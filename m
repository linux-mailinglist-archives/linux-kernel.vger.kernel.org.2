Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4740E3F661F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhHXRU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:20:29 -0400
Received: from mail-co1nam11on2083.outbound.protection.outlook.com ([40.107.220.83]:34592
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239751AbhHXRR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:17:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfG5/Mm5RCYSW4zVMx8LZT8kkFDXqMeTboDOPejPr39kbYshwjf0Fbj5raErf+3JnhXaShwuwduWNf8OaE/maYEUrysF8aHwWDZO7OBmLcP2tFnS1F2PVIMgD2R3R4flJhlt9DHPSKQLwUFnhCxnC5GWNw/1xB7JdMDfwNrB9facdsIaCK6sJntY43Bm3NX45GlRICL6vqSZPToiGziF926t0afDOoNGV/nswHacirfxtscWMPUJU2YD03hjWICZVf5fSQqKI2DU3/En6Qb087+lfV1DEr2XC+ad4qilurgW17Ex/gxFS9CcBvhClaPV4D47styz2oh34Qnyd+GMmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIRsXvEaD9tuH2VK/N0yvHqxPF6XJQVOZCpAr6m3E30=;
 b=lSiliK8Qvci8+cxXYVqG4h7A/kG0Z3mM7zsNQIQnY03cJya/ITasc/77jjVkodZsKLPCOY1OsXmbtpAn+92HwpVMMlPm1t5tM8Anbtmu0cX7BlmI+tnfG2s3y1sjuPmNu6JqP+d++yRsYNu7/DcJMRpHF6Kf4mJ3Jti151Is+MpZUoMYXOf3gxFn/qKUDBg7eRyvLpNMR3eUPkncRZyqMx+v6NhHAt2Qfu0QQPVUkjEL/ETJf0kcaqtV9Ry78AyWob9Xep2Hm6n4Y3UkNtwyOAAjYuTpmph7rgaemu7KQl0WyGT7QmhQWj69gY6Ic0uUHcZ/reybGfhg+0TQ0snfeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIRsXvEaD9tuH2VK/N0yvHqxPF6XJQVOZCpAr6m3E30=;
 b=ndSqUn5aapHon6qOMjvyDBuvwrJSRHE8y2j3E8ycu6mGurq0TYg+NyrkbCkmqmKyGB1a0UQvHFBOia6EE5WtJPQJzxMhSkL+tM9HD7zyHqoTT0Wypn5T2Pc+jzAsz9FiaOIK8uWrLfdGOB0fgamAW7dlnYR54Vrul54J9R8CASo=
Received: from BN9PR03CA0556.namprd03.prod.outlook.com (2603:10b6:408:138::21)
 by SA1PR02MB8477.namprd02.prod.outlook.com (2603:10b6:806:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 17:17:11 +0000
Received: from BN1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::c5) by BN9PR03CA0556.outlook.office365.com
 (2603:10b6:408:138::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 17:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT039.mail.protection.outlook.com (10.13.2.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 17:17:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 10:16:40 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 10:16:40 -0700
Envelope-to: git@xilinx.com,
 peter.chen@kernel.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.8] (port=48475 helo=xhdvnc108.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1mIa2R-00004w-4f; Tue, 24 Aug 2021 10:16:39 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 16987)
        id 37CED604AC; Tue, 24 Aug 2021 22:46:30 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Manish Narani <manish.narani@xilinx.com>,
        "Subbaraya Sundeep Bhatta" <sbhatta@xilinx.com>
Subject: [PATCH 1/6] usb: chipidea: Add support for VBUS control with PHY
Date:   Tue, 24 Aug 2021 22:46:13 +0530
Message-ID: <1629825378-8089-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
References: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53f3cdc5-e229-442c-15cc-08d9672302b5
X-MS-TrafficTypeDiagnostic: SA1PR02MB8477:
X-Microsoft-Antispam-PRVS: <SA1PR02MB8477CF9BC1E7111A58AF7C8AC1C59@SA1PR02MB8477.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApskRnLdmi+dhj1LskUYl9FcXNnoIFKsKrcWBcUnpaBugwlvOec/BQvO4A8bE1D9Za39ASJq2LVhKBHGyqRD5GeHzul66mA42bHTMWw4zP2uq6dZ4Ho8oRRnxPyKGoquv/+aswJpOoTI9RwzMny/0WKWOCIqeDYF221zJfTUYJfZv1wGGex+nNBlvSPBMW03Wpbuk5qHkViJzo0Ni+cD0uijDUBB1M0mdeccrPQW/3XZFaBSlJtt33HCMQSqRUyX2hViOYpe0d39dIZSCWWyA9OveWtTtZr0LZOs5p0RpoScJgIng8uSM4z678mTsAaaLXCp+CxSZEH1Rc5AFJa3c0SwEOKZGnv/L2lCXwZig24ehyOB/ejU2stzYeIg9bJTGFPqZOiIztRa8DTt0gImZdMJSKOg0PffCBTW3fD6hB/c+qSnOChToHLR3iZ9rHn6yhUi57qAcV+brEbDncNEsRv4wFryy87sxa89GBP5zqWjlvglg2QPuEmYMu7AgDce7h28vbd096OPFcxTiEbvEtlruyaYnOHVUnoRXrpu+5QmiKmC6Q4KGx6eG/FpLkcsKVEdwuXUs9ysttEwdSm7wTvAebdtklk7Y53hp96APiKrN1qIoZka9SP4XZPo/eOP8pTqDbfym50jIakyy+EznS+hDpswndH0V1mTnj5T6tLYUodKZBAe30IF2Po56SGX1XllxDBVjbsLxGogiYJPkjgjBhaypGLfgHHDL/Vdbtw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(46966006)(36840700001)(36756003)(36906005)(26005)(47076005)(8936002)(107886003)(110136005)(82740400003)(478600001)(7636003)(186003)(6266002)(44832011)(6666004)(356005)(36860700001)(316002)(70206006)(70586007)(42186006)(2616005)(82310400003)(426003)(336012)(6636002)(2906002)(8676002)(4326008)(5660300002)(83380400001)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 17:17:11.5254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f3cdc5-e229-442c-15cc-08d9672302b5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT039.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8477
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms make use of VBUS control over PHY which
means controller driver has to access PHY registers to
turn on/off VBUS line.This patch adds support for
such platforms in chipidea.

Signed-off-by: Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/usb/chipidea/ci_hdrc_usb2.c | 1 +
 drivers/usb/chipidea/host.c         | 9 +++++++++
 drivers/usb/chipidea/otg_fsm.c      | 7 +++++++
 include/linux/usb/chipidea.h        | 1 +
 4 files changed, 18 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_usb2.c b/drivers/usb/chipidea/ci_hdrc_usb2.c
index 89e1d82..dc86b12 100644
--- a/drivers/usb/chipidea/ci_hdrc_usb2.c
+++ b/drivers/usb/chipidea/ci_hdrc_usb2.c
@@ -30,6 +30,7 @@ static const struct ci_hdrc_platform_data ci_default_pdata = {
 
 static const struct ci_hdrc_platform_data ci_zynq_pdata = {
 	.capoffset	= DEF_CAPOFFSET,
+	.flags          = CI_HDRC_PHY_VBUS_CONTROL,
 };
 
 static const struct ci_hdrc_platform_data ci_zevio_pdata = {
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index e86d13c..578968d 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -63,6 +63,14 @@ static int ehci_ci_portpower(struct usb_hcd *hcd, int portnum, bool enable)
 		priv->enabled = enable;
 	}
 
+	if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL &&
+	    ci->usb_phy && ci->usb_phy->set_vbus) {
+		if (enable)
+			ci->usb_phy->set_vbus(ci->usb_phy, 1);
+		else
+			ci->usb_phy->set_vbus(ci->usb_phy, 0);
+	}
+
 	if (enable && (ci->platdata->phy_mode == USBPHY_INTERFACE_MODE_HSIC)) {
 		/*
 		 * Marvell 28nm HSIC PHY requires forcing the port to HS mode.
@@ -71,6 +79,7 @@ static int ehci_ci_portpower(struct usb_hcd *hcd, int portnum, bool enable)
 		hw_port_test_set(ci, 5);
 		hw_port_test_set(ci, 0);
 	}
+
 	return 0;
 };
 
diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
index 6ed4b00..2f7f94d 100644
--- a/drivers/usb/chipidea/otg_fsm.c
+++ b/drivers/usb/chipidea/otg_fsm.c
@@ -471,6 +471,10 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
 				return;
 			}
 		}
+
+		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
+			ci->usb_phy->set_vbus(ci->usb_phy, 1);
+
 		/* Disable data pulse irq */
 		hw_write_otgsc(ci, OTGSC_DPIE, 0);
 
@@ -480,6 +484,9 @@ static void ci_otg_drv_vbus(struct otg_fsm *fsm, int on)
 		if (ci->platdata->reg_vbus)
 			regulator_disable(ci->platdata->reg_vbus);
 
+		if (ci->platdata->flags & CI_HDRC_PHY_VBUS_CONTROL)
+			ci->usb_phy->set_vbus(ci->usb_phy, 0);
+
 		fsm->a_bus_drop = 1;
 		fsm->a_bus_req = 0;
 	}
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index edf3342..ee38835 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -62,6 +62,7 @@ struct ci_hdrc_platform_data {
 #define CI_HDRC_REQUIRES_ALIGNED_DMA	BIT(13)
 #define CI_HDRC_IMX_IS_HSIC		BIT(14)
 #define CI_HDRC_PMQOS			BIT(15)
+#define CI_HDRC_PHY_VBUS_CONTROL	BIT(16)
 	enum usb_dr_mode	dr_mode;
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
-- 
2.1.1

