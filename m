Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE8138ADFE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhETMVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbhETMVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:21:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0159C0967B8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:12:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id t206so8953642wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OD83TbqPWdUX23+2kol7uQAza90KSRa5uQTGth2iV1Q=;
        b=MiYFh4FnAcQPKlKMWXiAqv8cczel9f2LKqcOF3Z8ac1WePv4E95/YOkANGmW6FFwfG
         OGi6HMRXGL8AF3b4xMKtUk5LCIuE2Qvdiqxoyk1QbNMAMA1plEMoUgi7mt4e1lx7+TcH
         di5yVSYonhM4aRIMC3+8JL73SwY0SqToiArVgs4faKTiMbMBqkIOR5P5oj1IvIcNFz3Y
         XVMs0srPDG2z2kL2bfRpNsqZchS0zpdFO17xyJ4QVcjK1nG9yO459Y/UPjEPDRfabKgf
         z0jbcL2ZixtRwxUtbEN2E4cDmTFrOj8/fYd8M4OH1WklPJfsb8yY7nleMmugXtb50Hws
         xY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OD83TbqPWdUX23+2kol7uQAza90KSRa5uQTGth2iV1Q=;
        b=rtByc7VOl6Qv3tFoKQS8dGhejysFg6EQBQWufeQgpI5SigLgjoF/7ZgeHuc5sMJMrb
         1H+ArJxv7WKAQ81XDP7plgi8oAxtCKLtyNrYfDvCbRhZF+KCXimnp0OTm27Ag3l3JCj+
         boWU/2068Bx3KHXXGu1kh8E0gktbBY6TsAGyuOfEY/PPqhS/m5idwLlqnYBIWEc1RX+v
         aAbyjtAe3g8UDGFwuBUmGbu4NLzhcl3Ny4Enf5DL+iO7aiQN6C1KcpN4f8N9NRfCzm5w
         auquFLyDeDwaWjubKd4k3JD3neOX4cb67sCU4YonUgVvR9Ds7c/1IFD+hByURHFeTpiT
         Aj2g==
X-Gm-Message-State: AOAM530cEtGSZaU1vyCY9A8ms5W26CHVlkwe3Y1LYYYUHKsvEbtcpqS/
        lNj731De+JgAaK9hmwY2BkGQcQ==
X-Google-Smtp-Source: ABdhPJwSB1V6B0FJvwRLVBmLbfYNW0AriuyL1+qSPKXyG5ZO5wSOrl9CLdv6g/TrdjFQ0u6wsXSwpw==
X-Received: by 2002:a05:600c:4010:: with SMTP id i16mr3207168wmm.28.1621509152970;
        Thu, 20 May 2021 04:12:32 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id m20sm3834627wmi.5.2021.05.20.04.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:12:32 -0700 (PDT)
Date:   Thu, 20 May 2021 11:12:29 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] PM / EM: Inefficient OPPs detection
Message-ID: <YKZEHVcSjhGhwnk0@google.com>
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
 <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
 <YHg7pfGKhzlMrXqC@google.com>
 <20210422153644.GA316798@e124901.cambridge.arm.com>
 <YILydL1QDxvuiFde@google.com>
 <20210428144609.GB71893@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428144609.GB71893@e120877-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

Apologies for the late reply.

On Wednesday 28 Apr 2021 at 15:46:10 (+0100), Vincent Donnefort wrote:
> I do, it shows that the distribution is quite wide. I also have a 95% confidence
> interval, as follow:
>                             w/o LUT               W/ LUT
> 
> 	               Mean        std         Mean         std
> 
> Phase0:            10791+/-79      2262      10657+/-71     2240   [1]
> Phase1:            2924 +/-19      529       2894 +/-16     513    [1]
> Phase2:            2207 +/-19      535       2162 +/-17     515
> Phase3:            1897 +/-18      504       1864 +/-17     515    [1]
> Phase4:   Mid CPU  1700 +/-46      463       1609 +/-26     458
> Phase4:   Big CPU  1187 +/-15      407       1129 +/-15     385
> Phase5:            987  +/-14      395       900  +/-12     365 
> 
> 
> [1] I included these results originally as the p-value for the test I used
> showed we can reject confidently the null hypothesis that the 2 samples are
> coming from the same distribution... However, the confidence intervals for
> the mean overlaps. It is then complicated to conclude for those phases.

