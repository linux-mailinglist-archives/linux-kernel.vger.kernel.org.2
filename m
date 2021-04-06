Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6DF35529F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245753AbhDFLpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhDFLpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:45:10 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FF2C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 04:45:01 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id o15so8646486ilf.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 04:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5jQJwmjurYD1/X5qLcnpFP1lk9/TVOOrGxHkWoJTtbE=;
        b=Btj6MwJcJ/iYDmRUObx3ZtCdrUy/KmZLZ6iHkGzPjoR6ORS3zzDNUzQnmlsgFKOWqI
         y1OmbYC9pEvd6khx3b16YzKMTG02JHndnzoKlnBL/qhPYN0Mi0MaN+eM+mKt6Kc1ywk4
         ynwLM86zu3zSBcawIWOl6GYBURN2OD2X932U13k9tp7Lnu9DrLvBB5Rn5eYRGm/Y46tY
         Wti71428a6VjOShcOqhrgc4TSSKDmoLSmElWw1k4+/axB/1dfNwhmZYDxIEVlz2Y1pSK
         jh5qG6U5z3xNtg6gvVS7V+v3TJtCrxBXQInH197f6qhMIX1XqP99bYRBAhVu7MbZNH+T
         FXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5jQJwmjurYD1/X5qLcnpFP1lk9/TVOOrGxHkWoJTtbE=;
        b=FhaqJ93rsK0UgOzy+5urD5NPoPHkk/of2bEQFmwlFB4mcwB7lo8ihYVfGHmGgffP0I
         S2A7KtuL3b2FM0aCvX2vUkKyqYkmYdAtSYN25jPxKkeRzFI2VR+dwy8c+ZmVNL/Bx5yI
         1rrzKel06WTwaEFkJ2P94B0Jiogn4rV873OtKSTkNpebcwb9Ugup42BDFEkI5lhuETwa
         0ff2VPA4BzB32rfSUKL0CvPkw3DEE17vAv22rR9eS2YBBGgTVOolzjP0tMeCO5krHfDc
         u9eI0LNN+JFgwTVFV6u3DxVqtLmeiDN9AbM8Y9jMpvhcl4Dvwq83nY7pDgKYt3zcQTCq
         MeeQ==
X-Gm-Message-State: AOAM531ilmXWjz3ExDOKwYI40TWj/9+X+tSXCamXNmwgePnGmeNqdR2+
        FOreD3s8wdsF6ZjuQbCrk6Helqb67rLeryPdzQ==
X-Google-Smtp-Source: ABdhPJyJKff9R+msz6xwU3Rs5PVFvB1fAYTRwuyYlN01o/jOfzWq2BFCiRS9eTBXP9+wcf13sX/3C81Zm9geUjQmpxU=
X-Received: by 2002:a05:6e02:1285:: with SMTP id y5mr12879233ilq.4.1617709500478;
 Tue, 06 Apr 2021 04:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsYEhOuQUd2qjobumByFtAXyyoGqXgM8gXYZHqsnV8dgUg@mail.gmail.com>
 <20210404123934.2620-1-hdanton@sina.com> <YGrkHoYjTmR7HQeM@kroah.com> <20210405110200.7372-1-hdanton@sina.com>
In-Reply-To: <20210405110200.7372-1-hdanton@sina.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 6 Apr 2021 19:44:54 +0800
Message-ID: <CACkBjsYQ29j8O9e-Vp9nbERrFtSQ17L1vLLeLfuk245Y=ykabg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in cdev_del
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Happy to do it once Hao will echo confirming it works for him.
It looks like the patch solved the problem, nice!

Here's what I did. First, I compiled the kernel (5e46d1b7) with the
attached configuration, then I ran the reproducing program
(repro.cprog) and the same vulnerability was triggered, which means
the reproduction was successful. Then I added the patch from the email
to the gsmld_attach_gsm function and compiled it again with the same
configuration, this time after running the reproducing program, the
vulnerability was not triggered.

However, my operations are only carried out in x86_64 qemu virtual
machines, not sure whether the results will be the same under other
architectures, which need to be discussed further.

Reported-and-tested-by: SunHao-0/healer at dev (github.com)

