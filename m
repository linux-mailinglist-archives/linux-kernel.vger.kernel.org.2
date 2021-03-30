Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5216134DF2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhC3DUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:20:25 -0400
Received: from mail-mw2nam10on2072.outbound.protection.outlook.com ([40.107.94.72]:9985
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230339AbhC3DTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:19:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDkW90tI2cV3+Wtn3TgQk2xtkQBVrONv6hNINMvxkZO6aTpp3+zjejeksyJsvnEMJiiTZWhA29XX5aOKAyd/wPswJblvizGDEjnS47AnnARD+UeIr+yM/Xptpsg9BqtPF2rkN2kBTiVC4Eag5mKB2kSLKrp+gf0Yy3xH6HT0pfzcyuk2lVwpqAhpJGpaiDkjTtlmxb+dhONiJcD9fT/UVA1xvYgEqX71yrkw2+GfHiwB7hoTbYMKMp2qWioo5KLYoOmEe5kZxLPiHhVCxu2/C+SJIoeonpIWt7FYsJ+pTGSoHB+JsPGo5ZuxxMsX+kF4TLAS7uzKBiUEnC7MQmfBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ6q9lQxvewPEKCqYKtL56IiNEpYGnmXtCJ3z4lvezo=;
 b=kyVWeKC02QpNXJFVOrMoTI01py7nYljJiOw6DQpzO3/qANV7psokmnA/W50Xck5MspK7oXSW2xoimEVbxZmS6j/7/yvNKEsC+aiGabjKLcX0SXN0KKb0N2RYc7S15/XoIek+bhJAeJbiwppSHuiDd/fjklllSIhfGufATs6ltPu5jg+VkqaYoZrFe6FWO/ta1unvyz3lduMw/c+P6p/QyGKzCXEu0uBE0hAtNo56r/yF9d6deL8KPuobRCCCXXW6y7aO7qo/rkF4c55JKdr5SbPFE2EygqW+1M3uBZjkUqEVxr4eJdvC06/FEfOFMXrJmG+k1b6n+WBKjNeuTVc5xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ6q9lQxvewPEKCqYKtL56IiNEpYGnmXtCJ3z4lvezo=;
 b=NVwXr3obyOmUTHJ1pJAU49Vr5DMBQ5yfNGqLqLZ013XhG+f6Mu2CXRwm8lBRogyTbgh2X6XnKYSiYOIraKNnUmucSBohaAmL5A5KLEZp0RWtL3fNr2rxgSRVtwhjm2dIG+CcO0YZlgo87p/6VEH0U8MmwB6QmN/LqcfE8rAvo54=
Authentication-Results: armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=none action=none
 header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BYAPR03MB4616.namprd03.prod.outlook.com (2603:10b6:a03:13c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Tue, 30 Mar
 2021 03:19:28 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%9]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 03:19:27 +0000
Date:   Tue, 30 Mar 2021 11:19:22 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: ptdump: add __init section marker to three functions
Message-ID: <20210330111922.2fb4eaa4@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR02CA0064.namprd02.prod.outlook.com
 (2603:10b6:a03:54::41) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR02CA0064.namprd02.prod.outlook.com (2603:10b6:a03:54::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Tue, 30 Mar 2021 03:19:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18e89f8b-c80b-46bf-f762-08d8f32aa055
X-MS-TrafficTypeDiagnostic: BYAPR03MB4616:
X-Microsoft-Antispam-PRVS: <BYAPR03MB4616A9727D953BD5F6F1393EED7D9@BYAPR03MB4616.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DmU2FnK7prHKCOBbIEQOSlVU00ler/6MqX4Q1MOSL87kzltUnXfQ18/aJXYK1+fc4fHFeewqKMHpffL3D6H2iGeIG/E6i7bRRVwYaCbJzgM/b5+CJ7al+PJwfApj1K2CqdndyoJueplAa66IPa7A59kgOoc6Sf1rw56SxAEEQUAnjr7hlY0RmViP/uwL/veobKzVeq4vJhjiLst4AyuJXwI//1cZrTbQSjPXKcSpjSnBEVIJ8hW/Ck3EY7ATFwzcbzPIFpDCowt85dsZKTNYzHb02A4FvgF8REpEvGNhcq5ohDfO7/K4Ds5OcJeMsVKT5zmq8rjMxGI4/Li2hkAULfoXcE+4HEqqsVN/g4O+xp3ZBNDYtlij+bQ4Oe/8lt1Fsjmj2/DicusWDKhqxuFBH4MBw41/+Ur7Kvsx/r5qA+VHHXwvh0bSXK/OBkUtEqtew62L2FrV7eN2oQK5Vpe7X8Nn1dM5lH7JcM4bdz+YTOs22dyEUxX0WBPtzCOoOpUiqpIjc4GalqE0R0M7wpMe+i7DhBalT8jM94rU4sewkQ53+7G4jRkbeVUhr4pEdwAbIsKsBxh4j184V+C+ZDDCewkyCx/nfyvmS4nXhOqlCkhRxCiF53lz9Jgugs3DEgr6vKB440UJqmrJyPUgk8ru5Td0XBoJYo8VJ44fUYAjsmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(346002)(376002)(366004)(86362001)(4326008)(2906002)(8676002)(83380400001)(478600001)(186003)(26005)(16526019)(6506007)(316002)(5660300002)(1076003)(7696005)(9686003)(956004)(66556008)(66476007)(66946007)(8936002)(55016002)(6666004)(52116002)(38100700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yARtMDFZlFJ+SywBLPbFeT9vGnhMLPEYiZAfBrjU7PvRRYSH8JX2OdQrkjM6?=
 =?us-ascii?Q?n8LoBsMDaIunXqoivHHRFCLh8C/V3Y6s4otP8OEEZWtiU124LKmnFnMQhURL?=
 =?us-ascii?Q?inpV4fzX4jfYIe+qUTc6lH9GbiWF+TpuHU0bKJepayGLyBTMbIayEm9O4qy0?=
 =?us-ascii?Q?PBl26qzRap7uSNUcycqouilkPHBnzCkzc1lpmHj1TkIekWv8IIPJux3k7J88?=
 =?us-ascii?Q?NQ15XFidCUWmFwYOU38xIIN+jkZJdKEBy+bIs7SjQ4GA6Z5qP/96yrlngBOh?=
 =?us-ascii?Q?va3y1+NkSNTnnUC4UGZtmDdBKJVTKW7ah1jr/ZJPbZty+K6MxsTyVZ309m9+?=
 =?us-ascii?Q?Vjo/nLSI5vm2TvThqytC8D7sNEvcLpXNyMoBRBvm6ThqolGJ3V2CzjVnxFEh?=
 =?us-ascii?Q?n1kFV6CFwb4+k//s27G/fjh6fHRaVFkDxCTRHDqFJSLRc/6yIraEvFGeoS5D?=
 =?us-ascii?Q?QM6AxV7owAlHwpCWzMJQZ9f+Onxf7NVNCoyg4RoM1BnK9/UbJdS+VZWPVAdk?=
 =?us-ascii?Q?92Q5ic9EA+r7IxthIyZHW47Dp4Nh6RV7qrxZk6TSl6/OtvGkxrhbAKv904bn?=
 =?us-ascii?Q?ZnxwW/6rL3Fe3lwiwscofkRdrFRquoNXr8Z89kKujL3z4+qWJtM+QpTWR/0/?=
 =?us-ascii?Q?MqI+fbIk1q7l2sGGkK6KgFK+fbAC+luZ+2j7R+Qa3uh/ALCuWduF2eKw/cq8?=
 =?us-ascii?Q?8+Wn2ebqcFtQ+hvFBWDcVixEAOMXOWpzl+Z8UujQhP4LUfNwYIP+dqvujENs?=
 =?us-ascii?Q?tdMSdQXQ9DudaHJ5AO1EKfmNMbkKY5tj5DRkG/emTbm3dpNhR8nwO6WNCn3/?=
 =?us-ascii?Q?2wdO6f5nq4xFUslrNL6JU14ZI6xyXRY7cjxcZJGMyvIMVE//N5gRgnYWeddw?=
 =?us-ascii?Q?CsXlrL3HcXQBJQ8wIj98saL+naaw9VjPwpSxZnlVl63bZPhCBpx6K3AD620i?=
 =?us-ascii?Q?J51WMpfevzMTjWNegj2JFXPKNmFSG4/9iSXxd+6bDUtf10ffxC7IiqJLOT4+?=
 =?us-ascii?Q?Mr+/PqlxhxMP7OvM4Og2q/cdFXLrcY7FY1DV7j+zDR/GY4mOU8Q+8dPfMbHr?=
 =?us-ascii?Q?AMWiG/MqkGRtxVSveuw/VfJfDumAyMyN677Q9rJ0vfHXzOjdkkY2Ug951tlj?=
 =?us-ascii?Q?+LP+rvqZ809sEi2FzoEOcXpNSJ5b2Y/fllVASbFxeSyE8zbH6yUbTEQvszA/?=
 =?us-ascii?Q?E9+jkCQxPFG29ocTEfQgbHVpUB34XM/clZkL1pMovgV56g7UdwCTQDaQqSsQ?=
 =?us-ascii?Q?jBN3Tfb0dAPrwrOAGI8CyFlsDEkKfwooBfPBO36LVtH3SWMzx6l8WU3bNnYg?=
 =?us-ascii?Q?6qF+kYJN2WX/RRNeMZhIYzRB?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e89f8b-c80b-46bf-f762-08d8f32aa055
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 03:19:27.8354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5b5xhbAzgGL305rG4jaDHVAatGdgG7ARtGFiQMqng1IjjyMUledw9rO99nPVKBIuMaGld8ZnMquxndXjux3Zdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4616
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are not needed after booting, so mark them as __init to move them
to the .init section.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/mm/dump.c           | 4 ++--
 arch/arm/mm/ptdump_debugfs.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index 93ff0097f00b..fb688003d156 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -420,7 +420,7 @@ void ptdump_walk_pgd(struct seq_file *m, struct ptdump_info *info)
 	note_page(&st, 0, 0, 0, NULL);
 }
 
-static void ptdump_initialize(void)
+static void __init ptdump_initialize(void)
 {
 	unsigned i, j;
 
@@ -466,7 +466,7 @@ void ptdump_check_wx(void)
 		pr_info("Checked W+X mappings: passed, no W+X pages found\n");
 }
 
-static int ptdump_init(void)
+static int __init ptdump_init(void)
 {
 	ptdump_initialize();
 	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
index 598b636615a2..8df9afac8d81 100644
--- a/arch/arm/mm/ptdump_debugfs.c
+++ b/arch/arm/mm/ptdump_debugfs.c
@@ -24,7 +24,7 @@ static const struct file_operations ptdump_fops = {
 	.release	= single_release,
 };
 
-void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
+void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
 	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
 }
-- 
2.31.0

