Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33F63EB0DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 08:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbhHMG4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 02:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239095AbhHMGzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 02:55:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E034E60FC4;
        Fri, 13 Aug 2021 06:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628837728;
        bh=wC9KO+fAlbgCYi+D5FKUGu8oWyySC3HH67pt+slS538=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uu43ooe02x+C4gbtmWB0TUMYHwyDVgpIxqWCgWi1BTEulAEm2vwfkbLuXrDgDMf1T
         8Nm2sHvVv72T6QjepCIYufEj60Lyp1ntjh2K0zkQAQpoixZHbioWTK1CNz1M8IJDgs
         IIUYXPZA30dr3/OqQZw1NeG1lC+JUF8ojbBu46go=
Date:   Fri, 13 Aug 2021 08:55:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: give back URBs for unsent unlink requests during
 cleanup
Message-ID: <YRYXXbFyI1k9JBgR@kroah.com>
References: <20210806164015.25263-1-mail@anirudhrb.com>
 <YQ1nun3dwdd620TN@kroah.com>
 <YQ1uYSQ2T5kMrwfI@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQ1uYSQ2T5kMrwfI@anirudhrb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 10:46:17PM +0530, Anirudh Rayabharam wrote:
> On Fri, Aug 06, 2021 at 06:47:54PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Aug 06, 2021 at 10:10:14PM +0530, Anirudh Rayabharam wrote:
> > > In vhci_device_unlink_cleanup(), the URBs for unsent unlink requests are
> > > not given back. This sometimes causes usb_kill_urb to wait indefinitely
> > > for that urb to be given back. syzbot has reported a hung task issue [1]
> > > for this.
> > > 
> > > To fix this, give back the urbs corresponding to unsent unlink requests
> > > (unlink_tx list) similar to how urbs corresponding to unanswered unlink
> > > requests (unlink_rx list) are given back. Since the code is almost the
> > > same, extract it into a new function and call it for both unlink_rx and
> > > unlink_tx lists.
> > > 
> > > [1]: https://syzkaller.appspot.com/bug?id=08f12df95ae7da69814e64eb5515d5a85ed06b76
> > > 
> > > Reported-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
> > > Tested-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
> > > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > > ---
> > >  drivers/usb/usbip/vhci_hcd.c | 47 ++++++++++++++++++++++++++----------
> > >  1 file changed, 34 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> > > index 4ba6bcdaa8e9..45f98aa12895 100644
> > > --- a/drivers/usb/usbip/vhci_hcd.c
> > > +++ b/drivers/usb/usbip/vhci_hcd.c
> > > @@ -945,7 +945,8 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
> > >  	return 0;
> > >  }
> > >  
> > > -static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
> > > +static void __vhci_cleanup_unlink_list(struct vhci_device *vdev,
> > > +		struct list_head *unlink_list)
> > >  {
> > >  	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
> > >  	struct usb_hcd *hcd = vhci_hcd_to_hcd(vhci_hcd);
> > > @@ -953,23 +954,25 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
> > >  	struct vhci_unlink *unlink, *tmp;
> > >  	unsigned long flags;
> > >  
> > > +	if (unlink_list != &vdev->unlink_tx
> > > +			&& unlink_list != &vdev->unlink_rx) {
> > > +		pr_err("Invalid list passed to __vhci_cleanup_unlink_list\n");
> > > +		BUG();
> > 
> > Do not allow the system to crash, that is not ok.
> > 
> > > +		return;
> > 
> > This call makes no sense as you just rebooted the machine :(
> > 
> > Handle errors properly and recover from them and move on.  A single tiny
> > driver should not take down the whole system.
> 
> The execution can reach only if there is a developer error and they passed
> some random list in `unlink_list`.

Why would a developer do that?  As that is not the case in the kernel
tree, no need to check for it.

thanks,

greg k-h
