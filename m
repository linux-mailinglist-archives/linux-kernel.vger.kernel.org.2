Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FB532A38A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382224AbhCBJHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbhCBIve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:51:34 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C43C061794
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 00:50:12 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id s7so9372405qkg.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 00:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WhtnmggMNcdYdbu676s9iSifWjSdNBtSBANUCU9HTLA=;
        b=HWdhC6Gb3dHIkUWX1ekPGLN1ZDPAROMX2a6PxRqnebUcn3vfawQWV6gLkU3LrryQyg
         q3Ud9lCNthE1x5qsk0KPBq2H+T4buEZCsNfCEVAgQRQXsmquvAJ2u8QhCv6/dCldlXQY
         Xl5AJvS1dsWl78BXWH+n0T7+lUSj9zRM0ri9S/Sclpz2MYc1ZbL6wk9X3cUnBS5Hnux9
         0PwJrihWHSrA6jNEIjtbVvd39JsHWSEIKYDLmnsvSlFbcZQSvX5KATCEKECXUcVf8lBX
         xZaPZxN95ZtKLGrhh0KuZRd7dl+iR0t1w6xVqXbAOICi8+zrCfQE10QgfaCRUIGcxtiI
         Ru0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WhtnmggMNcdYdbu676s9iSifWjSdNBtSBANUCU9HTLA=;
        b=K2YfU+3b5FGU3rOjzfvpARPZrYMJRV9hlSQWyAayuV3eDnbahHDNagicIQlfeqtmHQ
         /YcUCpaWz6qfBM/Q/0lI97baWwnVyCw5RRy7wyNEeBDAZP/cPCVuRO7NbvAcK5uNWXC+
         8AWovl9j7B8pjLEUmfhzPhi0cTG0bEAb7gAuIrbflr29YZKKeD7JWrbDYS3nc79bWDGg
         oFtTNg7lD4GRgQpTEAQkh/5zihEcEMeoQacO44Rd6FncfCe8ASJJlSTt93xVlDbTTFIN
         /yWBi48RlVDNdTbRHfcti8sQUEWrOXeMr5ICe9PdU8mPB6tVgVXL6FoGPQyqmU09oP/H
         SmcQ==
X-Gm-Message-State: AOAM530OAkc9jWPtHXk70kkPkozUPL1qtizWsGS6d7mr5YLlizsk4Wo3
        fKt7Z5U3i4YSQj0WoXr6M64ZrguBDh3wQ8YIdp54XQ==
X-Google-Smtp-Source: ABdhPJxFaxzrqAzbQS0vDkDeFyvwPT2hM88tfon15RBo8eyUGj0oyV4bEeTzIjyDoDyB0NvJCCnWMKmiX1k0txeEB94=
X-Received: by 2002:a37:96c4:: with SMTP id y187mr19600645qkd.231.1614675011769;
 Tue, 02 Mar 2021 00:50:11 -0800 (PST)
MIME-Version: 1.0
References: <00000000000036bf3f05bc7ea28a@google.com> <20210302084313.1520-1-hdanton@sina.com>
In-Reply-To: <20210302084313.1520-1-hdanton@sina.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 2 Mar 2021 09:50:00 +0100
Message-ID: <CACT4Y+ZRivn84J08sYqOSWhsX1HzCp2ZTYX8ZKwtGndDJKJmDw@mail.gmail.com>
Subject: Re: memory leak in edge_startup
To:     Hillf Danton <hdanton@sina.com>, paskripkin@gmail.com
Cc:     syzbot <syzbot+59f777bdcbdd7eea5305@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 9:43 AM Hillf Danton <hdanton@sina.com> wrote:
>
> Mon, 01 Mar 2021 11:29:16 -0800
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    29c395c7 Merge tag 'x86-entry-2021-02-24' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10d694dad00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=66b7497b2c5acd67
> > dashboard link: https://syzkaller.appspot.com/bug?extid=59f777bdcbdd7eea5305
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162940dad00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1650737ad00000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+59f777bdcbdd7eea5305@syzkaller.appspotmail.com
> >
> > BUG: memory leak
> > unreferenced object 0xffff88810dc5a800 (size 2048):
> >   comm "kworker/1:3", pid 4818, jiffies 4294960503 (age 15.050s)
> >   hex dump (first 32 bytes):
> >     20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ...............
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<00000000153c6b11>] kmalloc include/linux/slab.h:554 [inline]
> >     [<00000000153c6b11>] kzalloc include/linux/slab.h:684 [inline]
> >     [<00000000153c6b11>] edge_startup+0x3f/0x11f0 drivers/usb/serial/io_edgeport.c:2833
> >     [<000000007c25fa28>] usb_serial_probe.cold+0x6ab/0xb84 drivers/usb/serial/usb-serial.c:1027
> >     [<0000000050250e6f>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
> >     [<00000000f10f144c>] really_probe+0x159/0x4a0 drivers/base/dd.c:554
> >     [<0000000036a9ab90>] driver_probe_device+0x84/0x100 drivers/base/dd.c:740
> >     [<00000000a08d4f3b>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:846
> >     [<000000009356c1ed>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
> >     [<00000000aa8a21fd>] __device_attach+0x122/0x250 drivers/base/dd.c:914
> >     [<00000000ee865ab7>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
> >     [<000000005ea173b6>] device_add+0x5d5/0xc40 drivers/base/core.c:3242
> >     [<000000003faa2805>] usb_set_configuration+0x9d9/0xb90 drivers/usb/core/message.c:2164
> >     [<0000000099ff1454>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
> >     [<00000000a57fa7c3>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
> >     [<00000000f10f144c>] really_probe+0x159/0x4a0 drivers/base/dd.c:554
> >     [<0000000036a9ab90>] driver_probe_device+0x84/0x100 drivers/base/dd.c:740
> >     [<00000000a08d4f3b>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:846
>
> Fix mm leak by rolling back in case of error.

I think paskripkin is already fixing this, you can see a patch testing request:

https://syzkaller.appspot.com/bug?extid=59f777bdcbdd7eea5305
https://groups.google.com/g/syzkaller-bugs/c/PlE-vZm0YJU/m/gzlYOh63BQAJ



> --- x/drivers/usb/serial/io_edgeport.c
> +++ y/drivers/usb/serial/io_edgeport.c
> @@ -3003,6 +3003,7 @@ static int edge_startup(struct usb_seria
>                                 response = -ENODEV;
>                         }
>
> +error_rsp:
>                         usb_free_urb(edge_serial->interrupt_read_urb);
>                         kfree(edge_serial->interrupt_in_buffer);
>
> @@ -3018,9 +3019,11 @@ static int edge_startup(struct usb_seria
>                  * continue as long as the edgeport is connected */
>                 response = usb_submit_urb(edge_serial->interrupt_read_urb,
>                                                                 GFP_KERNEL);
> -               if (response)
> +               if (response) {
>                         dev_err(ddev, "%s - Error %d submitting control urb\n",
>                                 __func__, response);
> +                       goto error_rsp;
> +               }
>         }
>         return response;
>  }
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20210302084313.1520-1-hdanton%40sina.com.
