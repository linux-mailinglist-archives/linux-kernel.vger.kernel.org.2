Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB70634E760
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhC3MSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:18:40 -0400
Received: from mail-mw2nam10on2087.outbound.protection.outlook.com ([40.107.94.87]:55904
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232037AbhC3MSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:18:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0dATeuIsEDaKw4kpOsa6QTCwR/mSxDUPPL2PfCBhZi8hcQB5lm2BBr3crpE6tNVpB7pEzLVGbx2ejoug7evO+dQVP8dUJ677q+aDVC9yTO3dDQ/rL2yO9ZTgE5JoRgILa1h77GpVMd8wNkyU53EnPhowxfC2/UmKfr4Rp3tGUQ44Xl5mFciS3MI2x17L+wrsPp/ez+V8acZwPnOa6ClOx6IqoJOowookeluT0BJfumBr+r5rN6QFeNfmRTHJBiT7mY2kG/y0zFYtFwyENsgE3nOz7dZ9W22/7p1y5cP3RqNXrDt+6c9B5VybjFAy8vRw+fRAWswkhIh2BDsbheasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK6DGXFvVtcUqFQ3U3o2te1UGJ5WCx728f/0asfrwKg=;
 b=L31b5g5hgY3CFvjJYvEKDGmfKmWFLpxMOaiRejlUGaJinYHWMhXDXYB3yRFE0R7qSk2uyrEU29AoW7HLQfX1l9x+/o4CIqZL2aVm8JfLbv6wLx52SMVzGb8n5cA99HJoMCe99m3QsH0Ax3nm0sGO2Zj2g+L+28THH9hsoBvjLgR2On7OXLoNzRhsXddqP7VAfCqHw1msEVkrPkFRxXcgrpE6XDOjxerx+gIvpegYJSPxD5lngVQxRQaj8jJkFX2H7bR3Fd4uI0iofeSkvhHEg+43EeCa2ppGlXzYHEr2CXTEdnLLIzTgNerNBhs001lhVWj4bX/wMj737ZvGqyKEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fK6DGXFvVtcUqFQ3U3o2te1UGJ5WCx728f/0asfrwKg=;
 b=IbqdME1PIIkBPe/5oB3bn4eUPr28uEbWRBt+ykzmhWXRqFaOIlLKWsr/iv9OUbi59a8UFCDFDwN5/7AkHZ2pCyo/ac/q6Uc4GY6sRAUeMNPuxmNAsrDOBXnAqr6AQaxb1jMSLZ8qFcfUoWGCQLR7Ho8UbLkaPqC8WC7nOpbvmPg=
Authentication-Results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2341.namprd11.prod.outlook.com (2603:10b6:903:b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 12:18:21 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 12:18:21 +0000
From:   quanyang.wang@windriver.com
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [V2] [PATCH] clk: zynqmp: pll: add set_pll_mode to check condition in zynqmp_pll_enable
Date:   Tue, 30 Mar 2021 20:17:01 +0800
Message-Id: <20210330121701.3258948-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0034.apcprd03.prod.outlook.com
 (2603:1096:203:c9::21) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HKAPR03CA0034.apcprd03.prod.outlook.com (2603:1096:203:c9::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Tue, 30 Mar 2021 12:18:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32a4b574-00bd-4335-8abb-08d8f375e854
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2341417D69724A730ED04494F07D9@CY4PR1101MB2341.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lvCrkxDIDObkArh0PO51eY+mVVK34hjJRoAbHIOHT94ARk6JXlV/DV/zws3zA79/TGRK8Oz6GqSovgF7ev1s2U1+xIRuIXz7E5ijxd17zRsXKpfw/LTLSq2Wia3zWPHBIWbzMuwO3uDT8StXWzCaVmqomYJlbh6nHGVzwZQmvpTv4F3PIAu4B+wFWjdfpREzLugNDWdSrs+zWHEe3zduTMu0NB7tcDhGmqC77YO9L6imm/9Brjj3PRKesSUXQz7EAA3wpl/DOC6lTS/VQjurlXmY0zuZTYL8dc9OKf9t2VFKhBg/rLL6zm6yYdTHYsGgurLHTkPI7ikDGirGMJ4QazbgZp7p7mSb+5u49OF9Y8EM+GSeoX0q0Ha22ITBL/oBrJf+kLB76I4NEImUkv/AcK13tQmMQjALnOAf/OFdpo1++lnXcmEzYGdIK0/+Ymg7Qm5/1K07BGvn2MJ/QWlAPRbsFLjaW6SF/OHVSaEST0ya5oIjhVT1dGcuk8pJNu1lGvvBw+ePLG+x2FCcBKVKJNdWumQ65EP5XStNOfxnCWFGBqweO31JJma1RWj3RJom6bXmJAHC8fVJbBcU2r8WEKM72hOStqVwVmbxAkGcnJrNtY7HS4mJtlAcyVnF8q3bYMNSKYAnxuq7u56TBdUU6lG0HrKTITdPtxpVRXGZzHM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(346002)(136003)(376002)(396003)(2906002)(186003)(26005)(16526019)(1076003)(36756003)(66946007)(4326008)(66476007)(8676002)(956004)(6486002)(38100700001)(52116002)(8936002)(478600001)(6512007)(6506007)(86362001)(5660300002)(6666004)(2616005)(54906003)(316002)(83380400001)(110136005)(66556008)(7416002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lzxe3/LTV86xvk2/0WlrUaYaoHJNfEQrEiyE98+RjdnLM/DJYZboxVugNpKz?=
 =?us-ascii?Q?KLZA6qoQ6wXLVAIm6wmu24s4XaSnzfm8EWlfAhJn6/0zk3E9kgR1Oag72/aK?=
 =?us-ascii?Q?YiGp3HXovlAmLs9su0WkPyChJiNKw53+itTxfaYoMbIqcsjfKSNQZPTbSn23?=
 =?us-ascii?Q?AqL7aZ7kyuMK871Kj+UEZtyGZt1KWq9EdxC/d8XfdZmpVJVeN57Po1P+lm7i?=
 =?us-ascii?Q?I1d0t1wTgDqCz+8d3YlE4eeDwAEGXFZ6lw9SP1Lgj+hY5g6CPeyLftuWqHZC?=
 =?us-ascii?Q?VWSNyowgdVahDgKdOkWN/tUVrhPDh27Xb/sXa5fxfA6NmIW8dw9At25hzRe5?=
 =?us-ascii?Q?x2abHnVISQvP/TmExCir4H4twkdiX/M3ljQRaIXX/iz9AKftX/zaNaOOckdo?=
 =?us-ascii?Q?hHVShP5CcZIWnn+M/6WFNg/osP32ARIDUM5sXudA1Ywl11WWc7Cf7UmgJLqQ?=
 =?us-ascii?Q?41JYy+U8r1ebXC1zmOmQtt8FFepImrf3cOGrVLpUs1x5G9QcLiE92U7OmYfD?=
 =?us-ascii?Q?I1VbbmOonsBC5w7xSVbA4mGY/gbshgPr7Jvd6yJKfAi6mn6haYX1Vo6AUK6b?=
 =?us-ascii?Q?YdnquxWlLjYkGAMN3eNxOo72mnHGdCaFuKqofkYRlwzeRXGpl1jvGb0p3MIf?=
 =?us-ascii?Q?1+Mj9ieil2s4ZtFdMJtmhNufUOv6s3e3huJcIRNS6wFhsvsb4wTKCNy+Zmzh?=
 =?us-ascii?Q?zd7HrS71Hl9C9GdgVUV1+c0sMlTFVMQmao/l8C/VEVQq4sy4eIK7XMotJ+sp?=
 =?us-ascii?Q?kIgaQH0wqWVqoJiGRl/MEEgSYliVRjAtL9YOwmkVYH7+d3Bn16Tn7yL6TekT?=
 =?us-ascii?Q?ZamncQAWyAMsd2g1tUiZeMwKzniRqEtC7lYl6yyRXfRPyXGFA/748nrnbwB7?=
 =?us-ascii?Q?nXx6MPxFp7DNvf1/iTipUt+Dv9dg5mILHJbbhnmyu49ZQElnlAzFemuWccoU?=
 =?us-ascii?Q?ktsYtaVpzu2/l87y/mK9pwkA10oDVwftovLdMoXbiLQnz0/GnjeCXqF6xbR+?=
 =?us-ascii?Q?4+CQP/EDUPQUR4Bl69AxZN3dBv/iL92uR+Rx3qLEh9ESGhblSQCccPAbxuTE?=
 =?us-ascii?Q?pciqz0P2ZqrBniQwjFt0HjgxqLPJeQysQGheKwZKXL5RJFaDfRh8amBKUvOe?=
 =?us-ascii?Q?LiRaXxU0Q4TKyOTci1goFmfOi+04igFMKNqOPuErhg2nklDBvleU7Yl34XTG?=
 =?us-ascii?Q?3mKxv9Fp1sbBSE6ywgZLf076VK+jfVhyv6HejYTnIuYFGu+hQRyKmLOTy3bP?=
 =?us-ascii?Q?Xp9B0IoHvBSBtVwXE+G0Kd72Xs7UNPJIyBuWuOHuqI3x3zlDL829Hlq2Tyl2?=
 =?us-ascii?Q?lq3YqusY9tdkeSXO9AHIO9t/?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a4b574-00bd-4335-8abb-08d8f375e854
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 12:18:21.2740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYqtE8FRGFDknmjlWFaMJQ7q6VkRkCLc9JS/Go7Z/7dnh6urpnyFMee6TuHim7kGMIjaqYYxAYJbdQTMs4Ii1XHQ2nc7pmktU4dZUZ9Oy3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2341
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

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
V2:
 - add Tested-by tag, thanks Laurent.
 - fix typos in commit message and multiline code comments
---
 drivers/clk/zynqmp/pll.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index 92f449ed38e5..fa89ee722a6d 100644
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

