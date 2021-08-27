Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC53FA069
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 22:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhH0UQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 16:16:26 -0400
Received: from mail-dm6nam10on2082.outbound.protection.outlook.com ([40.107.93.82]:32608
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229591AbhH0UQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 16:16:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEWfe9Oo/6W8sWf6HPqN7usShm7/3zvKf4D5JFCrBHy/rewS9xzF+rlgPvjFnrxxID+wOubZW27wi6dMxGgDVTT+4+0JlFSdU2aXiAJ1GOm9EIw2Pw3ZTSZB0lYBy5hsxInhGMUh/nnW8wr+ffgSiXIy9Cjj8/iQE45/xnG6dbH6lEMNyWS3sRSoAsyJuqQPE3voA8wO5sumvxlo9e89tRy0FmhnWRHiFNd52rPd6IQC+IMtNW8TfGgaQwqZiOJBO+QUzypu2ZWBrVhh0CPP5OkSk954DOuoenvVawvUt3+PeY5cZp8FQLTL7GjudXXEzDjiYqRrAn905HhbxXoGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+FvOmV9XUAAYsWS51vOYBMIZpfGeH2TnGcluv0/XJM=;
 b=RRQv/3w43C3qLEqtUbu3KpNx4TZmxTGVgnvt0FJU/ciw7ESmQE8mdcGch/ReGI9YMv/oT7a+bs8YQUrqsiqt0qEzdUPSojSrRLJkdb8vIJAZjv/QRtn5bMZVbf2NDCnzFmSVPVu0DxxMIK/ICvlRi+VXf2pnYMJ7R5AiGpugZFjw5mvFS35IV/Xhg6hPzuF9amzVx0c8kPCapJ8+srdaPzeit64t0FkJT5c9akWnmUqo0/U1fF4NmdvVixbEz6kcxT5yfXZDHZzLRcT+bvf7XCz1RDQeCb/zHl6r5tUEhWPfCsnNSCrV+vBgLcqnIewA+s87SDqaXa1zAjz98FKH3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+FvOmV9XUAAYsWS51vOYBMIZpfGeH2TnGcluv0/XJM=;
 b=uiZm7QyL9sSVzXapdnoxHEe3NPaiLAno0JTrVLQs3OTfz5oAHEWkX47SxF16+IyFa8pUox3M1Vg9o5xG7uUu6KR6kVoZ/pA/9ty5R0VbiOUEKzGkBUlqKb6ZxE5gu+i+oM+9vbILtVQyWZ42Pr4cYvHPEIEULqVgLivsaqAOwHo=
Received: from DM3PR12CA0069.namprd12.prod.outlook.com (2603:10b6:0:57::13) by
 MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Fri, 27 Aug
 2021 20:15:34 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::b1) by DM3PR12CA0069.outlook.office365.com
 (2603:10b6:0:57::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Fri, 27 Aug 2021 20:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; ladisch.de; dkim=none (message not signed)
 header.d=none;ladisch.de; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:15:33 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 27 Aug
 2021 15:15:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>
CC:     <linux-hwmon@vger.kernel.org>,
        Gabriel Craciunescu <nix.or.die@googlemail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wei Huang <wei.huang2@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Jean Delvare" <jdelvare@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] hwmon: (k10temp): Rework the temperature offset calculation
Date:   Fri, 27 Aug 2021 15:15:25 -0500
Message-ID: <20210827201527.24454-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827201527.24454-1-mario.limonciello@amd.com>
References: <20210827201527.24454-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8b5550b-f649-44dd-e33d-08d969976cee
X-MS-TrafficTypeDiagnostic: MN2PR12MB4190:
X-Microsoft-Antispam-PRVS: <MN2PR12MB41909AA93AAEA0612AF78574E2C89@MN2PR12MB4190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPMYpoXxabmC7SXnauMonPh5ZsQ7QAEFBaghW06AM+tdyf1md9eWsWJrZVn8fGAA+Am6vWnNuAinpjUjTrp78Ex+ieoABw2R/0yvIK2xLsXpyoTT61XeJTVMtyyxuT+5uWygjhZZ/Wkm3Nznwq06HrrPeroDrh2Jn5fTSmTcwKx5JCZB63dUFsUTlLXyNcl7mDHHdWoAGrrQwuMTnx+CY1KHja3g/5Kt1ZCu3QOrgyJ4Bh06CpBHPf9DarxGWSOaC5XItCp2VJg3HT3LSXqP0I0gwuwrvdLDhwvEgtCxVQlAHaKICJ0chVfrBU6bvJmdLz1v75DU4wOKhD40tnuRiv7xpQpsmFYlTxx+k+kW1T/QAqNXLgOm3UyKMZt/x8JjZ0OGKeaHEhJoWelHro0s9RrAHmxDVo08v18pyvydCi/VhwIv9Uzq7tr00lB2I/WZLKBOa/z11QhjCbUQ7hlEZ0oYeBwXv46B1iWI4Bp8KqXLfJ072+a/LFAsboL10uAPFWiO2yoWLAafK8uZiYX9LtabyIeAMZMFgrk279/XPvGJtdD3fysXcuvNSldD9bUukUq3M5d085811lxl8wz19Q5VsCB0yEytd2JkF4Lz/Q/OdGtEg7f5EeCvNqr8PzbfJGqOHt1lh5CffoYF3wLjEcRsHUXmhBTCU7rLETQr1wWjeMWK8Mfomp+xsW1F4kCHzcB46cBEEIrbubWG0xfs63hDSUjQQZdeCqtoMGwrIiI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(2906002)(36860700001)(4326008)(70206006)(2616005)(1076003)(316002)(44832011)(5660300002)(8936002)(16526019)(82740400003)(83380400001)(7696005)(8676002)(47076005)(26005)(86362001)(81166007)(6916009)(54906003)(36756003)(6666004)(356005)(186003)(478600001)(336012)(82310400003)(426003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:15:33.7219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b5550b-f649-44dd-e33d-08d969976cee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the existing assumptions made do not scale properly
to new silicon in upcoming changes.  This commit should cause
no functional changes to existing silicon.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/hwmon/k10temp.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index f6b325b8463e..159dbad73d82 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -65,10 +65,11 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define F15H_M60H_HARDWARE_TEMP_CTRL_OFFSET	0xd8200c64
 #define F15H_M60H_REPORTED_TEMP_CTRL_OFFSET	0xd8200ca4
 
-/* Common for Zen CPU families (Family 17h and 18h) */
-#define ZEN_REPORTED_TEMP_CTRL_OFFSET		0x00059800
+/* Common for Zen CPU families (Family 17h and 18h and 19h) */
+#define ZEN_REPORTED_TEMP_CTRL_BASE		0x00059800
 
-#define ZEN_CCD_TEMP(x)				(0x00059954 + ((x) * 4))
+#define ZEN_CCD_TEMP(offset, x)			(ZEN_REPORTED_TEMP_CTRL_BASE + \
+						 (offset) + ((x) * 4))
 #define ZEN_CCD_TEMP_VALID			BIT(11)
 #define ZEN_CCD_TEMP_MASK			GENMASK(10, 0)
 
@@ -103,6 +104,7 @@ struct k10temp_data {
 	u32 temp_adjust_mask;
 	u32 show_temp;
 	bool is_zen;
+	u32 ccd_offset;
 };
 
 #define TCTL_BIT	0
@@ -163,7 +165,7 @@ static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
 static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
 {
 	amd_smn_read(amd_pci_dev_to_node_id(pdev),
-		     ZEN_REPORTED_TEMP_CTRL_OFFSET, regval);
+		     ZEN_REPORTED_TEMP_CTRL_BASE, regval);
 }
 
 static long get_raw_temp(struct k10temp_data *data)
