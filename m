Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A36B30AF41
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhBAS3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhBASPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:55 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D9DC061221
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:19 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y205so12141702pfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wj97ynLU4juHaZmg3FI2nAyQleSP0VKWb4lYRditvLs=;
        b=lQwcqLvw8KMiYbtmguszA1QIr306Nxkib7LQWBdGOMDj7eWlz14SqyV1pUT1Ya1RzB
         VX7b0+KFRA7EXWdn1vvS58zfyXA05FFs85NFkrXR5GY1+mGrzA14T55PUOR8rdySSTM/
         JO78TY+BsLxNuEiZMtBHTMyumeLv9r5T8KCvENFc2XryGPSjs9zdlfdw/bqhpcFtyJvu
         ewaRYbE+wBhA1iQs5lWYgHRhrZxZRfXKr7iEdbotiPQVLQ8SOat0dKBOfnRNzKxVCnjy
         XY+atthpVGUYXbubwSZg0y+v33KcFtztygvTTfsMZwqdkzXfGzWAekIcpGxcCCGfY5hn
         r+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wj97ynLU4juHaZmg3FI2nAyQleSP0VKWb4lYRditvLs=;
        b=kCF7hDmt/1Ppqc+PQMns6HTF7ma5cm9f3NltRpklmUmZeieM9hhyXq/LNTGe4vTPnX
         BBE5fw0LwBlq0G5i8d9FYeRIjCFGPNgxO0TAaRhtNSD7lmIKV98Pfllev3nzfjlp7JQt
         bbrV2bwQM1N/L3SQ/Dff4lXbwN1iNoaHBo8N8lWIRXvVH97z4q8NSbIDKKYvPKCak20/
         bVK+Iw1fpukkbuxF7iqEc9InCM7tXWUdXJK3IOGoRM8uiHNEtvyCjA14288k1fueaTF8
         HiIIgriCX9CiylwKzoAbTbJV0AmPO9riRpr0dkUCJrzQm96JGqAz0Hgz7YUmMZqmNC79
         8vhg==
X-Gm-Message-State: AOAM5329bxb7sUVTiM55fiqk/1lcPOauNaZ3tvImjuV/HUs3IyNSzh6C
        GOmOjT57bZUglOHHkgqRD2t4ag==
X-Google-Smtp-Source: ABdhPJx4wBfHeCAFCUmp0yatV/dNTxTk13j+TKULV+UoEXjSRE2imXzytwXf0obfYEDeYMKHwPEX9A==
X-Received: by 2002:a63:4764:: with SMTP id w36mr17732583pgk.127.1612203259415;
        Mon, 01 Feb 2021 10:14:19 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:18 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/31] coresight: etm4x: Detect system instructions support
Date:   Mon,  1 Feb 2021 11:13:44 -0700
Message-Id: <20210201181351.1475223-25-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

ETM v4.4 onwards adds support for system instruction access
to the ETM. Detect the support on an ETM and switch to using the
mode when available.

Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-23-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-core.c          | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 8d644e93de51..48d8e99e31eb 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -782,6 +782,37 @@ static const struct coresight_ops etm4_cs_ops = {
 	.source_ops	= &etm4_source_ops,
 };
 
+static inline bool cpu_supports_sysreg_trace(void)
+{
+	u64 dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
+
+	return ((dfr0 >> ID_AA64DFR0_TRACEVER_SHIFT) & 0xfUL) > 0;
+}
+
+static bool etm4_init_sysreg_access(struct etmv4_drvdata *drvdata,
+				    struct csdev_access *csa)
+{
+	u32 devarch;
+
+	if (!cpu_supports_sysreg_trace())
+		return false;
+
+	/*
+	 * ETMs implementing sysreg access must implement TRCDEVARCH.
+	 */
+	devarch = read_etm4x_sysreg_const_offset(TRCDEVARCH);
+	if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH)
+		return false;
+	*csa = (struct csdev_access) {
+		.io_mem	= false,
+		.read	= etm4x_sysreg_read,
+		.write	= etm4x_sysreg_write,
+	};
+
+	drvdata->arch = etm_devarch_to_arch(devarch);
+	return true;
+}
+
 static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
 				   struct csdev_access *csa)
 {
@@ -812,9 +843,17 @@ static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
 static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
 				   struct csdev_access *csa)
 {
+	/*
+	 * Always choose the memory mapped io, if there is
+	 * a memory map to prevent sysreg access on broken
+	 * systems.
+	 */
 	if (drvdata->base)
 		return etm4_init_iomem_access(drvdata, csa);
 
+	if (etm4_init_sysreg_access(drvdata, csa))
+		return true;
+
 	return false;
 }
 
-- 
2.25.1

