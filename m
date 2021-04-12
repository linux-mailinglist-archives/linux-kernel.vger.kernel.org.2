Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7723135C2DB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244169AbhDLJvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:51:36 -0400
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:41024
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243170AbhDLJl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:41:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LR1aq6bXMlMQOsZWoopyJhJrngLc/DokFcoTF1oazKw3BUu9xBI4N1s+tLufbovGOerL4kD1y2LhQGCalGKtwrXchOJxy+XVtIT23a1A3lcjxcnYFkdiSwkDBVMBy/7lYjzCpiJTAeeq1BDHYYqDEg3eRvRrtSUt+GiAlGGx6v9DCaPZBV8VRnXIPJCI8LADbtH5qUW/3jQO9mFg738pv7Rc8d61Pa0gMmL3V5ax97T3Iv+j+RFRpWJc18GAyh1wWwdU9lr3s6lffwwtx3eo54bB+Xo0h68Yphnuka2tAOd4oqutV0XFGUEkTtofBXHo6wrByJexN4KWGe53o0SFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFTmj08wrDk1R0kR8vsX9vx+ugpaQV1brUMoz77Y6J0=;
 b=MZWYyRTJI1lJWHysKOedwrQhp3ELLN15eJDV1+I49iIvNI7Lm0+x3X0CDYZgoMHfriDCXPNn3Er5R58JQOiVnXJQVuoAcnUN4VphuTEufDaf4kegHNuhCmW28SsBH/ByiQ7fFGp1igFJ7a4sM2o7DRZprZTf99cCWbncAxsTU6FTkJ2J4pIe/kVQUP8TerSPNg9Hdp6pnaTzpsHfal6ej6AQvMF7sz+spQQ+sDw60uFmRsED+gRgIsl6MT1cuY3k19K8kFJzQNWhE/eF3fusoquD3T/xk4rwKyhuhQecYiw3pr13yowSRkYI6QVoYCeSzEjwe8uxGw80ajAn9DJXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFTmj08wrDk1R0kR8vsX9vx+ugpaQV1brUMoz77Y6J0=;
 b=Iq/quSN7lja1hQOWMSeVSOwvffN8IuBdyu4jVuQmpqNlOANDK5KW0Xc9dtTdGSdM9TOf9z0qWgHfvsnvR56nGh7AeeSp8IoMIzVyIwxQb8THXhV/sGd0tikyx2I54p1UIGu2DEoVglWOSP2CKyk/2hhh3GFqu+kos45dqGKr3/U=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by SJ0PR03MB5504.namprd03.prod.outlook.com (2603:10b6:a03:28a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 09:41:09 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%8]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 09:41:08 +0000
Date:   Mon, 12 Apr 2021 17:41:01 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liao Chang <liaochang1@huawei.com>
Subject: [PATCH] arm64: kprobes: Restore local irqflag if kprobes is
 cancelled
