Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8380B3808E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhENLvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:51:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:32784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhENLvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:51:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C8C361408;
        Fri, 14 May 2021 11:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620993002;
        bh=agN8USl6C0iQcigeQTMmrOK5X5NceXqaAkt80DJ+tvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QBbclD2lObdWCvRXCprTdisj9Hw029DaTalyF7o2T+3pfBoNIlgMuHqU49E+DryMC
         T68+fvXqXNGUxf1WvI001Q+sI7OAr5EhbuXWykm1DhOcyIIBNRyXa1seef1QsS0Ghv
         oRGxHricxrRk/zCcZwLE/RZCEsz4CVQgRUX6Vnns=
Date:   Fri, 14 May 2021 13:50:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moriis Ku <saumah@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8250: Add SUNIX SDC series uart driver
Message-ID: <YJ5j6DKJdAVrWUvV@kroah.com>
References: <20210514113908.5121-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514113908.5121-1-saumah@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 07:39:08PM +0800, Moriis Ku wrote:
> From: Morris Ku <saumah@gmail.com>
> 
> Add SUNIX SDC series uart driver
> 
> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  Kconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Kconfig b/Kconfig
> index 7ef60f8..3a68ef4 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -217,6 +217,12 @@ config SERIAL_8250_MANY_PORTS
>  	  say N here to save some memory. You can also say Y if you have an
>  	  "intelligent" multiport card such as Cyclades, Digiboards, etc.
>  
> +config SERIAL_8250_SDC
> +	tristate "SUNIX SDC serial port support"
> +	depends on SERIAL_8250 && MFD_SUNIX_SDC
> +	help
> +	  Support for SUNIX SDC serial port.
> +
>  #
>  # Multi-port serial cards
>  #
> -- 
> 2.20.1
> 

I think you forgot the rest of the patch :(

Also please make your patches at the "root" of the kernel tree, this is
in the wrong location.

thanks,

greg k-h
