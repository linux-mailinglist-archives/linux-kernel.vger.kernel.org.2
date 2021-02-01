Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A0430AF0C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhBASVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhBASPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:39 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4532BC0611C0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y10so6212793plk.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUTXKEyDoj2yYHV7VRlaeVtzyllZkVV0kWljFdybBQc=;
        b=opEvKWv5QoRwT30WTVzp5yrWzeuFQtpKLqPwN8Uyb+jH4PdqkIXmeagv0guR0tAaRp
         5wdxYueQ+YTMW8fqWq8tWfxtdL1zH/MBesu0wlKxKEoIDDohAiJ0U3quFRHBYMXaSWUD
         px8hRCQAT+318iemlpV699CeudNUzgiMAvRU9f7RhAzx3gQ1cTCUm21zauI60nHw68Uj
         U4UPizNOJWPdmd11tDOT5WulZhz6Rdw6y3Z/YMkMD6UUpPN8iZTL3qGxRvr5ydRH5X7o
         hAwmdU0sWBeDlbsihAaODfX9iAJn9IImiYUf/60LG4znVAAGl37aXYVhhmqnOkp3voCw
         muGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUTXKEyDoj2yYHV7VRlaeVtzyllZkVV0kWljFdybBQc=;
        b=UI7XDw1Au9aBupt/FD6jwwsyoNvWbYUgkuiUb6a/446d6Lhq2sNeybgaW6zVJKFmbN
         83AyzPRpWZM4NvPuct7LhpvduJ/zJXA+ASPZYY8o3QDEOVnVeCDQfv/IT+y9kkgZMTKs
         ZUWgrFsim3R/iGABmLP0y7Jv64RvKsARZEA/ndi+zTbpAzCEBxRiKhpuLDs162eGakRB
         fT+TO+JVHp4gvz8l01qe6FgwKGoOxubS1qEIZJF2B9rcWkYZ0zkSlmQQnQZ5YvZUQ7+/
         onJlLLkt22/K3naWRs+7ehe8gESedc3UpulOLkOCrUExiwH1470oV0on3+3QAb/hxGzZ
         xu/w==
X-Gm-Message-State: AOAM5336Gvkng8YHQqFYz8AW+Br30rqZblABaA64UNrQVDRVVgt33gh0
        zjJ5jrC7lhtk5Uwf1Iw9rDus2w==
X-Google-Smtp-Source: ABdhPJw/nAiZDK/T+Pgg2La1m2T8BiZb/t0a59Wp8Mcd+RaxYAaOlqp3bhxJDqV3tO8KAEN95i4sdA==
X-Received: by 2002:a17:90a:8c13:: with SMTP id a19mr152090pjo.80.1612203265683;
        Mon, 01 Feb 2021 10:14:25 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:25 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 30/31] coresight: Add support for v8.4 SelfHosted tracing
Date:   Mon,  1 Feb 2021 11:13:50 -0700
Message-Id: <20210201181351.1475223-31-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Zhou <jonathan.zhouwen@huawei.com>

v8.4 tracing extensions added support for trace filtering controlled
by TRFCR_ELx. This must be programmed to allow tracing at EL1/EL2 and
EL0. The timestamp used is the virtual time. Also enable CONTEXIDR_EL2
tracing if we are running the kernel at EL2.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
[ Move the trace filtering setup etm_init_arch_data() and clean ups]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-29-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-core.c          | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index c6238e208685..473ab7480a36 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -859,6 +859,30 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
 	return false;
 }
 
+static void cpu_enable_tracing(void)
+{
+	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
+	u64 trfcr;
+
+	if (!cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_TRACE_FILT_SHIFT))
+		return;
+
+	/*
+	 * If the CPU supports v8.4 SelfHosted Tracing, enable
+	 * tracing at the kernel EL and EL0, forcing to use the
+	 * virtual time as the timestamp.
+	 */
+	trfcr = (TRFCR_ELx_TS_VIRTUAL |
+		 TRFCR_ELx_ExTRE |
+		 TRFCR_ELx_E0TRE);
+
+	/* If we are running at EL2, allow tracing the CONTEXTIDR_EL2. */
+	if (is_kernel_in_hyp_mode())
+		trfcr |= TRFCR_EL2_CX;
+
+	write_sysreg_s(trfcr, SYS_TRFCR_EL1);
+}
+
 static void etm4_init_arch_data(void *info)
 {
 	u32 etmidr0;
@@ -1044,6 +1068,7 @@ static void etm4_init_arch_data(void *info)
 	/* NUMCNTR, bits[30:28] number of counters available for tracing */
 	drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
 	etm4_cs_lock(drvdata, csa);
+	cpu_enable_tracing();
 }
 
 static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
-- 
2.25.1

