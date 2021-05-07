Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD680376853
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbhEGPyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:54:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:38830 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236010AbhEGPyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:54:50 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 147Fctwn026537;
        Fri, 7 May 2021 08:53:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=hSDmVvPGGaAzN5e3D4wv2ShoNABsKfdC5hYhUvrDf8M=;
 b=hzvJp0OyWPQ1gI0aQA1QfKTgrdbloSELRUtPwSsmcsWn7Y+3u8ME9szpgs5mt6iK02XC
 kWHY05EgyHWcdFoodFAKvN5qZjSfDP0ePNY70UueOG/5xYLFluIU+k8/JuV8vkTgrq12
 lCbI3Xzk7abIDE0NJHFtH7x7B+sG+QyjtkD0ac7MZqc1pIZjoqpKOmGwThJkd/ZBBkYc
 JfkBt0ow9cpWxtTTtVfZt2meWF4CBYTLqcml7dTw4UoMq5NZ7iE89DJ9ZOJQ5XZRtB+8
 elN5y52WFHtGxKzNw+7F97AwB4J0zr4qgEmgrOnxZJqzjxmlRvMdJzV29OGhHy7oidPI xQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0b-002c1b01.pphosted.com with ESMTP id 38csq4hkj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 May 2021 08:53:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6w/xV+jjQBzvTuZJaZeUN9DPpwpo5bXorZUeHOLHxvT8Xl9BI6/abKHS6dGvKqXvtpkP4QTZ1c3qyeVetxl+fOCUDyPrTETSd4c2tk+gEfhyKRlYSVo42cdty3v/ozWHBOPMVdt/IjBK0JMQuWUC1kmQPy8QO7yp5qjjzIdGj+w/IrfoNky69QceBKnZtVl9qR1bNVew5w4TrZdEb6v0LLtbr9NY8MngD2oHABNor+jKrnMT84SAwGBxeP3q2+Sp5ltMD17yr9odBoBooJUy7aspjf3vNyMs1U718dYehzqTy5pLex44ltItl36J5oEXB81ICj1ZSRvWCPwxjsFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSDmVvPGGaAzN5e3D4wv2ShoNABsKfdC5hYhUvrDf8M=;
 b=OCxw3tumPhN+uyEnZIoczX1P1MldleL11zEPbKGKxISf+Yu+Qn6zvMd/z3w+JzSoTcozPExpxvpAPx26BoX/44ckWIM+fTMyr7GyP7kE3EJAR5UQByX62cVt5cSPOIL7zGluVLX5A4MnuVsMRYmEqSCcTC75N2tYfOkVVL4XOzCt3l6TmnurKqPSiAkh+Cwk+/Eno9ELxRNBCqywRJ/nX52InDoKcQeQimMLTSO5zDCie9RGLe9WrMkRfdssQhOYEc1ScbfFhhznKIdeqzvy7+Iuq9kiI+Tpp2A9NBDELwgUjQTWcGQ2qUwT68u6HXqmwk8onxNGuF/9hH1zSqvGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Authentication-Results: nutanix.com; dkim=none (message not signed)
 header.d=none;nutanix.com; dmarc=none action=none header.from=nutanix.com;
