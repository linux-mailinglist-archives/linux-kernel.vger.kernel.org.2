Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA3A3EED0D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbhHQNHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:07:54 -0400
Received: from mail-dm6nam12on2053.outbound.protection.outlook.com ([40.107.243.53]:61792
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237231AbhHQNHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:07:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpJVj84OSYxpILZgnNYmBj0BaxCOgS/AwE/jzc2s059/1l+Z6ohiKgAPDVicZb/mPjzxhab7jJuQ4df+EHFO414nqJohqPPDHB5HJCL6z+26unkzb8eIh4Ymg6Sfa+yq8oOH/tg7Zd12piDb7Esg1kU6N0Its5YdevVJpJ4LX0kF1wVvT0lyPyZ+QprT/vVaJNVx1zaKpIJt8q2QTAtJHgCr/u93RYdccbPM5F2cLQ984dmiax81huP9Sn3pgrKwElpf8GPuZmwB2Rh7uWCPn3tUrtMvxEhqEEPeng3DrgEKKCnq6VpFpX3mQxFfUati6UD5RHGchAlOB49pTbBcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmt77Apw8zUr9Ux6jYtpEUzzF15/ZPF1GjmuqrH/5W8=;
 b=nDprRvMp1JtdEdg0ChLtL0vdhDX+A5CM9GMZBskDkbJuLNxh3AsjgnKmh5IxQN8rT5ZaSWgUIXtp3yoGUsTSpD8aIdGHgnhAkPlMfiWExGgiCP6iOkOhkfploXqJAvEDdAMCKVYCcbkkG9AXQuAjQtBNDSD2DzgVTj7zOjqdk6Nc2EkORgLLr4ePWGjQWKd07wh4/0pPnkLCfAxn6hbyxPSd3wE4FnCtygF+YIZ8OCymxzn79+FxveZNXIVjUTPdxeDywzPQi70AcpzxBhI/mzDAHf1WUA68Cx9FmZ4r3tJ82321SUhrrLJWqGCKncMaCu2CJLjjGlNCWKrTL8p1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmt77Apw8zUr9Ux6jYtpEUzzF15/ZPF1GjmuqrH/5W8=;
 b=szUNcFYyKDJP+gxVvwvZXOPBh/V0Ly4WbG+KPemPMeRZGPNSldwUsgl+Nx5+BrMyGCdaddfhtplBHbEQ6X+zH4GOVRxU3YcKfeJ+U+ZI4Fy1qMqoRsF+Z+W0VY6kqJrWosj90GSXV3RmREC8jody0uf/PI6ocSI+plRkaP0YZ1Q=
Received: from SA9P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::8) by
 BYAPR02MB4229.namprd02.prod.outlook.com (2603:10b6:a02:fd::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14; Tue, 17 Aug 2021 13:07:18 +0000
Received: from SN1NAM02FT0017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:25:cafe::cd) by SA9P221CA0003.outlook.office365.com
 (2603:10b6:806:25::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Tue, 17 Aug 2021 13:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0017.mail.protection.outlook.com (10.97.4.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 13:07:18 +0000
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
        id 1mFynT-0002Yt-6W; Tue, 17 Aug 2021 06:06:27 -0700
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH 2/3] firmware: zynqmp: Add sysfs entry for runtime features
Date:   Tue, 17 Aug 2021 06:05:52 -0700
Message-ID: <20210817130553.20219-3-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210817130553.20219-1-ronak.jain@xilinx.com>
References: <20210817130553.20219-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2bfea1f-aad5-45d6-9f00-08d9617ff0fb
X-MS-TrafficTypeDiagnostic: BYAPR02MB4229:
X-Microsoft-Antispam-PRVS: <BYAPR02MB422929A255F5D398E7B216B2A4FE9@BYAPR02MB4229.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RX5pt8cJSkcfV1MVE68xI78qaoOOqk82ubve6ILsJC1RVEMtbVm3KL4Y0NQFHVrxcqzWuHzdVe5quinuj/xKyfunSn8zcHRTvk0EqDlxL8ChXNLF8uYPurOvSvw9K4NLpzCDzp7y6+L4WFtqtOqSF32mejRyOPjH8SknRCRe7KU9x1JPduR2+hZQ/6zgUD4TPgCh4nIesv6URfmhQk8zRZQJ3OW10meXYan43F7CvQU5YF30w3Tt7Dg8G9hVSfgAVsTPR+HLgsKPKrWKDOaPNWv++zR+4lyVyyYsFvcNiiCM73iKNy11cNXe/CuE6uYNVQYBQFrapEQ5Qn+dqrofYSzJqjNWGrr9O77nVg1WwFrWp4uKmhLrOYXba4QYNesMW+alxJ1t+zBaa0hpullZxYWtmxEmIqx7+x9I55hz8x3qgzP2DPxdft1ks80UGzrzdX/itABehV2NblJ2SjUQTbf9nDlzz9S8EHbRhzqjmdqKrw7g36IpAUJvSgXzj/46+XoJ6kA1vgvzoxz8g9TqaOlL+MhqdTeSBG30Gqhfx4zt2TeHFiL5J0Np0gFari3DajSkhrIrtyGHtNuqvxLT523A2lk+xA2lDMyFEWgWRzSRD7T2X6skYS7wK0c+BH9UAIfRJpZKLTvBIMhO4RZ7iy97edtExkk/RP2TnDMbnbEg5id612xEv7CEgtX5FdsRrwBWlKQ/wEPOYw0w5cf1uTUKB+yQFhVtTfJGH9/+jUw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2616005)(54906003)(36756003)(426003)(44832011)(4326008)(8936002)(110136005)(356005)(7696005)(70586007)(36860700001)(70206006)(336012)(107886003)(47076005)(36906005)(82310400003)(316002)(9786002)(7636003)(186003)(2906002)(1076003)(5660300002)(508600001)(26005)(6666004)(83380400001)(8676002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 13:07:18.0589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bfea1f-aad5-45d6-9f00-08d9617ff0fb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4229
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create sysfs entry for runtime feature configuration. Here the support
 is added for an over temperature and external watchdog feature.

The below listed path is used for runtime features configuration:
/sys/devices/platform/firmware\:zynqmp-firmware/*

Here there are two files to configure features at runtime.
1. feature_config_id
2. feature_config_value

In order to configure an over temperature or external watchdog
 features, first the user need to select the valid config id and then
 the user can configure the value for selected feature config id.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
 .../ABI/stable/sysfs-driver-firmware-zynqmp   | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Docume=
ntation/ABI/stable/sysfs-driver-firmware-zynqmp
index f5724bb5b462..2fde354715a5 100644
--- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
+++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
@@ -113,3 +113,87 @@ Description:
                    # echo 0 > /sys/devices/platform/firmware\:zynqmp-firmw=
are/health_status

 Users:         Xilinx
+
+What:          /sys/devices/platform/firmware\:zynqmp-firmware/feature_con=
fig_*
+Date:          Aug 2021
+KernelVersion: 5.14
+Contact:       "Ronak Jain" <ronak.jain@xilinx.com>
+Description:
+               This sysfs interface allows to configure features at runtim=
e.
+               The user can enable or disable features running at firmware=
.
+               Also, the user can configure the parameters of the features
+               at runtime. The supported features are over temperature and
+               external watchdog. Here, the external watchdog is completel=
y
+               different than the /dev/watchdog as the external watchdog i=
s
+               running on the firmware and it is used to monitor the healt=
h
+               of firmware not APU(Linux). Also, the external watchdog is
+               interfaced outside of the zynqmp soc.
+
+               By default the features are disabled in the firmware. The u=
ser
+               can enable features by querying appropriate config id of th=
e
+               features.
+
+               The default limit for the over temperature is 90 Degree Cel=
sius.
+               The default timer interval for the external watchdog is 570=
ms.
+
+               The supported config ids are for the feature configuration =
is,
+               1. PM_FEATURE_OVERTEMP_STATUS =3D 1, the user can enable or
+               disable the over temperature feature.
+               2. PM_FEATURE_OVERTEMP_VALUE =3D 2, the user can configure =
the
+               over temperature limit in Degree Celsius.
+               3. PM_FEATURE_EXTWDT_STATUS =3D 3, the user can enable or d=
isable
+               the external watchdog feature.
+               4. PM_FEATURE_EXTWDT_VALUE =3D 4, the user can configure th=
e
+               external watchdog feature.
+
+               Usage:
+
+               Enable over temperature feature
+               # echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/=
feature_config_id
+               # echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/=
feature_config_value
+
+               Check whether the over temperature feature is enabled or no=
t
+               # cat /sys/devices/platform/firmware\:zynqmp-firmware/featu=
re_config_value
+               The expected result is 1.
+
+               Disable over temperature feature
+               # echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/=
feature_config_id
+               # echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/=
feature_config_value
+
+               Check whether the over temperature feature is disabled or n=
ot
+               # cat /sys/devices/platform/firmware\:zynqmp-firmware/featu=
re_config_value
+               The expected result is 0.
+
+               Configure over temperature limit to 50 Degree Celsius
+               # echo 2 > /sys/devices/platform/firmware\:zynqmp-firmware/=
feature_config_id
+               # echo 50 > /sys/devices/platform/firmware\:zynqmp-firmware=
/feature_config_value
+
+               Check whether the over temperature limit is configured or n=
ot
+               # cat /sys/devices/platform/firmware\:zynqmp-firmware/featu=
re_config_value
+               The expected result is 50.
+
+               Enable external watchdog feature
+               # echo 3 > /sys/devices/platform/firmware\:zynqmp-firmware/=
feature_config_id
+               # echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/=
feature_config_value
+
+               Check whether the external watchdog feature is enabled or n=
ot
+               # cat /sys/devices/platform/firmware\:zynqmp-firmware/featu=
re_config_value
+               The expected result is 1.
+
+               Disable external watchdog feature
+               # echo 3 > /sys/devices/platform/firmware\:zynqmp-firmware/=
feature_config_id
+               # echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/=
feature_config_value
+
+               Check whether the external watchdog feature is disabled or =
not
+               # cat /sys/devices/platform/firmware\:zynqmp-firmware/featu=
re_config_value
+               The expected result is 0.
+
+               Configure external watchdog timer interval to 500ms
+               # echo 4 > /sys/devices/platform/firmware\:zynqmp-firmware/=
feature_config_id
+               # echo 500 > /sys/devices/platform/firmware\:zynqmp-firmwar=
e/feature_config_value
+
+               Check whether the external watchdog timer interval is confi=
gured or not
+               # cat /sys/devices/platform/firmware\:zynqmp-firmware/featu=
re_config_value
+               The expected result is 500.
+
+Users:         Xilinx
--
2.32.0.93.g670b81a

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
