Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9897233EB92
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCQIcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:32:22 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:56791 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhCQIcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:32:07 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MJmX3-1l6pci1RrF-00K80u for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021
 09:32:05 +0100
Received: by mail-ot1-f53.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so1030631otn.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:32:05 -0700 (PDT)
X-Gm-Message-State: AOAM532Q6SzNH3I5kYqlAVuVU7XvrKDjuddDznZEw18xNmKP1trDNB/0
        MnP6JHH8snmrgXvSz2LECjfz5V1Z3vtgnvuolp8=
X-Google-Smtp-Source: ABdhPJw0WED6GA+Cp8O4H4XC5cwO0STfMpzH/SMQfAXNc1kpYycFbPPDhLRQrHynegxHzApNDtrTXWPIyV31wwgqbdU=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr2447135otq.251.1615969924131;
 Wed, 17 Mar 2021 01:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069802205bda22b7f@google.com> <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
 <CAK8P3a1qtHVBY47FfCa6R9+sObzMCwxkREii+O2g8PPopw87eQ@mail.gmail.com>
 <CACT4Y+aC0YWU6gM32S3NoT+-wR7B1-_rhPyh4w542h21UCRRGw@mail.gmail.com>
 <CAK8P3a0zA9pv005d_P_e64j4EwXDh75yC6gNGRVdyy-VzO+7Fw@mail.gmail.com>
 <20210316155102.GP1463@shell.armlinux.org.uk> <CAK8P3a3A=TVWWmog=1YsALUhsaSkqReNrao5OTRd5mwyd0pnig@mail.gmail.com>
 <CACT4Y+a0UxqLCYY8P2qNcS_19LmesXMJf=+DaCOBFVZyS0DkWQ@mail.gmail.com>
 <CAK8P3a3+hfb2so28xH4cJ_t8mf3H5U0oQJeNOWUAk5dOiQSdTw@mail.gmail.com> <CACT4Y+bwfWJxNaqfcfW7uw4EFFWKpRj-ktjkTkfFCLaZ=p2xDg@mail.gmail.com>
In-Reply-To: <CACT4Y+bwfWJxNaqfcfW7uw4EFFWKpRj-ktjkTkfFCLaZ=p2xDg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Mar 2021 09:31:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1cjw419WZ=B5oPs7z4_6b6mxRwMjSJB0Q1eh5TpQoT9g@mail.gmail.com>
Message-ID: <CAK8P3a1cjw419WZ=B5oPs7z4_6b6mxRwMjSJB0Q1eh5TpQoT9g@mail.gmail.com>
Subject: Re: [syzbot] kernel panic: corrupted stack end in openat
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        syzbot <syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7yY7oMIUOBPFblG5hd/l/OPZ1U+GuravbZTThq0cXP2wARrTdw/
 QCfBLHWZ1Ks4KdhaUtwoYkDaofF/qHX3S3HGUTlQVT8d5jGM1k/0EpApG8htbfzERwECy3j
 Lo1P0ubBtdPnYWvUXGAVl6Ngf83ZgocSDKL6Q/dXiHdS6FAhJKmcQcdcFb9SMIINSApBLYC
 JfPaUWUeEY4ta36zPE6Kw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bW6bTBeD6v4=:V9mthI9ObXAWWEFYti1NqU
 mTK8UWF8ftz1Ow/gWA0/yWWTX/XGI9I4Cs2umhdUSFxnOTIPDTfWuu2Xl9vI6ZY3h9X+8R0sy
 Lwk3o/0yFc7CeJrzZu9BzJMgv0akO0+009ZtD84GMxVgYDxGX/TOBeEvFfZjOvzUa04VDS1N3
 ZE9Oogr/GFaexVTuMQzkfpL3wqB1Nf6S2RGVVMG3MYR9pGZwgMeIwhvBf6Aj2GbSZmMMa4qCu
 OpxTGWVrGq6KFfnHP6Om+ez5UbfplURzol4LEgPUh/Ue8OVRz+odSksp2ASIp4mBpT8KSOsbX
 5rZHsJiNMV6NNzb2hvhkDXdvdN9Y3CBsSGCMynJ0bC+TepgISghM05dUZ79lBKGFFfw939x1V
 0ENj/Y4ixIh001zaF0fqKdMzH/wONJhaSuumJAJOd04CBMyC2C11GioPrpblnJXB8rzkkfkUk
 jg6IyXYq8Xfa0auhx9IKaxH0txnoKOZbtoKHpTxu4bRcywCIc1ajbZx7WMOdeZMZr1MEOdpKI
 mXaLZ4B5D36Z8EdK2w8NW481Ci0cgxZmpmufLUeEt+p/FKj+XBvASeA5qf2dHLcUg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 8:52 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Tue, Mar 16, 2021 at 5:28 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Mar 16, 2021 at 5:13 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > On Tue, Mar 16, 2021 at 5:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Tue, Mar 16, 2021 at 4:51 PM Russell King - ARM Linux admin
