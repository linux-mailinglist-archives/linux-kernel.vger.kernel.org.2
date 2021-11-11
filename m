Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D15044D05E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 04:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhKKDZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 22:25:33 -0500
Received: from mail-eopbgr1320104.outbound.protection.outlook.com ([40.107.132.104]:28852
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229931AbhKKDZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 22:25:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDRj3H/o7gFNunt+P+lxyLP41NhqJylJdSyXe8tvsU92h1YTPEMF4SRduC030vs39Co8Aq3mK1Ry8MQqM6lW2w9tXkusoFaMst8pAyjF7W1HcPjgbjzBKQwlfwA5cwQJ1Rul3j6S24rwAtzzZ+UQo1lPlJxxHR+bTfj+TlW9IGFEqAXWGlcQ1tC3wyRp+VYiK3M4Ut8+mzLPSbWwFreESfiJnbIFcgOV8szUrG/u/VBlbVkxcCtJAJSR5C1flV4TQYI2O9m9NHngP5udDOvoCljhHT+1UJVW+14/MQY2UhaFFGN8n8ZIDNSzzEqKnkWjR+dMPrIN7P+F4d9SBuO8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQhviZWO6pizPwFBvpxXzj9SdkygfsvuMMlLK/KALr8=;
 b=WByYsyScZ/vgDUPLpnFIXEf2j3c2BrYZhKYqzmf2d9dYFxi8oM2kF6qgSGcFMdzcwI3ORLFhFSfmFEeeR/gQB5UG/x4eMsTNpUm6TIur//dITv6IWF20ugmbuIjB0TogTzV4ii4h7mqHUIvYEv6MLitgbk0V7zx1+duRLd8HmoLb9j6kDBIAJnGgVcPovu/hY4GLb4lK8/OZLIVju1LF7v4XSTwe/UDf0wclrJHp7Bk3P6d3WWoqtEsfybIBISs1xjJzC+FGaChGKhWitzuIP+rIrpEFFA9mWswX791iz57Ao1m9njyk1g1oCJV1RIgrtGo+I4fLKZ4oe8wP9oFAsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQhviZWO6pizPwFBvpxXzj9SdkygfsvuMMlLK/KALr8=;
 b=GREnIbovPqJVUsY7gatxD/XW43GUS5H9/oLY7RtzLu1K5OaR67zizrOcb5HIpwQ/xyrvHasrNB+P3ePwPPI0YJIiBL368Ay/upnvFEkxy3It305hEq5E1bDu7bGHkEIZDqOsrxZPuNTK7Td1VtdpPDh/T28CrTFO5CAwtHHEGI8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TY2PR06MB2526.apcprd06.prod.outlook.com (2603:1096:404:46::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Thu, 11 Nov
 2021 03:22:37 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::5e:78e1:eba3:7d0e%8]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 03:22:37 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] mm/damon/vaddr: remove swap_ranges() and replace it with swap()
