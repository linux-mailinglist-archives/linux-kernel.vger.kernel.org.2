Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B977F35DC1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbhDMKD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:03:57 -0400
Received: from mail-eopbgr680084.outbound.protection.outlook.com ([40.107.68.84]:31620
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229817AbhDMKDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:03:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkpU4PRuOyN4lvGaP2faDsrKwCGcv+oXUXmA3TgKf0EVT9fjDPoSBeujP0sbquywQge8g8Kv1ESvciD7sOiqgV34q3l9lYTbvqEDrKmerxuIehjQGvZjWuPEKzhZjSXx38gsGV6a7GZg1zws2mtuXaDlf44XNWFe0pZKMLUBwkH8KHPh/PReCVjP0x4yDtxf16Ih2OHIM4Gal1vf/uduMSl0Rb2mBt0T1yUSiwF0HGLjGGW/M6Ekg+0FfAGeE1oMVIFs9YQG+n8EnO3hYkVGKZDpb0i8DY3R9eLu4v0g9g5huGzuuymR2zTzA5DV6JAPJjyfVY/fiAItTMF7WHtwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QewffZxj0V4MoRs+/sidE1lyEv2QkDBJCm4oTIgbvng=;
 b=bfHZl1lvWMK9jsMuOsHzZNrdoP5HSO83rTd7krZix0ooGkB7rl9N1RUGjmvAJNRQ33Hp4vdbkidUxeHqjwpr19A9Qi1V3JU7XYrFu6bzdJQfrgt/mBFgu66h7CvRL4z2koONZYPs9eLWaim/ufzKJHJh6trCHVoYVcUYlg5an6AV24rQAf+67iwNHP/EFRUTkI1cno6i+fh+AMsa+Uy+CaddRHw7HnTcty5hkKMwbIbb3kKL7F8tDwKcdwyl5/JtwVTRPxSfn8WYfbtISWlXxLi1/ycQMZCdVf4cU4NcLh7ha2m79a6dBDQVnSpedV5ihA+bvYv1wOCAdZuRyocymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QewffZxj0V4MoRs+/sidE1lyEv2QkDBJCm4oTIgbvng=;
 b=MkeLTFiPYxdFxKFnBTHSAiMlk1coEG3VzNoxGon3RmqR8o8PeTO9nSoARur0/bUIcFbAHvj8JOzqQrU/8S8ALEXOoPnqlWbcSN041a77sQo5u6vjg2+BJ1gw3GmtgL4tgnDKOUYUqk6OJpPs+WyveRYYYmtR5KRDgYBqnXNTtyU=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BY5PR03MB5284.namprd03.prod.outlook.com (2603:10b6:a03:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 10:03:31 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%8]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 10:03:31 +0000
Date:   Tue, 13 Apr 2021 18:03:24 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/kprobes: Simplify alloc_insn_page() with 
 __vmalloc_node_range
Message-ID: <20210413180231.19b72601@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:a03:338::11) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0156.namprd03.prod.outlook.com (2603:10b6:a03:338::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 13 Apr 2021 10:03:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13010ff9-19ba-46cc-1990-08d8fe636454
X-MS-TrafficTypeDiagnostic: BY5PR03MB5284:
X-Microsoft-Antispam-PRVS: <BY5PR03MB52843588CA03E0DCC59AD5F7ED4F9@BY5PR03MB5284.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9cK6YyyRLIxJ7a5acVT+0/FI190OIo3yhSn0PDFncuTODzn7+JzxiPxN+/s743APrAGbM8ADLS1jqDE86s8UxRPWErG3BiNzNp3yks0OEQfViS7dY8Ch41cezn6sVPTOUAcpQ533X7GtKY+Hb8CiO6joHXdRdpChcUw9V9XlbVSmuP1NaUpYP9B+XDqQ6q6uY4+GuSqECFgY9Z3nb6aLQ5ysgOOdz8c6CBWokYu5mqP6gvlY+673lA22v97GXyI4JK59J1NcSpf0u7GcsKQk3I3Wk4af9f9dgrQnKscX0fMICRaD+CfciR2rldIzxapRGsiFSNoPFARwdDSlVn91f2eviZPSa6AaAQ8rL2xZyGVjr+JIZ9mG4jHws13Uiqi1il7zqeBHR571xdO5U1aHQj2PglaQoZi8+0maYKXAtucslkU0J80OLzkqEjKGyikxdEOROQtn92QiLgkm7kcs1fiJWpJqsNGo/7bVw8zCyk9hLbjXcENDmoBPb6I/w/Zn8O3qpir/nJ0w3/Crb9iTpt1Qj4nxBjsIAD5X2V80XWRSeLrGTEwADYbr5djqiRs8AEz4oi56Y/1L35vkl2b2UPG/OcOzoTlVY2rJvL3Rt3vuseLJx4wJqh6HTj5oxzeSqpp3wjGG9Je0gJiDJYtOxzilksTg0ys4Kf2n6V2ZWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(366004)(39860400002)(5660300002)(478600001)(110136005)(38350700002)(86362001)(8936002)(8676002)(26005)(6506007)(38100700002)(316002)(956004)(55016002)(1076003)(66946007)(52116002)(66476007)(16526019)(9686003)(6666004)(2906002)(186003)(7696005)(66556008)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nugN19JWHT4QrFSquF5I8Z0d8nFEQwMSJTPhOVV7EuM9bO1CJvBrdhTIAiHZ?=
 =?us-ascii?Q?EPVN4mCaqI0Rvh4XcrpK7iEjk9nBdvBrOzfYoiaw4eV87RuOKwDbPFe3pOQW?=
 =?us-ascii?Q?31/B/Q170wf5amC1W0+w0a692rEVi2j1lAQXSS4Mc+Mx135JqF6wybB6YPdQ?=
 =?us-ascii?Q?Is0PO+4IhYVdnqPbJxqt567TEs7s8n8GMhZ4OostmxlR2BqXWJb1ECNL34KU?=
 =?us-ascii?Q?dX+V3RH65+XOHWkGM4O3ZPbdJ+KKdhtAPnuoQsAiYDkJ5LV3NvyC3z6Kp08m?=
 =?us-ascii?Q?asZN+bwxW89XoA45793234G7DRMs7ErdrzgaKPsWx4JMa9U4aVYx2Z5mHS2P?=
 =?us-ascii?Q?WAXw4LsHvWH4aV38NWp9A37yHIsYqOkDmhja7ysCZF+qrXw3qI3MJ6taSxcw?=
 =?us-ascii?Q?NzPAkiZskT4rxeuaYfLfEtMMKriIbeLXUBi/5XHdZBW1gFmhqJK97361WWBo?=
 =?us-ascii?Q?m5etDSOCk5VY25yTGOmz5VMCJ1S/Kf1jdCsu5JAVvZgIGB6LFRV09mlkNe49?=
 =?us-ascii?Q?7WzKjQJwQOxNpAt0JcIffDLnDseEPV26imWwoThNWJcnkicvJeoWUKQiMJkS?=
 =?us-ascii?Q?yM3aul4dTB1NmrqkSXr4F5get/7OuWwYuN/dhDQnZWZPfcxAx2im5AclETK5?=
 =?us-ascii?Q?GFYLaCKNUHXzX/SRNVSqGdLHE2t0/fbHfK6Ba+inH1loyIzBHC10jutK8/PQ?=
 =?us-ascii?Q?ClfaO2yrKm2BypVOR6xtY8juqZGQRR1SeBvLkMvJiq7I8x4BF8UEr5Nup/hF?=
 =?us-ascii?Q?yKA/4WcR6TclvykcV6BIaQ1rY0HONvoFBgfu9qf6fztz42TYV846plNeeAd7?=
 =?us-ascii?Q?pVjKrMKKRLoeg1W6IbsmgUjHDchC7l/ui3F6TFxZPFEj7j9MuKRtAbADNgCx?=
 =?us-ascii?Q?sO4cvlE7Y4E+KXLuk1h4PvYx1EXLrgKN8NCa2TS+T/fv86+12xpm1bB0XSvg?=
 =?us-ascii?Q?j8L2rG0x9kh9JI1PJVDy6KINOIfFJmhOEGZR9UP41yz/itAFhTuhArebhHWS?=
 =?us-ascii?Q?MNVeeFpflSu1he6ZuPsVeJk3cbXTv5R+Q+bfFiXklFi2SoW3/ENTK+lXU+hj?=
 =?us-ascii?Q?74aGnzvomWuR0xXYW+iYs8iSpCKgLO3v8ctL7J2+slHuFQpHKJEeOtPQvwnr?=
 =?us-ascii?Q?0R24qd59bWU87F+63bEI08fiArk62IfzBm4IBWxN3AKOWG98wjPsL0OURC+l?=
 =?us-ascii?Q?Cu3qR9kChc4TT0yxb7twL4fRPj9OxIkSwTPJyMnEi6+3GklII0T48Y58SI0u?=
 =?us-ascii?Q?R+NQpR4uG++6NzkcigUHhJ2CAes0ONcYHcyjvB9B5/6eY3XI/3wDDYg91uIG?=
 =?us-ascii?Q?e3rCY97Ixv+U56MVNTbh8ho+?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13010ff9-19ba-46cc-1990-08d8fe636454
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 10:03:31.3576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJOpvnThfFLp/opiMucC4jvfmz/PRuAXK73pCZAlyMtwnoS4lPoRAd8O07/upPTma9JjiXohYW4HXj+BDUt/bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5284
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the __vmalloc_node_range() to simplify x86's alloc_insn_page()
implementation.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/x86/kernel/kprobes/core.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index df776cdca327..75081f3dbe44 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -383,26 +383,10 @@ static int prepare_boost(kprobe_opcode_t *buf, struct kprobe *p,
 /* Make page to RO mode when allocate it */
 void *alloc_insn_page(void)
 {
-	void *page;
-
-	page = module_alloc(PAGE_SIZE);
-	if (!page)
-		return NULL;
-
-	set_vm_flush_reset_perms(page);
-	/*
-	 * First make the page read-only, and only then make it executable to
-	 * prevent it from being W+X in between.
-	 */
-	set_memory_ro((unsigned long)page, 1);
-
-	/*
-	 * TODO: Once additional kernel code protection mechanisms are set, ensure
-	 * that the page was not maliciously altered and it is still zeroed.
-	 */
-	set_memory_x((unsigned long)page, 1);
-
-	return page;
+	return __vmalloc_node_range(PAGE_SIZE, PAGE_SIZE, VMALLOC_START,
+			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
+			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
+			__builtin_return_address(0));
 }
 
 /* Recover page to RW mode before releasing it */
-- 
2.31.0

