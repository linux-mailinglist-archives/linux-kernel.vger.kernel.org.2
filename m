Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD87D3A3E54
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhFKIxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbhFKIxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:53:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C6146024A;
        Fri, 11 Jun 2021 08:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623401512;
        bh=+wBiu5ms4OsgACb1B7q5KRRJdv1j9O9tSD7CRkVlVFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAu5TO8aXMC8fj8IO5lsRsJ2cWKehdXVZP9tWiBg4+a/5DmkQl/ghfZdeRGCHxz3R
         PYXbunfwoeNfGGDya+Zl+9G3NfZrf0/VBi9rQx7o8HiIsvQ82NGlKsL67sMYO75YzB
         8szlTsdStdraS5d+ap6KtvMXCljLmIxPo0rkq3Vk=
Date:   Fri, 11 Jun 2021 10:51:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v9 2/5] nvmem: eeprom: at25: add support for FRAM
Message-ID: <YMMkJo6insUzgqET@kroah.com>
References: <20210611052652.7894-1-jiri.prchal@aksignal.cz>
 <20210611052652.7894-3-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611052652.7894-3-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 07:26:49AM +0200, Jiri Prchal wrote:
> Added support for Cypress FRAMs.

Which devices exactly are you adding support for?

> These frams have ID and some of them have serial number too.
> Size of them is recognized by ID. They don't have pages, it could
> be read or written at once, but it's limited in this driver to
> io limit 4096.
> 
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
> v2: fixed warning at %zd at int
> Reported-by: kernel test robot <lkp@intel.com>
> v3: resend and added more recipients
> v4: resend
> v5: used in-kernel function int_pow
> v6: no change here
> v7: moved definition of sernum size to patch 4
> v8: changed buffer type to u8
> v9: removed needless has_sernum
> ---
>  drivers/misc/eeprom/Kconfig |   5 +-
>  drivers/misc/eeprom/at25.c  | 134 ++++++++++++++++++++++++++++--------
>  2 files changed, 107 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
> index 0f791bfdc1f5..f0a7531f354c 100644
> --- a/drivers/misc/eeprom/Kconfig
> +++ b/drivers/misc/eeprom/Kconfig
> @@ -32,12 +32,13 @@ config EEPROM_AT24
>  	  will be called at24.
>  
>  config EEPROM_AT25
> -	tristate "SPI EEPROMs from most vendors"
> +	tristate "SPI EEPROMs (FRAMs) from most vendors"
>  	depends on SPI && SYSFS
>  	select NVMEM
>  	select NVMEM_SYSFS
>  	help
> -	  Enable this driver to get read/write support to most SPI EEPROMs,
> +	  Enable this driver to get read/write support to most SPI EEPROMs
> +	  and Cypress FRAMs,
>  	  after you configure the board init code to know about each eeprom
>  	  on your target board.
>  
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index b76e4901b4a4..e59b6852816d 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * at25.c -- support most SPI EEPROMs, such as Atmel AT25 models
> + *	     and Cypress FRAMs FM25 models
>   *
>   * Copyright (C) 2006 David Brownell
>   */
> @@ -16,6 +17,9 @@
>  #include <linux/spi/spi.h>
>  #include <linux/spi/eeprom.h>
>  #include <linux/property.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/math.h>
>  
>  /*
>   * NOTE: this is an *EEPROM* driver.  The vagaries of product naming
> @@ -42,6 +46,9 @@ struct at25_data {
>  #define	AT25_WRSR	0x01		/* write status register */
>  #define	AT25_READ	0x03		/* read byte(s) */
>  #define	AT25_WRITE	0x02		/* write byte(s)/sector */
> +#define	FM25_SLEEP	0xb9		/* enter sleep mode */
> +#define	FM25_RDID	0x9f		/* read device ID */
> +#define	FM25_RDSN	0xc3		/* read S/N */
>  
>  #define	AT25_SR_nRDY	0x01		/* nRDY = write-in-progress */
>  #define	AT25_SR_WEN	0x02		/* write enable (latched) */
> @@ -51,6 +58,8 @@ struct at25_data {
>  
>  #define	AT25_INSTR_BIT3	0x08		/* Additional address bit in instr */
>  
> +#define	FM25_ID_LEN	9		/* ID length */
> +
>  #define EE_MAXADDRLEN	3		/* 24 bit addresses, up to 2 MBytes */
>  
>  /* Specs often allow 5 msec for a page write, sometimes 20 msec;
> @@ -58,6 +67,9 @@ struct at25_data {
>   */
>  #define	EE_TIMEOUT	25
>  
> +#define	IS_EEPROM	0
> +#define	IS_FRAM		1
> +
>  /*-------------------------------------------------------------------------*/
>  
>  #define	io_limit	PAGE_SIZE	/* bytes */
> @@ -129,6 +141,36 @@ static int at25_ee_read(void *priv, unsigned int offset,
>  	return status;
>  }
>  
> +/*
> + * read extra registers as ID or serial number
> + */
> +static int fm25_aux_read(struct at25_data *at25, u8 *buf, uint8_t command,
> +			 int len)
> +{
> +	int status;
> +	struct spi_transfer t[2];
> +	struct spi_message m;
> +
> +	spi_message_init(&m);
> +	memset(t, 0, sizeof(t));
> +
> +	t[0].tx_buf = &command;
> +	t[0].len = 1;
> +	spi_message_add_tail(&t[0], &m);
> +
> +	t[1].rx_buf = buf;
> +	t[1].len = len;
> +	spi_message_add_tail(&t[1], &m);
> +
> +	mutex_lock(&at25->lock);
> +
> +	status = spi_sync(at25->spi, &m);
> +	dev_dbg(&at25->spi->dev, "read %d aux bytes --> %d\n", len, status);
> +
> +	mutex_unlock(&at25->lock);
> +	return status;
> +}
> +
>  static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
>  {
>  	struct at25_data *at25 = priv;
> @@ -303,34 +345,37 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
>  	return 0;
>  }
>  
> +static const struct of_device_id at25_of_match[] = {
> +	{ .compatible = "atmel,at25", .data = (const void *)IS_EEPROM },
> +	{ .compatible = "cypress,fm25", .data = (const void *)IS_FRAM },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, at25_of_match);
> +
>  static int at25_probe(struct spi_device *spi)
>  {
>  	struct at25_data	*at25 = NULL;
>  	struct spi_eeprom	chip;
>  	int			err;
>  	int			sr;
> -	int			addrlen;
> +	u8 id[FM25_ID_LEN];
> +	const struct of_device_id *match;
> +	int is_fram = 0;
> +
> +	match = of_match_device(of_match_ptr(at25_of_match), &spi->dev);
> +	if (match)
> +		is_fram = (int)(uintptr_t)match->data;

Why the double cast?

And "uintptr_t" is not a kernel type.  This originally is just a void *,
so no need to "double cast" it here, right?

thanks,

greg k-h
