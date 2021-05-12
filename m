Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB89337B3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 04:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhELCCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 22:02:33 -0400
Received: from mail-bn8nam11on2083.outbound.protection.outlook.com ([40.107.236.83]:26080
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230388AbhELCCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 22:02:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDJsbWm6wlFUd3Rdkc2qJ4EeZUNiEsDEDclhTnaXTtJ6CvY8mqGjzbuahxIKDHoRBe4rxsdvLA1JVxCETeX++d0cN8MW+SLWtULaHxFshHZbVmJxnu5Jtt9nub7JvKDBH4aDTywPtSJS8BdylroGozgJc6P6LgAHue1N7M8/Jdch8yLRalmqVRtb+5QBnmfnzq8q/A7br+2hVaCXeB6JKt6wVSepDhzFe9c+QQsx9kj24V0GqbRED41PF/AexHFxhfiVumS3i2Ez/bGhZCANj6yQI1uttq1B5gon6+Fwu6WbLtD7rgXrayUAHStnQC5muGlXVaejzfff8t/wmtVrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwGScXAKq1YCjyZe/LJC51PdA34ZIXAEmS7y0o7dfMs=;
 b=DVnVJmZTm5qCaPJW2CpVOTHy2Ydkw3n0Fsg4RJh7MAoF3FpQcb0OnKMff8x7FypNOBsgUpmvTsBSrFwF6tCF1AtBha8WtjT/U/yITuQLVhoeWaIXUOJBf5+0NnnesSS9pa/JlBuwpuFyrOwrbN8QHZDJ5uAU6a7lkxjyrSzhu5PYDIQ3GxQJ1XAMpZMSl6UBeikgaWtE79TDlZITw1yCon9AQfCmu/qEdROt5HAHnKdJjeSqXepA1Mj3NrzwWWEphqduefRp2QYPOEFSr4Fpiat8R/sjmzpuYALRJUYSX2my5XcLM1vN6qjE79z5QlEb7lD6m6XtlnCDIKhC/wLNtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwGScXAKq1YCjyZe/LJC51PdA34ZIXAEmS7y0o7dfMs=;
 b=pg6moR9plHraclRcN6JT0Zl/QzydmD5hC7yMo8lKFuYUqgcy/xzYof1992RG8gIZv6DPQTezDX8mgzVTY3Qfvj/GKp4xWJ++6EuD97rlcXw52oviCHSb5LQBxTx3F4cxPzIbp6Wnb1F+nabcBMuexiMKwSAF5DCD/M8KiDJO50k=
Received: from DM5PR21CA0014.namprd21.prod.outlook.com (2603:10b6:3:ac::24) by
 BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.29; Wed, 12 May 2021 02:01:20 +0000
Received: from DM3NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::3) by DM5PR21CA0014.outlook.office365.com
 (2603:10b6:3:ac::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.0 via Frontend
 Transport; Wed, 12 May 2021 02:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT023.mail.protection.outlook.com (10.13.5.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 12 May 2021 02:01:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 19:00:56 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 11 May 2021 19:00:56 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=35748 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lgeBE-0002Ju-R6; Tue, 11 May 2021 19:00:56 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 09F84600135; Tue, 11 May 2021 18:53:46 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V6 XRT Alveo 18/20] fpga: xrt: DDR calibration driver
Date:   Tue, 11 May 2021 18:53:37 -0700
Message-ID: <20210512015339.5649-19-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512015339.5649-1-lizhi.hou@xilinx.com>
References: <20210512015339.5649-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01db50a0-4609-4549-6ae6-08d914e9d648
X-MS-TrafficTypeDiagnostic: BYAPR02MB4886:
X-Microsoft-Antispam-PRVS: <BYAPR02MB48861648A52EAE5A809AFDA4A1529@BYAPR02MB4886.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kepnUP814vH2+Ukt6WeuJN9COuT2fwvmcKercsw+2LM2l+i3rlTLynFXTQL7n8GHsO6TlVGJxBvujYMcBv9ep0ryOsCMfLD7W5vSaGysLj+ZynZrSn3KUKbY6amHntdS2n1le7kCoyMPw6tb0IgKpJPmtXx56TJbmQIShqa0rKPg73IoJj9IpZVcT0pTXbBuFLRfOqjQkOOUBOn//plClgErkywpGPsf0V/SWDgsCU97Y7Kxn3IJlZgxqPfPOI+JxzsV2Wdma7RYM9OwHV+CsK7zxGto0fAEhUElUeKX2Nfvq4aJwJaLsPIc24LQM08gxg+4QxTk153eghQ/t7Ppyu1G8G2jzY9auiSirmZfMLGPHj77IAiKn7r35kuC3+dNCO+qjKJW20GQVOtgdEfs7vAksl0tHfz+CfVA/5Fjwafe/VRwNbEXoM8CnzsVetz1K0ADs2c3S6PQoKLUkbPpwgvWxNQxhA8f3+BvRNhYJGSohPYZenI4Vrq5a8EJMfI0/WlImKikRfwn2OGdbyHK4rUvPM/f2rVbIyqoJUj5zbpnCCS3mXmOcKAxvbTi78y7akoJWJkmsye8augOTAxcd0S273uS194JbeGGpYUuHhSXsc1n57Sm10wozcPM8uzQis/PMne4kthkvSw1Q4KGgTIxSoB83bwHteyegXES8OY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39850400004)(396003)(46966006)(36840700001)(2616005)(426003)(6916009)(336012)(54906003)(44832011)(316002)(36756003)(70586007)(1076003)(107886003)(70206006)(356005)(186003)(5660300002)(6266002)(82740400003)(4326008)(42186006)(7636003)(2906002)(36906005)(6666004)(8676002)(26005)(8936002)(478600001)(47076005)(82310400003)(36860700001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 02:01:20.3741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01db50a0-4609-4549-6ae6-08d914e9d648
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT023.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4886
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DDR calibration driver. DDR calibration is a hardware function
discovered by walking firmware metadata. A xrt device node will
be created for it. Hardware provides DDR calibration status through
this function.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 .../fpga/xrt/include/xleaf/ddr_calibration.h  |  28 +++
 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c  | 210 ++++++++++++++++++
 2 files changed, 238 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xleaf/ddr_calibration.h
 create mode 100644 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c

diff --git a/drivers/fpga/xrt/include/xleaf/ddr_calibration.h b/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
new file mode 100644
index 000000000000..878740c26ca2
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XRT_DDR_CALIBRATION_H_
+#define _XRT_DDR_CALIBRATION_H_
+
+#include "xleaf.h"
+#include <linux/xrt/xclbin.h>
+
+/*
+ * Memory calibration driver leaf calls.
+ */
+enum xrt_calib_results {
+	XRT_CALIB_UNKNOWN = 0,
+	XRT_CALIB_SUCCEEDED,
+	XRT_CALIB_FAILED,
+};
+
+enum xrt_calib_leaf_cmd {
+	XRT_CALIB_RESULT = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+};
+
+#endif	/* _XRT_DDR_CALIBRATION_H_ */
diff --git a/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c b/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
new file mode 100644
index 000000000000..36a0937c9195
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA memory calibration driver
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * memory calibration
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include "xclbin-helper.h"
+#include "metadata.h"
+#include "xleaf/ddr_calibration.h"
+
+#define XRT_CALIB	"xrt_calib"
+
+#define XRT_CALIB_STATUS_REG		0
+#define XRT_CALIB_READ_RETRIES		20
+#define XRT_CALIB_READ_INTERVAL		500 /* ms */
+
+XRT_DEFINE_REGMAP_CONFIG(calib_regmap_config);
+
+struct calib_cache {
+	struct list_head	link;
+	const char		*ep_name;
+	char			*data;
+	u32			data_size;
+};
+
+struct calib {
+	struct xrt_device	*xdev;
+	struct regmap		*regmap;
+	struct mutex		lock; /* calibration dev lock */
+	struct list_head	cache_list;
+	u32			cache_num;
+	enum xrt_calib_results	result;
+};
+
+static void __calib_cache_clean_nolock(struct calib *calib)
+{
+	struct calib_cache *cache, *temp;
+
+	list_for_each_entry_safe(cache, temp, &calib->cache_list, link) {
+		vfree(cache->data);
+		list_del(&cache->link);
+		vfree(cache);
+	}
+	calib->cache_num = 0;
+}
+
+static void calib_cache_clean(struct calib *calib)
+{
+	mutex_lock(&calib->lock);
+	__calib_cache_clean_nolock(calib);
+	mutex_unlock(&calib->lock);
+}
+
+static int calib_calibration(struct calib *calib)
+{
+	u32 times = XRT_CALIB_READ_RETRIES;
+	u32 status;
+	int ret;
+
+	while (times != 0) {
+		ret = regmap_read(calib->regmap, XRT_CALIB_STATUS_REG, &status);
+		if (ret) {
+			xrt_err(calib->xdev, "failed to read status reg %d", ret);
+			return ret;
+		}
+
+		if (status & BIT(0))
+			break;
+		msleep(XRT_CALIB_READ_INTERVAL);
+		times--;
+	}
+
+	if (!times) {
+		xrt_err(calib->xdev,
+			"MIG calibration timeout after bitstream download");
+		return -ETIMEDOUT;
+	}
+
+	xrt_info(calib->xdev, "took %dms", (XRT_CALIB_READ_RETRIES - times) *
+		 XRT_CALIB_READ_INTERVAL);
+	return 0;
+}
+
+static void xrt_calib_event_cb(struct xrt_device *xdev, void *arg)
+{
+	struct calib *calib = xrt_get_drvdata(xdev);
+	struct xrt_event *evt = (struct xrt_event *)arg;
+	enum xrt_events e = evt->xe_evt;
+	enum xrt_subdev_id id;
+	int ret;
+
+	id = evt->xe_subdev.xevt_subdev_id;
+
+	switch (e) {
+	case XRT_EVENT_POST_CREATION:
+		if (id == XRT_SUBDEV_UCS) {
+			ret = calib_calibration(calib);
+			if (ret)
+				calib->result = XRT_CALIB_FAILED;
+			else
+				calib->result = XRT_CALIB_SUCCEEDED;
+		}
+		break;
+	default:
+		xrt_dbg(xdev, "ignored event %d", e);
+		break;
+	}
+}
+
+static void xrt_calib_remove(struct xrt_device *xdev)
+{
+	struct calib *calib = xrt_get_drvdata(xdev);
+
+	calib_cache_clean(calib);
+}
+
+static int xrt_calib_probe(struct xrt_device *xdev)
+{
+	void __iomem *base = NULL;
+	struct resource *res;
+	struct calib *calib;
+	int err = 0;
+
+	calib = devm_kzalloc(&xdev->dev, sizeof(*calib), GFP_KERNEL);
+	if (!calib)
+		return -ENOMEM;
+
+	calib->xdev = xdev;
+	xrt_set_drvdata(xdev, calib);
+
+	res = xrt_get_resource(xdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		err = -EINVAL;
+		goto failed;
+	}
+
+	base = devm_ioremap_resource(&xdev->dev, res);
+	if (IS_ERR(base)) {
+		err = PTR_ERR(base);
+		goto failed;
+	}
+
+	calib->regmap = devm_regmap_init_mmio(&xdev->dev, base, &calib_regmap_config);
+	if (IS_ERR(calib->regmap)) {
+		xrt_err(xdev, "Map iomem failed");
+		err = PTR_ERR(calib->regmap);
+		goto failed;
+	}
+
+	mutex_init(&calib->lock);
+	INIT_LIST_HEAD(&calib->cache_list);
+
+	return 0;
+
+failed:
+	return err;
+}
+
+static int
+xrt_calib_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
+{
+	struct calib *calib = xrt_get_drvdata(xdev);
+	int ret = 0;
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		xrt_calib_event_cb(xdev, arg);
+		break;
+	case XRT_CALIB_RESULT: {
+		enum xrt_calib_results *r = (enum xrt_calib_results *)arg;
+		*r = calib->result;
+		break;
+	}
+	default:
+		xrt_err(xdev, "unsupported cmd %d", cmd);
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static struct xrt_dev_endpoints xrt_calib_endpoints[] = {
+	{
+		.xse_names = (struct xrt_dev_ep_names[]) {
+			{ .ep_name = XRT_MD_NODE_DDR_CALIB },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_driver xrt_calib_driver = {
+	.driver = {
+		.name = XRT_CALIB,
+	},
+	.subdev_id = XRT_SUBDEV_CALIB,
+	.endpoints = xrt_calib_endpoints,
+	.probe = xrt_calib_probe,
+	.remove = xrt_calib_remove,
+	.leaf_call = xrt_calib_leaf_call,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(calib);
-- 
2.27.0

