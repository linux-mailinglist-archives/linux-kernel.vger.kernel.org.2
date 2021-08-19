Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679F03F1F92
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbhHSSKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:10:01 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21392 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhHSSJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:09:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1629396554; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=n/354dNALqKBgLHfZUCPYLu+VPP8obbVaXI81EDtB21ofHiK7NUAkf5hiXxLjJ1yu19uUmjU3U2+rwjVedYQZHlPty1ofW0CW7YVCPlctTQN9hTp3bhmNvpGI7cpz8jUd0D9ju4ACrH0SOAW7R35OkvEb1gBGhSeQM0Vduw2IiY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1629396554; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=YPLtqXA+DTLt44MP3qr0mCK0st3TStZXq1MMJsg68as=; 
        b=izvqCoIikdbf8Abz7KYycIAeexglz2tniEPips9ZGN62emqKj9zz95iMMBN6WbAxFX3hdqWVjyxPAsQoCZeHW9vSk4s4JruBvziEiZMS+doOzb4J/00eLlNCkq67QkyWJiyIK9XuXFk+Ae+w3QSp3Y12za+1Q9926No92wrh8DM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1629396554;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=YPLtqXA+DTLt44MP3qr0mCK0st3TStZXq1MMJsg68as=;
        b=xeqLA/0l2wyK/Am2Z9LRD6PHmsOhqGuIe8GLqGEBDx/rae6t/PmAICTaL3XtPNct
        ntPiXlCSSyyBrU/XI9dFchXkSmlBOl6AqxWxNcRsrLLCVYA067EzL9X6CNmC7vsODcf
        reGn8zIgBs7uJuN4z5wsT+GO++RTM0hf6OdmuLvo=
Received: from anirudhrb.com (106.51.110.226 [106.51.110.226]) by mx.zohomail.com
        with SMTPS id 1629396552779309.10712064166887; Thu, 19 Aug 2021 11:09:12 -0700 (PDT)
Date:   Thu, 19 Aug 2021 23:39:05 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, valentina.manea.m@gmail.com,
        shuah@kernel.org,
        syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] usbip: give back URBs for unsent unlink requests
 during cleanup
Message-ID: <YR6eQUpoe9cORXGu@anirudhrb.com>
References: <20210813182508.28127-1-mail@anirudhrb.com>
 <20210813182508.28127-2-mail@anirudhrb.com>
 <13450a85-bbfe-09c5-d614-1a944c2600c2@linuxfoundation.org>
 <YRydGRdPmOaiMWaY@kroah.com>
 <cb36604b-37f1-c12e-3ebb-cdafd7798dc1@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb36604b-37f1-c12e-3ebb-cdafd7798dc1@linuxfoundation.org>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 12:36:11PM -0600, Shuah Khan wrote:
> On 8/17/21 11:39 PM, Greg KH wrote:
> > On Tue, Aug 17, 2021 at 05:16:51PM -0600, Shuah Khan wrote:
> > > On 8/13/21 12:25 PM, Anirudh Rayabharam wrote:
> > > > In vhci_device_unlink_cleanup(), the URBs for unsent unlink requests are
> > > > not given back. This sometimes causes usb_kill_urb to wait indefinitely
> > > > for that urb to be given back. syzbot has reported a hung task issue [1]
> > > > for this.
> > > > 
> > > > To fix this, give back the urbs corresponding to unsent unlink requests
> > > > (unlink_tx list) similar to how urbs corresponding to unanswered unlink
> > > > requests (unlink_rx list) are given back.
> > > > 
> > > > [1]: https://syzkaller.appspot.com/bug?id=08f12df95ae7da69814e64eb5515d5a85ed06b76
> > > > 
> > > > Reported-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
> > > > Tested-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
> > > > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> > > > ---
> > > >    drivers/usb/usbip/vhci_hcd.c | 26 ++++++++++++++++++++++++++
> > > >    1 file changed, 26 insertions(+)
> > > > 
> > > > diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> > > > index 4ba6bcdaa8e9..6f3f374d4bbc 100644
> > > > --- a/drivers/usb/usbip/vhci_hcd.c
> > > > +++ b/drivers/usb/usbip/vhci_hcd.c
> > > > @@ -957,8 +957,34 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
> > > >    	spin_lock(&vdev->priv_lock);
> > > >    	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_tx, list) {
> > > > +		struct urb *urb;
> > > > +
> > > > +		/* give back URB of unsent unlink request */
> > > >    		pr_info("unlink cleanup tx %lu\n", unlink->unlink_seqnum);
> > > 
> > > I know this is an exiting one.
> > > Let's make this pr_debug or remove it all together.
> > > 
> > > > +
> > > > +		urb = pickup_urb_and_free_priv(vdev, unlink->unlink_seqnum);
> > > > +		if (!urb) {
> > > > +			pr_info("the urb (seqnum %lu) was already given back\n",
> > > > +				unlink->unlink_seqnum);
> > > 
> > > Let's make this pr_debug or remove it all together.
> > 
> > As you have a struct device for all of these, please use dev_dbg() and
> > friends, not pr_*(), for all of these.
> > 
> 
> Yes. Makes perfect sense.

Perhaps we should use usbip_dbg_vhci_hc() instead of dev_dbg()? It is
one of the custom macros defined by the usbip driver for printing debug
logs.

Thanks,

	Anirudh
