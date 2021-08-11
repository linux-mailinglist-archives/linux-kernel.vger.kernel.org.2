Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136DF3E9324
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbhHKN7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:59:39 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21386 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhHKN7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:59:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1628690347; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=WuCCI/rBZ8lWr4irii8zUWZ/ieQbpl22r1PPJcUhed74/0NYs6GyBwGAdIZhMcRFCEqH1t9Fqpj/zCUqDDpAyAhthzAkfwQpP7FiQ9YUhdFuaiPEWFzuUO7lbp2y72MtNczYsEY2TBh+IIv119sbv/f46i5fjZsvA0DVQKl03JY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1628690347; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ubSIKy+sSgzaqZS7QTljTFHq59xZvHdz22kUHhUcLOw=; 
        b=IaxZT30rB2Rk2y6sU6OTCz+96J1mdnVL3QFQo8B11pcMaYaCX0CaBODB2Va8gFlpfBx1nSKXm8/jJBCNbPoYZuCJ9Hh2OLvoZfVEvV6VCESVJInEyDG0TFYvwQE3owdtplqtGS+lQAfA8NSA2+fbTJY5X37xof4qLUcIrs5EYkg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1628690347;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=ubSIKy+sSgzaqZS7QTljTFHq59xZvHdz22kUHhUcLOw=;
        b=UkZlPPIiSLNX9ZNTu2Ec+isPz4t+sIg8xlYMHLpbAySl1P6iBIc0JNTLOi6vvcwP
        lFgOY3GQS16mWlmwuIFf5R/Jp7GqpYNjpvxKPSr5D0Ck5/SRbGVVLhmJrGHAMPml0pG
        Q4/KvDk8BSjs3KqolW3YhLzi9jaSM0yAsE8Bh5Ts=
Received: from anirudhrb.com (106.51.105.246 [106.51.105.246]) by mx.zohomail.com
        with SMTPS id 1628690342411673.202954929236; Wed, 11 Aug 2021 06:59:02 -0700 (PDT)
Date:   Wed, 11 Aug 2021 19:28:55 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, mail@anirudhrb.com
Subject: Re: [PATCH v2] usbip: give back URBs for unsent unlink requests
 during cleanup
Message-ID: <YRPXnzpyHETZ9bn2@anirudhrb.com>
References: <20210806181335.2078-1-mail@anirudhrb.com>
 <4aaf420d-e85e-212e-3bc4-a70e016de610@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aaf420d-e85e-212e-3bc4-a70e016de610@linuxfoundation.org>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 05:25:51PM -0600, Shuah Khan wrote:
> On 8/6/21 12:13 PM, Anirudh Rayabharam wrote:
> > In vhci_device_unlink_cleanup(), the URBs for unsent unlink requests are
> > not given back. This sometimes causes usb_kill_urb to wait indefinitely
> > for that urb to be given back. syzbot has reported a hung task issue [1]
> > for this.
> > 
> > To fix this, give back the urbs corresponding to unsent unlink requests
> > (unlink_tx list) similar to how urbs corresponding to unanswered unlink
> > requests (unlink_rx list) are given back. Since the code is almost the
> > same, extract it into a new function and call it for both unlink_rx and
> > unlink_tx lists.
> > 
> 
> Let's not do the refactor - let's first fix the problem and then the refactor.

Sure, I will make it a two patch series where the first one fixes the
problem and the second one does the refactor.

> 
> > [1]: https://syzkaller.appspot.com/bug?id=08f12df95ae7da69814e64eb5515d5a85ed06b76
> > 
> > Reported-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
> > Tested-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
> > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > ---
> > 
> > Changes in v2:
> > Use WARN_ON() instead of BUG() when unlink_list is neither unlink_tx nor
> > unlink_rx.
> > 
> > v1: https://lore.kernel.org/lkml/20210806164015.25263-1-mail@anirudhrb.com/
> > 
> > ---
> >   drivers/usb/usbip/vhci_hcd.c | 45 +++++++++++++++++++++++++-----------
> >   1 file changed, 32 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> > index 4ba6bcdaa8e9..67e638f4c455 100644
> > --- a/drivers/usb/usbip/vhci_hcd.c
> > +++ b/drivers/usb/usbip/vhci_hcd.c
> > @@ -945,7 +945,8 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
> >   	return 0;
> >   }
> > -static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
> > +static void __vhci_cleanup_unlink_list(struct vhci_device *vdev,
> > +		struct list_head *unlink_list)
> >   {
> >   	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
> >   	struct usb_hcd *hcd = vhci_hcd_to_hcd(vhci_hcd);
> > @@ -953,23 +954,23 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
> >   	struct vhci_unlink *unlink, *tmp;
> >   	unsigned long flags;
> > +	if (WARN(unlink_list != &vdev->unlink_tx
> > +				&& unlink_list != &vdev->unlink_rx,
> > +			"Invalid list passed to __vhci_cleanup_unlink_list\n"))
> > +		return;
> > +
> 
> With this change, this will be only place unlink_rx is used without
> vdev->priv_lock hold? Please explain why this is safe.

Well, this doesn't read or modify the contents of unlink_rx and unlink_tx.
So, it looks safe to me. Let me know if I'm missing something here.

> 
> >   	spin_lock_irqsave(&vhci->lock, flags);
> >   	spin_lock(&vdev->priv_lock);
> > -	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_tx, list) {
> > -		pr_info("unlink cleanup tx %lu\n", unlink->unlink_seqnum);
> > -		list_del(&unlink->list);
> > -		kfree(unlink);
> > -	}
> > -
> > -	while (!list_empty(&vdev->unlink_rx)) {
> > +	list_for_each_entry_safe(unlink, tmp, unlink_list, list) {
> >   		struct urb *urb;
> > -		unlink = list_first_entry(&vdev->unlink_rx, struct vhci_unlink,
> > -			list);
> > -
> > -		/* give back URB of unanswered unlink request */
> > -		pr_info("unlink cleanup rx %lu\n", unlink->unlink_seqnum);
> > +		if (unlink_list == &vdev->unlink_tx)
> > +			pr_info("unlink cleanup tx %lu\n",
> > +					unlink->unlink_seqnum);
> > +		else
> > +			pr_info("unlink cleanup rx %lu\n",
> > +					unlink->unlink_seqnum);
> >   		urb = pickup_urb_and_free_priv(vdev, unlink->unlink_seqnum);
> >   		if (!urb) {
> > @@ -1001,6 +1002,24 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
> >   	spin_unlock_irqrestore(&vhci->lock, flags);
> >   }
> > +static inline void vhci_cleanup_unlink_tx(struct vhci_device *vdev)
> > +{
> > +	__vhci_cleanup_unlink_list(vdev, &vdev->unlink_tx);
> 
> With this change, this will be only place unlink_rx is used without
> vdev->priv_lock hold? Please explain why this is safe.
> 
> > +}
> > +
> 
> Is there a need for this layer?
> 
> > +static inline void vhci_cleanup_unlink_rx(struct vhci_device *vdev)
> > +{
> > +	__vhci_cleanup_unlink_list(vdev, &vdev->unlink_rx);
> 
> With this change, this will be only place unlink_rx is used without
> vdev->priv_lock hold? Please explain why this is safe.
> 
> > +}
> > +
> Is there a need for this layer?

I added these wrappers purely for convenience. There is no other purpose.
Would you prefer this patch without the wrappers?

Thanks for the review!

	- Anirudh.
