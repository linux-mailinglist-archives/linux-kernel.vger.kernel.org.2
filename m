Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314D7357D49
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhDHH0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:26:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhDHH0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:26:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B96261057;
        Thu,  8 Apr 2021 07:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617866771;
        bh=FkccS7u81T140XGv+zsj6P+7Au5FReyCyBe+7GemLP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w8zLkNgt8/LePucgzTgO+trAK1xmPwAdW7zk1MERcwHvBcYZ/23XdZPlPVakVae+v
         LVc1UKuyWTuQtbSdzpaGRFR33e3SWWRyzEIou+oqj52XGepkAuNdSt2K8wm+LO/tB4
         olKy5n6gmyTyJ9b/t6lv2itVLJ/OKl1qT4CEkDyM=
Date:   Thu, 8 Apr 2021 09:26:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] staging: rtl8188eu: remove unused macros
Message-ID: <YG6wEDs2ZVPAOeUZ@kroah.com>
References: <20210407170531.29356-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407170531.29356-1-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 07:05:22PM +0200, Martin Kaiser wrote:
> usb_ops_linux.h contains a couple of macros to make functions usable as
> urb completion callbacks. Most of them are unused and can be removed.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/rtl8188eu/include/usb_ops_linux.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/include/usb_ops_linux.h b/drivers/staging/rtl8188eu/include/usb_ops_linux.h
> index 4e0e48cb5c8e..1a0b38de5027 100644
> --- a/drivers/staging/rtl8188eu/include/usb_ops_linux.h
> +++ b/drivers/staging/rtl8188eu/include/usb_ops_linux.h
> @@ -23,18 +23,10 @@
>  #define USB_HIGH_SPEED_BULK_SIZE	512
>  #define USB_FULL_SPEED_BULK_SIZE	64
>  
> -#define _usbctrl_vendorreq_async_callback(urb, regs)	\
> -	_usbctrl_vendorreq_async_callback(urb)
> -#define usb_bulkout_zero_complete(purb, regs)		\
> -	usb_bulkout_zero_complete(purb)
> -#define usb_write_mem_complete(purb, regs)		\
> -	usb_write_mem_complete(purb)
>  #define usb_write_port_complete(purb, regs)		\
>  	usb_write_port_complete(purb)
>  #define usb_read_port_complete(purb, regs)		\
>  	usb_read_port_complete(purb)
> -#define usb_read_interrupt_complete(purb, regs)		\
> -	usb_read_interrupt_complete(purb)

Wow, that's there for a really old kernel version and should not be
needed anymore at all.  I'll take this, but please remove the other ones
here, they are not necessary.

thanks,

greg k-h
