Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4B833EBD7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbhCQIup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhCQIud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:50:33 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFA7C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:50:33 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id d10so1003917qve.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PXKpgD8S0tpfF/4Jl42if8dBS2c84WD9R/ZEPqRwZqw=;
        b=Cyp4O4UBuKuRaZgByLxhrwpPMaWHFFb0EOD2eak0VGOkqSzdtZZjavXFfYxFv65j5Q
         Ii9UYCYGe3D34How2UtG4DECdWJLIdkgvbNPsDFMOqc9JqvkAMmEpSD7qbklrI9u2l+k
         DD3Xbpd4DV2kzt99QVluZdvlDPaoJL+oRQ+jeJf5x2mVkBVYR5NtTjhbKdbAE2tqhydN
         voh+Nuav3DagG7xs8bjp1gB59j9YBEFngNV3TK/Eq/EvKxSJWBlGYMR88/tNYPdDl6cR
         UCpAHQyUjJLLoREOtLr031OlbQ3Dz7ROz8FcwoT3jwyqnB9ZFsrmv4gmneVZgIEPCxkQ
         YmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PXKpgD8S0tpfF/4Jl42if8dBS2c84WD9R/ZEPqRwZqw=;
        b=IkoSPuZaUwLmcYlrfO69Z6uouUh6B/PnRQ0FK5sJ8Behcg50Jnxm2gq9r6pmcYg0Eg
         2IdQLxVVbFijAUz+j9MzHdtni6TmqrAzq4y8u41KOYWNR8kPvmi+/3ankA4BFlBBgpyK
         hMtTbzM+Y5f7GTM/Wc6wVIYVHmRvgTjRhABFatYMYQDXZj4cHI/YKvcqXjMn1WtMlaEb
         iqKnGDh71+bA1YO3SmmqwF+Hueo1nyjHXVQeHp+rVjNXlg8LXeGYBPso4OumTUQsBQVR
         uRwenIRCRRdMCnXFRe4rjAwCoGoE9cBMwiz4QHvLHTspvEVRJjcOngWnyX3pMVE2qpX1
         UpVw==
X-Gm-Message-State: AOAM531aEGFGRgbiVbqmmAWvnpbVvE4+Xgr4zS/KQ2REsGHDhDN5YyBR
        talDxbt59JhFOqSn7zAxmNS7n8nvULOcondEpMvMOw==
X-Google-Smtp-Source: ABdhPJw3MvrVFRDb5uadNU8fguI0OEoyzAIb8cGdqhM4lMMYb67TEvNwJKTW5/8us9UzH1Z/T0qce0OV+S/oY02V9zY=
X-Received: by 2002:a0c:8304:: with SMTP id j4mr4356484qva.18.1615971032019;
 Wed, 17 Mar 2021 01:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069802205bda22b7f@google.com> <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
 <CAK8P3a1qtHVBY47FfCa6R9+sObzMCwxkREii+O2g8PPopw87eQ@mail.gmail.com>
 <CACT4Y+aC0YWU6gM32S3NoT+-wR7B1-_rhPyh4w542h21UCRRGw@mail.gmail.com>
 <CAK8P3a0zA9pv005d_P_e64j4EwXDh75yC6gNGRVdyy-VzO+7Fw@mail.gmail.com>
 <20210316155102.GP1463@shell.armlinux.org.uk> <CAK8P3a3A=TVWWmog=1YsALUhsaSkqReNrao5OTRd5mwyd0pnig@mail.gmail.com>
 <CACT4Y+a0UxqLCYY8P2qNcS_19LmesXMJf=+DaCOBFVZyS0DkWQ@mail.gmail.com>
 <CAK8P3a3+hfb2so28xH4cJ_t8mf3H5U0oQJeNOWUAk5dOiQSdTw@mail.gmail.com>
 <CACT4Y+bwfWJxNaqfcfW7uw4EFFWKpRj-ktjkTkfFCLaZ=p2xDg@mail.gmail.com> <CAK8P3a1cjw419WZ=B5oPs7z4_6b6mxRwMjSJB0Q1eh5TpQoT9g@mail.gmail.com>
