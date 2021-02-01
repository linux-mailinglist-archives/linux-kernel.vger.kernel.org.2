Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D780930AEEC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhBASRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhBASPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:12 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3754BC061356
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:12 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u11so10444778plg.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nkl7K2vw3TX4frhQPmfegkQUMEyqX+IThipL7KY2uDo=;
        b=iIgmVpOKir7028W23vrGXUNsAxqqcr87Dah8tG6OvnNYIf24c+MTPaS8nMFxSxLlqW
         v6nXnmm1Gom//iRpRbv8tXFt4hNGfMuFOoeUHNLn/p8Qt48PBym3QJsVk8u1o+nXNQSo
         oQu/JtFFOMWLV9XEwqVIlPxd9orDLyTXN5LFOs4W39L9SjFHV9mfPXjdECylXiVnUk4s
         NdgLABs71iWl2y9wFn2KEWLU5S0P6a9DBQNVgfV6pN5A+Goh+3wxTNufMsWM8wpSVfpz
         /sbOlIa0QvqueF4iIuvieYMI2uvMs3hLhdHVoRN2kNozOw8AKJoqohXsC+iTu5ATu1Nx
         Ie+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nkl7K2vw3TX4frhQPmfegkQUMEyqX+IThipL7KY2uDo=;
        b=Rcu+pekFTo8lUhpU0TWRKDEFPbUtM3Kzn0q/tN4cQQK9Lt7NieqClxi0sNPQ1uPD34
         KUHprSgpMI2S0p9GIC2EQ2ZMMawtQiMlkNGMNDkelOzMoBwgn/+M058ytah1l7Okgmx/
         FBp1CzVfypI7dZgFYAFKK8GTxn/GHpAymc48aqPmkL7S5psoA0XGCDBBraQNxG3kdAxS
         F204oKFReDFstmEHE/i6rSVeoWm3ORq3GaszkLz+al1a8AbzRZGNJIhp2jqRbMPzq733
         OzKpsJqYny/qZRNcBQfFgQQmz+WdtmzcWif66k75T9S8FueZZi0YIvOpwRytSqhBdYAH
         ITUA==
X-Gm-Message-State: AOAM531fL3OKYkqEx7VCydbBtAAowWSBfkGYVSWpej1InZ1yyRdjF6aI
        itPs3Az5j5ecfST1fYMFC9BPbw==
X-Google-Smtp-Source: ABdhPJzuIgvytfBVtpkA2FJ9wHNHdDAGigkR/PxPydd4F18Pek1Eo61VNMxbJwmCpy5rOUXZGyoTLA==
X-Received: by 2002:a17:902:c40b:b029:de:2f1e:825c with SMTP id k11-20020a170902c40bb02900de2f1e825cmr18945101plk.64.1612203251771;
        Mon, 01 Feb 2021 10:14:11 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:11 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/31] coresight: etm4x: Cleanup secure exception level masks
Date:   Mon,  1 Feb 2021 11:13:37 -0700
Message-Id: <20210201181351.1475223-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

We rely on the ETM architecture version to decide whether
Secure EL2 is available on the CPU for excluding the level
for address comparators and viewinst main control register.
We must instead use the TRCDIDR3.EXLEVEL_S field to detect
the supported levels.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-16-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++----------
 drivers/hwtracing/coresight/coresight-etm4x.h      |  6 ++++--
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index f095ab9949d9..d91b259a4334 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -840,7 +840,6 @@ static void etm4_init_arch_data(void *info)
 	 * TRCARCHMAJ, bits[11:8] architecture major versin number
 	 */
 	drvdata->arch = BMVAL(etmidr1, 4, 11);
-	drvdata->config.arch = drvdata->arch;
 
 	/* maximum size of resources */
 	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
@@ -856,6 +855,7 @@ static void etm4_init_arch_data(void *info)
 	drvdata->ccitmin = BMVAL(etmidr3, 0, 11);
 	/* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
 	drvdata->s_ex_level = BMVAL(etmidr3, 16, 19);
+	drvdata->config.s_ex_level = drvdata->s_ex_level;
 	/* EXLEVEL_NS, bits[23:20] Non-secure state instruction tracing */
 	drvdata->ns_ex_level = BMVAL(etmidr3, 20, 23);
 
@@ -1027,16 +1027,9 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
 static u64 etm4_get_access_type(struct etmv4_config *config)
 {
 	u64 access_type = etm4_get_ns_access_type(config);
-	u64 s_hyp = (config->arch & 0x0f) >= 0x4 ? ETM_EXLEVEL_S_HYP : 0;
 
-	/*
-	 * EXLEVEL_S, bits[11:8], don't trace anything happening
-	 * in secure state.
-	 */
-	access_type |= (ETM_EXLEVEL_S_APP	|
-			ETM_EXLEVEL_S_OS	|
-			s_hyp			|
-			ETM_EXLEVEL_S_MON);
+	/* All supported secure ELs are excluded */
+	access_type |= (u64)config->s_ex_level << TRCACATR_EXLEVEL_SHIFT;
 
 	return access_type;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index fba3c02eea0b..29cd27f53e72 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -557,6 +557,8 @@
 /* PowerDown Control Register bits */
 #define TRCPDCR_PU			BIT(3)
 
+#define TRCACATR_EXLEVEL_SHIFT		8
+
 /* secure state access levels - TRCACATRn */
 #define ETM_EXLEVEL_S_APP		BIT(8)
 #define ETM_EXLEVEL_S_OS		BIT(9)
@@ -631,7 +633,7 @@ enum etm_impdef_type {
  * @vmid_mask0:	VM ID comparator mask for comparator 0-3.
  * @vmid_mask1:	VM ID comparator mask for comparator 4-7.
  * @ext_inp:	External input selection.
- * @arch:	ETM architecture version (for arch dependent config).
+ * @s_ex_level: Secure ELs where tracing is supported.
  */
 struct etmv4_config {
 	u32				mode;
@@ -675,7 +677,7 @@ struct etmv4_config {
 	u32				vmid_mask0;
 	u32				vmid_mask1;
 	u32				ext_inp;
-	u8				arch;
+	u8				s_ex_level;
 };
 
 /**
-- 
2.25.1

