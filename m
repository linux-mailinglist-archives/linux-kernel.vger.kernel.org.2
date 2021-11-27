Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108FE45F787
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 01:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344122AbhK0ApX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 19:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343903AbhK0AnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 19:43:21 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C202BC06175E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 16:40:03 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y8so7657010plg.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 16:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pAACPXPhIuNsU0wrwwPt8Pk5CS4bN+wWyKedlGDLZHY=;
        b=kUcdL3IP/6MwQb1slgFiwipM/4Y0+XW4dlmHB319dOafXEycXLgP4T6SPoIVLGs/il
         JXRMCNDKQpoPoMaAEz8Yth4e4GrSLb5q9i+FBbD8xGcZ2bD3LTzbs2gLhKd9Q9ID8cgl
         I0NrXAUGhM6FfFZGaTRVTpaj4ZMwmtE2Zy2uX4G7eYabK2qpYgIoN7/KPblQ48q19e98
         M+ANae3BhZujlXZqVVc+Z4WrG0dmEmqwHNhu3gIYj3PdRkwNyU/AJj6a4PHnnuvOVpwU
         CTXytLczVu+MfvHjcUScN79MP9Zz9hDicdKUlwCjAhkVVcONaNF1q00JQaiPOpCmLGov
         YBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pAACPXPhIuNsU0wrwwPt8Pk5CS4bN+wWyKedlGDLZHY=;
        b=A5lyeR00MTBDVK46NZNvAKqpBcf/p4tzJbe2y7gow39OuRF7jZ0nQr8cLp84G/utG6
         aO0x2x/wlCYxrAAcxmHID24SuE9qEIyP1G09MlKYFsDRPIlXY65iZiTENMgNhBj8w2Ea
         sYOMXIyvGnPVlOYc3qqL5m6x1yIzmbSLOJlvewwO/leouvToSqdo2f8vsqd6BG1BWEeC
         ru4KDQlze2+mgKJudezGEFKK9kbRENs9u4R0rruw74MBcdUlRxSmOe0Uu52S2N3m8kz1
         B+bCesl10ttY2zm8Itt+A9q2ZDgXry6gWv4VAu8sjNmHobYowKnnLEFH4NU4emWdd4TV
         5+lw==
X-Gm-Message-State: AOAM53190uDcnvorGwcTXIyOUTtCi5y5XPr5lV+2pN2SVXG7U1Sbccgz
        T8kp0wNOi5zSVWoxrtsA5sOno3ykKUojrIWMIDo=
X-Google-Smtp-Source: ABdhPJz1sXzzELcqoiTWktqNNKcmIX0Hu+WvFmlPH8wq8ixCidrwGUY6CInukEB38lXWPWWIxTmP5YQetF3HDIg9wR0=
X-Received: by 2002:a17:903:32d1:b0:142:1ce1:30c9 with SMTP id
 i17-20020a17090332d100b001421ce130c9mr41552222plr.0.1637973603351; Fri, 26
 Nov 2021 16:40:03 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com>
 <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com>
 <CANn89iJA1JOevgLSK019VYXKkLJsMjV-u9ZHvrgZ+XUypRWwfQ@mail.gmail.com>
 <CAFUsyfLeVGW8etXHuSGvYy_RoS3RGaA1L+NLKnpc7EsSMVORBg@mail.gmail.com>
 <CANn89iJxMhGfp364rPu6p_ZLrKnM1qWF_NWrw4_oL_KG+piByg@mail.gmail.com>
 <CAFUsyfJ33cKFQdUagHQ_b4N80CfBtGQZhyA4CN_JLgEmXEX=DA@mail.gmail.com>
 <CAFUsyf+TuU2Xe5Guy5yiFWsV-JZSjUJxcGZv=f0BYDSmODV+_w@mail.gmail.com>
 <CANn89iLjw7YeWNGNtVNi690adJfoSVwgLScrtx-zSyh=COZRsQ@mail.gmail.com>
 <CAFUsyfK5r+P6aQLBpYZoi0FSgvLwfawBUYTHtQL0TJRozujp3g@mail.gmail.com>
 <CANn89iKkK0eMQkOTSMGbvdtf+G=eRfXJG0Semju5h-C63QytaQ@mail.gmail.com>
 <CAFUsyf+9F9b2V-YDm8UdbnANrQ0_fYV6cGfRgPciASfvp9p=7w@mail.gmail.com> <CANn89iJb_2666U4qgrqsjqEyT9_rA9SKRThbdy_--4_X8rFMYg@mail.gmail.com>
In-Reply-To: <CANn89iJb_2666U4qgrqsjqEyT9_rA9SKRThbdy_--4_X8rFMYg@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Fri, 26 Nov 2021 18:39:52 -0600
Message-ID: <CAFUsyfLV2Jws3QywyPsePuHSRb2sMiR99z1ohJqVVjs91C0VcQ@mail.gmail.com>
Subject: Re: [PATCH v1] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
To:     Eric Dumazet <edumazet@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        X86 ML <x86@kernel.org>, hpa@zytor.com, peterz@infradead.org,
        alexanderduyck@fb.com, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 6:15 PM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Nov 26, 2021 at 12:33 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> >
> > On Fri, Nov 26, 2021 at 2:07 PM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Fri, Nov 26, 2021 at 11:50 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> > > >
> > > > Bright :) but it will need a BMI support check.
> > >
> > > Yes, probably not worth the pain.
> >
> > Making a V2 for my patch with your optimization for the loop case. Do you think
> > 1 or 2 accum for the 32 byte case?
> >
>
> I would vote for something simpler, thus one accum, since this 32byte
> block is only run one time ?

If the one at a time performance is whats the most important wouldn't that
argue in favor of 2x accum because it lead to decreased latency? Or are you
saying it's not that important so simpler codes is the priority?

>
> Thanks !
