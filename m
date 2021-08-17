Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D7C3EED06
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbhHQNHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:07:09 -0400
Received: from mail-mw2nam08on2087.outbound.protection.outlook.com ([40.107.101.87]:58955
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235463AbhHQNHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:07:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWwOTOdpYWCBg9w9ao3TgLNQJgrKEi2Ounzox3AKnVUY1bJtL3MN6o0rC9/Ok5dU/TCM4OOokoqGQcNDUGRCFI613Ow6BHapbXVuQj/U7uZFEhdGOdGDzvp25URxS0u+4mJLoHi8tYqoouIDkMaWwMgnBnhLSSzcuVDZPoZSFU5jtXD+TdvlSW7jbZEcWG8vJLVt5fNLxOkenbkSlAA46Ug2cAhcLkzpBRlYlVHrd6CcdqPS9C7GXrQH6xAp8UNM/6n/GbYKYkvZEdHeaWWstF4IYYaegCRNk5DQecG0Nw24ayuEA+EF5Z8EMcqzHQGbusgFh1VtyZutnsSpjXu0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH7RRuqb8OM/74/FfL063BIok+oR5nr90Ex0VAVvnpk=;
 b=IJXns3HbT1jqvL0itoc6VsSo+ba6Wcn8pWbtiViCjNzPHVBlwlBgPNYeKC2+wZKDwzIsz7FEqHXPqxb+3C5JrWiMGni/nO27UGfZS0Nm0b6KRuTyPtnTVxi7PNlVZ/aavhtzlPyqRiO8SMN+21sm/moxTUV+X2vEVSklvzNFpyHPDg7/1q9QQnq3d5Bmj2mHf+TBT8Q+mP6btOXrKCfjc/Y4k157OSQYOxYuoQw/OBou4LUiqQAoRuzk1vMK8h6PjjSChYAsH+siBj+xNNK8pu438n1FykHhZLWLxn9JkEH7MzABcrKI90xoxjYo94VZTYKyx4b9tb8vRqfa0B5UlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH7RRuqb8OM/74/FfL063BIok+oR5nr90Ex0VAVvnpk=;
 b=CCtiz0y9N+awWqrd2p6sOrwTUCvHRuQJGlC5gDkyUucbd0mPS/Xke/RrgX+Cwhk4MgQamdmqvILfdxiuazO1lEcRxwRAv4JnX8HF10mFKWjzQdGky+94KpYwPxIk0w8ChcQbtsEi/UJDBM3+Baby8y3aEKZA/pPoLk8n66CkiO8=
Received: from BN6PR12CA0025.namprd12.prod.outlook.com (2603:10b6:405:70::11)
 by BYAPR02MB4423.namprd02.prod.outlook.com (2603:10b6:a03:5f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 13:06:28 +0000
Received: from BN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::91) by BN6PR12CA0025.outlook.office365.com
 (2603:10b6:405:70::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend
 Transport; Tue, 17 Aug 2021 13:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT050.mail.protection.outlook.com (10.13.2.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 13:06:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 06:06:27 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 17 Aug 2021 06:06:27 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [172.19.2.91] (port=34742 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ronak.jain@xilinx.com>)
        id 1mFynT-0002Yt-5i; Tue, 17 Aug 2021 06:06:27 -0700
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH 1/3] firmware: xilinx: Add support for runtime features
Date:   Tue, 17 Aug 2021 06:05:51 -0700
Message-ID: <20210817130553.20219-2-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210817130553.20219-1-ronak.jain@xilinx.com>
References: <20210817130553.20219-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1619f04-206f-4970-7e92-08d9617fd322
X-MS-TrafficTypeDiagnostic: BYAPR02MB4423:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4423B2EFDB57D2959570FBF1A4FE9@BYAPR02MB4423.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKgde51Lrlh3EzH3TCNx3RFbXMAtxWp8ZiRO+7xbW9Xle0ymCcCmQXJ9RqZkH5Cdic2n9Zd1Z2EJXE2iQ9cg9m+6ylHyFlrVUo8NfwTEW9zJOqq/iNwxJk2KLbu75SDDnggroLIW+2UwNmyI/Ul090HUNRgtaz7V4NXuMzrYKRd10fI78Ehfj6KPEhixb6No/2bpLWAXJe/Bel1mLuJhZNzVnA/Cf9uxUequcueSKS+JZa91T17MeDMaM6lENAUDOj17ek74nRn5qQl4qvPrxHIEog8MnmPJIDfxJaLKYuI4z2COKpilo0qW3AtSCZfnex4RBcqEqVfqTpvub/mVXI0X2xQPM6dwyzDWT+IoUUbuUR/W0qwTVwroJsX1c8baCPnMA7T+55YFwhTC609DlgnfDuRg0QgBxrYnqEyC8nIruFgR6fFJ2Wd/ccA5AXLucs6RaP9jYFENP3OMt+mlAO5avlQW29lzLCpe9e6h1yoyhCBOT7PBiK2njRHQYFv7l4ZrXkFsaWEFsO4efxVJjIXYOjrSyRQ/W30AWy2jJyM429DUaMVGKOPB77MOHWo6tMHFI+8deoFJZG2KdsfoiIx/DucTR+xPUp2oYiO+axU3g1N09EqoLrYQ5Pxe1U+oUOx+yXpW3UlSY6WD7TZa8i+FxaThwEwx6sCrsbOfjMeDxmE2U/UrcyMs3J+bS9D4TP3elQr+hx52bpWSbFwMZbQ96Pu+XgzvxCagYq5FTh8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(70206006)(26005)(5660300002)(107886003)(186003)(44832011)(426003)(356005)(9786002)(36860700001)(6666004)(2616005)(70586007)(8936002)(336012)(2906002)(7636003)(8676002)(82740400003)(83380400001)(54906003)(1076003)(82310400003)(36756003)(7696005)(47076005)(4326008)(478600001)(110136005)(36906005)(316002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 13:06:27.9300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1619f04-206f-4970-7e92-08d9617fd322
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4423
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for runtime features by using an IOCTL call. The features
 can be enabled or disabled on the firmware as well as the features
 can configure at runtime by querying IOCTL_SET_FEATURE_CONFIG id.
 Similarly, the user can get the configured values of features by
 querying IOCTL_GET_FEATURE_CONFIG id. Here, we have added support for
 the over temperature and external watchdog features only.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 27 +++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 25 +++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zyn=
qmp.c
index 15b138326ecc..e2b0a8fb6f44 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1049,6 +1049,33 @@ int zynqmp_pm_system_shutdown(const u32 type, const =
u32 subtype)
                                   0, 0, NULL);
 }

+/**
+ * zynqmp_pm_set_feature_config - PM call to request IOCTL for feature con=
fig
+ * @id:         The config ID of the feature to be configured
+ * @value:      The config value of the feature to be configured
+ *
+ * Return:      Returns 0 on success or error value on failure.
+ */
+int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value)
+{
+       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_FEATURE_CONFIG,
+                                  id, value, NULL);
+}
+
+/**
+ * zynqmp_pm_get_feature_config - PM call to get value of configured featu=
re
+ * @id:         The config id of the feature to be queried
+ * @payload:    Returned value array
+ *
+ * Return:      Returns 0 on success or error value on failure.
+ */
+int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
+                                u32 *payload)
+{
+       return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_FEATURE_CONFIG,
+                                  id, 0, payload);
+}
+
 /**
  * struct zynqmp_pm_shutdown_scope - Struct for shutdown scope
  * @subtype:   Shutdown subtype
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/=
xlnx-zynqmp.h
index 9d1a5c175065..06d82e334d2b 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -119,6 +119,9 @@ enum pm_ioctl_id {
        IOCTL_READ_PGGS =3D 15,
        /* Set healthy bit value */
        IOCTL_SET_BOOT_HEALTH_STATUS =3D 17,
