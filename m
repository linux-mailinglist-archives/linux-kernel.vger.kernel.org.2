Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C06734751A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhCXJyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:54:35 -0400
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com ([40.107.244.54]:59073
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234802AbhCXJyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:54:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjbrXJV9JlziOzuQkkbH2REMsMTTJhSIAqYFm5QTr/7i2abNZxKQwjwpC/UKgreu8nA/owVYQ51tmprCYb7pYGsXDUL/W2YtTs7LB6KJ9BUkatNweqkkQxHjdwlZHjXxWfUATl0SC3ZM8lNh9SQw0zubuw6RhU3UDj1AXu6jpadaqZvatWKq3gzUz7y/5K0k9htliC7ZNQk58KhB4XFBemIFgAx6jbiohIEwisfKMzLvVdg/hfcX9AUGZA8D9i3ODtJghR9UiJOqKMVG/bXiN4qJgJE1iBm6iIWRjOlltYwQsHZZOD4a1hzmY9ft6rHfPb6ZscWQsPri1eq6C4io0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxfJzUOYUQTYpZ1KeXRQ5akStSMLwcyuQbhTQVOuPQA=;
 b=kB3A8+fhF/jJbgcOCOkxSD1LxFI5UDsCrUhVAY5f1kM6fVFIesUkk1NE9LZbsAGL1IrEbhymftJUs6TwpqluUhHCRmUVEzn2BExaU/znwKE9jFQeNhIllR5Z6RHWzbFxbnGG/m4G6pmegtXz3Dgq47eEOur0fMC8PZcpqP4cfUxOWj9ACnHIVOnHFKWqUoaEu/RXOgqv+V1Xzv6ecuk/c0H1mVwNPD9fPOIH7suSm6IrVX0OhY2CqfTQQh+OEXB8zjltCHtQTu0mNG8rjkFw/iuWSDTwnwG7BIo+hKPMuVqk4TCNE1xQBwWvs0VVegqDbsqWzSQyPF4f/TpKMSuLfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxfJzUOYUQTYpZ1KeXRQ5akStSMLwcyuQbhTQVOuPQA=;
 b=WgjFDoGs5d2X3TIuxvCIQ9K8fIoHNuqgtGrhlhAUfSFwaRmqkCOLHFM5l93OdRBDLP7tUznFLYGI1oGKiJlreAx4kMCVhT3gU4MzzGvKG/1OLZMGB5zQwsNvIy8uXBb30LjqkjkPodGEqcQTbZJ9K+MZUvF8Axzc8hJRWFOiq1Q=
Authentication-Results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none
 header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BYAPR03MB3672.namprd03.prod.outlook.com (2603:10b6:a02:af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 09:54:31 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%7]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 09:54:31 +0000
Date:   Wed, 24 Mar 2021 17:54:24 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: mm: remove set_kernel_text_r[ow]()
Message-ID: <20210324175424.065b90bb@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::35) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0210.namprd03.prod.outlook.com (2603:10b6:a03:2ef::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Wed, 24 Mar 2021 09:54:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ead5f80a-80b5-48b2-c639-08d8eeaad274
X-MS-TrafficTypeDiagnostic: BYAPR03MB3672:
X-Microsoft-Antispam-PRVS: <BYAPR03MB367238FD08B01E56F3C7E45CED639@BYAPR03MB3672.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:134;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vizYaMpgGgV4y/HFg06AaC5lLjiXLjTU4IqdkEsabe1q8djC390FdwP29wDINlIG8fGaKtilPXGmswqt21LYxbPyXtfunhMot1t6mus1oVvJqgU6e+o1r8mgTMQZf3q/Bq/liomEUkypxLCu6IDyG5Gg01dbeoRY3oUhlOfaJ9AKj8opeGrsxBOCN+t2nudkzMicqC0EZuSiAqGNYCXk1wmQtirAXSjDDa2nIyfmOGJz4NgSvZU433CkH4+foT8ZyKb+JbpQKkETPzNnc/LiiLDQbSDpHLWwDYMKHvf9/3wdY2QEMRNLYr+sNeDGPXimPQbdREUoYvKSd7A90NdxnSp8gFSIY++xU+4ePn75pGlqAUMEETjxUmRgFzBOMNStG9y+evEJsElZQPU89Uj71X+SQGR1Z5HBYtkSjqQ1sLBPuJaJYeqNQnG2niwoJvq8EXXtut1N/H4x8EOClE8Se5BWztn9phJdU8LVdOB02DHbKloG6HqbKrEXTey8uI0NH43FAeFMrqvfEy3o7s0qcvwzhYEvu0HBlyrV9up78Q+ijVFoOLbc5fxPQBTxZS3SXwOT3eKw/rgQAUeYH74DwHAepmTr4ZjKCz8kqAVbLi6zv8LdpIlyNq8zNFNeZJAUNjwW3OoL4oCaAWkj38Iww4z5BhAb04mi6GHbUZYHFD0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(396003)(376002)(346002)(7696005)(52116002)(1076003)(5660300002)(66946007)(6916009)(2906002)(8676002)(83380400001)(86362001)(6506007)(316002)(8936002)(38100700001)(186003)(956004)(6666004)(9686003)(55016002)(478600001)(66556008)(66476007)(4326008)(26005)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fnxKpa/ydSsiiZ6B7mLUEtvUlpaHBft0tdKDD/mLXwFyfuIJH9+pB4eM0Xm5?=
 =?us-ascii?Q?1m+ZfGeqJ/7VljLfsecHNBJn8PF3lCgajm/UA+IVgY0vihIeGB9MOmu3DH1u?=
 =?us-ascii?Q?/AvoZ9+b/NDDxD1ieNeS2V58i6a1bDS0pFvRieJpjAuHjZ6/ELe019UZK+z6?=
 =?us-ascii?Q?va0CAh9at1pjdLiFYFo8FZX92tgye4t/1m4GrU5i6qlMsx95GTmWYQ46wX2Q?=
 =?us-ascii?Q?inTd7KffBt/5RvjWz/sCEC8GgfjgI1CXrlrdTKkNcZGBzmU5FsUSaEhS1Qg7?=
 =?us-ascii?Q?ZPtP3qnT4k/91qvTBy1O3zwD5am8ZUunJJW5aWlzUZqLHfmcPbWaLLSXwz00?=
 =?us-ascii?Q?tHUkPa5zZsdnM6F3/moYKSzUoQXSaVnU4QdejiM/7T72zxbxe3BknL/474z5?=
 =?us-ascii?Q?5VhBuQkO3VUubl4LuZ4lHjoNIHT0bEbAX0nZbQmC3GRuoO27m3zkBae7gtL+?=
 =?us-ascii?Q?LlvYvJGDLa+Av4NPXZd8lR1A/VJdT4HZ0Vj2RJE3mQuIGdcxnpZUKsP/0sKI?=
 =?us-ascii?Q?LJn4lGmOfm3SfHWF8+0NyCvfJ39m9wvhhhof0uV+1IKVlOahMVE5oSedbbJA?=
 =?us-ascii?Q?lju50/HdJIl3L7iR6pGVxB7TtdU5MfcXpCQt4g90OAnNhTxIrGE08WrHxOl2?=
 =?us-ascii?Q?we00cV9cLTdCRQq2K6COd90T727YV/3yrV9vk2ci0pZmk5RbzkeOxUg9ECtj?=
 =?us-ascii?Q?G1cpWlxH1mF4uBwER5G6SHFDDtGlfq0wFdrOw7/2at8Y5qEYJLPzXj/pueFo?=
 =?us-ascii?Q?3yH4jBNtZ5G2k4MsWazT7yeQDC/H5OrcJiqmVsMx0SMm+QFxEojd75fhYRJl?=
 =?us-ascii?Q?Yg+jk/QUyGOsRrWRrS3QqNjKl8/SRNJ0SabyS+Vu+nS8yz14C5lqVRtWeZUR?=
 =?us-ascii?Q?3snU3lBUwg0zAXym/AReC408aupePbu4FCnIv7CVLPCDRy3ib3Ma4jVjkCta?=
 =?us-ascii?Q?TcOkOyxdj8Lzqu5f+a0tscvtyhDbxsOih8etPTBfuV0gMV7RXCrpnQFrJAAI?=
 =?us-ascii?Q?q7fSyodRekTIC0/oqoRNh6S3kE45hrJ3x1Tflp61jKJm/YOMQVYQQyt8eBd1?=
 =?us-ascii?Q?OidyDQtr+IBdpLgaRcqLDimh0LA5SjMA773ocxx9s1RTy1A8WwbVb3QQwzHf?=
 =?us-ascii?Q?YGqpvJf6ZQoFJDxgi15GTJNvURihD2WzPfL791Nv9eQTt631LBwHqWxvMS0u?=
 =?us-ascii?Q?VML83zr/mr5kQANBcGdERFx0JbNY4nGzQLZEhcW/8FQOK7TsTrlnw5ADMKl5?=
 =?us-ascii?Q?Je0yVSrZo4oZRJo+PG2TKG0GvrE74yEh078CfXnNvgwMvc3fVbwREWqlYNR/?=
 =?us-ascii?Q?uEmxFlY1juAWb14WBSzvW4Ne?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead5f80a-80b5-48b2-c639-08d8eeaad274
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 09:54:31.7426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1MCC8eNr1eqc2sGkIWk9kekVAfg0rWTwD7DM57ayAZxOopbCxO8oBv6IrjumaiQxH3vux6SXZalmukiqJGqHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3672
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 5a735583b764 ("arm/ftrace: Use __patch_text()"), the last
and only user of these functions has gone, remove them.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/include/asm/set_memory.h |  8 --------
 arch/arm/mm/init.c                | 21 ---------------------
 2 files changed, 29 deletions(-)

diff --git a/arch/arm/include/asm/set_memory.h b/arch/arm/include/asm/set_memory.h
index a1ceff4295d3..ec17fc0fda7a 100644
--- a/arch/arm/include/asm/set_memory.h
+++ b/arch/arm/include/asm/set_memory.h
@@ -18,12 +18,4 @@ static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
-#ifdef CONFIG_STRICT_KERNEL_RWX
-void set_kernel_text_rw(void);
-void set_kernel_text_ro(void);
-#else
-static inline void set_kernel_text_rw(void) { }
-static inline void set_kernel_text_ro(void) { }
-#endif
-
 #endif
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 828a2561b229..039c19597c7a 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -487,33 +487,12 @@ static int __mark_rodata_ro(void *unused)
 	return 0;
 }
 
-static int kernel_set_to_readonly __read_mostly;
-
 void mark_rodata_ro(void)
 {
-	kernel_set_to_readonly = 1;
 	stop_machine(__mark_rodata_ro, NULL, NULL);
 	debug_checkwx();
 }
 
-void set_kernel_text_rw(void)
-{
-	if (!kernel_set_to_readonly)
-		return;
-
-	set_section_perms(ro_perms, ARRAY_SIZE(ro_perms), false,
-				current->active_mm);
-}
-
-void set_kernel_text_ro(void)
-{
-	if (!kernel_set_to_readonly)
-		return;
-
-	set_section_perms(ro_perms, ARRAY_SIZE(ro_perms), true,
-				current->active_mm);
-}
-
 #else
 static inline void fix_kernmem_perms(void) { }
 #endif /* CONFIG_STRICT_KERNEL_RWX */
-- 
2.31.0

