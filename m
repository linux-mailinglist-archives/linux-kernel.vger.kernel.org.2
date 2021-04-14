Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E78D35F5A4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351705AbhDNNwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:52:02 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:34747 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351696AbhDNNvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:51:44 -0400
Received: by mail-lf1-f52.google.com with SMTP id n8so33405212lfh.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 06:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8GENsGc8D0bKDNdsjagU87Bnfm8Z5B+0SU7YS0JYXA=;
        b=jytwxLlO9c+x8F7zs/nxFzEfx4cCz0rgCBJej+qOmNeEcWEecHBsYrGluIsIB3IUel
         yoGDA2dikKm/PKM8rZx0sRMxXSbMiGRyhiIl+Ldl+ZSn0xDhs+MTPY0zgnb+HFhhQCAo
         z2yL1qfkErB9JpsvPRwijNBPHT/1woGPMAXc42CA0ezmbANCnKLDgLhqoribTgdRodJJ
         xYnCq3gLGOVBJPDhKiErU/oBApPw7odezd1GZ9kEeOpegSSEhbV3MEdGJ8fgQx2yytIL
         XCZri0DmgttddU7OkfsqBIZK5tmkfTR2+apABnnikg/iRgZD9dHqKfNIlbFyAK6dw9rD
         8teg==
X-Gm-Message-State: AOAM531cXn5w21P4AYUQITPS/qB6chZswtPxSmlnuk3JQtyiqHKRMxe9
        AMLCEozk2X7w9JuTWihpxUecQ+/OMuSSTl8PUUs=
X-Google-Smtp-Source: ABdhPJxgXsa30G6dmtMuy9XPZrhE6KZjOalKymu23s1Yjnp/j7vCBaFluI1b2hOOKLhf6pFRoAranB9yvnflJmwyUgM=
X-Received: by 2002:a05:6512:2033:: with SMTP id s19mr26119138lfs.300.1618408281029;
 Wed, 14 Apr 2021 06:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <1618340250-29027-1-git-send-email-kan.liang@linux.intel.com> <1618340250-29027-2-git-send-email-kan.liang@linux.intel.com>
In-Reply-To: <1618340250-29027-2-git-send-email-kan.liang@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 14 Apr 2021 22:51:09 +0900
Message-ID: <CAM9d7cijoqGDAHa8FSj8VcLWSLUugiRJe6ZC5eVq4MoTAGh_AA@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>, luto@amacapital.net,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan,

On Wed, Apr 14, 2021 at 4:04 AM <kan.liang@linux.intel.com> wrote:
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index dd9f3c2..0d4a1a3 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1585,6 +1585,8 @@ static void x86_pmu_del(struct perf_event *event, int flags)
>         if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
>                 goto do_del;
>
> +       __set_bit(event->hw.idx, cpuc->dirty);
> +
>         /*
>          * Not a TXN, therefore cleanup properly.
>          */
> @@ -2304,12 +2306,46 @@ static int x86_pmu_event_init(struct perf_event *event)
>         return err;
>  }
>
> +void x86_pmu_clear_dirty_counters(void)
> +{
> +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +       int i;
> +
> +       if (bitmap_empty(cpuc->dirty, X86_PMC_IDX_MAX))
> +               return;

Maybe you can check it after clearing assigned counters.

Thanks,
Namhyung

> +
> +        /* Don't need to clear the assigned counter. */
> +       for (i = 0; i < cpuc->n_events; i++)
> +               __clear_bit(cpuc->assign[i], cpuc->dirty);
> +
> +       for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
> +               /* Metrics and fake events don't have corresponding HW counters. */
> +               if (is_metric_idx(i) || (i == INTEL_PMC_IDX_FIXED_VLBR))
> +                       continue;
> +               else if (i >= INTEL_PMC_IDX_FIXED)
> +                       wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
> +               else
> +                       wrmsrl(x86_pmu_event_addr(i), 0);
> +       }
> +
> +       bitmap_zero(cpuc->dirty, X86_PMC_IDX_MAX);
> +}
