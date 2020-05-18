# NTfix

NTfix is a small program to fix the problem of proton Games won't running on NTFS partitions. It creates a symbolic of your compatdata folder on the NTFS disk to a equivalent one on your EXT4 partition via a very simple GUI.


## Screenshot

<a href="https://ibb.co/d5zgtPb"><img src="https://i.ibb.co/W2Yt0kD/ntfix-02.png" alt="ntfix-02" border="0"></a>


## Demo

[![Video demo](https://yt-embed.herokuapp.com/embed?v=0EoLQy4eKhs)](https://www.youtube.com/watch?v=0EoLQy4eKhs "NTfix Demonstration")

## Installation 

### Distributions

#### Arch / Manjaro / Other Arch derivatives

Install the development package from the AUR [`ntfix-git`](https://aur.archlinux.org/packages/ntfix-git//). You can use an AUR Helper like `yay` or `pamac`:

```bash
yay -S ntfix-git
```
or

```bash
pamac install ntfix-git
```


## Tarball

1. Download the latest tarball from [Releases](https://github.com/benjamimgois/ntfix/releases).

2. Extract the file by running the following command:

```bash
tar -zxvf ntfix*.tar.gz
```

3. Execute the binary by running the following command:

```bash
./ntfix
```

## Source

### Prerequisites

Before building, you will need to install the following:

 - [Lazarus](https://github.com/graemeg/lazarus) - IDE

### Building

To build NTfix, clone the git repository by running following command:

```bash
git clone https://github.com/benjamimgois/ntfix.git



Then, change directory and build ntfix by running the following commands:

```bash
cd ntfix

lazbuild -B ntfix.lpi
```

### Running

To run ntfix, run the following command:

```bash
./ntfix
```


## Donations

If this project was useful to you, don't hesitate to donate to me :)

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=Q5EYYEJ5NSJAU&source=url)


