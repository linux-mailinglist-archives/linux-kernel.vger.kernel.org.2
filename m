Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14243EFA3F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 07:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbhHRFkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 01:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238103AbhHRFkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 01:40:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13E0161029;
        Wed, 18 Aug 2021 05:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629265181;
        bh=EtIBL4nck6yS3y+rq79pT9mCLC3bvjYO+hQnPLk5ThE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S60Z4BDzLUbMnBdGBVbSnwufET+iJ+kHOPHNmlS04Qy7kLoYhoYJETBuvVh454+rm
         s59j4s8IFK7gcIoexdKrq8Qj0jtRu+T2ZB7nt1OH+Iy7JbU2h7ubByiYYFZ/krBbQs
         djRx51fhdmXLeZ1/fYVa5PfoawGeuoIFEpaYB9N4=
Date:   Wed, 18 Aug 2021 07:39:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        valentina.manea.m@gmail.com, shuah@kernel.org,
        syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] usbip: give back URBs for unsent unlink requests
 during cleanup
Message-ID: <YRydGRdPmOaiMWaY@kroah.com>
References: <20210813182508.28127-1-mail@anirudhrb.com>
 <20210813182508.28127-2-mail@anirudhrb.com>
 <13450a85-bbfe-09c5-d614-1a944c2600c2@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13450a85-bbfe-09c5-d614-1a944c2600c2@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 05:16:51PM -0600, Shuah Khan wrote:
> On 8/13/21 12:25 PM, Anirudh Rayabharam wrote:
> > In vhci_device_unlink_cleanup(), the URBs for unsent unlink requests are
> > not given back. This sometimes causes usb_kill_urb to wait indefinitely
> > for that urb to be given back. syzbot has reported a hung task issue [1]
> > for this.
> > 
> > To fix this, give back the urbs corresponding to unsent unlink requests
> > (unlink_tx list) similar to how urbs corresponding to unanswered unlink
> > requests (unlink_rx list) are given back.
> > 
> > [1]: https://syzkaller.appspot.com/bug?id=08f12df95ae7da69814e64eb5515d5a85ed06b76
> > 
> > Reported-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
> > Tested-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
> > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > ---
> >   drivers/usb/usbip/vhci_hcd.c | 26 ++++++++++++++++++++++++++
> >   1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> > index 4ba6bcdaa8e9..6f3f374d4bbc 100644
> > --- a/drivers/usb/usbip/vhci_hcd.c
> > +++ b/drivers/usb/usbip/vhci_hcd.c
> > @@ -957,8 +957,34 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
> >   	spin_lock(&vdev->priv_lock);
> >   	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_tx, list) {
> > +		struct urb *urb;
> > +
> > +		/* give back URB of unsent unlink request */
> >   		pr_info("unlink cleanup tx %lu\n", unlink->unlink_seqnum);
> 
> I know this is an exiting one.
> Let's make this pr_debug or remove it all together.
> 
> > +
> > +		urb = pickup_urb_and_free_priv(vdev, unlink->unlink_seqnum);
> > +		if (!urb) {
> > +			pr_info("the urb (seqnum %lu) was already given back\n",
> > +				unlink->unlink_seqnum);
> 
> Let's make this pr_debug or remove it all together.

As you have a struct device for all of these, please use dev_dbg() and
friends, not pr_*(), for all of these.

thanks,

greg k-h
