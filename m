Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AB93C7EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 08:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238159AbhGNGps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 02:45:48 -0400
Received: from mail-vi1eur05on2074.outbound.protection.outlook.com ([40.107.21.74]:17345
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237948AbhGNGpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 02:45:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSG12F7+2mUJ/8GyOfCBkmWc6RMVrt4fgytaMJ15cDdXAK9iQaixcGdPGiaeba1BSxBD8E6pYZvSDV5CfabGVKxdYP2fCk/7gGYs763f8msGWyuAuz181R5fzd7pMv2HF1XMDypiTJTiq/A/AiU+454Qo671DulgC51am3rXmhN61Gj4MmUbNXOTJNNNqEt45I+rbCgTLTxrM3PoPz2rDfgYfuiow+c1UBqXMi00g/iVTgKCPBJt1ME/eZ3IdQz5yPLXX1tw6hMVdd/CH9L9De5ffZUf8uRGA5zsulsJy0PGrq3bXoxXhsO7BJO+xRPw6Xu8A3eH2dcM+IVwLBGrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLYDlWzqdA2sBfyGBYYAfzZj+pUhlMJmvlUdGjkhHMU=;
 b=EYYt2MCi006cZx6NwkdbjLQCE4BWX79gYcx/fJ91vfjBnacmVKn3qVZIkPen1spbhlEBAZWS8fgar6FTVxxvKv7fWOtPddJ1gaDjzDaxxLigBBVPApoelGKBlLVkrA0mdMbcn62qFa2B5TtnoJ+oxfnWX7XoqCGh4OOtR3QzpK0ipA2KNZrvQCWz95lUaIoac6DsGOJOLX7ELmwaz7EQ496Frrc4ClMdjrK51dQGW0o3mmBIYfmSDKIqeTgw3/VWFfaEHSDt3TrYtKEZrYA9MCVI6SXMK60pnDGTLM1rXzAjUUWJjAjZDb/i2+vdoYNWvecBZ2marOA+cCSO02Xjaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLYDlWzqdA2sBfyGBYYAfzZj+pUhlMJmvlUdGjkhHMU=;
 b=eWSqdiY2KKTgpzL3TFlHPej/Ik9RxYY39h+NLNfYE+OzpZAm5h0JkJQpjmzY2epW/Abatvg4h442DqCYV5Y4ROfj2xXWe81wz+ld1pFQ2bSWkch+t6MtTgPxCzm4gClhtgybquSelJ8OodAMAMtZ7lM9JbE81k0GSbi5l9BY5+g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM6PR04MB4455.eurprd04.prod.outlook.com (2603:10a6:20b:15::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Wed, 14 Jul
 2021 06:42:34 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::1d4c:c3f2:dbbb:88f2]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::1d4c:c3f2:dbbb:88f2%9]) with mapi id 15.20.4242.023; Wed, 14 Jul 2021
 06:42:34 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [RFC PATCH] clk: fractional-divider: Correct max_{m,n} handed over to rational_best_approximation()
