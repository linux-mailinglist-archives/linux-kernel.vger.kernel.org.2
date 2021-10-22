Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DD8437B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhJVRGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:06:20 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:28092 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233769AbhJVRFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:05:33 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MEgLoZ012879;
        Fri, 22 Oct 2021 10:02:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=PLrvYGR0jUGOxOkqtxxr2QsHkbRlH7PQhIkiPnk0dr8=;
 b=iBKU7vXGafWgCpSEbAmQiosyn+dDvnEeY+Gwk0gLr1yEyJtpLEIeV4iZwBJwkqLJ7zRC
 6y/SqV6xFD24uO43S23JxWhiKbHdYWEglfMeBhLct7n80X52Jl5V6wwzeuhbccmxs8Za
 P1AszshNWikRIvOnVXjq6qvGHpuCe6jBxfFnMzhSlsT4PzrDibZNpoSzuu4wD5cq7Vgj
 1kbtpKITVzh8KbXJIF8TBDusSwMLchmWnHTrXCqe2PIycuedkl4Wt5498q+R9NaSbo7n
 LSj2iqvMPBrLoOyAh2H/rX3gMmP461TWN4DhSP+rmBJZVfx/tzYbYpuzJ9ZpUtM7ZTKs 5g== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3buya2resu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 10:02:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZKOMiYkRfem+6D5d9J/M3CHPSPTR6RMY9hfW3cLvoGYWsldNc9+tKZq29dUZZ4yb+lVMT9BJnJJ5nk2gIlPWrVsTfnhRes4dc3t6uzLFRgJic1PIOydM1Ud8Wrx7wcTuBqyMsUO/+EzZiVauwMnqcLZw9rNSXizv8L4Xai7JPQAF1jUEm4/ygtromTITmhr4Gf4d8h/8TB6Wk9RhSGDV8rdFT2J/Dn3RyAbrJdQt0hentOpazqXXYc5+ZA+7EpJRzORy7OmUh0hNnJizy3kQnDzST3MnH+KR4NV0Y1ERlKOjjhzpKvckOtw6tjE0WAxkmddnV+vE7sBG905RtUCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLrvYGR0jUGOxOkqtxxr2QsHkbRlH7PQhIkiPnk0dr8=;
 b=Z82TYV1eGEF2qpLtk6pTO6fdtx8J0YfvMWWPeEYm26bnMuxMneTCwQpVfC4ZxFvvM+XGdz9bbBRVsu79B5u0tRWOklEPt4D4BGFQUohC8EDMOnCVniT2Txh2Nr3X1gst1wSn/WLiLa9wVkLkSy+znae90w5Xlv3MiNf87dWa0qF7eVwuhHSJVG27Txay/EU1O8GkrKSxqNSNMcOXAae15ok3udG/5u9XcwSLoP6vdNxWFZrVrql0BZnpd+X7oI7K1yhC/CxQ4KnD9g3OpfEvQ5ozeTNoolWms3KfxkJ0N1on4PXUNooEQaFOp3jcxi+MaOqcDK86I8qzFCKo0qXMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=temperror action=none header.from=cadence.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLrvYGR0jUGOxOkqtxxr2QsHkbRlH7PQhIkiPnk0dr8=;
 b=MN7a9jjnNU/wILCEC7FL39TQj0mQfSIt22maSHLWess+N1NAq6rbnaA/BwzlKnUELHEotyrDHYxX4/76qaaa5q/HqlZDnOKy5btFlUDcJeq5sfQRlkJDXsTiENNqDPH9Pg+JfWKhYnzEw7f144yNS9ivKUvtcisThXox77tQ9tA=
