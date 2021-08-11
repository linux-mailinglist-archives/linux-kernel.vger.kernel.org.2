Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4E03E8F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbhHKLmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:42:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237352AbhHKLmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:42:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D82C60EB2;
        Wed, 11 Aug 2021 11:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628682142;
        bh=1Ty2De42TQlhkkrH54uVzC8gVy/9p3acvM3jsFQ6f44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ge7/YgEI2YBI5wdVCMFNxgOfPWBPOS2YSl2hwK0dM5jTw3jKK/1EwU2kuu764DMOi
         tPBCBxwKy9O6DhpdFBGdIc4LKW9PpYu947p/gwuNU2lBCNqdZB0gfOasj7l1yc/5UP
         uWfjpNjNI55E3z5Xlb71aeZfKnxhEaCzvxSZqZ8s=
Date:   Wed, 11 Aug 2021 13:42:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2,1/1] This aims to support Foxconn SDX55
Message-ID: <YRO3nDjt52EF1uVz@kroah.com>
References: <20210811085635.4699-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811085635.4699-1-slark_xiao@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 04:56:35PM +0800, Slark Xiao wrote:
> Foxconn SDX55 T77W175 device is working in PCIe mode normally.
> You can find it in drivers/bus/mhi/pci_geneirc.c file.
> But in some scenario, we need to capture the memory dump once it crashed.
> So a diag port driver is needed.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/usb/serial/qcserial.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
> index 83da8236e3c8..d8b58aea3c60 100644
> --- a/drivers/usb/serial/qcserial.c
> +++ b/drivers/usb/serial/qcserial.c
> @@ -111,6 +111,7 @@ static const struct usb_device_id id_table[] = {
>  	{USB_DEVICE(0x16d8, 0x8002)},	/* CMDTech Gobi 2000 Modem device (VU922) */
>  	{USB_DEVICE(0x05c6, 0x9204)},	/* Gobi 2000 QDL device */
>  	{USB_DEVICE(0x05c6, 0x9205)},	/* Gobi 2000 Modem device */
> +	{USB_DEVICE(0x05c6, 0x901d)},	/* Foxconn SDX55 QDL */

Why is this not sorted?

And the subject needs some work still...

thanks,

greg k-h
