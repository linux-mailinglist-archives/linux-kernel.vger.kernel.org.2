Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D901936196A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbhDPFlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:41:22 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21345 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhDPFlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:41:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1618551645; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ZeoBQETUSOqu2U6vnlj74+undnITnJ3L2EEsmkTHvybJBvBOYDv9tl2OjjC3CUMTR5R3VAANBCj5uPK6wvG2a1TnGwbiLBNg5k0QZroG2bSWDgNnS8m2am2LOG5DtC/ITcvSXfZqr9q+8xW/VP2Xi/D9q6PFWMgYqDbrdewimew=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1618551645; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=fvDfttZM4KjoqywY1vxhQFEBQkz4bYXvnPMQ5kjViCQ=; 
        b=aMEtqKpqImS0tWAwX/bWxlMfna+3TnQVZ0ONci3vDQgbdgNWGtZlyluwMKwqDfh2vp+x2sbYaZOaKc8lbKVvP+tO29l+ZgMOzAfE8AEVW6XF9D6O9LuhmZ6jQIEznC8EPSX8aFW8kXlt5H3zpXel4gJigHK/8Xbq9tIibNKIqzE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1618551645;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
        bh=fvDfttZM4KjoqywY1vxhQFEBQkz4bYXvnPMQ5kjViCQ=;
        b=oQuifcfEErLjhdioPKJp+y2VEaaML8w6UtdEqFF798F23ZQjyIm7yj+PTq58fDy0
        4mkrR++nEniubrt2wu1NX81s9sehhFXaGbas17pEzuKPXpQ2F6D+aktvSYlk35C9DOL
        pC2NaureWa41qDjKm1LKEKSrcMJhp+/Q6xUDSVcA=
Received: from anirudhrb.com (49.207.216.151 [49.207.216.151]) by mx.zohomail.com
        with SMTPS id 1618551642390440.0500003984672; Thu, 15 Apr 2021 22:40:42 -0700 (PDT)
Date:   Fri, 16 Apr 2021 11:10:35 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+eb4674092e6cc8d9e0bd@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] general protection fault in gadget_setup
Message-ID: <YHkjUwhlCYIxCUYt@anirudhrb.com>
References: <00000000000075c58405bfd6228c@google.com>
 <CACT4Y+bTjQz=RBXVNrVMQ9xPz5CzGNBE854fsb0ukS-2_wdi3Q@mail.gmail.com>
 <20210413161311.GC1454681@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210413161311.GC1454681@rowland.harvard.edu>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 12:13:11PM -0400, Alan Stern wrote:
> On Tue, Apr 13, 2021 at 10:12:05AM +0200, Dmitry Vyukov wrote:
> > On Tue, Apr 13, 2021 at 10:08 AM syzbot
> > <syzbot+eb4674092e6cc8d9e0bd@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    0f4498ce Merge tag 'for-5.12/dm-fixes-2' of git://git=
=2Ekern..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D124adbf6d=
00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Ddaeff30c2=
474a60f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Deb4674092e6=
cc8d9e0bd
> > > userspace arch: i386
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+eb4674092e6cc8d9e0bd@syzkaller.appspotmail.com
> >=20
> > I suspect that the raw gadget_unbind() can be called while the timer
> > is still active. gadget_unbind() sets gadget data to NULL.
> > But I am not sure which unbind call this is:
> > usb_gadget_remove_driver() or right in udc_bind_to_driver() due to a
> > start error.
>=20
> This certainly looks like a race between gadget_unbind and gadget_setup=
=20
> in raw_gadget.
>=20
> In theory, this race shouldn't matter.  The gadget core is supposed to=20
> guarantee that there won't be any more callbacks to the gadget driver=20
> once the driver's unbind routine is called.  That guarantee is enforced=
=20
> in usb_gadget_remove_driver as follows:
>=20
> 	usb_gadget_disconnect(udc->gadget);
> 	if (udc->gadget->irq)
> 		synchronize_irq(udc->gadget->irq);
> 	udc->driver->unbind(udc->gadget);
> 	usb_gadget_udc_stop(udc);
>=20
> usb_gadget_disconnect turns off the pullup resistor, telling the host=20
> that the gadget is no longer connected and preventing the transmission=20
> of any more USB packets.  Any packets that have already been received=20
> are sure to processed by the UDC driver's interrupt handler by the time=
=20
> synchronize_irq returns.
>=20
> But this doesn't work with dummy_hcd, because dummy_hcd doesn't use=20
> interrupts; it uses a timer instead.  It does have code to emulate the=20
> effect of synchronize_irq, but that code doesn't get invoked at the=20
> right time -- it currently runs in usb_gadget_udc_stop, after the unbind=
=20
> callback instead of before.  Indeed, there's no way for=20
> usb_gadget_remove_driver to invoke this code before the unbind=20
> callback,.
>=20
> I thought the synchronize_irq emulation problem had been completely=20
> solved, but evidently it hasn't.  It looks like the best solution is to=
=20
> add a call of the synchronize_irq emulation code in dummy_pullup.
>=20
> Maybe we can test this reasoning by putting a delay just before the call=
=20
> to dum->driver->setup.  That runs in the timer handler, so it's not a=20
> good place to delay, but it may be okay just for testing purposes.
>=20
> Hopefully this patch will make the race a lot more likely to occur.  Is=
=20

