Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AC138945F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355546AbhESRGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355533AbhESRGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:06:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 958606135C;
        Wed, 19 May 2021 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621443902;
        bh=KZkatEWHNgDQmypNgplFv9MtW4qUK0g4FyeIaZCQm3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RS6efuo8dZekbDkEG0UuscmqEykW9Ctr4htA69StyeXcvwZ3ZoQizHn6rp6rzehzM
         DRWa+vYD8Gr8dvOBQRJ+KG+aJH5TRq7b9CjantJEecLW1PxljJzSeuq6sF4kxZP6p2
         2LBE1a4px4yIo4wCk6D7ZRdzJRsC3QattigxOrzw=
Date:   Wed, 19 May 2021 19:04:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sysfs: Add helper BIN_ATTRIBUTE_GROUPS
Message-ID: <YKVFO4bmW/hkoUnx@kroah.com>
References: <66e9f6e5-fdee-6963-6131-228c69705350@gmail.com>
 <e20db248-ed30-cf5d-a37c-b538dceaa5b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e20db248-ed30-cf5d-a37c-b538dceaa5b2@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 06:33:14PM +0200, Heiner Kallweit wrote:
> New helper BIN_ATTRIBUTE_GROUPS() does the same as ATTRIBUTE_GROUPS(),
> just for binary attributes.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  include/linux/sysfs.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index d76a1ddf8..a12556a4b 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -162,6 +162,12 @@ static const struct attribute_group _name##_group = {		\
>  };								\
>  __ATTRIBUTE_GROUPS(_name)
>  
> +#define BIN_ATTRIBUTE_GROUPS(_name)				\
> +static const struct attribute_group _name##_group = {		\
> +	.bin_attrs = _name##_attrs,				\
> +};								\
> +__ATTRIBUTE_GROUPS(_name)

Is this really needed by more than just 1 driver?

How about just "open code" this for now, binary sysfs files are rare.

thanks,

greg k-h
