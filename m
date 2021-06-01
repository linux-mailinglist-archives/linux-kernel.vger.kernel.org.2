Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54803970C5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhFAJ7p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Jun 2021 05:59:45 -0400
Received: from smtp.asem.it ([151.1.184.197]:53860 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232173AbhFAJ7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:59:42 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Jun 2021 05:59:41 EDT
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 8.0.0)
        with ESMTP id 83bc53ab63c74599b705a2029c7a2fe7.MSG
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 11:52:55 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 1 Jun
 2021 11:52:55 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.2176.009; Tue, 1 Jun 2021 11:52:55 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Michael Walle <michael@walle.cc>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "Pratyush Yadav" <p.yadav@ti.com>
Subject: RE: [PATCH v1] mtd: spi-nor: add ACPI support for non-JEDEC SPI-NOR
Thread-Topic: [PATCH v1] mtd: spi-nor: add ACPI support for non-JEDEC SPI-NOR
Thread-Index: AQHW8/DSQFilXQ1vXUSgmqjMFBEDbqr92CQAgAHUbcA=
Date:   Tue, 1 Jun 2021 09:52:55 +0000
Message-ID: <67ad7c365fa749209eab5ddae7f8ce80@asem.it>
References: <20210126143748.1546187-1-f.suligoi@asem.it>
 <20210531074424.16086-1-michael@walle.cc>
In-Reply-To: <20210531074424.16086-1-michael@walle.cc>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.208]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A782F24.60B60377.0096,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

...
> 
> > In a x86 machine, an additional device can be described
> > inside the BIOS ACPI tables.
> > For example, an I2C GPIO expander, a LED, etc.,
> > can be successfully declared in ACPI, so that the related
> > device driver can start automatically at the boot.
> >
> > But for the SPI NOR devices, the ACPI description works
> > for JEDEC-compatible devices only.
> >
> > For example, an Everspin MR25H40 MRAM device (non-JEDEC
> > compatible), declared using the following table,
> > does not work:
> >
> >     Scope (\_SB.SPI1)
> >     {
> >         Device (NVR0)
> >         {
> >             Name (_HID, "PRP0001")
> >             Name (_DDN, "Everspin MR25H40 MRAM")
> >             Name (_CRS, ResourceTemplate () {
> >                 SpiSerialBus (
> >                 1,                      // Chip select
> >                 PolarityLow,            // Chip select is active low
> >                 FourWireMode,           // Full duplex
> >                 8,                      // Bits per word is 8 (byte)
> >                 ControllerInitiated,    // Don't care
> >                 10000000,               // 10 MHz
> >                 ClockPolarityLow,       // SPI mode 0 ClockPolarityLow
> >                 ClockPhaseFirst,        // SPI mode 0 ClockPhaseFirst
> >                 "\\_SB.SPI1",           // SPI host controller
> >                 0,                      // Must be 0
> >                 ResourceConsumer,
> >                 ,
> >                 )
> >             })
> >
> >             Name (_DSD, Package () {
> >                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >                 Package () {
> >                     Package () {"compatible", "mr25h40"},
> >                 }
> >             })
> >         }
> >     }
> 
> This isn't the correct compatible string, according to the devicetree
> binding [1], there is no compatible = "mr25h40" binding. The correct entry
> would be
>  compatible = "everspin,mr25h40", "jedec,spi-nor";
> 
> I'm not familiar with ACPI and don't know wether you can specify a list,
> nor am I convinced that it will work then. But it should be worth a try.

It works on our board with our custom BIOS.
I'm currently use this patch for the kernel of our x86 machines.
And that's is the only way I've found to describe the mr25h40 MRAM
presence in our BIOS.
Obviously, it works because of the above ACPI description is built-in
inside the custom BIOS of our boards.
Note that the mr25h40 is NOT jedec compatible.

> 
> [1] Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> 
> >
> > To enable the detection of a non-JEDEC device described
> > in a BIOS ACPI table, it is necessary to add its id name
> > in the spi_nor_of_table structure.
> > With this change, all the SPI NOR devices (JEDEC and
> > non-JEDEC) can be detected by the kernel (and the above
> > example of ACPI table finally works).
> >
> > Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> > ---
> >  drivers/mtd/spi-nor/core.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 6ae7d4c2d2b6..b6fb8b15c439 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -3755,6 +3755,19 @@ static const struct of_device_id
> spi_nor_of_table[] = {
> >  	 * JEDEC READ ID opcode (0x9F). Use this, if possible.
> >  	 */
> >  	{ .compatible = "jedec,spi-nor" },
> > +	{ .compatible = "m25p05-nonjedec" },
> > +	{ .compatible = "m25p10-nonjedec" },
> > +	{ .compatible = "m25p20-nonjedec" },
> > +	{ .compatible = "m25p40-nonjedec" },
> > +	{ .compatible = "m25p80-nonjedec" },
> > +	{ .compatible = "m25p16-nonjedec" },
> > +	{ .compatible = "m25p32-nonjedec" },
> > +	{ .compatible = "m25p64-nonjedec" },
> > +	{ .compatible = "m25p128-nonjedec" },
> > +	{ .compatible = "mr25h128" },
> > +	{ .compatible = "mr25h256" },
> > +	{ .compatible = "mr25h10" },
> > +	{ .compatible = "mr25h40" },
> >  	{ /* sentinel */ },
> >  };
> >  MODULE_DEVICE_TABLE(of, spi_nor_of_table);
> > --
> > 2.25.1

Thank you very much for your suggestions,
Flavio
