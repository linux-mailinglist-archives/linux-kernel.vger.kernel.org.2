Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447573FF9D2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243831AbhICFDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:03:01 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:44232 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233478AbhICFCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:02:21 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1830KKIU011808;
        Thu, 2 Sep 2021 22:01:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=EpE8rmgL0/KhksOTSnJ75V9qFI3tHWTLqw0t9sfXGuY=;
 b=SlynySgWlZhT6uQF4IpG2Kw39XVTMIgQi2reCUqelXjUZp2nXsU8rFcwJnV7pLiN4SiS
 DA1m3lvZfAXx7BrfhoFDWb8QtEwh4sg7/Byn2VDPSfhX/WeLKMtJTAT+/NF/QcJZv2bV
 tSR14sab46Mo2r1ju1qan+xfNGjAEVk/Yb/IgHXG/rVOV33GscTZy0BzWwH04bJge8zQ
 obGUlrZ8tqhR4Rcg8o0Y1yOcqfDNw/TKtANULNObqHLpydQh0o4uTYv4iYe8ZbkL91Qe
 /kfp1umhQQAf21R582OEuLbfkYcKcXC4GbAXftDvbC1zFhRqV3pBDaIRzKw09ZFkgz96 6A== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3atdvyek2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 22:01:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLHiaeFASqUO54uLHq/WJYcpYK4+c5bltmnlinrLsSzRAZf8/XwKYRLfSMjyaJerXLk7HYys3aD2YCByJWjaPl5/m4oW2Ajif8YCExeQ3UobL2oYDJj0IghTSAwHx+igzT4e3QHFr+BXObAM5CL3Cb6NZIT3fUk15xuhxnETcsalmk5jpDm48fNVTP96qVpjao4gdUflRu7cd9+0A8qW6QIwosU75d9e7tikBuMMMkVhdOzHfF59QiBG6yThRJdK+3xtIgetxuvHACddHfynPvFTXASXnJmhnFcWv8m/i/FaEmlqA7r/Aie6whosD9ud4zI8hnOu3hFdaI0qOrHASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EpE8rmgL0/KhksOTSnJ75V9qFI3tHWTLqw0t9sfXGuY=;
 b=lI0PIueeaTJJoIJTTKv0BoZz0ClfB4atQJc2BeqwgHiIFmYRt4BPgFmnICmbG3aC60B7kpQkuiPC3o+WDt+uiyCLpV2Pf6ZGau3GG1EWmIhMxwTZ7ekz0c325sfj5pknCJPDo7GQBwoKVSYV6wKJUnK8l+tWSAnq4CeGPtIYemJyggvYUCA+SkfztjlcZCqEgILYeFqEtgXVXmWG9UXRDo1L1M13E0DUErAW2xtQavDyygonEZcYtUmr/gHKw7bE594XN2r+kFAxUo2J+GKuaZ89MC4ZZ6N3hLCS3FFxg5eVMVJUB9Hl27t8oW+Le7OFR4fQcYPhvEqVvZ0GQJJ55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpE8rmgL0/KhksOTSnJ75V9qFI3tHWTLqw0t9sfXGuY=;
 b=PNNj9s4H/zQcgbLT1vMtwxHcySOxByUuiTYFpkkdmNyVCmR/j0aeEEaa7AWWsmeVaohlpj7NDtgQ1ADWTdNJ7PkyIymKUfT4w4kuC8cW2BzUWTmCm6+jdy2jbuC1lxCO5VGa8vwRw/rA3vaCRdK0w+mTbiEAQnLzaWH5WSHvAos=