Date:   Wed, 10 Nov 2021 19:22:03 -0800
Message-Id: <20211111032204.3721-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:4:7c::36) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by SG2PR03CA0108.apcprd03.prod.outlook.com (2603:1096:4:7c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.7 via Frontend Transport; Thu, 11 Nov 2021 03:22:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1abd4af-748e-48fa-7b9b-08d9a4c282c6
X-MS-TrafficTypeDiagnostic: TY2PR06MB2526:
X-Microsoft-Antispam-PRVS: <TY2PR06MB2526287778787478C145963AA2949@TY2PR06MB2526.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0dpagRTLJn759c2QETD5P8iSekJJneGRt9ixIlJsqJD2y5zbWMzwd6Zbq0oqjuYulFDY8PoV5GAuM98+5np4S+CQxsr/J6S2sc12qb9T/K4nWfmlAoBXxwCLMm8TUI//KJrOSv9qLKuD4D6vYL0aCecER7fXbNZkJlESxWtUuZjyjUpTSf8+bU+XFWEWLs4nVWvhrn0pxG8h99c0i5HQnRByWSc4Z7FbqeuRygE8uEh7YgnfToKykG4OEeGg6bWENADwaP1yIDXXtyU5ZZgY1B/D70jbLLPUZlAQpuLcdnPLOLo7PJL6V7nQPBwPnjKDh8NsU5Ca4fTK0OWhWSPKwtTexXhC2FsQd44VYYkIVOAiSFukLxtzCRgtZOodvv9gwrby4QPiVMpNrB3t/emBk5tph39/bS1zHgp1FsYBWmQOSIJhnDMRxvJOZjsthsT4GGlWCoP8SwomPcsSN2uWNmQUdsn05JYnP44gRC6YBAC2PoEA8Ztc5k3lwvn5PeLm3sIXVDcYNkTFtQnTg5Nlnm+WIn2pG1/eQVv7MbxoQJQaBWDcFwiCt589wDoaw2ZrEDLzYjWjBU0Iuq5/ptUMlGqhwCgIh7oqgTgiuS2tKb4Iz6TRSybH2Dw/UiYtJ1reJ844x5p00IEf7/Fg4CVoN8MiB0g958/eZ/hy4tX177QTM8d+PJ/yNPvU1ZXFk2Iwc1PJ/RXOffFaUJWWeoUGiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(66946007)(2906002)(4326008)(186003)(36756003)(6506007)(6512007)(8676002)(86362001)(1076003)(316002)(26005)(6486002)(6666004)(5660300002)(508600001)(8936002)(66476007)(956004)(107886003)(2616005)(38350700002)(83380400001)(110136005)(38100700002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SII8tetE9UxUhMLW3//vb1ggTjDnNfC2ssN6t9VKUhRvwk6+H5LccukFRXQX?=
 =?us-ascii?Q?koDDi9nzXvcZvtLFByx6n3EpGaHSRTtYaJuBCaj821Dd5Ts7WNmES8unJdYu?=
 =?us-ascii?Q?k4ZEZJqzM3TG/VRfX0BcPeadXQX6lH5i668i29GSLqoV9mmChodU4JBUxD+s?=
 =?us-ascii?Q?sGHKPDhhqxlR6FUy9QJeTRfxAbeNAg0SXXvW83FfLawGNuCyNzPKByAc8eMd?=
 =?us-ascii?Q?9iYCJLZF0pWfavtC7QlWyckW1uBtfqm3cxcgTpW3Vzkfv9f4KEljzOwOQQI9?=
 =?us-ascii?Q?evrSvW+lFXdGgdaNhHXY7A5QWgPr8FYGAR4GOC7Zepv/tib9JIzkfoGoEEuW?=
 =?us-ascii?Q?jnSHFf/kxKPElvIB78uGRAmXe7FEk7sKGciMWfS+t9/i2L/wgkmtD1ktYYfr?=
 =?us-ascii?Q?ZraUkwa2Qtir07JU3s5U/t7Pob05tbVb7KdL0Q39pkSP9TFA5O3F8LW9JsSk?=
 =?us-ascii?Q?RBife6276K7/WoXl3rUdLrlyHcNh5eHMT8Qzzo0jxH5vwxM1Cc3jdB0zf5MY?=
 =?us-ascii?Q?Xg2+BFPZG40CJCFFmZ5zDzYjJ3q5gVaxRqTzwk8CHBhjo5h84G2tyQRSRBub?=
 =?us-ascii?Q?9T20aryK6IspDhla4vupAb5WAx+T7vF1mYu30pkYhzYzI0Ky8Y6MpUmenoGW?=
 =?us-ascii?Q?s0kOKlinvB+59DYc+l4w4Jmv4jsPveAtuN3pHauBufr+udw3XJyiaUVEBEmn?=
 =?us-ascii?Q?AcAq1cCdA5+1dw5ThqRBN14gRJDkNDQhqmK0iyx8dAjVmUN7cQQa1nZ1Ne7C?=
 =?us-ascii?Q?92tc7y/EDxHq6G2Zt0YmfG3uZdj94n9rpyA3NkCM/3t2raoACZnXlc9hLRnm?=
 =?us-ascii?Q?UR82auJCIK30WRo0IdIKAAnF9NJBNx7GjLUGzuLybNK8GYFyQvRaoB68HxBd?=
 =?us-ascii?Q?xAYQxlIYbRGzkgROqu2RVCgA0mbSt/F0tJhndA25cjyDyWtTLxVIgS3FuU7f?=
 =?us-ascii?Q?TBY+HweBQGO3zXFHaTfRQdxBD4Qp9Wpe8teoeQVi/3hfi7XE8YSyYejfiufC?=
 =?us-ascii?Q?DnhjcK6O0St6PeQfofk/fEhYTqgJHe9cShz1/t6RY/XyXh55GB9DwzYCulsq?=
 =?us-ascii?Q?GLWUpAOEaXBSrDiuJqVnSLYj/JVsxo+B50nNWLQrvc7FiBoIOYyrourq6yBh?=
 =?us-ascii?Q?CPSe9enHyFCf/8EkL3s8GNlGbP/6TvqAo8rzcpJzWrDlL0VWthQfEmqTR74U?=
 =?us-ascii?Q?tZ7RJnr3y5cVvpjZDN0uReUaNHD3jxNrd0e+GHBTFMvj+rj0bqdxu0jV1eZD?=
 =?us-ascii?Q?ThqW/4Hv0Rch/V7MrosDRCd5WdepVkdrsujQaolqz1eEB8QZG0opXHeZBr4A?=
 =?us-ascii?Q?ig8kdfNI63MN3AH8VNv7tS9SjqcXG0iTBeG1olv93KT7rntN9qy9vdeXERK9?=
 =?us-ascii?Q?CrKItkp44qR9LnQIw1BahXzwhqso25eV7vLNhpv3ugWb82pQjmJKQU26Kat0?=
 =?us-ascii?Q?2ibTuFsPkPq5ZmgeXqi5BqtikKyqulQj5ghHuaCH/ku05jFC3FP33fPFBh/p?=
 =?us-ascii?Q?I3+8T8o/Z2A3p96/zsYirSg26qUL4WRFzBKyFzzGKexnrDcd8SsWhZyfJ35O?=
 =?us-ascii?Q?KO5DxFhv9u80B0tBtmFRx/Bi9HqWlNCXlPHaas1d07alCcgIAgqpGhkKYL7A?=
 =?us-ascii?Q?vkYOKSOlhW6b5J2REaSlFZg=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1abd4af-748e-48fa-7b9b-08d9a4c282c6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 03:22:37.6661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTXIH4/53sboLiDxGpPa4Rfg7Xl1OlhqECmU07vqNYBD2eBYmfft7bAGZFpH+FZAms2S+tu2SJIZtPG0nOgowg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2526
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 'swap_ranges()' and replace it with the macro 'swap()'
defined in 'include/linux/minmax.h' to simplify code and improve efficiency

Reviewed-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 mm/damon/vaddr.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 35fe49080ee9..814dc811d7c4 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -97,16 +97,6 @@ static unsigned long sz_range(struct damon_addr_range *r)
 	return r->end - r->start;
 }
 
