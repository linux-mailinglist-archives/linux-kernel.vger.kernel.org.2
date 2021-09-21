Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC126413552
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhIUOae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233601AbhIUOaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:30:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A36B60FA0;
        Tue, 21 Sep 2021 14:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632234527;
        bh=QYMMJltkcZK3rnYmumC87Yj+YbVxjSFLRfFSl4eUxCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lW/3LNlEf1rPA6jEa0YtNMWDCtPLAR2HkWyI3XWrCO8uov2736CdlndLv4B7fOILh
         gomcgcTPq3zI5bn1d59K4y9i4oy8pMLGbuObdqlb0cQF7E40Q+YaHePgKlV6U3RITU
         kjyiGVij88Jk6/syR5ubylT3sQS0xvnGdTN56NQQ=
Date:   Tue, 21 Sep 2021 16:28:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: Updated MAX3421 to MAX3421E in Kconfig
Message-ID: <YUnsGZLTS6eBtQBz@kroah.com>
References: <20210915110937.17647-1-ramona.nechita@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915110937.17647-1-ramona.nechita@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 02:09:37PM +0300, Ramona Alexandra Nechita wrote:
> MAX3421 is supposed to be MAX3421E, Kconfig was modified
> accordingly.
> 
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> ---
>  drivers/usb/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 79b2e79dddd0..0ffa77163ae0 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -372,7 +372,7 @@ config USB_FOTG210_HCD
>  	  module will be called fotg210-hcd.
>  
>  config USB_MAX3421_HCD
> -	tristate "MAX3421 HCD (USB-over-SPI) support"
> +	tristate "MAX3421E HCD (USB-over-SPI) support"
>  	depends on USB && SPI
>  	---help---
>  	  The Maxim MAX3421E chip supports standard USB 2.0-compliant
> -- 
> 2.25.1
> 

Please use the latest version of the kernel to send patches against.
Can you please update your tree and resubmit this so that it can be
applied "cleanly"?

thanks,

greg k-h
