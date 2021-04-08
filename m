Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388B7358BBF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhDHRzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:55:08 -0400
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com ([40.107.223.63]:59456
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231676AbhDHRzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:55:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVZF/Y2rIV7ps0Wvf+2YQOfmEW8sAVvERP+Ffpy5F9EALX+C7QiQR6MlVJeduDq5FgUeWF3HyepPasZ7VV7DiuGuBhxapt0riWwOdjJo+uwLGdeE9QERTlf3ySTlsTaHHXQK6AK0vM265M+52tke5etzqu+RYEPr7dFG341el/aX7Qul+KXzmmMw0PzqXNx+MEi39RS7oNjYv7qKcd1Izf4+b5SzSe4Q/f084IRtYPKgZBYg/PBZTLi/xC3i75nUWRsgMuEXHj+ZosyKc/SHyBBHRCJoh7c5f0aEPsqWjrpoWYW56hlT7SYsbMrpoKR1ApfKYvhW6oor7h5lawlcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtJgc4drPnHtAFZUQWQvtsu8PBmkm4Yj3FUOwq+uw24=;
 b=ftelx9XY7IRsP4azUtKSg9SpjDm0BRu2Etnr/62DHmzKVclXemiU/YrWBi6TGBybkK4aGlgBHrBCogBaZLeunYfDpMrrHSkc70iJ+OTRVFaxCQfMC2TawoVUUI3SfkPizN66DPIzrtQKiadnuiQa3ZK2jyiXAETgYEYdDdXiDYFXnHWYkaTrgnhzDTDQKGqiYug1aS8pyHa20S+BNHuR60llnlgUYNklC0pYYjGJJnzVP8OFUUC+YZiqFjfegHGRvhjTFOfqN6pQMK3anr7VL0hbfWb64naE2Uhmm2SN2wH64lLTzOu/IZUZcRI2ycqiJGm0U8kxs2t6HmPlHA9R7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtJgc4drPnHtAFZUQWQvtsu8PBmkm4Yj3FUOwq+uw24=;
 b=nPwG8FY9da9xpAZgs3uX0QiaasTHBvX/VcuMiVuGaYvUsZ79RFApmhKWqsKtrLSSWYHlFbCYLxCMbk+tUmozYKGgrK1T96U0XqJ3znYq3HrWWEhxO4rSJjtwb6jXJTNmLrcbw87pDZi8af51z/1GD7g0uA4p0nQ2sfD5ys8QPDM=
Received: from BL0PR01CA0023.prod.exchangelabs.com (2603:10b6:208:71::36) by
 CH2PR02MB6168.namprd02.prod.outlook.com (2603:10b6:610:a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17; Thu, 8 Apr 2021 17:54:53 +0000
Received: from BL2NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:71:cafe::53) by BL0PR01CA0023.outlook.office365.com
 (2603:10b6:208:71::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Thu, 8 Apr 2021 17:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT019.mail.protection.outlook.com (10.152.77.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 17:54:53 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 10:54:34 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Thu, 8 Apr 2021 10:54:34 -0700
Envelope-to: git@xilinx.com,
 balbi@kernel.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.106] (port=38715 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lUYrR-0002iP-35; Thu, 08 Apr 2021 10:54:33 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id D7BE212123D; Thu,  8 Apr 2021 23:24:22 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <michal.simek@xilinx.com>,
        <balbi@kernel.org>
CC:     <git@xilinx.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 1/2] usb: dwc3: Resolve kernel-doc warning for Xilinx DWC3 driver
Date:   Thu, 8 Apr 2021 23:24:07 +0530
Message-ID: <1617904448-74611-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1617904448-74611-1-git-send-email-manish.narani@xilinx.com>
References: <1617904448-74611-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 837e1236-a659-494e-a9d0-08d8fab769c1
X-MS-TrafficTypeDiagnostic: CH2PR02MB6168:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6168848B15F1A4E45C2125ACC1749@CH2PR02MB6168.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GRBdkHdUUgqNrcBqq7t2rW6/pbEGV1/coNdqxzuBT8JCbR5c8RwPpSrz+s9KZ+sbhdxRVXoR5ZPvtM6gEm/b7Qn8BVmpjdJAMZkAMVxAEZlyc+fRR/BrvJgap/13WZ4YJxjaf8DZ+wEvCIGtVSyUBuIs5yo/Lf7rJEAB364Ucaw7aWEDQ6FLotWkJulUraMu1PcvnuTxEH666b8GY85j9cjvBi4GR7v16wNID7I4eHv38jk+tPfKa5RiRkvM91E2h5mptwe0sP1s8h2DMhovU8NiwYSWyQxU7wOqhPPJngayTl8feMa6bRzim+837lYmw4afZt+C5m+wssZmg7WKauR7uG3veVW/XwMQMRIitoOdMPq4er0SWe9JiaiwgPR3NF2i3KPvX+X42gwvgi6mbAX+JF/Ox42pe2N022+y8w0bCqr+3N6G8pscxIoz7AU0Aa6P/UhUBknRPGbuHr0WbohiZVH/RsDgp3Ed9rjLzKd6uOmWu40KALZ/gx+3y0RAK4roHydrM1+7afQJh5hBkqD5zwOV8vsL+FYxwqckPFhJSU/iujKvSBkJWEt8rUbGYM5+tAU/LasnDPA0QRbjppEU1WbxI6GdKDaFTj7ZxOsSrVzDoq1x4yH58Xwfd51Jwwjj2xPhCd7eS/lJ6SnwLcyo2kSIqRtNqLbKcR9ikUTOj0kDC3n4GMQ9ZoUkAGMD
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(46966006)(36840700001)(83380400001)(107886003)(8676002)(478600001)(8936002)(82740400003)(36860700001)(2906002)(2616005)(336012)(426003)(4326008)(44832011)(6266002)(82310400003)(70586007)(36756003)(186003)(26005)(356005)(7636003)(6666004)(5660300002)(70206006)(4744005)(42186006)(110136005)(36906005)(316002)(47076005)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 17:54:53.1786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 837e1236-a659-494e-a9d0-08d8fab769c1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6168
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel-doc run gave a warning for Xilinx DWC3 driver:

drivers/usb/dwc3/dwc3-xilinx.c:27: warning: expecting prototype for
dwc3(). Prototype was for XLNX_USB_PHY_RST_EN() instead

Basically it was due to an extra '*' in line:2. This patch fixes the same.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index a59e149..f42f4cb 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * dwc3-xilinx.c - Xilinx DWC3 controller specific glue driver
  *
  * Authors: Manish Narani <manish.narani@xilinx.com>
-- 
2.1.1

