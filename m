Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4FE3F662C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbhHXRVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:21:21 -0400
Received: from mail-bn8nam11on2048.outbound.protection.outlook.com ([40.107.236.48]:38112
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240011AbhHXRSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:18:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJ2j9NIp5gboc5DVWQEW6ZZJAa178N3AmyN0NPpj8nkpU/gys9siYpGpNUjnsanlGOCuWpzJHO2WJv65w/uTqRwba2pXEPBqLnJWl5/ecHF67W0Nof0rJMfaA4iHj4fVk/DJJEPBfJD8JuGYC98UXjx/hJcI3vlvqnaYqekPPcnvyO4kdMBRpZkOeyuBf/53grb89nBMFZXSwQg8pwUKrJymfnAfSeT6ZEj+o6HNN6trP80qnXdkCBOR6oYGqxwHeds7s4DzDg7EAvaj5l1WNNugJ7LA4/uxpPh9tcNGeuXxMWPn3/dSOQBT5497O3Xuh7nAuE5Y/cEjOsNKXINW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7knTfQSDfMufJP+ojSC1wtxOeUxx+4Rdvq6I68xMd0k=;
 b=VxD8pOlB7KW+vxBnom2vSmtAOziTmKIzBZtS4PS9KBSUtHY3r3teXBYVM76am8TUYxQyNAUXtWSt1I+NRs6cEnQUk9vW5Z/oq1zLFv58m59coZiy54z2Uzx0SH/YISXHWkRrPbLZ3ZMShj/g4UisKIbxi4/tSfR3CUFTRFFTQunG/D1ka9fvj/a5bd3+yCCpfx1TDWV+4LJspjiqUy80WvFdT0S1Q7onNUadyLPkO0uWXcg2NPRE3+pOqF9xvXtPsUS9kMWznm1zRhGiFUa6ONDH0t2dRoxQwjPnn6fGpAwOMjIYKV8kIJC+vLN339wmsNfOa9zfKgrcY2BiOWQzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7knTfQSDfMufJP+ojSC1wtxOeUxx+4Rdvq6I68xMd0k=;
 b=n5JAf4QbEWP1rYEbqClsyXiQJOA5hABZbCkFAJupM24QMBXKEr7e6aRtd4MZzGARS4uB/8CR3lX+eX//A3+iHAY9xyRgmRn9WosfSRmom8YPX7WxROIxvCOj36UzUZh6SukTK0T9BDroA78e/JTDgMhbbUHMXdsip376xpBs6Ys=
Received: from DM5PR15CA0049.namprd15.prod.outlook.com (2603:10b6:3:ae::11) by
 BN6PR02MB3315.namprd02.prod.outlook.com (2603:10b6:405:68::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.23; Tue, 24 Aug 2021 17:17:47 +0000
Received: from DM3NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::8b) by DM5PR15CA0049.outlook.office365.com
 (2603:10b6:3:ae::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 24 Aug 2021 17:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT043.mail.protection.outlook.com (10.13.4.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 17:17:47 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 10:17:45 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 10:17:45 -0700
Envelope-to: git@xilinx.com,
 peter.chen@kernel.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.8] (port=48488 helo=xhdvnc108.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1mIa3U-0000Q5-Ik; Tue, 24 Aug 2021 10:17:44 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 16987)
        id 61AA660546; Tue, 24 Aug 2021 22:46:38 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Piyush Mehta <piyush.mehta@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 6/6] usb: chipidea: udc: Add xilinx revision support
Date:   Tue, 24 Aug 2021 22:46:18 +0530
Message-ID: <1629825378-8089-7-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
References: <1629825378-8089-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d05b435-1beb-4e01-912a-08d967231802
X-MS-TrafficTypeDiagnostic: BN6PR02MB3315:
X-Microsoft-Antispam-PRVS: <BN6PR02MB33157E0ACE542FA89E433AB0C1C59@BN6PR02MB3315.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txjzeAXG27GBNya055fTLhmGCJc9bhW9Cn/dc9R9MKyqCFpBD+S6x4C8lMzMl2pw1S40DbGtWQcVIygFbHBzcQD/afEpwlnheqyWw7dQp9cBTQaZ63Uzfa3rWqDrOYz2q9cu6XpPl/u8MaI/LN2QBP3fpbJI7OJjG3nl0zr3J55SWedMrYTfD/M+kCR51W1UaxF7sSw0GSgRuwWWbi2KidBsjlOr5vS7N5pm7ozoXcrqQxODB0t00OSbJlr5IC0KMEgvBCostg6s63Snf6ZTeF1EczVmmcs8nZNFWnu92PZ1UhQDGb5xDGxnsmfu2UAGp5N/i+qqoOrYF86N8cSnX7BC+d7xOa6h7WT+aE0+ATiwQtvoGnI1q/ecivU+8cyOSjymumwlqkTMuOxVDfJu18FnQ+58bh7zQYFswDLa4rMsLFh7fHbNaU5J4JKMwiq6oTKUirItUfKyaaVdn5eI6T+D7ouj96SlKKcTQDYODKGR7Ej92aHafbG2MtMGdOf09ySKFteZH7Qe6ybhRWWVuK9Q2NZonNkj2BbdU163hipHF82rmJaIK/xaDOpKVHtBqTtgAyj3Ups+KNFwrqZLYyJ69xI2BtSnGVqqMj1d0oSIZRXg8rdRvw2o41bS6OCxs1kKKofHLU0FL5l/eWCGg3dgodzuymISJ+tITs3ifPhF0EpV/69g9Zl/z5tGWi81rnU2AcvLFmUmyLttsupjnLBpQ5VoEJumK1LuZqhYo4w=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(336012)(5660300002)(186003)(36860700001)(426003)(44832011)(36756003)(8936002)(356005)(107886003)(110136005)(47076005)(2616005)(42186006)(70586007)(316002)(6266002)(6666004)(8676002)(70206006)(36906005)(54906003)(83380400001)(6636002)(82310400003)(7636003)(26005)(508600001)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 17:17:47.3053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d05b435-1beb-4e01-912a-08d967231802
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT043.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3315
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piyush Mehta <piyush.mehta@xilinx.com>

Issue: Adding a dTD to a Primed Endpoint May Not Get Recognized with
revision 2.20a.

There is an issue with the add dTD tripwire semaphore (ATDTW bit in
USBCMD register) that can cause the controller to ignore a dTD that is
added to a primed endpoint. When this happens, the software can read
the tripwire bit and the status bit at '1' even though the endpoint is
unprimed.
This issue observed with the Windows host machine.

Workaround:
The software must implement a periodic cycle, and check for each dTD
pending on execution (Active = 1), if the endpoint is primed. It can do
this by reading the corresponding bits in the ENDPTPRIME and ENDPTSTAT
registers. If these bits are read at 0, the software needs to re-prime
the endpoint by writing 1 to the corresponding bit in the ENDPTPRIME
register.

Added conditional revision check of 2.20[CI_REVISION_22] along with 2.40.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/usb/chipidea/udc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 8834ca6..b440205 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -680,7 +680,8 @@ static int _hardware_dequeue(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq)
 		if ((TD_STATUS_ACTIVE & tmptoken) != 0) {
 			int n = hw_ep_bit(hwep->num, hwep->dir);
 
-			if (ci->rev == CI_REVISION_24)
+			if (ci->rev == CI_REVISION_24 ||
+			    ci->rev == CI_REVISION_22)
 				if (!hw_read(ci, OP_ENDPTSTAT, BIT(n)))
 					reprime_dtd(ci, hwep, node);
 			hwreq->req.status = -EALREADY;
-- 
2.1.1

