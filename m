Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F7A45F4D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 19:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244612AbhKZSp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 13:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhKZSnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 13:43:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1702C08E6DF
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 10:15:37 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t9so3418213wrx.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 10:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JXIYabK6ZewRD4vP7R+kD9rZl3/XxOM5JXs9rSVNxs0=;
        b=iTFnKGSsCVTLxOd2xAfdCzvJtLtXzzeLRYgCDPm3rGbRtGGq/VpgOhMGAuFZfGAMPT
         vEVGEd97GyCp4Tgjw/UztITGZiYsO+m2NVbT1pADsFIQSXRf2wPDtNBQXIBoGXbhURZk
         skC+IFSr+b627dGkG1ZxZ78+cBFujDuOH3hdYlyEfud1o80wo3EgXmr21+8xLV41HAs/
         SGw6nXF0WaABUlHbYm/FpKkydUzCC/dRSlz1n2Q2yGl5rNVWVRuj05r1Yw6jrIXApgkC
         kc4r6QMEPbuCDQPLf8kGEczwhK6T9Q368rfn2Rg73Gaf1+OiO/S8MmxfxWI2CPk6AaTb
         VY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JXIYabK6ZewRD4vP7R+kD9rZl3/XxOM5JXs9rSVNxs0=;
        b=bXq3BKTAPBNDAeNZ0qDOL+Du/h6+pl3AAM5m1eXp8x+bvpdgFmGg/FQ8+hTgQz+8dR
         pCIksvsY7/j8Z2s2WzWDUEU4Imd91BOq2nU1z6B/CAMwefDNv8S86moM0xykSpZjb6cX
         +11RdH0MtFJlqnkpvtIHpSE/o6K9hQx78fS5+OnnkNE+re2eYbogbIuDBX7kp68fr0Y0
         3scJnNpNPINlovFIWpgeHnI1ctJET4RkhVxubn3xIOtoyMwkP/DWlpCMLUJUAnvE5UmD
         FoQb5OzCt/zoPyfZxFkqQ50QrXYkiSj+mIoPPKmH2XydFr1Z1AQFiBNlDT5voVuiwYOr
         JQ6A==
X-Gm-Message-State: AOAM533g+Lm0F04l5YDyus2FulVcfKDfUDoossvb7MH0pLAR+TC6Tcp8
        SWPpzG3VTwneQyoLoYL2jIhh1R8P1W0myA==
X-Google-Smtp-Source: ABdhPJwBNAihgPFhPG45uccfV3J1jHnFSsVV93NNcItup99n9uFLMD6GVATlMeefD3dd52RWyK1paw==
X-Received: by 2002:a05:6000:1862:: with SMTP id d2mr16409699wri.251.1637950536359;
        Fri, 26 Nov 2021 10:15:36 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:70b:e5b5:f868:20cf])
        by smtp.gmail.com with ESMTPSA id r83sm11744735wma.22.2021.11.26.10.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 10:15:35 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     robh@kernel.org, arnd@linaro.org, heiko@sntech.de,
        ulf.hansson@linaro.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 4/5] powercap/drivers/dtpm: Add CPU DT initialization support
Date:   Fri, 26 Nov 2021 19:14:57 +0100
Message-Id: <20211126181500.3404129-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126181500.3404129-1-daniel.lezcano@linaro.org>
References: <20211126181500.3404129-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the previous DT changes in the core code, use the 'setup'
callback to initialize the CPU DTPM backend.

Code is reorganized to stick to the DTPM table description. No
functional changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm_cpu.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 6bffb44c75aa..64cec0770803 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -21,6 +21,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/dtpm.h>
 #include <linux/energy_model.h>
+#include <linux/of.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/units.h>
@@ -176,6 +177,17 @@ static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
 }
 
 static int cpuhp_dtpm_cpu_online(unsigned int cpu)
+{
+	struct dtpm_cpu *dtpm_cpu;
+
+	dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
+	if (dtpm_cpu)
+		return dtpm_update_power(&dtpm_cpu->dtpm);
+
+	return 0;
+}
+
+static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 {
 	struct dtpm_cpu *dtpm_cpu;
 	struct cpufreq_policy *policy;
@@ -183,6 +195,10 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	char name[CPUFREQ_NAME_LEN];
 	int ret = -ENOMEM;
 
+	dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
+	if (dtpm_cpu)
+		return 0;
+
 	policy = cpufreq_cpu_get(cpu);
 	if (!policy)
 		return 0;
@@ -191,10 +207,6 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	if (!pd)
 		return -EINVAL;
 
-	dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
-	if (dtpm_cpu)
-		return dtpm_update_power(&dtpm_cpu->dtpm);
-
 	dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
 	if (!dtpm_cpu)
 		return -ENOMEM;
@@ -207,7 +219,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 
 	snprintf(name, sizeof(name), "cpu%d-cpufreq", dtpm_cpu->cpu);
 
-	ret = dtpm_register(name, &dtpm_cpu->dtpm, NULL);
+	ret = dtpm_register(name, &dtpm_cpu->dtpm, parent);
 	if (ret)
 		goto out_kfree_dtpm_cpu;
 
@@ -231,6 +243,17 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	return ret;
 }
 
+static int __init dtpm_cpu_setup(struct dtpm *dtpm, struct device_node *np)
+{
+	int cpu;
+
+	cpu = of_cpu_node_to_id(np);
+	if (cpu < 0)
+		return 0;
+
+	return __dtpm_cpu_setup(cpu, dtpm);
+}
+
 static int __init dtpm_cpu_init(void)
 {
 	int ret;
@@ -269,4 +292,4 @@ static int __init dtpm_cpu_init(void)
 	return 0;
 }
 
-DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init, NULL);
+DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init, dtpm_cpu_setup);
-- 
2.25.1

