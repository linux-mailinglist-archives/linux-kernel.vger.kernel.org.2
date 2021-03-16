Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F65E33D96B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbhCPQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:29:09 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:47719 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbhCPQ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:28:42 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MZT2u-1lAbBH1aC6-00WYug for <linux-kernel@vger.kernel.org>; Tue, 16 Mar
 2021 17:28:41 +0100
Received: by mail-wr1-f50.google.com with SMTP id e10so10785392wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:28:41 -0700 (PDT)
X-Gm-Message-State: AOAM530i8EGYkBTOzn6QJaHtYQHKyHpHnuyWo+lcbBfOF1ZNaeHihyQa
        Woo7NYcw+Vb5trHZ85bEibgi57+RlpoKVB5I1/0=
X-Google-Smtp-Source: ABdhPJy6OpogaQHFntBMP/7lsuEBqGdHp0LZpUuLXrGks38F2MUR3PM5odMpKcaTirqM3RleDkImZFnBOeP+nNlQJaY=
X-Received: by 2002:adf:ed87:: with SMTP id c7mr5898280wro.9.1615912121110;
 Tue, 16 Mar 2021 09:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069802205bda22b7f@google.com> <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
 <CAK8P3a1qtHVBY47FfCa6R9+sObzMCwxkREii+O2g8PPopw87eQ@mail.gmail.com>
 <CACT4Y+aC0YWU6gM32S3NoT+-wR7B1-_rhPyh4w542h21UCRRGw@mail.gmail.com>
 <CAK8P3a0zA9pv005d_P_e64j4EwXDh75yC6gNGRVdyy-VzO+7Fw@mail.gmail.com>
 <20210316155102.GP1463@shell.armlinux.org.uk> <CAK8P3a3A=TVWWmog=1YsALUhsaSkqReNrao5OTRd5mwyd0pnig@mail.gmail.com>
 <CACT4Y+a0UxqLCYY8P2qNcS_19LmesXMJf=+DaCOBFVZyS0DkWQ@mail.gmail.com>
In-Reply-To: <CACT4Y+a0UxqLCYY8P2qNcS_19LmesXMJf=+DaCOBFVZyS0DkWQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 16 Mar 2021 17:28:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3+hfb2so28xH4cJ_t8mf3H5U0oQJeNOWUAk5dOiQSdTw@mail.gmail.com>
Message-ID: <CAK8P3a3+hfb2so28xH4cJ_t8mf3H5U0oQJeNOWUAk5dOiQSdTw@mail.gmail.com>
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
X-Provags-ID: V03:K1:A3/E2MGTIBXJ++yPYmQG4ROGdK0EOOrqxMMb+a4nBkUHEyN4Xnz
 ReTwZaQGsPkN56cbl1WqfJkYyBHtaiiKQI+ZNLAfuOFdsrfy4Jv3STm8NIGv6YtxRmVg+Kq
 F6k4fijqRzpwFBtwTkRAElozOep2y2/Po4DMfFynvJgMYPCeW2mhs86DM9bnpXHagCj08Rn
 aMkwjhnbAyZSyrC6ZAIMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uIG5YjFscss=:DouYnqk/zRT9FBl1sxmjOo
 fRmYNuSQn218o4n66neAAI3TQ7YZiLfCNx/wHG9EO2LUtE/1kKha5z1ifY3/DcKk6td0Rqaxf
 PKkqaxNMNGQqXo0KPCzqItSr44/aYuVD7W3fhEpyEmYg29ulmlG6Am+VJutpjjZjcA3ySZJ81
 G8Mo/Y+AkrU4ZgsXR663Ffm38iNYqT0no6Ib/QGk4PWy3jwqFaR5uVcTiX1Ppw87N3Y411s5J
 TI2GH9OjeWw4lPyBOU/UifASIY4GMgnGjUt211STWQLfvYVBXBxJ2zM6/3xH4NyMr8LYVZ296
 RL0EDNlXlfM3lofPO0G8KLNV70icxNEulKu9c+OksaFoSSpB5Plb+t/3FWTNVH3uD8UDPqr0R
 1GPbRGYiJDkXJS25Vlpwb+UghD2hTS37JgYdh8uflXJWjuyjxLGEKBf5afqcUCyy159b++KGq
 YOyQWKaTG/NwnJqF70IhWRz7ti3P6QvJqPdzPpLWERBmGHjurBcSrd4f3EHIfOztSj4wceffV
 vxlyGVJSP8FYs5KQYZ99SThnJu4L2j1OLRBOZnlCEyLFOU1h/Y9Ku6Z2H69FrTvTA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 5:13 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Mar 16, 2021 at 5:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Mar 16, 2021 at 4:51 PM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > > On Tue, Mar 16, 2021 at 04:44:45PM +0100, Arnd Bergmann wrote:
> > > > On Tue, Mar 16, 2021 at 11:17 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > > The compiler is gcc version 10.2.1 20210110 (Debian 10.2.1-6)
> > > >
> > > > Ok, building with Ubuntu 10.2.1-1ubuntu1 20201207 locally, that's
> > > > the closest I have installed, and I think the Debian and Ubuntu versions
> > > > are generally quite close in case of gcc since they are maintained by
> > > > the same packagers.
> > >
> > > ... which shouldn't be a problem - that's just over 1/4 of the stack
> > > space. Could it be the syzbot's gcc is doing something weird and
> > > inflating the stack frames?
> >
> > It's possible, I think that's really unlikely given that it's just Debian's
> > gcc, which is as close to mainline as the version I was using.
> >
> > Uwe's DEBUG_STACKOVERFLOW patch from a while ago might
> > help if this was the problem though:
> > https://lore.kernel.org/linux-arm-kernel/20200108082913.29710-1-u.kleine-koenig@pengutronix.de/
> >
> > My best guess is something going wrong in the interrupt
> > that triggered the preempt_schedule() which ended up calling
> > task_stack_end_corrupted() in schedule_debug(), as you suggested
> > earlier.
>
> FWIW I see slightly larger frames with the config:
>
> 073ab64 <ima_calc_field_array_hash_tfm>:
> 8073ab64:       e1a0c00d        mov     ip, sp
> 8073ab68:       e92ddff0        push    {r4, r5, r6, r7, r8, r9, sl,
> fp, ip, lr, pc}
> 8073ab6c:       e24cb004        sub     fp, ip, #4
> 8073ab70:       e24ddfa7        sub     sp, sp, #668    ; 0x29c

Yes, this is the one that the compiler complained about when warning
for stack over 600 bytes. It's not called in this call chain though.

> page_alloc can also do reclaim, I had the impression that reclaim can
> be quite heavy-weight in all respects.

Yes, that is another possibility. What writable file systems or swap
do you normally have mounted that it could be writing to, and on
what storage device?

       Arnd
