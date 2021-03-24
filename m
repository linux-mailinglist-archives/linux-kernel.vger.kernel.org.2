Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7725B346EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 02:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhCXBdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 21:33:20 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:41606 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhCXBcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:32:53 -0400
Received: by mail-lf1-f54.google.com with SMTP id b14so16251433lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 18:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPlGyuHsYMTFJdo8mnBoWVUnbHgk6ZshI4ErqXjbjMo=;
        b=OpRHBaPYEIJNhnT54ZnhgdaCALWJhzcebpVnHhL4+p0U1lF/nMoChYIIfq9jDgUEB1
         F5pXsOw0iZ9LvQ3fEhR1NHriNzcfcH5uM84XbBIfr/2BaQQ4Ll/ZlhGz2ClTtAbgqnJ1
         A6une68Dx9/f9tihnbEvxHRS6NbyDUzOiibiXzqWBXsZ7PIxdjhq7NhjlAvlkmH4FogG
         JFtbt4Ko+Hn3oZmajn5dfSrtnIjV769snC2G9voWgOK+ursjvSdR6nwYWD+yJ0ISVG35
         HXjkQi7b71XhY/M49m7hBWWdyzjjr7+R6xXFe9Q8cFrNvccnEqX8JuaWvsC4cGtzbrza
         mUOQ==
X-Gm-Message-State: AOAM532/2D21K21EXzXlsbHE6km6M7ythImUE3NdfQX4RJKX7i6Osbqm
        oiuzgscdjXcRU9gxO6exjec2wDfNaAlLaF3dhEo=
X-Google-Smtp-Source: ABdhPJxfi2Mf+dSVk5E1f6fDO72JGILV3WZI3NU7FACkW2M+d8vA93SQ5Y9M7X9MCWSqhJJV256Wlc9l6mhy2VcEvGw=
X-Received: by 2002:a05:6512:36c8:: with SMTP id e8mr427590lfs.635.1616549572493;
 Tue, 23 Mar 2021 18:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210322060635.821531-1-like.xu@linux.intel.com> <20210322060635.821531-4-like.xu@linux.intel.com>
In-Reply-To: <20210322060635.821531-4-like.xu@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 24 Mar 2021 10:32:41 +0900
Message-ID: <CAM9d7ci7qj47xDC3z2AzYGjnFdPRNsuEPGivZ1_re-XGhoBwMg@mail.gmail.com>
Subject: Re: [PATCH v4 RESEND 3/5] perf/x86/lbr: Move cpuc->lbr_xsave
 allocation out of sleeping region
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Mar 22, 2021 at 3:14 PM Like Xu <like.xu@linux.intel.com> wrote:
> +void reserve_lbr_buffers(struct perf_event *event)
> +{
> +       struct kmem_cache *kmem_cache = x86_get_pmu()->task_ctx_cache;
> +       struct cpu_hw_events *cpuc;
> +       int cpu;
> +
> +       if (!static_cpu_has(X86_FEATURE_ARCH_LBR))
> +               return;
> +
> +       for_each_possible_cpu(cpu) {
> +               cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
> +               if (kmem_cache && !cpuc->lbr_xsave && !event->attr.precise_ip)
> +                       cpuc->lbr_xsave = kmem_cache_alloc(kmem_cache, GFP_KERNEL);
> +       }
> +}

I think we should use kmem_cache_alloc_node().

Thanks,
Namhyung
