Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353D83B7037
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhF2Jnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:43:47 -0400
Received: from mail-dm3nam07on2044.outbound.protection.outlook.com ([40.107.95.44]:24849
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232877AbhF2Jnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:43:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HacwsYoFlCkLy8/H+jQDZSSjJ8eKdvAN+sOkC8n6U0gesObE7BqVTFmkgux3Tgk1FWWGzY4qpqJdlPRia4qpz/wAD9NxgvFLiRQqaWyROByyKXApKNwZcLq4AVmfdB5DNRXdqbiKB1jgZvWL6wRm/NEpQweV9Lm2+SOkWfYlOHwfjDskKIgoboOBns/MIGRT7e2CSodstjFZjf4C8tL2f+hzriBJOWGB4WSjCv2Lf368Z0I+XLcL7jD23J1jAK5qQ9Xf30YhhtudJk8BdshDj7Z66cSAKj7X85XE5fI/PZD20qeY3Tb25M5aAqThV8+wBPokXdr2uN8zaH4OMViMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iYUU8whUrE2itOIt8Cy11CZR5l3epUQiHiIblwQlyU=;
 b=iPP/UwgON6jflL0yYyIt3D0pD0xU2I1kWtTQ5v/NysA2Vq9h3/YJu9Xjsm4LR6iB8qI8SvyekriTHe8equtG7gC0dvoky6i1hDZSGb3cxQHBBVCMl9vCgxdZcI7Vn/Nj0CE15Vf8DWFXMtkxIG1rpilb/WzJmbSJm3JgDD06NivDdYuP0d3ZoePtItVQ8d8N/5CPQgSs8bQOuRpjv5rStJJlOw1scYv+nFYnEzOOqtHKDYNnc2brX9ivBJ96WN8mFLRYafbAa2MSz80tZ+jUJBPDYWXYJp1cHFZOLTHIJ00gC7dlk7faXD6K/si7+5g8COqrsz+65Ei7+x2Ouv6aNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iYUU8whUrE2itOIt8Cy11CZR5l3epUQiHiIblwQlyU=;
 b=e6LmgDG+ovHY+FaVywno8TQ3cvhF0c4cjLY5ZdI2EXAmPFimjmiAR8RhByUKXc9ROSafL/uq+NUZRi/H6uSiV+hnXv8QHcj69Idftu6Y6XalheN/hoAPicxGbJMPYR4QltC2mdYlZfM3azsqdYcRnU3nf0but3T2dPcdGgGSd3A=
Received: from SA9P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::18)
 by BN0PR02MB7934.namprd02.prod.outlook.com (2603:10b6:408:162::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Tue, 29 Jun
 2021 09:41:17 +0000
Received: from SN1NAM02FT0059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:25:cafe::c6) by SA9P221CA0013.outlook.office365.com
 (2603:10b6:806:25::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend
 Transport; Tue, 29 Jun 2021 09:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0059.mail.protection.outlook.com (10.97.5.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 09:41:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 02:40:57 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 29 Jun 2021 02:40:57 -0700
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
        id 1lyAEi-0005yU-L8; Tue, 29 Jun 2021 02:40:57 -0700
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
Subject: [PATCH 3/3] phy: mscc: Add support for VSC8531_02 with RGMII tuning
Date:   Tue, 29 Jun 2021 15:10:38 +0530
Message-ID: <20210629094038.18610-4-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210629094038.18610-1-harini.katakam@xilinx.com>
References: <20210629094038.18610-1-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeb8be2b-5d40-4437-d0d4-08d93ae20b51
X-MS-TrafficTypeDiagnostic: BN0PR02MB7934:
X-Microsoft-Antispam-PRVS: <BN0PR02MB793404EFA2AF3BA2C343284DC9029@BN0PR02MB7934.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csnU9K+TGpNBRlBJugtL9l7rYZnfTt4QOlUEf3bD4qx6THHET/9F7QXYabiIIZ2jcdhSkYOUwjtLNGkPE6ho/bSL5gMFziXZFxgD8PfrKCfZpPnldZ2revaeEMx7uhFnzo2J/f1gDz5V/A9V9Jd9qTEnhiTd9ZzC7D53FGr9/AeduBuV+JoxvW+q5xYxUOwf7D7RxBAnvxzO+M1mGWoGLE6q7vhS4+jnL3mzWKr+5QMMekbTPyQeByEhUmwvyEQo1+iJLgTyhFNvhuU3S3Gn1qv8jm/HQD7JW9u2TmC+cOCspSj2YWXtmyGA9Az3ldpcueqo2Q2o3oYyAa5FGEp7V76khntqyW9bdnHbhiczGD0A4fgGadOWLf46DiKCRDBHwYqQB/vRso/KGtYTWYm2orcVjP6oUQ9UawoI8qX+XwYwlmgq0wEkEKs/+bt4STd05RwdMYuYUWeiRWc+cOjI7zuSmZRHDDi8MaEeJVvVs5bdlKbyX9O+k+rbz5/jo1DAtRYsm7I6Ectxu6t7DErhPOq12bLhNOwNTYgD4dDSayjBVMa/SDbnR0rxPOaeiRaOpZgbI0ytlEHp3E4CqnOL7fO4y/71Lh0wVZyFJ5MUcX05rC0/XM+O8TnmhWchN2vFiEHwiClflL3nx8bULL6DPEYorPSSc+znNu/xpqHSulhU5w6WLQaTgdPiDSPd7sS1VmaqQttBXHVhA1z5Ip5vFHuCDRuqztEfI0J6rdxE+LkKfLE7MOjRgFTSoFtRzQ9XKbilsXU7+AAKSlcaaCzhmQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(186003)(478600001)(26005)(44832011)(7416002)(5660300002)(36860700001)(2616005)(36906005)(426003)(110136005)(336012)(921005)(7696005)(36756003)(316002)(54906003)(82310400003)(47076005)(70586007)(83380400001)(6666004)(4326008)(1076003)(107886003)(9786002)(7049001)(2906002)(70206006)(7636003)(82740400003)(8676002)(8936002)(356005)(102446001)(290074003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 09:41:17.5767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb8be2b-5d40-4437-d0d4-08d93ae20b51
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0059.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7934
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for VSC8531_02 (Rev 2) device.
Add support for optional RGMII RX and TX delay tuning via devicetree.
The hierarchy is:
- Retain the defaul 0.2ns delay when RGMII tuning is not set.
- Retain the default 2ns delay when RGMII tuning is set and DT delay
property is NOT specified.
- Use the DT delay value when RGMII tuning is set and a DT delay
property is specified.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/phy/mscc/mscc.h      |  3 +++
 drivers/net/phy/mscc/mscc_main.c | 41 ++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index a50235fdf7d9..5a26eba0ace0 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -281,6 +281,7 @@ enum rgmii_clock_delay {
 #define PHY_ID_VSC8514			  0x00070670
 #define PHY_ID_VSC8530			  0x00070560
 #define PHY_ID_VSC8531			  0x00070570
+#define PHY_ID_VSC8531_02		  0x00070572
 #define PHY_ID_VSC8540			  0x00070760
 #define PHY_ID_VSC8541			  0x00070770
 #define PHY_ID_VSC8552			  0x000704e0
@@ -373,6 +374,8 @@ struct vsc8531_private {
 	 * package.
 	 */
 	unsigned int base_addr;
+	u32 rx_delay;
+	u32 tx_delay;
 
 #if IS_ENABLED(CONFIG_MACSEC)
 	/* MACsec fields:
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 6e32da28e138..2b501824c802 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -535,15 +535,16 @@ static int vsc85xx_rgmii_set_skews(struct phy_device *phydev, u32 rgmii_cntl,
 	u16 rgmii_tx_delay_pos = ffs(rgmii_tx_delay_mask) - 1;
 	u16 reg_val = 0;
 	int rc;
+	struct vsc8531_private *vsc8531 = phydev->priv;
 
 	mutex_lock(&phydev->lock);
 
 	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID ||
 	    phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
-		reg_val |= RGMII_CLK_DELAY_2_0_NS << rgmii_rx_delay_pos;
+		reg_val |= vsc8531->rx_delay << rgmii_rx_delay_pos;
 	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID ||
 	    phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
-		reg_val |= RGMII_CLK_DELAY_2_0_NS << rgmii_tx_delay_pos;
+		reg_val |= vsc8531->tx_delay << rgmii_tx_delay_pos;
 
 	rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_2,
 			      rgmii_cntl,
@@ -1820,6 +1821,17 @@ static int vsc85xx_config_init(struct phy_device *phydev)
 {
 	int rc, i, phy_id;
 	struct vsc8531_private *vsc8531 = phydev->priv;
+	struct device_node *of_node = phydev->mdio.dev.of_node;
+
+	rc = of_property_read_u32(of_node, "vsc8531,rx-delay",
+				  &vsc8531->rx_delay);
+	if (rc < 0)
+		vsc8531->rx_delay = RGMII_CLK_DELAY_2_0_NS;
+
+	rc = of_property_read_u32(of_node, "vsc8531,tx-delay",
+				  &vsc8531->tx_delay);
+	if (rc < 0)
+		vsc8531->tx_delay = RGMII_CLK_DELAY_2_0_NS;
 
 	rc = vsc85xx_default_config(phydev);
 	if (rc)
@@ -2444,6 +2456,30 @@ static struct phy_driver vsc85xx_driver[] = {
 	.get_strings    = &vsc85xx_get_strings,
 	.get_stats      = &vsc85xx_get_stats,
 },
+{
+	.phy_id		= PHY_ID_VSC8531_02,
+	.name		= "Microsemi VSC8531-02",
+	.phy_id_mask	= 0xfffffff0,
+	/* PHY_GBIT_FEATURES */
+	.soft_reset	= &genphy_soft_reset,
+	.config_init	= &vsc85xx_config_init,
+	.config_aneg	= &vsc85xx_config_aneg,
+	.read_status	= &vsc85xx_read_status,
+	.handle_interrupt	= vsc85xx_handle_interrupt,
+	.config_intr	= &vsc85xx_config_intr,
+	.suspend	= &genphy_suspend,
+	.resume		= &genphy_resume,
+	.probe		= &vsc85xx_probe,
+	.set_wol	= &vsc85xx_wol_set,
+	.get_wol	= &vsc85xx_wol_get,
+	.get_tunable	= &vsc85xx_get_tunable,
+	.set_tunable	= &vsc85xx_set_tunable,
+	.read_page	= &vsc85xx_phy_read_page,
+	.write_page	= &vsc85xx_phy_write_page,
+	.get_sset_count = &vsc85xx_get_sset_count,
+	.get_strings	= &vsc85xx_get_strings,
+	.get_stats	= &vsc85xx_get_stats,
+},
 {
 	.phy_id		= PHY_ID_VSC8540,
 	.name		= "Microsemi FE VSC8540 SyncE",
@@ -2668,6 +2704,7 @@ static struct mdio_device_id __maybe_unused vsc85xx_tbl[] = {
 	{ PHY_ID_VSC8514, 0xfffffff0, },
 	{ PHY_ID_VSC8530, 0xfffffff0, },
 	{ PHY_ID_VSC8531, 0xfffffff0, },
+	{ PHY_ID_VSC8531_02, 0xfffffff0, },
 	{ PHY_ID_VSC8540, 0xfffffff0, },
 	{ PHY_ID_VSC8541, 0xfffffff0, },
 	{ PHY_ID_VSC8552, 0xfffffff0, },
-- 
2.17.1