Aha, thanks for sharing. So yes, it's not all that obvious that we need
the extra complexity of the LUT there :/. In this case I'd be inclined
to suggest a simpler version first, and we can always optimize later.

How much would you hate something like the below (totally untested)? We
still end up with the double lookup in sugov, but as you've pointed out
in another reply we can't easily workaround, and as per the above the
linear search isn't that bad compared to the LUT. Maybe we could try a
few micro-optimizations on top (e.g. binary searching the EM table), but
IIRC that wasn't making much of difference last time I tried.

Thoughts?

Thanks,
Quentin

---
diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 757fc60658fa..8320f5e87992 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -22,6 +22,7 @@ struct em_perf_state {
        unsigned long frequency;
        unsigned long power;
        unsigned long cost;
+       unsigned int inefficient;
 };

 /**
@@ -85,6 +86,25 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
                                bool milliwatts);
 void em_dev_unregister_perf_domain(struct device *dev);

+static inline struct em_perf_state *__em_find_ps(struct em_perf_domain *pd, unsigned long freq)
+{
+       struct em_perf_state *ps;
+       int i;
+
+       for (i = 0; i < pd->nr_perf_states; i++) {
+               ps = &pd->table[i];
+               if (ps->frequency >= freq && !ps->inefficient)
+                       break;
+       }
+
+       return ps;
+}
+
+static inline unsigned long em_cpu_find_freq(struct em_perf_domain *pd, unsigned long freq)
+{
+       return pd ? __em_find_ps(pd, freq)->frequency : freq;
+}
+
 /**
  * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
                performance domain
@@ -104,7 +124,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 {
        unsigned long freq, scale_cpu;
        struct em_perf_state *ps;
-       int i, cpu;
+       int cpu;

        if (!sum_util)
                return 0;
@@ -118,16 +138,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
        scale_cpu = arch_scale_cpu_capacity(cpu);
        ps = &pd->table[pd->nr_perf_states - 1];
        freq = map_util_freq(max_util, ps->frequency, scale_cpu);
-
-       /*
-        * Find the lowest performance state of the Energy Model above the
-        * requested frequency.
-        */
-       for (i = 0; i < pd->nr_perf_states; i++) {
-               ps = &pd->table[i];
-               if (ps->frequency >= freq)
-                       break;
-       }
+       ps = __em_find_ps(pd, freq);

        /*
         * The capacity of a CPU in the domain at the performance state (ps)
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 0f4530b3a8cd..990048e9ec79 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -161,7 +161,8 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
                 * power efficient than a lower one.
                 */
                opp_eff = freq / power;
-               if (opp_eff >= prev_opp_eff)
+               table[i].inefficient = (opp_eff >= prev_opp_eff);
+               if (table[i].inefficient)
                        dev_dbg(dev, "EM: hertz/watts ratio non-monotonically decreasing: em_perf_state %d >= em_perf_state%d\n",
                                        i, i - 1);
                prev_opp_eff = opp_eff;
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4f09afd2f321..9186d52d8660 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -10,6 +10,7 @@
 
 #include "sched.h"
 
+#include <linux/energy_model.h>
 #include <linux/sched/cpufreq.h>
 #include <trace/events/power.h>
 
@@ -42,6 +43,8 @@ struct sugov_policy {
 
        bool                    limits_changed;
        bool                    need_freq_update;
+
+       struct em_perf_domain   *pd;
 };
 
 struct sugov_cpu {
@@ -152,6 +155,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
                                policy->cpuinfo.max_freq : policy->cur;
 
        freq = map_util_freq(util, freq, max);
+       freq = em_cpu_find_freq(sg_policy->pd, freq);
 
        if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
                return sg_policy->next_freq;
@@ -756,6 +760,7 @@ static int sugov_start(struct cpufreq_policy *policy)
        sg_policy->cached_raw_freq              = 0;
 
        sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
+       sg_policy->pd = em_cpu_get(policy->cpu);
 
        for_each_cpu(cpu, policy->cpus) {
                struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
