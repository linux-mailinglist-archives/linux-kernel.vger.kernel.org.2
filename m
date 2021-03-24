Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8E434705D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 05:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhCXEFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 00:05:23 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:34664 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhCXEFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 00:05:04 -0400
Received: by mail-lj1-f175.google.com with SMTP id f16so28500524ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 21:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TgVU7M3hkTrPRlTPdUuQz41iZtTwxWQCelmHjTb2Nyw=;
        b=MaE7wEj95QcnMpn9kmDpsc97VT4zFdKbIaGqDUCXYZZ9fHFSFtTbbVjLVyA6MABjKl
         mz8RMldPPVY0Qm9GlBtiakcLtr1Qs3OKOo0SVMIjZOAQMx9qFNHMz+NiRXvbcKhFHmnz
         gYgHWVTO6N6GrCrvIXTgRjKpregU7WIa+PJ+rJCLZ8mukLb0xkkf0vHzfTGfoZTpjIo/
         Bhy19HmOSPZok9LosTGRPjgVPNzp5vG5uU5ou9pY6B88RpkuHv55KSK/0/FMAONDelxx
         KRBoRvortQR1FYSHeui9W4WkBSIYtSaaahz0eDazHSKGBMdRHv8wzg0zqRCd1zWy9e20
         FFoA==
X-Gm-Message-State: AOAM531t2CZOQxvjRIcKdcJo9MS1Dx1YbbBGQMsTbJQwJERBL1YXdbvw
        FGDIfaMBVC68sDcPS62gL4/AyZm8tWn7JEEkJRq7JYh9
X-Google-Smtp-Source: ABdhPJwuTZkfudwfmSrLG88G1i63zGoWR6QAKCkBuRa3c48GySBQSNn/z2MVi4pH+7y9X4tk89IvBauilaXzd5meS5o=
X-Received: by 2002:a2e:5057:: with SMTP id v23mr696969ljd.393.1616558703541;
 Tue, 23 Mar 2021 21:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210322060635.821531-1-like.xu@linux.intel.com>
 <20210322060635.821531-4-like.xu@linux.intel.com> <CAM9d7ci7qj47xDC3z2AzYGjnFdPRNsuEPGivZ1_re-XGhoBwMg@mail.gmail.com>
 <5fda3599-1b51-5f58-fdcc-2afcf6d4968b@linux.intel.com>
In-Reply-To: <5fda3599-1b51-5f58-fdcc-2afcf6d4968b@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 24 Mar 2021 13:04:52 +0900
Message-ID: <CAM9d7cgouGAAt46qe_DGqMX0xzYF3a0ZQw2aXFwdxo4d66d18A@mail.gmail.com>
Subject: Re: [PATCH v4 RESEND 3/5] perf/x86/lbr: Move cpuc->lbr_xsave
 allocation out of sleeping region
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 12:47 PM Like Xu <like.xu@linux.intel.com> wrote:
>
> Hi Namhyung,
>
> On 2021/3/24 9:32, Namhyung Kim wrote:
> > Hello,
> >
> > On Mon, Mar 22, 2021 at 3:14 PM Like Xu <like.xu@linux.intel.com> wrote:
> >> +void reserve_lbr_buffers(struct perf_event *event)
> >> +{
> >> +       struct kmem_cache *kmem_cache = x86_get_pmu()->task_ctx_cache;
> >> +       struct cpu_hw_events *cpuc;
> >> +       int cpu;
> >> +
> >> +       if (!static_cpu_has(X86_FEATURE_ARCH_LBR))
> >> +               return;
> >> +
> >> +       for_each_possible_cpu(cpu) {
> >> +               cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
> >> +               if (kmem_cache && !cpuc->lbr_xsave && !event->attr.precise_ip)
> >> +                       cpuc->lbr_xsave = kmem_cache_alloc(kmem_cache, GFP_KERNEL);
> >> +       }
> >> +}
> >
> > I think we should use kmem_cache_alloc_node().
>
> "kmem_cache_alloc_node - Allocate an object on the specified node"
>
> The reserve_lbr_buffers() is called in __x86_pmu_event_init().
> When the LBR perf_event is scheduled to another node, it seems
> that we will not call init() and allocate again.
>
> Do you mean use kmem_cache_alloc_node() for each numa_nodes_parsed ?

I assume cpuc->lbr_xsave will be accessed for that cpu only.
Then it needs to allocate it in the node that cpu belongs to.
Something like below..

    cpuc->lbr_xsave = kmem_cache_alloc_node(kmem_cache, GFP_KERNEL,
                                               cpu_to_node(cpu));

Thanks,
Namhyung