Received: from BN9PR03CA0496.namprd03.prod.outlook.com (2603:10b6:408:130::21)
 by CH0PR07MB8347.namprd07.prod.outlook.com (2603:10b6:610:d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Fri, 3 Sep
 2021 05:01:04 +0000
Received: from BN8NAM12FT011.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::c9) by BN9PR03CA0496.outlook.office365.com
 (2603:10b6:408:130::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21 via Frontend
 Transport; Fri, 3 Sep 2021 05:01:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT011.mail.protection.outlook.com (10.13.183.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Fri, 3 Sep 2021 05:01:03 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 18350ufb020399
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 22:01:02 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Sep 2021 07:00:57 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 07:00:56 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 3 Sep 2021 07:00:56 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18350uQW025709;
        Fri, 3 Sep 2021 07:00:56 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18350uRO025708;
        Fri, 3 Sep 2021 07:00:56 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 10/14] phy: cadence: Sierra: Fix to get correct parent for mux clocks
Date:   Fri, 3 Sep 2021 07:00:50 +0200
Message-ID: <20210903050054.25627-11-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210903050054.25627-1-sjakhade@cadence.com>
References: <20210903050054.25627-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fedf88b2-ac42-474e-c602-08d96e97d4d7
X-MS-TrafficTypeDiagnostic: CH0PR07MB8347:
X-Microsoft-Antispam-PRVS: <CH0PR07MB8347128F0A2691D931964BA7C5CF9@CH0PR07MB8347.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v6/zFSfSGrntqEIYs7MnkHZ8tJ65o/C+W/x5TvmHxqj/UF3HTk+6v0V2WyPI9cWaw98t900/RxQjB5p6Jqh/NSxU+yOYbKzTdrp0+OB11EHnGDFJ5/Br+e9ACH6Yoa/WbNgv1svePQB8Vhe/p0sFLXQPqFKWW75ijSEeXyCYi09FIqjZ8ZvoFSGle6n8SZVGs09XdsiU/nNSA0fPV0j+DCEDeGVCgIl8vGmzr4sQYBT0nkbEPR7RFFvOPAatfY1ENRKWdiARnfPK5MDSll+BX3dizGAGSnV0I7okhFiUefymCd84InD5P7Mf/5Pbfnqtt8IbB4u6Rzn/yov7qF4YhLfyHtz4VbWWycImQI2NiUC/6NASxiQR/dENS4OtBsr5ZQRRQmx4HMrJ9PGluQKlmwCg2KznVBG1Sd/QuN6/VX1Rtk64Jy0hVY1RHBVZgssVhD2lTYOaXxPWLNix3VHJcXHvDBPRl11vBTgrTa7FIMMbSB7doX5RfaWDwM+HY0aGzpOT3BKLqIOTbOXksdw0xu/CpzcKDZ4GNQ/p3Ly8oRPXmxOOv/Sj/0vTw/6kssYeUtvLq6paTlfjQgKr6xZ1eRjo6vTCya9GVhSxK+LsoPmW+GwRVL8J1hR1OCexdwf4d1+yj71Da9rwZr7F/kdSQDF81UI2oPprzbdrg6pWd1UchbVCSHi+kXDDKTh9SSyWggG5Whf+8GfbuV3Hd1P9ZgbaA5uQ2ZGQHa4VGnU/W60=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(36092001)(36840700001)(46966006)(4326008)(8676002)(8936002)(2906002)(478600001)(36756003)(316002)(110136005)(42186006)(86362001)(54906003)(36906005)(2616005)(5660300002)(82740400003)(26005)(7636003)(82310400003)(336012)(186003)(70586007)(426003)(70206006)(1076003)(47076005)(83380400001)(356005)(36860700001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 05:01:03.8294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fedf88b2-ac42-474e-c602-08d96e97d4d7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT011.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR07MB8347
X-Proofpoint-GUID: Xq7Kg1X6G0CVdDE60XO9ziwr3Zs4l0t8
X-Proofpoint-ORIG-GUID: Xq7Kg1X6G0CVdDE60XO9ziwr3Zs4l0t8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_01,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix get_parent() callback to return the correct index of the parent for
PLL_CMNLC1 clock. Add a separate table of register values corresponding
to the parent index for PLL_CMNLC1. Update set_parent() callback
accordingly.

Fixes: 28081b72859f ("phy: cadence: Sierra: Model PLL_CMNLC and PLL_CMNLC1 as clocks (mux clocks)")
Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 31 ++++++++++++++++++++----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 83dc025d77a8..bab78322078e 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -257,7 +257,10 @@ static const int pll_mux_parent_index[][SIERRA_NUM_CMN_PLLC_PARENTS] = {
 	[CMN_PLLLC1] = { PLL1_REFCLK, PLL0_REFCLK },
 };
 
-static u32 cdns_sierra_pll_mux_table[] = { 0, 1 };
+static u32 cdns_sierra_pll_mux_table[][SIERRA_NUM_CMN_PLLC_PARENTS] = {
+	[CMN_PLLLC] = { 0, 1 },
+	[CMN_PLLLC1] = { 1, 0 },
+};
 
 enum cdns_sierra_phy_type {
 	TYPE_NONE,
@@ -567,11 +570,25 @@ static const struct phy_ops ops = {
 static u8 cdns_sierra_pll_mux_get_parent(struct clk_hw *hw)
 {
 	struct cdns_sierra_pll_mux *mux = to_cdns_sierra_pll_mux(hw);
+	struct regmap_field *plllc1en_field = mux->plllc1en_field;
+	struct regmap_field *termen_field = mux->termen_field;
 	struct regmap_field *field = mux->pfdclk_sel_preg;
 	unsigned int val;
+	int index;
 
 	regmap_field_read(field, &val);
-	return clk_mux_val_to_index(hw, cdns_sierra_pll_mux_table, 0, val);
+
+	if (strstr(clk_hw_get_name(hw), clk_names[CDNS_SIERRA_PLL_CMNLC1])) {
+		index = clk_mux_val_to_index(hw, cdns_sierra_pll_mux_table[CMN_PLLLC1], 0, val);
+		if (index == 1) {
+			regmap_field_write(plllc1en_field, 1);
+			regmap_field_write(termen_field, 1);
+		}
+	} else {
+		index = clk_mux_val_to_index(hw, cdns_sierra_pll_mux_table[CMN_PLLLC], 0, val);
+	}
+
+	return index;
 }
 
 static int cdns_sierra_pll_mux_set_parent(struct clk_hw *hw, u8 index)
@@ -589,7 +606,11 @@ static int cdns_sierra_pll_mux_set_parent(struct clk_hw *hw, u8 index)
 		ret |= regmap_field_write(termen_field, 1);
 	}
 
-	val = cdns_sierra_pll_mux_table[index];
+	if (strstr(clk_hw_get_name(hw), clk_names[CDNS_SIERRA_PLL_CMNLC1]))
+		val = cdns_sierra_pll_mux_table[CMN_PLLLC1][index];
+	else
+		val = cdns_sierra_pll_mux_table[CMN_PLLLC][index];
+
 	ret |= regmap_field_write(field, val);
 
 	return ret;
@@ -627,8 +648,8 @@ static int cdns_sierra_pll_mux_register(struct cdns_sierra_phy *sp,
 	for (i = 0; i < num_parents; i++) {
 		clk = sp->input_clks[pll_mux_parent_index[clk_index][i]];
 		if (IS_ERR_OR_NULL(clk)) {
-			dev_err(dev, "No parent clock for derived_refclk\n");
-			return PTR_ERR(clk);
+			dev_err(dev, "No parent clock for PLL mux clocks\n");
+			return IS_ERR(clk) ? PTR_ERR(clk) : -ENOENT;
 		}
 		parent_names[i] = __clk_get_name(clk);
 	}
-- 
2.26.1

