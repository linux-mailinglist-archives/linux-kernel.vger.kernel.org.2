Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36889315FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 07:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhBJGpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 01:45:43 -0500
Received: from mail-eopbgr750053.outbound.protection.outlook.com ([40.107.75.53]:41396
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232106AbhBJGpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:45:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=astm26aniAQNyK1DMPe0quCd3o4TnGPJmqLS9Rs8PHKDlsVJVmepS7T6RgLmM69gBHcQU+ZmrkAR3wvBzAB++Nh7LqyQWK1UHZy0dJ6TSSGzAnjvOOfz7tyGHIciWZNgsO9W5eLaLyP1T+xVF1MjZBvYMlYE9A056pSOYSUNGCt1L7wooxoIIAbfpl85vxO4RAwOm1bWY3vk9souLU5LxFWv4WWCHoAV/hcW9wyobVgPUMYjCsn80urVY6yoL2gptQBLsGmvoWBTpGrYoBJrYxMSJtH7QDSgrPjon3Mra3g/HK4gPAnN1Sjt+VYX9/sMP4soq2mVQcRxJSIrkmTcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhjJWuvonJWPXqMBpL1P7EPAg07h3Y01XWCBIRYYnjc=;
 b=jj96/nBFShExFxnmoDxVhS/ZXX3wR/7rKPsl4LLjg61GVsSZorDr5snB0KHBjNyoAlAMMtDLDOrkMoajqOCWRwY4myWLJhHNEOZOhTdyzBQH6cIt/bP+1SORUBbe5EB1hsRCabO1XxgeQoBnDNpFfYenNHDVv75kkXOY4d8ZD1Br1D3YkdGdZYMjAeDUz9iCRR1JKKzmJQezF/+5SACgepFj5aaaxJEKgVb7Gq7pZmI+UqA3AvO2594x8APXUZfHgKPJBMMb517vZWGb4EH69kd0rjJ1KaSj0iy2I7RLrfgx4cO4lWKA6J0fzseCkKCnQjaWb9a3xGAfzlyuT3NgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhjJWuvonJWPXqMBpL1P7EPAg07h3Y01XWCBIRYYnjc=;
 b=mH0j1816eO0pfSqFd5Fn8qn+IUJ2T0j3ABMvy/lDAyR43XlNBR/AqYwkBtP1+4C4Esvn22/lP/p0HwqNuXsURmt3AQzpdxIFE8wDgeURn2g1+ffjFpOFa/eFjkEtvek5znWViQq2zx0bBFy7KiIun7tSRZMu0JkONfphIQyJPUo=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synaptics.com;
Received: from BN8PR03MB4724.namprd03.prod.outlook.com (2603:10b6:408:96::21)
 by BN8PR03MB4723.namprd03.prod.outlook.com (2603:10b6:408:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27; Wed, 10 Feb
 2021 06:44:28 +0000
Received: from BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::34cf:5dc3:971:82a7]) by BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::34cf:5dc3:971:82a7%5]) with mapi id 15.20.3846.026; Wed, 10 Feb 2021
 06:44:28 +0000
