Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FA4361AED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbhDPH4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 03:56:22 -0400
Received: from mail-bn8nam08on2046.outbound.protection.outlook.com ([40.107.100.46]:48800
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233959AbhDPH4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:56:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBeWdnqkQ9pA3ZWD03lOeKL2HLKPMjWaFGV0S+t8/E+NBMPY38iXgpIkZdUdfgqDsaIlqhNn+vwdzue9+neAgg3jcV8bLWPU/HrQ/UCDKnGH57hByytX7occwa8SEhkc//cnzPcZ/+q2vPjanHMHW3W6G+ScWplvsomeFtnJthmqRhNq54otVuiMqH1FJrjYAndICarluN/SIj1LRRK7RogVVOJzaW6FZMqVAgid6He/T6xastQZecLHW/KkfxyhVXH2R7fQiQJd/4c9bAYlyZxP3Xnto34zwIizHGmoc3hWws4QZv3gSfgAAew2XqDkw95n8qEOMAbQ/0gIl4tgLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMX4HDG+uDIZ9Wjj1oVGQqWUFQJSs5aN6Dbo7FarFNo=;
 b=RwMs+ZQC8Bxgxtp0idcdu0Ob/hAgQE4b/BZU7k327QD4A2znv1quPzwHXVGMtRW7/lIXSOH4yp8xlKS19Q343VMt1eO5yPjq0LzEHrw/jrz29FgXYifhp986b2J000dziUjQkrKdSi4nsdAdrLRFEmk1pdTc7dRRCqgsNR4wgOiYg6VmJm05KlPBfYI9juW+gtjadtGASmbii/D78O32Of3P+g6XJJ4CrCCO/11BH25uJItagkDnSLWiYlTLKUWbgBaVtmraOUrtgyjbZVnHyTpVHyV7ZXaUx9WRTJri/zYM2roUa2qgOziZjaKlk2ODvwi6XLpRDvOlm2JrK5A0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMX4HDG+uDIZ9Wjj1oVGQqWUFQJSs5aN6Dbo7FarFNo=;
 b=MUILitxWFkUfqW+ZY+4M9j4Mtkd5MP+5+EsmAeGgIOz2vtGl9nQ+WVrDIkRXT3U5RntYkADlj4J/Nq3NS8NUvFkTjFYfhD6nE/4ASpiCeC8pUnxnL8KZMR6nsSelBXh9Fe/CDo+8joOsRelntOGwajbsx1S81WxP8OMjH/0Taho=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MW3PR11MB4763.namprd11.prod.outlook.com
 (2603:10b6:303:2c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 16 Apr
 2021 07:55:53 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 07:55:53 +0000
From:   He Zhe <zhe.he@windriver.com>
To:     oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com
Subject: [PATCH 1/3] arm64: ptrace: Add is_syscall_success to handle compat
Date:   Fri, 16 Apr 2021 15:55:31 +0800
Message-Id: <20210416075533.7720-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0064.apcprd04.prod.outlook.com
 (2603:1096:202:14::32) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core2.corp.ad.wrs.com (60.247.85.82) by HK2PR04CA0064.apcprd04.prod.outlook.com (2603:1096:202:14::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 07:55:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 808f9646-ef10-49fb-a4b9-08d900ad0eb3
X-MS-TrafficTypeDiagnostic: MW3PR11MB4763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR11MB47630DF2D55BEA8BC64378AE8F4C9@MW3PR11MB4763.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDazGbaZzFrA2nKTl7qLk5Qo+DshriCVsYtmrR5+1naw8FQonlKCvnaVOpuEqhd3MSXqlphqJ1OmShCwz+1Dcp8ngbGqKKglHC+RnDj83mT+Kyp7UhBrFuA1ol3YaV2HDsikEWmb7wchpSE+iaL8fshDFMc4qELrCqBX3h32LpyCLgkg0mN/EUT50iRXb3Ak2qTF787hk8jwq5/d2kFqB6lFrijDKraFq4Mc5ZTdGk5XFz7b3lBAejTzB1ut9ksz0ifnChw0ybUKj70qhpOXb+EUlfCNyxpyk2QPPbOvCG3RJb9UUhrIQoT9FQVjFgiLl3MpjePdToxxilnem7uvS+nurIo0CC+r7XlVNSnXE/sLw6p4F3OjDHzsCmzHRX6gly8pg8IWS8QvCQNZteGCozPrG+Q1bG0fdTjGHP/n5Bga2PbmQBwNOwXKhP1viajvhyZogDW1KsssQCEuKBCPLFSmg6MdW0WvpefPoORB+JEca5dER1ev3eQQRdmmyecor6wphzzSHWIBOgYTWC33sO2aWcQzFaRQzQXeGuG1KOVEPOUkDW5oomgpjWVKGJ4A0vZgd69ZeWRKaPah7HtZN6ed2QjaQzd0NZcMUD0QmynHaVa9CiFy5JhU1OrOBYyzHZEGo0I+RBzED0z2ei4MnExMUmSt5Rv1P7mMBEe51r8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(39850400004)(376002)(16526019)(8936002)(38100700002)(316002)(186003)(6512007)(6486002)(8676002)(66556008)(38350700002)(5660300002)(956004)(2616005)(26005)(1076003)(2906002)(6506007)(66946007)(66476007)(36756003)(478600001)(83380400001)(52116002)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ko2oklAoGkkYlNJkhDR29XFt13f16YjUdrRpEtG1hWLdZWZvSLifZdTjsZad?=
 =?us-ascii?Q?bmsP/4941Gm5JNvNCJ4b4avkjYJKzAC2ci1ga82cGW+C955i5cKEEsRcbs6a?=
 =?us-ascii?Q?OHTB+FYnrOF8XB/AwkaVPW43sbnAR+SWdmq5VAsq1pkd+jLhhV/iJ/ybyLR9?=
 =?us-ascii?Q?ZL919HqYp+jwMoDdrtBZhflIxLMxrWpY3b0w7tikoa93IjrHMTtJRFMfBb8f?=
 =?us-ascii?Q?H8dDsSwh4rcjx6i/YNNGMgyKNb8dVcDcSpMF/RVQ9wLSFKQ4N+kI0Quhhwen?=
 =?us-ascii?Q?9keSn7iwAKh31/EGOFC36cQXDxeC3CFIcYDRfQ8zxbcsmmmBmVKkSAkh79OH?=
 =?us-ascii?Q?rfYfOMTyN7c5o4T+oODCVeblXPZYKpAcxtu5qsi3LCzQQJFyS1y36R8FY0qR?=
 =?us-ascii?Q?3PnpYjiH6C1lGMYs2/YvPQg2g+WxIgNEww23JnxrtLOGxw5tGaRprYoqG/F3?=
 =?us-ascii?Q?rz2EbfkFQfcY+euNVCYpqgrFZqhdqlSIwLu6oj9nmzGA0MptrR923jYEJU9j?=
 =?us-ascii?Q?tLWoToKMduiDJF1qxCYo7jjt6mU2sRJM3Hlmvy7l/kVBWTvWSKrJ8LFG1kg+?=
 =?us-ascii?Q?mK7yq+r1/o07T5Uq8v56E0B20FT99+mvMq1C2Tpz2gl/O0ymMFXtTiIoD7oF?=
 =?us-ascii?Q?YFNyweRHLCb5Dbly8+jfyZ3lB/SNa+PWGGFnupmJjWAheds24eE1xrSYEy8y?=
 =?us-ascii?Q?9F89x8aOxlP/mgvTopK0xFgCa566D8/YcOcGfSv46vP/+tiIeGYKFOS4fqeU?=
 =?us-ascii?Q?nY5Dhr5uXwQmuDihl+TXG0aT7YhqJim7qoMFdmB1LVnntx9eT75u1XeDmHZI?=
 =?us-ascii?Q?bje6BXMoAbtW/jVGVA7Pqi6KaC9cTLpDYys4NBrLh0NkuC/Z1d9zVtPsNL/x?=
 =?us-ascii?Q?xYMhZjg22aUAaQivRUsBj6mXFM+ACSkckAsswfJQVHI4q7iib0vttfgRxymC?=
 =?us-ascii?Q?cYlyYOkke5VVwL/BYWHlbRZPbNOCEWeIGqgHtnzehv+j52/zTZvZ6Qr7UDW9?=
 =?us-ascii?Q?2js87Enwj0RGxa7ItDYzsKdW1P7fmqhtEPI5uqXxFCiNO9Z9G5TwMi85R4zW?=
 =?us-ascii?Q?cvsHtpZpsgMTWMLVUMrCUo/ykI3EcQYUGvg0QwhEnyJw1XuevPBowLQW9cSY?=
 =?us-ascii?Q?xZn3F1/D0QGsCoeMJj5YKPiSot5ioypG2Xmmq/bHNjT2d0V0YmoED1Xf5J1k?=
 =?us-ascii?Q?WXiq/FKt4uHddUgB4Q4Fm3nzOfQHH/l3wKONI04htx50Dcw8Q3ITjZ+Tbiqg?=
 =?us-ascii?Q?15QTOBGEskgSqmLLoMKalWTnpAaMNGhGjshsIHKR8ZI2kSddRp4MqdoDYibn?=
 =?us-ascii?Q?l6qWbmgSTyXwpHGL2G4HbF88?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808f9646-ef10-49fb-a4b9-08d900ad0eb3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 07:55:53.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQ30CzyE9JsDl8fIzzzKK9c0RyDlm2+sQYwkp15ir3l62sv7uC5Nx8c/Csptdj1GpHVmglU9pce0D/r13Iwq7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The general version of is_syscall_success does not handle 32-bit
compatible case, which would cause 32-bit negative return code to be
recoganized as a positive number later and seen as a "success".

Since is_compat_thread is defined in compat.h, implementing
is_syscall_success in ptrace.h would introduce build failure due to
recursive inclusion of some basic headers like mutex.h. We put the
implementation to ptrace.c

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 arch/arm64/include/asm/ptrace.h |  3 +++
 arch/arm64/kernel/ptrace.c      | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index e58bca832dff..3c415e9e5d85 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -328,6 +328,9 @@ static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
 	regs->regs[0] = rc;
 }
 
+extern inline int is_syscall_success(struct pt_regs *regs);
+#define is_syscall_success(regs) is_syscall_success(regs)
+
 /**
  * regs_get_kernel_argument() - get Nth function argument in kernel
  * @regs:	pt_regs of that context
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 170f42fd6101..3266201f8c60 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1909,3 +1909,13 @@ int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task)
 	else
 		return valid_native_regs(regs);
 }
+
+inline int is_syscall_success(struct pt_regs *regs)
+{
+	unsigned long val = regs->regs[0];
+
+	if (is_compat_thread(task_thread_info(current)))
+		val = sign_extend64(val, 31);
+
+	return !IS_ERR_VALUE(val);
+}
-- 
2.17.1