In-Reply-To: <CAK8P3a1cjw419WZ=B5oPs7z4_6b6mxRwMjSJB0Q1eh5TpQoT9g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 17 Mar 2021 09:50:20 +0100
Message-ID: <CACT4Y+Y+x=Lj6dC+ozvttq_RNrSUzX+pQmyg8N9ELokr5ce0Mg@mail.gmail.com>
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

On Wed, Mar 17, 2021 at 9:32 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > <linux@armlinux.org.uk> wrote:
> > > > > > On Tue, Mar 16, 2021 at 04:44:45PM +0100, Arnd Bergmann wrote:
> > > > > > > On Tue, Mar 16, 2021 at 11:17 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > > > > > The compiler is gcc version 10.2.1 20210110 (Debian 10.2.1-6)
> > > > > > >
> > > > > > > Ok, building with Ubuntu 10.2.1-1ubuntu1 20201207 locally, that's
> > > > > > > the closest I have installed, and I think the Debian and Ubuntu versions
> > > > > > > are generally quite close in case of gcc since they are maintained by
> > > > > > > the same packagers.
> > > > > >
> > > > > > ... which shouldn't be a problem - that's just over 1/4 of the stack
> > > > > > space. Could it be the syzbot's gcc is doing something weird and
> > > > > > inflating the stack frames?
> > > > >
> > > > > It's possible, I think that's really unlikely given that it's just Debian's
> > > > > gcc, which is as close to mainline as the version I was using.
> > > > >
> > > > > Uwe's DEBUG_STACKOVERFLOW patch from a while ago might
> > > > > help if this was the problem though:
> > > > > https://lore.kernel.org/linux-arm-kernel/20200108082913.29710-1-u.kleine-koenig@pengutronix.de/
> > > > >
> > > > > My best guess is something going wrong in the interrupt
> > > > > that triggered the preempt_schedule() which ended up calling
> > > > > task_stack_end_corrupted() in schedule_debug(), as you suggested
> > > > > earlier.
> > > >
> > > > FWIW I see slightly larger frames with the config:
> > > >
> > > > 073ab64 <ima_calc_field_array_hash_tfm>:
> > > > 8073ab64:       e1a0c00d        mov     ip, sp
> > > > 8073ab68:       e92ddff0        push    {r4, r5, r6, r7, r8, r9, sl,
> > > > fp, ip, lr, pc}
> > > > 8073ab6c:       e24cb004        sub     fp, ip, #4
> > > > 8073ab70:       e24ddfa7        sub     sp, sp, #668    ; 0x29c
> > >
> > > Yes, this is the one that the compiler complained about when warning
> > > for stack over 600 bytes. It's not called in this call chain though.
> > >
> > > > page_alloc can also do reclaim, I had the impression that reclaim can
> > > > be quite heavy-weight in all respects.
> > >
> > > Yes, that is another possibility. What writable file systems or swap
> > > do you normally have mounted that it could be writing to, and on
> > > what storage device?
> >
> > The root fs is ext4 on virtio-blk.
> >
> > There are also several dozens of shrinkers that can be called during reclaim:
> > https://elixir.bootlin.com/linux/latest/C/ident/unregister_shrinker
>
> Right, unfortunately I don't see a smoking gun there either, unless you are
> also using NFS or devicemapper.
>
> Implementing VMAP_STACK as you suggested earlier is probably the
> best way to figure out if there is an actual overrun of the stack.
> Alternatively, adding support for GCC_PLUGIN_STACKLEAK might
> also help find out if we ever get close to the limit. This is probably
> less work, but it might not actually help in this case.

VMAP_STACK is quite intrusive as far as I understand. For KASAN I
considered a simpler option: have a debug config that allocates an
extra page after the stack and mprotect's it. It wastes a physical
page per task (fine for a debug config), but I would assume should be
radically simpler to implement. In the end somebody implemented proper
VMAP_STACK support for KASAN, but I still think it may be a reasonable
compromise between time investment and value.