Hillf Danton <hdanton@sina.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=885=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=887:02=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 5 Apr 2021 12:19:10 Greg KH wrote:
> >On Sun, Apr 04, 2021 at 08:39:34PM +0800, Hillf Danton wrote:
> >> On Sun, 4 Apr 2021 17:05:17 Hao Sun wrote:
> >> > Besides, the 'refcount bug in cdev_del' bug still exists too.
> >>
> >> Thanks for your report, Hao.
> >> >
> >> > Here is the detailed information:
> >> > commit:   5e46d1b78a03d52306f21f77a4e4a144b6d31486
> >> > version:   Linux 5.12-rc5
> >> > git tree:    upstream
> >> > kernel config (KASAN not enabled) and reproducing program can be fou=
nd
> >> > in the attachment.
> >> > Report:
> >> > ------------[ cut here ]------------
> >> > refcount_t: underflow; use-after-free.
> >> > WARNING: CPU: 1 PID: 8923 at lib/refcount.c:28
> >> > refcount_warn_saturate+0x1cf/0x210 -origin/lib/refcount.c:28
> >> > Modules linked in:
> >> > CPU: 1 PID: 8923 Comm: executor Not tainted 5.12.0-rc5+ #8
> >> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> >> > 1.13.0-1ubuntu1.1 04/01/2014
> >> > RIP: 0010:refcount_warn_saturate+0x1cf/0x210 -origin/lib/refcount.c:=
28
> >> > Code: 4f ff ff ff e8 32 fa b5 fe 48 c7 c7 3d f8 f6 86 e8 d6 ab c6 fe
> >> > c6 05 7c 34 67 04 01 48 c7 c7 68 f8 6d 86 31 c0 e8 81 2e 9d fe <0f> =
0b
> >> > e9 22 ff ff ff e8 05 fa b5 fe 48 c7 c7 3e f8 f6 86 e8 a9 ab
> >> > RSP: 0018:ffffc90001633c60 EFLAGS: 00010246
> >> > RAX: 15d08b2e34b77800 RBX: 0000000000000003 RCX: ffff88804c056c80
> >> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> >> > RBP: 0000000000000003 R08: ffffffff813767aa R09: 0001ffffffffffff
> >> > R10: 0001ffffffffffff R11: ffff88804c056c80 R12: ffff888040b7d000
> >> > R13: ffff88804c206938 R14: ffff88804c206900 R15: ffff888041b18488
> >> > FS:  00000000022c9940(0000) GS:ffff88807ec00000(0000) knlGS:00000000=
0000000=3D
> >> > 0
> >> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> > CR2: 00007f9f9b122008 CR3: 0000000044b4b000 CR4: 0000000000750ee0
> >> > PKRU: 55555554
> >> > Call Trace:
> >> >  __refcount_sub_and_test -origin/./include/linux/refcount.h:283 [inl=
ine]
> >> >  __refcount_dec_and_test -origin/./include/linux/refcount.h:315 [inl=
ine]
> >> >  refcount_dec_and_test -origin/./include/linux/refcount.h:333 [inlin=
e]
> >> >  kref_put -origin/./include/linux/kref.h:64 [inline]
> >> >  kobject_put+0x17b/0x180 -origin/lib/kobject.c:753
> >> >  cdev_del+0x4b/0x50 -origin/fs/char_dev.c:597
> >> >  tty_unregister_device+0x99/0xd0 -origin/drivers/tty/tty_io.c:3343
> >> >  gsmld_detach_gsm -origin/drivers/tty/n_gsm.c:2409 [inline]
> >> >  gsmld_close+0x6c/0x140 -origin/drivers/tty/n_gsm.c:2478
> >> >  tty_ldisc_close -origin/drivers/tty/tty_ldisc.c:488 [inline]
> >> >  tty_ldisc_kill -origin/drivers/tty/tty_ldisc.c:636 [inline]
> >> >  tty_ldisc_release+0x1b6/0x400 -origin/drivers/tty/tty_ldisc.c:809
> >> >  tty_release_struct+0x19/0xb0 -origin/drivers/tty/tty_io.c:1714
> >> >  tty_release+0x9ad/0xa00 -origin/drivers/tty/tty_io.c:1885
> >> >  __fput+0x260/0x4e0 -origin/fs/file_table.c:280
> >> >  ____fput+0x11/0x20 -origin/fs/file_table.c:313
> >> >  task_work_run+0x8e/0x110 -origin/kernel/task_work.c:140
> >> >  tracehook_notify_resume -origin/./include/linux/tracehook.h:189 [in=
line]
> >> >  exit_to_user_mode_loop -origin/kernel/entry/common.c:174 [inline]
> >> >  exit_to_user_mode_prepare+0x16b/0x1a0 -origin/kernel/entry/common.c=
:208
> >> >  __syscall_exit_to_user_mode_work -origin/kernel/entry/common.c:290 =
[inline]
> >> >  syscall_exit_to_user_mode+0x20/0x40 -origin/kernel/entry/common.c:3=
01
> >> >  do_syscall_64+0x45/0x80 -origin/arch/x86/entry/common.c:56
> >> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>
> >> No error check on registering tty device - add it.
> >> And roll back in case of error.
> >>
> >> --- x/drivers/tty/n_gsm.c
> >> +++ y/drivers/tty/n_gsm.c
> >> @@ -2384,8 +2384,19 @@ static int gsmld_attach_gsm(struct tty_s
> >>              /* Don't register device 0 - this is the control channel =
and not
> >>                 a usable tty interface */
> >>              base =3D mux_num_to_base(gsm); /* Base for this MUX */
> >> -            for (i =3D 1; i < NUM_DLCI; i++)
> >> -                    tty_register_device(gsm_tty_driver, base + i, NUL=
L);
> >> +            for (i =3D 1; i < NUM_DLCI; i++) {
> >> +                    struct device *dev;
> >> +
> >> +                    dev =3D tty_register_device(gsm_tty_driver,
> >> +                                                    base + i, NULL);
> >> +                    if (IS_ERR(dev)) {
> >> +                            for (i--; i >=3D 1; i--)
> >> +                                    tty_unregister_device(gsm_tty_dri=
ver,
> >> +                                                            base + i)=
;
> >> +                            ret =3D PTR_ERR(dev);
> >> +                            return ret;
> >> +                    }
> >> +            }
> >>      }
> >>      return ret;
> >>  }
> >
> >Are you testing these patches somehow?
>
> No Sir because I am now having no access to the gsm hardware.
>
> >Can you do that and then submit them correctly?
>
> Happy to do it once Hao will echo confirming it works for him.
>
> Hillf
