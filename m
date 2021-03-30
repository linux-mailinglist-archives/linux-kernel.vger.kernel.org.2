Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE1D34DF1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhC3DRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:17:32 -0400
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:58593
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231241AbhC3DRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:17:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGSqhqjSAmm8Mwc3dskniQl8cUn1N3ArJwRuZZl472wgpa7S4NVt5lF5tWf+qesBx8v2tYxoGXzaIxlc4WG/nYMIKID8zojIYmbChVKJ+OL7bkgQQw9Afn+CWXLcGQy/90mVIUINT3rHUlmpjBv1ay2mG2G1GRW1nLii+rL1/WXc1rHNdsG6r7rJor56jQl97qbvfUjwKSPITi2X5kWRvmcD+3PDo0Sg8MUv2bR/IviCTk836xJWfaJpgjMIGvTohInQb/F+k6rmPBs88p+VWyQGVqsN//1DXV1I7xc704p55C4RdieDJsGb13D9Q5MYfgErwoEBKEiUUk0t/QrtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8wYgVxOMsdKY/wUJSmQujdFb0Co4UskCx9LwUeZFFY=;
 b=YNg6HQmVsA9kcGI1qiBfx7scEeUoYdObG6+fC0kc/g5nbPP3TTeBBu2d8HcGLgKWgWynNAvui8Ro5WP0JpP/4Q+HizDKfZfk95yCUS/P0EdrppQ3WCDebmkWKZ2/zFm+bxNeHWc8M8qFWjQx8HHDcb20LXQulqIRsB4EjwHv5QJka844otvjij6ybFQR4iKOFrQDv4JHffki19XGwEX21FENyrPU7tgeJuxW+pPcJ/9xuENkisA9bWiD9KQZwyEhK9Jgrs/y/rGhElygKpEn2u/7y2HBhb+63hKAoAt8OlQI1DOZ5n75FUULjyXIc6pjIReQNgPvNR/QBHrJHDOkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8wYgVxOMsdKY/wUJSmQujdFb0Co4UskCx9LwUeZFFY=;
 b=TluParY/Bj5MJWH/+UHeP1V6VdtTC7UHLyhvCI7m40HcOWw+UDdhXie6hg3NxMsAKXrcVUzIs16oQWgcWTDYOgcKGaYPPLIvS1Ni+u9hv4AY2Fc+joA0Sjg0BEXI63Hk1lmEaWr6Ciy6mRNZqcYyr/g85c9Z230WlH7R3jlbdJU=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BYAPR03MB3989.namprd03.prod.outlook.com (2603:10b6:a03:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 03:17:02 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%9]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 03:17:02 +0000
Date:   Tue, 30 Mar 2021 11:16:51 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: mm: ptdump: Add __init section marker to three
 functions
