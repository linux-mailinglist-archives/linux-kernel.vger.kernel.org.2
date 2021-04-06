Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E25F35580F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243870AbhDFPfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:35:12 -0400
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com ([40.107.94.48]:41664
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345850AbhDFPdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:33:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTzOvAsaGH45xlJd1T+efj9GdGLI7+JOQI+lWjouVAWSORX+i7ADUsBe85JHZkxlmze+pNoyHfXAtg5rm9VuC5Kyd1HcM8kH60G1MJ86GN6hDxaKj3aMax66qi7lvA0GFi27ZNwfD0GIfGLJrIzf7ScudSlHdlurDVUDzTpn4rBfyKyxr7eV6qZus/Umx6ltx3wTeFht3ZzZ9g8OSWxnkggqEYDwTuxyccnP2QutYmZuAabYe9ohEY4UaoD0iN7SfR5SwsnVRFRAqk5CBKBFpLFs2xlaMjVItK7f9vUX9Aa1OqBX7ALepBhsevKVyHQG2P6Zb5Ja1ygMrEpcPttDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdo6NpSrLCTj4s2AdDMj2QpYlPI5SZl1pJeJoKk6kuE=;
 b=TZ+JmFkyocM27bwARqsJ53yY0MspNiz9EFOdYvOAA1JWvCmz62RTrTY74k5OnkNR0QI9tjfh0Lp/02QK2ToAbb8i+A99MWWfHRqjMhn0BcjiFmDc8qe7NMXkQ4PLA+00q87qAJJfbBLdM/pGrlkWvup5HUSogzQkwR+5IG9monch65sUgznuGUTUDTbMVc92bsRBVCqwKcVcpuZfNGYRhtbESjP2you2+a1WCI516zdv3AI1ZTo39qm5+XyOA4q6yBHi/Sk5yNN4F6UfAkmDhjUCCuIa7QWQOvhVrLtATlP0USBhhBm08vp8+Eqe6eZ6gxEJh2yO1DzC1wYvlBYIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdo6NpSrLCTj4s2AdDMj2QpYlPI5SZl1pJeJoKk6kuE=;
 b=LGs6gpapi84nwZGnXPqy3Iv9IQkPPyDQzF/fpX5/Y/RnFG5uEjDyn7j1RE6Uj44QnxzgY4Bfb5iid6EQFAnU76bgFb/1VaM7Ft1ICaLcuFgQWqrjR4OXhqoTvUGDlaOaXJJ0cKK7BwwzccHWlLtbtBpcPQelrdT9t0qlYIkoHCE=
Authentication-Results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB2008.namprd11.prod.outlook.com (2603:10b6:903:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 15:32:59 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 15:32:59 +0000
From:   quanyang.wang@windriver.com
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [V3][PATCH] clk: zynqmp: pll: add set_pll_mode to check condition in zynqmp_pll_enable
Date:   Tue,  6 Apr 2021 23:31:31 +0800
Message-Id: <20210406153131.601701-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:a03:100::15) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by BYAPR08CA0002.namprd08.prod.outlook.com (2603:10b6:a03:100::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 6 Apr 2021 15:32:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b5b441b-fb2a-460e-377f-08d8f91141c5
X-MS-TrafficTypeDiagnostic: CY4PR11MB2008:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB20080C459A57DC1DFC001383F0769@CY4PR11MB2008.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jaVJicnhJ+Pu5ckNx0RAQ9e/csi4/eE4ysWfMatpTGASGQr0B1NyZly2djpnUbGzwCRE//PfMrhYjtbfohEafnqQW8IWXtRnUCM99XdIEkrWRvObrlWOKRrQsoqO6NuwKdtp8JnEib89JTe5Z3wCSGKMVKue1U0xgCe1wjLALBDze5tPZ0H57AHQpkaiP4Dr0LaGzdbXrgMJ5PcutpUFlZt/N2qzSADoOGJt7+lpxcx+PEgTIoQA2wn9jTW9xf2j1a2ftUS5t7q6n/r+R78m9h+oddhZb8nN/45yldqhKl1uuZlM7CcJfgST8qcWAM1gVP2+BicmJIh092dZ0vE4CdRtsQC2QsM+X6mVkdNT1HaGoIbS/pJQUuNUjs7Y6ZsSQiVgncLMz+mXKKcke8y0+68lcQtfTt3/bvvhNq+oA/LW/p3WYs/dVDHK+80SLQxVpmnERc7c9qrZVGFyFou78VVII6VEcDmHYmJe8xEO3+NAKXWyarQpJ42kHV1gslBGYxNNY83+OJ9BCmFjqcHXCVlkLuqMvMgbChlnbfDNDRTuu1JNHPqVQE5tAKKYkbwP34UCTTsLlb+Bd9KSClcwxh2dEODzIoGawnmDsw0IEqfWeoABp9ByiANrC1rDDLOy5p6DOvcvJLdrtronDhKo9sLxluyCidlr9HFU8BHh4TzH4/Y9tfBfsKVeLGl0Amy5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(39850400004)(346002)(83380400001)(956004)(2616005)(1076003)(5660300002)(54906003)(6486002)(4326008)(110136005)(36756003)(8676002)(38350700001)(2906002)(9686003)(38100700001)(316002)(6506007)(16526019)(8936002)(26005)(86362001)(66946007)(6666004)(6512007)(52116002)(66556008)(7416002)(478600001)(186003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ImVd6MQfgTAnZMUZoxIFf/kbRMB9DSh2VEnSxrRc+eFygqz+siEw2T8uaB6U?=
 =?us-ascii?Q?ZZLCIWExIQ5ZYEWTZqOS9iy3ilj+FS+TSmNvX4Ni+/lXpD1sxs6KuPcVsnfe?=
 =?us-ascii?Q?SkGwM1q1pWAydwZG2pkSupPoXT1NnHJbY9LddLYX2x6ENM/tMTZAlP4F1o7q?=
 =?us-ascii?Q?PrJovaiuRsD+fskJU40N83oa1s/VgvMky2/YUOzsujdkNB4R1p3DkxRHfqB7?=
 =?us-ascii?Q?SVfzIqmvdWtB08L366nbYDXOm84N9t/BwlV7CQqa0YHtCHmi5Q3m9WPrTTpZ?=
 =?us-ascii?Q?ErmWfn7aSQkkLHhItUOhiXdbXp6dIuOFI+3avYb/ZDozxkT57ATsYsF/Cr//?=
 =?us-ascii?Q?+c7XiNNhTKuid9UwzuchOwW3FWEwL/juva6AWzv3y3LC5fMat+qAPDjqFcga?=
 =?us-ascii?Q?rvHIDwLU068OgHQ1SXtUCFLpvhquLZq9Itci+hGSClUwdGqcT2b1epSuLTa5?=
 =?us-ascii?Q?ZlbhKPIHFhNBJcDsoe+S4+npTp1/S3alVdbyxnuBQdj0Lh2Snu6/CWRvLgLe?=
 =?us-ascii?Q?HpoV4Lt4nj8eF+IdmODQHPRYLQOuGN38L2TBTvcEbuaXzad4poFEfdcQxLot?=
 =?us-ascii?Q?KaSdroHfeJYfkCzustlWilu6Px7vNhEiIDrgM4gA7ErpC3LCpI/bGRuTA2H8?=
 =?us-ascii?Q?VBtElmbcvXgq74iI7OM4rUCqdF/zg8CxKepjZfdRWU8x+Gpe+SUSrEcXNuak?=
 =?us-ascii?Q?9wTBn6k0JH5mM/VSuf8EH5/EEuRkhJR7ovv7QwUYXARbOSZVNnI/qr6SiDNt?=
 =?us-ascii?Q?UjyvQnlw5BEDnXLAPm/G6VdVCdoWpdqsZRyKAzrnPCGn0OWUQV7fWU02lLIL?=
 =?us-ascii?Q?ZZUwKFxLPGiZiFqDaq2GwHFLqeS4Fm8dIFrrso2XQmiuaxv1UnWvF/JSqD1k?=
 =?us-ascii?Q?izxYf7HrJDR7SF26fyfDMzSG+yb+uIbio3xg8QBtiwSIC2MRYZGt5yOgnVdL?=
 =?us-ascii?Q?VT5Gzifo1UDgdQsMQZdcth6v4bY01W/xAEch0ZclBqrGsOmfU8zeCyR5nU1R?=
 =?us-ascii?Q?8h+tHGywf4CzXSvqZ7V8awcCl39PKmyv9fC4kk5EQlNKwfZBBiZ1jp6qHXrI?=
 =?us-ascii?Q?61J76jf9zJSMcu67E5LNc+4aUWiRYeBJruMqXGEOw0nbw2aioLp1ckNICMXO?=
 =?us-ascii?Q?EP9FmduYUoIqqrXHRR4u7ap259FVpm93/NQlVJPPvnpsXlzEConI4ZZ1r+zk?=
 =?us-ascii?Q?weR1Mh5JdO6PBZH00CLQhWozOTgj081eUxvPnM7khx4jWS74uA287Sy0I3KC?=
 =?us-ascii?Q?fUFjPwPjw5y39fy5O17iTyPiRxS9thn4OgYGs21U/pyGzAHB5HkuD71sLfPY?=
 =?us-ascii?Q?QgJiO38ExjWZKSnBYLXltf+y?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5b441b-fb2a-460e-377f-08d8f91141c5
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 15:32:59.0786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Je0qS4ahOw/RQRvPAb8EoY9F0Ej0uNoTB72WTQT3SOgS37F/4BHGe5xS6W4sEaUtPqu8yg6skx5/RPbBrZGKf5sDZpBPnMKZV/Yaa0ZIznQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2008
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

If there is a IOCTL_SET_PLL_FRAC_MODE request sent to ATF ever,
we shouldn't skip invoking PM_CLOCK_ENABLE fn even though this
pll has been enabled. In ATF implementation, it will only assign
the mode to the variable (struct pm_pll *)pll->mode when handling
IOCTL_SET_PLL_FRAC_MODE call. Invoking PM_CLOCK_ENABLE can force
ATF send request to PWU to set the pll mode to PLL's register.

There is a scenario that happens in enabling VPLL_INT(clk_id:96):
1) VPLL_INT has been enabled during booting.
2) A driver calls clk_set_rate and according to the rate, the VPLL_INT
   should be set to FRAC mode. Then zynqmp_pll_set_mode is called
   to pass IOCTL_SET_PLL_FRAC_MODE to ATF. Note that at this point
   ATF just stores the mode to a variable.
