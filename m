Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBE0338621
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhCLGnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCLGnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:43:01 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32162C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 22:43:01 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id t16so3785501qvr.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 22:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+gDfhRK8SeEpvOytoMC9TfOJ2HPdOSZgyvUXbZYZlfA=;
        b=DSO+oaQ82KThjwUxwdCvoYLgfwmpi067P7qeagoh7V31NwkJoT/5t1Px9kTYGNMy73
         OfqSRuM5KBYnVKFni30I40a7VBIOY/VX9TqUrljOQK8ri2ZAWlqh5bnCpblzN6/yFpYQ
         3xGI7JDuLrwsZ69VnLBfzfyfL/pwjHF5I+RVK3hxIVO7Mcf8gSPy4B+Jeglwq9wSPKN5
         D/2fwLoZhc5qGDald/YH415G/Iz1JVzY1BP37CgnBzPimtinL6MVDT9O2OlOsTOS4H0p
         dMQUPWqf24Ir7V4oxz3K85CiT2DKscmXEIWpzKBw3y6LqXb7gyje2RnuCZg/3CBx0CkO
         GNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+gDfhRK8SeEpvOytoMC9TfOJ2HPdOSZgyvUXbZYZlfA=;
        b=TCJSmagDwAPt1dFFUQHP3qaCkrtWN0vCpE6UNGeq0bYK4TB/jPA8hl6uOwPQ7Njch6
         QenNHhvx7+xoSDnRWML5Dw+keP1Pm3vrScVMNWdj9WJmOJxp6w5ISmYCF2fbfH4dJ6T1
         Ax/pbYdTMwQnGgSCEBRO9/32d8L6lWIqM6bYz9YTaQhwblAC3QW6+UWninV+NLZaPLWe
         +vLOkN2mr54p7oKFfSNbm609shpYZ99kSmkRzhevW3veEjTq7osGSXYfHUVk01Wre5S7
         uNcdB5W5UQssuR348AOZfnPbKP62S7zI5Wa8H/ezFrTV8ftlIAOpfDWExhElDZlDs5S3
         ObiQ==
X-Gm-Message-State: AOAM5323mcvsLfj5fo6Rp8rglnDwChZehG09as4UbSJEZFRvvJYBFLOm
        NEJG6A9y7HYbr2BMwEMCIyKvvNQvnOmj3XOHo2UboQ==
X-Google-Smtp-Source: ABdhPJzEM5s3oSLjaZ27Xt6uQrIo7xYZejVL47bJMdFf1WyDWoWrCwJKNMe0ItOU8/gUOKtLiPND3VPONn5iYvql2co=
X-Received: by 2002:ad4:410d:: with SMTP id i13mr10778021qvp.44.1615531380220;
 Thu, 11 Mar 2021 22:43:00 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com> <CACT4Y+Z_Req6qLArMOH0FHR92cTPyv+PLM91CCjkSw4Ua_vWjw@mail.gmail.com>
In-Reply-To: <CACT4Y+Z_Req6qLArMOH0FHR92cTPyv+PLM91CCjkSw4Ua_vWjw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Mar 2021 07:42:48 +0100
Message-ID: <CACT4Y+aWtSRdq+P_pVXb2yXKzwiF9ECuy2B7yGW8dC-emRv5Fw@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 6:25 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Mar 11, 2021 at 2:30 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Thu, Mar 11, 2021 at 12:38 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > The instances found few arm64-specific issues that we have not
> > > observed on other instances:
> >
> > I've had a brief look at these:
> >
> > > https://syzkaller.appspot.com/bug?id=1d22a2cc3521d5cf6b41bd6b825793c2015f861f
> >
> > This one  doesn't seem arm64 specific at all. While the KASAN report has shown
> > up on arm64, the link to
> > https://syzkaller.appspot.com/bug?id=aa8808729c0a3540e6a29f0d45394665caf79dca
> > seems to be for x86 machines running into the same problem.
>
> You are right. It's probably a consequence of some configs being enabled.
> I think we need to enable CONFIG_FW_LOADER_USER_HELPER on x86_64
> upstream instances as well.
>
>
> > Looking deeper into the log, I see that fw_load_sysfs_fallback() finds
> > an existing
> > list entry on the global "pending_fw_head" list, which seems to have been freed
> > earlier (the allocation listed here is not for a firmware load, so presumably it
> > was recycled in the meantime). The log shows that this is the second time that
> > loading the regulatory database failed in that run, so my guess is that it was
> > the first failed load that left the freed firmware private data on the
> > list, but I
> > don't see how that happened.
>
> Can it be as simple as: fw_load_sysfs_fallback adds fw to the pending
> list, but then returns with an error w/o removing it from the list?
> There are some errors checks after that:
> https://elixir.bootlin.com/linux/v5.12-rc2/source/drivers/base/firmware_loader/fallback.c#L536
> and it seems that the caller deletes fw in this case:
> https://elixir.bootlin.com/linux/v5.12-rc2/source/drivers/base/firmware_loader/main.c#L839

I've enabled CONFIG_FW_LOADER_USER_HELPER for all instances and syzbot
come up with a repro and KASAN report with alloc/free stacks:
https://lore.kernel.org/lkml/000000000000af467105bd5128fc@google.com/
