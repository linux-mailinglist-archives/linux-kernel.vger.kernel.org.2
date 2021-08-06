Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9323E2E81
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 18:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbhHFQsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 12:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235319AbhHFQsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 12:48:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1410D61163;
        Fri,  6 Aug 2021 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628268478;
        bh=pDK0bkXKmVreCJ5VsYO8Jcq4mOV4T4XgB6OpvbG+IDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tDgBevHwAVItkmlQn2fF9OPUCIIuu03MsLLjRYl8BmJn1VDWySQZGHOIXkyUyZ6Nh
         jqAzPtCjR2nY0fT6YzlOOwYahnLBALGtR+pkUiwJu+5yGOboSa0464KBHIZqXL/KOL
         8fDlk6umALau3ftWKi+4CjqaLpc0ZsZlSGj+Zrmg=
Date:   Fri, 6 Aug 2021 18:47:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: give back URBs for unsent unlink requests during
 cleanup
Message-ID: <YQ1nun3dwdd620TN@kroah.com>
References: <20210806164015.25263-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806164015.25263-1-mail@anirudhrb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 10:10:14PM +0530, Anirudh Rayabharam wrote:
> In vhci_device_unlink_cleanup(), the URBs for unsent unlink requests are
> not given back. This sometimes causes usb_kill_urb to wait indefinitely
> for that urb to be given back. syzbot has reported a hung task issue [1]
> for this.
> 
> To fix this, give back the urbs corresponding to unsent unlink requests
> (unlink_tx list) similar to how urbs corresponding to unanswered unlink
> requests (unlink_rx list) are given back. Since the code is almost the
> same, extract it into a new function and call it for both unlink_rx and
> unlink_tx lists.
> 
> [1]: https://syzkaller.appspot.com/bug?id=08f12df95ae7da69814e64eb5515d5a85ed06b76
> 
> Reported-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
> Tested-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
>  drivers/usb/usbip/vhci_hcd.c | 47 ++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 4ba6bcdaa8e9..45f98aa12895 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -945,7 +945,8 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
>  	return 0;
>  }
>  
> -static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
> +static void __vhci_cleanup_unlink_list(struct vhci_device *vdev,
> +		struct list_head *unlink_list)
>  {
>  	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
>  	struct usb_hcd *hcd = vhci_hcd_to_hcd(vhci_hcd);
> @@ -953,23 +954,25 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
>  	struct vhci_unlink *unlink, *tmp;
>  	unsigned long flags;
>  
> +	if (unlink_list != &vdev->unlink_tx
> +			&& unlink_list != &vdev->unlink_rx) {
> +		pr_err("Invalid list passed to __vhci_cleanup_unlink_list\n");
> +		BUG();

Do not allow the system to crash, that is not ok.

> +		return;

This call makes no sense as you just rebooted the machine :(

Handle errors properly and recover from them and move on.  A single tiny
driver should not take down the whole system.

thanks,

greg k-h
