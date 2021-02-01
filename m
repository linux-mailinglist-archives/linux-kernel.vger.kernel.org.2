Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318DB30AF58
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhBASbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhBASPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:21 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36163C061353
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:09 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o16so12626526pgg.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ex6Az5IYLj6cR6ue6WRS2UBP68zfl2Dt28cPPgU4zxE=;
        b=n/TPBFoXW/jBQamWy7UtyG/wcdV85ayugtTfFZSaTpR39cXEzsUJpb1UVjoCzF+Mop
         C2NPOWTr5+ROcBURQz13SBL9iRp6sqG1YNhx0OKliBCUxB11q4+siEivyPAR6NCVIB8D
         5H3Ea8zUH0MKYGoVyFQjz/czzrg6qjF42O/50MRDr1bewOKaD3/53N2RIdULNb28w36+
         tBOGIKP+BRCG/GHeBI1KMk8/ieQlXgi8Ic2Kq+hZh9ajjCpJre5ChQq8oYXmgYMVDaiw
         m54Dbh6XH6lslwh4x6ADBFbsE1xb/fZNA71hrYbKwTw8xKphyXEPPwRW9ELAtRiV68nF
         gu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ex6Az5IYLj6cR6ue6WRS2UBP68zfl2Dt28cPPgU4zxE=;
        b=asQv6bT5ZAh2+v+TV6wTabd6XjZAAdorbSRbvg0U95v/FVhouqGytcUENkwiTAyG2d
         Gs9eWNuOKRS74STV6K94GeMVJM3q+lS+zByXzEQaYK+TZ3iNyP5Bh+2yeMCRIWcVZzon
         +HrkcAcTZVIDNCt4/0SzM6WBUnKU8GCDKs5CbZa3U7SDNH89V3YKMTj+IwjpO0/Bp1Ty
         a4o+rbM3xSo0kmeeLYoN+VK9iqHxI7cC3qSvbfSS1IsCmpA0Cjes6u0nsydVqpCOtIHr
         IMvX8HBe6CUwL+Y0Jm6buNp6BZFsokzpJDZFBrbnMtN4POj2y/XR1A1wyNmFvfV2mLoO
         7vew==
X-Gm-Message-State: AOAM531/fhNAn9fiwKG0PmEtpMcm9b3y7XJ64QB/0jnTdahb+/lyxcEZ
        Rm24QVf/IdRCMB+4O1BfvandtNRp3R6Hnw==
X-Google-Smtp-Source: ABdhPJz4XfjLbEDIofu1JNEkj23kXX3CQ51umXIfXzgj2BSk8EVTG40xfhiYo9nDcayx2gp01Pc8tw==
X-Received: by 2002:a63:4e63:: with SMTP id o35mr17700966pgl.291.1612203248787;
        Mon, 01 Feb 2021 10:14:08 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:08 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/31] coresight: etm4x: Hide sysfs attributes for unavailable registers
Date:   Mon,  1 Feb 2021 11:13:34 -0700
Message-Id: <20210201181351.1475223-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Some of the management registers in ETMv4.x are not accessible
via system register instructions. Thus we must hide the sysfs
files exposing them to the userspace, to prevent system crashes.

This patch adds an is_visible() routine to control the visibility
at runtime for the registers that may not be accessed.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-13-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-sysfs.c         | 51 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm4x.h |  6 +++
 2 files changed, 57 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index ddbfeb24fc3f..e8fdda45ffca 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2370,6 +2370,56 @@ static ssize_t coresight_etm4x_reg_show(struct device *dev,
 	return scnprintf(buf, PAGE_SIZE, "0x%x\n", val);
 }
 
+static inline bool
+etm4x_register_implemented(struct etmv4_drvdata *drvdata, u32 offset)
+{
+	switch (offset) {
+	ETM4x_SYSREG_LIST_CASES
+		/*
+		 * Registers accessible via system instructions are always
+		 * implemented.
+		 */
+		return true;
+	ETM4x_MMAP_LIST_CASES
+		/*
+		 * Registers accessible only via memory-mapped registers
+		 * must not be accessed via system instructions.
+		 * We cannot access the drvdata->csdev here, as this
+		 * function is called during the device creation, via
+		 * coresight_register() and the csdev is not initialized
+		 * until that is done. So rely on the drvdata->base to
+		 * detect if we have a memory mapped access.
+		 */
+		return !!drvdata->base;
+	}
+
+	return false;
+}
+
+/*
+ * Hide the ETM4x registers that may not be available on the
+ * hardware.
+ * There are certain management registers unavailable via system
+ * instructions. Make those sysfs attributes hidden on such
+ * systems.
+ */
+static umode_t
+coresight_etm4x_attr_reg_implemented(struct kobject *kobj,
+				     struct attribute *attr, int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct device_attribute *d_attr;
+	u32 offset;
+
+	d_attr = container_of(attr, struct device_attribute, attr);
+	offset = coresight_etm4x_attr_to_offset(d_attr);
+
+	if (etm4x_register_implemented(drvdata, offset))
+		return attr->mode;
+	return 0;
+}
+
 #define coresight_etm4x_reg(name, offset)				\
 	&((struct dev_ext_attribute[]) {				\
 	   {								\
@@ -2417,6 +2467,7 @@ static const struct attribute_group coresight_etmv4_group = {
 };
 
 static const struct attribute_group coresight_etmv4_mgmt_group = {
+	.is_visible = coresight_etm4x_attr_reg_implemented,
 	.attrs = coresight_etmv4_mgmt_attrs,
 	.name = "mgmt",
 };
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 24ba0da5b096..193d2819afa7 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -157,6 +157,9 @@
 #define CASE_WRITE(val, x)					\
 	case (x): { write_etm4x_sysreg_const_offset((val), (x)); break; }
 
+#define CASE_NOP(__unused, x)					\
+	case (x):	/* fall through */
+
 /* List of registers accessible via System instructions */
 #define ETM_SYSREG_LIST(op, val)		\
 	CASE_##op((val), TRCPRGCTLR)		\
@@ -369,6 +372,9 @@
 #define ETM4x_READ_SYSREG_CASES(res)	ETM_SYSREG_LIST(READ, (res))
 #define ETM4x_WRITE_SYSREG_CASES(val)	ETM_SYSREG_LIST(WRITE, (val))
 
+#define ETM4x_SYSREG_LIST_CASES		ETM_SYSREG_LIST(NOP, __unused)
+#define ETM4x_MMAP_LIST_CASES		ETM_MMAP_LIST(NOP, __unused)
+
 #define read_etm4x_sysreg_offset(offset, _64bit)				\
 	({									\
 		u64 __val;							\
-- 
2.25.1

