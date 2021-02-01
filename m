Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD1F30AFA3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhBASmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbhBASPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:12 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8292FC06121C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:14 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id e19so12129992pfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMKTiBBzzA6qqd/h2MGcj7qPjB9ZbPsUF9hLa2otpO8=;
        b=mr3uuV5hq02GXn/RPIeayLViAvbTjtyxGnZZ/uAvii+zw7bOaztYkzXjVLHUAp2JmA
         queFWoAtMlomRlZdDFh1RMeYdgSgf/iv7fY2tZx7Pmb9GYW16+ErcAkk3JklVKKlYXsM
         tcJtp+YGuxPYtwYHgU8IlmtrAo5hSGZ2puppL43mtLUKI6VbM4Sf5InRyuJWqB76rWR2
         EZvlTMuFrPgSrvn+hux3V13Heug9PG9U6Xl4pmf+MFm7qp3T8PMUYjBZVhJfX2yQPlPz
         rWvDDQyxo4U5MvxbpBREmEwVSonuiNKapJVByaPZ8BkdqDpOcoB8gGw7fDyq3V+L4Z3C
         8frQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMKTiBBzzA6qqd/h2MGcj7qPjB9ZbPsUF9hLa2otpO8=;
        b=B7EpvXJCBT5pt/UgqL1x1uWZPtbbI0FQyDm/rxxUgV5DrIHBeHquwIkzukEaFpELC+
         jkObgECuqq3AnMogopkTMdv6ITq9BfZSjrYNYMXv6jUD1q4kK5tth3IGWYbxi63FVNWw
         Hlt4HWTeKQTtdSZHZMSgUbmVx18NMUvqgxXNpkk06+nXOVwj914MtckDJQmF0zNvf48X
         hKG6iyxOr4mYGSxBrHLBhsmWX0AnvrvvVc06ggDiWBWo2ASXeQxuY1qLMMtWG024la3u
         MD2CGAhpV3luAo3WBWLID1n/HQE9ukFQRAT2rYzTItlj0O70kbVzvX1+uwxeJgoZGQ/h
         8/Cw==
X-Gm-Message-State: AOAM530O+O9srNGIwp/tjkzUpMHtzq5TrsA2PXXqF4A7CsyDFRIazL2d
        2swG1NiMaQp5yFs+u/Q7fAZKaP0Mzkr3yQ==
X-Google-Smtp-Source: ABdhPJwOPo5tfyma8mXYuGivv4WlttJYWqemAQYnXdNmqQkNL/cR6iuq+N+XVj6NW833ivuaSD6rCA==
X-Received: by 2002:a62:75c1:0:b029:1b6:b71a:a369 with SMTP id q184-20020a6275c10000b02901b6b71aa369mr17568835pfc.27.1612203254038;
        Mon, 01 Feb 2021 10:14:14 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:13 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/31] coresight: etm4x: Handle ETM architecture version
Date:   Mon,  1 Feb 2021 11:13:39 -0700
Message-Id: <20210201181351.1475223-20-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

We are about to rely on TRCDEVARCH for detecting the ETM
and its architecture version, falling back to TRCIDR1 if
the former is not implemented (in older broken implementations).

Also, we use the architecture version information to
make some decisions. Streamline the architecture version
handling by adding helpers.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-18-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-core.c          |  2 +-
 drivers/hwtracing/coresight/coresight-etm4x.h | 60 ++++++++++++++++++-
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index c9fcb17968a0..59da9efae9c2 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -917,7 +917,7 @@ static void etm4_init_arch_data(void *info)
 	 * Otherwise for values 0x1 and above the number is N + 1 as per v4.2.
 	 */
 	drvdata->nr_resource = BMVAL(etmidr4, 16, 19);
