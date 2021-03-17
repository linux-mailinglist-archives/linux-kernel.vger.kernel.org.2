Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5B833EAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 08:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhCQHs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 03:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhCQHsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:48:11 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3C6C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 00:48:10 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id g8so978302qvx.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 00:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btQk/571WPXOLRNGWmF0j/+OmLEhVuOUexCPHcpCZx0=;
        b=QL8u6TGl+3a2WsVabpO4KATQNI6e9Hhu1B3qAUkU9UJ5GLQrAjbrXGIYLt+HggEwHk
         wYiEI80YewbedAws5JcOE9V0fZbS+M4TKHCOY/0t+QqePgCf4137RKyAX81T2qqKMaz3
         IR3Od4O3op9t3TxqwpkOACvI70wSNfSaJNnFmOB7J6RgzwSKwyPJHCUCIjvCwGGCad1X
         1471nba0x4pth0NTbNrvEJnuqlMyFLPcCocgEGYmQetmeOEGm+iUHf5v80FMNRtTQCCq
         b6XE00NVWL2SqSfRx2PBB5nxrZ5/Qqri4V3AsBGh9hUXUOenDX8NDAwanNNM7GR/9TCl
         FK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btQk/571WPXOLRNGWmF0j/+OmLEhVuOUexCPHcpCZx0=;
        b=obWck1BMW9NcxR8SXg0Ez+2jMut0SDo1W1nSykhNTQum6Ru8ijOWZ6CsBXUwPlggdj
         h12x4KW46stR6ibqv+IrwBvF3T6ZMGH9vgdRNETD6e5ynEArM2nT/n2PpcmqrhTH2InC
         M3gI+YXO3L3S8eJQswBHwzUzvlNJ+kUDmUB9X65eHcc/iDWFt7gZ1tkucMcRyi6YxGao
         rRKz78r5PGlEQrUthkhaqpS9YryzRjqU4mZ0qBoURSzbJ8710RHTlPY+XFN25HgDYAMb
         ddQKeWAit84zQZm3PfiJ0nfDogZImixHcld89vORRZSDEBV2kOqmz37/x+IFS48+0k6S
         FzNA==
X-Gm-Message-State: AOAM533L0hmvyVrdgYO9tpRmhCgxJMdXc+ORpz6gnilAXr3/cEi3AItf
        JzzcEw2jyjIW1DMSITVsnuYTN9Cxa9ocW31i8JNWoQ==
X-Google-Smtp-Source: ABdhPJxKysoN3vBI2CACYHFn97THSD/zihm3s6XrfUVyvAAdSCBB3dWitGdhszi6FKxipStzIhsBOK4PgeQxMLQDCt4=
X-Received: by 2002:a05:6214:1870:: with SMTP id eh16mr4078540qvb.23.1615967289939;
 Wed, 17 Mar 2021 00:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069802205bda22b7f@google.com> <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
 <CAK8P3a1qtHVBY47FfCa6R9+sObzMCwxkREii+O2g8PPopw87eQ@mail.gmail.com>
 <CACT4Y+aC0YWU6gM32S3NoT+-wR7B1-_rhPyh4w542h21UCRRGw@mail.gmail.com>
 <CAK8P3a0zA9pv005d_P_e64j4EwXDh75yC6gNGRVdyy-VzO+7Fw@mail.gmail.com>
 <20210316155102.GP1463@shell.armlinux.org.uk> <CAK8P3a3A=TVWWmog=1YsALUhsaSkqReNrao5OTRd5mwyd0pnig@mail.gmail.com>
 <CACT4Y+a0UxqLCYY8P2qNcS_19LmesXMJf=+DaCOBFVZyS0DkWQ@mail.gmail.com> <CAK8P3a3+hfb2so28xH4cJ_t8mf3H5U0oQJeNOWUAk5dOiQSdTw@mail.gmail.com>
In-Reply-To: <CAK8P3a3+hfb2so28xH4cJ_t8mf3H5U0oQJeNOWUAk5dOiQSdTw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 17 Mar 2021 08:47:58 +0100
Message-ID: <CACT4Y+bwfWJxNaqfcfW7uw4EFFWKpRj-ktjkTkfFCLaZ=p2xDg@mail.gmail.com>
Subject: Re: [syzbot] kernel panic: corrupted stack end in openat
To:     Arnd Bergmann <arnd@arndb.de>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 5:28 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Mar 16, 2021 at 5:13 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Tue, Mar 16, 2021 at 5:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Tue, Mar 16, 2021 at 4:51 PM Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk> wrote:
> > > > On Tue, Mar 16, 2021 at 04:44:45PM +0100, Arnd Bergmann wrote:
> > > > > On Tue, Mar 16, 2021 at 11:17 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > > > The compiler is gcc version 10.2.1 20210110 (Debian 10.2.1-6)
> > > > >
> > > > > Ok, building with Ubuntu 10.2.1-1ubuntu1 20201207 locally, that's
> > > > > the closest I have installed, and I think the Debian and Ubuntu versions
> > > > > are generally quite close in case of gcc since they are maintained by
> > > > > the same packagers.
> > > >
> > > > ... which shouldn't be a problem - that's just over 1/4 of the stack
> > > > space. Could it be the syzbot's gcc is doing something weird and
> > > > inflating the stack frames?
> > >
> > > It's possible, I think that's really unlikely given that it's just Debian's
> > > gcc, which is as close to mainline as the version I was using.
> > >
> > > Uwe's DEBUG_STACKOVERFLOW patch from a while ago might
> > > help if this was the problem though:
> > > https://lore.kernel.org/linux-arm-kernel/20200108082913.29710-1-u.kleine-koenig@pengutronix.de/
> > >
> > > My best guess is something going wrong in the interrupt
> > > that triggered the preempt_schedule() which ended up calling
> > > task_stack_end_corrupted() in schedule_debug(), as you suggested
> > > earlier.
> >
> > FWIW I see slightly larger frames with the config:
> >
> > 073ab64 <ima_calc_field_array_hash_tfm>:
> > 8073ab64:       e1a0c00d        mov     ip, sp
> > 8073ab68:       e92ddff0        push    {r4, r5, r6, r7, r8, r9, sl,
> > fp, ip, lr, pc}
> > 8073ab6c:       e24cb004        sub     fp, ip, #4
> > 8073ab70:       e24ddfa7        sub     sp, sp, #668    ; 0x29c
>
> Yes, this is the one that the compiler complained about when warning
> for stack over 600 bytes. It's not called in this call chain though.
>
> > page_alloc can also do reclaim, I had the impression that reclaim can
> > be quite heavy-weight in all respects.
>
> Yes, that is another possibility. What writable file systems or swap
> do you normally have mounted that it could be writing to, and on
> what storage device?

The root fs is ext4 on virtio-blk.

There are also several dozens of shrinkers that can be called during reclaim:
https://elixir.bootlin.com/linux/latest/C/ident/unregister_shrinker
