Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E200838CB7E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbhEURDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233990AbhEURDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:03:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84F83613D9;
        Fri, 21 May 2021 17:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621616529;
        bh=MA5it5WuPvv7lr+0xWzw4mBcIXDCBxAbqbu3dFK6ic4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LUE6CqOcWpxb9OrMW4GI+CXHksdKOMwEIUSE3URi7Nw+T0BZNlxmWiJIQF/slz93F
         N8pFwrm27lEI3DjpVyx73IqDmlBB0cPVzxiTa1XkrD2bHnhg0DkOVm85eYNPeFNBur
         xMqzzlji+XJe9ANMK53hlBZ0bj8eMm2ibmv3ZjB8=
Date:   Fri, 21 May 2021 19:02:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        rkovhaev@gmail.com, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] staging: rtl8712: Fix memory leak in
 r8712_init_recv_priv
Message-ID: <YKfnjYAsNzbfJh1d@kroah.com>
References: <20210521162519.677074-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521162519.677074-1-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 12:25:19AM +0800, Dongliang Mu wrote:
> r871xu_dev_remove failed to call r8712_free_drv_sw() and free the
> resource (e.g., struct urb) due to the failure of firmware loading.
> 
> Fix this by invoking r8712_free_drv_sw at the failure site.
> 
> Reported-by: syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
> Fixes: b4383c971bc5 ("staging: rtl8712: handle firmware load failure")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
> v1->v2: fix the initialization of pnetdev
> 
>  drivers/staging/rtl8712/usb_intf.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
> index dc21e7743349..57e773464e18 100644
> --- a/drivers/staging/rtl8712/usb_intf.c
> +++ b/drivers/staging/rtl8712/usb_intf.c
> @@ -593,13 +593,14 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
>  	struct usb_device *udev = interface_to_usbdev(pusb_intf);
>  
>  	if (pnetdev) {
> +		struct net_device *newpnetdev = NULL;
>  		struct _adapter *padapter = netdev_priv(pnetdev);
>  
>  		/* never exit with a firmware callback pending */
>  		wait_for_completion(&padapter->rtl8712_fw_ready);
> -		pnetdev = usb_get_intfdata(pusb_intf);
> +		newpnetdev = usb_get_intfdata(pusb_intf);

Please learn a bit more C knowledge before messing around in the kernel
tree.  Between the mistake in this chunk you added, and the mistake in
the previous submission, I think you need more experience here as there
are some things you still need to learn.

Best of luck!

greg k-h
