Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D47539D8C8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhFGJdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhFGJdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:33:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F992610A1;
        Mon,  7 Jun 2021 09:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623058276;
        bh=LrBvHL3aolaWr2c2hTdDl2fLYXTXMYq/Ecg4VX6RQWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YfQUp1/pQra+W56MbgRlkpno1T22lOTw9m74WtDyVylyrNs/z6na/8M7dyt43yiE6
         VP3ThltpOEN1PVkBsZfcXWwhU+ipr07pKfhKqCx21DCXnGsWAeYSPnjmTDRQesBnU3
         NDhJiGnOlPHv5mrc8/gnx2g3zu0YMPMco7/vGx44=
Date:   Mon, 7 Jun 2021 11:31:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 4/5] nvmem: eeprom: at25: export FRAM serial num
Message-ID: <YL3nYjzn1HVMlwJ8@kroah.com>
References: <20210607082638.52409-1-jiri.prchal@aksignal.cz>
 <20210607082638.52409-5-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607082638.52409-5-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 10:26:37AM +0200, Jiri Prchal wrote:
> This exports serial number of FRAM in sysfs file named "sernum".
> Formatted in hex, each byte separated by space.
> Example:
> $ cat /sys/class/spi_master/spi0/spi0.0/sernum
> 0000a43644f2ae6c
> 
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
> v2: no change here
> v3: resend and added more recipients
> v4: resend
> v5: reworked up on Greg comments: no spaces in string, sysfs done correctly
> v6: no change here
> ---
>  drivers/misc/eeprom/at25.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index 45a486994828..4e4fa8d3ba5d 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -39,6 +39,7 @@ struct at25_data {
>  	struct nvmem_config	nvmem_config;
>  	struct nvmem_device	*nvmem;
>  	int has_sernum;
> +	char *sernum;
>  };
>  
>  #define	AT25_WREN	0x06		/* latch the write enable */
> @@ -173,6 +174,25 @@ static int fm25_aux_read(struct at25_data *at25, char *buf, uint8_t command,
>  	return status;
>  }
>  
> +static ssize_t sernum_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct at25_data *at25;
> +	int i;
> +
> +	at25 = dev_get_drvdata(dev);
> +	for (i = FM25_SN_LEN - 1; i >= 0; i--)
> +		buf += sprintf(buf, "%02x", at25->sernum[i]);
> +	sprintf(buf, "\n");

Please use sysfs_emit() with the proper print modifier for an array of
bytes in hex (I think there is one...)

> +	return (2 * FM25_SN_LEN + 1);
> +}
> +static DEVICE_ATTR(sernum, 0440, sernum_show, NULL);

DEVICE_ATTR_RO() please.


> +
> +static struct attribute *sernum_attrs[] = {
> +	&dev_attr_sernum.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(sernum);
> +
>  static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
>  {
>  	struct at25_data *at25 = priv;
> @@ -417,8 +437,13 @@ static int at25_probe(struct spi_device *spi)
>  		else
>  			at25->chip.flags |= EE_ADDR2;
>  
> -		if (id[8])
> +		if (id[8]) {
>  			at25->has_sernum = 1;
> +			at25->sernum = kzalloc(FM25_SN_LEN, GFP_KERNEL);

Where do you free this memory?

And why does it have to be 0 filled?

thanks,

greg k-h
