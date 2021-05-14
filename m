Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509123803A4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 08:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhENGah convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 May 2021 02:30:37 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:59921 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhENGab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 02:30:31 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M8hIl-1ldIaN3qYT-004jez for <linux-kernel@vger.kernel.org>; Fri, 14 May
 2021 08:29:18 +0200
Received: by mail-wm1-f44.google.com with SMTP id u133so4213150wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 23:29:18 -0700 (PDT)
X-Gm-Message-State: AOAM532okK5QDELTiVNkAu46YKi/tlaDi7UVSveLk4e3N0SBgmoU794W
        OYQpMuysVmRiwLXkjqj7YgmVK8gDTBB0P7N7FMo=
X-Google-Smtp-Source: ABdhPJwq4wIOtbl6ITYtHXFzwsvaLAUFhNxQXa2z85PD2Ju5EY/QK9nLdrLeFihJr5gteE2Y+aO85tobdvaA5BUHJ0Y=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr7651880wmb.142.1620973758665;
 Thu, 13 May 2021 23:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210514062150.3533786-1-yukuai3@huawei.com>
In-Reply-To: <20210514062150.3533786-1-yukuai3@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 May 2021 08:28:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a01oF7QZzjbd703QwiK+6ZPx1w-fSBcLjeMm4KQ0X0amw@mail.gmail.com>
Message-ID: <CAK8P3a01oF7QZzjbd703QwiK+6ZPx1w-fSBcLjeMm4KQ0X0amw@mail.gmail.com>
Subject: Re: [PATCH] char: pcmcia: remove set but not used variable 'tmp'
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     Harald Welte <laforge@gnumonks.org>,
        gregkh <gregkh@linuxfoundation.org>, akpm@osdl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Qxz1l8NPpOz/1U3m2I1GyRaEWDhl+txVs5kE/C/5/v6NqBxqPBQ
 rDymgmL4Cc/WgdDayRJDfn7woSWad2w5ilOq0HurmYsgWOQ6ljMl8Dd5CT74efOpESdIJHX
 xJJXRZyecoI+LX1dKDjGwd5BZKeML6NSn6urO9qLS+rX3YBLCJxFwQigw9ImlDLA4+D+rwX
 ytIEk/SpsqXK3rnUjbqCQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:w5qaT08HwJA=:VpO3dqe1BF0uuYGHeu+mxn
 HFbn+3hAPihp1yk5LMwJGAl8PXWtDl5kLaCIFz0fk8sYperzW6jRRdGg6XjMJfbXC/wrc4s24
 oZ5nMRMILc5xPeXuKWCFNQS2Rs7TeEHnRU1CbSL8cWMsnfIRVhcWW+qW9MPpkL5uPZtve/UJz
 Xik2K+vfwjU6OI0QkQyQC9CUPCObgjcujIMgEDIQdhggOL1yp3wUdTEzNW5dLtEZgI7lma1Yy
 uGRgqcDg0u3n2vedLQiS/K6XJ7pkxo37CEjr/lj9hMywdAmX10qjIUgBntnI6YWj/gUS2D/aT
 /aPjLUaFXY0LKK4E2jS/Yvciix2OvgXIycq0YA3PsAU88j+1YOBrDeIcOW9zIc3JlmXU0iiRC
 GNIDAm/DMbxxyYqWtpqFpLGtaXD+cVwo6zmCgD0QVlpc0nmQ44fmJJ8dIHewIEtYVpfQz1BAs
 46Gf4D7hi9hs2pfdj/uhwxHt2raAg3mecjxnClvvsbrR/VFXTgLth0a0RyIxJkAhgP36PYRQ3
 ULaW11boteV7B0YbEo9pe4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 8:21 AM Yu Kuai <yukuai3@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/char/pcmcia/cm4000_cs.c:1053:16: warning: variable ‘tmp’
> set but not used [-Wunused-but-set-variable]
>
> It is never used and so can be removed.
>
> Fixes: c1986ee9bea3 ("[PATCH] New Omnikey Cardman 4000 driver")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me. This was likely written that way at a time when some
architecture implemented inb() as a macro, and ignoring its value
would cause a different warning.

Since you are already touching this file, can you have a look at this
warning as well:

   drivers/char/pcmcia/cm4000_cs.c: In function 'set_protocol':
>> drivers/char/pcmcia/cm4000_cs.c:569:16: warning: iteration 4 invokes undefined behavior [-Waggressive-loop-optimizations]
     569 |   pts_reply[i] = inb(REG_BUF_DATA(iobase));
         |   ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/char/pcmcia/cm4000_cs.c:567:2: note: within this loop
     567 |  for (i = 0; i < num_bytes_read; i++) {

This looks like a preexisting problem that was uncovered by a patch
that is now in linux-next to change the inb() definition once more,
I got a report from the kernel build bot about it after I merged the
patch into the asm-generic tree. It needs a range check on
num_bytes_read, or a Kconfig check to ensure it is not built on
architectures without working inb()/outb() operations.

        Arnd
