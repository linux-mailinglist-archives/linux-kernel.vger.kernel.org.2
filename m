Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0465C3B12C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 06:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhFWE1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 00:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFWE1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 00:27:16 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0DFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 21:24:58 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d12so665862pgd.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 21:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5xjI9Ft4Ufb3P2xW78lRK4EZEZNp1oyWp3i4UsHjcOQ=;
        b=rpEpW02sCPhAeieY8YKGZpRQeFRKEWmgMaE/6CSFjFaN3ZcJZrsCDugxR2bqzcf/ET
         f34P8r8jQDJcqMM1MW2PNQZaNAn0zjuzXiQU0avd9m1CbrdadKJotqml96+36krP5uME
         pFS+DHTXViUW1+Cwucw0l5O4mxwrLMM+EoltAJUOJ7PkNxXydoZ4RfaycOF7Fx4bcYkN
         BElFXjNeV79s9YLlgwqrMGEWAvWILYCnUXvD88slIsbJURe9UmZVQ0pndtKQ3U27qgBt
         AuvFxv3fazKLMWj/oYdOwU2Y2VM1CLJYZc8lhbK5TC70puMICaMOSq3FOcVupklEbmAm
         xbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5xjI9Ft4Ufb3P2xW78lRK4EZEZNp1oyWp3i4UsHjcOQ=;
        b=lZolTqR49LyDacnOZkg4GAomo2FnMqQ4t+aLzRcosky6UJ2+8ou2lNGX3gan5C+Cz1
         fyEfuE1jB5bHE4jH2HqG2UBdrjd4ygHNWkErGYrUlSGf1nrLxZWVS6ZqbrnwhO+mGEHl
         mH9JlFeVHDjtenMmYhxFTdsPFRU+Hb9whk2RFbGlnBkKotzV9sO5ojsYfCaXHHZqYwvA
         rODMm6oOXqf2/7NCNpVnBqMpTEAJS79AdeS7a0BgxaSK4PqAFxlgiydSugQnUgGaoLz8
         GGVetEwWpEKoAsWevbd7fgeFTWWj4S56hgX9DuvirJCrdpVhXVwpwvxds/Y96umR3Mo6
         RHPA==
X-Gm-Message-State: AOAM532oPpEKIcW2JyU0T/5pKT8BHPK2VO2oq3t5HnCWRjrScmQe20KY
        XLNpcN22j57mco3MxRUJX0fZjQ==
X-Google-Smtp-Source: ABdhPJwJmO5GkftCs9Xjm7jjQRx8YBAb8ct8MyDNaJijdxUtzF/nIsO1Gx3gwAAH8OZDTENsXVgJlg==
X-Received: by 2002:a62:3344:0:b029:28c:6f0f:cb90 with SMTP id z65-20020a6233440000b029028c6f0fcb90mr6866556pfz.58.1624422298462;
        Tue, 22 Jun 2021 21:24:58 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id 11sm779676pfh.182.2021.06.22.21.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 21:24:58 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/4] cpufreq: cppc: Migrate to ->exit() callback instead of ->stop_cpu()
Date:   Wed, 23 Jun 2021 09:54:39 +0530
Message-Id: <acd2f1b661083853bafca21982501654a2a2b973.1624421816.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1624421816.git.viresh.kumar@linaro.org>
References: <cover.1624421816.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 367dc4aa932b ("cpufreq: Add stop CPU callback to cpufreq_driver
interface") added the stop_cpu() callback to allow the drivers to do
clean up before the CPU is completely down and its state can't be
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
index 2f769b1630c5..be4f62e2c5f1 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -182,27 +182,6 @@ static int cppc_verify_policy(struct cpufreq_policy_data *policy)
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
@@ -352,6 +331,29 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
@@ -451,7 +453,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
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

