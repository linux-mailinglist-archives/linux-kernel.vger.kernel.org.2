Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8918D3B12C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 06:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhFWE1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 00:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhFWE1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 00:27:19 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E219FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 21:25:01 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id e22so664018pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 21:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EPOEQ7pRTnNWs9xaNPcoV7k6Yz2O7yBdc0WvhyMJhVY=;
        b=b8ZR4og0732gAR3c1QYoPDfJ0QOfR/MZV3Znls5zMiLv1QapescQpW0mD0cXuEw5Y+
         3ryskYMHsIw99NYuadcF4O8zZpYOnknde2t3RqK3gw6O00rMiPD5u6zLv9ZPRTnmPtqS
         QaibiMZ53wEa0Jnl4UvoisAz+Mq2Sd/rYN+VPqYLh+AeOXqhwxYhgYlhJ/KIAbBLM2u/
         RWaqb4dhS1RkSbnBFmzrpXoZteqOa4XE8SvRzjqKDRyngP1oIPE3ybe5u+9TezGMdJET
         G/83PxfoCv7PcITInYuigzvIk8yHyiE9S5Cp0CbNDM2i6M9FELfdjrys21Wt+7pVpMRy
         9m9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EPOEQ7pRTnNWs9xaNPcoV7k6Yz2O7yBdc0WvhyMJhVY=;
        b=aguD4fahBhjmuK7HQpouB6s/dejP1lFb6CgGGLGwV/8CLx1qlofS/w+iSdspqsrJcr
         zCGzdkXme2sjnSRAZBJe+80GZT4Uo85CjERtlAdpmWbQ0VGQEH5PjUbf5D9w2aolUq2O
         VUff3CZy/AWN88yZdwy1O0sIXrdS8cI0a+HAq0CAtPvMTS6L4pbWWsdXeBEiB7q4VSPw
         v8XL9o59Wzo9ramBoU1HSSB+DVXnEg7hxCqN1hjCNVrOnvE43EVCkEWYneqtgdeO7FYA
         H+mHhBIfKJ0e7MMq9iQvytSG/GvgvaQrJd6r3VrRLNPmmVcXt17Oj3y4GtCQLyKPeBsi
         Il6g==
X-Gm-Message-State: AOAM531isCQtWg3nahQK7lYRTwbjUfocAJ5YBJehcXz21CANkmeo41el
        Ej4HG+VcCaN7d4Rt7Hfc9BwbQw==
X-Google-Smtp-Source: ABdhPJwtaLYPkAkke/7GDdYEPqEd+You7RszJVPaWQ98zJu6S3iWxjde5O/SpattSp4ZGVHE9cqODQ==
X-Received: by 2002:aa7:954c:0:b029:2f5:33fc:1073 with SMTP id w12-20020aa7954c0000b02902f533fc1073mr6933781pfq.79.1624422301480;
        Tue, 22 Jun 2021 21:25:01 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id v3sm802496pfb.126.2021.06.22.21.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 21:25:01 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dirk Brandewie <dirk.brandewie@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/4] cpufreq: intel_pstate: Migrate to ->offline() instead of ->stop_cpu()
Date:   Wed, 23 Jun 2021 09:54:40 +0530
Message-Id: <6144911f36d3d1f5faddf81d744bd39946843f6b.1624421816.git.viresh.kumar@linaro.org>
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
by the CPU hotplug core now and we don't really need to separately
call stop_cpu() for cpufreq drivers.

Migrate to using the offline() callbacks instead of stop_cpu().

Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 0e69dffd5a76..b4c0ff7f5b71 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2335,6 +2335,8 @@ static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
 
 	pr_debug("CPU %d going offline\n", cpu->cpu);
 
+	intel_pstate_clear_update_util_hook(policy->cpu);
+
 	if (cpu->suspended)
 		return 0;
 
@@ -2374,13 +2376,6 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
-{
-	pr_debug("CPU %d stopping\n", policy->cpu);
-
-	intel_pstate_clear_update_util_hook(policy->cpu);
-}
-
 static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
 {
 	pr_debug("CPU %d exiting\n", policy->cpu);
@@ -2451,7 +2446,6 @@ static struct cpufreq_driver intel_pstate = {
 	.resume		= intel_pstate_resume,
 	.init		= intel_pstate_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
-	.stop_cpu	= intel_pstate_stop_cpu,
 	.offline	= intel_pstate_cpu_offline,
 	.online		= intel_pstate_cpu_online,
 	.update_limits	= intel_pstate_update_limits,
-- 
2.31.1.272.g89b43f80a514

