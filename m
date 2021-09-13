Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02552408733
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbhIMIla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:41:30 -0400
Received: from mail-bn7nam10on2056.outbound.protection.outlook.com ([40.107.92.56]:4033
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238081AbhIMIlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:41:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0APpOslpt+fKLl0vi6cFaotWEwj6eTiFCR4rGsgDnm46Thg0AZ7ru43XJzDLWQ2z70wZGpABWSLRdW48OP9AABZvjLStjAWX2wVsYyup8lP6LdR2lL9Gx1PALocLiKnwj3kmcczciWhzTvGxF7pDCjnFlf8tMo29n+JmLHsvLhnZ4fpWLXP8sgCgDhhvjZBWy4LTzJPO7im5d2srIyKUAXAEcebwGiMmIRxvp+D+D8uUBynAYmr0dSuLFUQ/oGp1mAts0A2JAoKSEcWRaRBc6gtgnc/SScMN2asbYifHWN+FoE45AWoiHj2EUio5T2rFtA+7RD/l33qQ7dke5z0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=67fCxD6E4dLZE1cpn6Vup1iRwBhE6IDC0CYLPSrUwN4=;
 b=Oo/0vhP2CgFm2le92Gxhx0clwE3ahtvOwx8/++WQzOGnrLGHsUWDwJhglNtuqfcx3dyaTokuBZNNtaOaI41IYUbuqrpf6cQSMvrdW3MGOYNscUS4GV/ee5l+8EgwD4KKdVwgs1rXcaOolFKgPDCMxCYRhFjD28XDAaD44NhtDQA+WX7TvkZFdnpti5UWdFpNV53C1qUBSHh3bUzbv92uQDECrSrrdDDk3ZjAF9Ohofyy+ynQjzEAwJJl/Q8+bEvEtGHbd2LyUXV/4sf6NMewr0mSxTzqSLNY38j9RM6TpcFOTmHOfRMOZT2dWq630rD+xASSw6ecLpjUdZ/QeLMNvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67fCxD6E4dLZE1cpn6Vup1iRwBhE6IDC0CYLPSrUwN4=;
 b=doPUrmKpHbF+TZqSnOXqXJGTDNtBfZTSHc0bVzYhHkjNgEddX/Z51IZIXR+oRwFtmmKOTTmcleTlFqkyE3BuFc7lg2v9h9c0xhl5RxpKGJAICadumsfPocizlRv4E0AsED34UU+CtHpEPWVWn3VNCLTa/NLr941o54l22rgBLr4=
Received: from BN8PR04CA0050.namprd04.prod.outlook.com (2603:10b6:408:d4::24)
 by PH0PR02MB8423.namprd02.prod.outlook.com (2603:10b6:510:dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 08:40:06 +0000
Received: from BN1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::58) by BN8PR04CA0050.outlook.office365.com
 (2603:10b6:408:d4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend
 Transport; Mon, 13 Sep 2021 08:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT004.mail.protection.outlook.com (10.13.2.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 08:40:06 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Sep 2021 01:40:04 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 13 Sep 2021 01:40:04 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [172.19.2.91] (port=36668 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ronak.jain@xilinx.com>)
        id 1mPhVU-000Cg1-69; Mon, 13 Sep 2021 01:40:04 -0700
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH v2 1/3] firmware: xilinx: Add support for runtime features
Date:   Mon, 13 Sep 2021 01:39:53 -0700
Message-ID: <20210913083955.27146-2-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210913083955.27146-1-ronak.jain@xilinx.com>
References: <20210913083955.27146-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8e44119-f5bf-4a96-90a9-08d9769216b0
X-MS-TrafficTypeDiagnostic: PH0PR02MB8423:
X-Microsoft-Antispam-PRVS: <PH0PR02MB8423062DECC593D14CD67324A4D99@PH0PR02MB8423.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:419;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oL1wSQgDIlXKnF0+4Il2Xv+5qfCtzZ/58nTG7ObyjWgkJGH6H1BHwLYM9/9DS8qnYsokXp5WAmUutwilYtNJrGT/tukvlEyTTdBcL/WjJPFuY7Y1VeuYN8pPId+FxcQ4kxUJz8IVqz51zXRzhuVNZoo2E5IASOI42TOuCwhNJvZZdqZ3o6caLD/27gxobiPzlueUlcA0TK1hoVX5cIjuteG2oi14EZDq4AYqe4MrBDDoXMNh8+KWwqyZANsq+XAHwojUeEqZl1AqWTEuwSGitTZSj9TllEralvL336c8ZNNuC+0xs161htAMAwUupdslKEeXUGI5oMturRrPgvUo4sNu0eiME2nk177os/tl6qFiTkv93D4jRfbLJrm9x5lv7m8QGHHx7FYv1Wv7IjOyuVraljgerrQBaJvvbDibH4J5sTjoxTqqkVdA0CjgVz8y2s5AYfftvvcdAuYwjNWUzPqUSI1++7objMR3df73/uUtZwgMTDH3/r8i6se7GGRTTHZ4Xy0TBBMmTObPnP843pBbNij0kzTOdpEPUFdkzWxylpj6TPI2LUrRHeWriIEmdzdoxhKxpLgdOxwlmmeOJrOOzfkcvw42SqgQqal3J1aJ6O/8KtS+qIddZJAxDWeGtPum2ASOR4Y4/9SYNey5WqeNIvylHSd6dKGBOo1Bdl9FzaSH7qo0vDj3pbIQuNIGu4Jv+7GAM1a8Gw8PtN3bbBQQmtJZX0bf7toCmiy0AXk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(376002)(136003)(36840700001)(46966006)(26005)(4326008)(426003)(336012)(186003)(2616005)(82310400003)(7696005)(5660300002)(356005)(44832011)(82740400003)(110136005)(36756003)(54906003)(36906005)(2906002)(7636003)(316002)(36860700001)(9786002)(107886003)(83380400001)(478600001)(8936002)(8676002)(70206006)(70586007)(6666004)(47076005)(1076003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 08:40:06.6129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e44119-f5bf-4a96-90a9-08d9769216b0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8423
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for runtime features by using an IOCTL call. The features
 can be enabled or disabled on the firmware as well as the features
 can be configured at runtime by querying IOCTL_SET_FEATURE_CONFIG id.
 Similarly, the user can get the configured values of features by
 querying IOCTL_GET_FEATURE_CONFIG id.

Here, the support is added for the over temperature and external
 watchdog features only.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
Changes in v2:
- Resolved merged conflict
- Update commit message
---
 drivers/firmware/xilinx/zynqmp.c     | 27 +++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 25 +++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index a3cadbaf3cba..875d13bc1a57 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1066,6 +1066,33 @@ int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
 				   0, 0, NULL);
 }
 
+/**
+ * zynqmp_pm_set_feature_config - PM call to request IOCTL for feature config
+ * @id:         The config ID of the feature to be configured
+ * @value:      The config value of the feature to be configured
+ *
+ * Return:      Returns 0 on success or error value on failure.
+ */
+int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_FEATURE_CONFIG,
+				   id, value, NULL);
+}
+
+/**
+ * zynqmp_pm_get_feature_config - PM call to get value of configured feature
+ * @id:         The config id of the feature to be queried
+ * @payload:    Returned value array
+ *
+ * Return:      Returns 0 on success or error value on failure.
+ */
+int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
+				 u32 *payload)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_FEATURE_CONFIG,
+				   id, 0, payload);
+}
+
 /**
  * struct zynqmp_pm_shutdown_scope - Struct for shutdown scope
  * @subtype:	Shutdown subtype
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 56b426fe020c..25308b9ad109 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -123,6 +123,9 @@ enum pm_ioctl_id {
 	IOCTL_READ_PGGS = 15,
 	/* Set healthy bit value */
 	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
+	/* Runtime feature configuration */
+	IOCTL_SET_FEATURE_CONFIG = 26,
+	IOCTL_GET_FEATURE_CONFIG = 27,
 };
 
 enum pm_query_id {
@@ -351,6 +354,14 @@ enum zynqmp_pm_shutdown_subtype {
 	ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM = 2,
 };
 
+enum pm_feature_config_id {
+	PM_FEATURE_INVALID = 0,
+	PM_FEATURE_OVERTEMP_STATUS = 1,
+	PM_FEATURE_OVERTEMP_VALUE = 2,
+	PM_FEATURE_EXTWDT_STATUS = 3,
+	PM_FEATURE_EXTWDT_VALUE = 4,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -416,6 +427,8 @@ int zynqmp_pm_pinctrl_get_config(const u32 pin, const u32 param,
 int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
 				 u32 value);
 int zynqmp_pm_load_pdi(const u32 src, const u64 address);
+int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
+int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -632,6 +645,18 @@ static inline int zynqmp_pm_load_pdi(const u32 src, const u64 address)
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_set_feature_config(enum pm_feature_config_id id,
+					       u32 value)
+{
+	return -ENODEV;
+}
+
+static inline int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
+					       u32 *payload)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.32.0.93.g670b81a