+       /* Runtime feature configuration */
+       IOCTL_SET_FEATURE_CONFIG =3D 26,
+       IOCTL_GET_FEATURE_CONFIG =3D 27,
 };

 enum pm_query_id {
@@ -347,6 +350,14 @@ enum zynqmp_pm_shutdown_subtype {
        ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM =3D 2,
 };

+enum pm_feature_config_id {
+       PM_FEATURE_INVALID =3D 0,
+       PM_FEATURE_OVERTEMP_STATUS =3D 1,
+       PM_FEATURE_OVERTEMP_VALUE =3D 2,
+       PM_FEATURE_EXTWDT_STATUS =3D 3,
+       PM_FEATURE_EXTWDT_VALUE =3D 4,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:       query ID
@@ -411,6 +422,8 @@ int zynqmp_pm_pinctrl_get_config(const u32 pin, const u=
32 param,
                                 u32 *value);
 int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
                                 u32 value);
+int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
+int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payloa=
d);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -622,6 +635,18 @@ static inline int zynqmp_pm_pinctrl_set_config(const u=
32 pin, const u32 param,
 {
        return -ENODEV;
 }
+
+static inline int zynqmp_pm_set_feature_config(enum pm_feature_config_id i=
d,
+                                              u32 value)
+{
+       return -ENODEV;
+}
+
+static inline int zynqmp_pm_get_feature_config(enum pm_feature_config_id i=
d,
+                                              u32 *payload)
+{
+       return -ENODEV;
+}
 #endif

 #endif /* __FIRMWARE_ZYNQMP_H__ */
--
2.32.0.93.g670b81a

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