Message-ID: <20210330111651.5636eea2@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BY5PR16CA0029.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::42) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BY5PR16CA0029.namprd16.prod.outlook.com (2603:10b6:a03:1a0::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Tue, 30 Mar 2021 03:17:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 872a68e6-d0b8-41ba-2726-08d8f32a49a1
X-MS-TrafficTypeDiagnostic: BYAPR03MB3989:
X-Microsoft-Antispam-PRVS: <BYAPR03MB3989C2CDEF412B0093BE1C52ED7D9@BYAPR03MB3989.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:133;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIRqpwNpn7tv0EG+Oe+H0FVf586YmkXg5ypZaV9D4jZv2aTwZSeJcAwMB5IFH7TDI5gTk/Y1gbx76wLqs02PpgIPRz0iOG3JOxqfch7EzmcThOEu5HrNk/T9UxuH5Z5l5ebP8SDc3+LB+RrxQj5DrMkkBSAD5QbdESbP7R/wuJtnoHbsZruJvFjA/6bBI6XyI1pV0Hqd6QlS5Bhr24FdxGSSeHk/ChTCVEuyz1tG5Qj5fC8H6o8mxdDqMoiBjEfFBP/6hBq8Rtix1dfzowAN8MoRA2urKp3u3OQ79BC5DYpaFvIQjk7lEbU0WvVMRellylPqkbwB5AJxzsLwZlYUwM3p+Gk3P56sdGVm6zQOYjifqeteqb24krb/HCX1HuODSy8xIkCYSzfgSNlgu1nLko6SsBZQuddDA7VMQCq+6RQ5Wa+U5tdIQKaBMezT9XyX8Y/iPIN8fuwlzA7jjK0k/rnccPOZP8T5CFLRAzIuv/sy2EeEcsbgfBe673cf9cERE4pYP6nthvgkHHMIIPckuAT03m2NNPvZ/PFMysX2uy8CYp1wTXoKq9JMPqxxkSEpFWNukL39v2Z1FhB0wIbamQdDoiBoYyp63hUOfmOdrr/CWvVXvMs47S+ORq/4WwFOGucaJMreVNtG75itiS+IvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(136003)(376002)(396003)(186003)(26005)(2906002)(4326008)(956004)(52116002)(16526019)(9686003)(55016002)(83380400001)(478600001)(66946007)(5660300002)(1076003)(6506007)(66556008)(66476007)(86362001)(6666004)(110136005)(7696005)(8936002)(8676002)(316002)(38100700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?t381HMqHR/hRS5IrAOYiUSyogsXypSMmYv5E4azZ7AAftmSe/JSJiFO8zh9L?=
 =?us-ascii?Q?kgdCE6BI17DLHAnCSv5vuNZUt/cW/yFWD6I95VuwS7RBGlusmkx7nB2rV5D2?=
 =?us-ascii?Q?UVuZREmNt7hRGgbUUYGyxpQrQ6rdb2Znf8ljOcGC77/UC5Uor9twNt9aY9B0?=
 =?us-ascii?Q?5r/2B1ovrDABqsyfut0roTyddDafJX8yRX2jnrAKvcWhR3+N061VVrHNLObH?=
 =?us-ascii?Q?3xIfUfFB4Xb9mP1oAoYDYSxHq3SX3ioSS1KQ1pprWfZzszcDIhiWDhOOERdW?=
 =?us-ascii?Q?yR+o+r4VYZ7xDqdcSRzoW2rjh/028H42S27nhYlJiylP4wstuI41s6uOPIzE?=
 =?us-ascii?Q?px8+9Ya+vGxSp912Z34OEqwyhmiksueklrRxzYciifuj5vXjNdLoCTcd0J9F?=
 =?us-ascii?Q?3/p2bR7EUob0lV3+SCky/ZJftGhty5eQZkwqNWs1wucf2o7YzrgpLfnXktqd?=
 =?us-ascii?Q?Mqtgv77LrgD44PwIoYj0BuW+UjvAH6PNXXWXl3z9bXMcbKvayVoNn9ZwDE/j?=
 =?us-ascii?Q?Kp9n3TdkoVCFHr4EB6ztOTVMhfW5qkG/Esc0KYzBgLnY/mY2VNhWks4soDCf?=
 =?us-ascii?Q?SobGpchxi0e5c7lU0QBRMpLASmQbZX7KQLPK2aL2GuXG7aWKDWsyCidMAYGm?=
 =?us-ascii?Q?4dPG1mcs9NDnZjqOwAmsOR/Bsjf86zb5A41d3ePImoSmbM3filkwpbVun635?=
 =?us-ascii?Q?JGYU4d3o1l91N9qaFNtmq5Mw65VxfTatx9ylowYGKANILLe6J/BNjV9S9k9T?=
 =?us-ascii?Q?V1XF++vB6YBEWFSELvDjoHYiEMkvNprK/l2Q8nkadqADXKOIPpoXRpl2z8w8?=
 =?us-ascii?Q?NKYKljMKFGUUdnWpKSHgzuus7qTPTIwXXfls9S0SDetUVTHCcMhC/D6Lk/nX?=
 =?us-ascii?Q?UA0jMXtRZas8G4ivKrYiTYf8rfamSwHHy9ZGY5MWWreNlTCo1nIljxC7yRVD?=
 =?us-ascii?Q?8zmNEG77ofXXT3zgAa0gvqqDyr0jdA5QAoBTajYUmJXQKJxq63bW9K5lArzC?=
 =?us-ascii?Q?tJ6bSWMCDfAnKz2S9+5O0qWgbFQ7HUksXPHSICeAOsBDCaED7nCoEvAya1gQ?=
 =?us-ascii?Q?7X6ViotzBFGCG9Jpcyu2wudJBtikoBOdug6bszG5w1gU0+0I/j+R8OZv9ZK6?=
 =?us-ascii?Q?NdMTLDS2tn4UU5qvW0ZFXqFwnVlmsnP+oqpNwP5we9gH0KikRslOnCs4TfaE?=
 =?us-ascii?Q?soePPoorj/UcXvbOkLrQnzuShcjA1bt2/qZU73/FJLFeazyXTrgHVCAnTbmt?=
 =?us-ascii?Q?Q8OUdn0t7rlIvZR5DpsU4RrwMEmKt9sNhe6Z0Z7WlsS7qqwULrLtTJnSkvl1?=
 =?us-ascii?Q?uPLF78sMiwx+fV8LvJgz/w1d?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872a68e6-d0b8-41ba-2726-08d8f32a49a1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 03:17:02.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwahYUjXSp0/LMd22W1e4BRLchT0TQv/35/v/Tp+ecYMYgljFAg0px7nFM0KLC1C8fXjJXVcAY8u2sAbB5tfvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3989
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are not needed after booting, so mark them as __init to move them
to the .init section.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/include/asm/ptdump.h | 2 +-
 arch/arm64/mm/ptdump.c          | 4 ++--
 arch/arm64/mm/ptdump_debugfs.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

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

