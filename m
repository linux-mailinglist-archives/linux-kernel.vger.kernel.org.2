Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C103E2ECE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 19:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240778AbhHFRQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 13:16:48 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21384 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhHFRQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 13:16:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1628270186; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=MGYtQv0N2P0s4WpiI/7SCa5cluFDHsRicj9t8o0lEPYl7ybY21fLcNmv/cZweNleSYwhzKSyFP3V31E0wivExUUng5HlsYr9xuxhWToOTVqAMxktDN5ihJRPzPU0l666KpLQTiSh6s/DFjgadI0EdMv0rc5w+9yCcN7w8VF7i9c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1628270186; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Mn1q6DOADEao/FpQAv/Cs8j4Ne3BhAG2jvQPfdsruQ0=; 
        b=UD3tLECcrs4Eqdk6YG5M4dzkAD7PI5J8Em3RX7qKPvXXgrg36xHXBaCAUuIUAhijs8CwO71gWcPjkqHkARxxUmOr5v2V1VXqtgtdByw65e2hGGvgpHILS4IhpX2VYfFlvDJyER8SG0Uh30YF/7/URKZUEaOiJmIvu3bgMO9VE4g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1628270186;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=Mn1q6DOADEao/FpQAv/Cs8j4Ne3BhAG2jvQPfdsruQ0=;
        b=wylVa7iXI5evEarzbIu/ZfcEs+YR148aez8XrDpaDfH4SI+OQDrCNc9HK6gXL4ws
        0fwofMCKNEgaaaCjwsNOtXbIjkp+eGuhkpcXbVZSF+oXf6m95aXUewQI+FFgMSLZ7Ju
        Ywb2N0xdQfUAoIN9+7GVHb/RWOJHn2oQpdEkits0=
Received: from anirudhrb.com (106.51.104.154 [106.51.104.154]) by mx.zohomail.com
        with SMTPS id 1628270183513352.4266722757876; Fri, 6 Aug 2021 10:16:23 -0700 (PDT)
Date:   Fri, 6 Aug 2021 22:46:17 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: give back URBs for unsent unlink requests during
 cleanup
Message-ID: <YQ1uYSQ2T5kMrwfI@anirudhrb.com>
References: <20210806164015.25263-1-mail@anirudhrb.com>
 <YQ1nun3dwdd620TN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQ1nun3dwdd620TN@kroah.com>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 06:47:54PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 06, 2021 at 10:10:14PM +0530, Anirudh Rayabharam wrote:
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
> > [1]: https://syzkaller.appspot.com/bug?id=08f12df95ae7da69814e64eb5515d5a85ed06b76
> > 
> > Reported-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
> > Tested-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
> > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > ---
> >  drivers/usb/usbip/vhci_hcd.c | 47 ++++++++++++++++++++++++++----------
> >  1 file changed, 34 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> > index 4ba6bcdaa8e9..45f98aa12895 100644
> > --- a/drivers/usb/usbip/vhci_hcd.c
> > +++ b/drivers/usb/usbip/vhci_hcd.c
> > @@ -945,7 +945,8 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
> >  	return 0;
> >  }
> >  
> > -static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
> > +static void __vhci_cleanup_unlink_list(struct vhci_device *vdev,
> > +		struct list_head *unlink_list)
> >  {
> >  	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
> >  	struct usb_hcd *hcd = vhci_hcd_to_hcd(vhci_hcd);
> > @@ -953,23 +954,25 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
> >  	struct vhci_unlink *unlink, *tmp;
> >  	unsigned long flags;
> >  
> > +	if (unlink_list != &vdev->unlink_tx
> > +			&& unlink_list != &vdev->unlink_rx) {
> > +		pr_err("Invalid list passed to __vhci_cleanup_unlink_list\n");
> > +		BUG();
> 
> Do not allow the system to crash, that is not ok.
> 
> > +		return;
> 
> This call makes no sense as you just rebooted the machine :(
> 
> Handle errors properly and recover from them and move on.  A single tiny
> driver should not take down the whole system.

The execution can reach only if there is a developer error and they passed
some random list in `unlink_list`. So, BUG() here crashes the kernel and
draws attention to this fact. Is WARN() a better option here? There is
no way to recover from this and continue with the rest of the function.
Either we WARN()/BUG() or we return silently.

Thanks!

	- Anirudh.
