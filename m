Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFED38C655
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhEUMTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhEUMTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:19:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF09F6023D;
        Fri, 21 May 2021 12:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621599495;
        bh=WM4Ggn3IyN24WcF0E893y/fz+rxySe7sPcDUueU/jWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1ZKscW+6mSgTPeCF5zfPSbW89yvIXajsNmcfvSc48iBjEeDK5Kadxl/dVXROqQyx
         97qBGRRBRh/OQEE/0gUoLECwFz9Jz58nbUAGDserGDnxuzhzWJeDJZBhl1TVuWAJn7
         AKS2wxWhQRKJZ25Nzk2JiyWI8I337K1fE31u8NU4=
Date:   Fri, 21 May 2021 14:18:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        rkovhaev@gmail.com, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
Subject: Re: [PATCH] staging: rtl8712: Fix memory leak in r8712_init_recv_priv
Message-ID: <YKelBRkGsLFz4byw@kroah.com>
References: <20210521120811.516339-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521120811.516339-1-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 08:08:11PM +0800, Dongliang Mu wrote:
> r871xu_dev_remove failed to call r8712_free_drv_sw() and free the
> resource (e.g., struct urb) due to the failure of firmware loading.
> 
> Fix this by invoking r8712_free_drv_sw at the failure site.
> 
> Reported-by: syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
> Fixes: b4383c971bc5 ("staging: rtl8712: handle firmware load failure")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/staging/rtl8712/usb_intf.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
> index dc21e7743349..a5190b4250ce 100644
> --- a/drivers/staging/rtl8712/usb_intf.c
> +++ b/drivers/staging/rtl8712/usb_intf.c
> @@ -589,7 +589,7 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
>   */
>  static void r871xu_dev_remove(struct usb_interface *pusb_intf)
>  {
> -	struct net_device *pnetdev = usb_get_intfdata(pusb_intf);
> +	struct net_device *pnetdev, *newpnetdev = usb_get_intfdata(pusb_intf);
>  	struct usb_device *udev = interface_to_usbdev(pusb_intf);
>  
>  	if (pnetdev) {

Did you test this?

I think you just broke the code right here :(

thanks,

greg k-h
