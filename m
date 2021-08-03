Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE723DE617
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 07:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhHCFQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 01:16:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhHCFQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 01:16:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A2F96023F;
        Tue,  3 Aug 2021 05:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627967774;
        bh=BD3EfVSm5ZmZYCUw/owaWZws+ZrwBusi9GEntH+libY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UFClKNbEqUL85oHwHn4xjatoR4E5iYO4AuqK231Pcn41tJtZ+mdm7ik9BfaNHFIey
         lZJfe/pbwnpYRWxeMg+BVJQDNcKSpBG0xKTOhr8JOhwdpnW1VO17dl8McybJh3WkBN
         uiwMJ7bkXSk7f27vFyNnqzQsz+qXdNfda93c+zdA=
Date:   Tue, 3 Aug 2021 07:16:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: get lock before calling
 usb_[disable|enable]_autosuspend()
Message-ID: <YQjRHLpJtvdavYjj@kroah.com>
References: <20210802223703.GA1425480@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802223703.GA1425480@pc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 11:37:03PM +0100, Salah Triki wrote:
> Based on the documentation of usb_[disable|enable]_autosuspend(), the
> caller must hold udev's device lock.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/staging/gdm724x/gdm_usb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
> index 54bdb64f52e8..31b3b3e563c8 100644
> --- a/drivers/staging/gdm724x/gdm_usb.c
> +++ b/drivers/staging/gdm724x/gdm_usb.c
> @@ -846,7 +846,9 @@ static int gdm_usb_probe(struct usb_interface *intf,
>  	udev->intf = intf;
>  
>  	intf->needs_remote_wakeup = 1;
> +	usb_lock_device(usbdev);
>  	usb_enable_autosuspend(usbdev);
> +	usb_unlock_device(usbdev);
>  	pm_runtime_set_autosuspend_delay(&usbdev->dev, AUTO_SUSPEND_TIMER);
>  
>  	/* List up hosts with big endians, otherwise,
> -- 
> 2.25.1

Please look at the other places where this function is called and note
that the pattern you have added here is not used in those situations
either, so perhaps this change is not correct at all.

thanks,

greg k-h