Hi Alan,=20

Indeed, I was able to reproduce this bug easily on my machine with your
delay patch applied and using this syzkaller program:

syz_usb_connect$cdc_ncm(0x1, 0x6e, &(0x7f0000000040)=3D{{0x12, 0x1, 0x0, 0x=
2, 0x0, 0x0, 0x8, 0x525, 0xa4a1, 0x40, 0x1, 0x2, 0x3, 0x1, [{{0x9, 0x2, 0x5=
c, 0x2, 0x1, 0x0, 0x0, 0x0, {{0x9, 0x4, 0x0, 0x0, 0x1, 0x2, 0xd, 0x0, 0x0, =
{{0x5}, {0x5}, {0xd}, {0x6}}, {{0x9, 0x5, 0x81, 0x3, 0x200}}}}}}]}}, &(0x7f=
0000000480)=3D{0x0, 0x0, 0x0, 0x0, 0x3, [{0x0, 0x0}, {0x0, 0x0}, {0x0, 0x0}=
]})

I also tested doing the synchronize_irq emulation in dummy_pullup and it
fixed the issue. The patch is below.

Thanks!

	- Anirudh.

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/du=
mmy_hcd.c
index ce24d4f28f2a..931d4612d859 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -903,6 +903,12 @@ static int dummy_pullup(struct usb_gadget *_gadget, in=
t value)
 	spin_lock_irqsave(&dum->lock, flags);
 	dum->pullup =3D (value !=3D 0);
 	set_link_state(dum_hcd);
+	/* emulate synchronize_irq(): wait for callbacks to finish */=1C
+	while (dum->callback_usage > 0) {
+		spin_unlock_irqrestore(&dum->lock, flags);
+		usleep_range(1000, 2000);
+		spin_lock_irqsave(&dum->lock, flags);
+	}
 	spin_unlock_irqrestore(&dum->lock, flags);
=20
 	usb_hcd_poll_rh_status(dummy_hcd_to_hcd(dum_hcd));
@@ -1005,13 +1011,6 @@ static int dummy_udc_stop(struct usb_gadget *g)
 	dum->ints_enabled =3D 0;
 	stop_activity(dum);
=20
-	/* emulate synchronize_irq(): wait for callbacks to finish */
-	while (dum->callback_usage > 0) {
-		spin_unlock_irq(&dum->lock);
-		usleep_range(1000, 2000);
-		spin_lock_irq(&dum->lock);
-	}
-
 	dum->driver =3D NULL;
 	spin_unlock_irq(&dum->lock);
=20
@@ -1900,6 +1899,7 @@ static void dummy_timer(struct timer_list *t)
 			if (value > 0) {
 				++dum->callback_usage;
 				spin_unlock(&dum->lock);
+				mdelay(5);
 				value =3D dum->driver->setup(&dum->gadget,
 						&setup);
 				spin_lock(&dum->lock);
