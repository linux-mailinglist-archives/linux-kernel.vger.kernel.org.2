Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49143E2E2B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 18:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhHFQKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 12:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHFQKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 12:10:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F07C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 09:09:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p38so19003494lfa.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43uacygLvcWCtdyY2jgBOl/PFgE5SglxC5TeeVKPEyM=;
        b=B6b6bGeyFS8ZkzpS5g4/yYAOB5scfQ4v5L1MivhkxaexnLYHcx7jsDG/ZXRpG8FmZ0
         79K2KZF1N/1SnXQDkMn7D9GIMc4w9MfYAfJ/eBCVJMHLWPezW9kxmoJZ9AWPObCF4f4D
         Acy6s0vuft+Ti9tmbyJiecXiUcrcWtQgyVFE4PncDa9u5VyELrBvSFE9YJUmzAgtRK2x
         bfAsuXuYDfaZb6XUmjCm1B/RfN7sjzYzWkeIonOU0kR9JeG2XQCuzVhObKjMZXvOfRwx
         vatlP4q67k5hIxVsp3iGMCSv+FK1mdAkLDdlMykYvTGNeF4keem/XotX5fzTGNIQ6MMk
         ZDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43uacygLvcWCtdyY2jgBOl/PFgE5SglxC5TeeVKPEyM=;
        b=mW+I62BzG7mdGB6/oJHYo2vzZ5OSLd+oC+U5juvU7R9XSbwFtr4qMqDi+Db5NvE6WH
         XNvHtN9PghPAwhNgwjrkwC0/lrVq7obm6oEuHHqnY70b8YlRqGzdhww2XQgo5B9qXgW1
         7OKuYOTnb5bFrMLcwIMwNscAc3R0PeewX8FM2+ONnmpFTQjBvfqq6H4cHWj39HRvHKfB
         G/ofhqTk8Y3Eux5NBcnomjVsfo2Ee68oBLeMQj6TTWtBp2epYTqRNTALo/CQuzidN3i1
         wVqSSql3PkyT3VV1tyILigMVp0N5xNBwkxLjnmQsH8Si5kTQYvzVIVLzGmtvflEwVkr0
         MZPQ==
X-Gm-Message-State: AOAM533yEhWpU+vSvjB2J6IuQ//UzMcImNMMq1CD4dxLfwcgXx70LMQi
        ieAe8x+LQCOfdu7RCjTQ8uZ4cN+jJ/w6h+3dfk8=
X-Google-Smtp-Source: ABdhPJxeYqldcOAETGWIFapsjzpyi18L/rARYobIkhFM8Eh6FUlyayf5m99esFktENHPJyfF80WlO/a7Jy1Oi5pAoFc=
X-Received: by 2002:a19:c712:: with SMTP id x18mr8302602lff.552.1628266195223;
 Fri, 06 Aug 2021 09:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210728135217.591173-1-suzuki.poulose@arm.com> <20210728135217.591173-9-suzuki.poulose@arm.com>