@@ -226,7 +228,8 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 			break;
 		case 2 ... 9:		/* Tccd{1-8} */
 			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
-				     ZEN_CCD_TEMP(channel - 2), &regval);
+				     ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
+						  &regval);
 			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
 			break;
 		default:
@@ -387,7 +390,7 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
 
 	for (i = 0; i < limit; i++) {
 		amd_smn_read(amd_pci_dev_to_node_id(pdev),
-			     ZEN_CCD_TEMP(i), &regval);
+			     ZEN_CCD_TEMP(data->ccd_offset, i), &regval);
 		if (regval & ZEN_CCD_TEMP_VALID)
 			data->show_temp |= BIT(TCCD_BIT(i));
 	}
@@ -433,12 +436,14 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		case 0x8:	/* Zen+ */
 		case 0x11:	/* Zen APU */
 		case 0x18:	/* Zen+ APU */
+			data->ccd_offset = 0x154;
 			k10temp_get_ccd_support(pdev, data, 4);
 			break;
 		case 0x31:	/* Zen2 Threadripper */
 		case 0x60:	/* Renoir */
 		case 0x68:	/* Lucienne */
 		case 0x71:	/* Zen2 */
+			data->ccd_offset = 0x154;
 			k10temp_get_ccd_support(pdev, data, 8);
 			break;
 		}
@@ -451,6 +456,7 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		case 0x0 ... 0x1:	/* Zen3 SP3/TR */
 		case 0x21:		/* Zen3 Ryzen Desktop */
 		case 0x50 ... 0x5f:	/* Green Sardine */
+			data->ccd_offset = 0x154;
 			k10temp_get_ccd_support(pdev, data, 8);
 			break;
 		}
-- 
2.25.1

