Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D508337A25
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhCKQ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhCKQ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:57:01 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EB5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:57:01 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id t5so2862633qvs.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YHm9mvHtvSd+8yBU3UFAB1EmCd9wLHSiLTY2qSSEVbo=;
        b=tm8eLqmV95BluK6aHz1yOyLRnITXFAAEdKpyO5gNhmEvld/2VPVmnb1F7TjaAsDHAZ
         gNbYMEEpnzg2qBMa+YP0k63L0Iib96yAvMMIjo3Lw82pQ+mRIve1+x2r5WJ832F8qSke
         feZQ5RyzVfQIYrSprYZIO/mPf0tr12/ZaOHsHKmm9/QlCvtrU37qsG4jQchNDT0eMvIz
         XGnVTO/rI1NQxe+dDWDl4RnthgMnWSHQgH0oJROOZH4UPhIdrAmVmXnZWH1mH2Fn7qSH
         rGhmNz6t7f9H0VJ+erUC+XAJdNkhNPKabZx0tGhcn+30vkC5ER5M+8AsMRFJ7kHlpPRJ
         kLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHm9mvHtvSd+8yBU3UFAB1EmCd9wLHSiLTY2qSSEVbo=;
        b=LMO96y2S2jDdSp3/YMsqxm2PnEXW1w/FEfxwqnz/iRcm6hNYWAK8M6ycwVuHmUQLSR
         DDz6bjAxbFlrbsH+deJLsMQnZZPGiq3hxkvjGX8e6L5djOutn2tP4K/SQOhZu1X2gaEK
         q6spVH/sG0HFIz7WW8wDX4bhyMapO2ozLyRBpY3wdSgIkPJr/k5pQzqNfrYjnDEE4o2B
         H4vQhEpYoRmohyjq7lstP1Nhk9SfUquL5S7gyOLJ/qSbB90GJ/F5LFU8gfRihxvc+tL5
         Vr9b9ss3rQ9P++IKEmLg49O9FfQIB5Kj64G5JglvaHpbNNDytqJEZ0IARm0jXJu1WgtC
         XNCQ==
X-Gm-Message-State: AOAM530l+cuBx+QKYpyJwbvg3JwuxUMGo9EYak90sUw9PWof2CJAGEkr
        dVSfv+/J6BquGzHW11TIovDEYAbYi+a/P58woub73Q==
X-Google-Smtp-Source: ABdhPJy3iOUHKrCBCVlN3MNLy7HqjGjfIX5sfaiGOyTWK8Qtpf4KyLjZ9/xs3jfKEt9MAFHQkuRqrEAYZmRWaR2LU80=
X-Received: by 2002:a05:6214:1870:: with SMTP id eh16mr8375976qvb.23.1615481819992;
 Thu, 11 Mar 2021 08:56:59 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <20210311123315.GF37303@C02TD0UTHF1T.local>
In-Reply-To: <20210311123315.GF37303@C02TD0UTHF1T.local>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Mar 2021 17:56:46 +0100
Message-ID: <CACT4Y+ZPO7D1hGHZvuBQ52Vy2W7UUSW+YFE-Ax6-NMDnmrKTBA@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     maz@kernel.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 1:33 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Mar 11, 2021 at 12:38:21PM +0100, 'Dmitry Vyukov' via syzkaller wrote:
> > Hi arm64 maintainers,
>
> Hi Dmitry,
>
> > We now have some syzbot instances testing arm64 (woohoo!) using qemu
> > emulation. I wanted to write up the current status.
>
> Nice!
>
> > There are 3 instances, first uses KASAN:
> > https://syzkaller.appspot.com/upstream?manager=ci-qemu2-arm64
> > second KASAN and 32-bit userspace test load (compat):
> > https://syzkaller.appspot.com/upstream?manager=ci-qemu2-arm64-compat
> > third uses MTE/KASAN_HWTAGS:
> > https://syzkaller.appspot.com/upstream?manager=ci-qemu2-arm64-mte
> >
> > Kernel configs:
> > https://github.com/google/syzkaller/blob/master/dashboard/config/linux/upstream-arm64-kasan.config
> > https://github.com/google/syzkaller/blob/master/dashboard/config/linux/upstream-arm64-mte.config
>
> FWIW, I keep my fuzzing config fragment in my fuzzing/* branches on
> git.kernel.org, and for comparison my fragment for v5.12-rc1 is:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=fuzzing/5.12-rc1&id=6d9f7f8a2514fe882823fadbe7478228f71d7ab1
>
> ... I'm not sure whether there's anything in that which is novel to you.

Hi Mark,

I've learned about DEBUG_TIMEKEEPING which we had disabled. I am enabling it.
We also have CONTEXT_TRACKING_FORCE disabled. I don't completely
understand what it's doing. Is it also "more debug checks" type of
config?

FWIW we have more debug configs:
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/debug.yml
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/base.yml
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/kasan.yml
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/kmemleak.yml
