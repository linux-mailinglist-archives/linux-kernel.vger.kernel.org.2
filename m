Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50E39DC99
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFGMik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhFGMih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:38:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97A1A60FE9;
        Mon,  7 Jun 2021 12:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623069406;
        bh=xPWkWt4mere88vFyYd89JcrZ0NlJFsjTPMJGauFmG8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZtXF2WWdKSpjotxx+538ES66yD20kxme3Jr4TCLfEslWhK3O4oxxucHzXv06PYEW1
         fvgCDdpOa6kbw8ZXxC1NeGzEcKiR7SBDNkWGxFLLh6T2Ehnhq3arv/0tPchUcn5BgX
         iWDfvca2tVOf5LTyNL4fYpZDnIkOsx1JDeYqvGSM=
Date:   Mon, 7 Jun 2021 14:36:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 4/5] nvmem: eeprom: at25: export FRAM serial num
Message-ID: <YL4S2/hlfRwRM+Ug@kroah.com>
References: <20210607122640.143582-1-jiri.prchal@aksignal.cz>
 <20210607122640.143582-5-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607122640.143582-5-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 02:26:39PM +0200, Jiri Prchal wrote:
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
> ---
>  drivers/misc/eeprom/at25.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index 3b7ffef1f0d7..a28dfd7e1798 100644
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
> @@ -172,6 +174,21 @@ static int fm25_aux_read(struct at25_data *at25, char *buf, uint8_t command,
>  	return status;
>  }
>  
> +static ssize_t sernum_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct at25_data *at25;
> +
> +	at25 = dev_get_drvdata(dev);
> +	return sysfs_emit(buf, "%016llx\n", *(unsigned long long *)at25->sernum);

That's a horrid hack, why not use the %*phN modifier?

Look in the printk-formats.rst file for help.

thanks,

greg k-h
