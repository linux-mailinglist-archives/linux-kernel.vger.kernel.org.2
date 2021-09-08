Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9406B403645
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350396AbhIHIo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:44:59 -0400
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:36224
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348242AbhIHIo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:44:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWEbAW8DAI6G/C3awVQR6AMm8Dnq/IO3lJCkm5YzUqAupnYT6xltnrE/JjEw7l3rscj5ul2xKKQgZC5nHsj6K1kfZy0wZpXSw3rZ2LgPgcre5cABzIBgXkhGPoIqOyI8jkqiliakr+mIOV0CBNmUPstcMUo5cQJv6WTkpN/S58cbP5sACGMT5f9pY4w0V8+xFYRrI8nDx11hqek8Hb+iOuL6r5Pi7/xyeiQuLxIogzneBmv/IX/ZWqcEglLALK0KhDVVdxb9ROLFC9sREFJ/rCrfd2OGn16S1S7X2PoMJQCI+4YmDI2kMqXMIw/4PjoRusuXD6q1QWRbYxL8IlaQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nGPJChtEVUubh6SEJmc7IhlQQJopUJ8lQ7IcrziDvpQ=;
 b=YuBBeNOrHFWq5UENYR5UAz0EKLlf8Qa2yoXdA0ojAT/Z2N4T471tWBypUnZWF3J071dHb8dxL1/RbQAV5lrFKzAoYy+umsboYB0BxjyxRIf5I/e0Wr8NFIEKuynpmYtmComgctN5P2I3LNSHmSBAS2/jteULvbKXLRfrwrli6QOBivr1HkyTrBI4uQ+iALUZXXKzMVEceDvxxsfNmpoXHjgm9juQDGbA09WlvNHRV1+QLyJrCs3wHO4kB9Tv/UsuGLptEkXxis0y8/9MpJTIX8vcY+6qcL8BywA2ZHczxZF++koZOhlDT5kOOiQxFpWjU34sWreQvNPe9AAz1n7Wjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGPJChtEVUubh6SEJmc7IhlQQJopUJ8lQ7IcrziDvpQ=;
 b=UI4EkuENNmZoPtE7RuZugHtWMVOyWhO5foDqzdqRCLm8meFX5wYTQeTWBCzhQZDapzhSk+eRMmVYfnNFH30bp77ZKPT11KCR9/mr0lwc9WCE7CBegisFjN9+hQZUG7t9EZo5KLkzJ30+tEha8QWE39UH0V8CoSbDKX6RclkhpIY=
