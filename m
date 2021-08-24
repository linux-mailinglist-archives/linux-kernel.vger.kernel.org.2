Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E933F6622
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbhHXRUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:20:43 -0400
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com ([40.107.244.83]:30176
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239880AbhHXRSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:18:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkeB6050ooqj1u9uZY+WNufiYpduWH2GpXJm01kcbYm9ErkWHYayBy1uqL3oE2Roq5EgB1GTo2612qJrptQXSt6nN/bpgrQw41Dn80TVjOv1mWiWOuFVOk4gjygsj0mVa3il+5jIumddQF2XZF8vWT/oDCBbNYYnVUqJ42hyuFBDyTSxV7VEepgWE3E0CckYHJIkgrPBdUb9MY1ss1o8InAgkLjswbpFKkGREtWpjAF7TgdFjoRrZEvjTbg13OODmHj13EAMzYV4mGuCT33+f5YhvigcaNhbUq5NQP7TFZellq9j83L2JDWTIVKcPN17puAP9mdkocA6ezGlw2kw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rfy02Cl0w6CyGciC8JFZa/SZn8yCtQL2V7ejDpTdZJY=;
 b=EgVldQXgz0+IHI8Ttv7Wj0xD3S8uQeCUwmuV6Lh4UMMY8yNA7dpNlF94gN13yg7HGWt538ML0Iqmc/ngV741pUxYm0ZsMzcsfc/SbFivltrfZje1am28raCIt26Oui2RO9UjpUcdFzLHTgcTZBlEgKTGYhezaDUc2zzaVlu0lpeXqrjqJxPlvAWYx4ZMEvvOOKXgksY0BPmbkbH5BtdtD3KXMDHUv7fG4YTW1K6Eu23GDSI1YjjCN2X0EIaaysBTiXvrTK+ZxDbDZ7hiA9hGdRpo1WpdN5ACo0u3Wj3qNwF5uM5drAIYOYAKkzpA1ndSuTeYRXd3ZALxuB3mrRHhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rfy02Cl0w6CyGciC8JFZa/SZn8yCtQL2V7ejDpTdZJY=;
 b=FA1a4nBB8yCB9rVFzQFwJhe7uIMd6Q5BYn+sIZ9QqTYlXMIDRWWCVFmq3jEu1XXtlJwbOW0ALFhT1lbW63CF5rYlY/tTuS1jBE82bgOmYZNpDkWfLyFWgsufgAOTfrtCdl8swtpGFNOoUgTNSgdHTdMSCUNtZpek4yAyV2kK83M=
Received: from DM5PR10CA0005.namprd10.prod.outlook.com (2603:10b6:4:2::15) by
 DM5PR0201MB3574.namprd02.prod.outlook.com (2603:10b6:4:77::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Tue, 24 Aug 2021 17:17:22 +0000
Received: from DM3NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::55) by DM5PR10CA0005.outlook.office365.com
 (2603:10b6:4:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 17:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT004.mail.protection.outlook.com (10.13.5.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 17:17:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 10:17:06 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 10:17:06 -0700
Envelope-to: git@xilinx.com,
 peter.chen@kernel.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.8] (port=48481 helo=xhdvnc108.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1mIa2r-000EeV-AW; Tue, 24 Aug 2021 10:17:05 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 16987)
        id 86B15604B4; Tue, 24 Aug 2021 22:46:34 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Manish Narani <manish.narani@xilinx.com>,
        "Subbaraya Sundeep Bhatta" <sbhatta@xilinx.com>
Subject: [PATCH 3/6] usb: chipidea: Check usb_phy exists before using it
Date:   Tue, 24 Aug 2021 22:46:15 +0530
Message-ID: <1629825378-8089-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
References: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34c6cca0-420c-4014-0672-08d9672308f3
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3574:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB357425B4DC9A40F070E8A752C1C59@DM5PR0201MB3574.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/+6uY76FbmbK59fZJYfS0wAeuPLILf7lL6pOtO/2gdBS7RApuxHcEemCcDCIUbSJauDxfOQOlkp1HonanbCvkbt6XIZQmTL11IslrgphDxkJ+JOwo9TFp9P707I41IVtRQ7+tlDU1/H5w/Rp536552f6Hmk30YTgUMq0OZVUi6gP6Pm4JUIBYonDan6aPgIQDAqgStF378kte0NUU4Rh6xmU7ZkLldWqyPmbETg+Kti473olzYpyspc2EAEPZzaXfaqbSQVu1LxHzBWViMYxyO6tMPgOnnL0RatLTnfKAkWneKMU6WWXisVQlYCa16MB/pH/7m7yqs4M/4H+zwXOT+hk7lPtdUC+ciogYf35L7zrZNsyo3kaAlqSDkuJXMMw+NXhapFOHZoRpNlm2NSD3wrZLrkwDHMRXlZHZX731HwZq/IYeKzB2yHSNeMLXBWfNgADrhKV+H3vCWZycqYgPjEcpHirl2zFVbrYAtUnyccAxIUdC0Glwt6zlqgdezFY7gPxILnUjk23Z9pLDFidZyYkXL0mZLjOnjbNEAZ+SLXqcIDAIcItnmN2xCnChr4fyBMrM2VnYup++XSPvbua5DCf9eq2nVXELHlSrlFIzPtiT+0eASR0JU+HmnB6Lqpt4b9pc6HSj9RoXRrCJ+TBS+lcxBhsIwJvmr7F7aeC2w0AVhehPkMoGFWACf/yIHyk11KdetzJuZCCScUxVldBIcRVIsJgLyGidiJB28yN1s=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966006)(36840700001)(70586007)(110136005)(6636002)(70206006)(4326008)(54906003)(316002)(82740400003)(7636003)(478600001)(356005)(5660300002)(47076005)(36906005)(8936002)(26005)(42186006)(36756003)(107886003)(44832011)(36860700001)(83380400001)(2616005)(336012)(426003)(6666004)(82310400003)(6266002)(186003)(2906002)(8676002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 17:17:22.0387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c6cca0-420c-4014-0672-08d9672308f3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3574
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_phy and usb_phy->set_vbus may not be present all the times
based on PHY driver used. So check for it.

Signed-off-by: Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/usb/chipidea/otg_fsm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
index 2f7f94d..5f8f5d2 100644
--- a/drivers/usb/chipidea/otg_fsm.c
+++ b/drivers/usb/chipidea/otg_fsm.c
@@ -472,7 +472,8 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
 			}
 		}
 
-		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
+		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL &&
+		    ci->usb_phy && ci->usb_phy->set_vbus)
 			ci->usb_phy->set_vbus(ci->usb_phy, 1);
 
 		/* Disable data pulse irq */
@@ -484,7 +485,8 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
 		if (ci->platdata->reg_vbus)
 			regulator_disable(ci->platdata->reg_vbus);
 
-		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
+		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL &&
+		    ci->usb_phy && ci->usb_phy->set_vbus)
 			ci->usb_phy->set_vbus(ci->usb_phy, 0);
 
 		fsm->a_bus_drop = 1;
-- 
2.1.1

