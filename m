Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DDD3198F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBLEJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:09:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhBLEI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:08:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BA3264E55;
        Fri, 12 Feb 2021 04:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613102895;
        bh=AXhzaOMPmuTSiNCKdR1nsq3uocVKemCt8anaxJiexF4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=R81vcaFHcJ17XXObUr4p9qLS5Gzw1kGjEkShEgvWj3syYjdN7/UbopjcMpUdQQFuH
         9sH207LlYyfxcyWtjj/O4VAHdcoLr/DTh3976zdk67RTm+j+cdJJG5yjGwsH2vtG5V
         TWMLITIWfc0rxsr6SGcEd2TpvDgI5DJvyFNNQ/zAE6P/Chk2c9Pdbi8Dl3aChy5h3j
         kcKSS8QjojR0nIYH0qYyePhSbBgWUwmxK/LMLNUnP/RRfgwDSNpx8FWIRjR01AFvg1
         uW9HbWR4KtxfyAgFn7XFIIzeMB0FvdpxyD+69B9gz/xiu5YaFCm1koKgUs3qLLsuWQ
         5gCk9r23ELXWw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201215004420.11342-2-liambeguin@gmail.com>
References: <20201215004420.11342-1-liambeguin@gmail.com> <20201215004420.11342-2-liambeguin@gmail.com>
Subject: Re: [RFC PATCH v1 1/1] clk: add initial support for the lmk04832
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     liambeguin@gmail.com, mturquette@baylibre.com
Date:   Thu, 11 Feb 2021 20:08:14 -0800
Message-ID: <161310289415.1254594.2269744513223344551@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Liam Beguin (2020-12-14 16:44:20)
> From: Liam Beguin <lvb@xiphos.com>
>=20
> The LMK04832 is an ultra-high performance clock conditioner with JEDEC
> JESD204B support and is also pin compatible with the LMK0482x family of
> devices.
>=20
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  .../devicetree/bindings/clock/ti,lmk04832.txt |   90 ++
>  drivers/clk/Kconfig                           |    7 +
>  drivers/clk/Makefile                          |    1 +
>  drivers/clk/clk-lmk04832.c                    | 1357 +++++++++++++++++
>  4 files changed, 1455 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,lmk04832.t=
xt
>  create mode 100644 drivers/clk/clk-lmk04832.c
>=20
> diff --git a/Documentation/devicetree/bindings/clock/ti,lmk04832.txt b/Do=
cumentation/devicetree/bindings/clock/ti,lmk04832.txt
> new file mode 100644
> index 000000000000..debe51765bf3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti,lmk04832.txt
> @@ -0,0 +1,90 @@
> +* Texas Instruments LMK04832 JESD204B Compliant Clock Jitter Cleaner

Please send a yaml document. It will get reviewed that way. Also Cc
devicetree@vger.kernel.org and robh+dt@kernel.org

