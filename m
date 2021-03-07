Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5533304B2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 21:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhCGUyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 15:54:06 -0500
Received: from mail-db8eur05on2065.outbound.protection.outlook.com ([40.107.20.65]:51808
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232818AbhCGUxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 15:53:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdHz9rOwTZN3zT9ZxcfC2KyOJMZMLBpSLNjIV8fcMqhoJ3rukSHyT2PWYfmj9mLEIcsl9SQM9jBrz6B/xFGUAfT1AZ+JFCLeSXx4gZ6gildSCpyAKctleA1w/bkG9aBS3JSuu4aoMwb4fEd9CS4FtEv4wrN2kU7vOMAnU3UFkvGL3kE+vzCdJP7FJVUeY4uIRftn9WwG1Ih1OdhvsQ7pOUu3vWwDcmDKxGSfvwrObZoVqtWeqlAZ/DpkRW4YOwsy/94kadsnwezodLkRqdIoD27ztHV5v/3qjkA45XQPEn61TGH/2nBG7KkgVUJUVZiZPbtbmJw790jmHJOtq/DqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUbfoWdyg2tVEY/bafEWr3tP1IKX3l+AnFEoCk8R+n4=;
 b=C93WjnI4H3vFVmfpwA7yErp7nBZBJW2sIsvaV1LKWVCmPxJgcPftWr/4hdUipmAQ15+tNle5ObPQj9iGwd9e5zbWSGzpUbQGj7PtUKMBr2f2ho7z64sWDqOIfoqouqePujaVrTpkdUujSGFWP9EP+f+yBA+2bPqC5YK9NRclMV7h+poCtcta4D3YvXg1AZzby1x4A+TMg7Grd5n6JA9Dqi955JzWratxNxA8CrxhAFcHz7vTL/fdEg8W1/VPl8zkP7zr3SY7CcRZpf3y3VrIdRp9EcF0VIV/40ggWgFk33grCchpCtSluoTxW/KYMApNZrbuXFjy+pAM8w9UWv4e4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUbfoWdyg2tVEY/bafEWr3tP1IKX3l+AnFEoCk8R+n4=;
 b=IssOA8z0PUfoB8IWZtbiFl6iHTsL8ATQ8vXmIFQjrSSK5o1Au3Gn1/REn+YDdeOrLp5KVKt1HNcxghaExsF+6mv7LNhAgzqwR02pKhtqkBXwsVHYFL9dbqjLOrOmDaeW3aK0GTj3ceHIcTkq0Pj0EhqybQYHbOC4Ts/1XS3FvSg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com (2603:10a6:803:4d::29)
 by VI1PR0402MB3792.eurprd04.prod.outlook.com (2603:10a6:803:20::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Sun, 7 Mar
 2021 20:53:36 +0000
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::29a6:a7ec:c1d:47ba]) by VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::29a6:a7ec:c1d:47ba%5]) with mapi id 15.20.3912.026; Sun, 7 Mar 2021
 20:53:36 +0000
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Greg Ungerer <gerg@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: ls1046a: mark crypto engine dma coherent
Date:   Sun,  7 Mar 2021 22:47:35 +0200
Message-Id: <20210307204737.12063-2-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210307204737.12063-1-horia.geanta@nxp.com>
References: <20210307204737.12063-1-horia.geanta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [83.217.231.2]
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To VI1PR04MB4046.eurprd04.prod.outlook.com
 (2603:10a6:803:4d::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv15138.swis.ro-buh01.nxp.com (83.217.231.2) by FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16 via Frontend Transport; Sun, 7 Mar 2021 20:53:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6eba5fd1-3f80-4eb7-a59b-08d8e1ab13c9
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3792EF13DA6D0F8DF91A2C2498949@VI1PR0402MB3792.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:49;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qT1Sw9HpDVB6bgpJa90EMJgDZaSCmiXEyujLt53cBqcS6YwYONm9aVW13MpuM/O1wN7O/VzT+kj6OdQ2yp370jSuhnIMgbRGKwJEqS6j99jwXXOf7tG/PoxGvLQ+wxPkftTMqipkCemig5SWmxfdjEjFlyJnwF5PE9xH+yl9d9Y3eADIt9uPsrCsGL8F+OH6Qr6XzMIM3VmfGzH+vX96u26NJoko6vTXFFi6pEI+muwmVC2zuT3Dj5ElmQ/g3FGzAb3OOuWLP4FStZDQDnro5Y8H+NyqnJp2pJKy3UR7JgIlMUogCvCoYCh0TAHGfew1v+/CvyYcPOzvEdxkuYlwf4KNddMhozPYSPDPTFNFKF6Kw070xtJh/fo2yN+yTdXeKvp99FjrS71AL9QAJWMykza3PczZaIB76gmzehwBlTE77H/rNWvuBklT0NCEo7U5i++lqGKiffERI41oaAKxRaVFNv3gNZF1YlqnEmdBXAd6IZkmgciSr37jS6bZVTz8yrjgvRcCaB0a0q5YQFDNfyKE42AS6vWDnnIuzKnmqXKjsCCrCSkbDFMmABz7+bPsk8zMe2SrhSJm/DY7Jg09doIQgULMH+UHJxViUdDevsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(2906002)(45080400002)(8676002)(5660300002)(66556008)(956004)(54906003)(16526019)(66946007)(86362001)(1076003)(110136005)(2616005)(26005)(36756003)(66476007)(316002)(8936002)(186003)(7696005)(478600001)(6486002)(4326008)(966005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eW1IWnJkRzFIKzUrQTA0MUQ1b25xRmZxZjI5VGNZVWx3N3RvaTh0UFhHalJ1?=
 =?utf-8?B?SE9xZ1JNS2pwVW83NXc1NVF1OTR3bFkvaVQ1MWo3a1NWWFVzSVhPWjRqSVRY?=
 =?utf-8?B?MmRDMW1lNnZwZEk5RlFxaE5JZTNxMVN6SzBzUmJON3NVZlRYb21IUUVhV25P?=
 =?utf-8?B?WG5EbkRXQTZrOXA3Q1A4Sm1QZjMyU0RITXBwcVBKZHpIL0lCSFJhcGlveGdD?=
 =?utf-8?B?bHNlYlFrN2Q1VFUrU1BNTW02ejhxVFFJVXpIZks4WTB0bDZpZHFTM09uQ1Iz?=
 =?utf-8?B?aTdndUk4dmN4Z2VyeFNvSG56a1liSEV1cGlxQk1CVmFkMXp5eC80blVUVzky?=
 =?utf-8?B?NVN5OVBaS0h1YWU1Q053M2tXV0xIYVVLN3FYUlF1bHlBME11ZzlNeGQ0dFhK?=
 =?utf-8?B?VFJXL1k4L3RmTk1xVll2ZzJXbFlibC8rVkZsaFo1bDdUMVV4YjVRbGptcFBI?=
 =?utf-8?B?R1EyOERTMjRnZUZPRi9JaVZFZ01LUWdGSDVPWGUrYllod2JkalMzSnRlTGJw?=
 =?utf-8?B?SFFCZlc4SXlXRHhYalZ4ekozZGd3K1kwQTRTQVJhZmtMOWFXZTI1TVNQNWtT?=
 =?utf-8?B?bWgzclNqeUxEZjVaMXFHQnlxcVc3T3l1SjJRVGVrR0hUQnBYZC9WQW1wWllM?=
 =?utf-8?B?SFVEbXlpbEhVcFZGSWMwKzlwR1A5Y1JqV01QamV5bGo4V0FJNStreGU1cDRw?=
 =?utf-8?B?YWo3YVdUbHhqT1ZabkhCa0tnRGtPRWFBamRzUWpGNUlpS244Y09FUG9mcHlQ?=
 =?utf-8?B?RmdWamlmNFc0aUpjTUM4SkUwS0RQR0JESWpZQjR4czFaS3B2K0dTMWdwdFcw?=
 =?utf-8?B?bzdZb0IvakFkamJTaFJpV0loWjFvQ3ZmenVhN3gvUjBUajhaVGF4b0IyR1l2?=
 =?utf-8?B?K293RURGc0xsM1lla3NuK0lncUZlOVRxOWVrQTdBaW91dEgzbGMwNHYxWW5D?=
 =?utf-8?B?aWVadHlVWnNBZEswQUgwU2YyRytVOXR0MVlianIvaXRZV2ZIaUsrd2VEd1No?=
 =?utf-8?B?c2hHWWE3UXRsTW1tbnRRYW1LN0V2bnJlTzF0eCtwK2g1SjIzNnY0VkIydEIz?=
 =?utf-8?B?RUN2cGFXNlZDR0lPMFZUMWszUzd2ZEtFU3lmdFI3WnUrSnc4WTZhM0tFRXFq?=
 =?utf-8?B?U0d2R05YdmhWcGdjQXBnN1hnN1lFWHFwZWxZa3ZOUmJZanJUc3pVRm1YZGUx?=
 =?utf-8?B?QVN1NUU2QTVoeXhQcko5cFRkSW55RE9MaDA4V2dRSEFvUHlqZk9Ub0JtOXgx?=
 =?utf-8?B?UkYzc0R2L1VmMVNWUm02SmcvNHRSNWRlcmFmUGJ3UVRGc2M5V3dIcERDeDdS?=
 =?utf-8?B?ZHU5VXU0ZEtNN1lwNHFWVVk3ck5vb3Y3NHkyNzdrYTFNY1gyWUpzM0NZOFZ6?=
 =?utf-8?B?SDRGV0YxN1lNVDNycVY0UFZ4WG50NXU0WVdnU1lRdGFiWlRoeEdmOE16bGxj?=
 =?utf-8?B?V0t6MmdlNlZ3S09KYVByUDZvano4clJLbUdmY3RLcG4wd21ib1p6SjNlVXg5?=
 =?utf-8?B?WUNmdHoxbnNtQlJRU1dJczMyME9KZGJXekZXYVJucVBmVnJWaUJEYkQwY2Jz?=
 =?utf-8?B?eVQzR0NrQitFVWYrUHhjOWt5ZUxRWlFCQm13ME9JR0VkSDB6QThhYjQ1a2pk?=
 =?utf-8?B?eG5yc2xsejZXYTJkL09KOSthdjBtRVk0VFJxdWNkcFJmdVc3V29ZZjlQMTFF?=
 =?utf-8?B?aTJQdERCMHhFUDU1RjJkUFBYb0VIYzVKZVE3N2tzalhDVEt1SXJiRUxwSmEy?=
 =?utf-8?Q?g/+plglVR7xEaYkT9cGiKpW8VJZcIm3Bej/Na0x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eba5fd1-3f80-4eb7-a59b-08d8e1ab13c9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2021 20:53:36.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSvXcHR6kn8EouF5f0SByGwAnRW+KZBR+cX6G/jqUtROLzx/U9ZHZF3qLvGDcvl3QWqLQRZJQP8YYc2/EIQV/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crypto engine (CAAM) on LS1046A platform is configured HW-coherent,
mark accordingly the DT node.

As reported by Greg and Sascha, and explained by Robin, lack of
"dma-coherent" property for an IP that is configured HW-coherent
can lead to problems, e.g. on v5.11:

> kernel BUG at drivers/crypto/caam/jr.c:247!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.11.0-20210225-3-00039-g434215968816-dirty #12
> Hardware name: TQ TQMLS1046A SoM on Arkona AT1130 (C300) board (DT)
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> pc : caam_jr_dequeue+0x98/0x57c
> lr : caam_jr_dequeue+0x98/0x57c
> sp : ffff800010003d50
> x29: ffff800010003d50 x28: ffff8000118d4000
> x27: ffff8000118d4328 x26: 00000000000001f0
> x25: ffff0008022be480 x24: ffff0008022c6410
> x23: 00000000000001f1 x22: ffff8000118d4329
> x21: 0000000000004d80 x20: 00000000000001f1
> x19: 0000000000000001 x18: 0000000000000020
> x17: 0000000000000000 x16: 0000000000000015
> x15: ffff800011690230 x14: 2e2e2e2e2e2e2e2e
> x13: 2e2e2e2e2e2e2020 x12: 3030303030303030
> x11: ffff800011700a38 x10: 00000000fffff000
> x9 : ffff8000100ada30 x8 : ffff8000116a8a38
> x7 : 0000000000000001 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000000
> x3 : 00000000ffffffff x2 : 0000000000000000
> x1 : 0000000000000000 x0 : 0000000000001800
> Call trace:
>  caam_jr_dequeue+0x98/0x57c
>  tasklet_action_common.constprop.0+0x164/0x18c
>  tasklet_action+0x44/0x54
>  __do_softirq+0x160/0x454
>  __irq_exit_rcu+0x164/0x16c
>  irq_exit+0x1c/0x30
>  __handle_domain_irq+0xc0/0x13c
>  gic_handle_irq+0x5c/0xf0
>  el1_irq+0xb4/0x180
>  arch_cpu_idle+0x18/0x30
>  default_idle_call+0x3c/0x1c0
>  do_idle+0x23c/0x274
>  cpu_startup_entry+0x34/0x70
>  rest_init+0xdc/0xec
>  arch_call_rest_init+0x1c/0x28
>  start_kernel+0x4ac/0x4e4
> Code: 91392021 912c2000 d377d8c6 97f24d96 (d4210000)

Cc: <stable@vger.kernel.org> # v4.10+
Fixes: 8126d88162a5 ("arm64: dts: add QorIQ LS1046A SoC support")
Link: https://lore.kernel.org/linux-crypto/fe6faa24-d8f7-d18f-adfa-44fa0caa1598@arm.com
Reported-by: Greg Ungerer <gerg@kernel.org>
Reported-by: Sascha Hauer <s.hauer@pengutronix.de>
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index f581a6d1f881..37fec474673a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -354,6 +354,7 @@
 			ranges = <0x0 0x00 0x1700000 0x100000>;
 			reg = <0x00 0x1700000 0x0 0x100000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 
 			sec_jr0: jr@10000 {
 				compatible = "fsl,sec-v5.4-job-ring",
-- 
2.17.1

