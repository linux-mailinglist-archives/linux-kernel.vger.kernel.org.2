Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27C433D8D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbhCPQN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238502AbhCPQNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:13:49 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2638C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:13:48 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id r14so12033777qtt.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbhnLt5Po3f4G5kXjVguaqd4p3iDZvyNukbT4E52Qls=;
        b=BOyj8/P7Nwc+5cPDa7gAcH6HI5QbkFpZoeri7JOM4JTZf9Q7VBjhaMn/YjIVCFAvc7
         oWD4HH+Px5/hFPs/TvTIwMmYwhUo8PdnEQ7zfQcyK5zoQWADKrNpkD1GLt1Jeih2SYdt
         Wcig87PXy13Po8QOW9RHObYCkIel2GznrGPFLKVVXCGG5lRmZ3blFR0kfkSwD7ZHb+uU
         1HEVDIM1qoHbs3Fyrme9khgO/D4NU3P/7AW36wAUY+QueIcuwtgxHMAbSr6XOjIKvMtG
         O21ufWxOk4AAsv4rNUNW4b7n/16QNkWzyiJ1odPBG1vBJMIr3otTOjkj1gdiYdNQSYlV
         pIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbhnLt5Po3f4G5kXjVguaqd4p3iDZvyNukbT4E52Qls=;
        b=tIh0WmoN4V92yGF10uYXb1k7hFhtyE2W1Ez2KhqnyP4MO70t8zjWPO5p3VVb2b64tr
         dpMZKB1m5+UMWJ/3YD5kUnyOPIoa3ANDrUMoiKGBEncckAqPrVDrI3EuPT4hNaSv8amy
         hlfMAdt5DUQehoVISJ7MkzoW+h9Gr9T76GSkZc5pp0O1MKvKwNLwJ+jXP+YTSa8I/17n
         TJy+b1QjqZwRWiOpm5aNt8MXD0DIEF7301oyKBsIf6RNLZx6mG8d/Ek2GKyPt7zkF9F9
         N7rUvRh+LITm9diKgLg0cqHUvXU5DELapn4OqsHrOmgrLFG7XkGgoEmhdcRm/MZgJuvd
         zOEA==
X-Gm-Message-State: AOAM532o4yQGWQFRm/V8AkXHKAS20bqrxgJ+vJ0rEgR49nyWOsERR1L6
        lDVIuYAZ1112xi7+K59VGH78CqcSqQFYOR/T/6CVpQ==
X-Google-Smtp-Source: ABdhPJyAxwxQDmSMM15n0z9V4H5wXTd3E4ty8mFcjXa3K2UqMp8/sXOv3+YW23BrgCK4XlTQg8Ayb1tzb7ZNtgCaKsg=
X-Received: by 2002:ac8:4558:: with SMTP id z24mr444357qtn.66.1615911227679;
 Tue, 16 Mar 2021 09:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069802205bda22b7f@google.com> <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
 <CAK8P3a1qtHVBY47FfCa6R9+sObzMCwxkREii+O2g8PPopw87eQ@mail.gmail.com>
 <CACT4Y+aC0YWU6gM32S3NoT+-wR7B1-_rhPyh4w542h21UCRRGw@mail.gmail.com>
 <CAK8P3a0zA9pv005d_P_e64j4EwXDh75yC6gNGRVdyy-VzO+7Fw@mail.gmail.com>
 <20210316155102.GP1463@shell.armlinux.org.uk> <CAK8P3a3A=TVWWmog=1YsALUhsaSkqReNrao5OTRd5mwyd0pnig@mail.gmail.com>
In-Reply-To: <CAK8P3a3A=TVWWmog=1YsALUhsaSkqReNrao5OTRd5mwyd0pnig@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 16 Mar 2021 17:13:36 +0100
Message-ID: <CACT4Y+a0UxqLCYY8P2qNcS_19LmesXMJf=+DaCOBFVZyS0DkWQ@mail.gmail.com>
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

On Tue, Mar 16, 2021 at 5:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Mar 16, 2021 at 4:51 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > On Tue, Mar 16, 2021 at 04:44:45PM +0100, Arnd Bergmann wrote:
> > > On Tue, Mar 16, 2021 at 11:17 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > The compiler is gcc version 10.2.1 20210110 (Debian 10.2.1-6)
> > >
> > > Ok, building with Ubuntu 10.2.1-1ubuntu1 20201207 locally, that's
> > > the closest I have installed, and I think the Debian and Ubuntu versions
> > > are generally quite close in case of gcc since they are maintained by
> > > the same packagers.
> >
> > ... which shouldn't be a problem - that's just over 1/4 of the stack
> > space. Could it be the syzbot's gcc is doing something weird and
> > inflating the stack frames?
>
> It's possible, I think that's really unlikely given that it's just Debian's
> gcc, which is as close to mainline as the version I was using.
>
> Uwe's DEBUG_STACKOVERFLOW patch from a while ago might
> help if this was the problem though:
> https://lore.kernel.org/linux-arm-kernel/20200108082913.29710-1-u.kleine-koenig@pengutronix.de/
>
> My best guess is something going wrong in the interrupt
> that triggered the preempt_schedule() which ended up calling
> task_stack_end_corrupted() in schedule_debug(), as you suggested
> earlier.

FWIW I see slightly larger frames with the config:

073ab64 <ima_calc_field_array_hash_tfm>:
8073ab64:       e1a0c00d        mov     ip, sp
8073ab68:       e92ddff0        push    {r4, r5, r6, r7, r8, r9, sl,
fp, ip, lr, pc}
8073ab6c:       e24cb004        sub     fp, ip, #4
8073ab70:       e24ddfa7        sub     sp, sp, #668    ; 0x29c

page_alloc can also do reclaim, I had the impression that reclaim can
be quite heavy-weight in all respects.
