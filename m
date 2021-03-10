Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F95C333433
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 05:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhCJEGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 23:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbhCJEFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 23:05:47 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C63C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 20:05:46 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id a7so16415446iok.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 20:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZ3rtEg/bwCYEb0dkhHomQWwGXuiWcjFrdtbUjGi/nM=;
        b=BlYVfepGwUqTOaZpCTkLZ8ye5WNMoLIiihM0O1hVkvmmwE/11uJH2jDcpeQwCFZr6q
         08b1COfPAU8yCULs66j4vvI+zgoEMoV9VLnUJ88Tm73TIhc2Ira5K8dEc71u3yegDD+9
         l22jzt1kD8syXAmWFS9rdnoLCGv5HIoIlGdArTBeF/KVozfH8pGJ1P37c5rjh1eKAUo5
         TDzhb/hPs0LkMc9efVlJs77fth97iWqeHGiveazyswfo1K3DQ/skbtFxd3JxG9cIpMLl
         pz7J9fZgUF8kY+9dip7p/CxZpfL1iE5hjuhxfK5DtrWz6KDcyodkjdS7MQDhDktzmQTd
         Nj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZ3rtEg/bwCYEb0dkhHomQWwGXuiWcjFrdtbUjGi/nM=;
        b=P5L6QJ7ok6TQSyD59I7shp5/QYsDNAEP+Ap5xg/fMLKR46OmICv6Tfkn9dpmLlYkB8
         LWtEzH2SUzJ11W+NIYUb3xYMlycDbwS+XtpvHdEBKE2GsyMSfHwa7HUFqweGzWmL5aEc
         oP6efmyPnXuZCAcujOWbFBGfxTSdzfFtvDzIxt0V5ayuE/CdlVP3toQBv9wWdIvaAEv1
         sjHQgWqHmfhNyR1Im1V4DCfy0yig4t7lrliJaVEeGo6ua7xrFzYmYZzIclau0Ull/lhK
         Bdy2pOArPccbrl5sf0lZKR9kRalDoJV5p2RdvLG61WBLWuVK1QhAHgfCXS/iLTRUfTSk
         1sjg==
X-Gm-Message-State: AOAM5323+UDzS1INinOr1Lt3ECaN3fwzUNy8Htl29zTGYLbkGUoiJayw
        fA11RYHUOh92guP6F5yq1AxFOPjxwIZnTwSl5A==
X-Google-Smtp-Source: ABdhPJzgHPUMsCwrZ8Z35B2KPUddxLUmwyX1vrqkRcWw0wEr0qKnh/yTNY3WE6lEtTvbScugCVOp8xelmcAqa66FRNs=
X-Received: by 2002:a05:6602:2018:: with SMTP id y24mr1160030iod.74.1615349146331;
 Tue, 09 Mar 2021 20:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20210309102138.41170-1-kernelfans@gmail.com> <20210309140159.GA28395@willie-the-truck>
In-Reply-To: <20210309140159.GA28395@willie-the-truck>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 10 Mar 2021 12:05:35 +0800
Message-ID: <CAFgQCTvgd32_aa4pgjo-+Ob2mETL03N=7TCZJNmhVe4kbEFKGQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/arch_numa: remove rebudant setup_per_cpu_areas()
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 10:02 PM Will Deacon <will@kernel.org> wrote:
>
> [typo in subject "rebudant"]
>
> On Tue, Mar 09, 2021 at 06:21:38PM +0800, Pingfan Liu wrote:
> > There are two identical implementations of setup_per_cpu_areas() in
> > mm/percpu.c and drivers/base/arch_numa.c.
> >
> > Hence removing the one in arch_numa.c. And let arm64 drop
> > HAVE_SETUP_PER_CPU_AREA.
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Atish Patra <atish.patra@wdc.com>
> > Cc: linux-kernel@vger.kernel.org
> > To: linux-arm-kernel@lists.infradead.org
> > ---
> >  arch/arm64/Kconfig       |  4 ----
> >  drivers/base/arch_numa.c | 22 ----------------------
> >  2 files changed, 26 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 1f212b47a48a..d4bf8be0c3d5 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1022,10 +1022,6 @@ config USE_PERCPU_NUMA_NODE_ID
> >       def_bool y
> >       depends on NUMA
> >
> > -config HAVE_SETUP_PER_CPU_AREA
> > -     def_bool y
> > -     depends on NUMA
> > -
> >  config NEED_PER_CPU_EMBED_FIRST_CHUNK
> >       def_bool y
> >       depends on NUMA
> > diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> > index 4cc4e117727d..23e1e419a83d 100644
> > --- a/drivers/base/arch_numa.c
> > +++ b/drivers/base/arch_numa.c
> > @@ -167,28 +167,6 @@ static void __init pcpu_fc_free(void *ptr, size_t size)
> >  {
> >       memblock_free_early(__pa(ptr), size);
> >  }
> > -
> > -void __init setup_per_cpu_areas(void)
> > -{
> > -     unsigned long delta;
> > -     unsigned int cpu;
> > -     int rc;
> > -
> > -     /*
> > -      * Always reserve area for module percpu variables.  That's
> > -      * what the legacy allocator did.
> > -      */
> > -     rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
> > -                                 PERCPU_DYNAMIC_RESERVE, PAGE_SIZE,
> > -                                 pcpu_cpu_distance,
> > -                                 pcpu_fc_alloc, pcpu_fc_free);
>
> This doesn't look identical to the version in mm/percpu.c -- that one passes
> NULL instead of 'pcpu_cpu_distance' and tries to allocate the pcpu memory on
> the relevant NUMA nodes. In fact, if you could remove this function, you
> could probably remove the whole HAVE_SETUP_PER_CPU_AREA block here as the
> other functions are just used as helpers. So I'm not sure this is valid.
>
You are right. I need to rethink about it to see whether these two
functions can be unified into one.

Thanks,
Pingfan