> > > > <linux@armlinux.org.uk> wrote:
> > > > > On Tue, Mar 16, 2021 at 04:44:45PM +0100, Arnd Bergmann wrote:
> > > > > > On Tue, Mar 16, 2021 at 11:17 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > > > > The compiler is gcc version 10.2.1 20210110 (Debian 10.2.1-6)
> > > > > >
> > > > > > Ok, building with Ubuntu 10.2.1-1ubuntu1 20201207 locally, that's
> > > > > > the closest I have installed, and I think the Debian and Ubuntu versions
> > > > > > are generally quite close in case of gcc since they are maintained by
> > > > > > the same packagers.
> > > > >
> > > > > ... which shouldn't be a problem - that's just over 1/4 of the stack
> > > > > space. Could it be the syzbot's gcc is doing something weird and
> > > > > inflating the stack frames?
> > > >
> > > > It's possible, I think that's really unlikely given that it's just Debian's
> > > > gcc, which is as close to mainline as the version I was using.
> > > >
> > > > Uwe's DEBUG_STACKOVERFLOW patch from a while ago might
> > > > help if this was the problem though:
> > > > https://lore.kernel.org/linux-arm-kernel/20200108082913.29710-1-u.kleine-koenig@pengutronix.de/
> > > >
> > > > My best guess is something going wrong in the interrupt
> > > > that triggered the preempt_schedule() which ended up calling
> > > > task_stack_end_corrupted() in schedule_debug(), as you suggested
> > > > earlier.
> > >
> > > FWIW I see slightly larger frames with the config:
> > >
> > > 073ab64 <ima_calc_field_array_hash_tfm>:
> > > 8073ab64:       e1a0c00d        mov     ip, sp
> > > 8073ab68:       e92ddff0        push    {r4, r5, r6, r7, r8, r9, sl,
> > > fp, ip, lr, pc}
> > > 8073ab6c:       e24cb004        sub     fp, ip, #4
> > > 8073ab70:       e24ddfa7        sub     sp, sp, #668    ; 0x29c
> >
> > Yes, this is the one that the compiler complained about when warning
> > for stack over 600 bytes. It's not called in this call chain though.
> >
> > > page_alloc can also do reclaim, I had the impression that reclaim can
> > > be quite heavy-weight in all respects.
> >
> > Yes, that is another possibility. What writable file systems or swap
> > do you normally have mounted that it could be writing to, and on
> > what storage device?
>
> The root fs is ext4 on virtio-blk.
>
> There are also several dozens of shrinkers that can be called during reclaim:
> https://elixir.bootlin.com/linux/latest/C/ident/unregister_shrinker

Right, unfortunately I don't see a smoking gun there either, unless you are
also using NFS or devicemapper.

Implementing VMAP_STACK as you suggested earlier is probably the
best way to figure out if there is an actual overrun of the stack.
Alternatively, adding support for GCC_PLUGIN_STACKLEAK might
also help find out if we ever get close to the limit. This is probably
less work, but it might not actually help in this case.

        Arnd
