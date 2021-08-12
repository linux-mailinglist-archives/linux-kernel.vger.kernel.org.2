Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798083E9D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 06:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhHLEgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 00:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhHLEgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 00:36:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642B4C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:35:49 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g12-20020a17090a7d0cb0290178f80de3d8so8588813pjl.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 21:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cJkxi06rEFhzSNPo56wxZ6biRKSh//pEh5NibXjmjwM=;
        b=RAirbPPx9tnYmbm7/B3VW4qbupcBxMwQjkcXHBx+L3yU6yxYBF+d9XUAInkPCyrn5B
         SRKabkuLIqGhQlNSuABj1NaR0ajNPChwmDUeed35LL86Frnk9LuGSVhl8oC2mIb1cF/b
         yWV54ZAS63LGN4XEqb8kAUqSNuoOoa9W1N1iNJEHnxpTf8vzopA7ovS5/kMJVQbHxFBn
         UZpWcqkInRb/D+Bhw1CfSBdQBAQ3aXcnxN9ePDT8ZVUWeA2QLEy/L3VJMXneTioQvsZB
         xz2bPCW/ZmYqSctomgT4xIc1fkwxBAPCDp7Un6a+dU2aKGT9/k+VH2uL69KgTJNzGdgx
         I/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cJkxi06rEFhzSNPo56wxZ6biRKSh//pEh5NibXjmjwM=;
        b=E6rR4SCmSUMKyo+QvzDRixtm4yd2d+XIb89CxzyfZ2fBWDXCkuEHGr8euOPgSpq0NX
         mH5Ynx/l1rH9z/qPo8H/sQkd0uckiaauEMl8phX7y8UwxZe6FN6G72nImPEpsd9SSPE0
         GNNE2X/VJ6IVkyK2/o7PtVqtrdFLSP1UZuvh1Bf0EQRPeeKxVWVGf82SOP05MkhoGLRP
         TsrxI6I72xc+Zuy0kb4DT3aML6Qkx4ECucltM2enctWPmEolRDrH81qTMesgxWkzS8PW
         P3FkjLndXTDuEP5SHUIHAIWIZBdhbGiGqMf+vsiTTUAjqeQ7MpYatgRvWNP7ubgGIbYE
         RRtg==
X-Gm-Message-State: AOAM532C3kHnUDLMBEOXy3pp1Ml2rKyR5mA7aJAkH3ynYhIrG77WCeAl
        uo0z3iAK1kY3GXh06yCdI8jBNQ==
X-Google-Smtp-Source: ABdhPJzYe9Uc7POMbit2QutNMEOk3hhy8oW8sfasQhDB1KbeeyaPb12rwkhy74NMfpkHICl6ATiB+A==
X-Received: by 2002:a17:902:a702:b029:12b:aa0f:d553 with SMTP id w2-20020a170902a702b029012baa0fd553mr2035019plq.3.1628742948946;
        Wed, 11 Aug 2021 21:35:48 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id s14sm1268828pfg.220.2021.08.11.21.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:35:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Quentin Perret <qperret@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/9] cpufreq: Add callback to register with energy model
Date:   Thu, 12 Aug 2021 10:05:14 +0530
Message-Id: <c17495b01b72b53bd290f442d39b060e015c7aea.1628742634.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628742634.git.viresh.kumar@linaro.org>
References: <cover.1628742634.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many cpufreq drivers register with the energy model for each policy and
do exactly the same thing. Follow the footsteps of thermal-cooling, to
get it done from the cpufreq core itself.

Provide a new callback, which will be called, if present, by the cpufreq
core at the right moment (more on that in the code's comment). Also
provide a generic implementation that uses dev_pm_opp_of_register_em().

This also allows us to register with the EM at a later point of time,
compared to ->init(), from where the EM core can access cpufreq policy
directly using cpufreq_cpu_get() type of helpers and perform other work,
like marking few frequencies inefficient, this will be done separately.

Reviewed-by: Quentin Perret <qperret@google.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 13 +++++++++++++
 include/linux/cpufreq.h   | 14 ++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 45f3416988f1..d301f39248a0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1491,6 +1491,19 @@ static int cpufreq_online(unsigned int cpu)
 		write_lock_irqsave(&cpufreq_driver_lock, flags);
 		list_add(&policy->policy_list, &cpufreq_policy_list);
 		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+
+		/*
+		 * Register with the energy model before
+		 * sched_cpufreq_governor_change() is called, which will result
+		 * in rebuilding of the sched domains, which should only be done
+		 * once the energy model is properly initialized for the policy
+		 * first.
+		 *
+		 * Also, this should be called before the policy is registered
+		 * with cooling framework.
+		 */
+		if (cpufreq_driver->register_em)
+			cpufreq_driver->register_em(policy);
 	}
 
 	ret = cpufreq_init_policy(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9fd719475fcd..c65a1d7385f8 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -9,10 +9,12 @@
 #define _LINUX_CPUFREQ_H
 
 #include <linux/clk.h>
+#include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/completion.h>
 #include <linux/kobject.h>
 #include <linux/notifier.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
 #include <linux/spinlock.h>
 #include <linux/sysfs.h>
@@ -373,6 +375,12 @@ struct cpufreq_driver {
 	/* platform specific boost support code */
 	bool		boost_enabled;
 	int		(*set_boost)(struct cpufreq_policy *policy, int state);
+
+	/*
+	 * Set by drivers that want to register with the energy model after the
+	 * policy is properly initialized, but before the governor is started.
+	 */
+	void		(*register_em)(struct cpufreq_policy *policy);
 };
 
 /* flags */
@@ -1046,4 +1054,10 @@ unsigned int cpufreq_generic_get(unsigned int cpu);
 void cpufreq_generic_init(struct cpufreq_policy *policy,
 		struct cpufreq_frequency_table *table,
 		unsigned int transition_latency);
+
+static inline void cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
+{
+	dev_pm_opp_of_register_em(get_cpu_device(policy->cpu),
+				  policy->related_cpus);
+}
 #endif /* _LINUX_CPUFREQ_H */
-- 
2.31.1.272.g89b43f80a514

