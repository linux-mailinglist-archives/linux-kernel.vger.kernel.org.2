Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1133F3FFD82
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348953AbhICJxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:53:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37448 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232273AbhICJx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:53:28 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1425920304C;
        Fri,  3 Sep 2021 11:52:28 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CF280203044;
        Fri,  3 Sep 2021 11:52:27 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2906C183AC8B;
        Fri,  3 Sep 2021 17:52:26 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
Subject: [PATCH v3 1/4] remoteproc: imx_rproc: Move common structure to header file
Date:   Fri,  3 Sep 2021 17:29:34 +0800
Message-Id: <1630661377-31244-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630661377-31244-1-git-send-email-shengjiu.wang@nxp.com>
References: <1630661377-31244-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common structure imx_rproc_att, imx_rproc_method
and imx_rproc_dcfg to header file which can be shared with
imx_dsp_rproc driver.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 28 +------------------------
 drivers/remoteproc/imx_rproc.h | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 27 deletions(-)
 create mode 100644 drivers/remoteproc/imx_rproc.h

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index d88f76f5305e..b0da0130c3b6 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -19,6 +19,7 @@
 #include <linux/remoteproc.h>
 #include <linux/workqueue.h>
 
+#include "imx_rproc.h"
 #include "remoteproc_internal.h"
 
 #define IMX7D_SRC_SCR			0x0C
@@ -72,33 +73,6 @@ struct imx_rproc_mem {
 /* M4 own area. Can be mapped at probe */
 #define ATT_OWN		BIT(1)
 
-/* address translation table */
-struct imx_rproc_att {
-	u32 da;	/* device address (From Cortex M4 view)*/
-	u32 sa;	/* system bus address */
-	u32 size; /* size of reg range */
-	int flags;
-};
-
-/* Remote core start/stop method */
-enum imx_rproc_method {
-	IMX_RPROC_NONE,
-	/* Through syscon regmap */
-	IMX_RPROC_MMIO,
-	/* Through ARM SMCCC */
-	IMX_RPROC_SMC,
-};
-
-struct imx_rproc_dcfg {
-	u32				src_reg;
-	u32				src_mask;
-	u32				src_start;
-	u32				src_stop;
-	const struct imx_rproc_att	*att;
-	size_t				att_size;
-	enum imx_rproc_method		method;
-};
-
 struct imx_rproc {
 	struct device			*dev;
 	struct regmap			*regmap;
diff --git a/drivers/remoteproc/imx_rproc.h b/drivers/remoteproc/imx_rproc.h
new file mode 100644
index 000000000000..23d8e808d27f
--- /dev/null
+++ b/drivers/remoteproc/imx_rproc.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
+ * Copyright 2021 NXP
+ */
+
+#ifndef _IMX_RPROC_H
+#define _IMX_RPROC_H
+
+/* address translation table */
+struct imx_rproc_att {
+	u32 da;	/* device address (From Cortex M4 view)*/
+	u32 sa;	/* system bus address */
+	u32 size; /* size of reg range */
+	int flags;
+};
+
+/* Remote core start/stop method */
+enum imx_rproc_method {
+	IMX_RPROC_NONE,
+	/* Through syscon regmap */
+	IMX_RPROC_MMIO,
+	/* Through ARM SMCCC */
+	IMX_RPROC_SMC,
+};
+
+struct imx_rproc_dcfg {
+	u32				src_reg;
+	u32				src_mask;
+	u32				src_start;
+	u32				src_stop;
+	const struct imx_rproc_att	*att;
+	size_t				att_size;
+	enum imx_rproc_method		method;
+};
+
+#endif /* _IMX_RPROC_H */
-- 
2.17.1

