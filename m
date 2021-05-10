Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE8C379865
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 22:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhEJUak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 16:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230449AbhEJUaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 16:30:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9CC361433
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 20:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620678573;
        bh=oaTgjDQTfshiY3HK0jVQ1voc8/BEcB5zGI7QMfQSF9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q06fs1u9eYAPV7usG9KN0CKyWOqBRsYrBPlsCUwx6B80+r1iUjyH1mESsLC470rb0
         9IHY3kraSxXK7g5AVCeXPO3QvW3P6Em+LJIeYCFkNr1sph/biWor3a5xvu4+aiZAhn
         uVaO72KqjEBahOywnXCIe7fiCbpsyhB6Az76CMaNXz+5CjtZVEyo40PYG9JiIcy7V+
         t0hrduJGxu+yyhYq5T8S/6VoBhC35aRl1NfZMULyBgYutlz0o1LfkKligyfNGE597p
         rA/XOBC7zAqgeFO8lnmBA8ZpFKpQt9LqU05ocAIA/u8krYeP/Tu5wHgeGh3sHccjYE
         I4KI7JgaB8XNQ==
Received: by mail-ej1-f41.google.com with SMTP id ga25so665118ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 13:29:33 -0700 (PDT)
X-Gm-Message-State: AOAM532UcLqcZa+aoVNO008sIfuxmv4nttODLrX6DWtytYTF/E6qxABK
        pkDdzh1o3RZX2JXM1kEZ7D9RrrBCfAIDAUYmCw==
X-Google-Smtp-Source: ABdhPJxcl8SOaXY48jlx9ihlR2EkCtvL+rPAKiJKWep1AaOyxjKwLWkTvDhPYauk9+U3bqRpKB9Wb6nYXUeQ/huxEDQ=
X-Received: by 2002:a17:906:f1d4:: with SMTP id gx20mr27377644ejb.108.1620678572460;
 Mon, 10 May 2021 13:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <1619115952-155809-1-git-send-email-kan.liang@linux.intel.com> <20210510191811.GA21560@worktop.programming.kicks-ass.net>
In-Reply-To: <20210510191811.GA21560@worktop.programming.kicks-ass.net>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 10 May 2021 15:29:21 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKeVoBL6cn6CGUW17jnf8B+4aHKeyRdceaGCiKzsUsZwg@mail.gmail.com>
Message-ID: <CAL_JsqKeVoBL6cn6CGUW17jnf8B+4aHKeyRdceaGCiKzsUsZwg@mail.gmail.com>
Subject: Re: [PATCH V6] perf: Reset the dirty counter to prevent the leak for
 an RDPMC task
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 2:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Apr 22, 2021 at 11:25:52AM -0700, kan.liang@linux.intel.com wrote:
>
> > - Add a new method check_leakage() to check and clear dirty counters
> >   to prevent potential leakage.
>
> I really dislike adding spurious callbacks, also because indirect calls
> are teh suck, but also because it pollutes the interface so.
>
> That said, I'm not sure I actually like the below any better :/
>
> ---
>
>  arch/x86/events/core.c       | 58 +++++++++++++++++++++++++++++++++++++++++---
>  arch/x86/events/perf_event.h |  1 +
>  include/linux/perf_event.h   |  2 ++
>  kernel/events/core.c         |  7 +++++-
>  4 files changed, 63 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 8e509325c2c3..e650c4ab603a 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -740,21 +740,26 @@ void x86_pmu_enable_all(int added)
>         }
>  }
>
> -static inline int is_x86_event(struct perf_event *event)
> +static inline bool is_x86_pmu(struct pmu *_pmu)
>  {
>         int i;
>
>         if (!is_hybrid())
> -               return event->pmu == &pmu;
> +               return _pmu == &pmu;
>
>         for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
> -               if (event->pmu == &x86_pmu.hybrid_pmu[i].pmu)
> +               if (_pmu == &x86_pmu.hybrid_pmu[i].pmu)
>                         return true;
>         }
>
>         return false;
>  }

[...]

> +bool arch_perf_needs_sched_in(struct pmu *pmu)
> +{
> +       if (!READ_ONCE(x86_pmu.attr_rdpmc))
> +               return false;
> +
> +       if (!is_x86_pmu(pmu))
> +               return  false;
> +
> +       return current->mm && atomic_read(&current->mm->context.perf_rdpmc_allowed);
>  }

Why add an arch hook for something that clearly looks to be per PMU?
Couldn't we add another atomic/flag for calling sched_task() that is
per PMU rather than per CPU. With that, I think I can avoid a hook in
switch_mm() and keep every self contained in the Arm PMU driver.

Rob
