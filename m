Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9043E3A444B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhFKOr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230508AbhFKOr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:47:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F1E6613C6;
        Fri, 11 Jun 2021 14:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623422712;
        bh=1YyTHfqURU0Hz7WIxsJ20hJvLqR0Vz5VNGTi/AQb7Nk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKIZnNO9l2IZCmo50C37hZsV5nEguP0igAxuqZs2gyyUkC+/8dZdXcMfZIv9leifx
         ZIGVh8BJgSAvPqlUKDLCe01ExyIDv/+TsWw4tUkWC3+tyOYhXJcLMciiD0pGw0ZGJm
         RgU5bFMh/FW05OHQMkIIbyJEaawJYGDxV/nCoVfY=
Date:   Fri, 11 Jun 2021 16:45:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvmem: eeprom: at25: fix type compiler warnings
Message-ID: <YMN29rIlPDCL0w3A@kroah.com>
References: <20210611142706.27336-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611142706.27336-1-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 04:27:06PM +0200, Jiri Prchal wrote:
> Fixes:
> drivers/misc/eeprom/at25.c:181:28: warning: field width should have type 'int',
> but argument has type 'unsigned long'
> 
> drivers/misc/eeprom/at25.c:386:13: warning: cast to smaller integer type 'int'
> from 'const void *'
> 
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/misc/eeprom/at25.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index 6e26de68a001..744f7abb22ee 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -178,7 +178,7 @@ static ssize_t sernum_show(struct device *dev, struct device_attribute *attr, ch
>  	struct at25_data *at25;
>  
>  	at25 = dev_get_drvdata(dev);
> -	return sysfs_emit(buf, "%*ph\n", sizeof(at25->sernum), at25->sernum);
> +	return sysfs_emit(buf, "%*ph\n", (int)sizeof(at25->sernum), at25->sernum);
>  }
>  static DEVICE_ATTR_RO(sernum);
>  
> @@ -379,11 +379,11 @@ static int at25_probe(struct spi_device *spi)
>  	u8 sernum[FM25_SN_LEN];
>  	int i;
>  	const struct of_device_id *match;
> -	int is_fram = 0;
> +	unsigned long is_fram = 0;
>  
>  	match = of_match_device(of_match_ptr(at25_of_match), &spi->dev);
>  	if (match)
> -		is_fram = (int)match->data;
> +		is_fram = (unsigned long)match->data;
>  
>  	/* Chip description */
>  	if (!spi->dev.platform_data) {
> -- 
> 2.25.1
> 

Looks good, now queued up.

greg k-h
