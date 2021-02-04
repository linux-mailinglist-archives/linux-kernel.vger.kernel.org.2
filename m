Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A87B30F48D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbhBDOF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:05:59 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:43036 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbhBDOBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:01:23 -0500
Received: by mail-lj1-f171.google.com with SMTP id t8so3477594ljk.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IkYQ8MA73CmyAwRS5K/xIpOPNoMC5854ODSwlxPV9/A=;
        b=PX3CkzNLoMZEaS24q/PebZzms7QEpF2Rbxb+fBTOPIoPPu6Kbbkk+rNjUjJDQEPArm
         gHGrRW2BGbx3UOElWcnWMgOFmsmoBOfpZh2Ir+3wlwX1//uiLdqMb+S2tjwnEozU9Rgs
         nJ0afKbBbzoRiPUMYvh09ObrO4IksUZ+sQubWfPQVaptQMO/3pW218avOO9cQw3PayVt
         hiOeBO5RHoybbumUFEGEHgPUDHooG0qC7YJkN2kb2+hE8KKo9eKw7LYmK5Ld+nVQxS5z
         30k57ZS9g6SCZFnvx0p//+mjj5e1XwkGqNZLUrPr8pmv09Iah1StQJGRfhTSBULaAgaS
         eYBA==
X-Gm-Message-State: AOAM531hzZ6E/6W4n1VT5IAmCRWvMSETrfySyvo6lohJZiPYk71wSSaF
        5IdNI1RJX45kwzHYhdSRSRqAZvTL2TeRUOBiI6e+bTCo
X-Google-Smtp-Source: ABdhPJxdl9BvqridFQnZdpS6BAEDO/EKgpDO4MauGVe4pevFh4YsOL7KqRIYCA1QoaVZAUBlFsd+jhqhSgjmv7hT9vg=
X-Received: by 2002:a2e:5016:: with SMTP id e22mr4899188ljb.166.1612447235392;
 Thu, 04 Feb 2021 06:00:35 -0800 (PST)
MIME-Version: 1.0
References: <1611873611-156687-1-git-send-email-kan.liang@linux.intel.com>
 <1611873611-156687-2-git-send-email-kan.liang@linux.intel.com> <b970c739-6783-34d6-8676-44632c7c9428@linux.intel.com>
In-Reply-To: <b970c739-6783-34d6-8676-44632c7c9428@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 4 Feb 2021 23:00:23 +0900
Message-ID: <CAM9d7chzwnmSeKydv0Fb_iopcuMZxRsx2mZ66uVwcu_RMw+Vyg@mail.gmail.com>
Subject: Re: [PATCH V3 1/5] perf/core: Add PERF_SAMPLE_WEIGHT_STRUCT
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Yao Jin <yao.jin@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>, maddy@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan,

On Sat, Jan 30, 2021 at 2:25 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
[SNIP]
> diff --git a/include/uapi/linux/perf_event.h
> b/include/uapi/linux/perf_event.h
> index b15e344..c50718a 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -145,12 +145,14 @@ enum perf_event_sample_format {
>         PERF_SAMPLE_CGROUP                      = 1U << 21,
>         PERF_SAMPLE_DATA_PAGE_SIZE              = 1U << 22,
>         PERF_SAMPLE_CODE_PAGE_SIZE              = 1U << 23,
> +       PERF_SAMPLE_WEIGHT_STRUCT               = 1U << 24,
>
> -       PERF_SAMPLE_MAX = 1U << 24,             /* non-ABI */
> +       PERF_SAMPLE_MAX = 1U << 25,             /* non-ABI */
>
>         __PERF_SAMPLE_CALLCHAIN_EARLY           = 1ULL << 63, /* non-ABI; internal use */
>   };
>
> +#define PERF_SAMPLE_WEIGHT_TYPE        (PERF_SAMPLE_WEIGHT |
> PERF_SAMPLE_WEIGHT_STRUCT)

I'm not sure you want to expose it in the uapi header as it's not
intended to be used IMHO.

Thanks,
Namhyung


>   /*
>    * values to program into branch_sample_type when PERF_SAMPLE_BRANCH
> is set
>    *
> @@ -890,7 +892,25 @@ enum perf_event_type {
>          *        char                  data[size];
>          *        u64                   dyn_size; } && PERF_SAMPLE_STACK_USER
>          *
> -        *      { u64                   weight;   } && PERF_SAMPLE_WEIGHT
> +        *      { union perf_sample_weight
> +        *       {
> +        *              u64             full; && PERF_SAMPLE_WEIGHT
> +        *      #if defined(__LITTLE_ENDIAN_BITFIELD)
> +        *              struct {
> +        *                      u32     var1_dw;
> +        *                      u16     var2_w;
> +        *                      u16     var3_w;
> +        *              } && PERF_SAMPLE_WEIGHT_STRUCT
> +        *      #elif defined(__BIG_ENDIAN_BITFIELD)
> +        *              struct {
> +        *                      u16     var3_w;
> +        *                      u16     var2_w;
> +        *                      u32     var1_dw;
> +        *              } && PERF_SAMPLE_WEIGHT_STRUCT
> +        *      #endif
> +        *
> +        *       }
> +        *      }
>          *      { u64                   data_src; } && PERF_SAMPLE_DATA_SRC
>          *      { u64                   transaction; } && PERF_SAMPLE_TRANSACTION
>          *      { u64                   abi; # enum perf_sample_regs_abi
> @@ -1248,4 +1268,29 @@ struct perf_branch_entry {
>                 reserved:40;
>   };
>
> +#if defined(__LITTLE_ENDIAN_BITFIELD)
> +union perf_sample_weight {
> +       __u64           full;
> +       struct {
> +               __u32   var1_dw;
> +               __u16   var2_w;
> +               __u16   var3_w;
> +       };
> +};
> +
> +#elif defined(__BIG_ENDIAN_BITFIELD)
> +
> +union perf_sample_weight {
> +       __u64           full;
> +       struct {
> +               __u16   var3_w;
> +               __u16   var2_w;
> +               __u32   var1_dw;
> +       };
> +};
> +
> +#else
> +#error "Unknown endianness"
> +#endif
> +
>   #endif /* _UAPI_LINUX_PERF_EVENT_H */
