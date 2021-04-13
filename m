Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B6135E38C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhDMQNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:13:35 -0400
Received: from netrider.rowland.org ([192.131.102.5]:52115 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229688AbhDMQNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:13:32 -0400
Received: (qmail 1460435 invoked by uid 1000); 13 Apr 2021 12:13:11 -0400
Date:   Tue, 13 Apr 2021 12:13:11 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+eb4674092e6cc8d9e0bd@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] general protection fault in gadget_setup
Message-ID: <20210413161311.GC1454681@rowland.harvard.edu>
References: <00000000000075c58405bfd6228c@google.com>
 <CACT4Y+bTjQz=RBXVNrVMQ9xPz5CzGNBE854fsb0ukS-2_wdi3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bTjQz=RBXVNrVMQ9xPz5CzGNBE854fsb0ukS-2_wdi3Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 10:12:05AM +0200, Dmitry Vyukov wrote:
> On Tue, Apr 13, 2021 at 10:08 AM syzbot
> <syzbot+eb4674092e6cc8d9e0bd@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    0f4498ce Merge tag 'for-5.12/dm-fixes-2' of git://git.kern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=124adbf6d00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=daeff30c2474a60f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=eb4674092e6cc8d9e0bd
> > userspace arch: i386
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+eb4674092e6cc8d9e0bd@syzkaller.appspotmail.com
> 
> I suspect that the raw gadget_unbind() can be called while the timer
> is still active. gadget_unbind() sets gadget data to NULL.
> But I am not sure which unbind call this is:
> usb_gadget_remove_driver() or right in udc_bind_to_driver() due to a
> start error.

This certainly looks like a race between gadget_unbind and gadget_setup 
in raw_gadget.

In theory, this race shouldn't matter.  The gadget core is supposed to 
guarantee that there won't be any more callbacks to the gadget driver 
once the driver's unbind routine is called.  That guarantee is enforced 
in usb_gadget_remove_driver as follows:

	usb_gadget_disconnect(udc->gadget);
	if (udc->gadget->irq)
		synchronize_irq(udc->gadget->irq);
	udc->driver->unbind(udc->gadget);
	usb_gadget_udc_stop(udc);

usb_gadget_disconnect turns off the pullup resistor, telling the host 
that the gadget is no longer connected and preventing the transmission 
of any more USB packets.  Any packets that have already been received 
are sure to processed by the UDC driver's interrupt handler by the time 
synchronize_irq returns.

But this doesn't work with dummy_hcd, because dummy_hcd doesn't use 
interrupts; it uses a timer instead.  It does have code to emulate the 
effect of synchronize_irq, but that code doesn't get invoked at the 
right time -- it currently runs in usb_gadget_udc_stop, after the unbind 
callback instead of before.  Indeed, there's no way for 
usb_gadget_remove_driver to invoke this code before the unbind 
callback,.

I thought the synchronize_irq emulation problem had been completely 
solved, but evidently it hasn't.  It looks like the best solution is to 
add a call of the synchronize_irq emulation code in dummy_pullup.

Maybe we can test this reasoning by putting a delay just before the call 
to dum->driver->setup.  That runs in the timer handler, so it's not a 
good place to delay, but it may be okay just for testing purposes.

Hopefully this patch will make the race a lot more likely to occur.  Is 
there any way to tell syzkaller to test it, despite the fact that 
syzkaller doesn't think it has a reproducer for this issue?

Alan Stern


Index: usb-devel/drivers/usb/gadget/udc/dummy_hcd.c
===================================================================
--- usb-devel.orig/drivers/usb/gadget/udc/dummy_hcd.c
+++ usb-devel/drivers/usb/gadget/udc/dummy_hcd.c
@@ -1900,6 +1900,7 @@ restart:
 			if (value > 0) {
 				++dum->callback_usage;
 				spin_unlock(&dum->lock);
+				mdelay(5);
 				value = dum->driver->setup(&dum->gadget,
 						&setup);
 				spin_lock(&dum->lock);
