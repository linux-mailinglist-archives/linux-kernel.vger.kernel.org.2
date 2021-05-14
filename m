Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AF73808E1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhENLur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhENLur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:50:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACF5C061574;
        Fri, 14 May 2021 04:49:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t3so1901463edc.7;
        Fri, 14 May 2021 04:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vccyEx0yI+JFtGV4Vj5cjkFEHkXdVNsLiy5PXPi9hKM=;
        b=Vf1jQoa8m529GPe/YnPzWF1i3mEm5JBnzQnuoQ4VzkIVrL3LCB/tIiM/rRW0nYFuZ8
         b8GFSUHJ+fRCjz+EClxdj0eEK5tPXenfk2GDRKUfsHJgJI91Bc2/2rdYZuFSat2YbCdj
         TpBz6DBUErPNy30m7RwX4MUUdxg2iZ1zGkbm+XdcDcErzELFlWaWyyQnGxHB9kfY86XU
         CCrO66cfhtRZXVSb9KDPhAvZCMVpekpaqXl0/PYw+UQB1KbSRG3Ez+jDzQr18Xt0KnEu
         EOo7/ia2cW1yx4Z50Nl9VK+2Ts8SKS9ywevf9rB2iefzfs0cyxNG9NFxMvAVc8XyFR96
         6r3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vccyEx0yI+JFtGV4Vj5cjkFEHkXdVNsLiy5PXPi9hKM=;
        b=kH3D/PQh7Ew6hXXWjVhXZud3urEFzo0AJuudgPB5jFJ9l7s24zYbd2WDlI4rOddxMY
         JicHNS7wkMMBmOrpEhlqvDCYsk+FyoBPoj7mmKEQq3Qu8mAUBvq0ofb0cRM0/F1yEhmw
         Q5kIWt+22ZxE0/B8BF/dJxrec06VtuzmcpgPWGYjymfHNPwnNcE0hcCjbNtIn42axLnj
         JQxSn7j0wmZO90urQ+nX08CJmjCjePrPgzydkm3ph7/u0qIzNanv6pClkuaaWd8JOD9E
         uBLRz5SRHxIoG1Y8a3JB0IFlFsJpve0oLhflIsgguMYM+qrQkl/Qe0ncGMEksob2rFaZ
         n+Eg==
X-Gm-Message-State: AOAM5305caSr17/pJAwvhrAd2IvA3O065mKqkqMh7RxgveoQcCG+vSIT
        N3I+WLJIysqbs6LIDJfI9jObRm3EdN3DU4sp2IYCBDhs+ASY7NODY4CTzg==
X-Google-Smtp-Source: ABdhPJzLB4GLCEsbnYKRPU2GsUt7N+crUbb5yHILgsv3lc0lVWR+RukGx4G54TEUxbLRO8r6zLyvsbNZVE16quS5Ojg=
X-Received: by 2002:a05:6402:1109:: with SMTP id u9mr57320786edv.174.1620992974567;
 Fri, 14 May 2021 04:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210514110317.2041580-1-mudongliangabcd@gmail.com> <YJ5bllCkul/X+iNk@kroah.com>
In-Reply-To: <YJ5bllCkul/X+iNk@kroah.com>
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Fri, 14 May 2021 19:48:57 +0800
Message-ID: <CAD-N9QVUNRMB43RocnLZc6WxG+tUSjLcdHC5XXS=x7663Yom8Q@mail.gmail.com>
Subject: Re: [PATCH] misc/uss720: fix memory leak in uss720_probe
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 7:14 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 14, 2021 at 07:03:17PM +0800, Dongliang Mu wrote:
> > uss720_probe forgets to decrease the refcount of usbdev in uss720_probe.
> > Fix this by decreasing the refcount of usbdev by usb_put_dev.
> >
> > BUG: memory leak
> > unreferenced object 0xffff888101113800 (size 2048):
> >   comm "kworker/0:1", pid 7, jiffies 4294956777 (age 28.870s)
> >   hex dump (first 32 bytes):
> >     ff ff ff ff 31 00 00 00 00 00 00 00 00 00 00 00  ....1...........
> >     00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00  ................
> >   backtrace:
> >     [<ffffffff82b8e822>] kmalloc include/linux/slab.h:554 [inline]
> >     [<ffffffff82b8e822>] kzalloc include/linux/slab.h:684 [inline]
> >     [<ffffffff82b8e822>] usb_alloc_dev+0x32/0x450 drivers/usb/core/usb.c:582
> >     [<ffffffff82b98441>] hub_port_connect drivers/usb/core/hub.c:5129 [inline]
> >     [<ffffffff82b98441>] hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
> >     [<ffffffff82b98441>] port_event drivers/usb/core/hub.c:5509 [inline]
> >     [<ffffffff82b98441>] hub_event+0x1171/0x20c0 drivers/usb/core/hub.c:5591
> >     [<ffffffff81259229>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
> >     [<ffffffff81259b19>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
> >     [<ffffffff81261228>] kthread+0x178/0x1b0 kernel/kthread.c:292
> >     [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> >
> > Reported-by: syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/usb/misc/uss720.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
> > index b5d661644263..748139d26263 100644
> > --- a/drivers/usb/misc/uss720.c
> > +++ b/drivers/usb/misc/uss720.c
> > @@ -736,6 +736,7 @@ static int uss720_probe(struct usb_interface *intf,
> >       parport_announce_port(pp);
> >
> >       usb_set_intfdata(intf, pp);
> > +     usb_put_dev(usbdev);
> >       return 0;
> >
> >  probe_abort:
> > --
> > 2.25.1
> >
>
> Nice catch!

Thanks.

This should be a bug fix. From the document, "Fixes" tag is needed for
bug fixes. How do I quickly get this bug-inducing commit? Any
suggestion here?
