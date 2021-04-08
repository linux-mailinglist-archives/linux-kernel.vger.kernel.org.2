Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59978358CFC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhDHSxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:53:22 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:41684 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHSxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:53:20 -0400
Received: by mail-pg1-f174.google.com with SMTP id f29so2043818pgm.8;
        Thu, 08 Apr 2021 11:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h49KcBd5xHhKT6A+MHvhKtJ6y1rV0GAACbv3hOLpipg=;
        b=IcjgX/JjFa3Xva2CGdyM6qYxCNj/g7a6b2O1w920voEMn7PgdKJt710anCve1ss2Qr
         sym3s+TxJ6xug/CxCe5K5GgZj48m69XIf8/1kQ11XUuGnM6L1ispC6dO8P0R7eLnFTbs
         ePZX56MSvsYwfl+w5DEg9q1mGd0tp9hKHdsUFWOsxg+ZSOgwu2rL5ZW0eJyLiAxm4Tvu
         Y6cyWMKpe2Vct+G5xE6s6y8A9GEpUCy4t2fQ/jdT6RNfs4b5kdogBVu6KZgdxlUaXvYT
         M1jQZ00TVkfxadGcYS1EWoN/b9YHuJ3diM1goHRoQx7moCD5YNhCEcXJdUdFnf7rOoX0
         R4Lg==
X-Gm-Message-State: AOAM531J+TNO4lBmOdBVezyQWJGj0IJcj17REd0XKGlUj6e5AN0l8jO/
        S6DG95D77Mcw31GkgmNe5e0=
X-Google-Smtp-Source: ABdhPJzBe01GxB/GWlJFtZWCiM+i1cMOBBsP48lhU5f8tagsfcedli8OKNojSTz16WBxdZ00iBRbUw==
X-Received: by 2002:a63:4c5d:: with SMTP id m29mr9081742pgl.366.1617907988613;
        Thu, 08 Apr 2021 11:53:08 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id x18sm201791pfu.32.2021.04.08.11.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 11:53:07 -0700 (PDT)
Date:   Thu, 8 Apr 2021 11:53:06 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "Xu, Yilun" <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "russell.h.weight@linux.intel.com" <russell.h.weight@linux.intel.com>
Subject: Re: [PATCH 2/3] fpga: dfl: Add DFL bus driver for Altera SPI Master
Message-ID: <YG9REtNPi4e2hyJK@epycbox.lan>
References: <20210405235301.187542-1-matthew.gerlach@linux.intel.com>
 <20210405235301.187542-3-matthew.gerlach@linux.intel.com>
 <YGuvFYvJTMPPm2Jy@epycbox.lan>
 <alpine.DEB.2.22.394.2104060847030.208844@rhweight-WRK1>
 <YGyQdN9uS/niyFDP@epycbox.lan>
 <DM6PR11MB3819E0FC4F735C72746CE54785749@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20210408081152.GA2713@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819317A55FD7798E778EC4D85749@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819317A55FD7798E778EC4D85749@DM6PR11MB3819.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 09:20:19AM +0000, Wu, Hao wrote:
