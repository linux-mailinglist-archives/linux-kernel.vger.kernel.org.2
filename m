Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21053314C9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhCHR0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhCHRZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:25:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE6DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 09:25:45 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 7so12339360wrz.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KDJBiI7Jz+ZJxzzkRkQSxdCDSJkaDkUx+GMMqEt1F+w=;
        b=JmReW/AdN2WS/R3f/Nb098bFIdkUhG98+qaq2bmS6KN09iW/E1DUfZ76v2g8TDzHhU
         3ZK2RktU0M679FTp9JheLP5s1V1/3dRoFnuJT9udFN1N/LSof0AbgED8H3ia8/J+t3xs
         wgl9y31YlJO4zVCRhtwi2MbYfYoQw8xpR8IKDtQWZc3pCqTXf+3nxmGjrj6OVRVlKtKJ
         chGampfjcZ1Mb9bT5ZKAeCvR+76NS5VqlX3kEC8KJ5zAI0F+o79XtMBjqH+mKc54yNHQ
         Db8N82SxybRjScHNiD5qlMqj14Xk1cJlVkk9PKnhcEiqd59yc9S0OX5zW5yWZXk1vN2D
         4CMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDJBiI7Jz+ZJxzzkRkQSxdCDSJkaDkUx+GMMqEt1F+w=;
        b=gqL39aXkvIizX8qcuGdIjcDaysTp8IsJBUtdtc9hKNi0OxjcFIFDXVmxLQzZWzwFDn
         9AqHhZEPTg5DWpVoyaH13lk/mg63u/JI62T9cmUDppWwS3zuxNXVq57zGyNECToMBnP6
         D1fPiI/FZQOdxK02Ii/o3Gbs3Amou3dL2dscAC3K4Wd/1BlLPhsTjG+MeDInyP75jzOf
         Q+awkDJweyC/jo5KnCNim7dXkXqbj1Y8gr1iEPTZNH6CoBU6kFhPM90Swc6uHB5kixHy
         BQAGfnZkg5gzz9m5ixoMPiogTY96gH9FkFJjCHXRd+lZm+0hMOdbGgtBkh6ebJd0AIpn
         /z+Q==
X-Gm-Message-State: AOAM531ijZ6t847Zk0gvvs7f4sntOdOFuVkU5v1jU+lweNhAGrzrsdbB
        Qo5tYBN7sey0iJEGOAncbGgQ3LDqTyo/KY8wv6F/NA==
X-Google-Smtp-Source: ABdhPJy3h6p4JPNsIK/yYso55HNpXsiAeCbKFyUmBoXu7RSwIMlMvqj16iJFOyykGAPwpmAI55JgTrf478qF0KDDfxU=
X-Received: by 2002:a5d:558b:: with SMTP id i11mr23442640wrv.176.1615224344175;
 Mon, 08 Mar 2021 09:25:44 -0800 (PST)