Received: from DM5PR12CA0017.namprd12.prod.outlook.com (2603:10b6:4:1::27) by
 SN6PR02MB5615.namprd02.prod.outlook.com (2603:10b6:805:ea::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.21; Wed, 8 Sep 2021 08:43:48 +0000
Received: from DM3NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::d) by DM5PR12CA0017.outlook.office365.com
 (2603:10b6:4:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend
 Transport; Wed, 8 Sep 2021 08:43:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT006.mail.protection.outlook.com (10.13.4.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 08:43:48 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 8 Sep 2021 01:43:45 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 8 Sep 2021 01:43:45 -0700
Envelope-to: git@xilinx.com,
 peter.chen@kernel.org,
 gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.35] (port=43544 helo=xhdsaipava40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1mNtBI-0000GD-35; Wed, 08 Sep 2021 01:43:44 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <sgoud@xilinx.com>, <michal.simek@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH] usb: chipidea: udc: make controller hardware endpoint primed
Date:   Wed, 8 Sep 2021 14:13:21 +0530
Message-ID: <20210908084321.375662-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 023a7771-bb5c-4775-ad10-08d972a4c6c5
X-MS-TrafficTypeDiagnostic: SN6PR02MB5615:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5615AE1C0D31967112DDE23FD4D49@SN6PR02MB5615.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRJKUzE23S0P49mzLaKWx5VaBz5XfEMjW/YR65TSzDq4DPgh7Msu10g9dxRfU5clrb9VCpOiKdQxz9XiXvbhOTZks5RrcIReiP4wS4BmlQ7t3WTThHPjdKVT7XI7Fo69Kn0bfmEnhKPScHM9KzmsKNnFaFD9PYeQzyGAp9cg/PW49kC/lxTU49XM8AfgTCJMJzZ8XW669ZKpF4GYqBMNRwP1K5wedmTKtNC9KP11rJUr3/ALqRl1BWs19hl3bQ2xRumSZpyyBTN+gh+s8WM/ikMqmKyfuv1vSZAgD0PjqtqFVkeQVGBUlxoWEKULd1BAlplaRDtbBOAxVYWVN+QRM+DOTUo0YB+F/4VAOBLi29Yhd5Rk2XXn67Cuiu8pmTCplCTWC7ZOAW197ufZk0yoi2fuPgmgkZPzp5phrNzKQD13Y9XfVbymG6+G4cB6Fi5N5irEMjAEZCBWz3iHrNXNr/HdxeC1qQwu8YvUTXVWIa8cUl7bPyAisYvjcmoDzBEzir8vOOhj/ylkktURxGlTIWwYW/+VhmmLq7jia9TSWgrKZed++SDPBkP170j0eOTm9ProFM8YHbdm51jZPvuZ5m8QaVow4l7mqax7pCLy8H//bwpX1cH4XkXGh0fkk50MIUHj0VtFrGVb73YlPTnLu6pWaM5k5YB0qeBi2SGGxACw/jPg7kHqBdxBqbh1q1wzuV/UssOPNAQ1hFFoZp7UQXpxP68OwnuUEHCrBRIFs50=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2616005)(6666004)(186003)(107886003)(70206006)(26005)(1076003)(44832011)(82310400003)(2906002)(36906005)(4326008)(9786002)(426003)(110136005)(8676002)(47076005)(336012)(54906003)(36756003)(8936002)(508600001)(7636003)(36860700001)(356005)(70586007)(5660300002)(7696005)(316002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 08:43:48.3772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 023a7771-bb5c-4775-ad10-08d972a4c6c5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5615
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Root-cause:
There is an issue like endpoint is not recognized as primed, when bus
have more pressure and the add dTD tripwire semaphore (ATDTW bit in
USBCMD register) that can cause the controller to ignore a dTD that is
added to a primed endpoint.
This issue observed with the Windows10 host machine.

Workaround:
The software must implement a periodic cycle, and check for each dTD,
if the endpoint is primed. It can do this by reading the corresponding
bits in the ENDPTPRIME and ENDPTSTAT registers. If these bits are read
at 0, the software needs to re-prime the endpoint by writing 1 to the
corresponding bit in the ENDPTPRIME register.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 drivers/usb/chipidea/udc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 8834ca6..d970f45 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -49,6 +49,8 @@ ctrl_endpt_in_desc = {
 	.wMaxPacketSize  = cpu_to_le16(CTRL_PAYLOAD_MAX),
 };
 
+static int reprime_dtd(struct ci_hdrc *ci, struct ci_hw_ep *hwep,
+		       struct td_node *node);
 /**
  * hw_ep_bit: calculates the bit number
  * @num: endpoint number
@@ -599,8 +601,15 @@ static int _hardware_enqueue(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq)
 
 		prevlastnode->ptr->next = cpu_to_le32(next);
 		wmb();
+
+		if (ci->rev == CI_REVISION_22) {
+			if (!hw_read(ci, OP_ENDPTSTAT, BIT(n)))
+				reprime_dtd(ci, hwep, prevlastnode);
+		}
+
 		if (hw_read(ci, OP_ENDPTPRIME, BIT(n)))
 			goto done;
+
 		do {
 			hw_write(ci, OP_USBCMD, USBCMD_ATDTW, USBCMD_ATDTW);
 			tmp_stat = hw_read(ci, OP_ENDPTSTAT, BIT(n));
-- 
2.7.4

