Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68952389D61
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 07:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhETFyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 01:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhETFyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 01:54:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 179B3600CD;
        Thu, 20 May 2021 05:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621489959;
        bh=mmvYidpxJwJA6FRO4I+/38QOPSQq4ArdS9cwWG/bWFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IbwTYbQubAcOmFoz9TeQpdhC9GH/78A6G6iQKzsNXrQoK0JGp82HA3xbJMCRQ4npb
         Bt9+Itqj4vXO1p7I7NBs/J30ES5vSbdNEvrfLcGl1cvERekgbgpHGv9HRUw1OZBQHD
         xxz8BfT42GgsegWioNuGtF1byogSi5xf6EkwbCKQ=
Date:   Thu, 20 May 2021 07:52:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 4/4] nvmem: eeprom: at25: export FRAM serial num
Message-ID: <YKX5Iqm3AoCXsDV6@kroah.com>
References: <20210520054714.8736-1-jiri.prchal@aksignal.cz>
 <20210520054714.8736-5-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520054714.8736-5-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 07:47:14AM +0200, Jiri Prchal wrote:
> This exports serial number of FRAM in sysfs file named "sernum".
> Formatted in hex, each byte separated by space.
> Example:
> $ cat /sys/class/spi_master/spi0/spi0.0/sernum

No new Documentation/ABI/ entry for this?

> a4 36 44 f2 ae 6c 00 00
> 
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
> v2: no change here
> v3: resend and added more recipients
> v4: resend
> ---
>  drivers/misc/eeprom/at25.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index 4f6e983c278b..b2cffeb3af2c 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -38,6 +38,7 @@ struct at25_data {
>  	struct nvmem_config	nvmem_config;
>  	struct nvmem_device	*nvmem;
>  	int has_sernum;
> +	char *sernum;
>  };
> 
>  #define	AT25_WREN	0x06		/* latch the write enable */
> @@ -172,6 +173,19 @@ static int fm25_aux_read(struct at25_data *at25, char *buf, uint8_t command,
>  	return status;
>  }
> 
> +static ssize_t sernum_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct at25_data *at25;
> +	int i;
> +
> +	at25 = dev_get_drvdata(dev);
> +	for (i = 0; i < FM25_SN_LEN; i++)
> +		buf += sprintf(buf, "%02x ", at25->sernum[i]);
> +	sprintf(--buf, "\n");
> +	return (3 * i);

No, that is not how sysfs files work, sorry.  They are "one value per
file".  This looks like multiple values in the same file, why not just
one file per "sernum"?

Also, please use sysfs_emit() in the future.



> +}
> +static DEVICE_ATTR_RO(sernum);
> +
>  static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
>  {
>  	struct at25_data *at25 = priv;
> @@ -427,8 +441,13 @@ static int at25_probe(struct spi_device *spi)
>  		else
>  			at25->chip.flags |= EE_ADDR2;
> 
> -		if (id[8])
> +		if (id[8]) {
>  			at25->has_sernum = 1;
> +			at25->sernum = kzalloc(FM25_SN_LEN, GFP_KERNEL);
> +			if (!at25->sernum)
> +				return -ENOMEM;
> +			fm25_aux_read(at25, at25->sernum, FM25_RDSN, FM25_SN_LEN);
> +		}
>  		else
>  			at25->has_sernum = 0;
> 
> @@ -467,6 +486,13 @@ static int at25_probe(struct spi_device *spi)
>  	if (IS_ERR(at25->nvmem))
>  		return PTR_ERR(at25->nvmem);
> 
> +	/* Export the FM25 serial number */
> +	if (at25->has_sernum) {
> +		err = device_create_file(&spi->dev, &dev_attr_sernum);

You just raced with userspace and lost :(

Please do this correctly, by setting the driver group if you need a file
like this.

thanks,

greg k-h
