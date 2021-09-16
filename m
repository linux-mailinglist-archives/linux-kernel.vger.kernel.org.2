Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D30740DBDA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbhIPN4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbhIPNz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:55:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B50C0613E0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:54:24 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j6so5985668pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RBxaFu3pY1XGgJ+O5Jy/ycVlHu3l8KkYJ5CJh2tLDGE=;
        b=zycJseAEgDTdHciu+zr6qozTIWy9Um9QTI433DBMma7E9/71DKRz83ov5jyljAUFHf
         JVmwZX8C77ymWd1xmUAiHTQOFq4BCwnFLMyU2aQmskWTfeDJSCz0UDcUMk85IZ35FEdC
         O1DMlfAnpOIZZpPIlkcAj8dUQhZWiDvz/khCQUp/HwwsuMPhG0e4Xdcc9mTpeKUKzune
         Jdwa+CeOfdzO9PbVAHck/8IDY9yK8wQpdkC+9R1AVZZuWwiuzfaHIuC24dYKxpOx5T1y
         WDFIV/KL37K0mP7LrINbOKFe8NAKRSeTqaIOTRFGfr0/GobB0i50/97QiV6CymKt1o1z
         UnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RBxaFu3pY1XGgJ+O5Jy/ycVlHu3l8KkYJ5CJh2tLDGE=;
        b=YKe6dzgLP7ktRZgSs0VE/rBO1p8quT5qEZh2HoZip2dS76c5paR7T0k6k7CqfQZA6f
         g+O+DNl1lfJn+6SI27zEPhG682axAQi39A826Judn/xMdTojHStOSiXP0t1v8E7YMQQq
         mA4AAxVMAFe4sZbwYkYzzWGaOXPAVXBVwt4hly3dQD6pHUxrniq46tbty4tdfDyiuNtJ
         uVScCg+N7NyFrTcTaMWyzRWK0si8Bs770NDD3/RIS9J+YbyyuYYqWZxpU0RG5J+3sGYj
         GLZbOz8wwAjFncdtdAwS3MoIsbePvSZkJl9qGNTSyuN0MK02/fFGGcuELmBvWZTeJ8WN
         U0bQ==
X-Gm-Message-State: AOAM532Q+tcxhOd6RNg1CqKWBxlL9TXqMNNgdHDS3ND7iKCQYN8mcAFs
        JLHAyZiYCmSVJ+1wQgKdUdU6Zw==
X-Google-Smtp-Source: ABdhPJyHcd9SoDVspAfCj4bePj6K8NMYfKUSSnWreCaAC3Q/YuNKN+3yErhgRupe1mYJH1TjXR5Y2Q==
X-Received: by 2002:aa7:9115:0:b029:359:69db:bc89 with SMTP id 21-20020aa791150000b029035969dbbc89mr5436462pfh.32.1631800463937;
        Thu, 16 Sep 2021 06:54:23 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([213.173.35.225])
        by smtp.gmail.com with ESMTPSA id e5sm7887253pjv.44.2021.09.16.06.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 06:54:23 -0700 (PDT)
Date:   Thu, 16 Sep 2021 21:54:18 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
Message-ID: <20210916135418.GA383600@leoy-ThinkPad-X240s>
References: <20210916001748.1525291-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916001748.1525291-1-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Wed, Sep 15, 2021 at 05:17:48PM -0700, Namhyung Kim wrote:
> When perf report synthesize events from ARM SPE data, it refers to
> current cpu, pid and tid in the machine.  But there's no place to set
> them in the ARM SPE decoder.  I'm seeing all pid/tid is set to -1 and
> user symbols are not resolved in the output.
> 
>   # perf record -a -e arm_spe_0/ts_enable=1/ sleep 1
> 
>   # perf report -q | head
>      8.77%     8.77%  :-1      [kernel.kallsyms]  [k] format_decode
>      7.02%     7.02%  :-1      [kernel.kallsyms]  [k] seq_printf
>      7.02%     7.02%  :-1      [unknown]          [.] 0x0000ffff9f687c34
>      5.26%     5.26%  :-1      [kernel.kallsyms]  [k] vsnprintf
>      3.51%     3.51%  :-1      [kernel.kallsyms]  [k] string
>      3.51%     3.51%  :-1      [unknown]          [.] 0x0000ffff9f66ae20
>      3.51%     3.51%  :-1      [unknown]          [.] 0x0000ffff9f670b3c
>      3.51%     3.51%  :-1      [unknown]          [.] 0x0000ffff9f67c040
>      1.75%     1.75%  :-1      [kernel.kallsyms]  [k] ___cache_free
>      1.75%     1.75%  :-1      [kernel.kallsyms]  [k] __count_memcg_events
> 
> Like Intel PT, add context switch records to track task info.  As ARM
> SPE support was added later than PERF_RECORD_SWITCH_CPU_WIDE, I think
> we can safely set the attr.context_switch bit and use it.

Thanks for the patch.

Before we had discussion for enabling PID/TID for SPE samples; in the patch
set [1], patches 07, 08 set sample's pid/tid based on the Arm SPE context
packets.  To enable hardware tracing context ID, you also needs to enable
kernel config CONFIG_PID_IN_CONTEXTIDR.

At that time, there have a concern is the hardware context ID might
introduce confusion for non-root namespace.

We also considered to use PERF_RECORD_SWITCH_CPU_WIDE event for setting
pid/tid, the Intel PT implementation uses two things to set sample's
pid/tid: one is PERF_RECORD_SWITCH_CPU_WIDE event and another is to detect
the branch instruction is the symbol "__switch_to".  Since the trace
event PERF_RECORD_SWITCH_CPU_WIDE is coarse, so it only uses the new
pid/tid after the branch instruction for "__switch_to".  Arm SPE is
'statistical', thus it cannot promise the trace data must contain the
branch instruction for "__switch_to", please see details [2].

I think the feasible way is to use CONTEXTIDR to trace PID/TID _only_
for root namespace, and the perf tool uses context packet to set
pid/tid for samples.  So except we need patches 07 and 08, we also
need a change in Arm SPE driver as below:

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index d44bcc29d99c..2553d53d3772 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -272,7 +272,9 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
        if (!attr->exclude_kernel)
                reg |= BIT(SYS_PMSCR_EL1_E1SPE_SHIFT);
 
-       if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
+       /* Only enable context ID tracing for root namespace */
+       if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable() &&
+           (task_active_pid_ns(current) == &init_pid_ns))
                reg |= BIT(SYS_PMSCR_EL1_CX_SHIFT);
 
        return reg;

Could you confirm if this works for you?  If it's okay for you, I will
sync with James for upstreaming the changes.

Thanks,
Leo

[1] https://lore.kernel.org/lkml/20210119144658.793-8-james.clark@arm.com/
[2] https://lore.kernel.org/lkml/20210204102734.GA4737@leoy-ThinkPad-X240s/
