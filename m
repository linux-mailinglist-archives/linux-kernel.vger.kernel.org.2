Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1543314DDD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhBILHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:07:44 -0500
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:49056
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232101AbhBILD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 06:03:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wyr9b1Ac76ghxGpyJ473suCZAkERV7XNUe1hqW4WLv1OSSNdEyLo5ZRzq4WZwpO07nkIziyQmAnBJpMTUCfPF3Xi0y6IA5/Vp813dWDdMWnqscTaaMQlcd+0bG700GZq96p9bs+NFHofgpXHwzk1NZ/9sogrRIpazusStY9uyOzYL5DIHPGIm42LLXq/nz7EKvXPoBfv1XNwMchOab3i4dZxKVsESHLDe5SklX8IRHNiF0a+XrJyOzN7eY20XY4G1UuVtXajVOdOD57Q2HMRa73kM0G/x+vJP0b4PnUe1iz67IRlhBtIoXS5FELpo/OeaXloHCqL+Uf2FuwF6aK0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JugYxd9uLXoKx8Cr8VgaMlebyYcdqyF7cJZKUYDf0Sw=;
 b=avQX6v4/Hx0sdcZ/IYdMbSDaB3AIpMRf3hGNwN5nkwyV6num87rwOY2c0fShPFhxGB8EznJe4v1nPgBrB18baBaK6OtPfAfq1XONHAQKqVRJnBfrHcA6ICeWE7ns6LkI03MWGstMJOowr/tlzrFSNCkl/7NLAOqqZolXOgsVhryZEPpNymqj3mPtxkFGperky0ISeusUM0AjJV+rAbtBCLBpCVeastOcvuLG3a3xcbOmIYv91rXHi2rKK3pC/lk/VC1AsRuvtDxRgr/p2MpDAc5Sqtm2ws7u561V8R6r4QniXf1dkoxHHNiwj73PWrb2jQEeyJ6PdZ8QHyCrF/rEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JugYxd9uLXoKx8Cr8VgaMlebyYcdqyF7cJZKUYDf0Sw=;
 b=e4oOeYnkxqps/+1SUOsdmCLkUanZV1JUYdsX205BvSRuIzt682y8x+zaSxYra+uI55vZ/NoWfbBJmHRZkrg3HBzfz3WAOx82aEfgtib/EG2U6nngBEdpjO/KB8HzSWozcu7OSOiTqZzsldiY+XWpXSvkhZP6DHJ0auPzzr4UlCE=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synaptics.com;
