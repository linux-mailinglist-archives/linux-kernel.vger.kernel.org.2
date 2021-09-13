Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2D7408734
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbhIMIlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:41:39 -0400
Received: from mail-co1nam11on2057.outbound.protection.outlook.com ([40.107.220.57]:26208
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238162AbhIMIl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:41:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YInMwCt73jAvs1xOUVnGbzagAy+EIftqoG/TZFB0rpaEzVcJ+KQyJR02jfqkHMpjX00KZp+GAbU2E6UwmuvLhjbUFmFFpmScVNHhAME3QHU6zw7WUajTSk7pgI4NFYQ1CKQHk4ycUWgRuToRBGcicRtLVcCTXh0+TRUXxAp7Iuxers7eNTbCPHuAK/z0jMzqMVYL1Z6z+P1yyg5udCJvkWOcQIpeGiHVexqBCz5n5MMnWUnSMYBrqhGN8XohEAK49NwmXLAqWIwOt6wUpWXanHqhTOr4EsvO0142/7MWobx9wICXrtUbvz3qADOZFP/1P7H36NYvA8lmyQWwgBx9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JioRz3POfK62mbHI4yl/Tw7szNZ2xYq6Etn46MFIoT4=;
 b=e/wuAggV0bY+lnWo2E/hsX5jZ2BSpWuROBgAyZgz1BsfXGRiB9Gx2WFE6tMwDRrGoqI/WbL47vQ9TtUJnpZ1ZzI5UL9CgF99P+c93JMK/rxjwMxTEktNtCAyKqcDELYN+PKRzeq5o3tEH0UY/2wqhNYf8rTA08/2PmuTc20Qz0uZ8asZhB9V//RDwsxWL5b2Jk0vYIxID0ZSylv1cwLk0YDAX0/UW1x3/a87nrtu/SftFCZHnxjwZmU6c+IZ/RPIuQAyJiDwGKcQejWz5heo4GHL2MfRttr9iSYjaVla9JHiJAeiO3okfP73XVr9v3Go8gEwa43OCQnoWN8md32UCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JioRz3POfK62mbHI4yl/Tw7szNZ2xYq6Etn46MFIoT4=;
 b=nknKqTNmeOoqAt52NcPbdPpOsi7OTcl/3U1A4jVYgS+GQ7mbPyf/1BW3jV/ufNyMbsg/8w7iRNmYzqE+4h8XTwJqhNvtxc3w+pRDsDVp4tTVxdmDXBvpJUnlMu+XZp4eBT8M161Zb5EIsjPmGhP2Cg8yb60G8TGBvpSUk7LRH9M=
Received: from BN9PR03CA0099.namprd03.prod.outlook.com (2603:10b6:408:fd::14)
 by DM6PR02MB6542.namprd02.prod.outlook.com (2603:10b6:5:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 08:40:09 +0000
Received: from BN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::4f) by BN9PR03CA0099.outlook.office365.com
 (2603:10b6:408:fd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend
 Transport; Mon, 13 Sep 2021 08:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT040.mail.protection.outlook.com (10.13.2.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 08:40:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
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
        id 1mPhVU-000Cg1-D5; Mon, 13 Sep 2021 01:40:04 -0700
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rajan.vaja@xilinx.com>,
        <corbet@lwn.net>, <linux-arm-kernel@lists.infradead.org>,
        <arnd@arndb.de>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH v2 2/3] firmware: zynqmp: Add sysfs entry for runtime features
Date:   Mon, 13 Sep 2021 01:39:54 -0700
Message-ID: <20210913083955.27146-3-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20210913083955.27146-1-ronak.jain@xilinx.com>
References: <20210913083955.27146-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee773ea6-653a-4491-be77-08d976921874
X-MS-TrafficTypeDiagnostic: DM6PR02MB6542:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6542CBBE45D1FB5B52359AB3A4D99@DM6PR02MB6542.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfBwxnfgAkPYYKCIdsSPEEnDx/YBhppf3p2ZZ4rJkGi+cY7KZ5IDbxQt+8Oq8LkggNyqkF0T3RxRlLO0cW8tQKo6ZAIgmNF6eD4oUW2x/mqM/hb/D9CSkJZ/X1NE6YTeXOFEIkNc366uUlWPwhOLE1bi4S4lc3qgvOkrqKDtOWbBFEEmpOXWvKwBKYDI5tqv2fWhk/MEhlV6ClHqxyA6+jcCfus59EWn0BMoqU36LW66u//Owv1I9HaoXsN4xNmWt+2v0k/oEtqhNOWGnrHg/nBhtrctFPZuULhvKmZ2bQl+Sf84gEhp/XJ6P463qzjPYEKf7SObyDMVGZHQc+seFMvybZL/R/uINxqnmwafo/cdcLiD/J4pEhvtr7A9ecQA3yiAK9uQYoHSx/RmetLnQ/PTV/Z5VUtfr+uHgJm2NZKMCEPEhvHxlYNVDHcEVm6cgq+lEelw/dejZazNF1hafUPdcsgeqkvZT+HJpWVscSIfXC0dBkhAoEfwhMioz9geoMkFkQZCl/HwmIY2ny2rPUvbHQYApO/g+mVtEQonsQ+HRCu10wo6ediA91w88TzkZLWzkcbjnUphuEniL/fOWl67TH2cWy8udYFaT1tKS3+V35sgMlp1atjQPH7Tk6UudcNnzvQRRSMZ5nW+z7BTw86xEdeEb5wvAT6vmiK0VIQKXTWgfPRR85gEEoZWOHLmZCA940YI8kfGQno8JFpAVU1rTT3d88JIzr1VHPvHZzY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(82310400003)(5660300002)(36756003)(1076003)(83380400001)(426003)(336012)(8936002)(508600001)(2616005)(70586007)(186003)(70206006)(7696005)(47076005)(6666004)(36906005)(8676002)(316002)(44832011)(4326008)(7636003)(356005)(36860700001)(26005)(54906003)(107886003)(2906002)(9786002)(110136005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 08:40:09.5763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee773ea6-653a-4491-be77-08d976921874
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6542
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create sysfs entry for runtime feature configuration. The support
 is added for an over temperature and external watchdog feature.

The below listed files are used for runtime features configuration:
/sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
/sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value

In order to configure an over temperature or external watchdog
 features, first the user need to select the valid config id and then
 the user can configure the value for selected feature config id.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
Changes in v2:
- Update commit message
---
 .../ABI/stable/sysfs-driver-firmware-zynqmp   | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
index f5724bb5b462..2fde354715a5 100644
--- a/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
+++ b/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
@@ -113,3 +113,87 @@ Description:
 		    # echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/health_status
 
 Users:		Xilinx
+
+What:		/sys/devices/platform/firmware\:zynqmp-firmware/feature_config_*
+Date:		Aug 2021
+KernelVersion:	5.14
+Contact:	"Ronak Jain" <ronak.jain@xilinx.com>
+Description:
+		This sysfs interface allows to configure features at runtime.
+		The user can enable or disable features running at firmware.
+		Also, the user can configure the parameters of the features
+		at runtime. The supported features are over temperature and
+		external watchdog. Here, the external watchdog is completely
+		different than the /dev/watchdog as the external watchdog is
+		running on the firmware and it is used to monitor the health
+		of firmware not APU(Linux). Also, the external watchdog is
+		interfaced outside of the zynqmp soc.
+
+		By default the features are disabled in the firmware. The user
+		can enable features by querying appropriate config id of the
+		features.
+
+		The default limit for the over temperature is 90 Degree Celsius.
+		The default timer interval for the external watchdog is 570ms.
+
+		The supported config ids are for the feature configuration is,
+		1. PM_FEATURE_OVERTEMP_STATUS = 1, the user can enable or
+		disable the over temperature feature.
+		2. PM_FEATURE_OVERTEMP_VALUE = 2, the user can configure the
+		over temperature limit in Degree Celsius.
+		3. PM_FEATURE_EXTWDT_STATUS = 3, the user can enable or disable
+		the external watchdog feature.
+		4. PM_FEATURE_EXTWDT_VALUE = 4, the user can configure the
+		external watchdog feature.
+
+		Usage:
+
+		Enable over temperature feature
+		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+
+		Check whether the over temperature feature is enabled or not
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+		The expected result is 1.
+
+		Disable over temperature feature
+		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+		# echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+
+		Check whether the over temperature feature is disabled or not
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+		The expected result is 0.
+
+		Configure over temperature limit to 50 Degree Celsius
+		# echo 2 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+		# echo 50 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+
+		Check whether the over temperature limit is configured or not
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+		The expected result is 50.
+
+		Enable external watchdog feature
+		# echo 3 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+		# echo 1 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+
+		Check whether the external watchdog feature is enabled or not
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+		The expected result is 1.
+
+		Disable external watchdog feature
+		# echo 3 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+		# echo 0 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+
+		Check whether the external watchdog feature is disabled or not
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+		The expected result is 0.
+
+		Configure external watchdog timer interval to 500ms
+		# echo 4 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_id
+		# echo 500 > /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+
+		Check whether the external watchdog timer interval is configured or not
+		# cat /sys/devices/platform/firmware\:zynqmp-firmware/feature_config_value
+		The expected result is 500.
+
+Users:		Xilinx
-- 
2.32.0.93.g670b81a