Received: from BN6PR16CA0026.namprd16.prod.outlook.com (2603:10b6:405:14::12)
 by BN7PR07MB5377.namprd07.prod.outlook.com (2603:10b6:408:2e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Fri, 22 Oct
 2021 17:02:52 +0000
Received: from BN8NAM12FT004.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::12) by BN6PR16CA0026.outlook.office365.com
 (2603:10b6:405:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Fri, 22 Oct 2021 17:02:52 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 158.140.1.147) smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=temperror action=none
 header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT004.mail.protection.outlook.com (10.13.183.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.8 via Frontend Transport; Fri, 22 Oct 2021 17:02:52 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2iNN008564
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 10:02:51 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Oct 2021 19:02:39 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 22 Oct 2021 19:02:39 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 22 Oct 2021 19:02:39 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2dvd018933;
        Fri, 22 Oct 2021 19:02:39 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 19MH2drO018932;
        Fri, 22 Oct 2021 19:02:39 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v3 11/15] phy: cadence: Sierra: Fix to get correct parent for mux clocks
Date:   Fri, 22 Oct 2021 19:02:32 +0200
Message-ID: <20211022170236.18839-12-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211022170236.18839-1-sjakhade@cadence.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6161eb9d-6304-4d16-0ba4-08d9957dc8d8
X-MS-TrafficTypeDiagnostic: BN7PR07MB5377:
X-Microsoft-Antispam-PRVS: <BN7PR07MB537768B9191658A7A6F691A6C5809@BN7PR07MB5377.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NksHXxNs4moMFlmcz2GfEkAr6QN77PI2a8USMjt8c0SfNjUrviHG880Tj/S97nxUyIR/8OFP/SIkxrViXdWAtpwMVwrlr6CZP3GNF9pv3F45BrRDF3VHJXuc587hTKReKn+g7iF7uxik/OHK+8VNvJfL66hfYE/Zqh3AEJReLHdo9AaK5bHnlcqpCOtHTFn841A6t8IUHei+nm8QyOVxH7KleLwstUc7L61qEijEF9qgBOVF04RUpV+EtMvIpeb6+nF0LiE4SlVmSx5k1pyCyZGSi3MIVzCuPCp4ranG7i8RTRyjXaJo7MpkmVMjB+WTQq7KB7aIfsX7apo43lt4wVzCdP5qkRcF4B/BLxwqCG8iBS+QsbtxhhT00iQdMNdfs0/GJUGaXn++YoPlmnl/UP/nfCl5XnUJGaABqMONmRo2CARa77XtGjNZeHnb0cH3eWZhhz9WMBbQ71PMXh1VTPiE6hYW7/Ah37yjeEErBk2/vD2CZzWbD2cQdXKn2au/QQwpakbrydFMYesJQRfNJKSlZAtsP2IxsQS9n6ls2VBDmsMTbns3xWxaqyXVl1gnnrDmOIcLb/hOQabgtEo7R8dPjayzTbPS709nvQZmiJqLZWIQyyHuOawIb5fkHQTnCfIGDx7BXV7NYqvrajZeNwOjrSMrLhuZnQ6RY4iJ2oWZaxpoSQOh3o11x0uuMZhA0NSTFaQZDhfnPAB1D272xnQVnEnJutL6d9tp5co2dug=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(70206006)(47076005)(6666004)(316002)(83380400001)(54906003)(110136005)(1076003)(7636003)(36906005)(42186006)(336012)(4326008)(70586007)(356005)(86362001)(426003)(63370400001)(2616005)(63350400001)(8936002)(508600001)(36860700001)(82310400003)(186003)(26005)(5660300002)(2906002)(36756003)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 17:02:52.1189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6161eb9d-6304-4d16-0ba4-08d9957dc8d8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT004.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB5377
X-Proofpoint-GUID: Vcn8M-NzwWFP5eAo7r5OhfIUVyOJa7HO
X-Proofpoint-ORIG-GUID: Vcn8M-NzwWFP5eAo7r5OhfIUVyOJa7HO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_04,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=979 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix get_parent() callback to return the correct index of the parent for
PLL_CMNLC1 clock. Add a separate table of register values corresponding
to the parent index for PLL_CMNLC1. Update set_parent() callback
accordingly.

Fixes: 28081b72859f ("phy: cadence: Sierra: Model PLL_CMNLC and PLL_CMNLC1 as clocks (mux clocks)")
Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 31 ++++++++++++++++++++----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 728abd14aa79..abdbc6ebd5a8 100644
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

