Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CAB3B7033
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhF2Jn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:43:27 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:1377
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232850AbhF2JnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:43:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dc4I0McUfZQf0sZw/PEXSlgDLmnqfAZxTt5gdXDAx8bZt0qUZEbY+C3a1jRO78KlY3c7k9PUiYZ2KLesBHnOO+vGDIdqe5dHVxtOdH4uh8OyIhoJ3kcFCoza7WH7LCg99UGqM6jHHSol2A7pYqL97rkcCrMD5TVcc7BLhRmovVw2Z7IGu8ujirjaD2gcf/8WxWMLe0jqKdV/5N6WFfu/AqL7GQpP9kvi3okLcEF3KRtYptl45BCaQSo3qYVcFUIazcbEMNp45jdTwQ0fy3sI+SbQ6LLdVB1ePFoF2D9LJjqz624M37Diubql7ufIJT/XVACLdFLicsE63w+btKRLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VOJ1Nae0Hw6OPZYBOL9GhDHSWJdaDT4XlMEi4oWciU=;
 b=nfYd6K3bGh9OBvNF1nSD9fuLSl4eJ/gbKn5Zc5fKFHUcueaqev7ejXRzPNqmJZ5A85oeVi0+wvpl4wUm3D82r5nBUlqCKIkXhpCboSNujX2OgwO2RBMh/7zOBWmM5mcVWAdqhMm0T2mqAhxy8NJzrFEVob8LSOzB8RNg26SU//EBysZXRO4c82BAn8+rhRx50zG8Db9qbWRT0qvi6RrV/g52m4S7DXOPwiSAvVIQcjhMnq3lZb3E56BO67qYpnLXne46v6riR15uy/HDBH5RV1FufuOi4bH38BXptPX99vXzqNjphH7wvgH6bIQzGTVKF0o4zqzS6UnAKdkNKVNuvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VOJ1Nae0Hw6OPZYBOL9GhDHSWJdaDT4XlMEi4oWciU=;
 b=MVHdib4n70KkGlRBe+pBSKcl9zjZ/FrPKap7u605WZFg8nwy+QbbasrDTzlC0Osa8eyF9lGnZNpYKATe4a/BUvuwD/U/oadg3TfWAWnLxqOMxCDhCTheCMMdE4FwnDzOA2Rw+25jE2fcWyiux7eP8AdqHmnSutRDIp3poRXfnPQ=
Received: from SA0PR12CA0004.namprd12.prod.outlook.com (2603:10b6:806:6f::9)
 by PH0PR02MB7414.namprd02.prod.outlook.com (2603:10b6:510:1f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 09:40:56 +0000
Received: from SN1NAM02FT0037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6f:cafe::4f) by SA0PR12CA0004.outlook.office365.com
 (2603:10b6:806:6f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Tue, 29 Jun 2021 09:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0037.mail.protection.outlook.com (10.97.4.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 09:40:56 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 02:40:52 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 29 Jun 2021 02:40:52 -0700
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
        id 1lyAEV-0005yU-8L; Tue, 29 Jun 2021 02:40:43 -0700
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
Subject: [PATCH 0/3] Add support for VSC8531_02 PHY and DT RGMII tuning
Date:   Tue, 29 Jun 2021 15:10:35 +0530
Message-ID: <20210629094038.18610-1-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0dc995f-295c-4437-4bf6-08d93ae1fec6
X-MS-TrafficTypeDiagnostic: PH0PR02MB7414:
X-Microsoft-Antispam-PRVS: <PH0PR02MB74145AEA84E643A8A5122AFFC9029@PH0PR02MB7414.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0T290Pcffz3Lm3xU+0/02rBhsMElSphhTDX4KsqbxFI8kLgimkql3rvZ6iRl3otnG/jeep46zmIUYbw8K4YoYRJOITT/ITBDy7/+iBCdjZOQLRGH+SJVIcTEs5lKXZ0pvnWNbwPEhnIX+7mHr0O8tgyBCC53DvFeRmVi6RXqIkJrYofaLFmEFcm1A5egFJl5LV52/apZeXycVnVoEaR+J5i2b3tuqsfgKSvKBQ6N3/6MDw44lwV92bR+O0V2jwuHVsQi0LKYBJ3IDbP6Cl11Ev2fmAzJGB65r8tNYXHylk9dkaaVOgafkf581O1t5ZdFiWMzEsmEt5bFOgYADwj/M/zrNvDM0E4XTN1UlFT+a4B+I44FSQGyTqnDqRH9UwO4fJNQgN9b7+ajpPOKi2RmSozkksW0weVn4UGzJvhYSXjnivDQ22G6Pv4SJ8zDa85bJG4t0wM1CN57VPVrkPJVaO/dVHIaBfkmlwNUA625kZ0bJXhqlZe5SzbsesWy6NjIKoJB+RtZUfgGyG5Ds05Q8XQ6W7vnAs8nUWqWvE1fzNeRJuxvvazAmADnGyiFZcOO+3vK5084s/YnYQz0SuEs4dNNu9FoOvVuJBuKB69YbHVUBABXgjjhFpujheJR1GMS9tdFUMfE4BClsqg61OhBPVRYscuP3LbikdSz5iZlZJStwvoabrPeqNqoMu7GZhzQ8rO5jzNfb47vnNVoqwJTfH5QUBvXXWaHPgwLpZ36cPLX1jLZiOm+QHGCH3fgzNT
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(36840700001)(46966006)(82310400003)(82740400003)(7696005)(7049001)(8936002)(9786002)(316002)(36906005)(110136005)(356005)(26005)(36860700001)(107886003)(7636003)(186003)(4744005)(54906003)(83380400001)(4326008)(336012)(8676002)(426003)(70586007)(47076005)(1076003)(7416002)(5660300002)(2906002)(70206006)(2616005)(478600001)(6666004)(44832011)(36756003)(921005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 09:40:56.4537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0dc995f-295c-4437-4bf6-08d93ae1fec6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7414
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for VSC8531_02 PHY ID.
Also provide an option to tune RGMII delay value via devicetree.
The default delays are retained in the driver.

Harini Katakam (3):
  include: dt-bindings: Add mscc-vsc8531 RGMII clock delay definitions
  dt-bindings: mscc: Add RGMII RX and TX delay tuning
  phy: mscc: Add support for VSC8531_02 with RGMII tuning

 .../bindings/net/mscc-phy-vsc8531.txt         |  9 +++-
 drivers/net/phy/mscc/mscc.h                   |  3 ++
 drivers/net/phy/mscc/mscc_main.c              | 41 ++++++++++++++++++-
 include/dt-bindings/net/mscc-phy-vsc8531.h    |  9 ++++
 4 files changed, 59 insertions(+), 3 deletions(-)

-- 
2.17.1

