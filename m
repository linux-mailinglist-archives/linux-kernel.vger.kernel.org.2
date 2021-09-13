Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0012A408736
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbhIMIlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:41:49 -0400
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com ([40.107.237.84]:1152
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238209AbhIMIlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:41:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QONqvvvYz3L60VtzVMcKccmxVkRMkHCJaezrSv86I6URntaVPXCxWvESOH0daM8MnUAjDCt1DZ70nLTNpnDSohl5Mnca5e+C38na26oISzZnuCfhOQNtqGo5wqBlHDkHgjnYcmCwemM/Gq13ti9B0CJvHVB5Ybmrgh5Ai2cIe7buxAhYo3S4XKtFTLDWhehFzTlW9Srrag6q5wEwf1R9THyYbXd5p/8DHsMT58jMhrIYwcbJBXw5TLdKrR4iJDNnvsLCESB0c6+Ol+vgnn6VymtcIvDccsqTNfHra862ecZX73y0OfeMlXvwz/l4uadYApPV+4qJxxpNeRa8grHCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lX4xB8WN3Dnc9QqYHqtWediTQWVLXAjsmkpEYi1+08o=;
 b=ndhZbK6KEHCtvK0qtcxjB1koxImSu+vtD6/TJYtTx5gqOU6k9z0nf/vJbxqOc5wsoKOgXExnAWkV0FcyUuMIILBjiu5wsqXJi2eTsvuEtvFPmAbS5ZEwNFLMXjJmbBg32I7Sx3VVGRxzdu6RYCGHrbxdIgHn77gJ/VC8oSLYsLXiDQn15hFVt80GOhPi8ep7Hn3R47Fr2Bn5jZPqTlRFr0NuUIMjrd1CxO1+G0C7lsZUzrfehFN1vH47yT8PEF7Jldm2URj6utyucrJJpr90/RsrlKV3pu4ZyXdcedmWATNMfeSePd9Gh+3z0B3xNoBL9h+kz+5Ooptff79mOXH8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX4xB8WN3Dnc9QqYHqtWediTQWVLXAjsmkpEYi1+08o=;
 b=DGwSAQGrJjn0F/q+M3HdvEvbPklJALdBvdfjE2JbzWwk05N5TMBtgFn52OljRCWL8Zjd2YbuKRB2L8Sh0FIFDDhGu1+GalO/AJdJTtrc0/3w/dZdzrVm2aBP172687k23SyMgXUPluQ4pcuXRsE4DVPpQWVi9tOQr8CITwniUMo=
Received: from BN9PR03CA0088.namprd03.prod.outlook.com (2603:10b6:408:fc::33)
 by MW4PR02MB7187.namprd02.prod.outlook.com (2603:10b6:303:78::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 08:40:27 +0000
Received: from BN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::2) by BN9PR03CA0088.outlook.office365.com
 (2603:10b6:408:fc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend
 Transport; Mon, 13 Sep 2021 08:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT062.mail.protection.outlook.com (10.13.2.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 08:40:27 +0000
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
        id 1mPhVU-000Cg1-E3; Mon, 13 Sep 2021 01:40:04 -0700
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH v2 3/3] firmware: xilinx: Add sysfs support for feature config
Date:   Mon, 13 Sep 2021 01:39:55 -0700
Message-ID: <20210913083955.27146-4-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210913083955.27146-1-ronak.jain@xilinx.com>
References: <20210913083955.27146-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c0651cd-47de-4327-882c-08d9769222f4
X-MS-TrafficTypeDiagnostic: MW4PR02MB7187:
X-Microsoft-Antispam-PRVS: <MW4PR02MB7187FAC8004C0C7BEBCAB508A4D99@MW4PR02MB7187.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0eGSDn+ZC7ZIzqNwt4IfZjn1K8OVAdrldHGi+MEkYRqKYkswEazK5vRfhAGqSD/IWMPVaE4diovrYhAPw6/6bJzDaTiNHctd49vc9y4yGJUdh3uhxKXTagThNvFcgco5pXM9lnyg6+VJ9flmAKnUySzG5bM7fyRTeKOI80P+MsEXzqI8Fp9JcIC4/bKbZNw7clCmtOrGdsTNqrOqk3lqxlgzqJba4x7V3LDH8XmLBpi9adfRdw2enFF6fXGYUTJNl4e1NZuBLu593ANFjzKFAAU4DlSAJFlxu3hh3RC5EOaOLEeTgOoQ8i3YzVGkm9jFDiYvarthqz75rY2ZRp42zgYW1sdkdSD0wdeVY6N7dtBfYYMyOf3eZlvRu4YTGZASq3u9yzrUxFojpXvf+90tLx651cMhc91pDNXMJYJTtVLlz/U5FBtqJ7FHbEetZFnsvIIK2LISbFOa+FWXmUQi4ekW9lXJUZMojkJsN059SVq0e8DKSup6vtUSCktN2/bl9jf65gSx3+3OSoOSqdGnJ3UOpr5hfkZ/OngYeCFabGntEJjMVdPWb/dkGBm6PISHOWnXFFTfFE4MM1cgkS6Gu6MQCKZVtBZ7ptrw+tiqDtCIrksZFBt1ubFlGWcM7VCtavRzn63a0jTM53o5rEDl5lErYTDInp33gXDlf40wGQbPobIlQsb3Yd53GsgvJmCvVey0B/E/6pfTsy2EJMDg+N+Z3o2R4+WFu0aWhn96lM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36756003)(4326008)(26005)(6666004)(8936002)(426003)(8676002)(5660300002)(186003)(9786002)(356005)(7636003)(44832011)(36906005)(107886003)(54906003)(83380400001)(1076003)(2906002)(70206006)(336012)(47076005)(508600001)(110136005)(7696005)(36860700001)(70586007)(2616005)(82310400003)(316002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 08:40:27.2070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0651cd-47de-4327-882c-08d9769222f4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7187
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for sysfs interface for runtime features configuration.
 The user can configure the features at runtime. First the user need
 to select the config id of the supported features and then the user
 can configure the parameters of the feature based on the config id.
 So far the support is added for the over temperature and external
 watchdog features.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
Changes in v2:
- Update commit message
---
 drivers/firmware/xilinx/zynqmp.c | 71 ++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 875d13bc1a57..a1434dd368f2 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1361,6 +1361,75 @@ static DEVICE_ATTR_RW(pggs1);
 static DEVICE_ATTR_RW(pggs2);
 static DEVICE_ATTR_RW(pggs3);
 
+static atomic_t feature_conf_id;
+
+static ssize_t feature_config_id_show(struct device *device,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	return sysfs_emit(buf, "%d\n", atomic_read(&feature_conf_id));
+}
+
+static ssize_t feature_config_id_store(struct device *device,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	u32 config_id;
+	int ret;
+
+	if (!buf)
+		return -EINVAL;
+
+	ret = kstrtou32(buf, 10, &config_id);
+	if (ret)
+		return ret;
+
+	atomic_set(&feature_conf_id, config_id);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(feature_config_id);
+
+static ssize_t feature_config_value_show(struct device *device,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	int ret;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	ret = zynqmp_pm_get_feature_config(atomic_read(&feature_conf_id),
+					   ret_payload);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", ret_payload[1]);
+}
+
+static ssize_t feature_config_value_store(struct device *device,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	u32 value;
+	int ret;
+
+	if (!buf)
+		return -EINVAL;
+
+	ret = kstrtou32(buf, 10, &value);
+	if (ret)
+		return ret;
+
+	ret = zynqmp_pm_set_feature_config(atomic_read(&feature_conf_id),
+					   value);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(feature_config_value);
+
 static struct attribute *zynqmp_firmware_attrs[] = {
 	&dev_attr_ggs0.attr,
 	&dev_attr_ggs1.attr,
@@ -1372,6 +1441,8 @@ static struct attribute *zynqmp_firmware_attrs[] = {
 	&dev_attr_pggs3.attr,
 	&dev_attr_shutdown_scope.attr,
 	&dev_attr_health_status.attr,
+	&dev_attr_feature_config_id.attr,
+	&dev_attr_feature_config_value.attr,
 	NULL,
 };
 
-- 
2.32.0.93.g670b81a