Date:   Wed, 10 Feb 2021 14:44:09 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] tee: optee: add invoke_fn tracepoints
Message-ID: <20210210144409.36ecdaed@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR07CA0037.namprd07.prod.outlook.com
 (2603:10b6:a03:60::14) To BN8PR03MB4724.namprd03.prod.outlook.com
 (2603:10b6:408:96::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR07CA0037.namprd07.prod.outlook.com (2603:10b6:a03:60::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Wed, 10 Feb 2021 06:44:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd9e7cca-84cc-4ba9-6db2-08d8cd8f4ff9
X-MS-TrafficTypeDiagnostic: BN8PR03MB4723:
X-Microsoft-Antispam-PRVS: <BN8PR03MB4723267B26FD5C93B4254455ED8D9@BN8PR03MB4723.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IA4Bi1U4Lux4Z5ZQ6gVlVDQzNREOLA/8p/8C9tJ2MehSbGwhBpt/gglp0ZY9ImEvlNTWWakC6phTHCrfYnXvpefS473uM6chCgu22P1EUg4Ox5oxdYQ3oMGF0olIeey6J3YoNBivJaOS0BB0UBwDX/KOZ2BscwXCLAKelMUp1ruQ+PqfVQ5NTGgV+CzNculxcSzvHuk7ckrMnyHXGWQmNfw0A1/Qw2++Y2sah05bzI5u3yR1YAA2JDGH7h+4UXJenUXsEozcLl/JgrL9u/TEFXq1YZnyyWxXRbWuLRSNfhsY+YqYR2kLTVXqo90hWKXxAALeGSkzIoX5R6fGpPOyiWK809nWqbea70S0lmUZk2Y1x4s6QMDm5NEfwEhG539AIw3X+g8QzEg7jQ/5OC5p1xEwgOpRETxpt7Rp6dzK8ZMD0ysHPmnItV5x+pe+89A6wIt3zvXhKQmtTflq7V6Xr14wp/Of/7SxREk/Y7I3VcGbny92fhIeCzn312OBNbAB0WDwQd1/THr5KiPzZqBaWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB4724.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(346002)(376002)(136003)(366004)(7696005)(52116002)(956004)(6666004)(186003)(9686003)(8936002)(16526019)(1076003)(8676002)(110136005)(2906002)(86362001)(478600001)(83380400001)(26005)(66946007)(316002)(66556008)(66476007)(55016002)(5660300002)(4326008)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZiyBgu3F0L1nN2Sy3TDLNkgqcYe2TRxMJWIHCyySB5muay+w+NCf0KNo9BQg?=
 =?us-ascii?Q?ahN9ER43RhBXUtou0P3XE5qlgcc2pOOjIOkGmKJgMdopkXB1mr+WBv357Qd6?=
 =?us-ascii?Q?ugV3hriOYm1AoGLfofFfa7oclvm2eGLqhLfR+Sqdq3DKC7SFBjvXkb7UgTb+?=
 =?us-ascii?Q?tvs8JNAarafYKdeDepua769lsylZk4F9oo80z9nATy4GUqYyLHZI1mm1n3RD?=
 =?us-ascii?Q?cfcfLQcsGBc+BsVDEWTYr3f+pqfwI0rIi72WGgGb9PVoW199lgAKjuC6c8P7?=
 =?us-ascii?Q?VaBgAre6epdALKHvdgqe9g/PKD5ACBORvw7admDqym950owWSpaPyJHLxX/N?=
 =?us-ascii?Q?xBurvjdztg7DV6L0KoWl/88K2QntE4dUwXD+lCjlnkeAkptpdku95MvucoRI?=
 =?us-ascii?Q?2o/0pNJta3KZ+MveId4kyl/d4v/hTPA6T/OHFfDEaN/pycVIEDytLPdQ0cD8?=
 =?us-ascii?Q?i5sJgs/TRDzitFXgFTIyRXwDX98/2nrsgjjcPOrznciJAoRMOQUtMBWEqBvp?=
 =?us-ascii?Q?ACznqt6gq8Q9/VMHhh4HZINOJaJy2u0Zr47+bd/nNn7CkLl46YKrAKG9bGAt?=
 =?us-ascii?Q?MS2hRs8IgU1DEabXOxPMbvmD5IsAO6Hwg+QKZ98LPz44MP02Be7mLdikm76t?=
 =?us-ascii?Q?LaRTU/aJvd5cs1NqCkJBQD32T61b2tQDv0bcWfMmG0p/j5WJa0PnH7nFSqcn?=
 =?us-ascii?Q?fpWGGd+/4rafu666oa7hDF+vpTulQu/7+m2AdDCxgoCHynihSmtgrUgsfos3?=
 =?us-ascii?Q?1qbZBUqoLdSpexGjEF1UGOD97wyiPa/XkENgRduuM1OZ+ktwPEI9ZjgbcvCA?=
 =?us-ascii?Q?a/AFqirZx11wVTDca0oM1+4AZxWEn6WQNzOxfdq1wKXjQqiSH+yWj87jL6fB?=
 =?us-ascii?Q?gQbIFxhtKKzn80TXl6SKWWnU0DhKdlgV3vw9qXO2UL4ODbCSVEWO1vBoZ/w/?=
 =?us-ascii?Q?NlXdx+XZb9/llfyTu3bLE0wzQ0H3yH94q+VBpCMnNSPPwI37EsYjPvtCmyoT?=
 =?us-ascii?Q?ySq3biU+IufBqCTiojTeQYoT14DNcM6OPVTizb/xrmj/0kzCXcJWApSHFnxB?=
 =?us-ascii?Q?coLdi82v29n6lHRXfUZ2zrzssBEmr9/qK1ifwho0SY+hHKN5uV7NxckvLFEp?=
 =?us-ascii?Q?UeI8qEF4s+yGnvOCxYJFZIxRJTTyX13ieVvFVpxaiYDQ9cXUpb2ChQOYd7Om?=
 =?us-ascii?Q?5VwU8cqel2BK84J5s1UbcypNI9G6f6AF9JbyTDnHFVdhKuDpcs8zqW18fzid?=
 =?us-ascii?Q?7vD4Nmd2NTZGOcpD7G5KrNrV9b6NbiZS8JBmGul7YiMiZ07uan5Mx0RAgCkX?=
 =?us-ascii?Q?+WYX6WRaPsHBA7zEzb2SthFf?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9e7cca-84cc-4ba9-6db2-08d8cd8f4ff9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB4724.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 06:44:28.0518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UD8wuVZaoLobaaq/Xh3CpSA6OcFQAplbZGNKS6YbessIWGd6rcl4mXcK97MOjt/OsS4ax77LfjXG2rKVc8lxyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4723
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tracepoints to retrieve information about the invoke_fn. This would
help to measure how many invoke_fn are triggered and how long it takes
to complete one invoke_fn call.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---

Since v1:
 - add BUILD_BUG_ON() macro usage to make sure that the size of what is being
   copied, is not smaller than the amount being copied. Thank Steve.
 - move optee_trace.h to keep include headers sorted

 drivers/tee/optee/call.c        |  4 ++
 drivers/tee/optee/optee_trace.h | 67 +++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 drivers/tee/optee/optee_trace.h

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 780d7c4fd756..0da6fe50f1af 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -14,6 +14,8 @@
 #include <linux/uaccess.h>
 #include "optee_private.h"
 #include "optee_smc.h"
+#define CREATE_TRACE_POINTS
+#include "optee_trace.h"
 
 struct optee_call_waiter {
 	struct list_head list_node;
@@ -138,9 +140,11 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
 	while (true) {
 		struct arm_smccc_res res;
 
+		trace_optee_invoke_fn_begin(&param);
 		optee->invoke_fn(param.a0, param.a1, param.a2, param.a3,
 				 param.a4, param.a5, param.a6, param.a7,
 				 &res);
+		trace_optee_invoke_fn_end(&param, &res);
 
 		if (res.a0 == OPTEE_SMC_RETURN_ETHREAD_LIMIT) {
 			/*
diff --git a/drivers/tee/optee/optee_trace.h b/drivers/tee/optee/optee_trace.h
new file mode 100644
index 000000000000..7c954eefa4bf
--- /dev/null
+++ b/drivers/tee/optee/optee_trace.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * optee trace points
+ *
+ * Copyright (C) 2021 Synaptics Incorporated
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM optee
+
+#if !defined(_TRACE_OPTEE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_OPTEE_H
+
+#include <linux/arm-smccc.h>
+#include <linux/tracepoint.h>
+#include "optee_private.h"
+
+TRACE_EVENT(optee_invoke_fn_begin,
+	TP_PROTO(struct optee_rpc_param *param),
+	TP_ARGS(param),
+
+	TP_STRUCT__entry(
+		__field(void *, param)
+		__array(u32, args, 8)
+	),
+
+	TP_fast_assign(
+		__entry->param = param;
+		BUILD_BUG_ON(sizeof(*param) < sizeof(__entry->args));
+		memcpy(__entry->args, param, sizeof(__entry->args));
+	),
+
+	TP_printk("param=%p (%x, %x, %x, %x, %x, %x, %x, %x)", __entry->param,
+		  __entry->args[0], __entry->args[1], __entry->args[2],
+		  __entry->args[3], __entry->args[4], __entry->args[5],
+		  __entry->args[6], __entry->args[7])
+);
+
+TRACE_EVENT(optee_invoke_fn_end,
+	TP_PROTO(struct optee_rpc_param *param, struct arm_smccc_res *res),
+	TP_ARGS(param, res),
+
+	TP_STRUCT__entry(
+		__field(void *, param)
+		__array(unsigned long, rets, 4)
+	),
+
+	TP_fast_assign(
+		__entry->param = param;
+		BUILD_BUG_ON(sizeof(*res) < sizeof(__entry->rets));
+		memcpy(__entry->rets, res, sizeof(__entry->rets));
+	),
+
+	TP_printk("param=%p ret (%lx, %lx, %lx, %lx)", __entry->param,
+		  __entry->rets[0], __entry->rets[1], __entry->rets[2],
+		  __entry->rets[3])
+);
+#endif /* _TRACE_OPTEE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE optee_trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.30.0

