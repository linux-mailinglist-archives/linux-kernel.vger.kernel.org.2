Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7F531178D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBFABj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhBENtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:49:21 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57AAC061793
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 05:48:15 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d16so7696362wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 05:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWpWa4+1iKK+RayrUT+yCSDT3owhoX+eHjAu9iJ6SQA=;
        b=L5Dn0vcvyEXFBBJKfAy5VQe/Mn7LuBycukT87RR+YDc/YRySpJULagRcC1u9wqARap
         7Z86qj3yTj3z3a4Clp+dlpR/eajmmY5KSBcWoRoY3omiF0r/9OpSo0zlJk65QMQ9TBek
         x6gu/WzYBK+n1YWvY4Y//8mTxJzutRXcLsUWAMdqPP942YXU6nL3kgv21SA524yeOany
         DAorm2uo3bnlShcZgOEh29Heh3mwD/uT2AUzu7M4F9hr0PJGhQ3FN+s5PTuM5JCfw44H
         /6Skyw+bE+6zQT5Gk1KeWYeR8QP+9lVCX3kTZUyH1qC1rywWVUr69kIXjhmcW35aPl3D
         p7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWpWa4+1iKK+RayrUT+yCSDT3owhoX+eHjAu9iJ6SQA=;
        b=rhdK3JBR/l21tA+7lrnp+I0pilY1t9stX+4B5pRHAXwmm7C/p7Xn5KxXmwiti5tRj3
         O7qfxOkIYY96vOEy44IccGUnNQZVpY1HxfEylmqUA5CADRuba2Aq38J3Y7MCRXejE0sX
         zIvlrwz9X6U9LhRLuqPf45crvVw7m+MEWhtXOvGaw+DPyddVs7gRka+zaGO5V8IZELVP
         VlN4Pn9qI9piHTuQVBjtb1C2SrDZKpjYxk41ZcF6BKv9ljV3uiHhs2HNHf0VhkJd+yay
         C7nC4/E1MmdSzUOIogRGK27hhmhT7cQf9wC7gGGfExdNYo96I9O0c7dGn7BtME8Gwy3A
         m3UQ==
X-Gm-Message-State: AOAM531cmHTx8x6UVONzYlv88/fS1IDhtb8oyX5jSFVeqMa/QgdWmRU+
        HHJ+y6PR3Re1JDIa202navjVlaCqeW+SlA+YWv/gFw==
X-Google-Smtp-Source: ABdhPJwipDk3pYli3s9I0hRnoSDPpdt88sFz0g3PIyGrQrhT0c9XmTBfdO6ph40RDBXdTBljYnedsFPJSFdcrCWwd+w=
X-Received: by 2002:adf:f687:: with SMTP id v7mr5098319wrp.182.1612532894632;
 Fri, 05 Feb 2021 05:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20210202163842.134734-1-leo.yan@linaro.org> <20210202163842.134734-5-leo.yan@linaro.org>
