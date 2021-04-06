Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5791935584E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345785AbhDFPmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:42:02 -0400
Received: from mail-co1nam11on2058.outbound.protection.outlook.com ([40.107.220.58]:44647
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244150AbhDFPmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:42:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEUlOIwUb9u95289i2jSXlabziLCdoEW8CvLmYNYasMJKHPsufGavYDlnQjpa83FJd+fpt9NGOVhfhkjL4Rv6r/IqR4IBJDyfEP9j4MhPe4QgU0ghJMceuQ/7oh5qGsyUmLHNctB/Rn4iQbuZaPG3QEyw/fpeGt1ziYOpk+sm891iUeNQT22jj2+r2dQZdMRbIxTNSswCBcJvuiRIGExgm4ZKK9eLh0Abe6TSkWoPZERWX5g6FTdDqa6PuY5f/pRDrUr4xx5vzBlROdPbFhh9db6xhLs8nyhF/VT/bYC09MvdC+F+4uPrOsBO2tASadNJkCC6J0fQeVdyN84gn7wNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgsasAbIGX0KBO78AtPvTCN42iBoHQx5Mee4+RFWlso=;
 b=HSZPiqrnyJAVIMXuGvQjIft4MTTjXGw9femQKNxBI7kAHgRZMsvGmzeWXgHpOJ+ASMMBLKaEPMjjB+9SFctvRPgvQBFO46K/SazO0hxvuZAS/k+9Kn2zIECDbhotzKh8ZQunXHfzF6a/unTB6B2loIsfruI57WrGIIbjAhU0BvRucQQ5nc/tmpgvK2QNLff3WK/uvXNqMBmH3egmc3zEfQyzGPodv7sp42zI5C0VpWq9HROE3Obus42pdV4jAUXS5kxTGuUTx2N8TjR8HPilCbkFiHWfmwHxpzNTbpc0gXFsmw09uTia2ZZOnfaOMQ9aGGgZ/iDIeaoWgu5lmdR6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgsasAbIGX0KBO78AtPvTCN42iBoHQx5Mee4+RFWlso=;
 b=e9DcBH7Y/iZBfL0xW2IQf3T+uPW2jRNjl+CTdmNXsmsFKg2j9EcCVVf1BgsN38g+s+iX5GerSW6641jFDE5fBqUD2zrdYrWDxO/f7ghVGS8j4ZQ/eOYDvZPCC6YhYDd9c4grHAxxwtf4P1H4TF7X9DcodWsQrH1p0HnDmbsiOI8=
Authentication-Results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1256.namprd11.prod.outlook.com (2603:10b6:903:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 15:41:51 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 15:41:51 +0000
From:   quanyang.wang@windriver.com
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [V2][PATCH] clk: zynqmp: move zynqmp_pll_set_mode out of round_rate callback
Date:   Tue,  6 Apr 2021 23:40:15 +0800
Message-Id: <20210406154015.602779-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::21) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by SJ0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:a03:2c2::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.9 via Frontend Transport; Tue, 6 Apr 2021 15:41:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d10abdbb-fb83-4fc4-7bb2-08d8f9127ec5
X-MS-TrafficTypeDiagnostic: CY4PR11MB1256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB12563C58DA37DBEC4604C9AFF0769@CY4PR11MB1256.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIBpTGPf4g7PFSRqeXLYBpG554Enti93+KrUcCsItjg8fW/+9G6Yl9BA65Je5grtQ4V4I2W7UGDWRFrCVfbOYogS19LNlE/qMcD7Jp/Ij5nEpQW/1xVPdBrPqyxIwgpUX3CuoX/LqIl8HtnCokkN9/X7ivGei0rHeyiwLJcLUBniRw1vyPWCWBoTKLjvHxB8CVnnVy12aVF8Qarta28RiDW94TM9RuXBdrkVDEGhrbd32DkHAtDlscDB+tJDKgrslb+TX47Mo9cj1ke9ANJDplXwB+b3fBYLWWUk9cdJthMWWiwHT8TTjn1yMsM9f+LxV79gniWuUlQfNNKxc5VssXeUQLQ7SH2XichqhaKb9Oq+a5Bygzl7KC3/A0sJoHd55/y+eL/zpZdIRKW7Ft4KdqkjRQ/uLKuRIvwvcQ4PQLZTb1Es4qnlEwSFeTg+D4IScYerQ0wQJ9o9t7M0PyKRthb2Rzv01D3JEjfpUGMFYi4TI/HMsh/HZjsiTngm4POvVk4L8cbGmPdBV1i7JT+vpYpuWf6RuqlRrUndRxUvOgqfS0LWTVa2VPEr6nR34ijbEqruCVmUA/ONLP6XMS0twLNRmQf5geE9s1Y8tzG+oZdiY+xhGV8UB8w5hRetowXS1mUjO70VY50xNJ8oRUkqb2uFfNHOcsIAMOQGyAGE1feoNVozS2zhWLq1DyN9Mn/WNMEwUGg3UU7bZLvcI8I3GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(478600001)(6486002)(66476007)(66556008)(52116002)(4326008)(83380400001)(66946007)(5660300002)(38350700001)(186003)(38100700001)(16526019)(8936002)(8676002)(956004)(2616005)(26005)(9686003)(110136005)(2906002)(316002)(7416002)(6666004)(6506007)(1076003)(86362001)(54906003)(36756003)(6512007)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?K5Cs+5vOP80AgjK6HQRBLZ5WjvdmdyIHTW5cUQMRqxfRCiM0CGeMXuoEpkfR?=
 =?us-ascii?Q?AMOx2zGatlPUNF+wAJLUN6De6tbxn2yvHk86+bUZqabWhclM2PdK/akjlVU0?=
 =?us-ascii?Q?2UhqDjtSgwe4BBavPd2QW+qLwtANluwVmKAwCyMV/d1r6hG/yt/YmrXaZPbo?=
 =?us-ascii?Q?M606+Sxr9bZsn/0mZ/jTIi7+vrf/Ak6vZ/BoUi50P+3n0W3SdsbxxqBwAtDt?=
 =?us-ascii?Q?3BKKXFtItHKFBwgWcy0vjfgIDZzkVErohJWrOp/FliwDTnFw72d+bLgWDC3i?=
 =?us-ascii?Q?xUJ0VhQyPtc0CYWv/AdGQF1oAYCcS+8/I1IWcV62GUuZYWlvUClN4O5dARNZ?=
 =?us-ascii?Q?q42p0rZ9u8akaPhc6d7r+PhoXEqVgdUGIP9mD63UfzINiY5Fh6d2ovC/1dyw?=
 =?us-ascii?Q?wCjh6gJAKSZFwHiNFZCca4krJkNJE4O9Ylp7mfSO18RroNLUjzpHDl/ssTHz?=
 =?us-ascii?Q?ocOnAWiJOLkeu6t3dVVgVOVe1Dws2y/5/JMYo8ZrpSEUWrZ0L6MFqYapkCxc?=
 =?us-ascii?Q?nDGtQ7UeVDSE/M0VuTHeaHGlilRPDrfdEQD3UCOQcY0liVuo5NYB6bJI+HXY?=
 =?us-ascii?Q?7En5JhndEBp9zc1TnLEIAUWxR9BxJ+ZtQitmV5zohG1dSrtgqSxKJIoYt3Yy?=
 =?us-ascii?Q?axtQlgl5dxj+d/Mop0vZ3+FLgC/mzKAZa4rR94lbHeneSUyCiFgElmRbs72Q?=
 =?us-ascii?Q?hWryXU7J4CpUpZ6DI1za1T1LGQJrDEvEaUoUStMpPfpXGp5M4QiE5NKzrTlM?=
 =?us-ascii?Q?X0pmSxvO0pz2PwC0AiNeX8rtpQn9XIu38uLRlo1v3aN0OyifT1MpY6sqLVy1?=
 =?us-ascii?Q?/WMbhbxuVenzTcMfd4jgpGhB8m5kSmhbCrd0l9cOhttnh7Z6m78yJg2RsErW?=
 =?us-ascii?Q?gxu1Qnr9T2fIHi7Ib66RIM3tN/10zzea42Z+b11fZa4v+34UQyyFRmJhaBQ2?=
 =?us-ascii?Q?zm4f9BGB8PLAnjEdNT6+u/QvQ1hpoFxzOBjXEFWjuG2cpTITl8kh1Hyq0lgW?=
 =?us-ascii?Q?DH7c4haqfGYtEQ5tPm1l12Wwb6MNW9xHX+D+eSzTXkhJ86GQrWWb9bkBk9pD?=
 =?us-ascii?Q?XpKRnmjHSWKfXFiSogIIA5b8/ihV+TGAL8P1WXZayxCCVu5fEaOkIWxNDuUN?=
 =?us-ascii?Q?NslTpn4yi6DDM8SS8jeVpy8cOKffbLBARN/Q6y/l5PKNk2Zq3Xkl/KmHm1uJ?=
 =?us-ascii?Q?m4ZaaYvsTekg2GJEYpShZi5ITPm3qPdLCwvj+EnXM4tvHrqt3yKXw13WcDwH?=
 =?us-ascii?Q?8fhv4wBzfc3pa8E0qVCiIkOf2F+6DFyEDt/wZ0xcT8t28dg0lFhbV4j1i+eV?=
 =?us-ascii?Q?YhyL9hHKRvYyAWku+0pSKcBF?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10abdbb-fb83-4fc4-7bb2-08d8f9127ec5
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 15:41:50.8242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYu1QqS+OPTqfG0LwJhnRPajwcUeoBa2gmSk1rahVTlBEPQPVPIN5Axy3rdUiN/0u16NuBux/+yVR1k6IMu+UXLn9zVipAGTMwmOhTb+FdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The round_rate callback should only perform rate calculation and not
involve calling zynqmp_pll_set_mode to change the pll mode. So let's
move zynqmp_pll_set_mode out of round_rate and to set_rate callback.

Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
V2:
 - add Fixes tag.
---
 drivers/clk/zynqmp/pll.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index 0d64268a4a84..abe6afbf3407 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -104,9 +104,7 @@ static long zynqmp_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	/* Enable the fractional mode if needed */
 	rate_div = (rate * FRAC_DIV) / *prate;
 	f = rate_div % FRAC_DIV;
-	zynqmp_pll_set_mode(hw, !!f);
-
-	if (zynqmp_pll_get_mode(hw) == PLL_MODE_FRAC) {
+	if (f) {
 		if (rate > PS_PLL_VCO_MAX) {
 			fbdiv = rate / PS_PLL_VCO_MAX;
 			rate = rate / (fbdiv + 1);
@@ -177,10 +175,12 @@ static int zynqmp_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	long rate_div, frac, m, f;
 	int ret;
 
-	if (zynqmp_pll_get_mode(hw) == PLL_MODE_FRAC) {
-		rate_div = (rate * FRAC_DIV) / parent_rate;
+	rate_div = (rate * FRAC_DIV) / parent_rate;
+	f = rate_div % FRAC_DIV;
+	zynqmp_pll_set_mode(hw, !!f);
+
+	if (f) {
 		m = rate_div / FRAC_DIV;
-		f = rate_div % FRAC_DIV;
 		m = clamp_t(u32, m, (PLL_FBDIV_MIN), (PLL_FBDIV_MAX));
 		rate = parent_rate * m;
 		frac = (parent_rate * f) / FRAC_DIV;
-- 
2.25.1

