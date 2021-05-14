Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E469B3808F2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhENLyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232376AbhENLyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:54:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0295861205;
        Fri, 14 May 2021 11:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620993176;
        bh=fh+mN5i4A9ZHINgqgqeSFBr5nWgABC8Hh8x2JV89FQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6yg+7uIekFTTFLEWUGkdjC1QVlid4CznQTz14y0dQBXTho4h6tA/fwMcVB0BghlJ
         gug8IDKP9k+b8nci9DlH6BABMOC/qN92ACg9UPtg2BOqB9D02eV9LvO+eJTx9A+pVn
         C1Bg8jCrgTorE6ZgM2bk3B17wJtcHBNovxGSNqoA=
Date:   Fri, 14 May 2021 13:52:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com
Subject: Re: [PATCH] misc/uss720: fix memory leak in uss720_probe
Message-ID: <YJ5klcRZW0I5SShX@kroah.com>
References: <20210514110317.2041580-1-mudongliangabcd@gmail.com>
 <YJ5bllCkul/X+iNk@kroah.com>
 <CAD-N9QVUNRMB43RocnLZc6WxG+tUSjLcdHC5XXS=x7663Yom8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD-N9QVUNRMB43RocnLZc6WxG+tUSjLcdHC5XXS=x7663Yom8Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 07:48:57PM +0800, 慕冬亮 wrote:
> On Fri, May 14, 2021 at 7:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, May 14, 2021 at 07:03:17PM +0800, Dongliang Mu wrote:
> > > uss720_probe forgets to decrease the refcount of usbdev in uss720_probe.
> > > Fix this by decreasing the refcount of usbdev by usb_put_dev.
> > >
> > > BUG: memory leak
> > > unreferenced object 0xffff888101113800 (size 2048):
> > >   comm "kworker/0:1", pid 7, jiffies 4294956777 (age 28.870s)
> > >   hex dump (first 32 bytes):
> > >     ff ff ff ff 31 00 00 00 00 00 00 00 00 00 00 00  ....1...........
> > >     00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00  ................
> > >   backtrace:
> > >     [<ffffffff82b8e822>] kmalloc include/linux/slab.h:554 [inline]
> > >     [<ffffffff82b8e822>] kzalloc include/linux/slab.h:684 [inline]
> > >     [<ffffffff82b8e822>] usb_alloc_dev+0x32/0x450 drivers/usb/core/usb.c:582
> > >     [<ffffffff82b98441>] hub_port_connect drivers/usb/core/hub.c:5129 [inline]
> > >     [<ffffffff82b98441>] hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
> > >     [<ffffffff82b98441>] port_event drivers/usb/core/hub.c:5509 [inline]
> > >     [<ffffffff82b98441>] hub_event+0x1171/0x20c0 drivers/usb/core/hub.c:5591
> > >     [<ffffffff81259229>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
> > >     [<ffffffff81259b19>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
> > >     [<ffffffff81261228>] kthread+0x178/0x1b0 kernel/kthread.c:292
> > >     [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> > >
> > > Reported-by: syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com
> > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > ---
> > >  drivers/usb/misc/uss720.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
> > > index b5d661644263..748139d26263 100644
> > > --- a/drivers/usb/misc/uss720.c
> > > +++ b/drivers/usb/misc/uss720.c
> > > @@ -736,6 +736,7 @@ static int uss720_probe(struct usb_interface *intf,
> > >       parport_announce_port(pp);
> > >
> > >       usb_set_intfdata(intf, pp);
> > > +     usb_put_dev(usbdev);
> > >       return 0;
> > >
> > >  probe_abort:
> > > --
> > > 2.25.1
> > >
> >
> > Nice catch!
> 
> Thanks.
> 
> This should be a bug fix. From the document, "Fixes" tag is needed for
> bug fixes.

It would be good, yes, please resend with that added.

> How do I quickly get this bug-inducing commit? Any
> suggestion here?

look at the log for this one file to find where the offending change
happend.  Try `git log -p drivers/usb/misc/uss720.c`

thanks,

greg k-h