> > On Thu, Apr 08, 2021 at 03:30:15PM +0800, Wu, Hao wrote:
> > > > > On Mon, 5 Apr 2021, Moritz Fischer wrote:
> > > > >
> > > > > > Hi Matthew,
> > > > > >
> > > > > > On Mon, Apr 05, 2021 at 04:53:00PM -0700,
> > > > matthew.gerlach@linux.intel.com wrote:
> > > > > > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > > > >
> > > > > > > This patch adds DFL bus driver for the Altera SPI Master
> > > > > > > controller.  The SPI master is connected to an Intel SPI Slave to
> > > > > > > Avalon Master Bridge, inside an Intel MAX10 BMC Chip.
> > > > > > >
> > > > > > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > > > > ---
> > > > > > >  drivers/fpga/Kconfig          |   9 ++
> > > > > > >  drivers/fpga/Makefile         |   1 +
> > > > > > >  drivers/fpga/dfl-spi-altera.c | 221
> > > > ++++++++++++++++++++++++++++++++++++++++++
> > > > > > >  3 files changed, 231 insertions(+)
> > > > > > >  create mode 100644 drivers/fpga/dfl-spi-altera.c
> > > > > > >
> > > > > > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > > > > > index d591dd9..0a86994 100644
> > > > > > > --- a/drivers/fpga/Kconfig
> > > > > > > +++ b/drivers/fpga/Kconfig
> > > > > > > @@ -210,6 +210,15 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
> > > > > > >    the card. It also instantiates the SPI master (spi-altera) for
> > > > > > >    the card's BMC (Board Management Controller).
> > > > > > >
> > > > > > > +config FPGA_DFL_SPI_ALTERA
> > > > > > > +tristate "FPGA DFL Altera SPI Master Driver"
> > > > > > > +depends on FPGA_DFL
> > > > > > > +select REGMAP
> > > > > > > +help
> > > > > > > +  This is a DFL bus driver for the Altera SPI master controller.
> > > > > > > +  The SPI master is connected to a SPI slave to Avalon Master
> > > > > > > +  bridge in a Intel MAX BMC.
> > > > > > > +
> > > > > > >  config FPGA_DFL_PCI
> > > > > > >  tristate "FPGA DFL PCIe Device Driver"
> > > > > > >  depends on PCI && FPGA_DFL
> > > > > > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > > > > > > index 18dc9885..58a42ad 100644
> > > > > > > --- a/drivers/fpga/Makefile
> > > > > > > +++ b/drivers/fpga/Makefile
> > > > > > > @@ -45,6 +45,7 @@ dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-
> > > > afu-dma-region.o
> > > > > > >  dfl-afu-objs += dfl-afu-error.o
> > > > > > >
> > > > > > >  obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)+= dfl-n3000-
> > > > nios.o
> > > > > > > +obj-$(CONFIG_FPGA_DFL_SPI_ALTERA)+= dfl-spi-altera.o
> > > > > > >
> > > > > > >  # Drivers for FPGAs which implement DFL
> > > > > > >  obj-$(CONFIG_FPGA_DFL_PCI)+= dfl-pci.o
> > > > > > > diff --git a/drivers/fpga/dfl-spi-altera.c b/drivers/fpga/dfl-spi-altera.c
> > > > > > > new file mode 100644
> > > > > > > index 0000000..9bec25fd
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/fpga/dfl-spi-altera.c
> > > > > > > @@ -0,0 +1,221 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > > +/*
> > > > > > > + * DFL bus driver for Altera SPI Master
> > > > > > > + *
> > > > > > > + * Copyright (C) 2020 Intel Corporation, Inc.
> > > > > > > + *
> > > > > > > + * Authors:
> > > > > > > + *   Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > > > > + */
> > > > > > > +
> > > > > > > +#include <linux/types.h>
> > > > > > > +#include <linux/kernel.h>
> > > > > > > +#include <linux/module.h>
> > > > > > > +#include <linux/stddef.h>
> > > > > > > +#include <linux/errno.h>
> > > > > > > +#include <linux/platform_device.h>
> > > > > > > +#include <linux/io.h>
> > > > > > > +#include <linux/bitfield.h>
> > > > > > > +#include <linux/io-64-nonatomic-lo-hi.h>
> > > > > > > +#include <linux/regmap.h>
> > > > > > > +#include <linux/spi/spi.h>
> > > > > > > +#include <linux/spi/altera.h>
> > > > > > > +#include <linux/dfl.h>
> > > > > > > +
> > > > > > > +struct dfl_altera_spi {
> > > > > > > +void __iomem *base;
> > > > > > > +struct regmap *regmap;
> > > > > > > +struct device *dev;
> > > > > > > +struct platform_device *altr_spi;
> > > > > > > +};
> > > > > > > +
> > > > > > > +#define SPI_CORE_PARAMETER      0x8
> > > > > > > +#define SHIFT_MODE              BIT_ULL(1)
> > > > > > > +#define SHIFT_MODE_MSB          0
> > > > > > > +#define SHIFT_MODE_LSB          1
> > > > > > > +#define DATA_WIDTH              GENMASK_ULL(7, 2)
> > > > > > > +#define NUM_CHIPSELECT          GENMASK_ULL(13, 8)
> > > > > > > +#define CLK_POLARITY            BIT_ULL(14)
> > > > > > > +#define CLK_PHASE               BIT_ULL(15)
> > > > > > > +#define PERIPHERAL_ID           GENMASK_ULL(47, 32)
> > > > > > > +#define SPI_CLK                 GENMASK_ULL(31, 22)
> > > > > > > +#define SPI_INDIRECT_ACC_OFST   0x10
> > > > > > > +
> > > > > > > +#define INDIRECT_ADDR           (SPI_INDIRECT_ACC_OFST+0x0)
> > > > > > > +#define INDIRECT_WR             BIT_ULL(8)
> > > > > > > +#define INDIRECT_RD             BIT_ULL(9)
> > > > > > > +#define INDIRECT_RD_DATA        (SPI_INDIRECT_ACC_OFST+0x8)
> > > > > > > +#define INDIRECT_DATA_MASK      GENMASK_ULL(31, 0)
> > > > > > > +#define INDIRECT_DEBUG          BIT_ULL(32)
> > > > > > > +#define INDIRECT_WR_DATA        (SPI_INDIRECT_ACC_OFST+0x10)
> > > > > > > +#define INDIRECT_TIMEOUT        10000
> > > > > > > +
> > > > > > > +static int indirect_bus_reg_read(void *context, unsigned int reg,
> > > > > > > + unsigned int *val)
> > > > > > > +{
> > > > > > > +struct dfl_altera_spi *aspi = context;
> > > > > > > +void __iomem *base = aspi->base;
> > > > > > > +int loops;
> > > > > > > +u64 v;
> > > > > > > +
> > > > > > > +writeq((reg >> 2) | INDIRECT_RD, base + INDIRECT_ADDR);
> > > > > > > +
> > > > > > > +loops = 0;
> > > > > > > +while ((readq(base + INDIRECT_ADDR) & INDIRECT_RD) &&
> > > > > > > +       (loops++ < INDIRECT_TIMEOUT))
> > > > > > > +cpu_relax();
> > > > > > > +
> > > > > > > +if (loops >= INDIRECT_TIMEOUT) {
> > > > > > > +pr_err("%s timed out %d\n", __func__, loops);
> > > > > > > +return -ETIME;
> > > > > > > +}
> > > > > > > +
> > > > > > > +v = readq(base + INDIRECT_RD_DATA);
> > > > > > > +
> > > > > > > +*val = v & INDIRECT_DATA_MASK;
> > > > > > > +
> > > > > > > +return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int indirect_bus_reg_write(void *context, unsigned int reg,
> > > > > > > +  unsigned int val)
> > > > > > > +{
> > > > > > > +struct dfl_altera_spi *aspi = context;
> > > > > > > +void __iomem *base = aspi->base;
> > > > > > > +int loops;
> > > > > > > +
> > > > > > > +writeq(val, base + INDIRECT_WR_DATA);
> > > > > > > +writeq((reg >> 2) | INDIRECT_WR, base + INDIRECT_ADDR);
> > > > > > > +
> > > > > > > +loops = 0;
> > > > > > > +while ((readq(base + INDIRECT_ADDR) & INDIRECT_WR) &&
> > > > > > > +       (loops++ < INDIRECT_TIMEOUT))
> > > > > > > +cpu_relax();
> > > > > > > +
> > > > > > > +if (loops >= INDIRECT_TIMEOUT) {
> > > > > > > +pr_err("%s timed out %d\n", __func__, loops);
> > > > > > > +return -ETIME;
> > > > > > > +}
> > > > > > > +return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static const struct regmap_config indirect_regbus_cfg = {
> > > > > > > +.reg_bits = 32,
> > > > > > > +.reg_stride = 4,
> > > > > > > +.val_bits = 32,
> > > > > > > +.fast_io = true,
> > > > > > > +
> > > > > > > +.reg_write = indirect_bus_reg_write,
> > > > > > > +.reg_read = indirect_bus_reg_read,
> > > > > > > +};
> > > > > > > +
> > > > > > > +static struct spi_board_info m10_bmc_info = {
> > > > > > > +.modalias = "m10-d5005",
> > > > > > > +.max_speed_hz = 12500000,
> > > > > > > +.bus_num = 0,
> > > > > > > +.chip_select = 0,
> > > > > > > +};
> > > > > > > +
> > > > > > > +static struct platform_device *create_cntrl(struct device *dev,
> > > > > > > +    void __iomem *base,
> > > > > > > +    struct spi_board_info *m10_info)
> > > > > > > +{
> > > > > > > +struct altera_spi_platform_data pdata;
> > > > > > > +struct platform_device_info pdevinfo;
> > > > > > > +u64 v;
> > > > > > > +
> > > > > > > +v = readq(base + SPI_CORE_PARAMETER);
> > > > > > > +
> > > > > > > +memset(&pdata, 0, sizeof(pdata));
> > > > > > > +pdata.mode_bits = SPI_CS_HIGH;
> > > > > > > +if (FIELD_GET(CLK_POLARITY, v))
> > > > > > > +pdata.mode_bits |= SPI_CPOL;
> > > > > > > +if (FIELD_GET(CLK_PHASE, v))
> > > > > > > +pdata.mode_bits |= SPI_CPHA;
> > > > > > > +
> > > > > > > +pdata.num_chipselect = FIELD_GET(NUM_CHIPSELECT, v);
> > > > > > > +pdata.bits_per_word_mask =
> > > > > > > +SPI_BPW_RANGE_MASK(1, FIELD_GET(DATA_WIDTH, v));
> > > > > > > +
> > > > > > > +pdata.num_devices = 1;
> > > > > > > +pdata.devices = m10_info;
> > > > > > > +
> > > > > > > +dev_dbg(dev, "%s cs %u bpm 0x%x mode 0x%x\n", __func__,
> > > > > > > +pdata.num_chipselect, pdata.bits_per_word_mask,
> > > > > > > +pdata.mode_bits);
> > > > > > > +
> > > > > > > +memset(&pdevinfo, 0, sizeof(pdevinfo));
> > > > > > > +
> > > > > > > +pdevinfo.name = "subdev_spi_altera";
> > > > > > > +pdevinfo.id = PLATFORM_DEVID_AUTO;
> > > > > > > +pdevinfo.parent = dev;
> > > > > > > +pdevinfo.data = &pdata;
> > > > > > > +pdevinfo.size_data = sizeof(pdata);
> > > > > > > +
> > > > > > > +return platform_device_register_full(&pdevinfo);
> > > > > >
> > > > > > Should this be a SPI driver? I think looking at the UIO case we had
> > > > > > decided against this pattern?
> > > > >
> > > > > This driver is similar in function to drivers/fpga/dfl-n3000-nios.c which
> > > > > uses this design pattern.  Is it okay to keep this design pattern for
> > > > > consistency?
> > > > >
> > > > >
> > > > > >
> > > > > > > +}
> > > > > > > +static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
> > > > > > > +{
> > > > > > > +struct device *dev = &dfl_dev->dev;
> > > > > > > +struct dfl_altera_spi *aspi;
> > > > > > > +
> > > > > > > +aspi = devm_kzalloc(dev, sizeof(*aspi), GFP_KERNEL);
> > > > > > > +
> > > > > > > +if (!aspi)
> > > > > > > +return -ENOMEM;
> > > > > > > +
> > > > > > > +dev_set_drvdata(dev, aspi);
> > > > > > > +
> > > > > > > +aspi->dev = dev;
> > > > > > > +
> > > > > > > +aspi->base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
> > > > > > > +
> > > > > > > +if (IS_ERR(aspi->base)) {
> > > > > > > +dev_err(dev, "%s get mem resource fail!\n", __func__);
> > > > > > > +return PTR_ERR(aspi->base);
> > > > > > > +}
> > > > > > > +
> > > > > > > +aspi->regmap = devm_regmap_init(dev, NULL, aspi,
> > > > &indirect_regbus_cfg);
> > > > > > > +if (IS_ERR(aspi->regmap))
> > > > > > > +return PTR_ERR(aspi->regmap);
> > > > > > > +
> > > > > > > +aspi->altr_spi = create_cntrl(dev, aspi->base, &m10_bmc_info);
> > > > > > > +
> > > > > > > +if (IS_ERR(aspi->altr_spi)) {
> > > > > > > +dev_err(dev, "%s failed to create spi platform driver\n",
> > > > > > > +__func__);
> > > > > > > +return PTR_ERR(aspi->base);
> > > > > > > +}
> > > > > > > +
> > > > > > > +return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void dfl_spi_altera_remove(struct dfl_device *dfl_dev)
> > > > > > > +{
> > > > > > > +struct dfl_altera_spi *aspi = dev_get_drvdata(&dfl_dev->dev);
> > > > > > > +
> > > > > > > +platform_device_unregister(aspi->altr_spi);
> > > > > > > +}
> > > > > > > +
> > > > > > > +#define FME_FEATURE_ID_MAX10_SPI        0xe
> > > > > > > +
> > > > > > > +static const struct dfl_device_id dfl_spi_altera_ids[] = {
> > > > > > > +{ FME_ID, FME_FEATURE_ID_MAX10_SPI },
> > > > > > > +{ }
> > > > > > > +};
> > > > > >
> > > > > > Maybe you can extend the Altera SPI driver with this part?
> > > > >
> > > > > The file, drivers/spi/spi-altera.c, already has platform MODULE_ related
> > > > > code.  Wouldn't moving this code to that file produce conflicts?
> > > >
> > > > I've seen other drivers support multiple busses, so it should be
> > > > possible, there might be nuances I'm missing in my brief look at this,
> > > > though.
> > > >
> > > > I think one of them would be MODULE_DEVICE_TABLE(platform, ...)
> > > > and the other one MODULE_DEVICE_TABLE(dfl, ...)
> > > >
> > > > See drivers/i2c/busses/i2c-designware-platdrv.c for an example (though
> > > > they might be guarding against what you describe with CONFIG_OF vs
> > > > CONFIG_ACPI)
> > > >
> > > > If that doesn't work we could split it up into
> > > >
> > > > altera-spi-plat.c and altera-spi-dfl.c and altera-spi-core.c
> > > > or something of that sort?
> > > >
> > > > My point being, now that we have a bus, let's use it and develop drivers
> > > > according to the Linux device model where possible :)
> > >
> > > Agree. This does make sense from my side too. DFL core provides the
> > mechanism
> > > to enumerate different IPs on FPGA, but each function driver needs to go to
> > > related subsystem for review.  : )
> > >
> > > I understand that for FPGA case, it may have some additional logics for specific
> > > purposes based on common altera spi master IP, then additional code for
> > 
> > I'm wondering if the additional logics are extensions for common spi-altera. Like
> > the
> > SPI_CORE_PARAMETER register, it is not within the register space of
> > spi-altera,
> > 
> > 
> >   |   |      +-------------+
> >   |DFL|------| +--------+  |
> >   |BUS|      | |SPI CORE|  |
> >   |   |      | |PARAM   |  |
> >   |   |      | +--------+  |
> >   |   |      |             |
> >   |   |      | +--------+  |   +-------+
> >              | |Indirect|  |   |spi    |
> >              | |access  +--+---|altera |
> >              | |master  |  |   +-------+
> >              | +--------+  |
> >              +-------------+
> > > a specific product still can be put into altera-spi-xxxx.c or altera-spi-dfl-xxxx.c
> > 
> > So is it proper we integrate this feature into spi-altera? Previously
> > we have merged the dfl-n3000-nios, its spi part is very similar as
> > this driver. The dfl-n3000-nios make the spi-altera as a sub device.
> > Could we borrow the idea, or could we just integrate this driver in
> > dfl-n3000-nios?
> 
> Looks like those are enhancements of the IP. They can be applied even
> other buses are used, not only for DFL, like PCI device or platform device,
> right? then why not put related code together with the original IP?

Do you maybe need to extend struct dfl_device to have multiple mmio_res,
then?

Can DFL describe such a scenario?

That seems the logical step to support what's been drawn up there?

> 
> The reason I suggested that function drivers which use DFL bus, still need
> to go to related subsystem, because we know DFL quite well but may
> not be the experts for every subsystem (e.g. SPI), and every IPs (e.g. 
> Altera SPI Master). Altera SPI Master driver maintainer could give more
> valuable suggestions on your question if this feature can be integrated
> into spi-altera or not. : )
> 
> Hao
> 
> > 
> > Thanks,
> > Yilun
> > 
> > >
> > > Thanks
> > > Hao
> > >
> > > >
> > > > Cheers,
> > > > Moritz

Cheers,
Moritz
