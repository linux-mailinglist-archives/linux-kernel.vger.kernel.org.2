Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307ED3F662B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbhHXRVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:21:07 -0400
Received: from mail-bn8nam11on2052.outbound.protection.outlook.com ([40.107.236.52]:30817
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239504AbhHXRS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:18:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSuOkG0XUTPKhUlnU6zHhHHxQqNDfcGU29KNtloUuw4CmlRKcxK17MOU4UoGB8NgtKI3iN2OYrDCmSifBdBiONY1f5dpIzN+QPqKWXFiGUalidOHjyq/ys3hGfxQFgmcIU7RZzrhvh+4nBxYjewR25CpLAwu1jHPODNkf+d/zBzZYmVuY+i+IeONtMuxG3cs3TG1lPhb0ECEOxK5Bc8NeQyDGiOIOE9xQSqlwTLzVmQc0JLtJL5WcQwqwczdBNxa2w6LKK8GYkzOyo0UjfhGR8cIN+l227CJfLlpEqi75+aJ/03xnzXx1+CRjVp4xuUrptUbHeBhXfD6wwr2lshJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTyg4IEu+LpJiHDbbckPs34+/Yzt10Cuf/+CMBWMYQs=;
 b=ZyCtiX1Nag7YuJAYXVGp/p4Vif0jJ+ndK8zwVH73ErOBwIboRWof1AEmjzHw69j2RuPPYdcXcBltY+Vp1rXceV/qptp9fXCXzVbOLnLOymIy2tg0XkEYcU8HEtdDPESxpWsB/UqcIau/3Z6cy6pBwLAkVT2ssdRB1WxW+p7G9KbmL23JoK7Tu6lP0w4a0c65WAguB4weieJKsaGqNFKM+Pyfni7GhezXKHcsFc+5giWwXne1hZ26aZ2VuofsJm0lcVCiFRPX8PNS9sTOouAKegw9VO2u0aZy1Ae0W+vle2GuiMlVtl5kkXkNQ0R33hYKIAlLVGPSvxEO15+lK88oXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTyg4IEu+LpJiHDbbckPs34+/Yzt10Cuf/+CMBWMYQs=;
 b=OtQqiJITZFcNaxWYKewHaTTslJSFMhuLqsa3kMxCFxhDzji4RCpB4JaBLyFcS93d5JbVCNXM7LpbGHawBgwUS3AKOxk/Ft5QR6qAMR53Szz2ZWIOUZ4IWL+kxGKSWvqNKCCZwzJrNLJb2pORlK9zv4Kxx+edqfXTBMhidBEregg=
Received: from BN9PR03CA0984.namprd03.prod.outlook.com (2603:10b6:408:109::29)
 by DM6PR02MB5690.namprd02.prod.outlook.com (2603:10b6:5:7c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 17:17:40 +0000
Received: from BN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::ca) by BN9PR03CA0984.outlook.office365.com
 (2603:10b6:408:109::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 24 Aug 2021 17:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT026.mail.protection.outlook.com (10.13.2.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 17:17:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 10:17:32 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 10:17:32 -0700
Envelope-to: git@xilinx.com,
 peter.chen@kernel.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.8] (port=48485 helo=xhdvnc108.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1mIa3H-000Efu-Fx; Tue, 24 Aug 2021 10:17:31 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 16987)
        id A207460540; Tue, 24 Aug 2021 22:46:37 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Piyush Mehta <piyush.mehta@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 5/6] usb: chipidea: core: Add return value function check
Date:   Tue, 24 Aug 2021 22:46:17 +0530
Message-ID: <1629825378-8089-6-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
References: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1f04210-074e-4282-2cce-08d9672313d1
X-MS-TrafficTypeDiagnostic: DM6PR02MB5690:
X-Microsoft-Antispam-PRVS: <DM6PR02MB56904AC338F666921FA87DBDC1C59@DM6PR02MB5690.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9p5rLdm8XogQNkP9Q1RxUNh9AEYyicZhgOlG7iC+IrNzfru0Zy3KG1SM9fUKri8IRVKJRb8FVUBMY8cCCcJ9Hp2NRSu0fEgJLra03LpDoI/w9OfsILGyXukg/6pz/k3UeSQafA0jW8PZhYyVoNav0f2xsiK+aPw3GLYODBulfFz8ht7LAQ6MFRFJnmeqU0R86IwLbNnvI4bFXus6xRbTvLQJvARLyXxOz3PZbGo2/zYZ+c6fQBbNpLEyIWjolEUrERzmDI1L1Y/FH0rBBTEktAv0wkURQAfwFw4rFudUXUZcWOpL20BBi+I6/B/Pd1QhvUOOKIqS6po/UZuqDKwgrTR5VDHccbRDAuewTlGOJW8sWX+Ht5oabiyp+BxtkLpSvM0SNuNnY54h/9j0KpPNzwdLDMuMWogTodakcux2BxfDMDAfM8fuHP9lFO9I5YSqB0Af+Um1u+UbKAVx3z1vDLHNjs2ipqBB1aclVnWLccf5oXCdsRv4ArQw79ruF9wutHo30UcCWvysS+ejhEtgJUrH3kdiVD4JtumeM3nsmG1ZaVoak0Z/S9cspmkTWHaEVxTIXa9y1fzLFVcGUEXByWynIcvWVHvIQUGkYA7v+qXLanIHOjnxSNkCSLMdl/p9P2tdg6fxuyaaZQM+IAmQrihJaHUoRf24vP5yMzzA1Q+J6SpV8c6KtatSHJ/36dWE237+IqikoC1ZAxnwVEPtPXzdZCNtpAklyZ/RjLhFykY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8676002)(107886003)(6636002)(8936002)(4326008)(356005)(42186006)(5660300002)(36756003)(70586007)(2906002)(83380400001)(7636003)(47076005)(26005)(44832011)(6266002)(2616005)(426003)(336012)(36860700001)(186003)(70206006)(110136005)(54906003)(82310400003)(6666004)(36906005)(508600001)(316002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 17:17:40.2318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f04210-074e-4282-2cce-08d9672313d1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5690
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piyush Mehta <piyush.mehta@xilinx.com>

Add return value validation for function phy exit and phy power off.

Addresses-Coverity: "USELESS_CALL"
Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/usb/chipidea/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 676346f..37f619e 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -324,7 +324,8 @@ static int _ci_usb_phy_init(struct ci_hdrc *ci)
 
 		ret = phy_power_on(ci->phy);
 		if (ret) {
-			phy_exit(ci->phy);
+			if (phy_exit(ci->phy) < 0)
+				dev_dbg(ci->dev, "phy exit failed\r\n");
 			return ret;
 		}
 	} else {
@@ -341,12 +342,20 @@ static int _ci_usb_phy_init(struct ci_hdrc *ci)
  */
 static void ci_usb_phy_exit(struct ci_hdrc *ci)
 {
+	int ret;
+
 	if (ci->platdata->flags & CI_HDRC_OVERRIDE_PHY_CONTROL)
 		return;
 
 	if (ci->phy) {
-		phy_power_off(ci->phy);
-		phy_exit(ci->phy);
+		ret = phy_power_off(ci->phy);
+		if (ret < 0)
+			dev_dbg(ci->dev, "phy poweroff failed\r\n");
+
+		ret = phy_exit(ci->phy);
+		if (ret < 0)
+			dev_dbg(ci->dev, "phy exit failed\r\n");
+
 	} else {
 		usb_phy_shutdown(ci->usb_phy);
 	}
-- 
2.1.1

