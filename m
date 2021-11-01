Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22A44411FE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 02:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhKACAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 22:00:48 -0400
Received: from mail-eopbgr1320085.outbound.protection.outlook.com ([40.107.132.85]:5280
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230234AbhKACAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 22:00:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2Lrfuh2s42tRWizTlsTuO5a/EnbT0BRHMiHv0tBFiCMBNsB8D2hfWCw6fXH4LSb1OXUd07m95AOInFAtZRKo+e49Hqt6haanKyPRsyljkLWAOiS2IZk3TH+Hi1fXmhUSjRyPPt+1+PGoXy10MRQZ6TiPSNxBL7BydQoXgxGXlPBcqZvTPLxQw4w7DCLB2m20kVOB+mGV1xcfx7jt6STJWabb0/sZuAWr+WC9Ir6LHfBH5oUSLND3KJ+8lzojHQBLcdardrPsZvsar57gU59/mGNz4FoMEU4VjQq0IonUeQXYAcVuF6SyJS8WJeC3Og7B/sGd2c/WLUdAtaUdK//Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xc8x4mocXxfJqfffI3mfQKW7znFLjHgxsPY1Kmajr90=;
 b=L/ikM8sRLCIQ7VvHvWH6FaEoF+bM/ddZfaLgJ7FRi67mQlZnpVkQQLrVbDN1t8aTmn6htwRdHzy0ttnYPd5zHgOij2I3VukPCs+iKqYRdeYYiHIjSdmpfilBjnJ8LZAcpPXa4iRRITAOCTh7ODLQAZiFyvIfFC0QGP6S2kGOjXHEY1kpSqW42TBBTkasG2b8LnWzA70KVSNb4vaBJSfvtKHcTrRPbInwewlK5SkgmzIhQKl3VprqPkzHHWnWvclZ7uBMTB2wBpQW4RuT8EUrcqKCPWcl7ExSYsN4zm7ZBjEKMkk7bQQRbOKOTftv9XeNVzlmksxSTek67dHwPhAr+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc8x4mocXxfJqfffI3mfQKW7znFLjHgxsPY1Kmajr90=;
 b=ERQdwgMtU6BEXXMt/4I/rL7JdNnwPzEieH55OfeqFx+7ePmVxX+Xt5tKHrD8t8AVhnAkWVD1IwTqPEo3yaySwA2qu3QkEyHQtXA/WYFzol+6pu9M1d0g/upyUlYSLIquISCEd7k68G/SAvMqhgoh1bOY1fQ0ZKOL2l9C46QrzVg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from KU1PR02MB2536.apcprd02.prod.outlook.com (2603:1096:802:22::12)
 by KL1PR0201MB2120.apcprd02.prod.outlook.com (2603:1096:802:9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 01:58:07 +0000
Received: from KU1PR02MB2536.apcprd02.prod.outlook.com
 ([fe80::8132:4e3:4879:62e8]) by KU1PR02MB2536.apcprd02.prod.outlook.com
 ([fe80::8132:4e3:4879:62e8%6]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 01:58:07 +0000
From:   Qihang Hu <huqihang@oppo.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qihang Hu <huqihang@oppo.com>
Subject: [PATCH] usb: gadget: composite: Fix null pointer exception
Date:   Mon,  1 Nov 2021 09:57:57 +0800
Message-Id: <20211101015757.290350-1-huqihang@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0053.apcprd04.prod.outlook.com
 (2603:1096:202:14::21) To KU1PR02MB2536.apcprd02.prod.outlook.com
 (2603:1096:802:22::12)
MIME-Version: 1.0
Received: from localhost.localdomain (58.252.5.71) by HK2PR04CA0053.apcprd04.prod.outlook.com (2603:1096:202:14::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Mon, 1 Nov 2021 01:58:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 723fd4ef-5d65-4f74-aabe-08d99cdb0c74
X-MS-TrafficTypeDiagnostic: KL1PR0201MB2120:
X-Microsoft-Antispam-PRVS: <KL1PR0201MB2120D95DFDCE4D787FAA9C45B08A9@KL1PR0201MB2120.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SuQurvToSQ+dauyPAJPXUmUxq5NxsR6dHfZtFls/ZxFuNx8gbQicAtoybhdsCO800RZR3lzKUadIQREiBhzoI3yHgw9yb5+BB3AokU6n0bJDUA0e3haISlSn6275EURmqWEymekJVQIWYnXQuT/Lkt9B9WuaLuax8CG+7CovFJUAMD03MK1pPLds7yYwJmgG/T7pttZAQ8Bw2Wm43+fSeeTLWpATXNQ282/GaAghYeGrNsO3qILDvaPg60ZZuk5P65U2eDGg0oC31WaX6oA3giNfmkFQ5XN0XmOeTr35zi8TJnePiEYW/Jo8es3fnSb0U2F5HwDHncyTtCi4hqmcX7xEQrn4Q6EIEFyyTYsHa1LeBQ0QuAcZFtPDT7UfQZwFYhSZecz95L3Rk2u9ax7ZpNwc6dGOgrPSPTx8Ifwy00eZrfNn8YDZwE7l/Rqe9wg19zBcOs18/Ecte3shu3b4LYghu5AH8XcWjMoO696GYo3sJo7X+5b45fB0aAzzI7uBfyjCU47r6Dvjdx/+whSjJdPztZMnaSw2FbmPeYV0Q5CclbIU6cg1EF0lRwA8tKItPp6zXFUFhAKYoSEy9CVmhJLOvl1peTd6k56ddzEtmgR/xRoGnulJ/osSqCUky/FwDEF4D9OMLudcuONJb/Xt3C7FFCiLkh16AU4pwed1p0UZfTuIkk8OTzWdHNFO0u5J0aX69g5Xci38eUJ6DP3JA7LUvXkYCGiHiMfRoNJ29hw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1PR02MB2536.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(956004)(38100700002)(1076003)(26005)(6506007)(38350700002)(66556008)(66476007)(66946007)(107886003)(36756003)(4326008)(6666004)(5660300002)(52116002)(86362001)(316002)(186003)(83380400001)(2906002)(8676002)(6512007)(508600001)(6486002)(8936002)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8QZ/rhdylKzTWklRQOaMRZuPN3U5pazPyVO+AdK7TWSo2CAAiOG/miXFyu+g?=
 =?us-ascii?Q?sqMsWYYzgyQAjcOXDTpBij7LBqgt6OTVlcVLokx0AafvYeyR/r8cOCDSbF6I?=
 =?us-ascii?Q?JvGTDng/CYPA7JMcjbfvCBo8YlnNvl0NIfRJLtmN588i3i1xDwSw2/11IHma?=
 =?us-ascii?Q?QmM745j7W23vaUxDQ5yuMboCwxB3mqxnLxhxsCmz0zT6mBjRAVsXPtytJA3F?=
 =?us-ascii?Q?xvhsBBi1NNFnkwrs1u44Lis0nPB5NK5L3FdwJJdGGrdLasAAAfQgN9hm9wyK?=
 =?us-ascii?Q?9A0J1m1e1EPo5EWZtY3e2OeTIcI0dZhmifzQizcjsd50C0qRmjd2bp9Gv/7z?=
 =?us-ascii?Q?37ucK1J/IssiukN7DxHVfdAjasode5eVgK7FdlYbZJYkChMdrlhagKtq3o6/?=
 =?us-ascii?Q?k8GQC/cF6qOv8Hya86FaEtTt+QAiXvM9W2nyGUhyrqsmfOvZdyQySB0zNNwK?=
 =?us-ascii?Q?tXUHWeBrQc1VTM4tf3HgSisHNdznestkpC9WgLKcKqBwCRSxO33wNYi0zhR6?=
 =?us-ascii?Q?DBq+bwYOaKcJZcf0pnFk31czz0R7PwGjNmc442saPbWAb2Wk+269ZFIT0Usy?=
 =?us-ascii?Q?Cjof52lIuThY5rMTIXkQ1uf5LhfaOkmDjZwjyJRWJEw6sbPtoTV8mkXjEw7T?=
 =?us-ascii?Q?/AWP5v/GWwZ0qNd/iynAFHSmq93Y+Ao7IgtEp37R6GcZgTwZFwQtqShW8oH3?=
 =?us-ascii?Q?+Xvj6tsyrJKyTKq3d252fMj1gzLqr07LJdq1hqg1b17Z1aFA20yH91onBQ4s?=
 =?us-ascii?Q?7OV2sCMWopO5hfxV0lfpuiSlQKt7f8m38jha35s0G6A6x/jHLRGfZ8+TiFdX?=
 =?us-ascii?Q?osk6R87JVKZTAO13aL4cTVkeoU6LzQKfI8kgb4O4e0qodCM7ZwF1BAZzEG+G?=
 =?us-ascii?Q?svrw0VBMrUhihx/riquW97Nnihghx8KgmbRQiJsuoa5nD8Fb0oQlrccNiw21?=
 =?us-ascii?Q?irqdbKmj0ElQK32tqjDgSc0mHyfwctaxweNmlSZj4Sg2dQblg3Z+xuaiRCHB?=
 =?us-ascii?Q?IFfV1eyKV3dC82seHcpyjQzLCwx9gCiV6dp/bvEpqKkWzJwukz4G8Gp/Flde?=
 =?us-ascii?Q?Uuw6/nmElR/Ec6OgobQ7yJCujqsPwbgpRkuTnYr8uZZKscv6L66XLhKHO+5+?=
 =?us-ascii?Q?F7jvqnnpfT4tPVb4IklEO/S2E45ndVcLXmQ/EBMg8qyYNmem8ktP0vuzoySh?=
 =?us-ascii?Q?UgTsyR076BsKSD1v9KQ3A37HosN1EhCR6+x2ikPoqg6Ce/83+6dX1WTd3rWc?=
 =?us-ascii?Q?1OVfWeO8WTKHqJmUA7btQNbDTCKlHeL0j6+vh5Kj5h+BzDehbk1TzLCzeggl?=
 =?us-ascii?Q?dBaGqAG4NvQS2WFXXqx2cyD4i7q5SYDKC2HQvsRq8qw/AYs4cL/xlripwEef?=
 =?us-ascii?Q?b66jJd94xLflf8wem2lzQJGoE0kQl4HQJ44h0UIM/+Nkgu6rr/ZySFgBAO/D?=
 =?us-ascii?Q?0PWtcBM7xfl5d4f/JhhZeMfcuIvMvd1Kqfs+dVOtQyIrKKlt7iEwy5Z92RgE?=
 =?us-ascii?Q?zXlejkvid6tg3T5z5b1lPW/U2YnlCJUwV4NssLmGCdvPABc0ci6AryOlfjvj?=
 =?us-ascii?Q?EOCf83hqR00sni02cdFlvQ8jBNJPlaooVap83UGXtDiRx2XAavjhceNzTS8R?=
 =?us-ascii?Q?UJ49L8cdpUtj09Le9zoLx7g=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723fd4ef-5d65-4f74-aabe-08d99cdb0c74
X-MS-Exchange-CrossTenant-AuthSource: KU1PR02MB2536.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 01:58:07.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmuQChX83LBpR2NmTFD8YWXjupf3AoCZ/QsNKffdXyGrzkZ9bgf7GUP8SD5gECdt6YXJj7a8CWe0WZ/U0yLKgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0201MB2120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the config_ep_by_speed_and_alt function, select the corresponding
descriptor through g->speed, but the interface driver may not
support the corresponding speed. So, we need to check whether the
interface driver provides the corresponding speed descriptor when
selecting the descriptor.

[  237.708146]  android_work: sent uevent USB_STATE=CONNECTED
[  237.712464]  kconfigfs-gadget gadget: super-speed config #1: b
[  237.712487]  kUnable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[  237.712493]  kMem abort info:
[  237.712498]  k  ESR = 0x96000006
[  237.712504]  k  EC = 0x25: DABT (current EL), IL = 32 bits
[  237.712510]  k  SET = 0, FnV = 0
[  237.712515]  k  EA = 0, S1PTW = 0
[  237.712520]  kData abort info:
[  237.712525]  k  ISV = 0, ISS = 0x00000006
[  237.712530]  k  CM = 0, WnR = 0
[  237.712536]  kuser pgtable: 4k pages, 39-bit VAs, pgdp=000000020ef29000
[  237.712541]  k[0000000000000000] pgd=000000020ef2a003, pud=000000020ef2a003, pmd=0000000000000000
[  237.712554]  kInternal error: Oops: 96000006 [#1] PREEMPT SMP
[  237.722067]  kSkip md ftrace buffer dump for: 0x1609e0
[  237.787037]  kWorkqueue: dwc_wq dwc3_bh_work.cfi_jt
[  237.854922]  kpstate: 60c00085 (nZCv daIf +PAN +UAO)
[  237.863165]  kpc : config_ep_by_speed_and_alt+0x90/0x308
[  237.871766]  klr : audio_set_alt+0x54/0x78
[  237.879108]  ksp : ffffffc0104839e0

Signed-off-by: Qihang Hu <huqihang@oppo.com>
---
 drivers/usb/gadget/composite.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 72a9797dbbae..443a65af98af 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -166,21 +166,21 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g,
 	/* select desired speed */
 	switch (g->speed) {
 	case USB_SPEED_SUPER_PLUS:
-		if (gadget_is_superspeed_plus(g)) {
+		if (gadget_is_superspeed_plus(g) && f->ssp_descriptors) {
 			speed_desc = f->ssp_descriptors;
 			want_comp_desc = 1;
 			break;
 		}
 		fallthrough;
 	case USB_SPEED_SUPER:
-		if (gadget_is_superspeed(g)) {
+		if (gadget_is_superspeed(g) && f->ss_descriptors) {
 			speed_desc = f->ss_descriptors;
 			want_comp_desc = 1;
 			break;
 		}
 		fallthrough;
 	case USB_SPEED_HIGH:
-		if (gadget_is_dualspeed(g)) {
+		if (gadget_is_dualspeed(g) && f->hs_descriptors) {
 			speed_desc = f->hs_descriptors;
 			break;
 		}
-- 
2.25.1