Received: from BN8PR03MB4724.namprd03.prod.outlook.com (2603:10b6:408:96::21)
 by BN8PR03MB4930.namprd03.prod.outlook.com (2603:10b6:408:de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Tue, 9 Feb
 2021 11:03:09 +0000
Received: from BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::34cf:5dc3:971:82a7]) by BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::34cf:5dc3:971:82a7%5]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 11:03:09 +0000
Date:   Tue, 9 Feb 2021 19:02:15 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        op-tee@lists.trustedfirmware.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] tee: optee: add invoke_fn tracepoints
Message-ID: <20210209190215.337b3d0f@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::18) To BN8PR03MB4724.namprd03.prod.outlook.com
 (2603:10b6:408:96::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR02CA0005.namprd02.prod.outlook.com (2603:10b6:a02:ee::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 11:03:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac468443-4ebb-4eb7-0408-08d8ccea48df
X-MS-TrafficTypeDiagnostic: BN8PR03MB4930:
X-Microsoft-Antispam-PRVS: <BN8PR03MB4930F94E8CF3BBAE4E647531ED8E9@BN8PR03MB4930.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zR2yvUmxMkfyZf9l5pBo3HkDseM6hNjeuMTC4HJIbufhneDDM+PIuh8/RJ81KH2kPjBgo/QtlHOCkM0/AwWol8nzptMv3EYNiOuDgBWRDuZtLygIr5TJUJ5kIpEE/uojDEXX3U4cbqIE9M5Eg8uNEjcAml7xLPHGSdLncSNBbr8jeHm5uyKGZ/QzeHYPZjsjRIVml3H3L2pJkTyztBTUY1c9vdVAhtA0j8R7xL3iCz7a3MO9D+LIf2MukseSXSOZc8cXU0NO6M5YK3QH9LSEQDzcynhWWb7LgJ8e3jKEAPc5eR0VPbe8f9NI9ZrzfOacL1kInnXC6Yz4mypYovOWCc8y8OhPTZeb6n7AsXraEMvurmCrmrJFk3A0LaRA6jrZS10jePhgD3piHrXxP+VNH6kHIKJexWHp/JhvMWLPwBHQfu6ulLD+XDiBY1yQ4VY+ux57HMXM4F1+ziGxG46hdP8+JhSkosdaD+Ry9lBTt+6OK1F2woFuFu7uro2mldq2XmSFS/X1lrm17xl1QYdgbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB4724.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(376002)(136003)(346002)(55016002)(8676002)(9686003)(956004)(316002)(16526019)(478600001)(6506007)(186003)(6666004)(1076003)(83380400001)(4326008)(7696005)(52116002)(26005)(2906002)(5660300002)(66556008)(66476007)(66946007)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?83KAjHKousmyHWdeiabDXoJOAqiSSgb67XajrlrwW+VejwseS2UlcVHiReU6?=
 =?us-ascii?Q?RtuiJ4YabJlwK9d8qHEf3plCTeT5S+BJ1C8NDaQ/DRtFX1jaSQL0PF51D8m7?=
 =?us-ascii?Q?5yxR0UB64au8o+yHylxNFRpL6xCoPy4i8W9O8nHPt8tBht0+4n+yKY0+HwQl?=
 =?us-ascii?Q?5nXmYHCzlJd+NQ2+QvKQDVCzbwffocP1LxFxyFZe4acHSQagAv0Iex+1vGaG?=
 =?us-ascii?Q?WkfWKn/GM2aZMt9YDXIPlNZc885tf59A64uhoOB4pPboxWVxZzpRGZgW3Co1?=
 =?us-ascii?Q?duXNvK8/I5vr6SoMrVF6KYxwR4MAfB7k6wzRVg1jjW9nIS/3yxviiKpo39vz?=
 =?us-ascii?Q?VXS8tzP+NBvHZjDIM2Ik+jZW8kzon2lxFseNOZ43KXloYSE7nyymbJllSJIM?=
 =?us-ascii?Q?gnw/0K9AbRYNY6MV9KFTFhvufZ/bi15xFH6tEVfDGafNYZlNWQ7pJeshpwgu?=
 =?us-ascii?Q?+rXfvhkzaF82kClAOyE7DWG67Wdu2CSNW0vhnE+Ea2Gfh9bCsOCqstitOYhF?=
 =?us-ascii?Q?XwmvKH0cMjnyvsXWL9DpWKVJPcv6iW0UDqBderak4ka9S4hHym7XlzzReDOh?=
 =?us-ascii?Q?O0AshwBoOancyGmYLGPpG+giyBKwbyTry/MQ6EQEV++2gf6EWUQbTzSEIKnz?=
 =?us-ascii?Q?1vDFDflWV1WaDduHT1OwMR2OMHjKqLZhPuzY9he2Wj7jrD3KVXATq+lUAiHy?=
 =?us-ascii?Q?rLZWpzZY/lMJ9QiF54dJda26Xy5YkL07Cv99TsWm3C6DYk5wmt0sax7Xesxz?=
 =?us-ascii?Q?u/21itn6uwzvl4ew9Ewfm0opdzJGHZX65ImR0fvtrO+mRlS81K0y8cLE5C8H?=
 =?us-ascii?Q?QhbH2yQik8XZ7N57rbmg8/1htH7D3+zkmKowxopxUba3u3CXeX1k0CF/HIiE?=
 =?us-ascii?Q?5Fqo9orrUr09e96wtylpfHDSzZ/CEhRuLHQ9DkKtELqmDutvPwyytqy5PxFA?=
 =?us-ascii?Q?uMcUwaDT75pzExPWS3joKtfDt1Jvr2gFJRlODQvVdvpy5+/8D/F1fOeGXti1?=
 =?us-ascii?Q?YUYxWvzKzjGGINnHjKFc4Cstm4YqPE3is67P5QVTgUKG9IHpSN6voRQdHV4E?=
 =?us-ascii?Q?rhynFbYRXaSkuR8d8EXwkSp4/xnUZlUAc2QylZWt6lBNuHnq4LMYqtMRHXPS?=
 =?us-ascii?Q?hsaCQ0u5hXadiizsb2k0hWTMGEJoTbqWDkJxB8P981LSdF49/WzSxC3pfkpN?=
 =?us-ascii?Q?7WxHHlwB/4/kpsDdxYCCfvNV47PWRqUBfZaY5t7z5TKUaEkd3fEmK0fJKNNa?=
 =?us-ascii?Q?y5E03/QLINok2XnZzGDNLMbSMdgSZuldirDy0xqEDBKgldDslqX8Y7/pIqyT?=
 =?us-ascii?Q?p5BTRFsytJmlIjwZEmmlqYCa?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac468443-4ebb-4eb7-0408-08d8ccea48df
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB4724.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 11:03:09.1752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JqSiArEiz5NTSioyszhUvqNMH2qntJhykbwcjYObje+/Sf94/qBnFUdry1wbdH78JFWeYVTeglSMUqJ2jMKcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4930
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tracepoints to retrieve information about the invoke_fn. This would
help to measure how many invoke_fn are triggered and how long it takes
to complete one invoke_fn call.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/tee/optee/call.c        |  4 ++
 drivers/tee/optee/optee_trace.h | 65 +++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 drivers/tee/optee/optee_trace.h

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 780d7c4fd756..9dbab10e7ac3 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -12,6 +12,8 @@
 #include <linux/tee_drv.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#define CREATE_TRACE_POINTS
+#include "optee_trace.h"
 #include "optee_private.h"
 #include "optee_smc.h"
 
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
index 000000000000..f209df7004c2
--- /dev/null
+++ b/drivers/tee/optee/optee_trace.h
@@ -0,0 +1,65 @@
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

