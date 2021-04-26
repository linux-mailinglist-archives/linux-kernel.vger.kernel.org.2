Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177B436B058
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhDZJRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:17:40 -0400
Received: from mail-bn8nam12on2088.outbound.protection.outlook.com ([40.107.237.88]:37728
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232068AbhDZJRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:17:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUOaP9vA9gN8V9iAmThe8Ve7lenoji0f3TkIY69qbcV1rlesK8BAelbXDsAT/mawC3Z0jU8YFG9aKjNcvG69PNxXwYSzz0X+B4RY9zJBQKn2T1zfctwlStucq+EuBLS3n7LKPu7xxvPSuZp70G/qZJ6aNymMnvRO/1cXFF8kZhGT7NEcjEinOkzENMbRksZdiZ3jEstyQhLc+3OGG4+NM1JsK1vlJ/GHBL2RyctRowe1TqFlvC949Q5qFbXeeXKeWkyBXEXeBzJnz4XFFIVFJuBO4425xF01W6Apj6J97J3RiNC+1uR9sJs4iFTJltXT+VF+/IeQX6VrhaZkARykQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZBxxZTBEa9S6Rku6VwrS+BLXTlYuLgdVHsHBi7l9Yo=;
 b=grhCXN0EGDCWlB1FXI11Gm4mYFHxUunMa49WwnqWMIjzFzj10wW7V6TANOE4e37bYtgOomG0vCH1NKmrtbfRot75Rl2j9xATfa4ZRFqwGxrH6vCRvlIi6LpU0Gj165DchMQiz0J/i60Oa7JUe/fL2mTPa63qzyIjlFFr3i3NNgomHuXT3L7AdLEh39V0a6LdtTlnoF73ofv2KiCKtSpNykKPuN7Lw5LJ0OKt/khk48wWSzjQ0X8gt622wEAw1BU4jNy9/ZkXF6NJdC7pungcRGFyluZB9dWBYPqo4pxQkLeZsKagnY+OFLFQGDMPuwPb0KNGyG7k951evkePVJdVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZBxxZTBEa9S6Rku6VwrS+BLXTlYuLgdVHsHBi7l9Yo=;
 b=KWEf88MWgMSlX5exc4nz+jktAgzCJTg4hWDRGpIvgo64rfcKKE6MMP8v4YI6LyXu7gqDk1LefevQtMPlXrmb4a7o0UoGMY9V8dzoGGRhkkDN/N6ehBPDWE1wpzlhDumbtXTARwIT47gDG5YlPI6Mrd1VVn3rBq0hA3hOoprcSHw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by CO1PR11MB4867.namprd11.prod.outlook.com
 (2603:10b6:303:9a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 09:16:55 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 09:16:54 +0000
From:   He Zhe <zhe.he@windriver.com>
To:     oleg@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        paul@paul-moore.com, eparis@redhat.com, linux-audit@redhat.com,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhe.he@windriver.com
Subject: [PATCH] alpha: Add syscall_get_return_value()
Date:   Mon, 26 Apr 2021 17:16:29 +0800
Message-Id: <20210426091629.45020-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423103533.30121-3-zhe.he@windriver.com>
References: <20210423103533.30121-3-zhe.he@windriver.com>
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpg-core2.corp.ad.wrs.com (60.247.85.82) by HK0PR01CA0052.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Mon, 26 Apr 2021 09:16:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3687dbce-00b4-41b4-15b5-08d908940885
X-MS-TrafficTypeDiagnostic: CO1PR11MB4867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR11MB4867B9799AD960A5F579190A8F429@CO1PR11MB4867.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6SVHQs97znjIi7y6VfnfOXEFnAYt0xqjuIMGAx+YX+vaQPfZIJxhzl+6wZFQAJVIfEgDCEvJ4xoyXjJG9KrYY1GPzee7Fr9uU1J7JjYsVuItAfig0rfUF8Nta1nhBKU5HO32azNdybw2C6lPl0HHMAGJAMs6d6ftDx1a3TaMP2wk+jXrfORvDdpTLuq4RnrV1GUc+7fyRRmtL4nDEGJbs9tFfQhko4hvvcl7b4QDAn/4rAWhA7zq3U3fC1W/vzRBykVc6YrZw7av1YvnuPPBOV70WLJEyv7NgttYJQMsWU8Sk78bWEVPK7BCrYQ/g0lRcxy5NPD4tLzUvR4u72i2d8DlVbFpIx7m4hG6qQrzp91UV5HUX9XgY5JZtb8q/vjKaNqgXopqdvOyyPeP15let5RX2CBHfnR2kEN0pknB7Bqdp6XsJ4fcUYmw0Q7LPwN8r4j+BW+SHYpodkstPKnpXXkw8euheufjP+GQjzizv8QVq5Ds5qetC6jpd7j3jXEtoPTCNNJcKqwWbvnd9Jt3/MY8IutXwnQrbhsnjm75LdW9iXWKE55AqWEu9YhNgxpSBWaCPpJPlJNXonx+n2nFNU90Jtk3J1GVK1uAzO1wDg7NPStitshtFWhLBdCJPUSETP8vEMBNv8HmH6g8/YN+8JqJxtHeqC8rUVt8RmYwac=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39840400004)(376002)(366004)(136003)(66476007)(66556008)(16526019)(8676002)(5660300002)(86362001)(6486002)(38350700002)(6666004)(2906002)(478600001)(7416002)(4744005)(1076003)(66946007)(38100700002)(2616005)(186003)(36756003)(6506007)(956004)(8936002)(921005)(52116002)(316002)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VYUt1iZzSsnthqoS2SctA9XGycmZAntbe9Pefok2gn47lwoXrFM70yRhjUTs?=
 =?us-ascii?Q?HdM4TCt/BWjK/RRbFyBEw7xCrW5Ncy8giK+YKSvkEUfTTrBnGueLcI8MXTfX?=
 =?us-ascii?Q?0vh2v/CTv7R4ML9ECNPf9nzS1ulRdjkyhX/SIkc8EwvnvZzEjaNV3pFWcIn5?=
 =?us-ascii?Q?yZ4fytsqiOS+Y8TIV9uBHhKlf2jHg41Ig6YBPk2WH5LWCDqLpuF2qO67ybrx?=
 =?us-ascii?Q?zxYOSGgPOvwKnTNVDR3veu4k9qIiQD45xKubRm7t7NAC7kKr3hQcPcfGwRIp?=
 =?us-ascii?Q?ZtBU7xnKjphEy7JUkpE7BOjGZw0yetxqivWFaFw+3bZyr94bfNDPuZuuYDUT?=
 =?us-ascii?Q?6U7LCn0Qf5qbrKOBkJp5ISetjI57tpT/ADpoH/Z+JdfDG2zh54vuv/6s8/dA?=
 =?us-ascii?Q?y1zu3gEgW77R6MMLqc7jfkBwyoE+LFiMKKSOie4Grz9M/0//33ym179085gr?=
 =?us-ascii?Q?kL+khPRW5+7KTbYo40eWQzQGs0y+2fuh6lAuHA7jRF2OMlg/kPPF/34UZcWT?=
 =?us-ascii?Q?jvT129NvxrEMB3jGdoXHL1e+ciYRs2Ltk1KIahGKRs36BJusxO4f+wSzNpaN?=
 =?us-ascii?Q?x88arokh2OAkBEVBsnnjrcZ3v27LJnSmN1I5kJKMdZVUCOl62MBg1Lvt2VlF?=
 =?us-ascii?Q?mKxsiShif9ll/FHXSy4/PopMEHC6IP9wTrllS9aE6N2syL25wNn2FMX4ahNU?=
 =?us-ascii?Q?zbPdwo9JVwyvZdEM3bwRzlHAD7pFPTKgco9NdwaeOkM6wPeJIXK3r0SkFtBh?=
 =?us-ascii?Q?LwwuIpE152p8o1BG1wMhApeaI16yIePlLusErS8VYL62rLgV1F3+fYtDJjY1?=
 =?us-ascii?Q?V15uDpC0uoD8nPGBzege5PWCqc5eK+UdyrV2WjqLAoxJBMQy0zM4eq2nchR3?=
 =?us-ascii?Q?2kMgEm3LTYcVj5+W3+x0JzvWZteKaO+hb22hKc6mbC+zPAaRzK3SZ/r3QWTg?=
 =?us-ascii?Q?lhu446EmlRjXkvjc8uWKdkQnKFUhPGA5mTHtYlcGSc2stsF9/LTL7QudpNwr?=
 =?us-ascii?Q?73N75/rxs04gNP+GKsqXcb2fKj5HiYOYmYwvrP1Cq7OmZKLNSrGRITIXs8o5?=
 =?us-ascii?Q?pzQUR/phm0UPE4LuSHIa704AE3ZrFo+JGt2pFzgmNmmAarYuCGu8aZey4yAI?=
 =?us-ascii?Q?q+C8Ei4HWEIE+SJyP7rjGbK5ue3uzUmpKK0V1OCbtmNEyiwlZ6Txh/Wh6Yt0?=
 =?us-ascii?Q?rg6EHC8XcHbWS7gZmxX30qcDzbFfjw3BE2Yz9oU3MBVwCnwzvB7odG6byfAj?=
 =?us-ascii?Q?uTRhzDuE4uxgXBdFIDQ85bO87JQevdtVbA1FGqZqsGt40ZPlkhQi3PxxyBAL?=
 =?us-ascii?Q?NrGJr5AziJFU3xgByQ+Mq8y+?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3687dbce-00b4-41b4-15b5-08d908940885
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 09:16:54.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdMtRmN5epN6Gphvrbo2GdAQUikwgoa66HoZnEOx/PlY8GVt+yv39a4veXIIiEn8w+Xly9t2Qv3B1WVzGGsNeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4867
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

audit now reuquires syscall_get_return_value instead of regs_return_value
to retrieve syscall return code . Other architectures that support audit
have already define this function.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 arch/alpha/include/asm/syscall.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/alpha/include/asm/syscall.h b/arch/alpha/include/asm/syscall.h
index 11c688c1d7ec..f21babaeed85 100644
--- a/arch/alpha/include/asm/syscall.h
+++ b/arch/alpha/include/asm/syscall.h
@@ -9,4 +9,10 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_ALPHA;
 }
 
+static inline long syscall_get_return_value(struct task_struct *task,
+					    struct pt_regs *regs)
+{
+	return regs->r0;
+}
+
 #endif	/* _ASM_ALPHA_SYSCALL_H */
-- 
2.17.1