-	if ((drvdata->arch < ETM4X_ARCH_4V3) || (drvdata->nr_resource > 0))
+	if ((drvdata->arch < ETM_ARCH_V4_3) || (drvdata->nr_resource > 0))
 		drvdata->nr_resource += 1;
 	/*
 	 * NUMSSCC, bits[23:20] the number of single-shot
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 91b82002e260..0af60571aa23 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -468,7 +468,6 @@
 #define ETM_MAX_RES_SEL			32
 #define ETM_MAX_SS_CMP			8
 
-#define ETM_ARCH_V4			0x40
 #define ETMv4_SYNC_MASK			0x1F
 #define ETM_CYC_THRESHOLD_MASK		0xFFF
 #define ETM_CYC_THRESHOLD_DEFAULT       0x100
@@ -593,8 +592,63 @@
 #define TRCVICTLR_EXLEVEL_S_MASK	(ETM_EXLEVEL_S_MASK << TRCVICTLR_EXLEVEL_SHIFT)
 #define TRCVICTLR_EXLEVEL_NS_MASK	(ETM_EXLEVEL_NS_MASK << TRCVICTLR_EXLEVEL_SHIFT)
 
+#define ETM_TRCIDR1_ARCH_MAJOR_SHIFT	8
+#define ETM_TRCIDR1_ARCH_MAJOR_MASK	(0xfU << ETM_TRCIDR1_ARCH_MAJOR_SHIFT)
+#define ETM_TRCIDR1_ARCH_MAJOR(x)	\
+	(((x) & ETM_TRCIDR1_ARCH_MAJOR_MASK) >> ETM_TRCIDR1_ARCH_MAJOR_SHIFT)
+#define ETM_TRCIDR1_ARCH_MINOR_SHIFT	4
+#define ETM_TRCIDR1_ARCH_MINOR_MASK	(0xfU << ETM_TRCIDR1_ARCH_MINOR_SHIFT)
+#define ETM_TRCIDR1_ARCH_MINOR(x)	\
+	(((x) & ETM_TRCIDR1_ARCH_MINOR_MASK) >> ETM_TRCIDR1_ARCH_MINOR_SHIFT)
+#define ETM_TRCIDR1_ARCH_SHIFT		ETM_TRCIDR1_ARCH_MINOR_SHIFT
+#define ETM_TRCIDR1_ARCH_MASK		\
+	(ETM_TRCIDR1_ARCH_MAJOR_MASK | ETM_TRCIDR1_ARCH_MINOR_MASK)
+
+#define ETM_TRCIDR1_ARCH_ETMv4		0x4
+
+/*
+ * Driver representation of the ETM architecture.
+ * The version of an ETM component can be detected from
+ *
+ * TRCDEVARCH	- CoreSight architected register
+ *                - Bits[15:12] - Major version
+ *                - Bits[19:16] - Minor version
+ * TRCIDR1	- ETM architected register
+ *                - Bits[11:8] - Major version
+ *                - Bits[7:4]  - Minor version
+ * We must rely on TRCDEVARCH for the version information,
+ * however we don't want to break the support for potential
+ * old implementations which might not implement it. Thus
+ * we fall back to TRCIDR1 if TRCDEVARCH is not implemented
+ * for memory mapped components.
+ * Now to make certain decisions easier based on the version
+ * we use an internal representation of the version in the
+ * driver, as follows :
+ *
+ * ETM_ARCH_VERSION[7:0], where :
+ *      Bits[7:4] - Major version
+ *      Bits[3:0] - Minro version
+ */
+#define ETM_ARCH_VERSION(major, minor)		\
+	((((major) & 0xfU) << 4) | (((minor) & 0xfU)))
+#define ETM_ARCH_MAJOR_VERSION(arch)	(((arch) >> 4) & 0xfU)
+#define ETM_ARCH_MINOR_VERSION(arch)	((arch) & 0xfU)
+
+#define ETM_ARCH_V4	ETM_ARCH_VERSION(4, 0)
 /* Interpretation of resource numbers change at ETM v4.3 architecture */
-#define ETM4X_ARCH_4V3	0x43
+#define ETM_ARCH_V4_3	ETM_ARCH_VERSION(4, 3)
+
+static inline u8 etm_devarch_to_arch(u32 devarch)
+{
+	return ETM_ARCH_VERSION(ETM_DEVARCH_ARCHID_ARCH_VER(devarch),
+				ETM_DEVARCH_REVISION(devarch));
+}
+
+static inline u8 etm_trcidr_to_arch(u32 trcidr1)
+{
+	return ETM_ARCH_VERSION(ETM_TRCIDR1_ARCH_MAJOR(trcidr1),
+				ETM_TRCIDR1_ARCH_MINOR(trcidr1));
+}
 
 enum etm_impdef_type {
 	ETM4_IMPDEF_HISI_CORE_COMMIT,
@@ -761,7 +815,7 @@ struct etmv4_save_state {
  * @spinlock:   Only one at a time pls.
  * @mode:	This tracer's mode, i.e sysFS, Perf or disabled.
  * @cpu:        The cpu this component is affined to.
- * @arch:       ETM version number.
+ * @arch:       ETM architecture version.
  * @nr_pe:	The number of processing entity available for tracing.
  * @nr_pe_cmp:	The number of processing entity comparator inputs that are
  *		available for tracing.
-- 
2.25.1