3) This driver calls clk_prepare_enable and zynqmp_pll_enable is
   called to try to enable VPLL_INT pll. Because of 1), the function
   zynqmp_pll_enable just returns without doing anything after checking
   that this pll has been enabled.

In the scenario above, the pll mode of VPLL_INT will never be set
successfully. So adding set_pll_mode to check condition to fix it.

Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
V3:
 - add Fixes tag.
V2:
 - add Tested-by tag, thanks Laurent.
 - fix typos in commit message and multiline code comments.
---
 drivers/clk/zynqmp/pll.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index 92f449ed38e5..0d64268a4a84 100644
--- a/drivers/clk/zynqmp/pll.c
+++ b/drivers/clk/zynqmp/pll.c
@@ -14,10 +14,12 @@
  * struct zynqmp_pll - PLL clock
  * @hw:		Handle between common and hardware-specific interfaces
  * @clk_id:	PLL clock ID
+ * @set_pll_mode:	Whether an IOCTL_SET_PLL_FRAC_MODE request be sent to ATF
  */
 struct zynqmp_pll {
 	struct clk_hw hw;
 	u32 clk_id;
+	bool set_pll_mode;
 };
 
 #define to_zynqmp_pll(_hw)	container_of(_hw, struct zynqmp_pll, hw)
@@ -81,6 +83,8 @@ static inline void zynqmp_pll_set_mode(struct clk_hw *hw, bool on)
 	if (ret)
 		pr_warn_once("%s() PLL set frac mode failed for %s, ret = %d\n",
 			     __func__, clk_name, ret);
+	else
+		clk->set_pll_mode = true;
 }
 
 /**
@@ -240,9 +244,15 @@ static int zynqmp_pll_enable(struct clk_hw *hw)
 	u32 clk_id = clk->clk_id;
 	int ret;
 
-	if (zynqmp_pll_is_enabled(hw))
+	/*
+	 * Don't skip enabling clock if there is an IOCTL_SET_PLL_FRAC_MODE request
+	 * that has been sent to ATF.
+	 */
+	if (zynqmp_pll_is_enabled(hw) && (!clk->set_pll_mode))
 		return 0;
 
+	clk->set_pll_mode = false;
+
 	ret = zynqmp_pm_clock_enable(clk_id);
 	if (ret)
 		pr_warn_once("%s() clock enable failed for %s, ret = %d\n",
-- 
2.25.1