Date:   Wed, 14 Jul 2021 14:41:29 +0800
Message-Id: <20210714064129.1321277-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR03CA0127.apcprd03.prod.outlook.com (2603:1096:4:91::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.10 via Frontend Transport; Wed, 14 Jul 2021 06:42:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fc58e38-742e-4634-0c5d-08d946928fd8
X-MS-TrafficTypeDiagnostic: AM6PR04MB4455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB44557D0B5F41E85855B3E80C98139@AM6PR04MB4455.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MUL8/z3vMY5J7GayXSTkj7dHp1MLBIEwa8kzPoKFD1mKprPxkjPTa/8z/1Su4KvY2jFtISAC1+tdk5ZuwUD6xQUcRkZUP9KJOuPnGy+uUaII5R4AqHr1IqYwu/RTU5jpClEUi2fFTLh9MVeUNiksZsAlNm4cd6bPgcWuNe9gjrKhCcVXaerjDQZ4saiJdhhqnbZkHjth8us3qDsRiSQLye5/x0jeHajz54zrkPpFkSZDth0rfW9SZXOSxtRuCWeHzUgCBJRDvktdP0+iF2s4YHCdE6OLk2rI2XBNJy5N92IwYi8fDXw12xzgVum8fHomxSWC/mVNFtq8X+uaF3ytI5txZO2iLhLTRaKRuTHcjLV+cwvk++Ncoo5c9EEfplo5u2NyaLMjUun8MOobYK+UYmmkaWuoRFGO7Q31K6KSDmfKj+Rfr2YQlYeTQMRVkTZIYlHOUWpIwiHSAGSdpTS2aZLcAO04bPOuWcjwsrwscb5q5GGwpedUuAGyWHNM0CPKc3fI38AER0naJnNqLusaGB+rmwBdhg+cVTVkxIBUGC7y/DxN7Vd4K83SUT64kuzi+2MpG4qtLcByoX37beW+oAyQEqBD3v+f7F91egQFoyjViYSx6MKYbCQhEG6+a4LnEDtFOyBrOPvzimEEj1l76QU7Bn7jYdeFVMLB2id0iRLsOiED+tXsH13eVlQML3zHC63wcfI0TTANv7R6OJViA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(8676002)(83380400001)(956004)(38350700002)(2616005)(5660300002)(6486002)(26005)(316002)(52116002)(38100700002)(8936002)(1076003)(478600001)(86362001)(6512007)(54906003)(66556008)(6506007)(66476007)(4326008)(36756003)(66946007)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kAqJ7TRpXCgfKqYOvl84ii3kFKqldy76mI/K1EmHTQ2plFywhV6U5HVRPLBW?=
 =?us-ascii?Q?aBneCeITV/+1FBWP1/JjuZclRM8RGgn7C32l35u38JK4uL5Hrce8Y/JCyGbJ?=
 =?us-ascii?Q?rYQ84v81upwYXqH7zgcT6pUuf/CRwotgyaWvfea6OmVDK+fS3ZDnHNtLsesk?=
 =?us-ascii?Q?VxnImRrY0Ll1ByayBIH5QAEc+UX2vYR8o2kxu4flKsGishBsf2yAOzfYjvVR?=
 =?us-ascii?Q?gT3Tmy8I2y7/EIe9WeTZou4uki9j+xY4vnldBaNkv3uyZIRrDICUVIBj5oNC?=
 =?us-ascii?Q?c9N5foMekYd2d6lqFchsxnJYUnrX9EPw5EYiK2jAjLGIj6A0wc1qqsTU+YGg?=
 =?us-ascii?Q?OfZXabcIOTex17aI8HcnOxlnmbfiXdaCjveC615bRSsAyg7zAoD2yQNPcled?=
 =?us-ascii?Q?DMPdlLuToFsA7jpxJS09Lv5QQ85A0yu28hFBG0iM6YHqr8ZUknbUFueMUwHw?=
 =?us-ascii?Q?Zy6wSSIysExQbC3oMgO+OadG58j3ZGONAGCYVPLOzERTvtcRWZ+6Y3O41OKD?=
 =?us-ascii?Q?MOWXsXEWT0H4+/zTTdO/DPobLbs4rPsnk0tlPf5ir+wgdRd9Iy+HLKaLg0bn?=
 =?us-ascii?Q?VLgVWa0XnLl3For3y7QM4jwOxSwWEEoUlMqdxiFpLZHI4k0SrRwrLrvQ5Jfx?=
 =?us-ascii?Q?Ra+mVTXP77CJgpcm/9epgpBfaAfkGNtMXV5beK9taoFqFUbRh2OXMzX33ajx?=
 =?us-ascii?Q?Bs131xXBMiQ2tmnlcEqXlolc8huYC/rZ0L0+KOmC7PzqyNMyJn0Xb6A/UlSQ?=
 =?us-ascii?Q?MBnGhG51tu33WhkvwfxEM0S66CjrOiMi3kPoT832muS0b69mAZANOCmfxasX?=
 =?us-ascii?Q?PiV/CjdJ3Pd7cKUJtk1PFcl9UD4G/qyaeNi6h28t/SBvbxNUCPUoX0MijC9O?=
 =?us-ascii?Q?6lWP77wmb43i8dUnDRZozoe+MK8ax/UV5SK8YDwS/+wkY9uSg2LJqk/K/70l?=
 =?us-ascii?Q?gxW1BIIaiPnziGHwwdPnctzOc43lt40hVVaCZplc7iZU7BaQxGw3AKw7dlsQ?=
 =?us-ascii?Q?7/5AZLv9yXvKIXDoFNwDV9oLqLDHVflwE/JPcqi5pENUk0Qb9MjYlZOmZv2u?=
 =?us-ascii?Q?TLX8P1G92k5CaXvzZQv+nIlXQ4T2h0CsKJBsKf2LMaYtTEURJCsfZFM4S7S3?=
 =?us-ascii?Q?NCFGTyg6gDBIiCyVOw0c/mXiS0BQQnvYBRa4p9MwwBaQnTZTzsv8DQXL2eXm?=
 =?us-ascii?Q?232ufoqJCflaXkCki8MOE81AVXfs3BtYHLvNAXmtYg5CqNafy9A7G++ut7Ol?=
 =?us-ascii?Q?ok2cWAkFIh8/RIZDCEa0JnvFGgO9OCRNZo4J8XSi3croQyckV4yEFi7a4mOu?=
 =?us-ascii?Q?wHSWQ9tpyjggPXjMdWCIvdtP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc58e38-742e-4634-0c5d-08d946928fd8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 06:42:34.3609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+xW4xVVuGcZydXMyp5IYrZnakm+rCBustdIq++fr9pp7oIDVPhfyHyzS1Zyagw5vdfKMYXhKYORkcGrNnXsMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4455
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a fractional divider clock has the flag
CLK_FRAC_DIVIDER_ZERO_BASED set, the maximum
numerator and denominator handed over to
rational_best_approximation(), in this case
max_m and max_n, should be increased by one
comparing to those have the flag unset.  Without
this patch, a zero based fractional divider
with 1-bit mwidth and 3-bit nwidth would wrongly
generate 96MHz clock rate if the parent clock
rate is 288MHz, while the expected clock rate
is 115.2MHz with m = 2 and n = 5.

Fixes: e983da27f70e ("clk: fractional-divider: add CLK_FRAC_DIVIDER_ZERO_BASED flag support")
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
The patch is RFC, because the rationale behind the below snippet in
clk_fd_general_approximation() is unclear to Jacky and me and we are
not sure if there is any room to improve this patch due to the snippet.
Maybe, Andy may help shed some light here.  Thanks.

-----------------------------------8<---------------------------------
/*
 * Get rate closer to *parent_rate to guarantee there is no overflow
 * for m and n. In the result it will be the nearest rate left shifted
 * by (scale - fd->nwidth) bits.
 */
scale = fls_long(*parent_rate / rate - 1);
if (scale > fd->nwidth)
	rate <<= scale - fd->nwidth;
-----------------------------------8<---------------------------------

Jacky helped test this patch on i.MX7ulp EVK platform.

 drivers/clk/clk-fractional-divider.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index b1e556f20911..86e985e14468 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -30,6 +30,19 @@ static inline void clk_fd_writel(struct clk_fractional_divider *fd, u32 val)
 		writel(val, fd->reg);
 }
 