> +
> +Required properties:
> +       - compatible: Must be "ti,lmk04832"
> +       - reg: SPI chip select for the device
> +       - spi-max-frequency: should be lower that 5MHz
> +       - #clock-cells: should be 1
> +       - clock-names: list of input clock names: "oscin"
> diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
> new file mode 100644
> index 000000000000..0938f49d8ab8
> --- /dev/null
> +++ b/drivers/clk/clk-lmk04832.c
> @@ -0,0 +1,1357 @@
> +/*
> + * LMK04832 Ultra Low-Noise JESD204B Compliant Clock Jitter Cleaner
> + * Pin compatible with the LMK0482x family
> + *

Is there a link to the datasheet pdf that can be put here?

> + * Copyright (c) 2020, Xiphos Systems Corp.
> + *
> + */
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/gcd.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +/* 0x000 - 0x00d System Functions */
> +#define LMK04832_REG_RST3W             0x000
> +#define LMK04832_BIT_RESET                     BIT(7)
> +#define LMK04832_BIT_SPI_3WIRE_DIS             BIT(4)
> +#define LMK04832_REG_POWERDOWN         0x002
> +#define LMK04832_REG_ID_DEV_TYPE       0x003
> +#define LMK04832_REG_ID_PROD_MSB       0x004
> +#define LMK04832_REG_ID_PROD_LSB       0x005
> +#define LMK04832_REG_ID_MASKREV                0x006
> +#define LMK04832_REG_ID_VNDR_MSB       0x00c
> +#define LMK04832_REG_ID_VNDR_LSB       0x00d
> +
> +/* 0x100 - 0x137 Device Clock and SYSREF Clock Output Control */
> +#define LMK04832_REG_DCLK_DIV_LSB(ch)  (0x100 + (ch >> 1) * 8)
> +#define LMK04832_REG_CLKOUT_CTRL0(ch)  (0x102 + (ch >> 1) * 8)
> +#define LMK04832_BIT_CLKOUTX_Y_PD              BIT(7)
> +#define LMK04832_BIT_DCLK_DIV_MSB              GENMASK(1, 0)
> +#define LMK04832_REG_CLKOUT_SRC_MUX(ch)        (0x103 + (ch % 2) + (ch >=
> 1) * 8)
> +#define LMK04832_BIT_CLKOUT_SRC_MUX            BIT(5)
> +#define LMK04832_REG_CLKOUT_CTRL1(ch)  (0x103 + (ch >> 1) * 8)
> +#define LMK04832_BIT_DCLK_PD                   BIT(4)
> +#define LMK04832_REG_CLKOUT_CTRL2(ch)  (0x104 + (ch >> 1) * 8)
> +#define LMK04832_BIT_SCLK_PD                   BIT(4)
> +#define LMK04832_REG_CLKOUT_FMT(ch)    (0x107 + (ch >> 1) * 8)
> +#define LMK04832_BIT_CLKOUT_FMT(ch)            (ch % 2 ? 0xf0 : 0x0f)
> +#define LMK04832_VAL_CLKOUT_FMT_POWERDOWN              0x00
> +#define LMK04832_VAL_CLKOUT_FMT_LVDS                   0x01
> +#define LMK04832_VAL_CLKOUT_FMT_HSDS6                  0x02
> +#define LMK04832_VAL_CLKOUT_FMT_HSDS8                  0x03
> +#define LMK04832_VAL_CLKOUT_FMT_LVPECL1600             0x04
> +#define LMK04832_VAL_CLKOUT_FMT_LVPECL2000             0x05
> +#define LMK04832_VAL_CLKOUT_FMT_LCPECL                 0x06
> +#define LMK04832_VAL_CLKOUT_FMT_CML16                  0x07
> +#define LMK04832_VAL_CLKOUT_FMT_CML24                  0x08
> +#define LMK04832_VAL_CLKOUT_FMT_CML32                  0x09
> +#define LMK04832_VAL_CLKOUT_FMT_CMOS_OFF_INV           0x0a
> +#define LMK04832_VAL_CLKOUT_FMT_CMOS_NOR_OFF           0x0b
> +#define LMK04832_VAL_CLKOUT_FMT_CMOS_INV_INV           0x0c
> +#define LMK04832_VAL_CLKOUT_FMT_CMOS_INV_NOR           0x0d
> +#define LMK04832_VAL_CLKOUT_FMT_CMOS_NOR_INV           0x0e
> +#define LMK04832_VAL_CLKOUT_FMT_CMOS_NOR_NOR           0x0f
> +
> +/* 0x138 - 0x145 SYSREF, SYNC, and Device Config */
> +#define LMK04832_REG_VCO_OSCOUT                0x138
> +#define LMK04832_BIT_VCO_MUX                   GENMASK(6, 5)
> +#define LMK04832_VAL_VCO_MUX_VCO0                      0x00
> +#define LMK04832_VAL_VCO_MUX_VCO1                      0x01
> +#define LMK04832_VAL_VCO_MUX_EXT                       0x02
> +#define LMK04832_REG_SYSREF_OUT                0x139
> +#define LMK04832_BIT_SYSREF_MUX                        GENMASK(1, 0)
> +#define LMK04832_VAL_SYSREF_MUX_CONTINUOUS             0x03
> +#define LMK04832_REG_SYSREF_DIV_MSB    0x13a
> +#define LMK04832_BIT_SYSREF_DIV_MSB            GENMASK(4, 0)
> +#define LMK04832_REG_SYSREF_DIV_LSB    0x13b
> +#define LMK04832_REG_FB_CTRL           0x13f
> +#define LMK04832_BIT_PLL2_RCLK_MUX             BIT(7)
> +#define LMK04832_VAL_PLL2_RCLK_MUX_OSCIN               0x00
> +#define LMK04832_VAL_PLL2_RCLK_MUX_CLKIN               0x01
> +#define LMK04832_BIT_PLL2_NCLK_MUX             BIT(5)
> +#define LMK04832_VAL_PLL2_NCLK_MUX_PLL2_P              0x00
> +#define LMK04832_VAL_PLL2_NCLK_MUX_FB_MUX              0x01
> +#define LMK04832_BIT_FB_MUX_EN                 BIT(0)
> +#define LMK04832_REG_MAIN_PD           0x140
> +#define LMK04832_BIT_PLL1_PD                   BIT(7)
> +#define LMK04832_BIT_VCO_LDO_PD                        BIT(6)
> +#define LMK04832_BIT_VCO_PD                    BIT(5)
> +#define LMK04832_BIT_OSCIN_PD                  BIT(4)
> +#define LMK04832_BIT_SYSREF_GBL_PD             BIT(3)
> +#define LMK04832_BIT_SYSREF_PD                 BIT(2)
> +#define LMK04832_BIT_SYSREF_DDLY_PD            BIT(1)
> +#define LMK04832_BIT_SYSREF_PLSR_PD            BIT(0)
> +#define LMK04832_REG_SYNC              0x143
> +#define LMK04832_BIT_SYNC_EN                   BIT(4)
> +#define LMK04832_REG_SYNC_DIS          0x144
> +
> +/* 0x146 - 0x14a CLKin Control */
> +#define LMK04832_REG_CLKIN_SEL0                0x148
> +#define LMK04832_REG_CLKIN_SEL1                0x149
> +#define LMK04832_REG_CLKIN_RST         0x14a
> +#define LMK04832_BIT_SDIO_RDBK_TYPE            BIT(6)
> +#define LMK04832_BIT_CLKIN_SEL_MUX             GENMASK(5, 3)
> +#define LMK04832_VAL_CLKIN_SEL_MUX_SPI_RDBK            0x06
> +#define LMK04832_BIT_CLKIN_SEL_TYPE            GENMASK(2, 0)
> +#define LMK04832_VAL_CLKIN_SEL_TYPE_OUT                        0x03
> +
> +/* 0x14b - 0x152 Holdover */
> +
> +/* 0x153 - 0x15f PLL1 Configuration */
> +
> +/* 0x160 - 0x16e PLL2 Configuration */
> +#define LMK04832_REG_PLL2_R_MSB                0x160
> +#define LMK04832_BIT_PLL2_R_MSB                        GENMASK(3, 0)
> +#define LMK04832_REG_PLL2_R_LSB                0x161
> +#define LMK04832_REG_PLL2_MISC         0x162
> +#define LMK04832_BIT_PLL2_MISC_P               GENMASK(7, 5)
> +#define LMK04832_BIT_PLL2_MISC_REF_2X_EN       BIT(0)
> +#define LMK04832_REG_PLL2_N_CAL_0      0x163
> +#define LMK04832_BIT_PLL2_N_CAL_0              GENMASK(1, 0)
> +#define LMK04832_REG_PLL2_N_CAL_1      0x164
> +#define LMK04832_REG_PLL2_N_CAL_2      0x165
> +#define LMK04832_REG_PLL2_N_0          0x166
> +#define LMK04832_BIT_PLL2_N_0                  GENMASK(1, 0)
> +#define LMK04832_REG_PLL2_N_1          0x167
> +#define LMK04832_REG_PLL2_N_2          0x168
> +#define LMK04832_REG_PLL2_DLD_CNT_LSB  0x16b
> +#define LMK04832_REG_PLL2_LD           0x16e
> +#define LMK04832_BIT_PLL2_LD_MUX               GENMASK(7, 3)
> +#define LMK04832_VAL_PLL2_LD_MUX_PLL2_DLD              0x02
> +#define LMK04832_BIT_PLL2_LD_TYPE              GENMASK(2, 0)
> +#define LMK04832_VAL_PLL2_LD_TYPE_OUT_PP               0x03
> +
> +/* 0x16F - 0x555 Misc Registers */
> +#define LMK04832_REG_PLL2_PD           0x173
> +#define LMK04832_BIT_PLL2_PRE_PD               BIT(6)
> +#define LMK04832_BIT_PLL2_PD                   BIT(5)
> +#define LMK04832_REG_PLL1R_RST         0x177
> +#define LMK04832_REG_CLR_PLL_LOST      0x182
> +#define LMK04832_REG_RB_PLL_LD         0x183
> +#define LMK04832_REG_RB_CLK_DAC_VAL_MSB        0x184
> +#define LMK04832_REG_RB_DAC_VAL_LSB    0x185
> +#define LMK04832_REG_RB_HOLDOVER       0x188
> +#define LMK04832_REG_SPI_LOCK          0x555
> +
> +enum lmk04832_device_types {

Is the plan to add more in the future? Can't we add this when that
happens?

> +       LMK04832,
> +};
> +
> +/**
> + * lmk04832_device_info - Holds static device information that is specif=
ic to
> + * the chip revision
> + *
> + * pid:          Product Identifier
> + * maskrev:      IC version identifier
> + * num_channels: Number of available output channels (clkout count)
> + * vco0_range:   {min, max} of the VCO0 operating range (in MHz)
> + * vco1_range:   {min, max} of the VCO1 operating range (in MHz)
> + */
> +struct lmk04832_device_info {
> +       uint16_t pid;

u16

> +       uint8_t maskrev;

u8

> +       unsigned int num_channels;

size_t?

> +       unsigned int vco0_range[2];
> +       unsigned int vco1_range[2];
> +};
> +
> +struct lmk04832_device_info lmk04832_device_info[] =3D {
> +       [LMK04832] =3D {
> +               .pid =3D 0x63d1, /* WARNING PROD_ID is inverted in the da=
tasheet */
> +               .maskrev =3D 0x70,
> +               .num_channels =3D 14,
> +               .vco0_range =3D { 2440, 2580 },
> +               .vco1_range =3D { 2945, 3255 },
> +       },
> +};
> +
> +enum lmk04832_rdbk_type {
> +       RDBK_CLKIN_SEL0,
> +       RDBK_CLKIN_SEL1,
> +       RDBK_RESET,
> +};
> +
> +struct lmk_dclk {
> +       struct lmk04832 *lmk;
> +       struct clk_hw hw;
> +       uint8_t id;
> +};
> +
> +struct lmk_clkout {
> +       struct lmk04832 *lmk;
> +       struct clk_hw hw;
> +       uint32_t format;

u32

> +       bool sysref;
> +       uint8_t id;

u8

> +};
> +
> +/**
> + * struct lmk04832 - The LMK04832 device structure
> + *
> + * @dev:    reference to a struct device, linked to the spi_device
> + * @regmap: struct regmap instance use to access the chip
> + *
> + * @oscin:  PLL2 input clock
> + * @vco:    reference to the internal VCO clock
> + * @sclk:   reference to the internal sysref clock (SCLK)
> + *
> + * @reset_gpio: Device reset GPIO
> + *
> + * @dclk:   List of device clocks (DCLKX_Y), There's one device clock fo=
r each
> + *          pair of clkout clocks.
> + * @clkout: List of output clocks.
> + */
> +struct lmk04832 {
> +       struct device *dev;
> +       struct regmap *regmap;
> +
> +       struct clk *oscin;

Hopefully this isn't necessary and we can get the clk from DT using
clk_parent_data?

> +       struct clk_hw vco;
> +       struct clk_hw sclk;
> +
> +       struct gpio_desc *reset_gpio;
> +
> +       struct lmk_dclk *dclk;
> +       struct lmk_clkout *clkout;
> +       struct clk_hw_onecell_data *clk_data;
> +
> +#ifdef CONFIG_DEBUG_FS
> +       struct dentry *debugfs_dentry;
> +       uint16_t cached_reg_addr;

u16

> +#endif
> +};
> +
> +#ifdef CONFIG_DEBUG_FS
> +static ssize_t debugfs_read_reg(struct file *file, char __user *userbuf,
> +                               size_t count, loff_t *ppos)
> +{
> +       struct lmk04832 *lmk =3D file->private_data;
> +       unsigned int val =3D 0;
> +       char buf[20];
> +       ssize_t len;
> +       int ret;
> +
> +       ret =3D regmap_read(lmk->regmap, lmk->cached_reg_addr, &val);
> +       if (ret) {
> +               dev_err(lmk->dev, "%s: read reg 0x%04x failed (%d)\n", __=
func__,
> +                       lmk->cached_reg_addr, ret);
> +               return ret;
> +       }
> +
> +       len =3D snprintf(buf, sizeof(buf), "0x%02x\n", val);
> +
> +       return simple_read_from_buffer(userbuf, count, ppos, buf, len);
> +}
> +
> +static ssize_t debugfs_write_reg(struct file *file, const char __user *u=
serbuf,
> +                                size_t count, loff_t *ppos)
> +{
> +       struct lmk04832 *lmk =3D file->private_data;
> +       unsigned int reg, val;
> +       char buf[32];
> +       int ret;
> +
> +       count =3D min_t(size_t, count, (sizeof(buf) - 1));
> +       if (copy_from_user(buf, userbuf, count))
> +               return -EFAULT;
> +
> +       buf[count] =3D 0;
> +
> +       ret =3D sscanf(buf, "%i %i", &reg, &val);
> +
> +       switch (ret) {
> +       case 1:
> +               lmk->cached_reg_addr =3D reg;
> +               break;
> +       case 2:
> +               lmk->cached_reg_addr =3D reg;
> +               ret =3D regmap_write(lmk->regmap, reg, val);

This looks like some sort of wrapper on top of regmap? regmap already
has debugfs support, and if you want to change values of registers from
debugfs you can enable the compile time option to do so. Please use that
instead of reinventing it here.

> +               if (ret) {
> +                       dev_err(lmk->dev, "%s: write reg 0x%04x failed\n",
> +                               __func__, lmk->cached_reg_addr);
> +                       return ret;
> +               }
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return count;
> +}
> +
> +static const struct file_operations debugfs_reg_fops =3D {
> +       .open =3D simple_open,
> +       .read =3D debugfs_read_reg,
> +       .write =3D debugfs_write_reg,
> +};
> +
> +static int lmk04832_register_debugfs(struct lmk04832 *lmk)
> +{
> +       struct dentry *d;
> +       struct device_node *np =3D lmk->dev->of_node;
> +
> +       lmk->debugfs_dentry =3D debugfs_create_dir(np->name, NULL);
> +       if (IS_ERR(lmk->debugfs_dentry))
> +               return PTR_ERR(lmk->debugfs_dentry);
> +
> +       if (lmk->debugfs_dentry =3D=3D NULL) {
> +               dev_warn(lmk->dev, "Failed to create debugfs directory\n"=
);

We don't care about debugfs errors. Just remove any warnings/prints and
move on with life.

> +               return -EFAULT;
> +       }
> +
> +       d =3D debugfs_create_file("direct_reg_access", 0644,
> +                               lmk->debugfs_dentry,
> +                               lmk, &debugfs_reg_fops);
> +       if (!d) {
> +               debugfs_remove_recursive(lmk->debugfs_dentry);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +#endif
> +
> +static bool lmk04832_regmap_rd_regs(struct device *dev, unsigned int reg)
> +{
> +       switch (reg) {
> +       case LMK04832_REG_RST3W ... LMK04832_REG_ID_MASKREV:
> +               /* fallthrough */
> +       case LMK04832_REG_ID_VNDR_MSB:
> +               /* fallthrough */
> +       case LMK04832_REG_ID_VNDR_LSB:
> +               /* fallthrough */
> +       case LMK04832_REG_DCLK_DIV_LSB(0) ... LMK04832_REG_PLL2_DLD_CNT_L=
SB:
> +               /* fallthrough */
> +       case LMK04832_REG_PLL2_LD:
> +               /* fallthrough */
> +       case LMK04832_REG_PLL2_PD:
> +               /* fallthrough */
> +       case LMK04832_REG_PLL1R_RST:
> +               /* fallthrough */
> +       case LMK04832_REG_CLR_PLL_LOST ... LMK04832_REG_RB_DAC_VAL_LSB:
> +               /* fallthrough */
> +       case LMK04832_REG_RB_HOLDOVER:
> +               /* fallthrough */
> +       case LMK04832_REG_SPI_LOCK:
> +               return true;
> +       default:
> +               return false;
> +       };
> +};
> +
> +static bool lmk04832_regmap_wr_regs(struct device *dev, unsigned int reg)
> +{
> +       switch (reg) {
> +       case LMK04832_REG_RST3W:
> +               /* fallthrough */
> +       case LMK04832_REG_POWERDOWN:
> +               return true;
> +       case LMK04832_REG_ID_DEV_TYPE ... LMK04832_REG_ID_MASKREV:
> +               /* fallthrough */
> +       case LMK04832_REG_ID_VNDR_MSB:
> +               /* fallthrough */
> +       case LMK04832_REG_ID_VNDR_LSB:
> +               return false;
> +       case LMK04832_REG_DCLK_DIV_LSB(0) ... LMK04832_REG_PLL2_DLD_CNT_L=
SB:
> +               /* fallthrough */
> +       case LMK04832_REG_PLL2_LD:
> +               /* fallthrough */
> +       case LMK04832_REG_PLL2_PD:
> +               /* fallthrough */
> +       case LMK04832_REG_PLL1R_RST:
> +               /* fallthrough */
> +       case LMK04832_REG_CLR_PLL_LOST ... LMK04832_REG_RB_DAC_VAL_LSB:
> +               /* fallthrough */
> +       case LMK04832_REG_RB_HOLDOVER:
> +               /* fallthrough */

Use the fallthrough define for this. Does it work to only have it once?
That would be nice vs. having it duplicated so many times.

> +       case LMK04832_REG_SPI_LOCK:
> +               return true;
> +       default:
> +               return false;
> +       };
> +};
> +
> +static const struct regmap_config regmap_config =3D {
> +       .name =3D "lmk04832",
> +       .reg_bits =3D 16,
> +       .val_bits =3D 8,
> +       .use_single_read =3D 1,
> +       .use_single_write =3D 1,
> +       .read_flag_mask =3D 0x80,
> +       .write_flag_mask =3D 0x00,
> +       .readable_reg =3D lmk04832_regmap_rd_regs,
> +       .writeable_reg =3D lmk04832_regmap_wr_regs,
> +       .cache_type =3D REGCACHE_NONE,
> +       .max_register =3D LMK04832_REG_SPI_LOCK,
> +};
> +
> +static int lmk04832_vco_is_enabled(struct clk_hw *hw)
> +{
> +       struct lmk04832 *lmk =3D container_of(hw, struct lmk04832, vco);
> +       unsigned int tmp;
> +       int ret;
> +
> +       ret =3D regmap_read(lmk->regmap, LMK04832_REG_MAIN_PD, &tmp);
> +       if (ret)
> +               return ret;
> +
> +       return !(FIELD_GET(LMK04832_BIT_OSCIN_PD, tmp) |
> +                FIELD_GET(LMK04832_BIT_VCO_PD, tmp) |
> +                FIELD_GET(LMK04832_BIT_VCO_LDO_PD, tmp));
> +}
> +
> +static int lmk04832_vco_prepare(struct clk_hw *hw)
> +{
> +       struct lmk04832 *lmk =3D container_of(hw, struct lmk04832, vco);
> +       int ret;
> +
> +       ret =3D regmap_update_bits(lmk->regmap, LMK04832_REG_PLL2_PD,
> +                                LMK04832_BIT_PLL2_PRE_PD |
> +                                LMK04832_BIT_PLL2_PD,
> +                                0x00);
> +       if (ret)
> +               return ret;
> +
> +       return regmap_update_bits(lmk->regmap, LMK04832_REG_MAIN_PD,
> +                                 LMK04832_BIT_VCO_LDO_PD |
> +                                 LMK04832_BIT_VCO_PD |
> +                                 LMK04832_BIT_OSCIN_PD, 0x00);
> +}
> +
> +static void lmk04832_vco_unprepare(struct clk_hw *hw)
> +{
> +       struct lmk04832 *lmk =3D container_of(hw, struct lmk04832, vco);
> +
> +       regmap_update_bits(lmk->regmap, LMK04832_REG_PLL2_PD,
> +                          LMK04832_BIT_PLL2_PRE_PD | LMK04832_BIT_PLL2_P=
D,
> +                          0xff);
> +
> +       /* Don't set LMK04832_BIT_OSCIN_PD since other clocks depend on i=
t */
> +       regmap_update_bits(lmk->regmap, LMK04832_REG_MAIN_PD,
> +                          LMK04832_BIT_VCO_LDO_PD | LMK04832_BIT_VCO_PD,=
 0xff);
> +}
> +
> +static unsigned long lmk04832_vco_recalc_rate(struct clk_hw *hw,
> +                                             unsigned long prate)
> +{
> +       struct lmk04832 *lmk =3D container_of(hw, struct lmk04832, vco);
> +       unsigned int pll2_p[] =3D {8, 2, 2, 3, 4, 5, 6, 7};
> +       unsigned int pll2_n, p, pll2_r;
> +       unsigned int pll2_misc;
> +       unsigned long vco_rate;
> +       uint8_t tmp[3];
> +       int ret;
> +
> +       ret =3D regmap_read(lmk->regmap, LMK04832_REG_PLL2_MISC, &pll2_mi=
sc);
> +       if (ret)
> +               return ret;
> +
> +       p =3D FIELD_GET(LMK04832_BIT_PLL2_MISC_P, pll2_misc);
> +
> +       ret =3D regmap_bulk_read(lmk->regmap, LMK04832_REG_PLL2_N_0, &tmp=
, 3);
> +       if (ret)
> +               return ret;
> +
> +       pll2_n =3D (FIELD_GET(LMK04832_BIT_PLL2_N_0, tmp[0]) << 16) |
> +                tmp[1] << 8 | tmp[2];

I feel like this pattern is somewhere in kernel.h or bits.h but I can't
find it. I suppose FIELD_PREP() could be used to shift it to the right
place. Can you use that?

> +
> +       ret =3D regmap_bulk_read(lmk->regmap, LMK04832_REG_PLL2_R_MSB, &t=
mp, 2);
> +       if (ret)
> +               return ret;
> +
> +       pll2_r =3D (FIELD_GET(LMK04832_BIT_PLL2_R_MSB, tmp[0]) << 8) | tm=
p[1];
> +
> +
> +       vco_rate =3D (prate << FIELD_GET(LMK04832_BIT_PLL2_MISC_REF_2X_EN,
> +                                      pll2_misc)) * pll2_n * pll2_p[p] /=
 pll2_r;
> +
> +       return vco_rate;
> +};
> +
> +/**
> + * lmk04832_check_vco_ranges - Check requested VCO frequency against VCO=
 ranges
> + *
> + * @lmk:   Reference to the lmk device
> + * @rate:  Desired output rate for the VCO
> + *
> + * The LMK04832 has 2 internal VCO, each with independant operating rang=
es. Use
> + * the device_info structure to determine which VCO to use based on rate.
> + *
> + * Returns VCO_MUX value or negative errno.
> + */
> +static int lmk04832_check_vco_ranges(struct lmk04832 *lmk, unsigned long=
 rate)
> +{
> +       struct spi_device *spi =3D to_spi_device(lmk->dev);
> +       struct lmk04832_device_info info;

Why not a pointer instead of struct copy?

> +       unsigned long mhz =3D rate / 1000000;
> +
> +       info =3D lmk04832_device_info[spi_get_device_id(spi)->driver_data=
];
> +
> +       if (mhz >=3D info.vco0_range[0] && mhz <=3D info.vco0_range[1]) {
> +               return LMK04832_VAL_VCO_MUX_VCO0;
> +       } else if (mhz >=3D info.vco1_range[0] && mhz <=3D info.vco1_rang=
e[1]) {
> +               return LMK04832_VAL_VCO_MUX_VCO1;
> +       } else {
> +               dev_err(lmk->dev, "%lu Hz is out of VCO ranges", rate);

Missing newline.

> +               return -ERANGE;
> +       }
> +}
> +
> +/**
> + * lmk04832_calc_pll2_params - Get PLL2 parameters used to set the VCO f=
requency
> + *
> + * @prate: parent rate to the PLL2, usually OSCin
> + * @rate:  Desired output rate for the VCO
> + * @n:     reference to PLL2_N
> + * @r:     reference to PLL2_R
> + *
> + * This functions assumes LMK04832_BIT_PLL2_MISC_REF_2X_EN is set since =
it is
> + * recommended in the datasheet because a higher phase detector frequenc=
ies
> + * makes the design of wider loop bandwidth filters possible.
> + *
> + * the VCO rate can be calculated using the following expression:
> + *
> + *     VCO =3D OSCin * 2 * PLL2_N * PLL2_P / PLL2_R
> + *
> + * Returns vco rate or negative errno.
> + */
> +static long lmk04832_calc_pll2_params(unsigned long prate, unsigned long=
 rate,
> +                                     unsigned int *n, unsigned int *p,
> +                                     unsigned int *r)
> +{
> +       unsigned long num, div;
> +
> +       /* Set PLL2_P to a fixed value to simplify optimizations */
> +       *p =3D 2;
> +
> +       div =3D gcd(rate, prate);
> +
> +       /* num =3D 2 * PLL_N * PLL_P */
> +       num =3D DIV_ROUND_CLOSEST(rate, div);
> +       *r =3D DIV_ROUND_CLOSEST(prate, div);
> +
> +       if (num > 4) {
> +               *n =3D num >> 2;
> +       } else {
> +               *r =3D *r << 2;
> +               *n =3D num;
> +       }
> +
> +       if (*n < 1 || *n > 0x03ffff)
> +               return -EINVAL;
> +       if (*r < 1 || *r > 0xfff)
> +               return -EINVAL;
> +
> +       return DIV_ROUND_CLOSEST(prate * 2 * *p * *n, *r);

Please grow some local variables here so that we don't have to think
about pointers being derefed and multiplied in the wrong order. It looks
cool but is too complicated.

> +}
> +
> +static long lmk04832_vco_round_rate(struct clk_hw *hw, unsigned long rat=
e,
> +                                   unsigned long *prate)
> +{
> +       struct lmk04832 *lmk =3D container_of(hw, struct lmk04832, vco);
> +       unsigned long vco_rate;
> +       unsigned int n, p, r;
> +       int ret;
> +
> +       ret =3D lmk04832_check_vco_ranges(lmk, rate);
> +       if (rate < 0)
> +               return ret;
> +
> +       vco_rate =3D lmk04832_calc_pll2_params(*prate, rate, &n, &p, &r);
> +       if (vco_rate < 0) {
> +               dev_err(lmk->dev, "PLL2 parmeters out of range (N=3D%d, P=
=3D%d, R=3D%d)\n",
> +                       n, p, r);
> +               return vco_rate;
> +       }
> +
> +       dev_dbg(lmk->dev, "%s: prate %ld Hz, got %ld Hz (delta=3D%lu Hz)\=
n",
> +               clk_hw_get_name(hw), *prate, vco_rate, abs(rate - vco_rat=
e));
> +
> +       return vco_rate;
> +};
> +
> +static int lmk04832_vco_set_rate(struct clk_hw *hw, unsigned long rate,
> +                                unsigned long prate)
> +{
> +       struct lmk04832 *lmk =3D container_of(hw, struct lmk04832, vco);
> +       unsigned long vco_rate;
> +       unsigned int n, p, r;
> +       int vco_mux;
> +       int ret;
> +
> +       vco_mux =3D lmk04832_check_vco_ranges(lmk, rate);
> +       if (vco_mux < 0)
> +               return vco_mux;
> +
> +       ret =3D regmap_update_bits(lmk->regmap, LMK04832_REG_VCO_OSCOUT,
> +                                LMK04832_BIT_VCO_MUX,
> +                                FIELD_PREP(LMK04832_BIT_VCO_MUX, vco_mux=
));
> +       if (ret)
> +               return ret;
> +
> +       vco_rate =3D lmk04832_calc_pll2_params(prate, rate, &n, &p, &r);
> +       if (vco_rate < 0) {

vco_rate is unsigned, can't be less than zero.

> +               dev_err(lmk->dev, "failed to determine PLL2 parmeters\n");
> +               return vco_rate;
> +       }
> +
> +       ret =3D regmap_update_bits(lmk->regmap, LMK04832_REG_PLL2_R_MSB,
> +                                LMK04832_BIT_PLL2_R_MSB,
> +                                FIELD_GET(0x000700, r));
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_write(lmk->regmap, LMK04832_REG_PLL2_R_LSB,
> +                          FIELD_GET(0x0000ff, r));
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(lmk->regmap, LMK04832_REG_PLL2_MISC,
> +                                LMK04832_BIT_PLL2_MISC_P,
> +                                FIELD_PREP(LMK04832_BIT_PLL2_MISC_P, p));
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * PLL2_N registers must be programmed after other PLL2 dividers =
are
> +        * programed to ensure proper VCO frequency calibration
> +        */
> +       ret =3D regmap_write(lmk->regmap, LMK04832_REG_PLL2_N_0,
> +                          FIELD_GET(0x030000, n));
> +       if (ret)
> +               return ret;
> +       ret =3D regmap_write(lmk->regmap, LMK04832_REG_PLL2_N_1,
> +                          FIELD_GET(0x00ff00, n));
> +       if (ret)
> +               return ret;
> +       ret =3D regmap_write(lmk->regmap, LMK04832_REG_PLL2_N_2,
> +                          FIELD_GET(0x0000ff, n));
> +       if (ret)
> +               return ret;
> +
> +       return 0;

Just return regmap_write(...)

> +};
> +
> +const struct clk_ops lmk04832_vco_ops =3D {

static?

> +       .is_enabled =3D lmk04832_vco_is_enabled,
> +       .prepare =3D lmk04832_vco_prepare,
> +       .unprepare =3D lmk04832_vco_unprepare,
> +       .recalc_rate =3D lmk04832_vco_recalc_rate,
> +       .round_rate =3D lmk04832_vco_round_rate,
> +       .set_rate =3D lmk04832_vco_set_rate,
> +};
> +
> +static int lmk04832_register_vco(struct lmk04832 *lmk)
> +{
> +       const char *parent_names[1];
> +       struct clk_init_data init;
> +       int ret;
> +
> +       init.name =3D "lmk-vco";
> +       parent_names[0] =3D __clk_get_name(lmk->oscin);
> +       init.parent_names =3D parent_names;
> +
> +       init.ops =3D &lmk04832_vco_ops;
> +       init.flags =3D CLK_SET_RATE_GATE;
> +       init.num_parents =3D 1;
> +
> +       ret =3D regmap_update_bits(lmk->regmap, LMK04832_REG_VCO_OSCOUT,
> +                                LMK04832_BIT_VCO_MUX,
> +                                FIELD_PREP(LMK04832_BIT_VCO_MUX,
> +                                           LMK04832_VAL_VCO_MUX_VCO1));
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(lmk->regmap, LMK04832_REG_FB_CTRL,
> +                                LMK04832_BIT_PLL2_RCLK_MUX |
> +                                LMK04832_BIT_PLL2_NCLK_MUX,
> +                                FIELD_PREP(LMK04832_BIT_PLL2_RCLK_MUX,
> +                                           LMK04832_VAL_PLL2_RCLK_MUX_OS=
CIN)|
> +                                FIELD_PREP(LMK04832_BIT_PLL2_NCLK_MUX,
> +                                           LMK04832_VAL_PLL2_NCLK_MUX_PL=
L2_P));
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(lmk->regmap, LMK04832_REG_PLL2_MISC,
> +                                LMK04832_BIT_PLL2_MISC_REF_2X_EN,
> +                                LMK04832_BIT_PLL2_MISC_REF_2X_EN);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_write(lmk->regmap, LMK04832_REG_PLL2_LD,
> +                          FIELD_PREP(LMK04832_BIT_PLL2_LD_MUX,
> +                                     LMK04832_VAL_PLL2_LD_MUX_PLL2_DLD) |
> +                          FIELD_PREP(LMK04832_BIT_PLL2_LD_TYPE,
> +                                     LMK04832_VAL_PLL2_LD_TYPE_OUT_PP));
> +       if (ret)
> +               return ret;
> +
> +       lmk->vco.init =3D &init;
> +       return devm_clk_hw_register(lmk->dev, &lmk->vco);
> +}
> +
> +static int lmk04832_sclk_is_enabled(struct clk_hw *hw)
> +{
> +       struct lmk04832 *lmk =3D container_of(hw, struct lmk04832, sclk);
> +       unsigned int tmp;
> +       int ret;
> +
> +       ret =3D regmap_read(lmk->regmap, LMK04832_REG_MAIN_PD, &tmp);
> +       if (ret)
> +               return ret;
> +
> +       return FIELD_GET(LMK04832_BIT_SYSREF_PD, tmp);
> +}
> +
> +static int lmk04832_sclk_prepare(struct clk_hw *hw)
> +{
> +       struct lmk04832 *lmk =3D container_of(hw, struct lmk04832, sclk);
> +
> +       return regmap_update_bits(lmk->regmap, LMK04832_REG_MAIN_PD,
> +                                 LMK04832_BIT_SYSREF_PD, 0x00);
> +}
> +
> +static void lmk04832_sclk_unprepare(struct clk_hw *hw)
> +{
> +       struct lmk04832 *lmk =3D container_of(hw, struct lmk04832, sclk);
> +
> +       regmap_update_bits(lmk->regmap, LMK04832_REG_MAIN_PD,
> +                          LMK04832_BIT_SYSREF_PD, LMK04832_BIT_SYSREF_PD=
);
> +}
> +
> +static unsigned long lmk04832_sclk_recalc_rate(struct clk_hw *hw,
> +                                              unsigned long prate)
> +{
> +       struct lmk04832 *lmk =3D container_of(hw, struct lmk04832, sclk);
> +       unsigned int sysref_div;
> +       uint8_t tmp[2];
> +       int ret;
> +
> +       ret =3D regmap_bulk_read(lmk->regmap, LMK04832_REG_SYSREF_DIV_MSB=
, &tmp, 2);
> +       if (ret)
> +               return ret;
> +
> +       sysref_div =3D FIELD_GET(LMK04832_BIT_SYSREF_DIV_MSB, tmp[0]) << =
8 |
> +               tmp[1];
> +
> +       return DIV_ROUND_CLOSEST(prate, sysref_div);
> +}
> +
> +static long lmk04832_sclk_round_rate(struct clk_hw *hw, unsigned long ra=
te,
> +                                    unsigned long *prate)
> +{
> +       struct lmk04832 *lmk =3D container_of(hw, struct lmk04832, sclk);
> +       unsigned long sclk_rate;
> +       unsigned int sysref_div;
> +
> +       sysref_div =3D DIV_ROUND_CLOSEST(*prate, rate);
> +       sclk_rate =3D DIV_ROUND_CLOSEST(*prate, sysref_div);
> +
> +       if (sysref_div < 0x07 || sysref_div > 0x1fff) {
> +               dev_err(lmk->dev, "SYSREF divider out of range\n");
> +               return -EINVAL;
> +       }
> +
> +       dev_dbg(lmk->dev, "%s: prate %ld Hz, got %ld Hz (delta=3D%lu Hz)\=
n",
> +               clk_hw_get_name(hw), *prate, sclk_rate, abs(rate - sclk_r=
ate));
> +
> +       return sclk_rate;
> +}
> +
> +static int lmk04832_sclk_set_rate(struct clk_hw *hw, unsigned long rate,
> +                                 unsigned long prate)
> +{
> +       struct lmk04832 *lmk =3D container_of(hw, struct lmk04832, sclk);
> +       unsigned int sysref_div;
> +       int ret;
> +
> +       sysref_div =3D DIV_ROUND_CLOSEST(prate, rate);
> +
> +       if (sysref_div < 0x07 || sysref_div > 0x1fff) {
> +               dev_err(lmk->dev, "SYSREF divider out of range\n");
> +               return -EINVAL;
> +       }
> +
> +       ret =3D regmap_write(lmk->regmap, LMK04832_REG_SYSREF_DIV_MSB,
> +                          FIELD_GET(0x1f00, sysref_div));
> +       if (ret)
> +               return ret;
> +
> +       return regmap_write(lmk->regmap, LMK04832_REG_SYSREF_DIV_LSB,
> +                           FIELD_GET(0x00ff, sysref_div));
> +}
> +
> +const struct clk_ops lmk04832_sclk_ops =3D {

static?

> +       .is_enabled =3D lmk04832_sclk_is_enabled,
> +       .prepare =3D lmk04832_sclk_prepare,
> +       .unprepare =3D lmk04832_sclk_unprepare,
> +       .recalc_rate =3D lmk04832_sclk_recalc_rate,
> +       .round_rate =3D lmk04832_sclk_round_rate,
> +       .set_rate =3D lmk04832_sclk_set_rate,
> +};
> +
> +static int lmk04832_register_sclk(struct lmk04832 *lmk)
> +{
> +       const char *parent_names[1];
> +       struct clk_init_data init;
> +       int ret =3D 0;
> +
> +       init.name =3D "lmk-sclk";
> +       parent_names[0] =3D clk_hw_get_name(&lmk->vco);
> +       init.parent_names =3D parent_names;
> +
> +       init.ops =3D &lmk04832_sclk_ops;
> +       init.flags =3D CLK_SET_RATE_PARENT;
> +       init.num_parents =3D 1;
> +
> +       ret =3D regmap_update_bits(lmk->regmap, LMK04832_REG_SYSREF_OUT,
> +                                LMK04832_BIT_SYSREF_MUX,
> +                                FIELD_PREP(LMK04832_BIT_SYSREF_MUX,
> +                                           LMK04832_VAL_SYSREF_MUX_CONTI=
NUOUS));
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(lmk->regmap, LMK04832_REG_MAIN_PD,
> +                                LMK04832_BIT_SYSREF_PLSR_PD,
> +                                LMK04832_BIT_SYSREF_PLSR_PD);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_update_bits(lmk->regmap, LMK04832_REG_SYNC,
> +                                LMK04832_BIT_SYNC_EN, 0xff);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_write(lmk->regmap, LMK04832_REG_SYNC_DIS, 0xff);
> +       if (ret)
> +               return ret;
> +
> +       lmk->sclk.init =3D &init;
> +       return devm_clk_hw_register(lmk->dev, &lmk->sclk);
> +}
> +
> +static int lmk04832_dclk_is_enabled(struct clk_hw *hw)
> +{
> +       struct lmk_dclk *dclk =3D container_of(hw, struct lmk_dclk, hw);
> +       struct lmk04832 *lmk =3D dclk->lmk;
> +       unsigned int tmp;
> +       int ret;
> +
> +       ret =3D regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_CTRL1(dclk->=
id),
> +                         &tmp);
> +       if (ret)
> +               return ret;
> +
> +       return !FIELD_GET(LMK04832_BIT_DCLK_PD, tmp);
> +}
> +
> +static int lmk04832_dclk_prepare(struct clk_hw *hw)
> +{
> +       struct lmk_dclk *dclk =3D container_of(hw, struct lmk_dclk, hw);
> +       struct lmk04832 *lmk =3D dclk->lmk;
> +
> +       return regmap_update_bits(lmk->regmap,
> +                                 LMK04832_REG_CLKOUT_CTRL1(dclk->id),
> +                                 LMK04832_BIT_DCLK_PD, 0x00);
> +}
> +
> +static void lmk04832_dclk_unprepare(struct clk_hw *hw)
> +{
> +       struct lmk_dclk *dclk =3D container_of(hw, struct lmk_dclk, hw);
> +       struct lmk04832 *lmk =3D dclk->lmk;
> +
> +       regmap_update_bits(lmk->regmap,
> +                          LMK04832_REG_CLKOUT_CTRL1(dclk->id),
> +                          LMK04832_BIT_DCLK_PD, 0xff);
> +}
> +
> +static unsigned long lmk04832_dclk_recalc_rate(struct clk_hw *hw,
> +                                              unsigned long prate)
> +{
> +       struct lmk_dclk *dclk =3D container_of(hw, struct lmk_dclk, hw);
> +       struct lmk04832 *lmk =3D dclk->lmk;
> +       unsigned int dclk_div;
> +       unsigned int lsb, msb;
> +       unsigned long rate;
> +       int ret;
> +
> +       ret =3D regmap_read(lmk->regmap, LMK04832_REG_DCLK_DIV_LSB(dclk->=
id),
> +                         &lsb);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_CTRL0(dclk->=
id),
> +                         &msb);
> +       if (ret)
> +               return ret;
> +
> +       dclk_div =3D FIELD_GET(LMK04832_BIT_DCLK_DIV_MSB, msb) << 8 | lsb;
> +       rate =3D DIV_ROUND_CLOSEST(prate, dclk_div);
> +
> +       return rate;
> +};
> +
> +static long lmk04832_dclk_round_rate(struct clk_hw *hw, unsigned long ra=
te,
> +                                    unsigned long *prate)
> +{
> +       struct lmk_dclk *dclk =3D container_of(hw, struct lmk_dclk, hw);
> +       struct lmk04832 *lmk =3D dclk->lmk;
> +       unsigned long dclk_rate;
> +       unsigned int dclk_div;
> +
> +       dclk_div =3D DIV_ROUND_CLOSEST(*prate, rate);
> +       dclk_rate =3D DIV_ROUND_CLOSEST(*prate, dclk_div);
> +
> +       if (dclk_div < 1 || dclk_div > 0x3ff) {
> +               dev_err(lmk->dev, "%s_div out of range", clk_hw_get_name(=
hw));
> +               return -EINVAL;
> +       }
> +
> +       dev_dbg(lmk->dev, "%s: prate %ld Hz, got %ld Hz (delta=3D%lu Hz)\=
n",
> +               clk_hw_get_name(hw), *prate, dclk_rate, abs(rate - dclk_r=
ate));
> +
> +       return dclk_rate;
> +};
> +
> +static int lmk04832_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
> +                                 unsigned long prate)
> +{
> +       struct lmk_dclk *dclk =3D container_of(hw, struct lmk_dclk, hw);
> +       struct lmk04832 *lmk =3D dclk->lmk;
> +       unsigned int dclk_div;
> +       int ret;
> +
> +       dclk_div =3D DIV_ROUND_CLOSEST(prate, rate);
> +
> +       if (dclk_div < 1 || dclk_div > 0x3ff) {

How is dclk_div ever zero?

> +               dev_err(lmk->dev, "%s_div out of range", clk_hw_get_name(=
hw));

Missing newline on the printk. Same comment applies for the duplicate
printk above.

> +               return -EINVAL;
> +       }
> +
> +       ret =3D regmap_write(lmk->regmap, LMK04832_REG_DCLK_DIV_LSB(dclk-=
>id),
> +                          FIELD_GET(0x0ff, dclk_div));
> +       if (ret)
> +               return ret;
> +
> +       return regmap_update_bits(lmk->regmap,
> +                                 LMK04832_REG_CLKOUT_CTRL0(dclk->id),
> +                                 LMK04832_BIT_DCLK_DIV_MSB,
> +                                 FIELD_GET(0x300, dclk_div));
> +};
> +
> +const struct clk_ops lmk04832_dclk_ops =3D {
> +       .is_enabled =3D lmk04832_dclk_is_enabled,
> +       .prepare =3D lmk04832_dclk_prepare,
> +       .unprepare =3D lmk04832_dclk_unprepare,
> +       .recalc_rate =3D lmk04832_dclk_recalc_rate,
> +       .round_rate =3D lmk04832_dclk_round_rate,
> +       .set_rate =3D lmk04832_dclk_set_rate,
> +};
> +
> +static int lmk04832_clkout_is_enabled(struct clk_hw *hw)
> +{
> +       struct lmk_clkout *clkout =3D container_of(hw, struct lmk_clkout,=
 hw);
> +       struct lmk04832 *lmk =3D clkout->lmk;
> +       unsigned int clkoutx_y_pd;
> +       unsigned int sclkx_y_pd;
> +       unsigned int tmp;
> +       uint8_t fmt;

Please use u8/u16/u32.

> +       int enabled;

u32 enabled? Doesn't need to be signed right?

> +       int ret;
> +
> +       ret =3D regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_CTRL0(clkout=
->id),
> +                         &clkoutx_y_pd);
> +       if (ret)
> +               return ret;
> +
> +       enabled =3D !FIELD_GET(LMK04832_BIT_CLKOUTX_Y_PD, clkoutx_y_pd);
> +
> +       ret =3D regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_SRC_MUX(clko=
ut->id),
> +                         &tmp);
> +       if (ret)
> +               return ret;
> +
> +       if (FIELD_GET(LMK04832_BIT_CLKOUT_SRC_MUX, tmp)) {
> +               ret =3D regmap_read(lmk->regmap,
> +                                 LMK04832_REG_CLKOUT_CTRL2(clkout->id),
> +                                 &sclkx_y_pd);
> +               if (ret)
> +                       return ret;
> +
> +               enabled =3D enabled && !FIELD_GET(LMK04832_BIT_SCLK_PD, s=
clkx_y_pd);
> +       }
> +
> +       ret =3D regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_FMT(clkout->=
id),
> +                         &tmp);
> +       if (ret)
> +               return ret;
> +
> +       fmt =3D (tmp & (0xf << 4 * (clkout->id % 2))) >> 4 * (clkout->id =
% 2);