MIME-Version: 1.0
References: <20210225193543.2920532-1-suzuki.poulose@arm.com> <20210225193543.2920532-10-suzuki.poulose@arm.com>
In-Reply-To: <20210225193543.2920532-10-suzuki.poulose@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 8 Mar 2021 17:25:33 +0000
Message-ID: <CAJ9a7VjsDzpRquhYJVrwoFyVVm79Z+c16cgrKvZ1UJfzJ89cJg@mail.gmail.com>
Subject: Re: [PATCH v4 09/19] coresight: etm4x: Move ETM to prohibited region
 for disable
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 at 19:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> If the CPU implements Arm v8.4 Trace filter controls (FEAT_TRF),
> move the ETM to trace prohibited region using TRFCR, while disabling.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> New patch
> ---
>  .../coresight/coresight-etm4x-core.c          | 21 +++++++++++++++++--
>  drivers/hwtracing/coresight/coresight-etm4x.h |  2 ++
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 15016f757828..00297906669c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -31,6 +31,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
>
> +#include <asm/barrier.h>
>  #include <asm/sections.h>
>  #include <asm/sysreg.h>
>  #include <asm/local.h>
> @@ -654,6 +655,7 @@ static int etm4_enable(struct coresight_device *csdev,
>  static void etm4_disable_hw(void *info)
>  {
>         u32 control;
> +       u64 trfcr;
>         struct etmv4_drvdata *drvdata = info;
>         struct etmv4_config *config = &drvdata->config;
>         struct coresight_device *csdev = drvdata->csdev;
> @@ -676,6 +678,16 @@ static void etm4_disable_hw(void *info)
>         /* EN, bit[0] Trace unit enable bit */
>         control &= ~0x1;
>
> +       /*
> +        * If the CPU supports v8.4 Trace filter Control,
> +        * set the ETM to trace prohibited region.
> +        */
> +       if (drvdata->trfc) {
> +               trfcr = read_sysreg_s(SYS_TRFCR_EL1);
> +               write_sysreg_s(trfcr & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE),
> +                              SYS_TRFCR_EL1);
> +               isb();
> +       }
>         /*
>          * Make sure everything completes before disabling, as recommended
>          * by section 7.3.77 ("TRCVICTLR, ViewInst Main Control Register,
> @@ -683,12 +695,16 @@ static void etm4_disable_hw(void *info)
>          */
>         dsb(sy);
>         isb();
> +       /* Trace synchronization barrier, is a nop if not supported */
> +       tsb_csync();
>         etm4x_relaxed_write32(csa, control, TRCPRGCTLR);
>
>         /* wait for TRCSTATR.PMSTABLE to go to '1' */
>         if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
>                 dev_err(etm_dev,
>                         "timeout while waiting for PM stable Trace Status\n");
> +       if (drvdata->trfc)
> +               write_sysreg_s(trfcr, SYS_TRFCR_EL1);
>
>         /* read the status of the single shot comparators */
>         for (i = 0; i < drvdata->nr_ss_cmp; i++) {
> @@ -873,7 +889,7 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
>         return false;
>  }
>
> -static void cpu_enable_tracing(void)
> +static void cpu_enable_tracing(struct etmv4_drvdata *drvdata)
>  {
>         u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
>         u64 trfcr;
> @@ -881,6 +897,7 @@ static void cpu_enable_tracing(void)
>         if (!cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_TRACE_FILT_SHIFT))
>                 return;
>
> +       drvdata->trfc = true;
>         /*
>          * If the CPU supports v8.4 SelfHosted Tracing, enable
>          * tracing at the kernel EL and EL0, forcing to use the
> @@ -1082,7 +1099,7 @@ static void etm4_init_arch_data(void *info)
>         /* NUMCNTR, bits[30:28] number of counters available for tracing */
>         drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
>         etm4_cs_lock(drvdata, csa);
> -       cpu_enable_tracing();
> +       cpu_enable_tracing(drvdata);
>  }
>
>  static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 0af60571aa23..f6478ef642bf 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -862,6 +862,7 @@ struct etmv4_save_state {
>   * @nooverflow:        Indicate if overflow prevention is supported.
>   * @atbtrig:   If the implementation can support ATB triggers
>   * @lpoverride:        If the implementation can support low-power state over.
> + * @trfc:      If the implementation supports Arm v8.4 trace filter controls.
>   * @config:    structure holding configuration parameters.
>   * @save_state:        State to be preserved across power loss
>   * @state_needs_restore: True when there is context to restore after PM exit
> @@ -912,6 +913,7 @@ struct etmv4_drvdata {
>         bool                            nooverflow;
>         bool                            atbtrig;
>         bool                            lpoverride;
> +       bool                            trfc;
>         struct etmv4_config             config;
>         struct etmv4_save_state         *save_state;
>         bool                            state_needs_restore;
> --
> 2.24.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
