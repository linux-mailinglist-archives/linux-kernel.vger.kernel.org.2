Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0B434198B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCSKI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:08:29 -0400
Received: from mail-eopbgr770079.outbound.protection.outlook.com ([40.107.77.79]:52366
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230160AbhCSKIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:08:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW1yj8mRw+erGe13TDuYNeOxupvMDScx4sE7a2dHuIVcwwEAreQtndBWjBQ4Y7ml6+jq7O3XKyuW6EmttPyI5g2B8pHVO/PX20ZYbUW3RdvTUxFjXS1U+LtpbPtpWK8Vss6LzhT87zcWoH4H0ZY1QhpyLGbiFttUgWERxE46lTLrTXWXBnYm9Q1T9qnhsdFFD2y3TjBwlHGTnkRGDaOrPMBmfB5c8zA7kuBpwJrMWxQN1fhfE83QoKFutUHf/U/XfquAgykOtOOrnC8P/xuq9/KTRJBThVq9vc/6V766P78PEYfGGZ9+VG+VvKWDP8mJ6KVCRbkRcSr/Wb17H6PLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5N6hPyyDYZHTm0mVBK41QqtKjJ+EtEw/77aH9OeUUQ=;
 b=RL4O6aVo/KND5j9LLxPK7DcqiASzuhYgI5D4Ek2fk1Ls0yefFXCNsPtTP7CkXpin+FrUxuuR4AWu4RxzJGGpUm2+RkNqypN2rAFNbwNh3KIWh6rrnA69HKXjGgU3CzqyZEHkad5JWKxcoVO57P0C5X8DOiVGFaSgw2vfniGfnO1Hb9BXJP6ej2OteEfgKRMSYIHY+SiUQ2AKc5R7e6+kPGjCPZGr6Mm1iYfPZopnNL761HKD5+VOIRpZmh7ppz14ktBifP64TVxC4eisBkBIz9h6PoDInrnOnS5rmsgBR+Se677rbfCMYAV8xPaULmAZkRD7fyfKY0HNDRmZ0P1gyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5N6hPyyDYZHTm0mVBK41QqtKjJ+EtEw/77aH9OeUUQ=;
 b=aCj9H51BmBAOcuXOdKMVUgyunXITLXayjjUot2Eo3vf6dU2ZX4j2pIFzXRQUAzMQ/E0urSuxNaFa7GLUym5hQsAlkcAQe0u0JOgsehOXzKVpCBleO6YPtzTjYteCAUevORflETvQbBpob2th816duV4NsJkizxKqAkJdQTN9DJA=
Authentication-Results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB0072.namprd11.prod.outlook.com (2603:10b6:910:76::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 10:08:17 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 10:08:17 +0000
From:   quanyang.wang@windriver.com
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clk: zynqmp: pll: add set_pll_mode to check condition in zynqmp_pll_enable
Date:   Fri, 19 Mar 2021 18:07:17 +0800
Message-Id: <20210319100717.507500-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0025.apcprd03.prod.outlook.com
 (2603:1096:203:c9::12) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HKAPR03CA0025.apcprd03.prod.outlook.com (2603:1096:203:c9::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Fri, 19 Mar 2021 10:08:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b449a92d-d76a-4040-39d9-08d8eabeeaa8
X-MS-TrafficTypeDiagnostic: CY4PR11MB0072:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB007254FE7B41FBD640F3671DF0689@CY4PR11MB0072.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcX8yb5hbcCwRqzKj5atImhQ3xN+vilwZWESMmH+TRS9oO2oS8w40mRYjY8cU6YWzcKGA6FqFOtjYw29aCj1jxSbzYqMLa1Jx3ts8dXouDwUnN/qJk65iJn6ScY6NxxR7IPCz7KF23ALxQ/yIWLCLhNao/H4kvaxxd0TRz1rPN3AmSymphSOfmBBE1EJutLs4w1sjIzDZlZQMtZfNkPLPoGPoglxtq8yZHe0IzXFVVA12hA7TsNgGbjTwmhXO3+NTJf9PyXEZ6qoLoyErruNaIiV1CUg1MIVJz8wBgaoLD+UUaK3Qv14wBvcLMeeqRBHKejH7Gmp2VYQHR+cw8tvLM+TS7Wid1E1aE9eQcG7YaN5HX/CKEpSCGmQHfnMSdZ2IBfGaH6M3T4FbH/7rLDbgu7CK3NIPxKDfA6EF8N4KaVwkuXH8iKXHDrwWiS9PFboM+aUME6dLlvCzujKhkOPEu+KDOqXRD8hGJHUze9A1jtXKNVv5qo0JIZHuvVNs9DKtggwMT31dxcSyLzNKdiMgl3WEFaTqyzKqqG7T7iAVlO+RuPEfi35vZvK3XCdpWLLJoPscLMFyCaidwqdqjcnCVEqjt49VH+XpFIzekUqEuqVQkhlMnXUYyJ1T1x334y9PJqx9Pc0akcIWYicK5mfBWwxFkAqleIUTsgAe1D8hyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(346002)(366004)(136003)(396003)(376002)(36756003)(8936002)(316002)(26005)(4326008)(52116002)(478600001)(6512007)(9686003)(8676002)(86362001)(54906003)(956004)(110136005)(2906002)(83380400001)(66946007)(66556008)(66476007)(6486002)(2616005)(16526019)(7416002)(1076003)(186003)(6506007)(5660300002)(38100700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MvE7xU/h2O0fI631dpqoiW4AsSVj+krJZa56+EpEqQ2yuu53lmrM9Z8HPCrK?=
 =?us-ascii?Q?7RPw1q6kcy/OGkKc8A/iUdiLxZ9eiV+lk4PTBhNJLQTZqSwObEq6q4HvOtN3?=
 =?us-ascii?Q?FscWoAjvhHXhwEPEE7EJtByJRbpViE8ikMYKZx03fcbyoekfsvRjCzHchm0R?=
 =?us-ascii?Q?LizWGh1aMSRjdkwm5Oz1UlwRYx0c1V9WhFdsdsaIrBOE0NvwwJ12aWLjRnch?=
 =?us-ascii?Q?djB+OMxHhhvS1QBIDK1P6JDTnFau099KNevfVlAhJkhOogdKyTanA8jFDNhV?=
 =?us-ascii?Q?lmfNHiIxFBUN4uBiF/J8ryhHMyS9BABx/k3pDejcNpocBWhOBM4XBjYD/RKf?=
 =?us-ascii?Q?j9r1GECUpd/onbRk06jsLAaQClZ7eXa88m/j8bf9L9kJBpdIuKbpUngrNr1m?=
 =?us-ascii?Q?0rd/21TA/BUxUZNB5BiNp9fJcmbDl6NQX0UnmqqOVCseYKR0EPkk7kV1lb86?=
 =?us-ascii?Q?Va97pqCQ76B3CrHIGMHClKIgXFXgmIetie/fyey9yU8NrfJs4YbyleyrMLqg?=
 =?us-ascii?Q?O0iTNKM3CBd4cW6l1puJ1wyjyVCrGr1c+oSXyhRVtklbRDTGAskhAaMalgN8?=
 =?us-ascii?Q?sgH3VgL3pRaYmOQO5N+Cn04o2TG4wFBpfKHKni/sHQKmI31ZXKzHYB8c4wGD?=
 =?us-ascii?Q?KBSPQpGUIVxWB20eZtvID6gGfeIvvadbxG91hq9eARgBnJcfoNqNw13vC+fA?=
 =?us-ascii?Q?MuRZiTelNoc/05h4UHzMWm0aqcAiwXhsgikc695jV9Y6YOag8HXpH4EIHxb5?=
 =?us-ascii?Q?dPjAx/b8IBRUGdkMyd7wnragzQ+CmGZmtl6NnnKFOnr+6cQRHhty1j8voKIc?=
 =?us-ascii?Q?KkoOvGSDTCVJfPkj5PbVVofofbZlGucH63KfZZFzSDeQwRLyCtHuBBBdkX8j?=
 =?us-ascii?Q?qHItBfQJO+DuXT3lmUjk5lEk52wFEZJHhmcR9P4qIfNJ4v3zZctLCqvy11y4?=
 =?us-ascii?Q?fqpWAYx8znIRyjVu/Zj5VMFOMSlsRsIO2SiQAJ7T2Txqsj+WfQvHKMiAfuaI?=
 =?us-ascii?Q?9CB+GokqIRgBTFPA9VLUqWYA2LBxFquAA2oy/cwDReaMkAcXRxmJWJFoAXDC?=
 =?us-ascii?Q?vWokoOTrWNsoC/5CRwarZQdpioHBPU4VgnQQgMBAui8mPATeG8T3JS5EYkm9?=
 =?us-ascii?Q?iupuNfWe55RlkLtyWl39NRVnU2WK48dkz5ymsnQOgQV5HOcMvu9+SWuPqQ82?=
 =?us-ascii?Q?tRRDvRz0FJT393Z3x3r4vcIvePub3CcDnZpksIOjTpJL2TCfe16SudEh0osT?=
 =?us-ascii?Q?J2/iuT0zDxQEvtVw19WKSWARH+0wGjRsmELqPULJJg+CfDuSYmQL17Sxz1ML?=
 =?us-ascii?Q?by+/eXjofh1rgDoCnEaMcKXZ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b449a92d-d76a-4040-39d9-08d8eabeeaa8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 10:08:17.7032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLgHuGDFa8n9cXtBYDs7FW1VIEn5KBLGef5Ce+nyD+JVGYksC6pzywKTb0+G/NCgmKm13C8p6vD2WgUNJ5I7iQI8Zm3ht6hOH8zpBuUCv6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0072
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
successfully. So adding set_pll_mode to chec condition to fix it.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/clk/zynqmp/pll.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index 92f449ed38e5..f1e8f37d7f52 100644
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
@@ -240,9 +244,14 @@ static int zynqmp_pll_enable(struct clk_hw *hw)
 	u32 clk_id = clk->clk_id;
 	int ret;
 
-	if (zynqmp_pll_is_enabled(hw))
+	/* Don't skip enabling clock if there is an IOCTL_SET_PLL_FRAC_MODE request
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

