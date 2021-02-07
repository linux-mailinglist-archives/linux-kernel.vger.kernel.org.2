Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A928D3122C6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 09:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBGIds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 03:33:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhBGIcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 03:32:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3B6E64E30;
        Sun,  7 Feb 2021 08:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612686681;
        bh=M3PH+chd17Y34z36kJqmIdtJdfNBKaFZ1Kv4CHgD2OI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQ/u0DT4rWsmpteZpoewVkCesHjCd3R7GTGmWbIpaVsUTCd2HPsCOrGrZL6pLlFGr
         yr1p38UgU/KZXR0SmWJE1AD0as9nREMIMEyaZqODbi8TI3yRrBxprOHQEMMJvgiV3H
         zRbM0NUgrRnh2EBJ/HZSYrNecpn03Llk1fZaR+Zs=
Date:   Sun, 7 Feb 2021 09:31:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] staging: emxx_udc: Fix incorrectly defined global
Message-ID: <YB+lVey4DAXxEPmF@kroah.com>
References: <20210207000030.256592-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207000030.256592-1-memxor@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 05:30:31AM +0530, Kumar Kartikeya Dwivedi wrote:
> The global gpio_desc pointer and int were defined in the header,
> instead put the definitions in the translation unit and add an extern
> declaration for consumers of the header (currently only one, which is
> perhaps why the linker didn't complain about symbol collisions).
> 
> This fixes sparse related warnings for this driver:
> drivers/staging/emxx_udc/emxx_udc.c: note: in included file:
> drivers/staging/emxx_udc/emxx_udc.h:23:18: warning: symbol 'vbus_gpio' was not declared. Should it be static?
> drivers/staging/emxx_udc/emxx_udc.h:24:5: warning: symbol 'vbus_irq' was not declared. Should it be static?
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  drivers/staging/emxx_udc/emxx_udc.c | 3 +++
>  drivers/staging/emxx_udc/emxx_udc.h | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
> index a30b4f5b1..6983c3e31 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -34,6 +34,9 @@
>  #define	DRIVER_DESC	"EMXX UDC driver"
>  #define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
>  
> +struct gpio_desc *vbus_gpio;
> +int vbus_irq;

A tiny driver can not create global variables with generic names like
this, sorry.  That will polute the global namespace.

thanks,

greg k-h