Received: from BL0PR02MB4579.namprd02.prod.outlook.com (2603:10b6:208:4b::10)
 by BL0PR02MB3811.namprd02.prod.outlook.com (2603:10b6:207:42::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Fri, 7 May
 2021 15:53:30 +0000
Received: from BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::75cf:5b99:f963:cc07]) by BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::75cf:5b99:f963:cc07%5]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 15:53:30 +0000
From:   Jon Kohler <jon@nutanix.com>
Cc:     Jon Kohler <jon@nutanix.com>, Dave Hansen <dave.hansen@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Anand K Mistry <amistry@google.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/bugs: wrap X86_FEATURE_RSB_CTXSW with ifdef CONFIG_RETPOLINE
Date:   Fri,  7 May 2021 11:53:05 -0400
Message-Id: <20210507155308.97649-1-jon@nutanix.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2601:19b:c501:64d0:a9a2:6149:85cc:8a4]
X-ClientProxiedBy: BYAPR02CA0049.namprd02.prod.outlook.com
 (2603:10b6:a03:54::26) To BL0PR02MB4579.namprd02.prod.outlook.com
 (2603:10b6:208:4b::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from C02F13YVQ05N.corp.nutanix.com (2601:19b:c501:64d0:a9a2:6149:85cc:8a4) by BYAPR02CA0049.namprd02.prod.outlook.com (2603:10b6:a03:54::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 15:53:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73c8e35f-6ad8-406b-de02-08d911704286
X-MS-TrafficTypeDiagnostic: BL0PR02MB3811:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR02MB3811ECF81BC81059D301A7F4AF579@BL0PR02MB3811.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pVWf6VqJiS+FHbqKjIlb1/fh1+P1M5nbnV4NlLCu9DARmG/clr0cJlnFYvmsQ7L9XQflua2yRhJK2fKsFSj6qJQ6g9kPn9tjeWRwOf79vLXpcQm0V7dqTTk5i9YqTgs6ybibUMO7Mlsm6xgiJyUb+/Y7Ftr/8oHED0jnaW69gG+X/wafTBtpYoGiU7SHEm3nsQbBszz5C7/fmz3aU/Y/RBaDRs0wQdWnNWrKWt2pHVUYQTA3BA+EE0QduF7snG7xI9HEAnPGxA9Jmznh29jyTiFnSdM2DSmqdLbKOw7vJJxTHCujD7DF8UmQJBsYp8dSX9kNdiM9khyjIRqZPj4icuoVBaHokbCYarvMmYQGrQUD34vbco1d6aeERqlo0uLSIDmqLv3//pDRQvyt47vqenmMQ7RZfdlpIS8fKwsZ4RmfCep0pyxEmfdfbZT5wPMFOtf6bQruYiqzxwZwNoI/wpattQNXXAaiZtOvvzhArrAU0ITj0kQ4jQxMnoD96FwKVAZx1nnDvZy2guDaeFkmDyjc6S7YMOjIhzn1imXJvoFpuHlp+EA5bA1I1VFUpkUQczMnT28DyJuqbYA3nx/t6+MZ83nvSKlbxXfHcsLPxE/3Q3mubK2jTs80rOGQ6ZXUb3yv8YsmuOG/iYHFKvLCjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4579.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39850400004)(376002)(346002)(52116002)(7696005)(66556008)(54906003)(66476007)(8936002)(66946007)(6486002)(38100700002)(6666004)(2906002)(7416002)(109986005)(36756003)(83380400001)(4326008)(316002)(2616005)(16526019)(5660300002)(186003)(86362001)(1076003)(8676002)(478600001)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cYBzqQ708y9SbBtToo48If8q7OEJQPVs9v5izEMA+n+0GrdM4B8Kbpr4eeKI?=
 =?us-ascii?Q?am+NTe+3vHQvLZAMlQhFQCNXl3Aj3FP0uaB283iKw57e8SK5O06nhXxftV9c?=
 =?us-ascii?Q?ubca6oCS44CurWRivvhCBb3GfW/Tz92xNyIy5Uo6JS0mj9mizQaztpl0U2tW?=
 =?us-ascii?Q?+MBDPdIGSHtyNw6xPODnErbmyunkMsSJruirDFnOFjtToOby4Bs55Mx9cVkf?=
 =?us-ascii?Q?bYhoqFF3u4tqFoG9KLQ7B5DZsKWbSVwO31+93ycK6TbUXA3rcvg4lXQlcezO?=
 =?us-ascii?Q?0IFqkc5HJAXFuzsJEl7ZcoWfRT3zlwsLneRg66hOZskOYx4nyVJYMdMIxbJk?=
 =?us-ascii?Q?OXkHDVW+2Sw3KP/qnmaKXXEWC6i3DUKVJ/ki/8MiJMk5KZYpUwt5H9R0Dyhz?=
 =?us-ascii?Q?IF8NxHVVqKKEie3fHr1aIOeCYJg+cBBtafplQZbv+rY9iopcRWWqDJugvpWZ?=
 =?us-ascii?Q?Lzd4HUBwFUr0UiPXbT65Usk+ktGSJAeOJXnZrRLgWLeJTnnLUx8/2g2eMQU3?=
 =?us-ascii?Q?MkqsBA5QmI1T25moiUnlIxx7SXLmILiAtQe0PK22Vp/j67OyeX8FkvNnAaAr?=
 =?us-ascii?Q?7kIsBPovMqYNUxEbNhwmjpP2d44gn+6EspRp0V5W1zq5+id2+6UW1d7cV9CT?=
 =?us-ascii?Q?4P7PHtPsBN6b3+Ywz/Xmwp+Eww4vcaiXXjoQ8zylCOeUxdd5RVXTRx/QZJ1Z?=
 =?us-ascii?Q?2GGJufT5gHmInmjOCCiUBzP0tXE/2Sjs/t3aqlPHsmTUmw0lYcfi9lpBXDTc?=
 =?us-ascii?Q?NZZIjkPkl8GXqxChzsshRqPu6T0APi2QeLx2OSi1hpDtGH6nxGYkDHlzUsWH?=
 =?us-ascii?Q?p90A+VcA1Sko6/rW1BVSo8qeYvZp2iyRJPL+f5x9lPBUyC+FpfYuGlc20Xzf?=
 =?us-ascii?Q?yMUsEfObcGNbb356249r7VjAWHXcnXD0pfZdz2CZMvHNtBLIdcPIRueTJIKF?=
 =?us-ascii?Q?mpfP0o6cDo21KheOyKf/R8NBK6qWf0eMTD53Mlo06mARpLes3/UJueAE8eoX?=
 =?us-ascii?Q?ha4eiS2UwWJz8A5pBa50egRZSMVNV+LDB5qeL8DrUz8MTLhRmCddjpCRPmOh?=
 =?us-ascii?Q?c7vglvulrGNybmmqJU19HFuNuNEEY6A0TXomXBjRAsPFs5HTfwLU9Yrs6Ofu?=
 =?us-ascii?Q?S5nkqJ8cRxiWyPu5UraYuCJ0aO9t1ah9WmvHH6P6UntFnDzQnh5+XtV4liQj?=
 =?us-ascii?Q?dRGUCF0xEVHlS2hLR2cytllkoUsEUawy8j5Bs5R7BoWPv+vV4NyzBEnH7zH0?=
 =?us-ascii?Q?x8G1f10tQ+cGXiuBNiYOys/Xeao5So+cO1eZ8t/jx1PDBW6qzbcJAm1BiiYX?=
 =?us-ascii?Q?OuzKfwjc9f82BMuNs2SkupYt4atN3CPuR7aKhixcmGehAmWmmjfwck6uydlo?=
 =?us-ascii?Q?3dc4wngfOTRtsRc2djPgy56y7R94?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c8e35f-6ad8-406b-de02-08d911704286
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4579.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 15:53:30.1918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMt8VoHJun9UVY851q7Guz529TyKt2hoP/RGBcncouji9eIx7+sQKnS1F4c2464eOaQYdzpcsmAmMGM2Q5KpxazBCKqV/4Eb2MNg1DgCmrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3811
X-Proofpoint-ORIG-GUID: d74E2e5TtzxvMs8x5yecrBxEU2Hb5UeG
X-Proofpoint-GUID: d74E2e5TtzxvMs8x5yecrBxEU2Hb5UeG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-07_06:2021-05-06,2021-05-07 signatures=0
X-Proofpoint-Spam-Reason: safe
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only place X86_FEATURE_RSB_CTXSW is currently in use is in
arch/x86/entry/entry_{32|64}.S, where its use is wrapped with
ifdef CONFIG_RETPOLINE. If someone uses a system with
X86_FEATURE_IBRS_ENHANCED and compiles without CONFIG_RETPOLINE
but still has spectre v2 set to auto, the kernel log will
print that eIBRS is enabled and that RSB stuffing is enabled;
however, that stuffing would never occur.

To make this behavior more clear, wrap the enablement of
X86_FEATURE_RSB_CTXSW and the resulting log message with ifdef
CONFIG_RETPOLINE, such that it is compiled out along with the
actions it controls.

This way seems more correct at first glance as this was the way
the code was originally written in fdf82a7856b; however, when
enhanced IBRS was added, there was a goto added under
SPECTRE_V2_CMD_AUTO which bypasses going through retpoline_auto,
where X86_FEATURE_RETPOLINE is set.

The other option would be to remove the CONFIG_RETPOLINE from
the code in entry_{32|64}.S, such that it would always be
compiled no matter what, such that these two areas match.

Fixes: 706d51681d6 ("x86/speculation: Support Enhanced IBRS on future CPUs")
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 arch/x86/kernel/cpu/bugs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d41b70fe4918..b72056ee21dd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -923,6 +923,7 @@ static void __init spectre_v2_select_mitigation(void)
 	spectre_v2_enabled = mode;
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
+#ifdef CONFIG_RETPOLINE
 	/*
 	 * If spectre v2 protection has been enabled, unconditionally fill
 	 * RSB during a context switch; this protects against two independent
@@ -933,6 +934,9 @@ static void __init spectre_v2_select_mitigation(void)
 	 */
 	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
 	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
+#else
+	pr_info("Spectre v2 / SpectreRSB mitigation: kernel not compiled with retpoline, do not fill RSB on context switch\n");
+#endif
 
 	/*
 	 * Retpoline means the kernel is safe because it has no indirect
-- 
2.30.1 (Apple Git-130)