Message-ID: <20210412174101.6bfb0594@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::8) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0123.namprd03.prod.outlook.com (2603:10b6:a03:33c::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 09:41:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4160eb4e-26e1-4df8-53a4-08d8fd97199f
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5504:
X-Microsoft-Antispam-PRVS: <SJ0PR03MB550407E7E2566C15A415329FED709@SJ0PR03MB5504.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Icvy4ag0JNxA74qClbTJJfyUBeJ7jtj0jVbq6BP3A4QcHvdyoWut9s5QBoB/o1furhJ/WgRSl/lPaLF1epzzPUp85np5uH1wrc9c1f/keuM3NmiSUKhUzKOC3MV79cfCwIlO/BgbiTwxlsjCR3dJOTN+Qblkx4oV2fWCXQLEpxgT821EqsSIo5vz/xd2B/I3AwEdYlZVk7DIA+FPwZni2f7J0PIeuzrEqfnItxTcpMDGIfWfQqgOmvGJpH2abavRU5wsLYoNX7EIGQHOupgKQmHdGVeT1HvhfCO4Fti0gwNPbc0wlQ4grP0UbssjB/Krnyy37cTqu0BipiLcGK9gL7jQVtQ6PIYlOiZ+dxrZ4kBm8orJLVBP3SlyrAgNYcQ7wSk8riePJKwbo73MpwiiAQ2B1nrcwqBYrXZlSS9hfbhUr01D1qrKJKH5nt0VIXOuc4kBmnVaz9jQB7EOs7bL8Hl1lhf2SMudHasOryiSm5B1nq9Wldzm6AtdVS1EmXIT9sKNT1gZ2Ru65V0NBsRuPgJWe/fr7NzzgeLzzdbFRJapSvrzAeJXqqDmXEuDKiP6SXypIXC4B9sbeRM7N1QOF4Dmcx2NVjiyGFKI3OYdttowHC+e7eMmXHjFDeS4f6TIrf0e/QKJdcyQyHRphbis1SNUpOYk7rgK54yeiS/0uys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(136003)(346002)(396003)(86362001)(38100700002)(2906002)(9686003)(4326008)(7696005)(52116002)(66946007)(1076003)(956004)(38350700002)(55016002)(6666004)(316002)(478600001)(16526019)(186003)(66556008)(6506007)(83380400001)(110136005)(66476007)(26005)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5Tgy6j9U4AwaAZ4nouLTxFaHGQgMVVa9xzusp9IQwmutUSeKBTamOyph0aw+?=
 =?us-ascii?Q?dZ+G08jqFoP4d0xue0Typ2a6FTnzTQJBGZpUbYUvxR2xOBTdUbanIzn7TmCK?=
 =?us-ascii?Q?Aj2nRSnifBVUvbZaLxaYvQ2cceHWi7QGDOO5dcB5Jd3sHF2ms1SIUEoYrzbP?=
 =?us-ascii?Q?oYUTAFV7SS8CSKJ/8RkDrcF2Waue0kI+gXrYZELppTMGf6f+qv4qDOnfxoHS?=
 =?us-ascii?Q?1OeOCEmX5Q/+2YS6thRPx8QHuZ+Q+wr1cX9tbQCg7h5iUuUFoy0ybfRn8Mie?=
 =?us-ascii?Q?mitdVTMoXi+6jgrLPjKk33JHnOl07Kt0B08gkAcNgWe7Yh1v/KC5QxalyX5R?=
 =?us-ascii?Q?T2lkvZtp34boilwWje2gLE8l6bBa+QOKQL7lfezhlDruc9KFmxutp6XPadN2?=
 =?us-ascii?Q?ORgLUsyjTAedO7yZlDNu41KDWnAMu93CItaGNASX+B2QqvtTHEshWF5604Jy?=
 =?us-ascii?Q?S8n9gh+6eYXtM7Ol3HsKuvVQIBI3G15ZarHVjyS/vBnovnJ1e/7azshXqRyB?=
 =?us-ascii?Q?YtyuloGnRHTydMQk7v1rp6YY6H7I1xs4VaSu5c1xKyYESRmnzo0Qp0OpfJ9+?=
 =?us-ascii?Q?QVOLAsJ/QzuNOT634zcEE71ZaSVPMPhXUToehxPUl1kpwoGLDo7R3Kb1kUHK?=
 =?us-ascii?Q?VKbp5QrYFYsuJ+e40uJB/6k+U4s6IUmSyGoZqB365s98L+XRNRMXSJQ1X51Y?=
 =?us-ascii?Q?By8/CUvpg13WHi1mcPju2lnRrJP3Cjz+YdO9apWqanfxpn8pYvgzcYm11UHS?=
 =?us-ascii?Q?psJ2gpKsj9qf3BUAfWkEV3niVlk9WZ8lBYA0x0PIDJDQm5yqrLjZvdqKsUCU?=
 =?us-ascii?Q?RP6x5y3RTgi+KtwBXyxkSrF+97WY1c2eiVfSHnzdNzVM9Rw4mxPF8OA1I7/A?=
 =?us-ascii?Q?IJeBjb6j2jNUNec70BU7v5JjI7s+2PDF21TPVibnJ2TzesIIZQ+nJRamY4AK?=
 =?us-ascii?Q?zKUOAl56P4uiw8HJVE3+EB7tIjGEM5UdapV4uUHeWyb2z6RrvTZNsbDociY2?=
 =?us-ascii?Q?6tRwHS9u7+gw7/InvetHXtEdaBaP7AdmV5LLYz+8HRbxwEcmszZ63lGdi/0I?=
 =?us-ascii?Q?XO5JJJ8vUAKDq0W7zc0nc/ONZutGF6q0IwbE771r528lDqvkEuygxOCioC9v?=
 =?us-ascii?Q?xux17l5RYzzwGYpc9a2WESJtTxtrhKPyl6iKvWCpc5svC4cwRpqCRpUaDkMD?=
 =?us-ascii?Q?GHbjh/m89to6o+w9wtBFyKPMgcidsPLSE+lBWWZLX3nBbK4QWmnoj5fP9knM?=
 =?us-ascii?Q?b0+ogoKRTrDArgHlVz/ceCyQnQsk2JAfWFFhaSdlOm+PGzDXSdPR7cEeGrUb?=
 =?us-ascii?Q?jJK9WTHSxKqtwloOZIMMMjkT?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4160eb4e-26e1-4df8-53a4-08d8fd97199f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 09:41:08.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5vs1ROkkGGGHxQEOHI4xNo505rx6aHJaDnWpebW/JVF3TjN4mUlGQt67EO356RjU9Jq5j4kzsWu9Um8HQCEmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5504
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If instruction being single stepped caused a page fault, the kprobes
is cancelled to let the page fault handler continue as a normal page
fault. But the local irqflags are disabled so cpu will restore pstate
with DAIF masked. After pagefault is serviced, the kprobes is
triggerred again, we overwrite the saved_irqflag by calling
kprobes_save_local_irqflag(). NOTE, DAIF is masked in this new saved
irqflag. After kprobes is serviced, the cpu pstate is retored with
DAIF masked.

This patch is inspired by one patch for riscv from Liao Chang.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm64/kernel/probes/kprobes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 66aac2881ba8..85645b2b0c7a 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -267,10 +267,12 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 		if (!instruction_pointer(regs))
 			BUG();
 
-		if (kcb->kprobe_status == KPROBE_REENTER)
+		if (kcb->kprobe_status == KPROBE_REENTER) {
 			restore_previous_kprobe(kcb);
-		else
+		} else {
+			kprobes_restore_local_irqflag(kcb, regs);
 			reset_current_kprobe();
+		}
 
 		break;
 	case KPROBE_HIT_ACTIVE:
-- 
2.31.0

