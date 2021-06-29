Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BD93B703A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhF2JoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:44:03 -0400
Received: from mail-mw2nam12on2057.outbound.protection.outlook.com ([40.107.244.57]:55841
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232929AbhF2Jn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:43:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUKhz2lulfoTI2XLX01Cm49RRg6TT6o76Vy5bvGui8pNIOpz1SCp8hNYVlIZewxFGOQlANjEPzfjG1kHfxi98L9aCrKHca90AMBGODEfRpq3YemywckfccTJDXqHa/j3/8VeHVfeRPmZBRL5/EbasxsiJSrMlTecdb56Ef6zujE75sRkhvYb1aA6Qcxn6KsJGjanzy4peXSXNFCVX8uJquZBuup78yh8Lj0mFr3f1II3ZPz18275sW+v1vWAtnP0Xzz7JqWR2pUlZBZDTUXwDImqOwpIsxsFzuVY8sHpLECla9uXa5tCCBVKRgyj2LpLAOi/jHmEiFkxgdAlR3+R8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Bg/QQ+pvABWS91zzxrOezwGTu2ohzYofB07oOyazQc=;
 b=bXtlvmbnPoteqUZ0iLSToDqLtby0fcaHyv2W4l7WvwbxLPZZ0zSIV0sNJxORkawLeNeEJVO+5DqSmMtBQbQVNas7xiqTJVfsF/15/+sdXZ4Db53pc/Swyo0ml++yGse6ZNyfhmuxwutCJvPjtXVROQI1rB+uyWtZrUpaZMsBJNOvhFcU7BDKjpnHKY1w96C7Z5NK3bjZDxy88ne1c0cTF8nZnbQ516fD9iSR6NQNUs0sSZrOa9+T7zp+GDMyu0seJ+B03vjbcfOcIexUj94cN6u80KRphS9y0eoo/yIkytMzeBSMx2n8BMB++fQVWpPAXnHYQqaYQuQUgL7YgsgEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Bg/QQ+pvABWS91zzxrOezwGTu2ohzYofB07oOyazQc=;
 b=sj8VVx62IOQd/qlE4cWuGvQhJHswofifG+E2EMNYYwcc5U7C3kDYX9/g8elA1vlfUMu8Hbzb8pRgYY4MC8o/CzaC9e6mnw7i+QFOQCm7q5RQIsEv/fokczKnRHOhAhVSi6jLy5hG24AuwdvcdlghqQ50UoB5LYtF5PXGDnFPqyk=
Received: from SN4PR0801CA0017.namprd08.prod.outlook.com
 (2603:10b6:803:29::27) by SN6PR02MB5295.namprd02.prod.outlook.com
 (2603:10b6:805:67::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 09:41:08 +0000
Received: from SN1NAM02FT0011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:29:cafe::dd) by SN4PR0801CA0017.outlook.office365.com
 (2603:10b6:803:29::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Tue, 29 Jun 2021 09:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0011.mail.protection.outlook.com (10.97.5.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 09:41:08 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 02:40:55 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 29 Jun 2021 02:40:55 -0700
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
        id 1lyAEZ-0005yU-Mp; Tue, 29 Jun 2021 02:40:48 -0700
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
Subject: [PATCH 1/3] include: dt-bindings: Add mscc-vsc8531 RGMII clock delay definitions
Date:   Tue, 29 Jun 2021 15:10:36 +0530
Message-ID: <20210629094038.18610-2-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210629094038.18610-1-harini.katakam@xilinx.com>
References: <20210629094038.18610-1-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba11c726-31a9-45cc-2022-08d93ae205e1
X-MS-TrafficTypeDiagnostic: SN6PR02MB5295:
X-Microsoft-Antispam-PRVS: <SN6PR02MB529598BAC00B497985BB0190C9029@SN6PR02MB5295.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:269;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GaAMIEIM3Wk2hsQ2Zy/oLCTtaXigTiPQ+pC5nfgOJqRcWn4pyJ2YLqSN55ACNSpB+rXPqffm2n7pw3/LXs+jZ8ouwBH6TWF8Ca0MMcqLPde6kcMhJ77AgQQyy0bPaPQ2I409CMc/2MTYXfX4uYcRlm2dzd+aP8T6VEWTvSZoSUBhq2FRGPt89Tg4vtC8EsIlLkvm7GehGm3IBcCd1HA4MyD+zIbGRp9qiCh116Q+IOPsfjojWlgJgN/E/Bxej4Zl2+SyzGHP1kAsSfhTqlJEfDSClIuvnPA5LaVtWdfIy+PPmRm7Yfbek/3SSLIan9UUQbjPMtAhMZFgLw7BFZS3QqLfsocZ5lRnhuLrdZfbJBZFKgTBXSeXIUck1DSWdYTchMszooeFJwbcloMMkHtvj9VKTclSaATUV7nwRWd31qIA6KKvpBkx9moTEv7YvzddT1vzaRB0tz8gwWtJOVnGAGrUCheLoT1nbaHG2Jck2PeBi0AAFDWFQBv2dRcDVstAd2C7DXtlcyjbLidvGO3KuXtlFP6pNzVli/0MDJsmQFCVqpAWKdR5u8MYHbgc95LLJda2e5edP2TeJkWfZzRam9VnFLUt5EsfYQTwLfybBMdNzzu7EbpGksWUeDjzxKgnNHtG8qG9JuFfOKJKgOC68qcRIMxABk/R1kNl/vIIN1gGUo9+Cy/pKdTcDnaB4xrp101eeaDhuVq17Lu/P61qEISOzLW9WWmd7CTmT3CHkclnemOUNPQ7X/0+dsQ0cPa8
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(136003)(376002)(36840700001)(46966006)(70586007)(47076005)(7696005)(5660300002)(110136005)(8676002)(44832011)(83380400001)(70206006)(4326008)(8936002)(478600001)(82310400003)(336012)(36860700001)(186003)(54906003)(82740400003)(2616005)(7636003)(36756003)(36906005)(6666004)(9786002)(426003)(7416002)(316002)(7049001)(921005)(356005)(107886003)(1076003)(2906002)(26005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 09:41:08.4485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba11c726-31a9-45cc-2022-08d93ae205e1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5295
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RGMII clock delay definitions in mscc-phy-vsc8531 header.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 include/dt-bindings/net/mscc-phy-vsc8531.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/dt-bindings/net/mscc-phy-vsc8531.h b/include/dt-bindings/net/mscc-phy-vsc8531.h
index 9eb2ec2b2ea9..242eb4c7ede9 100644
--- a/include/dt-bindings/net/mscc-phy-vsc8531.h
+++ b/include/dt-bindings/net/mscc-phy-vsc8531.h
@@ -28,4 +28,13 @@
 #define VSC8531_FORCE_LED_OFF           14
 #define VSC8531_FORCE_LED_ON            15
 
+#define VSC8531_RGMII_CLK_DELAY_0_2_NS	0
+#define VSC8531_RGMII_CLK_DELAY_0_8_NS	1
+#define VSC8531_RGMII_CLK_DELAY_1_1_NS	2
+#define VSC8531_RGMII_CLK_DELAY_1_7_NS	3
+#define VSC8531_RGMII_CLK_DELAY_2_0_NS	4
+#define VSC8531_RGMII_CLK_DELAY_2_3_NS	5
+#define VSC8531_RGMII_CLK_DELAY_2_6_NS	6
+#define VSC8531_RGMII_CLK_DELAY_3_4_NS	7
+
 #endif
-- 
2.17.1