-static void swap_ranges(struct damon_addr_range *r1,
-			struct damon_addr_range *r2)
-{
-	struct damon_addr_range tmp;
-
-	tmp = *r1;
-	*r1 = *r2;
-	*r2 = tmp;
-}
-
 /*
  * Find three regions separated by two biggest unmapped regions
  *
@@ -145,9 +135,9 @@ static int __damon_va_three_regions(struct vm_area_struct *vma,
 		gap.start = last_vma->vm_end;
 		gap.end = vma->vm_start;
 		if (sz_range(&gap) > sz_range(&second_gap)) {
-			swap_ranges(&gap, &second_gap);
+			swap(gap, second_gap);
 			if (sz_range(&second_gap) > sz_range(&first_gap))
-				swap_ranges(&second_gap, &first_gap);
+				swap(second_gap, first_gap);
 		}
 next:
 		last_vma = vma;
@@ -158,7 +148,7 @@ static int __damon_va_three_regions(struct vm_area_struct *vma,
 
 	/* Sort the two biggest gaps by address */
 	if (first_gap.start > second_gap.start)
-		swap_ranges(&first_gap, &second_gap);
+		swap(first_gap, second_gap);
 
 	/* Store the result */
 	regions[0].start = ALIGN(start, DAMON_MIN_REGION);
-- 
2.17.1

