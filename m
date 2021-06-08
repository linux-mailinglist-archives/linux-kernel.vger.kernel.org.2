Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A69C39F1A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFHJHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:07:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229724AbhFHJHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:07:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 761C36124B;
        Tue,  8 Jun 2021 09:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623143146;
        bh=qTLFXeqFTMC+AXvxK2jkQktlzwzO8S271xo8RvSBd44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U8Phe36hy13YdvwPYhMAtfYJZsSqatajV0+aUtplf7XrwnkXoHxeFgg1dsBgFwldV
         eJWakTFROH/tGg0O1JsYEKD5RW1yuebZMIMk/iYtpiwSeia+XbQxVGvMg3RW082DvC
         WMYfUbrjrZceiys9VLAaySqdDX6zFPqcbSFefE4c=
Date:   Tue, 8 Jun 2021 11:05:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 4/5] nvmem: eeprom: at25: export FRAM serial num
Message-ID: <YL8y58QAtH8HbC1p@kroah.com>
References: <20210607161201.223697-1-jiri.prchal@aksignal.cz>
 <20210607161201.223697-5-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607161201.223697-5-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 06:12:00PM +0200, Jiri Prchal wrote:
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
> v7: moved FM25_SN_LEN, static array, used sysfs_emit, DEVICE_ATTR_RO
> v8: clarify sysfs_emit format
> ---
>  drivers/misc/eeprom/at25.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index e25cec7c474b..4a47a7e2d90d 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -31,6 +31,7 @@
>   *   AT25M02, AT25128B
>   */
>  
> +#define	FM25_SN_LEN	8		/* serial number length */
>  struct at25_data {
>  	struct spi_device	*spi;
>  	struct mutex		lock;
> @@ -39,6 +40,7 @@ struct at25_data {
>  	struct nvmem_config	nvmem_config;
>  	struct nvmem_device	*nvmem;
>  	int has_sernum;
> +	u8 sernum[FM25_SN_LEN];
>  };
>  
>  #define	AT25_WREN	0x06		/* latch the write enable */
> @@ -172,6 +174,21 @@ static int fm25_aux_read(struct at25_data *at25, u8 *buf, uint8_t command,
>  	return status;
>  }
>  
> +static ssize_t sernum_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct at25_data *at25;
> +
> +	at25 = dev_get_drvdata(dev);
> +	return sysfs_emit(buf, "%*phN\n", sizeof at25->sernum, at25->sernum);

sizeof(at25->sernum) is the normal way to write this.

thanks,

greg k-h
