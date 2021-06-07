Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190D039DC95
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhFGMhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:37:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230261AbhFGMhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:37:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37CF0610E7;
        Mon,  7 Jun 2021 12:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623069309;
        bh=ADMsq/ShJ2O26kMrdnlG5EUnw1/xmIU1TQQpDXI2K+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfxIsh3Zx8OT3XTTJyR4YIHl63c6LZAeKPvY/Cw/b39CYF9Sh8q3c9hIjB2vVKRwh
         iVKsTEPVjR7OcgjskYe9dir0IDLlK5zC1BOteKv/3bVXrerJvDpmRh7JMo8Bb4vek5
         VEhEBWJpbvnXx7VxM2YRarpykkpr0Or+izj56cvY=
Date:   Mon, 7 Jun 2021 14:35:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 1/5] nvmem: eeprom: at25: prepare basics for FRAM
 support
Message-ID: <YL4Se3bQfnBYV8yN@kroah.com>
References: <20210607122640.143582-1-jiri.prchal@aksignal.cz>
 <20210607122640.143582-2-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607122640.143582-2-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 02:26:36PM +0200, Jiri Prchal wrote:
> Added enum and string for FRAM to expose it as "fram".
> 
> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
> v2: no change here
> v3: resend and added more recipients
> v4: resend
> v5: no change here
> v6: changed commit subject
> v7: no change here
> ---
>  drivers/nvmem/core.c           | 4 ++++
>  include/linux/nvmem-provider.h | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 177f5bf27c6d..01ef9a934b0a 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -180,6 +180,7 @@ static const char * const nvmem_type_str[] = {
>  	[NVMEM_TYPE_EEPROM] = "EEPROM",
>  	[NVMEM_TYPE_OTP] = "OTP",
>  	[NVMEM_TYPE_BATTERY_BACKED] = "Battery backed",
> +	[NVMEM_TYPE_FRAM] = "FRAM",
>  };
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> @@ -359,6 +360,9 @@ static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
>  	if (!config->base_dev)
>  		return -EINVAL;
>  
> +	if (config->type == NVMEM_TYPE_FRAM)
> +		bin_attr_nvmem_eeprom_compat.attr.name = "fram";
> +

As this is a new sysfs file, where is the documentation for it?

thanks,

greg k-h
