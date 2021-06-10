Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD343A26E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFJI0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFJI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:26:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD60C061760
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 01:24:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 69so593141plc.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 01:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YORa9oPGsIte4A9SIv+iSxyTgKDWii2V9/ngG7/TXzA=;
        b=QnZSOGTFeWsKK1KHilKfDK4pafowlzadJ9TKAa+hmsV2BZzCj+/mzNGTDxGSaBhHA3
         j/7avbEiKFpACZp0062Lhq8ApmUqDHyaUNM+2SVWL6t63Mw8Jzz3JvHS46Y2baQoz7PK
         Psc3SuhhpdtfnOaufzA9UXg8V6Tk3nmeGGQiHBD2OTApscMEaeu6rDPiayIHvoXeTNkO
         OzSaPi3D8jX9cmHFu0QqCMlaONZwPocDxFUjMhN5zsfaMm9H6rzAv1z+zMDteOM3yf7A
         slwe6pRxRWJX0x+NuFPRLD7cdIvGV1p5JICgyLJVmWhKqBMx3+hd/fDo6PZ/zuvhmjqe
         wXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YORa9oPGsIte4A9SIv+iSxyTgKDWii2V9/ngG7/TXzA=;
        b=VWCFok+LoGvLR3wLgzP+3VygjyirP/ncENEuVl6Ow/13wdYuuTv3klnX5n9JiwJ1jm
         YPkGZYul8GwLXTPrw77zkKWzde0qtnEswCIa6s/JcirVlY/zRpD80xuxDRyUnVkte2gR
         1sxtFFPGYeJMYZr/5fqaXhgmNAYKEHT3c/xWcE2rFuTIzXkEx2wojs9/gUuMjxqtLXLE
         8oLHz/CZjKslOxWh6pd5cXO09AmTSB2mIBZWtRFr5CSLNQQIvIZmeSfY0MmxW+UcWWTD
         ut/bSi1mpOoYTE20T4daRb61paK0pnvFkhygFoZpGGdMxjDB8Yx18CWsdyzWY9iXBv+x
         quZw==
X-Gm-Message-State: AOAM530CK296XTo3dIx2wnrA3X7ZDHBLfKKNPnFDLiiRx95613UySe0v
        i93MInvtuCs/LY7N92F4xJ9//Q==
X-Google-Smtp-Source: ABdhPJxxjxDfePUL+ZrWmGQpCfk90nF4ermMnz9VruCwJ5VOs8yvxrVVB/cZUKwaTEtxBqS7qTN70A==
X-Received: by 2002:a17:90a:8816:: with SMTP id s22mr2211669pjn.231.1623313452088;
        Thu, 10 Jun 2021 01:24:12 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id j2sm6913313pji.34.2021.06.10.01.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 01:24:11 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] cpufreq: cppc: Migrate to ->exit() callback instead of ->stop_cpu()
Date:   Thu, 10 Jun 2021 13:53:57 +0530
Message-Id: <07fa2077b682d026c47192507f320da5bbd4e10f.1623313323.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1623313323.git.viresh.kumar@linaro.org>
References: <cover.1623313323.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 367dc4aa932b ("cpufreq: Add stop CPU callback to cpufreq_driver
interface") added the stop_cpu() callback to allow the drivers to do
clean up before the CPU is completely down and its state cannot be
modified.

At that time the CPU hotplug framework used to call the cpufreq core's
registered notifier for different events like CPU_DOWN_PREPARE and
CPU_POST_DEAD. The stop_cpu() callback was called during the
CPU_DOWN_PREPARE event.

This is no longer the case, cpuhp_cpufreq_offline() is called only once
by the CPU hotplug core now and we don't really need two separate
callbacks for cpufreq drivers, i.e. stop_cpu() and exit(), as everything
can be done from the exit() callback itself.

Migrate to using the exit() callback instead of stop_cpu().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 46 ++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 3848b4c222e1..30a861538784 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -384,27 +384,6 @@ static int cppc_verify_policy(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
-static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
-{
-	struct cppc_cpudata *cpu_data = policy->driver_data;
-	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
-	unsigned int cpu = policy->cpu;
-	int ret;
-
-	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
-
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
-	if (ret)
-		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 caps->lowest_perf, cpu, ret);
-
-	/* Remove CPU node from list and free driver data for policy */
-	free_cpumask_var(cpu_data->shared_cpu_map);
-	list_del(&cpu_data->node);
-	kfree(policy->driver_data);
-	policy->driver_data = NULL;
-}
-
 /*
  * The PCC subspace describes the rate at which platform can accept commands
  * on the shared PCC channel (including READs which do not count towards freq
@@ -557,6 +536,29 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static int cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
+
+	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	if (ret)
+		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
+			 caps->lowest_perf, cpu, ret);
+
+	/* Remove CPU node from list and free driver data for policy */
+	free_cpumask_var(cpu_data->shared_cpu_map);
+	list_del(&cpu_data->node);
+	kfree(policy->driver_data);
+	policy->driver_data = NULL;
+
+	return 0;
+}
+
 static inline u64 get_delta(u64 t1, u64 t0)
 {
 	if (t1 > t0 || t0 > ~(u32)0)
@@ -665,7 +667,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.target = cppc_cpufreq_set_target,
 	.get = cppc_cpufreq_get_rate,
 	.init = cppc_cpufreq_cpu_init,
-	.stop_cpu = cppc_cpufreq_stop_cpu,
+	.exit = cppc_cpufreq_cpu_exit,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
-- 
2.31.1.272.g89b43f80a514

