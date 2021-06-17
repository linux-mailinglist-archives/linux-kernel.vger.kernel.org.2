Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B833AB9FC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 18:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhFQQzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 12:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229915AbhFQQzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:55:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D846B610A2;
        Thu, 17 Jun 2021 16:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623948777;
        bh=OOsFdi80wy5W6ivV1HCR4PBnh1VaW31ogvRDn0R+dro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C7ZND+T23mGAewGjh3QqBECJFT2uGHd79xpUFdN4wNLwc0St16pfOk3QyKveudEJ3
         ZQkpwwjEKNItQDJBxnA4SbkV0BAHShxhpkrh01tsKrbukLYci16TASr8SpYM65/BzL
         qwbkhwLS7ua5CyGPeKsHh70gpHOP0YfLhCY5jSu4=
Date:   Thu, 17 Jun 2021 18:52:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Fabien Chouteau <fabien.chouteau@barco.com>,
        Segiy Stetsyuk <serg_stetsuk@ukr.net>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH] usb: gadget: f_hid: fix endianness issue with descriptors
Message-ID: <YMt95iarFDUDvjQ8@kroah.com>
References: <20210617162755.29676-1-ruslan.bilovol@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617162755.29676-1-ruslan.bilovol@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 07:27:55PM +0300, Ruslan Bilovol wrote:
> Running sparse checker it shows warning message about
> incorrect endianness used for descriptor initialization:
> 
> | f_hid.c:91:43: warning: incorrect type in initializer (different base types)
> | f_hid.c:91:43:    expected restricted __le16 [usertype] bcdHID
> | f_hid.c:91:43:    got int
> 
> Fixing issue with cpu_to_le16() macro
> 
> Fixes: 71adf1189469 ("USB: gadget: add HID gadget driver")
> Cc: Fabien Chouteau <fabien.chouteau@barco.com>
> Cc: Segiy Stetsyuk <serg_stetsuk@ukr.net>
> Cc: stable@kernel.org
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
> ---
>  drivers/usb/gadget/function/f_hid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index 70774d8cb14e..02683ac0719d 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -88,7 +88,7 @@ static struct usb_interface_descriptor hidg_interface_desc = {
>  static struct hid_descriptor hidg_desc = {
>  	.bLength			= sizeof hidg_desc,
>  	.bDescriptorType		= HID_DT_HID,
> -	.bcdHID				= 0x0101,
> +	.bcdHID				= cpu_to_le16(0x0101),

This is a BCD value, not a little-endian value, are you sure this
conversion is correct?

thanks,

greg k-h
