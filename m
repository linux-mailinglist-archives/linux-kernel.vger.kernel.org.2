Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD03A34FC11
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhCaJCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:02:02 -0400
Received: from mail-dm6nam11on2057.outbound.protection.outlook.com ([40.107.223.57]:2785
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230080AbhCaJBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:01:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjXv7RHRTxusFa9oTEy/YsQnovy8gA/Adb12yk8BCK1ep/8I8Uw7hInNIi7pcrAHBStE2Wi4QqBq8RnnsF3VABMRTqRHk1UFg6RraTTfXAGY3505ebIPIUMSpE9vKmJmzZS9eYZZLj4m3fZyIWN25NTLZ/4436hN6/5SUrC0YO54h0+F8hXmk2FjFR4UO4aSxi5YQHAXe4vKVdOx3Fr++x6YyfZhuc0I4REp+dfug/ZmOyRDrWvaM2zpz6zfjGPpEAQidVZR9ga86bAcYBeNDQxHdUwvbymxUDO1AY9HDos98aIuMZ7RUcDian83Hf23/iezkwI3quLQvWvxEkenDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDIgI74lcm928aBXvOQxzC0bUUtbi8qY7krONRSb78U=;
 b=XLQ29IP5WViHtWhTj9Ro6d8Fnvv/EXNrWaq33J8pIaI0CsMTneA7fCteH0uH2qJJb6h6gG3YN82MfE1ijHRQR3e2l9Hv5620UnkEpnmy6wREW6VWzYZcRven1Osc/CjtE53gw8h/N8TlyTeryvBzay730opLKxfy+OrLVwF5ecHnf6BC9dyYFH6jllQbmkI4fEu0lGh1hb2ehHq8+IpLy2uYtQ5IXgsWK0nW70t2bzoOTXWMxDIdn0FYKH41h7Fo7YtfElohudf2mAQIuR8TkhduAYsiLr1qQ6niVGXwIzngdDTRPQPJsb73fu8LV/4r7+U8438InY34vdS7h1CX+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDIgI74lcm928aBXvOQxzC0bUUtbi8qY7krONRSb78U=;
 b=Q38CEcMa+InfERpHusOxiB2pwFU888p79YUrnT5Rhq/7hpLMO1xCDSvhA3OZIxOl421AZO00kNW9WBC2d5aKsTMI26qJl1lcNcVYkq3i2K2yWcjRwJTy8Ls1qGYNmf5tXQyQw9hI5V10F/RcS//un4LPc7Rs2uGzIJTU/GPbr54=
Authentication-Results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1526.namprd11.prod.outlook.com (2603:10b6:910:7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32; Wed, 31 Mar
 2021 09:01:34 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::d4fe:8135:d8fa:81c0%5]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 09:01:34 +0000
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
Subject: [PATCH] clk: zynqmp: move zynqmp_pll_set_mode out of round_rate callback
Date:   Wed, 31 Mar 2021 17:00:18 +0800
Message-Id: <20210331090018.3464094-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0205.apcprd02.prod.outlook.com
 (2603:1096:201:20::17) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK2PR02CA0205.apcprd02.prod.outlook.com (2603:1096:201:20::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Wed, 31 Mar 2021 09:01:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3a20edf-ce7e-4e4a-854f-08d8f42395b6
X-MS-TrafficTypeDiagnostic: CY4PR11MB1526:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB15264B93936FFA50B2A2A6D9F07C9@CY4PR11MB1526.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XzNciXt8cwJbDFRmcT+pWwF1SDJ0SaIKQsEJgSuzf6VpjMustyIwRtfSETatrXbj27EcFOD4ggib7yPvZI+yoA+f7tXxv6aBZ3B7O+nTBzdD7X5ZK3cVithefbD93kwSWBdgAH7c2TnZMxNphK+oabzWAMVhOLfbgbqtKIMwZz2X9npBnpsUSB/bSFgHbYXCuwo8TQh+PeSGWmHhEiYXHv6JQDb/L57c/GpK6EVQJCpYAGSYNpIh5PNo9C0FnAaHmBWJ+zY1VFUewOAZY/8K2ufKZTnqTVwPf149OJCUh2RHDLbvuVzZtojCMJQJBViRVMvcFITk/t0862JFzew5oama+0dKsLTfDc6Cy2xGskSxaEjyFWXW+xMTGPnBcc+/jC73LmLTeKbjSyO1W77x9pmPiNURNvSMcAmfrPvr0BzOSeLEsn3UjE15PF4pFa+RST86dKnhMnief7f/2HOHwfMqIws6aZaHD4bDLgOa0A9zxp4K3QPxPLIsc9NsPkQI0oI42lvUthpX8JqHxJYqmEvJawYeN0avGBsOwnZEg/fFdpX8DAdhitfaBumtXpLEe0sM+kSvak4IR3rTEqZU+CVhf4qkF+fXtVZBwEczZb1BpEUO4PJFfKQQwvacavBBYvmgdjBIVyrzLi2xu7+LBPpYDnmVVyCByCyfugtH2gY6FQ9QJ0YK87bDcGfBoySK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(346002)(396003)(366004)(376002)(5660300002)(52116002)(478600001)(4326008)(316002)(86362001)(83380400001)(7416002)(1076003)(38100700001)(26005)(2906002)(9686003)(6512007)(6506007)(66946007)(186003)(16526019)(66556008)(36756003)(66476007)(6666004)(6486002)(8936002)(54906003)(2616005)(956004)(8676002)(110136005)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hS+NVMK7MfNvBmX59mlTtgpKOO/o5NTYLv+BZ0WZqTRhzrua/h+OnNZDYZ3e?=
 =?us-ascii?Q?pcu/5b7M17+ZlrUXRqTDEZOZEvscJBoiE5uhyNLMRZbNaXC7XuYFb8ZMV43/?=
 =?us-ascii?Q?KltUTTwB/ihjR87aeFXhLZRH5SlUI1CZ/AYa1orUpCbjgUS27WoMdbw1LdAd?=
 =?us-ascii?Q?13RKwW7PFnyydclboBpgr33HKHR1ZL+OV7JyisvjGvjHem57yqPUg2pTZHHX?=
 =?us-ascii?Q?GutyWSvxe7CcNzQ6a/El4HnDDeptQjq9/BlUYhGalhhNXAxxnpe3SWLnINse?=
 =?us-ascii?Q?JMzG2Cvvt6dfji7VQiIynQ2bD1Oz8hHd3np9uAovWjJYJ23iQ9lUpguY3Kng?=
 =?us-ascii?Q?R5GPa59obGFFS0QKStRbcUkg+mH+fUtZF6NnGOsh4Tkjy1261fFzNbd4IBia?=
 =?us-ascii?Q?Ywnj4uYvVOKcUegq4gU7IkmYpifHd5INglGYFw9gX9h1VYUn0u3bX7dpZyUV?=
 =?us-ascii?Q?7IqdX4Zw7QoUPdaR1PpnbMIVyM+T6fCroNsQeT8iW96CRey5UAzh59Qk5cqT?=
 =?us-ascii?Q?b5bJvRQOJyMH6DLmK3kJLlwO1VuNYredpmQbruYzikK/ObJNPjF1P5FG4SJ/?=
 =?us-ascii?Q?sypN0LxzyGCdmrAFMxtnNUUZ7lb+WiprCeXFghNLn6vBiVfxk/SoWd2oa9ZO?=
 =?us-ascii?Q?/VvEopII0BKV0cfpfA+ms9/u9ypdz/8BwFBS3+yAo+kAFCYvd4kRa/Hgk4Ik?=
 =?us-ascii?Q?hgZPOxriT+NO/+v6IM0DEGdBhlOTkmhbgijHeP9Ur43sV+/GjXK3Lgzuc909?=
 =?us-ascii?Q?7yrLQ52VTfhRMINZYYdMF925v9i/p0GzJjr83fQ0BTWOwF86GP7InxAWsMoq?=
 =?us-ascii?Q?Ygy2O6WvdcS4jMld6oiwkkHeAmaGrWAWs9mvBHtSmJ6XFEJr5jfc90rLoceY?=
 =?us-ascii?Q?VPIDaGZjUzfkOetfo6w/1hwNLvuejkzhXCmcKaT0QvUXosgnl6gghZ/yTvFd?=
 =?us-ascii?Q?mtrHvwBZk5EAmdNN7fF0EA7UE5GgTxdV9icZr2ThzKXLPmmlXACRn3Ttl9R/?=
 =?us-ascii?Q?PNMMX/2ZhAxEc6uNJGih3ueotbdwkJQ8UfMS9O0wP4efpelDqjViAHkmiLKR?=
 =?us-ascii?Q?HCv6u2sdt6Ndy01dd2slAuQ8rEwoF4GTCA3vx0XwqjO3Kr994GZO83GuFMiX?=
 =?us-ascii?Q?y8ezvnPoP0gOJy5ZUw2r0ZPGaaP2CxuXLrGja5L7QMiT//W+isjd5ToDtH1W?=
 =?us-ascii?Q?oJdqlU78973Lr+VIPhdsVeEv7x4Diwre0i4I8QSxbmb1VMta7jHvdkbJaf4p?=
 =?us-ascii?Q?jh/8pyOjaQ80lBRLZnOA/NOu4GIJb3KHnxXmkPem2+vDYbPL/f5YUpNN5nB4?=
 =?us-ascii?Q?v3QjNmcVaTlimgAgH967P/BD?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a20edf-ce7e-4e4a-854f-08d8f42395b6
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 09:01:34.8083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3N58AO1q7AAbG9VemkSJqQVUTl372pV/YMiF/Y54pBcER0M28bxwqwLejYCaba2CAneCDznww3y/AZGomZWZG3aY70BS+PdwAX66Qya4RNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1526
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The round_rate callback should only perform rate calculation and not
involve calling zynqmp_pll_set_mode to change the pll mode. So let's
move zynqmp_pll_set_mode out of round_rate and to set_rate callback.

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/clk/zynqmp/pll.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
index fb16ddbb7e2d..1aea5c137b69 100644
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