This is quite a long line. Can we break it up into multiple lines with
some more local variables?

> +       return enabled && !fmt;
> +}
> +
> +static int lmk04832_clkout_prepare(struct clk_hw *hw)
> +{
> +       struct lmk_clkout *clkout =3D container_of(hw, struct lmk_clkout,=
 hw);
> +       struct lmk04832 *lmk =3D clkout->lmk;
> +       unsigned int tmp;
> +       int ret;
> +
> +       if (clkout->format =3D=3D LMK04832_VAL_CLKOUT_FMT_POWERDOWN)
> +               dev_err(lmk->dev, "prepared %s but format is powerdown\n",
> +                       clk_hw_get_name(hw));
> +
> +       ret =3D regmap_update_bits(lmk->regmap,
> +                                LMK04832_REG_CLKOUT_CTRL0(clkout->id),
> +                                LMK04832_BIT_CLKOUTX_Y_PD, 0x00);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_SRC_MUX(clko=
ut->id),
> +                         &tmp);
> +       if (ret)
> +               return ret;
> +
> +       if (FIELD_GET(LMK04832_BIT_CLKOUT_SRC_MUX, tmp)) {
> +               ret =3D regmap_update_bits(lmk->regmap,
> +                                        LMK04832_REG_CLKOUT_CTRL2(clkout=
->id),
> +                                        LMK04832_BIT_SCLK_PD, 0x00);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return regmap_update_bits(lmk->regmap,
> +                                 LMK04832_REG_CLKOUT_FMT(clkout->id),
> +                                 LMK04832_BIT_CLKOUT_FMT(clkout->id),
> +                                 clkout->format << 4 * (clkout->id % 2));
> +}
> +
> +static void lmk04832_clkout_unprepare(struct clk_hw *hw)
> +{
> +       struct lmk_clkout *clkout =3D container_of(hw, struct lmk_clkout,=
 hw);
> +       struct lmk04832 *lmk =3D clkout->lmk;
> +
> +       regmap_update_bits(lmk->regmap, LMK04832_REG_CLKOUT_FMT(clkout->i=
d),
> +                          LMK04832_BIT_CLKOUT_FMT(clkout->id),
> +                          0x00);
> +}
> +
> +static int lmk04832_clkout_set_parent(struct clk_hw *hw, uint8_t index)
> +{
> +       struct lmk_clkout *clkout =3D container_of(hw, struct lmk_clkout,=
 hw);
> +       struct lmk04832 *lmk =3D clkout->lmk;
> +
> +       return regmap_update_bits(lmk->regmap,
> +                                 LMK04832_REG_CLKOUT_SRC_MUX(clkout->id),
> +                                 LMK04832_BIT_CLKOUT_SRC_MUX,
> +                                 FIELD_PREP(LMK04832_BIT_CLKOUT_SRC_MUX,
> +                                            index));
> +}
> +
> +static uint8_t lmk04832_clkout_get_parent(struct clk_hw *hw)
> +{
> +       struct lmk_clkout *clkout =3D container_of(hw, struct lmk_clkout,=
 hw);
> +       struct lmk04832 *lmk =3D clkout->lmk;
> +       unsigned int tmp;
> +       int ret;
> +
> +       ret =3D regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_SRC_MUX(clko=
ut->id),
> +                         &tmp);
> +       if (ret)
> +               return ret;
> +
> +       return FIELD_GET(LMK04832_BIT_CLKOUT_SRC_MUX, tmp);
> +}
> +
> +const struct clk_ops lmk04832_clkout_ops =3D {

static?

> +       .is_enabled =3D lmk04832_clkout_is_enabled,
> +       .prepare =3D lmk04832_clkout_prepare,
> +       .unprepare =3D lmk04832_clkout_unprepare,
> +       .set_parent =3D lmk04832_clkout_set_parent,
> +       .get_parent =3D lmk04832_clkout_get_parent,
> +};
> +
> +static int lmk04832_register_clkout(struct lmk04832 *lmk, const int num)
> +{
> +       char name[] =3D "lmk-clkoutXX";
> +       char dclk_name[] =3D "lmk-dclkXX_YY";
> +       const char *parent_names[2];
> +       struct clk_init_data init;
> +       int dclk_num =3D num / 2;
> +       int ret;
> +
> +       if (num % 2 =3D=3D 0) {
> +               sprintf(dclk_name, "lmk-dclk%02d_%02d", num, num + 1);
> +               init.name =3D dclk_name;
> +               parent_names[0] =3D clk_hw_get_name(&lmk->vco);
> +               init.ops =3D &lmk04832_dclk_ops;
> +               init.flags =3D CLK_SET_RATE_PARENT;
> +               init.num_parents =3D 1;
> +
> +               lmk->dclk[dclk_num].id =3D num;
> +               lmk->dclk[dclk_num].lmk =3D lmk;
> +               lmk->dclk[dclk_num].hw.init =3D &init;
> +               ret =3D devm_clk_hw_register(lmk->dev, &lmk->dclk[dclk_nu=
m].hw);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               sprintf(dclk_name, "lmk-dclk%02d_%02d", num - 1, num);
> +       }
> +
> +       if (of_property_read_string_index(lmk->dev->of_node,
> +                                         "clock-output-names",
> +                                         num, &init.name)) {
> +               sprintf(name, "lmk-clkout%02d", num);
> +               init.name =3D name;
> +       }
> +
> +       parent_names[0] =3D dclk_name;
> +       parent_names[1] =3D clk_hw_get_name(&lmk->sclk);

Can you use clk_parent_data instead? That way it doesn't need to be
name based unless it's part of a DT binding.

> +       init.parent_names =3D parent_names;
> +       init.ops =3D &lmk04832_clkout_ops;
> +       init.flags =3D CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT;
> +       init.num_parents =3D ARRAY_SIZE(parent_names);
> +
> +       lmk->clkout[num].id =3D num;
> +       lmk->clkout[num].lmk =3D lmk;
> +       lmk->clkout[num].hw.init =3D &init;
> +       lmk->clk_data->hws[num] =3D &lmk->clkout[num].hw;
> +
> +       /* Set initial parent */
> +       regmap_update_bits(lmk->regmap,
> +                          LMK04832_REG_CLKOUT_SRC_MUX(num),
> +                          LMK04832_BIT_CLKOUT_SRC_MUX,
> +                          FIELD_PREP(LMK04832_BIT_CLKOUT_SRC_MUX,
> +                                     lmk->clkout[num].sysref));
> +
> +       return devm_clk_hw_register(lmk->dev, &lmk->clkout[num].hw);
> +}
> +
> +static int lmk04832_set_spi_rdbk(const struct lmk04832 *lmk, const int r=
dbk_pin)
> +{
> +       int reg;
> +       int ret;
> +
> +       dev_info(lmk->dev, "Setting up 4-wire mode");
> +       ret =3D regmap_write(lmk->regmap, LMK04832_REG_RST3W,
> +                          LMK04832_BIT_SPI_3WIRE_DIS);
> +       if (ret)
> +               return ret;
> +
> +       switch (rdbk_pin) {
> +       case RDBK_CLKIN_SEL0:
> +               reg =3D LMK04832_REG_CLKIN_SEL0;
> +               break;
> +       case RDBK_CLKIN_SEL1:
> +               reg =3D LMK04832_REG_CLKIN_SEL1;
> +               break;
> +       case RDBK_RESET:
> +               reg =3D LMK04832_REG_CLKIN_RST;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return regmap_write(lmk->regmap, reg,
> +                           FIELD_PREP(LMK04832_BIT_CLKIN_SEL_MUX,
> +                                      LMK04832_VAL_CLKIN_SEL_MUX_SPI_RDB=
K) |
> +                           FIELD_PREP(LMK04832_BIT_CLKIN_SEL_TYPE,
> +                                      LMK04832_VAL_CLKIN_SEL_TYPE_OUT));
> +}
> +
> +static int lmk04832_probe(struct spi_device *spi)
> +{
> +       struct lmk04832_device_info lmk_devinfo;
> +       int rdbk_pin =3D RDBK_CLKIN_SEL1;
> +       struct device_node *child;
> +       struct lmk04832 *lmk;
> +       uint8_t tmp[3];
> +       int ret =3D 0;
> +       int i;
> +
> +       lmk_devinfo =3D lmk04832_device_info[spi_get_device_id(spi)->driv=
er_data];
> +
> +       lmk =3D devm_kzalloc(&spi->dev, sizeof(struct lmk04832), GFP_KERN=
EL);
> +       if (!lmk)
> +               return -ENOMEM;
> +
> +       lmk->dev =3D &spi->dev;
> +
> +       lmk->oscin =3D devm_clk_get(lmk->dev, "oscin");
> +       if (IS_ERR(lmk->oscin)) {
> +               dev_err(lmk->dev, "failed to get oscin clock\n");
> +               return PTR_ERR(lmk->oscin);
> +       }
> +
> +       ret =3D clk_prepare_enable(lmk->oscin);
> +       if (ret)
> +               return ret;
> +
> +       lmk->reset_gpio =3D devm_gpiod_get_optional(&spi->dev, "reset", G=
PIOD_OUT_LOW);
> +       if (!IS_ERR(lmk->reset_gpio)) {
> +               ret =3D gpiod_direction_output(lmk->reset_gpio, 0);

What if it fails?

> +       }
> +
> +       lmk->dclk =3D devm_kcalloc(lmk->dev, lmk_devinfo.num_channels >> =
1,
> +                                sizeof(struct lmk_dclk), GFP_KERNEL);
> +       if (IS_ERR(lmk->dclk)) {
> +               ret =3D PTR_ERR(lmk->dclk);
> +               goto err_disable_oscin;
> +       }
> +
> +       lmk->clkout =3D devm_kcalloc(lmk->dev, lmk_devinfo.num_channels,
> +                                   sizeof(struct lmk_clkout), GFP_KERNEL=
);

sizeof(*lmk->clkout) please.

> +       if (IS_ERR(lmk->clkout)) {
> +               ret =3D PTR_ERR(lmk->clkout);
> +               goto err_disable_oscin;
> +       }
> +
> +       lmk->clk_data =3D devm_kzalloc(lmk->dev, sizeof(*lmk->clk_data) +
> +                                    sizeof(*lmk->clk_data->hws) *

Use struct_size()

> +                                    lmk_devinfo.num_channels,
> +                                    GFP_KERNEL);
> +       if (IS_ERR(lmk->clk_data)) {
> +               ret =3D PTR_ERR(lmk->clk_data);
> +               goto err_disable_oscin;
> +       }
> +
> +       for_each_child_of_node(lmk->dev->of_node, child) {
> +               int reg;
> +
> +               ret =3D of_property_read_u32(child, "reg", &reg);
> +               if (ret) {
> +                       dev_err(lmk->dev, "missing reg property in child:=
 %s\n",
> +                               child->full_name);
> +                       goto err_disable_oscin;
> +               }
> +
> +               of_property_read_u32(child, "lmk,clkout-fmt",
> +                                    &lmk->clkout[reg].format);
> +
> +               if (lmk->clkout[reg].format >=3D 0x0a && reg % 2 =3D=3D 0
> +                   && reg !=3D 8 && reg !=3D 10)
> +                       dev_err(lmk->dev, "invalid format for clkout%02d\=
n",
> +                               reg);
> +
> +               lmk->clkout[reg].sysref =3D
> +                       of_property_read_bool(child, "lmk,clkout-sysref");

Not sure what this is but it looks scary. Some sort of configuration
based on what is in DT but each node in DT is for some clk? Hopefully it
can be done some other way.

> +       };
> +
> +       lmk->regmap =3D devm_regmap_init_spi(spi, &regmap_config);
> +       if (IS_ERR(lmk->regmap)) {
> +               dev_err(lmk->dev, "%s: regmap allocation failed: %ld\n",
> +
> +                       __func__, PTR_ERR(lmk->regmap));
> +               ret =3D PTR_ERR(lmk->regmap);
> +               goto err_disable_oscin;
> +       }
> +
> +       regmap_write(lmk->regmap, LMK04832_REG_RST3W, LMK04832_BIT_RESET);
> +
> +       if (!(spi->mode & SPI_3WIRE)) {
> +               device_property_read_u32(lmk->dev, "lmk,spi-4wire-rdbk",
> +                                        &rdbk_pin);
> +               ret =3D lmk04832_set_spi_rdbk(lmk, rdbk_pin);
> +               if (ret)
> +                       goto err_disable_oscin;
> +       }
> +
> +       regmap_bulk_read(lmk->regmap, LMK04832_REG_ID_PROD_MSB, &tmp, 3);
> +       if ((tmp[0] << 8 | tmp[1]) !=3D lmk_devinfo.pid || tmp[2] !=3D lm=
k_devinfo.maskrev) {
> +               dev_err(lmk->dev, "unsupported device type: pid 0x%04x, m=
askrev 0x%02x\n",
> +                       tmp[0] << 8 | tmp[1], tmp[2]);
> +               ret =3D -EINVAL;
> +               goto err_disable_oscin;
> +       }
> +
> +       /* Setup device clock path in PLL2 single loop mode */
> +       ret =3D lmk04832_register_vco(lmk);
> +       if (ret) {
> +               dev_err(lmk->dev, "failed to init device clock path\n");
> +               goto err_disable_oscin;
> +       }
> +
> +       /* Setup SYNC/SYSREF in continuous mode */
> +       ret =3D lmk04832_register_sclk(lmk);
> +       if (ret) {
> +               dev_err(lmk->dev, "failed to init SYNC/SYSREF clock path\=
n");
> +               goto err_disable_oscin;
> +       }
> +
> +       for (i =3D 0; i < lmk_devinfo.num_channels; i++) {
> +               ret =3D lmk04832_register_clkout(lmk, i);
> +               if (ret) {
> +                       dev_err(lmk->dev, "failed to register clk %d\n", =
i);
> +                       goto err_disable_oscin;
> +               }
> +       }
> +
> +       lmk->clk_data->num =3D lmk_devinfo.num_channels;
> +       ret =3D of_clk_add_hw_provider(lmk->dev->of_node, of_clk_hw_onece=
ll_get,
> +                                    lmk->clk_data);
> +       if (ret) {
> +               dev_err(lmk->dev, "failed to add provider (%d)\n", ret);
> +               goto err_disable_oscin;
> +       }
> +
> +#ifdef CONFIG_DEBUG_FS

Drop the config and make an inline stub for the function below when
CONFIG_DEBUG_FS=3Dn.

> +       ret =3D lmk04832_register_debugfs(lmk);
> +       if (ret)
> +               goto err_del_provider;
> +#endif
> +
> +       spi_set_drvdata(spi, lmk);
> +       dev_info(lmk->dev, "successfully initialized, product ID is 0x%04=
x\n",

Please drop this "I probed" message.

> +                lmk_devinfo.pid);
> +
> +       return 0;
> +
> +err_del_provider:
> +       of_clk_del_provider(spi->dev.of_node);
> +
> +err_disable_oscin:
> +       clk_disable_unprepare(lmk->oscin);
> +
> +       return ret;
> +}
> +
> +static int lmk04832_remove(struct spi_device *spi)
> +{
> +       struct lmk04832 *lmk =3D spi_get_drvdata(spi);
> +
> +#ifdef CONFIG_DEBUG_FS

Drop the config.

> +       debugfs_remove_recursive(lmk->debugfs_dentry);
> +#endif
> +       clk_disable_unprepare(lmk->oscin);
> +
> +       of_clk_del_provider(spi->dev.of_node);
> +
> +       return 0;
> +}
> +static const struct spi_device_id lmk04832_id[] =3D {
> +       { "lmk04832", LMK04832 },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(spi, lmk04832_id);

Presumably there's some of_device_id table needed as well?

> +
> +static struct spi_driver lmk04832_driver =3D {
> +       .driver =3D {
> +               .name   =3D "lmk04832",
> +               .owner  =3D THIS_MODULE,

Drop this owner line as module_spi_driver() should handle it.

> +       },
> +       .probe          =3D lmk04832_probe,
> +       .remove         =3D lmk04832_remove,
> +       .id_table       =3D lmk04832_id,
> +};
> +module_spi_driver(lmk04832_driver);
> +
