Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E28D40920B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 16:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245059AbhIMOHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 10:07:30 -0400
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com ([40.107.237.48]:32224
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244194AbhIMOCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 10:02:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+nQIe7uiv94vrBP8rKtc3vC94FfIFNdhtfUJXT6RvoX7SRqBtzO/5o3dXPEBFB4MkDu+3lyaDv3N3AWhSyNRqK0QLT2FQFBsqurEz3ybaT/gnX4qEY3lQDcmdU8RAGk9wI8rs/fpyq1ykDdVig4Y9M3Xn4XPzHGjvdV3HQAzpzAXV5FXmItKN6mjoMF0UPVVTiRz0Lp3nQU8X6Vo5sajfJnMLrHDYXrzN31k9c34f5aPYptXO6aBprV5UTI7uJedzgufYCPZPRk351PC1l1nC53SciC5x3FJ2hMp9PLuvPK8GFs3z2IGCZ07JJ1iGxv6GW3j3mYh8J32vLXe1KeHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1QtDZZVfI2xe+P/PAB8QvRsM2X1mZuFZ2JcGrajtYV4=;
 b=jSMf5fP9aFiUpsnTKW1ynHuOtmXKMOzjS50cEvBmgEI0o0z7hyNBgYKPM8rv06/fqNJI1cGmvKDiaufqN+SSnmC9HL91ZPGFri2m7+LXrHIxtTe68+KjOBID9puRgfdO4BrKuw2EdjUYoMH6MpgsHFKXsN9d3/7o2Zcsn6NZBFRKMJsh4L1oiP61O2A2cXMgzpvq4ARuDG0KZeA37uIBMpi5opkZKEfpcNcyGdnTctbtvHMPijgAyg2/xDBnWuaNg8dBtpLO30qTaOxRy0jHdOEdffxm2DVHz57ETuz4QJrW7lcRuio8lHEafOIWh5U6W0BCy76VV7Mt3lqEta53fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QtDZZVfI2xe+P/PAB8QvRsM2X1mZuFZ2JcGrajtYV4=;
 b=b4j5Y4vaQGtKEQIHJnrEk0bZbmb5p2kmi7VxyaaeUUXf6ZSnODZNkpNi9UI0BWwxnCLuq7zcMP7TiJyfD2WJR4mgKK3DubBfFiGuy+l5/RA2RwllDtE+zQJ9XGxZcTp7iOL8+oCjNSwWYAgeftCp1AYI3q3QHZG5TOpSu5K15+Q=
Received: from SA9PR10CA0009.namprd10.prod.outlook.com (2603:10b6:806:a7::14)
 by MWHPR02MB3215.namprd02.prod.outlook.com (2603:10b6:301:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 14:00:47 +0000
Received: from SN1NAM02FT0030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:a7:cafe::bb) by SA9PR10CA0009.outlook.office365.com
 (2603:10b6:806:a7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 14:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0030.mail.protection.outlook.com (10.97.5.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 14:00:47 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Sep 2021 07:00:15 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 13 Sep 2021 07:00:15 -0700
Envelope-to: git@xilinx.com,
 peter.chen@kernel.org,
 gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.35] (port=46162 helo=xhdsaipava40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1mPmVJ-0005co-DL; Mon, 13 Sep 2021 07:00:13 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <sgoud@xilinx.com>, <michal.simek@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH V2] usb: chipidea: udc: make controller hardware endpoint primed
Date:   Mon, 13 Sep 2021 19:30:05 +0530
Message-ID: <20210913140005.955699-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96fdf1fc-95e5-43a6-f43f-08d976bee306
X-MS-TrafficTypeDiagnostic: MWHPR02MB3215:
X-Microsoft-Antispam-PRVS: <MWHPR02MB3215B1E9AA63D25003950615D4D99@MWHPR02MB3215.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGd95ZTxv3jXYLQifRGrVMEHHt60exj/A7lsE7uXBxaRsZubfM5NeBEsDSHPO7Th5jXA8yZb9IxDJE46+Nj1g30jaht9dGMHjpVWBv7JRsIKEyfgIhSZbA6U38Hy/A5DMHcrLUj6c1Wxi2UV1/DCGyt6i7Xf10B8tgFZHLJ+WW14h27t8ue3t1BNReY2tc+mEmeAsHIaD9Ku4mKCuZILqdAf//MCdoUr1DM29E7N+0XxsFApzPnG/NVvOjo3Bfiaszg4mhaWsM3Cbs3cqDjM25y3A+KQrtgvHLLQDHSjo1oGIwFCOfECrV8SvCniJdoaVfs3/XY2+Vz7RIGYpVtMkAYc4+fmeMzVz1hCuQb7FuBftvBjvmkjqVd0acocYzCTa7/x6eMjkXCrqW+YPc3ggWEqcJdD/10WmOIfSM57DxUK7AwyJDVl9smkT3JamoXHHMaOX1dC7Z1NkL/91EB3fsMfsiamlqdLh19WxcyAozer2l/5FB2vdYzJccBCEEyxfHAHL4iLBPRRPuf2HXY/nqiSEh+NJXqXrkX+mUB7A9RsIWqwxdjG3yarsQFEAFkRQ0nv/08rON4DGkwih3EfBzuOgOsImIfo0daii7k3VOam/xkEuBuzewzgAJbwD5RwKk4l4mpd0+i+JI9EW5dFqKcwuOVrQe1Yt3U5ZNzeToq9ZYtJBL7V1tnBN3bu79EkjkqDcc5hUkH0pkfPQ81yg24BygcJvJ5IfjMs/dxBguvfcX+YtDwGvBEqROkydgix39vYUcGKSvbo+McQ0/rUGvHY/SY5pjnBPLmegl962DRAWZfludZ9shVXqOgfdy4s
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(36840700001)(46966006)(8936002)(26005)(83380400001)(186003)(478600001)(2616005)(336012)(44832011)(45080400002)(7696005)(82310400003)(5660300002)(426003)(8676002)(9786002)(54906003)(110136005)(47076005)(356005)(36756003)(107886003)(2906002)(4326008)(7636003)(1076003)(70586007)(70206006)(82740400003)(316002)(6666004)(36906005)(966005)(36860700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 14:00:47.3573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fdf1fc-95e5-43a6-f43f-08d976bee306
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0030.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3215
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

Added conditional revision check of 2.20[CI_REVISION_22].

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
Changes for V2:
- Addressed Peter review comments - Remove unrelated new-line
- Updated commit message

Link: https://lore.kernel.org/linux-usb/SJ0PR02MB8644CBBA848A0F68323F1AA5D4D99@SJ0PR02MB8644.namprd02.prod.outlook.com/
---
 drivers/usb/chipidea/udc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 8834ca6..f9ca501 100644
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
@@ -599,6 +601,12 @@ static int _hardware_enqueue(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq)
 
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
 		do {
-- 
2.7.4

