Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545893A8456
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhFOPuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhFOPuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:50:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B7136148E;
        Tue, 15 Jun 2021 15:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623772091;
        bh=0dr+xOxeQVMtzD8qXKJLgyftKOPEn+gUdjrEiokt9lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMjcVvJIV8PeQl0Zu9CGK/Vf/tdgZumtTLgzvPNKPXBSRzA3f3BtPyEW6aUYFIDIM
         39wpjGj1mpdzRTfhGChUc7+PixGWT8pl1YRErl6WuXudmn2kw5deaTkRKdQT7WUSki
         l6/xCuBizaI/1NvA55Q3YTo7cfBxks6l+TLJ4IPk=
Date:   Tue, 15 Jun 2021 17:48:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-kernel@vger.kernel.org,
        Huilong Deng <denghuilong@cdjrlc.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH 3/3] mcb: Remove trailing semicolon in macros
Message-ID: <YMjLuWRuRuMiIBjv@kroah.com>
References: <cover.1623768541.git.johannes.thumshirn@wdc.com>
 <fe520620eeddaa2ed8c669125f9b673c89d6b5a5.1623768541.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe520620eeddaa2ed8c669125f9b673c89d6b5a5.1623768541.git.johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:55:30PM +0900, Johannes Thumshirn wrote:
> From: Huilong Deng <denghuilong@cdjrlc.com>
> 
> Macros should not use a trailing semicolon.
> 
> Signed-off-by: Huilong Deng <denghuilong@cdjrlc.com>
> Signed-off-by: Johannes Thumshirn <jth@kernel.org>
> ---
>  include/linux/mcb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mcb.h b/include/linux/mcb.h
> index 71dd10a3d928..f6efb16f9d1b 100644
> --- a/include/linux/mcb.h
> +++ b/include/linux/mcb.h
> @@ -120,7 +120,7 @@ extern int __must_check __mcb_register_driver(struct mcb_driver *drv,
>  	__mcb_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
>  extern void mcb_unregister_driver(struct mcb_driver *driver);
>  #define module_mcb_driver(__mcb_driver)		\
> -	module_driver(__mcb_driver, mcb_register_driver, mcb_unregister_driver);
> +	module_driver(__mcb_driver, mcb_register_driver, mcb_unregister_driver)
>  extern void mcb_bus_add_devices(const struct mcb_bus *bus);
>  extern int mcb_device_register(struct mcb_bus *bus, struct mcb_device *dev);
>  extern struct mcb_bus *mcb_alloc_bus(struct device *carrier);
> -- 
> 2.31.1
> 

I've applied this one, feel free to resend the first 2 as emails.

thanks,

greg k-h
