Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF1130AEEB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhBASRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbhBASPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:05 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2459AC061354
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:10 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l18so80950pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gZHHgMd2DF7eOHXrryvC3652lFec+KRo8i3F2jjRyIY=;
        b=h5/BT7ssV6f/lY/QPEpcBlU+EjYrFM1Ho90LRBm7jkh50+eeK2EaSapsH+ldy2GMFH
         dbTZZQsLrVZn21yNOsbx9OVcBFWnjfwg1GX9yVr3hYIry/wthOaUh93qn29tPo1Jn2xC
         mkysB2b0em36SKr8BnkyQ4zxdlavTiiqAnfYAg3EmJdsobHhEvuwWMxTKxDbo02JnuW0
         rO3Vuc4KUbtBAXMQzYWtumnxKCVx1yMPhy2UQcW4kYONf61lGxTpv0rK8H3b1RFGoQ4r
         RiZBoNGwh4WxG8kVhR0LdvF0fqGNNywEM8p+4f0HCzw6ahkhULRS26Y2s7CygXHHgt8q
         h17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gZHHgMd2DF7eOHXrryvC3652lFec+KRo8i3F2jjRyIY=;
        b=SM+TMfunzjZ4f94B2UQNstu9x6RlPZgZ4jrrhY2P8pdwWSYdiDMrkuzZzX9DPtbDrJ
         df6CswUUCqGpApF0HxUSd5At0TohOQxZVnDlDD1iR3ZsAF5jPtMdNVMvqSQNRujkJGxi
         CMp/T0CcuJiSvhsOnOtf1GdJIBapZZ8yuhVxi+ATCWdY7Y1L+rohAJZ6qOjKaAs2U73O
         nPNSVUaT8VOfriO59V/D3ATGivGrQZjiVfQCj30c2+qXS9c2FFliWNtl7ImduH7GUxCk
         Gz05DD+tv6wgoQVDSHpKNheTSmnvY24HmsedHf5mQ1eOqivjv8dta3goJHTuPl1qlM1F
         /e+w==
X-Gm-Message-State: AOAM5311Y+Ab/9D7a51eEBsXSbS8WQniks39KpCKM1NZkZ3eb/Kv9TKl
        biSSnUNXT/hllcqTplMzza1pdQ==
X-Google-Smtp-Source: ABdhPJy3K3xVS7WDAk9hnk2f/brxYo2shhJg6/nTZ3QySyctXmBChtK08y5vx/Ki1eCJ0Ga6m6O02A==
X-Received: by 2002:a17:90b:30d4:: with SMTP id hi20mr123401pjb.41.1612203249684;
        Mon, 01 Feb 2021 10:14:09 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:09 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/31] coresight: etm4x: Define DEVARCH register fields
Date:   Mon,  1 Feb 2021 11:13:35 -0700
Message-Id: <20210201181351.1475223-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Define the fields of the DEVARCH register for identifying
a component as an ETMv4.x unit. Going forward, we use the
DEVARCH register for the component identification, rather
than the TRCIDR3.

Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-14-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-core.c          |  4 +-
 drivers/hwtracing/coresight/coresight-etm4x.h | 42 +++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 37f90d380436..04ec13ae22d0 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1720,8 +1720,8 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 static struct amba_cs_uci_id uci_id_etm4[] = {
 	{
 		/*  ETMv4 UCI data */
-		.devarch	= 0x47704a13,
-		.devarch_mask	= 0xfff0ffff,
+		.devarch	= ETM_DEVARCH_ETMv4x_ARCH,
+		.devarch_mask	= ETM_DEVARCH_ID_MASK,
 		.devtype	= 0x00000013,
 	}
 };
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 193d2819afa7..fba3c02eea0b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -506,6 +506,48 @@
 					 ETM_MODE_EXCL_KERN | \
 					 ETM_MODE_EXCL_USER)
 
+/*
+ * TRCDEVARCH Bit field definitions
+ * Bits[31:21]	- ARCHITECT = Always Arm Ltd.
+ *                * Bits[31:28] = 0x4
+ *                * Bits[27:21] = 0b0111011
+ * Bit[20]	- PRESENT,  Indicates the presence of this register.
+ *
+ * Bit[19:16]	- REVISION, Revision of the architecture.
+ *
+ * Bit[15:0]	- ARCHID, Identifies this component as an ETM
+ *                * Bits[15:12] - architecture version of ETM
+ *                *             = 4 for ETMv4
+ *                * Bits[11:0] = 0xA13, architecture part number for ETM.
+ */
+#define ETM_DEVARCH_ARCHITECT_MASK		GENMASK(31, 21)
+#define ETM_DEVARCH_ARCHITECT_ARM		((0x4 << 28) | (0b0111011 << 21))
+#define ETM_DEVARCH_PRESENT			BIT(20)
+#define ETM_DEVARCH_REVISION_SHIFT		16
+#define ETM_DEVARCH_REVISION_MASK		GENMASK(19, 16)
+#define ETM_DEVARCH_REVISION(x)			\
+	(((x) & ETM_DEVARCH_REVISION_MASK) >> ETM_DEVARCH_REVISION_SHIFT)
+#define ETM_DEVARCH_ARCHID_MASK			GENMASK(15, 0)
+#define ETM_DEVARCH_ARCHID_ARCH_VER_SHIFT	12
+#define ETM_DEVARCH_ARCHID_ARCH_VER_MASK	GENMASK(15, 12)
+#define ETM_DEVARCH_ARCHID_ARCH_VER(x)		\
+	(((x) & ETM_DEVARCH_ARCHID_ARCH_VER_MASK) >> ETM_DEVARCH_ARCHID_ARCH_VER_SHIFT)
+
+#define ETM_DEVARCH_MAKE_ARCHID_ARCH_VER(ver)			\
+	(((ver) << ETM_DEVARCH_ARCHID_ARCH_VER_SHIFT) & ETM_DEVARCH_ARCHID_ARCH_VER_MASK)
+
+#define ETM_DEVARCH_ARCHID_ARCH_PART(x)		((x) & 0xfffUL)
+
+#define ETM_DEVARCH_MAKE_ARCHID(major)			\
+	((ETM_DEVARCH_MAKE_ARCHID_ARCH_VER(major)) | ETM_DEVARCH_ARCHID_ARCH_PART(0xA13))
+
+#define ETM_DEVARCH_ARCHID_ETMv4x		ETM_DEVARCH_MAKE_ARCHID(0x4)
+
+#define ETM_DEVARCH_ID_MASK						\
+	(ETM_DEVARCH_ARCHITECT_MASK | ETM_DEVARCH_ARCHID_MASK | ETM_DEVARCH_PRESENT)
+#define ETM_DEVARCH_ETMv4x_ARCH						\
+	(ETM_DEVARCH_ARCHITECT_ARM | ETM_DEVARCH_ARCHID_ETMv4x | ETM_DEVARCH_PRESENT)
+
 #define TRCSTATR_IDLE_BIT		0
 #define TRCSTATR_PMSTABLE_BIT		1
 #define ETM_DEFAULT_ADDR_COMP		0
-- 
2.25.1

