Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C5A3A26E7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFJI0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhFJI0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:26:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AD4C0617A8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 01:24:21 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h16so3203343pjv.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 01:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CWh1Aokcvj2UQLotNOEP1WcKgv5ApFMcJuxcuwZzDnY=;
        b=yfdQVopR5TI3meR02dYmXSyInvDr/3fhuuTS2PsKDcsKLC6x8NTEx3quKD6H2xTcyr
         hXwuuTiL2kCbiS5eVHWLzGnZEc3Ks6Q9Fa08m2lXkTLq1ygZ1WmoqMyyEWR+BX2eBHbe
         WX7pdOLNlu2PT45ePAJlWjm2y8tido3FmiO+ZknmtSDKH5fJbtc37Mnrx2IFMvCJTLVq
         bb+dnqC9aHYa3n3L9GqoKHCTPCmU25TD2GEwd5xUbqdV2hetEL+edqptR8vQWLscui2W
         lX2APi+adydBdmwI3t9qFgYUSXyzCHb91KzFb4+/dffecVL2MjhHgOvg39lq6UXspvqO
         W2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CWh1Aokcvj2UQLotNOEP1WcKgv5ApFMcJuxcuwZzDnY=;
        b=rRe1D6Cv//WaNkR8fV3JWfctvwu8sxeSYKwZUF+39+9QQd53weqTle5wZbR4TG+g+X
         gLp681iSdKZo6M6TspykelnKRmjwKKKLN5+0wuKbAEpFOqAw91pUFCw4+JVse6rnr+sV
         wtZSDMl8p18w8VOy7pP+zmFSL9bVFRSK04MbV3NbdMFO2xMUolZgaFwaqqBLVXLuzy1O
         D9n4hDnKAbrzx7X9FrLtSCMp3yoWZ3dvsCE0G9rwZq67b3IvCUNtUWqJp6tX02cDMl5+
         C1941T5P4U774+NOpGSvCpx2htVbfxqvtfYlqOixmHZURcet9FiTPisawhIXt3+7Du0k
         XTMA==
X-Gm-Message-State: AOAM531C4aKD7A0jb6VsfWMmKiZwFh8v+rZaDySOh/ts0QeLRSDGbBy8
        vtt6H38SBv+U8xC7hKlqpzSh1Q==
X-Google-Smtp-Source: ABdhPJyaaDXr8g7kkcXGZv4NNDc5gQjlEQI1ewN+YWmwgslYfZxiziQFr5nDp23V0bWGIf5Xfv9FDA==
X-Received: by 2002:a17:902:a3c3:b029:f0:b297:7778 with SMTP id q3-20020a170902a3c3b02900f0b2977778mr3939702plb.16.1623313460999;
        Thu, 10 Jun 2021 01:24:20 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id s3sm2120419pgs.62.2021.06.10.01.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 01:24:20 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] cpufreq: Add start_cpu() and stop_cpu() callbacks
Date:   Thu, 10 Jun 2021 13:54:00 +0530
Message-Id: <1d1c3ee64c0a5a701c8d7c66440fd2781512432c.1623313323.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1623313323.git.viresh.kumar@linaro.org>
References: <cover.1623313323.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On CPU hotplug, the cpufreq core doesn't call any driver specific
callback unless all the CPUs of a policy went away.

There is need for a callback to be called in such cases (for the CPPC
cpufreq driver) now. Reuse the existing stop_cpu() callback and add a
new one for start_cpu().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/cpu-drivers.rst |  7 +++++--
 drivers/cpufreq/cpufreq.c              | 11 ++++++++---
 include/linux/cpufreq.h                |  5 ++++-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/cpu-freq/cpu-drivers.rst b/Documentation/cpu-freq/cpu-drivers.rst
index a697278ce190..15cfe42b4075 100644
--- a/Documentation/cpu-freq/cpu-drivers.rst
+++ b/Documentation/cpu-freq/cpu-drivers.rst
@@ -71,8 +71,11 @@ And optionally
  .exit - A pointer to a per-policy cleanup function called during
  CPU_POST_DEAD phase of cpu hotplug process.
 
- .stop_cpu - A pointer to a per-policy stop function called during
- CPU_DOWN_PREPARE phase of cpu hotplug process.
+ .start_cpu - A pointer to a per-policy per-cpu start function called
+ during CPU online phase.
+
+ .stop_cpu - A pointer to a per-policy per-cpu stop function called
+ during CPU offline phase.
 
  .suspend - A pointer to a per-policy suspend function which is called
  with interrupts disabled and _after_ the governor is stopped for the
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 802abc925b2a..fac2522be5c3 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1119,6 +1119,10 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
 
 	cpumask_set_cpu(cpu, policy->cpus);
 
+	/* Do CPU specific initialization if required */
+	if (cpufreq_driver->start_cpu)
+		cpufreq_driver->start_cpu(policy, cpu);
+
 	if (has_target()) {
 		ret = cpufreq_start_governor(policy);
 		if (ret)
@@ -1581,6 +1585,10 @@ static int cpufreq_offline(unsigned int cpu)
 		policy->cpu = cpumask_any(policy->cpus);
 	}
 
+	/* Do CPU specific de-initialization if required */
+	if (cpufreq_driver->stop_cpu)
+		cpufreq_driver->stop_cpu(policy, cpu);
+
 	/* Start governor again for active policy */
 	if (!policy_is_inactive(policy)) {
 		if (has_target()) {
@@ -1597,9 +1605,6 @@ static int cpufreq_offline(unsigned int cpu)
 		policy->cdev = NULL;
 	}
 
-	if (cpufreq_driver->stop_cpu)
-		cpufreq_driver->stop_cpu(policy);
-
 	if (has_target())
 		cpufreq_exit_governor(policy);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 353969c7acd3..c281b3df4e2f 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -371,7 +371,10 @@ struct cpufreq_driver {
 	int		(*online)(struct cpufreq_policy *policy);
 	int		(*offline)(struct cpufreq_policy *policy);
 	int		(*exit)(struct cpufreq_policy *policy);
-	void		(*stop_cpu)(struct cpufreq_policy *policy);
+
+	/* CPU specific start/stop */
+	void		(*start_cpu)(struct cpufreq_policy *policy, unsigned int cpu);
+	void		(*stop_cpu)(struct cpufreq_policy *policy, unsigned int cpu);
 	int		(*suspend)(struct cpufreq_policy *policy);
 	int		(*resume)(struct cpufreq_policy *policy);
 
-- 
2.31.1.272.g89b43f80a514