In-Reply-To: <20210728135217.591173-9-suzuki.poulose@arm.com>
From:   Linu Cherian <linuc.decode@gmail.com>
Date:   Fri, 6 Aug 2021 21:39:43 +0530
Message-ID: <CAAHhmWjR6XYo5j_h3jfLsmWzqD9i9L-pHq=zrrdrw9YTXmuCqg@mail.gmail.com>
Subject: Re: [PATCH 08/10] coresight: trbe: Workaround TRBE errat overwrite in
 FILL mode
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, maz@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        catalin.marinas@arm.com, Coresight ML <coresight@lists.linaro.org>,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Wed, Jul 28, 2021 at 7:23 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> ARM Neoverse-N2 (#2139208) and Cortex-A710(##2119858) suffers from
> an erratum, which when triggered, might cause the TRBE to overwrite
> the trace data already collected in FILL mode, in the event of a WRAP.
> i.e, the TRBE doesn't stop writing the data, instead wraps to the base
> and could write upto 3 cache line size worth trace. Thus, this could
> corrupt the trace at the "BASE" pointer.
>
> The workaround is to program the write pointer 256bytes from the
> base, such that if the erratum is triggered, it doesn't overwrite
> the trace data that was captured. This skipped region could be
> padded with ignore packets at the end of the session, so that
> the decoder sees a continuous buffer with some padding at the
> beginning.

Just trying to understand,
Is there a possibility that lost data results in partial trace packets
towards the end of the buffer ? Or its always guaranteed that
trace packet end is always aligned with buffer end/limit ?
Thinking of a case when formatting is disabled.

The trace data written at the base is considered
> lost as the limit could have been in the middle of the perf
> ring buffer, and jumping to the "base" is not acceptable.
> We set the flags already to indicate that some amount of trace
> was lost during the FILL event IRQ. So this is fine.
>
> One important change with the work around is, we program the
> TRBBASER_EL1 to current page where we are allowed to write.
> Otherwise, it could overwrite a region that may be consumed
> by the perf. Towards this, we always make sure that the
> "handle->head" and thus the trbe_write is PAGE_SIZE aligned,
> so that we can set the BASE to the PAGE base and move the
> TRBPTR to the 256bytes offset.
>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 111 +++++++++++++++++--
>  1 file changed, 102 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 9ea28813182b..cd997ed5d918 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -17,6 +17,7 @@
>
>  #include <asm/barrier.h>
>  #include <asm/cputype.h>
> +#include <asm/cpufeature.h>
>
>  #include "coresight-self-hosted-trace.h"
>  #include "coresight-trbe.h"
> @@ -84,9 +85,17 @@ struct trbe_buf {
>   * per TRBE instance, we keep track of the list of errata that
>   * affects the given instance of the TRBE.
>   */
> -#define TRBE_ERRATA_MAX                        0
> +#define TRBE_WORKAROUND_OVERWRITE_FILL_MODE    0
> +#define TRBE_ERRATA_MAX                                1
> +
> +/*
> + * Safe limit for the number of bytes that may be overwritten
> + * when the erratum is triggered.
> + */
> +#define TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP       256
>
>  static unsigned long trbe_errata_cpucaps[TRBE_ERRATA_MAX] = {
> +       [TRBE_WORKAROUND_OVERWRITE_FILL_MODE] = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
>  };
>
>  /*
> @@ -531,10 +540,13 @@ static enum trbe_fault_action trbe_get_fault_act(u64 trbsr)
>         if ((ec == TRBE_EC_STAGE1_ABORT) || (ec == TRBE_EC_STAGE2_ABORT))
>                 return TRBE_FAULT_ACT_FATAL;
>
> -       if (is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc == TRBE_BSC_FILLED)) {
> -               if (get_trbe_write_pointer() == get_trbe_base_pointer())
> -                       return TRBE_FAULT_ACT_WRAP;
> -       }
> +       /*
> +        * It is not necessary to verify the TRBPTR == TRBBASER to detect
> +        * a FILL event. Moreover, CPU errata could make this check invalid.
> +        */
> +       if (is_trbe_wrap(trbsr) && (ec == TRBE_EC_OTHERS) && (bsc == TRBE_BSC_FILLED))
> +               return TRBE_FAULT_ACT_WRAP;
> +
>         return TRBE_FAULT_ACT_SPURIOUS;
>  }
>
> @@ -544,6 +556,7 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
>  {
>         u64 write;
>         u64 start_off, end_off;
> +       u64 size;
>
>         /*
>          * If the TRBE has wrapped around the write pointer has
> @@ -559,7 +572,18 @@ static unsigned long trbe_get_trace_size(struct perf_output_handle *handle,
>
>         if (WARN_ON_ONCE(end_off < start_off))
>                 return 0;
> -       return (end_off - start_off);
> +
> +       size = end_off - start_off;
> +       /*
> +        * If the TRBE is affected by the following erratum, we must fill
> +        * the space we skipped with IGNORE packets. And we are always
> +        * guaranteed to have at least a PAGE_SIZE space in the buffer.
> +        */
> +       if (trbe_has_erratum(TRBE_WORKAROUND_OVERWRITE_FILL_MODE, buf->cpudata) &&
> +           !WARN_ON(size < TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP))
> +               __trbe_pad_buf(buf, start_off, TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP);
> +
> +       return size;
>  }
>
>  static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
> @@ -704,20 +728,73 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
>         return size;
>  }
>
> +
> +static int trbe_apply_work_around_before_enable(struct trbe_buf *buf)
> +{
> +       /*
> +        * TRBE_WORKAROUND_OVERWRITE_FILL_MODE causes the TRBE to overwrite a few cache
> +        * line size from the "TRBBASER_EL1" in the event of a "FILL".
> +        * Thus, we could loose some amount of the trace at the base.
> +        *
> +        * To work around this:
> +        * - Software must leave 256bytes of space from the base, so that
> +        *   the trace collected now is not overwritten.
> +        * - Fill the first 256bytes with IGNORE packets for the decoder
> +        *   to ignore at the end of the session, so that the decoder ignores
> +        *   this gap.
> +        *
> +        * This also means that, the TRBE driver must set the TRBBASER_EL1
> +        * such that, when the erratum is triggered, it doesn't overwrite
> +        * the "area" outside the area marked by (handle->head, +size).
> +        * So, we make sure that the handle->head is always PAGE aligned,
> +        * by tweaking the required alignment for the TRBE (trbe_align).
> +        * And when we enable the TRBE,
> +        *
> +        *   - move the TRBPTR_EL1 to 256bytes past the starting point.
> +        *     So that any trace collected in this run is not overwritten.
> +        *
> +        *   - set the TRBBASER_EL1 to the original trbe_write. This will
> +        *     ensure that, if the TRBE hits the erratum, it would only
> +        *     write within the region allowed for the TRBE.
> +        *
> +        * At the trace collection time, we always pad the skipped bytes
> +        * with IGNORE packets to make sure the decoder doesn't see any
> +        * overwritten packets.
> +        */
> +       if (trbe_has_erratum(TRBE_WORKAROUND_OVERWRITE_FILL_MODE, buf->cpudata)) {
> +               if (WARN_ON(!IS_ALIGNED(buf->trbe_write, PAGE_SIZE)))
> +                       return -EINVAL;
> +               buf->trbe_hw_base = buf->trbe_write;
> +               buf->trbe_write += TRBE_WORKAROUND_OVERWRITE_FILL_MODE_SKIP;
> +       }
> +
> +       return 0;
> +}
> +
>  static int __arm_trbe_enable(struct trbe_buf *buf,
>                              struct perf_output_handle *handle)
>  {
> +       int ret = 0;
> +
>         buf->trbe_limit = compute_trbe_buffer_limit(handle);
>         buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
>         if (buf->trbe_limit == buf->trbe_base) {
> -               trbe_stop_and_truncate_event(handle);
> -               return -ENOSPC;
> +               ret = -ENOSPC;
> +               goto err;
>         }
>         /* Set the base of the TRBE to the buffer base */
>         buf->trbe_hw_base = buf->trbe_base;
> +
> +       ret = trbe_apply_work_around_before_enable(buf);
> +       if (ret)
> +               goto err;
> +
>         *this_cpu_ptr(buf->cpudata->drvdata->handle) = handle;
>         trbe_enable_hw(buf);
>         return 0;
> +err:
> +       trbe_stop_and_truncate_event(handle);
> +       return ret;
>  }
>
>  static int arm_trbe_enable(struct coresight_device *csdev, u32 mode, void *data)
> @@ -1003,7 +1080,23 @@ static void arm_trbe_probe_cpu(void *info)
>                 pr_err("Unsupported alignment on cpu %d\n", cpu);
>                 goto cpu_clear;
>         }
> -       cpudata->trbe_align = cpudata->trbe_hw_align;
> +
> +       /*
> +        * If the TRBE is affected by erratum TRBE_WORKAROUND_OVERWRITE_FILL_MODE,
> +        * we must always program the TBRPTR_EL1, 256bytes from a page
> +        * boundary, with TRBBASER_EL1 set to the page, to prevent
> +        * TRBE over-writing 256bytes at TRBBASER_EL1 on FILL event.
> +        *
> +        * Thus make sure we always align our write pointer to a PAGE_SIZE,
> +        * which also guarantees that we have at least a PAGE_SIZE space in
> +        * the buffer (TRBLIMITR is PAGE aligned) and thus we can skip
> +        * the required bytes at the base.
> +        */
> +       if (trbe_has_erratum(TRBE_WORKAROUND_OVERWRITE_FILL_MODE, cpudata))
> +               cpudata->trbe_align = PAGE_SIZE;
> +       else
> +               cpudata->trbe_align = cpudata->trbe_hw_align;
> +
>         cpudata->trbe_flag = get_trbe_flag_update(trbidr);
>         cpudata->cpu = cpu;
>         cpudata->drvdata = drvdata;
> --
> 2.24.1
>
> _______________________________________________
> CoreSight mailing list
> CoreSight@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/coresight
