Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFD634E0E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 07:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhC3FzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 01:55:18 -0400
Received: from mail-eopbgr690089.outbound.protection.outlook.com ([40.107.69.89]:38016
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230224AbhC3FzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 01:55:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmHjGr0+acEWDHtnymC29QTcqKlgIFPFRG91qjG5qDHz/6mn5k5QYlAXY6IlhF6BZbFKOsj97Qew+/rouJXRNXThg08rYVMRotvAn2MS01N1Ehx1fF2oGQy23AEC5kaU6zUK/tdMfmuhHv5qcm7knFdjo3fd1/OVQhG22OtMCHNjSWtSOTTc2WTuXHPZAgcD4h81TIEdJMC7EW5iKdy/ZkRuizzFSsQZaIbeLeBGY/x3dgU5t9bJKAw8vM1S2Ixd5r9KiU63u2UJLMe7ERSkY39f28rt50F3L9251T5oQ1hIAdrz9qkCFnc1W4AGpMXijh/xT+XlHPFX2eWzKF2zXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsFucPWx26PzMg8zkriIHgFC9iaPRa0abPAraOgwhUA=;
 b=btWUbZV57tbOiz86/0l4khv+e0nWGOlqglFDJFwoFhyEKAlwj62gmCvO6glUDHEJxONmqSH3AwVUEa2Xze630edAR08Yzwb2OVVmz2qBj4hsroH1nL1MVr6kXIuNpGCKOggYChXugy9X9CEhhnS8s2b/0OqGMglkBqmQotnxNJL1j4YcdkZ1YndN0UKlNgPrWQdMOFbJBIMdI4n7y6Xh52rJG7LrXuQ8jELmMP3AmItnrtCAZM/z4kGLDkYUOffZXFSKMs1Jt4nxNt9gfvF/GSKvwK6AoVMJPOvTn/N3LY9s1w95N9g1zQbPJR/nhOIYTxnZNN0YaGDhYirT+r/Oqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsFucPWx26PzMg8zkriIHgFC9iaPRa0abPAraOgwhUA=;
 b=SXH2p3j3jE0I7r9J9Kw6/0VnqzAg/+R63sTmO4qox+b18WCeiwWqjVse7Nv4fcVcBRU1jtTsmDGGX+q5NadlzOltG469NcykuQhrrI4VvLzUgEWbGExzIYgEh6hTIbQfc7JYojCqRUW9PvqJWJ3tn8xcT1Z0qhmWzzva7TyO0MY=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BYAPR03MB4422.namprd03.prod.outlook.com (2603:10b6:a03:c7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 05:54:59 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%9]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 05:54:58 +0000
Date:   Tue, 30 Mar 2021 13:54:49 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: Add __init section marker to some functions
Message-ID: <20210330135449.4dcffd7f@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::18) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR13CA0103.namprd13.prod.outlook.com (2603:10b6:a03:2c5::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.14 via Frontend Transport; Tue, 30 Mar 2021 05:54:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65f60b43-cf78-4f07-dd88-08d8f3405a11
X-MS-TrafficTypeDiagnostic: BYAPR03MB4422:
X-Microsoft-Antispam-PRVS: <BYAPR03MB44220FDBC8F1A5018E712071ED7D9@BYAPR03MB4422.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:98;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rElmhMvBZnbvUsXfTW1anuKASr6X5NXL3OU/JWakSTmBlij9U/bQ5PgE26VbIYdB5ZPiRWV8yDgp8Bi4rKhu6vFB9mHjHkprYKJ5N+dJAdsF43ZQME/E+bKaj3c6Y1U1DWFTdplwJ8LWxWut90ADj+pxW8uLGbcvx2dOQhRsQjh79AvRwSFTochVIm2ykABSei9HZevgxUexvLctNtkLRv+ke0vAv+BPWNlAmFcKu8zp7J6DnHkn9IlLjuNbv6KKH14qUoZncPP8H26Sti1Sd7oQ5tBwmwJwk5b0xXRAs7l3ur7FpApb6AFy55EMag3TiKwFcrVbhnxrCswL+pgfapEu9dyCfQzk4wnUERXFDTzOJb90dkhlfaiYz3P07iXmiZHTA8OhOgZeM5av61vXkCPh4UWB6CEmyxWdfk0emQi0b9HjJJ6INCNguOOUVfHLBS/+mY2sT/iNi+jSTXXhy2ieQAahH6oKs4UQ819t38XvRIqZZJlFFwX2Yb9kTTGv5GSDQR9ehHN+Iz8DtsGZNGGnzdzgjZWJ8FrtRy0iDecmYj+uIqEACrZrN0URxuL7Swrw+TrrPGdY1qQ/SLYVUicr5HZM9Jw2uV6JMghM4e71wOYzevXb+rD6czuEKwe5+p96KFHBAiIfX0uGg+Ww6U4yycPjcQUm9yRwdf+jiRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(346002)(136003)(39860400002)(956004)(86362001)(52116002)(6506007)(1076003)(7696005)(83380400001)(4326008)(9686003)(26005)(5660300002)(316002)(478600001)(6666004)(110136005)(66946007)(66476007)(66556008)(2906002)(8936002)(186003)(38100700001)(16526019)(55016002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pR0MPnRCz9Pjw7P6sRvl6hV9Z1ArszD1keYPIUwsGdgIGhMW1Pgz4uZOeumb?=
 =?us-ascii?Q?AP6icNCRJYMXoo4/4Wrv0J/cSyctjMO62spAx8JVxtPxO9/1kyx2HEV7uy9M?=
 =?us-ascii?Q?dNvRpm8DiR/fK33Tya1TmdWfWtvK9koltklHxXAVNcy5dR15Uf6lp5tVZdbU?=
 =?us-ascii?Q?q32bONd3alaQdhggWUWt1NNogWNuJ4n/pJ65K0Sw/GBLneJzQC/GIRAe8Skd?=
 =?us-ascii?Q?DNtWqioOAagojNNtH+eNPQk0Y+MoADBLXuI+yFEJETX1HDVm33tfWcje1TkB?=
 =?us-ascii?Q?cwjN8GLcAlBrSqFarmj0LcFbsftFJygCy3elvlmyh5K0mmuIIaZ3YCLe19w6?=
 =?us-ascii?Q?XBZsnJ2VYE9hp1Fu8B+LTxV0A4mxVe57VAkDdAGHqwdQdvnrkAe/QemTvQbg?=
 =?us-ascii?Q?yYMGAwZU9biiyw/n0hcApTesZLxPNORJv1xuT6PSC2mzLst6KOx210gJ6BT+?=
 =?us-ascii?Q?0puc4NNzRmH1warwXwVab+sCy4RSFgXlVsobjcOqNeZsjpTtlpHy0Cp27ZU1?=
 =?us-ascii?Q?EHUV4yd0f1/fCOXRJzeRxF78qI4EAXpalaFc+JHnSnPTyzUKdEyf8i/1JC4p?=
 =?us-ascii?Q?uyAcqgQCkG1XY/Of5dOYwXi/B9DpsXnSDXms0yhchWfMX0q9u9Q2yJ+9irTV?=
 =?us-ascii?Q?VzYwIzMKcDN9IJvzVCw1w4wjbeLYAYL1EbSBLx2NcdzYY+ZudeWxfy4c7vRe?=
 =?us-ascii?Q?6BUseA+x1w5dPjN2P4O1QvJpJzjvsCyq3Ccix/ij01kaCglurEKisZUIW2nt?=
 =?us-ascii?Q?EPYykGDqqpYn05fRXg0lprCArxWKAof6BaPXHENglaQ3j+tnDIP12vlYTypC?=
 =?us-ascii?Q?vHU0z6YLUiqhsVyE2Ao7s3KPifA1h7rJ+/VtmV4lPlCDGcbaPzF0HDpIWDp5?=
 =?us-ascii?Q?RM12lxK3ELV/Kl8C4vF4z8bb72g6ld63uH2HtCm6MvJ8VZ9YVpJLMVEtZkua?=
 =?us-ascii?Q?3IQi528GpVR4ojOMtFZDjgJ0pBMMjxSZ22bIK3f6fZds9ruL5ahQiIx8nmfD?=
 =?us-ascii?Q?1zTH8NnSQ08JPZ4aoaErDmP8oFl45GMQUlj/6BPH/1R9UkpxRdcKXxMi732F?=
 =?us-ascii?Q?M7dC2HDTtToUBfAzV4WphTB4ZU40DaeKblo1lDgf2tMDxkCJbg9YpFz3n12v?=
 =?us-ascii?Q?8hk6pTMHDCWOjg27g3aCb76TIbHYLpt7yipV5mYhhBuEd4kxoXJc44NR9waB?=
 =?us-ascii?Q?7kkq1/0xPWKf338w2Wf+PticME12Xt/WrN7WxMCmiaGek1b59ltr0Wo+Nl5O?=
 =?us-ascii?Q?VKNw2JdxH0AsOavVU4oum+Y7Mt8z0XHyVQuKrOSTyPokPdtgWamjMs4evMnN?=
 =?us-ascii?Q?jvU52Es5b9lQnzJYeldT3wiR?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f60b43-cf78-4f07-dd88-08d8f3405a11
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 05:54:58.8796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axx1oKJe2Ezel24MxhtO0/PD+HMU3fBozmMRvi6Df/1MlWK1Nw/SgY4MRwanSRdg//JBhy3f1qqXRNm77wRjVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4422
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are not needed after booting, so mark them as __init to move them
to the .init section.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
Since v1:
 - add __init section mark to __vdso_init() and __aarch32_alloc_vdso_pages()

 arch/arm64/include/asm/ptdump.h | 2 +-
 arch/arm64/kernel/vdso.c        | 4 ++--
 arch/arm64/mm/ptdump.c          | 4 ++--
 arch/arm64/mm/ptdump_debugfs.c  | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 38187f74e089..b1dd7ecff7ef 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -23,7 +23,7 @@ struct ptdump_info {
 
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
 #ifdef CONFIG_PTDUMP_DEBUGFS
-void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
+void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
 #else
 static inline void ptdump_debugfs_register(struct ptdump_info *info,
 					   const char *name) { }
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index cee5d04ea9ad..d1fa288518a7 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -86,7 +86,7 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
-static int __vdso_init(enum vdso_abi abi)
+static int __init __vdso_init(enum vdso_abi abi)
 {
 	int i;
 	struct page **vdso_pagelist;
@@ -326,7 +326,7 @@ static int aarch32_alloc_sigpage(void)
 	return 0;
 }
 
-static int __aarch32_alloc_vdso_pages(void)
+static int __init __aarch32_alloc_vdso_pages(void)
 {
 
 	if (!IS_ENABLED(CONFIG_COMPAT_VDSO))
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 0e050d76b83a..a50e92ea1878 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -337,7 +337,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 	ptdump_walk_pgd(&st.ptdump, info->mm, NULL);
 }
 
-static void ptdump_initialize(void)
+static void __init ptdump_initialize(void)
 {
 	unsigned i, j;
 
@@ -381,7 +381,7 @@ void ptdump_check_wx(void)
 		pr_info("Checked W+X mappings: passed, no W+X pages found\n");
 }
 
-static int ptdump_init(void)
+static int __init ptdump_init(void)
 {
 	address_markers[PAGE_END_NR].start_address = PAGE_END;
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index d29d722ec3ec..68bf1a125502 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -16,7 +16,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(ptdump);
 
-void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
+void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
 	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
 }
-- 
2.31.0