+static inline void clk_fd_get_max_m_n(struct clk_fractional_divider *fd,
+				      unsigned long *max_m,
+				      unsigned long *max_n)
+{
+	*max_m = GENMASK(fd->mwidth - 1, 0);
+	*max_n = GENMASK(fd->nwidth - 1, 0);
+
+	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
+		(*max_m)++;
+		(*max_n)++;
+	}
+}
+
 static unsigned long clk_fd_recalc_rate(struct clk_hw *hw,
 					unsigned long parent_rate)
 {
@@ -73,7 +86,7 @@ static void clk_fd_general_approximation(struct clk_hw *hw, unsigned long rate,
 					 unsigned long *m, unsigned long *n)
 {
 	struct clk_fractional_divider *fd = to_clk_fd(hw);
-	unsigned long scale;
+	unsigned long scale, max_m, max_n;
 
 	/*
 	 * Get rate closer to *parent_rate to guarantee there is no overflow
@@ -84,9 +97,9 @@ static void clk_fd_general_approximation(struct clk_hw *hw, unsigned long rate,
 	if (scale > fd->nwidth)
 		rate <<= scale - fd->nwidth;
 
-	rational_best_approximation(rate, *parent_rate,
-			GENMASK(fd->mwidth - 1, 0), GENMASK(fd->nwidth - 1, 0),
-			m, n);
+	clk_fd_get_max_m_n(fd, &max_m, &max_n);
+
+	rational_best_approximation(rate, *parent_rate, max_m, max_n, m, n);
 }
 
 static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -115,12 +128,13 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_fractional_divider *fd = to_clk_fd(hw);
 	unsigned long flags = 0;
+	unsigned long max_m, max_n;
 	unsigned long m, n;
 	u32 val;
 
-	rational_best_approximation(rate, parent_rate,
-			GENMASK(fd->mwidth - 1, 0), GENMASK(fd->nwidth - 1, 0),
-			&m, &n);
+	clk_fd_get_max_m_n(fd, &max_m, &max_n);
+
+	rational_best_approximation(rate, parent_rate, max_m, max_n, &m, &n);
 
 	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
 		m--;
-- 
2.25.1