In-Reply-To: <20210202163842.134734-5-leo.yan@linaro.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 5 Feb 2021 13:48:04 +0000
Message-ID: <CAJ9a7ViF6XMt62s77cABJ+otiEZ+8gh8815TfViab+OAxfRuRg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] perf cs-etm: Support PID tracing in config
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Grant <al.grant@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 at 16:39, Leo Yan <leo.yan@linaro.org> wrote:
>
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> If the kernel is running at EL2, the pid of a task is exposed via VMID
> instead of the CONTEXTID.  Add support for this in the perf tool.
>
> This patch respects user setting if user has specified any configs
> from "contextid", "contextid1" or "contextid2"; otherwise, it
> dynamically sets config based on PMU format "contextid".
>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Al Grant <al.grant@arm.com>
> Co-developed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/include/linux/coresight-pmu.h |  3 ++
>  tools/perf/arch/arm/util/cs-etm.c   | 61 +++++++++++++++++++++++------
>  2 files changed, 52 insertions(+), 12 deletions(-)
>
> diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> index 5dc47cfdcf07..4ac5c081af93 100644
> --- a/tools/include/linux/coresight-pmu.h
> +++ b/tools/include/linux/coresight-pmu.h
> @@ -20,14 +20,17 @@
>   */
>  #define ETM_OPT_CYCACC         12
>  #define ETM_OPT_CTXTID         14
> +#define ETM_OPT_CTXTID2                15
>  #define ETM_OPT_TS             28
>  #define ETM_OPT_RETSTK         29
>
>  /* ETMv4 CONFIGR programming bits for the ETM OPTs */
>  #define ETM4_CFG_BIT_CYCACC    4
>  #define ETM4_CFG_BIT_CTXTID    6
> +#define ETM4_CFG_BIT_VMID      7
>  #define ETM4_CFG_BIT_TS                11
>  #define ETM4_CFG_BIT_RETSTK    12
> +#define ETM4_CFG_BIT_VMID_OPT  15
>
>  static inline int coresight_get_trace_id(int cpu)
>  {
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index c25c878fd06c..fa6f91a7c8a1 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -67,6 +67,7 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
>         char path[PATH_MAX];
>         int err = -EINVAL;
>         u32 val;
> +       u64 contextid;
>
>         ptr = container_of(itr, struct cs_etm_recording, itr);
>         cs_etm_pmu = ptr->cs_etm_pmu;
> @@ -86,25 +87,59 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
>                 goto out;
>         }
>
> +       /* User has configured for PID tracing, respects it. */
> +       contextid = evsel->core.attr.config &
> +                       (BIT(ETM_OPT_CTXTID) | BIT(ETM_OPT_CTXTID2));
> +
>         /*
> -        * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID tracing
> -        * is supported:
> -        *  0b00000 Context ID tracing is not supported.
> -        *  0b00100 Maximum of 32-bit Context ID size.
> -        *  All other values are reserved.
> +        * If user doesn't configure the contextid format, parse PMU format and
> +        * enable PID tracing according to the "contextid" format bits:
> +        *
> +        *   If bit ETM_OPT_CTXTID is set, trace CONTEXTIDR_EL1;
> +        *   If bit ETM_OPT_CTXTID2 is set, trace CONTEXTIDR_EL2.
>          */
> -       val = BMVAL(val, 5, 9);
> -       if (!val || val != 0x4) {
> -               err = -EINVAL;
> -               goto out;
> +       if (!contextid)
> +               contextid = perf_pmu__format_bits(&cs_etm_pmu->format,
> +                                                 "contextid");
> +
> +       if (contextid & BIT(ETM_OPT_CTXTID)) {
> +               /*
> +                * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID
> +                * tracing is supported:
> +                *  0b00000 Context ID tracing is not supported.
> +                *  0b00100 Maximum of 32-bit Context ID size.
> +                *  All other values are reserved.
> +                */
> +               val = BMVAL(val, 5, 9);
> +               if (!val || val != 0x4) {
> +                       pr_err("%s: CONTEXTIDR_EL1 isn't supported\n",
> +                              CORESIGHT_ETM_PMU_NAME);
> +                       err = -EINVAL;
> +                       goto out;
> +               }
> +       }
> +
> +       if (contextid & BIT(ETM_OPT_CTXTID2)) {
> +               /*
> +                * TRCIDR2.VMIDOPT[30:29] != 0 and
> +                * TRCIDR2.VMIDSIZE[14:10] == 0b00100 (32bit virtual contextid)
> +                * We can't support CONTEXTIDR in VMID if the size of the
> +                * virtual context id is < 32bit.
> +                * Any value of VMIDSIZE >= 4 (i.e, > 32bit) is fine for us.
> +                */
> +               if (!BMVAL(val, 29, 30) || BMVAL(val, 10, 14) < 4) {
> +                       pr_err("%s: CONTEXTIDR_EL2 isn't supported\n",
> +                              CORESIGHT_ETM_PMU_NAME);
> +                       err = -EINVAL;
> +                       goto out;
> +               }
>         }
>
>         /* All good, let the kernel know */
> -       evsel->core.attr.config |= (1 << ETM_OPT_CTXTID);
> +       evsel->core.attr.config |= contextid;
>         err = 0;
>
>  out:
> -
>         return err;
>  }
>
> @@ -489,7 +524,9 @@ static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
>                 config |= BIT(ETM4_CFG_BIT_TS);
>         if (config_opts & BIT(ETM_OPT_RETSTK))
>                 config |= BIT(ETM4_CFG_BIT_RETSTK);
> -
> +       if (config_opts & BIT(ETM_OPT_CTXTID2))
> +               config |= BIT(ETM4_CFG_BIT_VMID) |
> +                         BIT(ETM4_CFG_BIT_VMID_OPT);
>         return config;
>  }
>
> --
> 2.25.1
>

reviewed-by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
