Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BA6329FCC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574603AbhCBDsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243493AbhCAV0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:26:35 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAA6C0617A9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 13:23:09 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l22so526471wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 13:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c0ZvIjJHRTziXyViFMvrOdCl+6OVi36JkN8Az258FFk=;
        b=F25vV8ZwUlpswV28t5eTxSEqVwfPJQNQVhoJlps0ydBthIHOOzFTJorj0Ur44LRcZk
         HW16eoSIvgZ63I/rWT4Ff4UEEhg4wBOKXhP3zwKcytejl5hry5G3mgjouDundeg5D1qt
         bexwYHfW7XO58De9uz2Sw1Dn/ND6S89X0NkBTS95cWfGlWrVvzp1kSbl/CBXdA+vH+aN
         kymfJm5Hyb3FgLG9RNvPipPBW0IdoQaMuXu0TRf4vKeGfBo8Iy10fCTKOMSTtsoNDhh5
         /QVAt3IxSaJBA3K+pMYmQi6eA1vl+wjcckwi4GpOraNUw43Rtpw/jscOxtwl84T5PqO7
         VKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c0ZvIjJHRTziXyViFMvrOdCl+6OVi36JkN8Az258FFk=;
        b=lh3LA1ucvt4dyVkGWGnU0EbMJGlXGjwtEA8Ob5FlKCFUOVO5/WfP4O2K3gFeLrZIaj
         VzMkRdWHP+/do7DuyUA9oShiKxfhoQQZp7c29PVzGyQQQXpdZTgetfD/eAmcOHB4ZeSl
         ACXEnO7anmRg5AvjmMKiylC3+lM7TZI2lkZnprdJwmewk5Q003uZGxMtwtQ29xTIttTo
         Ng0DyHlLWOEC4Jwjaw8ycj9rqEW7zeEAe2PUd8NsiZy+PqiugFYvaGuqsVAWqwfY4Z4e
         5TV1BRptVp5BbZ0QIgWY1jb9flyrmLvrzms/kuBr/7b9WRLVTfHFY3WwK8BGS4EiX8NP
         iOJQ==
X-Gm-Message-State: AOAM532XFeXtPkr/VfrSPTSh2V1PrGBZkq+84rtVRZdm2QZLg92kBtgr
        ryXXtY6PSWpgwtVkh7vFW1iFIg==
X-Google-Smtp-Source: ABdhPJxAcm9ZSZ2+Ew0yaY/tvRsvhtlD1818WLOUABifS7YNzhs8YpZm9rt+mivCEk8YBlFDOXA87g==
X-Received: by 2002:a7b:cf16:: with SMTP id l22mr759803wmg.26.1614633787709;
        Mon, 01 Mar 2021 13:23:07 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.gmail.com with ESMTPSA id o11sm6783866wrq.74.2021.03.01.13.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 13:23:07 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 5/5] powercap/drivers/dtpm: Scale the power with the load
Date:   Mon,  1 Mar 2021 22:21:49 +0100
Message-Id: <20210301212149.22877-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210301212149.22877-1-daniel.lezcano@linaro.org>
References: <20210301212149.22877-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the power consumption is based on the current OPP power
assuming the entire performance domain is fully loaded.

That gives very gross power estimation and we can do much better by
using the load to scale the power consumption.

Use the utilization to normalize and scale the power usage over the
max possible power.

Tested on a rock960 with 2 big CPUS, the power consumption estimation
conforms with the expected one.

Before this change:

~$ ~/dhrystone -t 1 -l 10000&
~$ cat /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
2260000

After this change:

~$ ~/dhrystone -t 1 -l 10000&
~$ cat /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
1130000

~$ ~/dhrystone -t 2 -l 10000&
~$ cat /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
2260000

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm_cpu.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index e728ebd6d0ca..8379b96468ef 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -68,27 +68,40 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	return power_limit;
 }
 
+static u64 scale_pd_power_uw(struct cpumask *cpus, u64 power)
+{
+	unsigned long max, util;
+	int cpu, load = 0;
+
+	for_each_cpu(cpu, cpus) {
+		max = arch_scale_cpu_capacity(cpu);
+		util = sched_cpu_util(cpu, max);
+		load += ((util * 100) / max);
+	}
+
+	return (power * load) / 100;
+}
+
 static u64 get_pd_power_uw(struct dtpm *dtpm)
 {
 	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 	struct em_perf_domain *pd;
 	struct cpumask cpus;
 	unsigned long freq;
-	int i, nr_cpus;
+	int i;
 
 	pd = em_cpu_get(dtpm_cpu->cpu);
 	freq = cpufreq_quick_get(dtpm_cpu->cpu);
 
 	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
-	nr_cpus = cpumask_weight(&cpus);
 
 	for (i = 0; i < pd->nr_perf_states; i++) {
 
 		if (pd->table[i].frequency < freq)
 			continue;
 
-		return pd->table[i].power *
-			MICROWATT_PER_MILLIWATT * nr_cpus;
+		return scale_pd_power_uw(&cpus, pd->table[i].power *
+					 MICROWATT_PER_MILLIWATT);
 	}
 
 	return 0;
-- 
2.17.1

