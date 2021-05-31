Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC79395672
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhEaHqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:46:13 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:56935 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhEaHqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:46:10 -0400
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8FF7722205;
        Mon, 31 May 2021 09:44:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1622447070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aetr3CJLcVwBx8/n3/lNL4cKdU1lU4msQpJFawzHTUU=;
        b=HDGQGeCj9UJxgjKjWMjomZZAZF0j70f8VZjMU/ufIZvVq1HQ9USZMvd4xniyvWczLRfETR
        NzsVt1afhWxM42Ca7EWmgUeaO2wdCvjb/qPfWJ1dH9OPH4ICeuSpvn2I2TzesBaR4c7/m4
        Z3wojAVJWyNmSyFU42PGvDS0HG+HOUY=
From:   Michael Walle <michael@walle.cc>
To:     f.suligoi@asem.it
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com, michael@walle.cc,
        Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH v1] mtd: spi-nor: add ACPI support for non-JEDEC SPI-NOR
Date:   Mon, 31 May 2021 09:44:24 +0200
Message-Id: <20210531074424.16086-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126143748.1546187-1-f.suligoi@asem.it>
References: <20210126143748.1546187-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> In a x86 machine, an additional device can be described
> inside the BIOS ACPI tables.
> For example, an I2C GPIO expander, a LED, etc.,
> can be successfully declared in ACPI, so that the related
> device driver can start automatically at the boot.
> 
> But for the SPI NOR devices, the ACPI description works
> for JEDEC-compatible devices only.
> 
> For example, an Everspin MR25H40 MRAM device (non-JEDEC
> compatible), declared using the following table,
> does not work:
> 
>     Scope (\_SB.SPI1)
>     {
>         Device (NVR0)
>         {
>             Name (_HID, "PRP0001")
>             Name (_DDN, "Everspin MR25H40 MRAM")
>             Name (_CRS, ResourceTemplate () {
>                 SpiSerialBus (
>                 1,                      // Chip select
>                 PolarityLow,            // Chip select is active low
>                 FourWireMode,           // Full duplex
>                 8,                      // Bits per word is 8 (byte)
>                 ControllerInitiated,    // Don't care
>                 10000000,               // 10 MHz
>                 ClockPolarityLow,       // SPI mode 0 ClockPolarityLow
>                 ClockPhaseFirst,        // SPI mode 0 ClockPhaseFirst
>                 "\\_SB.SPI1",           // SPI host controller
>                 0,                      // Must be 0
>                 ResourceConsumer,
>                 ,
>                 )
>             })
> 
>             Name (_DSD, Package () {
>                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                 Package () {
>                     Package () {"compatible", "mr25h40"},
>                 }
>             })
>         }
>     }

This isn't the correct compatible string, according to the devicetree
binding [1], there is no compatible = "mr25h40" binding. The correct entry
would be
 compatible = "everspin,mr25h40", "jedec,spi-nor";

I'm not familiar with ACPI and don't know wether you can specify a list,
nor am I convinced that it will work then. But it should be worth a try.

[1] Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml

> 
> To enable the detection of a non-JEDEC device described
> in a BIOS ACPI table, it is necessary to add its id name
> in the spi_nor_of_table structure.
> With this change, all the SPI NOR devices (JEDEC and
> non-JEDEC) can be detected by the kernel (and the above
> example of ACPI table finally works).
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  drivers/mtd/spi-nor/core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 6ae7d4c2d2b6..b6fb8b15c439 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3755,6 +3755,19 @@ static const struct of_device_id spi_nor_of_table[] = {
>  	 * JEDEC READ ID opcode (0x9F). Use this, if possible.
>  	 */
>  	{ .compatible = "jedec,spi-nor" },
> +	{ .compatible = "m25p05-nonjedec" },
> +	{ .compatible = "m25p10-nonjedec" },
> +	{ .compatible = "m25p20-nonjedec" },
> +	{ .compatible = "m25p40-nonjedec" },
> +	{ .compatible = "m25p80-nonjedec" },
> +	{ .compatible = "m25p16-nonjedec" },
> +	{ .compatible = "m25p32-nonjedec" },
> +	{ .compatible = "m25p64-nonjedec" },
> +	{ .compatible = "m25p128-nonjedec" },
> +	{ .compatible = "mr25h128" },
> +	{ .compatible = "mr25h256" },
> +	{ .compatible = "mr25h10" },
> +	{ .compatible = "mr25h40" },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, spi_nor_of_table);
> -- 
> 2.25.1
