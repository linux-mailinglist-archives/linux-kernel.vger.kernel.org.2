Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4874039E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351757AbhIHMbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:31:53 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:49924 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349059AbhIHMbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:31:02 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886da2C016872;
        Wed, 8 Sep 2021 05:29:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=EpE8rmgL0/KhksOTSnJ75V9qFI3tHWTLqw0t9sfXGuY=;
 b=DWdhNWe+ESYhczkfU0A7V6Hkl2XMYUV5dDfyYcyXes7jEzQ239dP+X9N+ChOXn3+Fa9t
 dmzKbqcF4iBIFLUA9Z0FNHtdAarktt9NESSWJKCxacmc1Mv8Ml99wVssWX71+f62+V5i
 ZPJ035jaApA/7bSzepQAcfwNs3y00iEsT0pFqm7M7Icl9ry6WpbH1Y5uWiG3OMn8LCPj
 6nBj97u8dBrIJBMFIaHeFbNI3z/rrOZtSXwAb5iEX/GtB0u0H0LJgiGWN8LwPF+O/Vji
 SdswJ94CO9NmhLtfJ74hbNE95UexQEbXpKe1ldXYjUxS930wt7rHuhsFltSUXSwmVNdZ HA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3axcp9k481-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 05:29:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTyjVIsIh57ftmTV5MQ1q06VeyFGDb8U5tf+vKO860b1tUppYorv07TBucfhCf9hIgUzgoxwtkDfwwFt99PO9XjKOvUL9d/bci0Mf0tcn/v8YyZhZNsm8RDJs25Kl7xP/W2fr8XEIEzsqjxXYOSR/Eug9z/23SF4TA0EX6X+gAhjzfAWr4rurmgvCDhNreiG35PhjxURdstPb3zz0VbAlUnR/XAN//gRIVoiRD/ioWfgcNG1aNgo4GTKQZZsJDxkyjxrawnb/nW8zYIBGiKEGaRjuXaOczoWHC7Zl+Jp6yickqolGmct98XvfwX04neTPXf5XTEDujDsEc1N4yaTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EpE8rmgL0/KhksOTSnJ75V9qFI3tHWTLqw0t9sfXGuY=;
 b=BOXVrN2HtfmVk/xpSfljHTUkR9c3JsL9wD9Ud+QTRrq1N68UGH6zJy2/7JAvRdTJm/zeI5SBdEYAKt++KSKxe7IfF9eZ5bOHhosTdrH1+CjF8ZgBuCwX9yY4Xqa6UkX2p279weYvg4DJnzMdIPSLE0IC2xYgOwFHBKHPC0/zzj90ujvtC2JMWJt3xawqLLDocP33swGrgdX23j5pjpZKbxi18pzN2nFsVBldy4PhFFkqS5xnNWBdN/kb7U1cxbIyAnlDCkz0N2qkuYw4yNc0egs/HsRjA2jJNVCd3qRE8D4aptp41FpQpvC9EvOVG9xYf+BlhRbf4/hI/emsSfPRIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpE8rmgL0/KhksOTSnJ75V9qFI3tHWTLqw0t9sfXGuY=;
 b=TajNfYsSlg6tPzfUn0KVLrOJnBbzzKadyR/UKuQwfizCZripfPTEQla4gTJVsll0eBbi7dbYAfEWvXn5kUW+580pPRNmOiRej4nlI8htm5/c4vTpyHGXORGjBvjpV0U61IA96/qOt8EHJhi4KLAZNjJMH1VaVBwZsYBS3KYmFKs=
Received: from MW4PR03CA0357.namprd03.prod.outlook.com (2603:10b6:303:dc::32)
 by BY5PR07MB7016.namprd07.prod.outlook.com (2603:10b6:a03:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 12:29:41 +0000
Received: from MW2NAM12FT067.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::2e) by MW4PR03CA0357.outlook.office365.com
 (2603:10b6:303:dc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend
 Transport; Wed, 8 Sep 2021 12:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT067.mail.protection.outlook.com (10.13.181.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 12:29:40 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTX9T026939
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 05:29:40 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 14:29:33 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 8 Sep 2021 14:29:33 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 14:29:33 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTXqq010313;
        Wed, 8 Sep 2021 14:29:33 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188CTXtA010312;
        Wed, 8 Sep 2021 14:29:33 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 11/15] phy: cadence: Sierra: Fix to get correct parent for mux clocks
Date:   Wed, 8 Sep 2021 14:29:26 +0200
Message-ID: <20210908122930.10224-12-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908122930.10224-1-sjakhade@cadence.com>
References: <20210908122930.10224-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c612275-ec1e-4e1c-8d71-08d972c454a1
X-MS-TrafficTypeDiagnostic: BY5PR07MB7016:
X-Microsoft-Antispam-PRVS: <BY5PR07MB701683BE9204F9F0FC9AAB8FC5D49@BY5PR07MB7016.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdBBhm5RkAraUjgAWHeEpvLIurhDPcHBQuggQ+LXyFmapT3j2b3IZ2SiAOibreDO4xftQJmFrb+X2Vf4fiuTMjYKcjRc21E+pPbR0vebq6Ko7iw457VolDHlueb0PB+GTXGntCRtrZIS2oxY/mypMx5XKooVV4CuENdH+nHnTJuuMZ5VPkRRUa35zf/apel0klYOWvTReVTLyZaKxEe2UFMOApsnMEaMg6PE3uUOfxsbOx+kygCon1DLg2Im1TbB9wY2Frt/5czE31+mHWFc46XsSZiBTQTNi8V064yrXhZkmq/7IfA4kvfz5I8Y/baxy9LKb66JxS5ywWCbiE2fqdEbvzAVBuynjcepK37k8ziOLZg+gBoIDAOvqZ0ZaZY8K2O2q45lFPIaG97UJj2rIpJPT9UdF5kxbjmN2orqmGK9NI3xgloXQN1175rDlh+OMAr6xfRojCDTp1iNbsfsediVIZlpw8m0pv0Yg4CBKUU8n6Y3zFwQ2z4ugK73WGstPDj32iZp7hrTO+GNTEueBjGCqEf3hLFYDxodQFugJMSNM29uTJFZ3lvD5myCKdqFnjmcD7rZKDz+rTNv9cHlYTimbFfkyb1jf+qTeKN2BPMpaxhPzdU0XtTnPVjg4nIYHifjwg7EOJDpH1wg1zojDGaw372n35/e1hUKY99fXy1q+NXXJYQ450OhJIBn5CzXfwr801aH5e+sOQMcAj3X126Sqf5PBBZ7abptDhsF3yk=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(36092001)(46966006)(36840700001)(42186006)(82740400003)(4326008)(186003)(26005)(82310400003)(6666004)(70586007)(36860700001)(5660300002)(2616005)(70206006)(8936002)(36756003)(110136005)(86362001)(54906003)(8676002)(316002)(36906005)(356005)(426003)(478600001)(336012)(1076003)(2906002)(83380400001)(7636003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 12:29:40.8106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c612275-ec1e-4e1c-8d71-08d972c454a1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT067.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7016
X-Proofpoint-GUID: i1Z3QJ-mVhKQ8MzM9tMWSaJpDF6tP02G
X-Proofpoint-ORIG-GUID: i1Z3QJ-mVhKQ8MzM9tMWSaJpDF6tP02G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_06,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080080
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

