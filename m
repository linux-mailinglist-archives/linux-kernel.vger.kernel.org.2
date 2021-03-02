Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E540232AA8B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839807AbhCBToY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579861AbhCBRLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:11:12 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5C9C0611C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 09:02:29 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w11so20628757wrr.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 09:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2twvRoA3NAihouq+BGmazRF+N6tq+OJ4ANyVz+dJYmQ=;
        b=yOYXKLEW9xqrQyEkADuSYJ2910/i3eUbAXE6nfCokgYzZF31tKBDLFEpqn2mquvCqD
         z2jUkrRTmL69Al5ClM37EFCIv5ltbmap4+7CCeytDtB/yGT8xBpsP5dzv8UH2LLLZXOo
         VDBG3WeARx50Ft5hVQ7D6sWifDxQ7mnQm/IEj3kLlaEjYy076qbGyN11VGUk4zIkF7jX
         1MKH7lh4rzCmhSufCKy4mYP2wEbZimYjPoFHPSFFSky2YbsUwSKNcGUEEN6we9AX4AFs
         E1AO5BAnIVmxonmiuAEzHyCJOF8LRimE6ddOVfql67O5PgpZUKR5JUXw8YYP/4s7eQUG
         z0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2twvRoA3NAihouq+BGmazRF+N6tq+OJ4ANyVz+dJYmQ=;
        b=to9LqXAbGgN+14qoBRkotYe7i6MQuJG4rbYPRVuEue6EaG9dZtmgV92/WCkObCAXzC
         dKtMsbjRO9AAywpo7Pi9aVajBeh2XsBF0hOUrjSKjJ9ICP5G79c/7hXbeCpUT/cJvcxc
         TOMiz64wxarslUdjyIeCW7+mj6FQ3d7n6/uu6xXziNOed8jKu9BYOjhbf0G42GR8rUer
         KOtemiI1zXuhDJL9jJ5+54cgvwkdxvJLCx6jFxFCbR2PW1LHmtSdyfCLUAzpo5ATP+6W
         3tjfo5f81OundnW7bjjalRx4TtcS3SyEEckOyDoiyqHy8UvNjt0O+EQmEdXaB7K7fl5I
         nTTQ==
X-Gm-Message-State: AOAM532JCANbPvKcK0QSAgQkn/vNqdLdKKcYwpQJfNSqPptiRxOsv3SU
        sVci+Mhhb15XWu5Z6DuyVG99raYfF6EVNFNUnrrDMg==
X-Google-Smtp-Source: ABdhPJyZylNWGCXM8kX0RArUB9xsjfbomu24WxVC1n0jTvfiH8yd/AeGl7pX3HYbrqFfVrhEn7FXSdGvOglsrCMowoA=
X-Received: by 2002:a5d:558b:: with SMTP id i11mr22567539wrv.176.1614704548486;
 Tue, 02 Mar 2021 09:02:28 -0800 (PST)
MIME-Version: 1.0
References: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
 <YD41GUtuq8fVa4Q6@kernel.org> <CAJ9a7ViKLg8vjBnuA1eWh8b5-PN7RryefyOV1qoX9Zu362Eq8Q@mail.gmail.com>
 <YD5mu7Df3fXiWZuk@kernel.org> <20210302164254.GA3789438@xps15>
In-Reply-To: <20210302164254.GA3789438@xps15>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 2 Mar 2021 17:02:17 +0000
Message-ID: <CAJ9a7Vg5H-UUr9B3iOG4FqtgF=f3-2p8-VVqCCoegbrLn_GMjA@mail.gmail.com>
Subject: Re: [PATCH 0/6] coresight: Patches for v5.12 (perf tools)
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 at 16:42, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> On Tue, Mar 02, 2021 at 01:24:27PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Mar 02, 2021 at 02:23:14PM +0000, Mike Leach escreveu:
> > > On Tue, 2 Mar 2021 at 12:52, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > Em Wed, Feb 24, 2021 at 09:48:29AM -0700, Mathieu Poirier escreveu:
> > > > > I noticed there is a couple of patchsets [1][2] that haven't made it
> > > > > to your tree for the coming v5.12 cycle.  Do you think that can still
> > > > > be done?
> >
> > > > > I tallied the patches here to make it easier for you to pick up.
> >
> > > > > Applies cleanly on perf/core (84b7725536d8)
> >
> > > > > [1]. https://lore.kernel.org/lkml/20210202214040.32349-1-mike.leach@linaro.org/
> > > > > [2]. https://lore.kernel.org/lkml/20210213113220.292229-1-leo.yan@linaro.org/
> >
> > > > These are not applying right now, I've pushed what I have to
> > > > tmp.perf/core, please take a look, I'll get back to this after
> > > > processing fixes for v5.12 and what is outstanding for v5.13.
> >
> > > I've tried [1] on both Linux-5.12-rc1 and your tmp.perf/core and it
> > > applies cleanly on both.
> >
> > Can you please try one more time, these are the last csets on this
> > branch:
> >
> >   $ git log --oneline acme/tmp.perf/core -10
> >   8e1488a46dcf73b1 (HEAD -> perf/core, five/perf/core, acme/tmp.perf/core, acme.korg/tmp.perf/core) perf cs-etm: Detect pid in VMID for kernel running at EL2
> >   47f0d94c203751dd perf cs-etm: Add helper cs_etm__get_pid_fmt()
> >   30cb76aabfb4deab perf cs-etm: Support PID tracing in config
> >   8c559e8d68630d64 perf cs-etm: Fix bitmap for option
> >   2bb4ccbd95d7fbf5 tools headers UAPI: Update tools' copy of linux/coresight-pmu.h
> >   42b2b570b34afb5f perf cs-etm: Update ETM metadata format
> >   83bf6fb8b076c72f perf vendor events power9: Remove unsupported metrics
> >   34968b9327c83589 perf buildid-cache: Add test for PE executable
> >   9bb8b74bdb186bd3 perf docs: Add man pages to see also
> >   d9fd5a718977702f perf tools: Generate mips syscalls_n64.c syscall table
> >   $
>
> As far as I can tell you have all 6 patches.
>

Agreed - [1] I was trying is in fact:
42b2b570b34afb5f perf cs-etm: Update ETM metadata format
in the above list.

Mike

> >
> > I think it doesn't apply because I applied a series from Mathieu
> > touching files affected by those two patchkits.
> >
> > - Arnaldo
> >
> > > Let me know if there is anything else I can try.
> > >
> > > Thanks
> > >
> > > Mike
> > >
> > >
> > >
> > > --
> > > Mike Leach
> > > Principal Engineer, ARM Ltd.
> > > Manchester Design Centre. UK
> >
> > --
> >
> > - Arnaldo



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
