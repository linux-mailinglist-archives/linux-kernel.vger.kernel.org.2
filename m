Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1C5380916
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhENMEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhENMEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:04:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C436C061574;
        Fri, 14 May 2021 05:02:56 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s6so34355892edu.10;
        Fri, 14 May 2021 05:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pocb49nzdeqrWwdmjQ0ZJ+vWbjj70MiL2/8rMr/J5ZA=;
        b=vU3xhnwgCmRyn2T2bAdoNR21kUL5/bWTBNS4Tf2oK47aneMTF+lcIludTTdGxpzXjG
         uG1Y+p8Wd6HlF8Sse5JQ9U66sgMAYkWSDN9PRq7SZ2HrPzw4j1zv/2mLHzCjz54YjWxd
         pQGXpFegj1w8QljEtUHSdeaRy2UKR6hXKu/vC3pYNhedLvRsdrIN1stmMSAvb4sR48r0
         JdCVencOlRKoy1gl6dRyfVfuMnhH+Q6l0TAHMyai2Z/tozKhFCuhka0f5/zi9dqpHHCx
         ai+w2EViJEEYNEJuXqIJbhFqqXZy/AhbKUQtBCRiGRK0z7h4IIJODvIrWKde1E8Jfh29
         Nu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pocb49nzdeqrWwdmjQ0ZJ+vWbjj70MiL2/8rMr/J5ZA=;
        b=uFV/TtUxpG6faB5yzwnHLzsq6BS52VACvRpup+PAJZyDc1uOiMnRIetVHPZDLupAnj
         XG4QqWOs5gSDkawyAdvnEFlzOrYpyrAMVU5IqQhHD9visBJhhEr3J6lJXCiUfGsFd2iF
         mYGskUSwjkmrfF77vnjpj+NowdxoQDBAGQJoK9qDmh+xPDcP3uvg7sRMomMFfzoVNY5V
         pGy4Qfh0Pm60O3eXS6tHnDOILYewc5iguGrQRiA/gLC3CxMuCwRx/Z6CGzqL3TRNCH3J
         RReTkSGiNcQRimaAwZ/sw6j0vkE8HAimPBrd738jJhnrmnk9o9h952vbKs5G5aNcAI0Z
         6H0w==
X-Gm-Message-State: AOAM530/cW66e5GrI0OsiHbQRAE2cSNGqdiT7n3SDHvQtEnHHk2XK2xj
        gggRJd/3Y1f2GFcNFAZCxda3d+cFohIHFEGDBfjLn+ByTk93h70Qjw8wForq
X-Google-Smtp-Source: ABdhPJwvEhI2OU3pE0RqtzIkEDWFTvBnQ9J15MZw26hwWx3D4smbU0sqGAOGtJ9zBZgAFcA978wTCJ2dQzDXfik8NE4=
X-Received: by 2002:a50:f41a:: with SMTP id r26mr55516745edm.339.1620993775228;
 Fri, 14 May 2021 05:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210514110317.2041580-1-mudongliangabcd@gmail.com>
 <YJ5bllCkul/X+iNk@kroah.com> <CAD-N9QVUNRMB43RocnLZc6WxG+tUSjLcdHC5XXS=x7663Yom8Q@mail.gmail.com>
 <YJ5klcRZW0I5SShX@kroah.com>
In-Reply-To: <YJ5klcRZW0I5SShX@kroah.com>
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Fri, 14 May 2021 20:02:17 +0800
Message-ID: <CAD-N9QW+HA9F=CiWUJseLggNA6qJ=TLomE4rja1x-NGgEX_jpg@mail.gmail.com>
Subject: Re: [PATCH] misc/uss720: fix memory leak in uss720_probe
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 7:52 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 14, 2021 at 07:48:57PM +0800, =E6=85=95=E5=86=AC=E4=BA=AE wro=
te:
> > On Fri, May 14, 2021 at 7:14 PM Greg KH <gregkh@linuxfoundation.org> wr=
ote:
> > >
> > > On Fri, May 14, 2021 at 07:03:17PM +0800, Dongliang Mu wrote:
> > > > uss720_probe forgets to decrease the refcount of usbdev in uss720_p=
robe.
> > > > Fix this by decreasing the refcount of usbdev by usb_put_dev.
> > > >
> > > > BUG: memory leak
> > > > unreferenced object 0xffff888101113800 (size 2048):
> > > >   comm "kworker/0:1", pid 7, jiffies 4294956777 (age 28.870s)
> > > >   hex dump (first 32 bytes):
> > > >     ff ff ff ff 31 00 00 00 00 00 00 00 00 00 00 00  ....1.........=
..
> > > >     00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00  ..............=
..
> > > >   backtrace:
> > > >     [<ffffffff82b8e822>] kmalloc include/linux/slab.h:554 [inline]
> > > >     [<ffffffff82b8e822>] kzalloc include/linux/slab.h:684 [inline]
> > > >     [<ffffffff82b8e822>] usb_alloc_dev+0x32/0x450 drivers/usb/core/=
usb.c:582
> > > >     [<ffffffff82b98441>] hub_port_connect drivers/usb/core/hub.c:51=
29 [inline]
> > > >     [<ffffffff82b98441>] hub_port_connect_change drivers/usb/core/h=
ub.c:5363 [inline]
> > > >     [<ffffffff82b98441>] port_event drivers/usb/core/hub.c:5509 [in=
line]
> > > >     [<ffffffff82b98441>] hub_event+0x1171/0x20c0 drivers/usb/core/h=
ub.c:5591
> > > >     [<ffffffff81259229>] process_one_work+0x2c9/0x600 kernel/workqu=
eue.c:2275
> > > >     [<ffffffff81259b19>] worker_thread+0x59/0x5d0 kernel/workqueue.=
c:2421
> > > >     [<ffffffff81261228>] kthread+0x178/0x1b0 kernel/kthread.c:292
> > > >     [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/ent=
ry_64.S:294
> > > >
> > > > Reported-by: syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com
> > > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > > ---
> > > >  drivers/usb/misc/uss720.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
> > > > index b5d661644263..748139d26263 100644
> > > > --- a/drivers/usb/misc/uss720.c
> > > > +++ b/drivers/usb/misc/uss720.c
> > > > @@ -736,6 +736,7 @@ static int uss720_probe(struct usb_interface *i=
ntf,
> > > >       parport_announce_port(pp);
> > > >
> > > >       usb_set_intfdata(intf, pp);
> > > > +     usb_put_dev(usbdev);
> > > >       return 0;
> > > >
> > > >  probe_abort:
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > Nice catch!
> >
> > Thanks.
> >
> > This should be a bug fix. From the document, "Fixes" tag is needed for
> > bug fixes.
>
> It would be good, yes, please resend with that added.

Sure. I will resend the patch.

>
> > How do I quickly get this bug-inducing commit? Any
> > suggestion here?
>
> look at the log for this one file to find where the offending change
> happend.  Try `git log -p drivers/usb/misc/uss720.c`

0f36163d3abefbda1b21a330b3fdf3c2dc076d94 [PATCH] usb: fix uss720
schedule with interrupts off

@@ -536,93 +682,91 @@ static struct parport_operations parport_uss720_ops =
=3D
static int uss720_probe(struct usb_interface *intf,
const struct usb_device_id *id)
{
- struct usb_device *usbdev =3D interface_to_usbdev(intf);
+ struct usb_device *usbdev =3D usb_get_dev(interface_to_usbdev(intf));

Then only the code only decreases the refcount at failure sites.

>
> thanks,
>
> greg k-h
