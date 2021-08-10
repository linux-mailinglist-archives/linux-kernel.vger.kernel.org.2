Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484273E5464
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbhHJHh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbhHJHh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:37:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F7EC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:37:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so4133530pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZMnI+ITVBnBcneBIgvhNm4piucoB9ecl6DZQEqepNc=;
        b=ussZDGKOXX/2mkZH5nS13YeUAqSCGfAjQ1/Hs72syBDUyUK1jzDkKS8xsyVvLvyjE9
         CIZjQNxPnkyuvb0DAV/4sxnkxL2IjezejN73dFjQ5l/W9fRT07jA2hTRbRGMlOyIMDJQ
         mLkaA21gaqA1IwLRHBAdu2MTsLg3uAOz2CRAbPc93WzsMjUc29tQKIDD8XvpNSo+s8zn
         njTVprhkFudNvMEhJskzmhUVJ/r9IkbGRzxKGwICtyK4pDZJetllqkLA6BhaAb+MC3fb
         VnNOojFgtp/C+bHo0FYwxoTnqF8lvywlatxLoFMZXm5vTs9xLaSAGiOl05ml64ADSrGj
         TAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZMnI+ITVBnBcneBIgvhNm4piucoB9ecl6DZQEqepNc=;
        b=TJS5gR8jnyeRpg324MG8f9WW9oZ5i0VqLhWC3BYpnhlxTvHTRYqq35+yEZmT+vhq/V
         6zmO/b0fU+gkdBCf334DDfdX0lpF8vl7sO24S2DdcDIz2KrqyXaPoBFD/cSyHy00G7J3
         r2eunPmc6KuipeElzvzRUvO0NmTQtWZ4yAuQ9YfC/eE/bm4vBJAaxCThneQLlCNzBpuy
         J5xwOPbZcgwmW/wRJodZlkxm4PANSoP2tAvDJouvh0gG+GR8ftjJ6fSR2HPzx5kFZueh
         0Aed/llBAN2XyXvqirH8tsLkTmKv2A/Q3pI1sZG7funu7gi3o45TSkDV2C8YQl46g7uy
         892Q==
X-Gm-Message-State: AOAM531aIalGGB9xLUqTOA9nybXeIbJ6NfEOksz/DsXLamxIpHMldM+W
        QYFYNUk39N7XpiKqN7fRITs4vg==
X-Google-Smtp-Source: ABdhPJytiBET/ss+m+yWyb9JeDYcJvkpyXiuWhA05uHcWM750Z6HXoGn9UXm6x1Ppt3TOt2R1h4m+A==
X-Received: by 2002:a17:902:70c6:b029:12c:c0f3:605c with SMTP id l6-20020a17090270c6b029012cc0f3605cmr23934208plt.70.1628581026997;
        Tue, 10 Aug 2021 00:37:06 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id a185sm5054759pfa.205.2021.08.10.00.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:37:06 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] cpufreq: Auto-register with energy model if asked
Date:   Tue, 10 Aug 2021 13:06:48 +0530
Message-Id: <b48e2c944db072c220a1b0ae0c3d94eb1c4da7ab.1628579170.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628579170.git.viresh.kumar@linaro.org>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many cpufreq drivers register with the energy model for each policy and
do exactly the same thing. Follow the footsteps of thermal-cooling, to
get it done from the cpufreq core itself.

Provide a cpufreq driver flag so drivers can ask the cpufreq core to
register with the EM core on their behalf. This allows us to get rid of
duplicated code in the drivers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 9 +++++++++
 include/linux/cpufreq.h   | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 06c526d66dd3..a060dc2aa2f2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -23,6 +23,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
@@ -1511,6 +1512,11 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_thermal_control_enabled(cpufreq_driver))
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
+	if (cpufreq_driver->flags & CPUFREQ_REGISTER_WITH_EM) {
+		dev_pm_opp_of_register_em(get_cpu_device(policy->cpu),
+					  policy->related_cpus);
+	}
+
 	pr_debug("initialization complete\n");
 
 	return 0;
@@ -1602,6 +1608,9 @@ static int cpufreq_offline(unsigned int cpu)
 		goto unlock;
 	}
 
+	if (cpufreq_driver->flags & CPUFREQ_REGISTER_WITH_EM)
+		dev_pm_opp_of_unregister_em(get_cpu_device(cpu));
+
 	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
 		cpufreq_cooling_unregister(policy->cdev);
 		policy->cdev = NULL;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9fd719475fcd..f11723cd4cca 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -424,6 +424,12 @@ struct cpufreq_driver {
  */
 #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
 
+/*
+ * Set by drivers that want the core to automatically register the CPU device
+ * with Energy Model.
+ */
+#define CPUFREQ_REGISTER_WITH_EM		BIT(7)
+
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
-- 
2.31.1.272.g89b43f80a514

