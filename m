Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC223EED05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhHQNHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:07:05 -0400
Received: from mail-dm6nam08on2058.outbound.protection.outlook.com ([40.107.102.58]:29603
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229721AbhHQNHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:07:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+Oy/BI4JY10gr+Od4ZcGQ0UsruVP2xR1YDUG2XYCrtYhS2OrMIXBb++q3lEgKnrZ1jkMKCQ9H2cGCd9Ou6R5Ti7mNqELN5Gytl2O5kK2qykbaYvzxiDsEbRZCgOaaeqEwlrhshY0mvpxRofeo1bhOnJOfttnt33EUwIfP/1OKZTWwRzoHhHtjhG/0VC4rBxFLMf7yyYxJUxz3t1CTwUOi33IqVXL/QXm6jsVa9KYQl34kQsRCEjhYn1O3WfJ4ZhtpogWra4m+I8aA/H7Y3SwQAXNcGox2cEvp7PFLVuuZ5gjLI/wASird94YbVxGkhzC9Wicl7uQmN2xf/M0xZ0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laiyVZpx0QQrAFdqXaaEKkQpea2mA3weXtGanss4B6c=;
 b=Z0bXuksHZ7k3eFQVMVhqLCct9HFwsOVXovt1qUNmqjNtUT10HrdDoijzJ7/C5fy+778DqHiwJF1zYwUaddAppR+tL68v/ySW25+s+pfJUtOGidwBuILG1K4sp+vorCTuSEe/aYVhdP+WE/Efoe3KKKTg2QSom3wQz0Kyd7+WSKaAWB2u21/51wQKKNvLJzEYvwo+FT6fHYLTifxnk3xtZBwu/6u0JOb8PyjVt3ja2MQgAwnB0mDS18LX1qYnB7h/7G/8KpjO39rvxNH8g9RxbHpCQohSX7UoJS3HHTOyjOCoaXQ3j3KVThfaE9vWizgbJcjpKIBnk1+Dtf2lkUN2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laiyVZpx0QQrAFdqXaaEKkQpea2mA3weXtGanss4B6c=;
 b=b229w45l6s75FpX3F10lY2le6q3taP/GbmC9K9RjPYK59VF99vW+lXqj8+1Hc9411Z7HGjHPnYyXfcKhL+CYV/sVUxfKlq1LDmx8g+81eZUPe61qOBqEL3swOIcsKgu6UKFj3yI9sKdufITvab6RI1DBLiOYI1qK4D9x6G4/bXs=
Received: from SN7PR04CA0120.namprd04.prod.outlook.com (2603:10b6:806:122::35)
 by BL0PR02MB5475.namprd02.prod.outlook.com (2603:10b6:208:89::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.21; Tue, 17 Aug
 2021 13:06:28 +0000
Received: from SN1NAM02FT0042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:122:cafe::a3) by SN7PR04CA0120.outlook.office365.com
 (2603:10b6:806:122::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend
 Transport; Tue, 17 Aug 2021 13:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0042.mail.protection.outlook.com (10.97.4.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 13:06:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
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
        id 1mFynT-0002Yt-7P; Tue, 17 Aug 2021 06:06:27 -0700
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH 3/3] firmware: xilinx: Add sysfs support for feature config
Date:   Tue, 17 Aug 2021 06:05:53 -0700
Message-ID: <20210817130553.20219-4-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210817130553.20219-1-ronak.jain@xilinx.com>
References: <20210817130553.20219-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f34f092d-cfa5-4b9f-fb3d-08d9617fd310
X-MS-TrafficTypeDiagnostic: BL0PR02MB5475:
X-Microsoft-Antispam-PRVS: <BL0PR02MB5475449012D9544524245BD1A4FE9@BL0PR02MB5475.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMfnd11zONYQErkSJViQFr4uOBMfZcL+tbEVZCVGA3ZZH2d3CCMkOQVzXGXhxs6ZAoRReJ5YcUpTwEtgCAHMHWwF4l7dc2zOvi9XyYrgxbpz5nAAeOpVTMivrLC+UGZs8obhoykpQMJ+isPX10Uv8D5v7CcQF20C3EWJmYYO+tOf6eikA3u+wwJUg6JAw02gIPBFtIxdvhSKOApJZAHZF7Y8ffGg7feh10iwwn8qKxk4MzXwTeC2ezYdFPLT5S0GkZ4GrGbZMwfDC/IIIqN7JnmNEjXaEz+8nKUq2sOd5U7VVceCQStKrBMO5g8WO/BRmsQp4zIhx8Fhg50xgwV69d2yRgr72Gt2Z2v0esTQ6jtBMWJukrvRMTIPu4DlZUqJZv9bK98uDYwRulY+H/qLF19fUcz7vlimQr9GmuKF6xv6vz5DXPgGW1yCMSs0V3rCLKGa521u15LcYSiT2IHBk8DhQqK794OvYsEdEfWk2eSw95jf4HJRB045rTdJiCHawlQYpwE/BVaoQ/EUp9N5aH2XvJwy9GoAI+yk5s+SJuwPRzIc0m+UqTbiNQvPZ1mX3xRoeCItfsc266vCQnQksMPyr8wAoqNDnRL/6tOrGPLDzN7zQXiPQV1Z+FSETjNdMcVC/d8XY3KK6zccYeyKBIXtgq5o0WuvIVYr602RJgQvHDm7IPKPOOxE/qngFdETZeNjhl8a0eDe3mfpbWr4VMNdCbc2Hz/ONhoBJ2YqGjI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(36840700001)(8676002)(83380400001)(70206006)(5660300002)(8936002)(107886003)(2906002)(6666004)(70586007)(4326008)(54906003)(478600001)(9786002)(316002)(110136005)(36906005)(356005)(186003)(47076005)(1076003)(26005)(336012)(426003)(2616005)(36860700001)(7636003)(82740400003)(7696005)(82310400003)(44832011)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 13:06:27.8672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f34f092d-cfa5-4b9f-fb3d-08d9617fd310
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5475
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for sysfs interface for runtime features
 configuration. The user can configure the features at runtime. First
 the user need to select the config id of the supported features and
 then the user can configure the parameters of the feature based on
 the config id. So far the support is added for the over temperature
 and external watchdog features.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c | 71 ++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zyn=
qmp.c
index e2b0a8fb6f44..4c5010899837 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1344,6 +1344,75 @@ static DEVICE_ATTR_RW(pggs1);
 static DEVICE_ATTR_RW(pggs2);
 static DEVICE_ATTR_RW(pggs3);

+static atomic_t feature_conf_id;
+
+static ssize_t feature_config_id_show(struct device *device,
+                                     struct device_attribute *attr,
+                                     char *buf)
+{
+       return sysfs_emit(buf, "%d\n", atomic_read(&feature_conf_id));
+}
+
+static ssize_t feature_config_id_store(struct device *device,
+                                      struct device_attribute *attr,
+                                      const char *buf, size_t count)
+{
+       u32 config_id;
+       int ret;
+
+       if (!buf)
+               return -EINVAL;
+
+       ret =3D kstrtou32(buf, 10, &config_id);
+       if (ret)
+               return ret;
+
+       atomic_set(&feature_conf_id, config_id);
+
+       return count;
+}
+
+static DEVICE_ATTR_RW(feature_config_id);
+
+static ssize_t feature_config_value_show(struct device *device,
+                                        struct device_attribute *attr,
+                                        char *buf)
+{
+       int ret;
+       u32 ret_payload[PAYLOAD_ARG_CNT];
+
+       ret =3D zynqmp_pm_get_feature_config(atomic_read(&feature_conf_id),
+                                          ret_payload);
+       if (ret)
+               return ret;
+
+       return sysfs_emit(buf, "%d\n", ret_payload[1]);
+}
+
+static ssize_t feature_config_value_store(struct device *device,
+                                         struct device_attribute *attr,
+                                         const char *buf, size_t count)
+{
+       u32 value;
+       int ret;
+
+       if (!buf)
+               return -EINVAL;
+
+       ret =3D kstrtou32(buf, 10, &value);
+       if (ret)
+               return ret;
+
+       ret =3D zynqmp_pm_set_feature_config(atomic_read(&feature_conf_id),
+                                          value);
+       if (ret)
+               return ret;
+
+       return count;
+}
+
+static DEVICE_ATTR_RW(feature_config_value);
+
 static struct attribute *zynqmp_firmware_attrs[] =3D {
        &dev_attr_ggs0.attr,
        &dev_attr_ggs1.attr,
@@ -1355,6 +1424,8 @@ static struct attribute *zynqmp_firmware_attrs[] =3D =
{
        &dev_attr_pggs3.attr,
        &dev_attr_shutdown_scope.attr,
        &dev_attr_health_status.attr,
+       &dev_attr_feature_config_id.attr,
+       &dev_attr_feature_config_value.attr,
        NULL,
 };

--
2.32.0.93.g670b81a

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
