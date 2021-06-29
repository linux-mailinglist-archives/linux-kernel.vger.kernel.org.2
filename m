Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD873B7035
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhF2Jnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:43:35 -0400
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com ([40.107.94.65]:5536
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232891AbhF2Jnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:43:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5NRWNYzmVIBvl0cy5POBH1WVCDJbcTZxklrFCCwrqVHUiAZpGfmbPIbsqUY99NphTnA4TmujGjykwFC6ctooPV3cZ6lNPLRr6FMBWTg+EIg5F+oILGr5sxXwF7ND2siwJiW3bbfH4GSse+qon34dVcRvANyHeHd60EtAeWDZTcSOajQQEXETlejV1/d4HHf8MOZPZS3TGsx787sK+BWiCM9ghw9KfrBOf4og+pSBiiC13FagYDGr/k0JzJAhQ7N8JivxBsgWXTBNcm9DLdnNE0SWnxZ3+le8YlUNbJ5hhJ8OUTmS63OUWCzfj9G11WemYi5QI7F5MYdIqVvSuKjIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hS6FxFePW86qsriYXwFHB/2HyPy2tg9iR/x7ypRQiM8=;
 b=AJal9AyNMGUukwrzCiyahe42dRN5wzCA+4nmmgAA1mStN5OxLHr8PrGS9OotspcjaQKq+nSp/kW3e2z+b/OIZDkiMIBhmOolvX7KsNXUoTqdq9Xd+HIoVY0+E52VBrNAlol/Ukss1R+P5iSpWbpOE+OyQra6sefLR3+0jat+K22g7I54RLl9cAD+Yp3goX49LC+2IIY5YUKr4NuMJ+721kuy39ItN5pccTckscKIY5jP6gUTcwriGgZbA0Oo/xfNjEcVB1fC2otLww5YtaGdlOYqQMtDnjQg3JIr0nN+YOPRB5A0byYhcAGclGWeeADWvnnbeUcvNoY2eFe1BcpZ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hS6FxFePW86qsriYXwFHB/2HyPy2tg9iR/x7ypRQiM8=;
 b=ciypviEF/lNMGYPTmHz9D5amjwon0w7vH9iHBtK1OgkH7fYful4eHWRlyIbsZH9BYVmHi2PwTxS87xQDMgDTXEE1fL0IOFk4Xh/HQKcCROfK7TcElko6fb4uHiG2wMjgMrFaBZMN18pcJ5lGp3xxpcExSdNNrFdZ0Y7l4/tlPwA=
Received: from SA0PR11CA0097.namprd11.prod.outlook.com (2603:10b6:806:d1::12)
 by BN7PR02MB5201.namprd02.prod.outlook.com (2603:10b6:408:21::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Tue, 29 Jun
 2021 09:41:04 +0000
Received: from SN1NAM02FT0018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d1:cafe::25) by SA0PR11CA0097.outlook.office365.com
 (2603:10b6:806:d1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend
 Transport; Tue, 29 Jun 2021 09:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0018.mail.protection.outlook.com (10.97.5.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 09:41:04 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 02:40:54 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 29 Jun 2021 02:40:54 -0700
Envelope-to: robh+dt@kernel.org,
 andrew@lunn.ch,
 hkallweit1@gmail.com,
 linux@armlinux.org.uk,
 davem@davemloft.net,
 kuba@kernel.org,
 steen.hegelund@microchip.com,
 bjarni.jonasson@microchip.com,
 ioana.ciornei@nxp.com,
 likaige@loongson.cn,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 harinikatakamlinux@gmail.com
Received: from [10.140.6.13] (port=43732 helo=xhdharinik40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1lyAEe-0005yU-5z; Tue, 29 Jun 2021 02:40:52 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <robh+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <davem@davemloft.net>, <kuba@kernel.org>,
        <steen.hegelund@microchip.com>, <bjarni.jonasson@microchip.com>,
        <ioana.ciornei@nxp.com>, <likaige@loongson.cn>,
        <harini.katakam@xilinx.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
        <michal.simek@xilinx.com>, <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 2/3] dt-bindings: mscc: Add RGMII RX and TX delay tuning
Date:   Tue, 29 Jun 2021 15:10:37 +0530
Message-ID: <20210629094038.18610-3-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210629094038.18610-1-harini.katakam@xilinx.com>
References: <20210629094038.18610-1-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abcc3d5a-1006-49f2-a104-08d93ae20377
X-MS-TrafficTypeDiagnostic: BN7PR02MB5201:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5201D120D195A79F02CB7371C9029@BN7PR02MB5201.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTPIvw5vKT6zLGWDtZGUu2sSIHhA2A2oomZGVHEvNQGgDI8Vp86zL+c1iiEg/+hUpPJ01GcBA6kVnmNifsKcuOwsy3/MMmq6CwamPXPQY0W9ORYYnCmAoyFAIzIoSHUCtvO1SdQvniR6OkMKBP6VEf32Z8w5nbsBkHingYceqwIFCV3sQK/vbNHiRAkTsAahaSIXpCdehc/YYChMht4m2C9Luwk1XBwYsj+hXbWUddaVbgD8hZqeUs1DoV7bz5nQUi8l5t9DRtHGzaZ2RDL63f59VPi432MqZN6QPYyH8GOdMmB9YNExOZ78Bl0izW4R65miQvpv5/OCQvrv8bm/5Lvf8e83JtZXdtDWUKufGs145XYVhuFizl5TCQ+Y6iAggIDibQXQfxDeTqltetSAax26mIjW5AvTQ7cX/8cdR5bvK8qnROYuK4pfWE6TmbEJ+i8pN2NBYW7t8dLILEe2u0DYxe49FvQ8bUHkxazuzz3cgjZo6KpLo0FziVC45oiejFrc/w1L3vmkW3IE+qgXCm3vp0UPObL4JPrS6hhu75d013etl3n8jSYwpeWTMYsphCwh/589SjqY3j58xcv3CrbHnwJj6km19tfaw70rCqZyLJskgRNcrIlWHxOVJObvqWuAxDPC6Ho3cGhQw6TurU141e5kyKMVqvSYjFXnCX3c3ixZ0WslcM1iRLvTtjx/wJpOWYeNB4ZuoKN8o/8+DXioV/BXZvYYryxYAgQNyXjN7ergs3w05d7S8ks/KvA4
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(36840700001)(46966006)(8936002)(8676002)(36756003)(44832011)(9786002)(70586007)(7049001)(82310400003)(2616005)(426003)(70206006)(36860700001)(336012)(2906002)(7416002)(7636003)(107886003)(83380400001)(47076005)(6666004)(7696005)(54906003)(478600001)(82740400003)(356005)(186003)(4326008)(26005)(921005)(316002)(5660300002)(36906005)(1076003)(110136005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 09:41:04.4037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abcc3d5a-1006-49f2-a104-08d93ae20377
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5201
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional properties to tune RGMII RX and TX delay.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 .../devicetree/bindings/net/mscc-phy-vsc8531.txt         | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
index 87a27d775d48..e201d24d8e27 100644
--- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
+++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
@@ -33,7 +33,14 @@ Optional properties:
 			  VSC8531_DUPLEX_COLLISION (8).
 - load-save-gpios	: GPIO used for the load/save operation of the PTP
 			  hardware clock (PHC).
-
+- vsc8531,rx-delay	: RGMII RX delay. Allowed values are defined in
+			  "include/dt-bindings/net/mscc-phy-vsc8531.h".
+			  Default value, set by the driver is
+			  VSC8531_RGMII_CLK_DELAY_2_0_NS.
+- vsc8531,tx-delay	: RGMII TX delay. Allowed values are defined in
+			  "include/dt-bindings/net/mscc-phy-vsc8531.h".
+			  Default value, set by the driver is
+			  VSC8531_RGMII_CLK_DELAY_2_0_NS.
 
 Table: 1 - Edge rate change
 ----------------------------------------------------------------|
-- 
2.17.1

