Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA093AE5D5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFUJWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhFUJW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:22:29 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A8CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:20:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g192so5481503pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+Pr0hB3aQxiWpb5eCV/aiPVZfCXjZdbK/uF+fA2suE=;
        b=GzDORQUQfU4EyaIz84r9ofxl7S2qiMUmnL8adgMAMRlSCje4XuoLkb9AZt5+OZ/uYc
         bdmFmBbJfOOzTSdfwKiThKNfnYfOjUzcgK0E1v1AHbdJxj8yDUAmT/WcHTgZF5V86eaW
         IOmErKVtiXIbnK72LGtHfyBwiLysLsLxXc0MfVqxq9qm/mlS5bUsh24zUD08THTH36H0
         7lBFyItmFb6sudEMOE4c8N6ae5aX1P0TbHDDmPPZdn5KYMBx5RczSegJQAcVOZyMWfGg
         vGNdwbIlfXD/vcmiDSuJsLaxrDRF+VXQsFrVUwIzFWJfHeRnc3YnWU0PCpSzn6OM8NwF
         B5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+Pr0hB3aQxiWpb5eCV/aiPVZfCXjZdbK/uF+fA2suE=;
        b=VCJUPoLe/AzyoYD3oB/GLXLHdlFJ8qaoFErl14M/NU57rLplGCFR+wh5j9JTCw7z9M
         fACYKaWS8/4c3hZ1vrAcc+6u3ETeSNeB2apF6wSqaeKVL5zXoZWBDhto7CcaJJjA+ETZ
         Iptxdmlz0U8UhJgFvqsgWRdyXkSPK4pg6tXwDzKahMN2l5veZGBMQqmPrjxkBQJIe4Fo
         g7546Vkjj4Tvt1hyfy1hRREVLAYXZjFgHUUWWGy8ORgPsQgBqhTHkXCsEW+u9G/jrwvd
         jCv4n1ilNp6DAjWWzml1qCkkuYj0yfBpMRVlJgjvkdKP4s9bksBRQ1aNgug/IEJNPwdj
         LAtQ==
X-Gm-Message-State: AOAM533n1ZUtMZovyn0hSjLFkpCsT56lYDnY9iI+V5N6DVgwesBEcBB8
        mAcNsb9pGXjNOX0tozFhYHaAxw==
X-Google-Smtp-Source: ABdhPJztGqVoSVeigfrMYYjeWjpM2W5IxlGJLJaOWvr+uIBpPJEwCRmMsMAJm6R+YxhzlWO4jag9lw==
X-Received: by 2002:a63:36c1:: with SMTP id d184mr23133582pga.47.1624267215148;
        Mon, 21 Jun 2021 02:20:15 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id c18sm1521186pfo.143.2021.06.21.02.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 02:20:14 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/4] cpufreq: cppc: Fix potential memleak in cppc_cpufreq_cpu_init
Date:   Mon, 21 Jun 2021 14:49:34 +0530
Message-Id: <579689469ed8a7dfd68dcbb41e9191472799a326.1624266901.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1624266901.git.viresh.kumar@linaro.org>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a classic example of memleak, we allocate something, we fail and
never free the resources.

Make sure we free all resources on policy ->init() failures.

Fixes: a28b2bfc099c ("cppc_cpufreq: replace per-cpu data array with a list")
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index be4f62e2c5f1..35b8ae66d1fb 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -256,6 +256,16 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 	return NULL;
 }
 
+static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+
+	list_del(&cpu_data->node);
+	free_cpumask_var(cpu_data->shared_cpu_map);
+	kfree(cpu_data);
+	policy->driver_data = NULL;
+}
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
@@ -309,7 +319,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	default:
 		pr_debug("Unsupported CPU co-ord type: %d\n",
 			 policy->shared_type);
-		return -EFAULT;
+		ret = -EFAULT;
+		goto out;
 	}
 
 	/*
@@ -324,10 +335,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
-	if (ret)
-		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 caps->highest_perf, cpu, ret);
+	if (!ret)
+		return 0;
 
+	pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
+		 caps->highest_perf, cpu, ret);
+
+out:
+	cppc_cpufreq_put_cpu_data(policy);
 	return ret;
 }
 
@@ -345,12 +360,7 @@ static int cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 			 caps->lowest_perf, cpu, ret);
 
-	/* Remove CPU node from list and free driver data for policy */
-	free_cpumask_var(cpu_data->shared_cpu_map);
-	list_del(&cpu_data->node);
-	kfree(policy->driver_data);
-	policy->driver_data = NULL;
-
+	cppc_cpufreq_put_cpu_data(policy);
 	return 0;
 }
 
-- 
2.31.1.272.g89b43f80a514

