Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C538359507
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhDIFyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:54:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54184 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhDIFyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:54:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1395n8J8035833;
        Fri, 9 Apr 2021 05:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=n17sfqVARcv0KnEBqShtIJbK8TdVXUAyLGczQnQ5y1I=;
 b=zqqtfjKupRaM7q+EBljcfFGJuCe+3zNTmLyvWPl18WULZoOhMyuBWg1BPI8JauiAYo94
 wPb6eK2ff10YzdkisKTlxLAXDAY1LOXI++ZkMCRtsq5iSr7fr/e4BY2PozyOPsIKhH23
 ATGZtWRcBtys+y/KHT6t/DFeT89k7g93QM2F2ve/OrX+gwQUXwhWAvGniFkso/i9hF60
 AiTg21h3ZxF49YMq8XjAvb5Ymq4vOn0hdaK7sfYiaWIYhVtPz9YfXfQhlnz0hEmBJni8
 rTeRAFQrePSf2/A21oAB1ELdqaW4p13Jw0DIqwkv7knMFDLzJZ1upAUoQi6BSjhLezDA bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37rvas836a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 05:53:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1395k4UP069915;
        Fri, 9 Apr 2021 05:53:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by userp3030.oracle.com with ESMTP id 37rvbgkt10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Apr 2021 05:53:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZCnxrewIHgz2H46H1nKn9TyIrSmjlgIpqf/7JXZDoZY8FRQgH3uXpXfzo8Xa3cyWhiWzvF+fYSNs289ytf/yu5ow3K7IEUSM6ziuI9vHJb3bnI5+Jd9Fu/hh9ROHosg2/YEkqal41M46tGMU/Qf2u/hM9yiKesmH3x1V86Ikx8xiJa/Xz2Ne7S3NbVg7acqppDy2h2xZr5ysodXDfhYfXuaiuJftFP573QU8G2lG4tMVLVDxXFD9dND4DMokx79RyREHGiJ/cMTWA+riR2Hbe6CfC7R3B9VpJnB/s76jqQTVLHeHJX48MvmNDJYrBwR5wWxq+x6L7JXIoPWxwCEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n17sfqVARcv0KnEBqShtIJbK8TdVXUAyLGczQnQ5y1I=;
 b=gJLZmauJy9+ELW0/522gqP2TIZaeZVVtS0co6yVPdF6UFjvCgzOcNmcPtoBXsKb0yCdXX9BefNln0xPhm9/YBXSLXnjwzk+3cz6MzZL7RIKbgo8o4wsvm6x3ahRc24U+jTAm3FLf+F3YpXDSQiK5CQmH8LWXYrQGfVO5zlLTEp34wKxYP+5baDFOXJwaksRiM65JxBxYW3Jj8nzbEeOMrnCcDdC5zzR734xkLW8I45Z8qN2Cn0qsxKUW5r8IIKOQ8ffTjBj/k3aMbT6OWrXOBz8DFclrFcJJb6qxBTJLA+oM2P2gFKGRDOqZI0qH6sxQoCeBYWOsSSjDlLPAeiz+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n17sfqVARcv0KnEBqShtIJbK8TdVXUAyLGczQnQ5y1I=;
 b=urYfL/9fVZp3PRdhu1nZtjFCk3Sy6VVTEnCL5bOB6QN52xpm/SWGpUdyNGe6zNmQ3C0MP51guELNx4daawsSNF/NohFewSk0xhsGS6/z9T/NkfCFUx1MQEhOyoF2CBUADjbclGE9jhpkUN0k5Rh/8943aLrLtHK5rIH93r7/SFA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 9 Apr
 2021 05:53:22 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::44f7:1d8f:cc50:48ad]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::44f7:1d8f:cc50:48ad%6]) with mapi id 15.20.4020.016; Fri, 9 Apr 2021
 05:53:22 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, qais.yousef@arm.com,
        mpe@ellerman.id.au, paulmck@kernel.org, npiggin@gmail.com,
        frederic@kernel.org, ethp@qq.com, joe.jin@oracle.com,
        dongli.zhang@oracle.com
Subject: [PATCH v2 1/1] kernel/cpu: to track which CPUHP callback is failed
Date:   Thu,  8 Apr 2021 22:53:16 -0700
Message-Id: <20210409055316.1709-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [138.3.200.16]
X-ClientProxiedBy: BY5PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:180::36) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (138.3.200.16) by BY5PR13CA0023.namprd13.prod.outlook.com (2603:10b6:a03:180::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 05:53:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24548b93-124c-4385-3263-08d8fb1bc885
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB468697A57EA178E299F0547DF0739@SJ0PR10MB4686.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:166;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4W7BpTIInKBMG4//yyOFj98sz3eqSPU78Uylz4GoKSbVqDK/48WzsGiSDU5Fg7uNV2sqwQ1WXHL5ODhgJHkt2qOvfN3edyq3Yw0bGccNBpX0SYaj63XiWqq/954J9XdxC8t6NCscFduVsbO6i5I7qsDNhjYR18qGN967vhxFuy43nkvS5h7a3lwTYd7aVe9YbJBcJP7KHGy5Q0jjQwNO+DSabfjdavYe3Xoqw0dORM/QCXFv1eAI2tGOjls/6YSxhkQ66LivhYqQ352Ha/xkCbVfOz+XP/XP5cdatSBAZ9JnY7oeCTuMGNylBjvN60l4bPDEYt2v7Uh9wTj3dCsONLuknCcn9t62LcWpyRyscL/JTE7DCsEQPlzcq/VHU8TbNugQ9OD3AAUrb9K9dxI1s4S2SvwI/UFu7qrsfztKD3dii3rGYwbreraz272JKTAgZJHh2Y8imuxRgn026JN1tr9TeNGqBpacpSTcobgdyKf57A2GTY8lTNU6/f+UZtzl1bBoV9QYi62Sp5/ZSas5vdR6Cj0gNnrU5vvhmGof4Rdy571CQpacylRFb4pSro69RytLUJ1kzxjnloxnvkRQlNpa0g8XjbRlwjur0dPOkge9DuN8DhKZoxPkSimFQtAQJDV1cbCidmKzevSyIY6QJwZwZYA8XC6Og9mpD7xVpvsRakHv0smQliU65TCwwj9glbUc/Bxu1s6ZXN9ZyDOcPQsAauzv8DZSt/56SDeKti8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(396003)(366004)(1076003)(26005)(16526019)(83380400001)(186003)(6666004)(5660300002)(38350700001)(52116002)(66946007)(2906002)(6486002)(6506007)(66476007)(38100700001)(478600001)(6916009)(316002)(36756003)(107886003)(8676002)(6512007)(69590400012)(86362001)(44832011)(2616005)(956004)(4326008)(8936002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?g7SUih1dIOIF/Y3/POwtCFP7lvxHHHO/TMkkdyki1bhmeAoWYVc+sGwxrjqn?=
 =?us-ascii?Q?ldQJIOCvpxOnWJw4dnSULKZtHk3Kb+XOkiyddUmwtueDEG56yRc3eZy8Y+F6?=
 =?us-ascii?Q?T4W3pkIiM/IVWHteLig79aquydZiCdPISHXwZ1IyYko1vkf/nUBUOOIR0obj?=
 =?us-ascii?Q?5AfMX2I7YDshJN+WPPsJizem8NgxoWTpAAJohlKniMKf0wZ1Bk5URfvLydi9?=
 =?us-ascii?Q?ShkusX+wuIsqu2dyvZ1D9WHMTs13EQ9VW4Ne63FT89ht1pnpbbzKxcnsJFfD?=
 =?us-ascii?Q?k4WpD9dSoV2pZcG3uCfBnRswO1e7YWChPv4/ShV91aAcLrBuJuF8sf6djg98?=
 =?us-ascii?Q?UqMpTTBZAa853Rln1OH2PyfWaEmS8zuCbNgZblFjZ4c8fqYjNShWY6xi7N2/?=
 =?us-ascii?Q?PaVNi+aJgcW02AiGnMxk14yS94ECZIjX5cIWUYuX5r1iNpXak4w11tblOH+o?=
 =?us-ascii?Q?GMMwsbFKdagVtnEPhpCJG+e/L0WIScs6h+iVbCdjgJrwLRBbPLiu8BX8hQ+W?=
 =?us-ascii?Q?g+8CrSJNLKTnKtNk56zeb4y21GfUFRnHzhG2WHjxR3w6B4vOR3NRA7EbZ6El?=
 =?us-ascii?Q?OJqH8QQNxZPZY0D7E2J5lm3NqaUEqhJlV86txkdn3oWRSfGo7NQVw/qACqcp?=
 =?us-ascii?Q?sUSpw5hMyejzmqS99KSGtTxAeU/RiMfetGXrbY//s/4KNZHMC2NihwNF/0fS?=
 =?us-ascii?Q?bk4Ac2hfc/9jQQ991zyQ6vgxNtmdbn6C5+PBzjGjpQOZWNlinZX12K2+F5RN?=
 =?us-ascii?Q?zQWS3nENYM98Ys35jc6uA2ffCWJQD0wrlK7BSF4s8eF9+0Xc8zPYtFplkAPD?=
 =?us-ascii?Q?OcDOD4h8DloAjWU5pyKuqRjFuJ70nIfOaLknoaOm6BkHHrq762LvHlTXKT+i?=
 =?us-ascii?Q?usIvRxP3avhxLLTVY65nhx1/wnE2L9cQC0UnMwP8Ur/qDrK3D6xW7HiZ4HD7?=
 =?us-ascii?Q?tDkWZWjgT2dJXLBtKcFB91N1l3emi8Hoh+VLZMjH4MN8CdBwbRleCuGbIfcW?=
 =?us-ascii?Q?e2+33QF0qmbm46X0Li/I4XD8F1ozpRboD9pEjXw6ddksD3lud33ZgzZUFFFa?=
 =?us-ascii?Q?CdZgnthJdL/caX/81tnxqBHfXLG4UJwql+aQHt0lYBAd3S6WRXAzdk1KmAFh?=
 =?us-ascii?Q?vMY+bcLpDLE46szbYfYj8T6Ipq0SIBBG0lVusnE5OIyYopDFkXl01o28Tie1?=
 =?us-ascii?Q?h9VSmu4QeSig6Fq3jthWmLMIK7ufLushT0zX4qkdolG5IbAC+SuksKeuU2UO?=
 =?us-ascii?Q?bT/NhMFRb06ddVVU6CecVVcOaQTTcHBfL+PXRqMU+MA3Hxyolc5fsjZhUlhO?=
 =?us-ascii?Q?jK3mi4rpli1Whkwu2tgu3K6C?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24548b93-124c-4385-3263-08d8fb1bc885
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 05:53:22.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iC2XRoFxPaRnW43p3trEk8RkXaiofmPpSUBmT9EyH7L7JKFg0PAF1O+9524B3v+jh9gteOVn0Z1RJXh5YhC4iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4686
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090043
X-Proofpoint-GUID: Ou7YY9todHSiGLRy8UJ8oQRGj5eofuBO
X-Proofpoint-ORIG-GUID: Ou7YY9todHSiGLRy8UJ8oQRGj5eofuBO
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During bootup or cpu hotplug, the cpuhp_up_callbacks() or
cpuhp_down_callbacks() call many CPUHP callbacks (e.g., perf, mm,
workqueue, RCU, kvmclock and more) for each cpu to online/offline. It may
roll back to its previous state if any of callbacks is failed. As a result,
the user will not be able to know which callback is failed and usually the
only symptom is cpu online/offline failure.

This patch is to print more debug log to help user narrow down where is the
root cause.

Below is the example that how the patch helps narrow down the root cause
for the issue fixed by commit d7eb79c6290c ("KVM: kvmclock: Fix vCPUs > 64
can't be online/hotpluged").

We will have below dynamic debug log once we add
dyndbg="file kernel/cpu.c +p" to kernel command line and when issue is
reproduced.

"CPUHP up callback failure (-12) for cpu 64 at kvmclock:setup_percpu (66)"

Cc: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
Changed since v1 RFC:
  - use pr_debug() but not pr_err_once() (suggested by Qais Yousef)
  - print log for cpuhp_down_callbacks() as well (suggested by Qais Yousef)

 kernel/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 1b6302ecbabe..bcd4dd7de9c3 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -621,6 +621,10 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 		st->state++;
 		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
 		if (ret) {
+			pr_debug("CPUHP up callback failure (%d) for cpu %u at %s (%d)\n",
+				 ret, cpu, cpuhp_get_step(st->state)->name,
+				 st->state);
+
 			if (can_rollback_cpu(st)) {
 				st->target = prev_state;
 				undo_cpu_up(cpu, st);
@@ -990,6 +994,10 @@ static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 	for (; st->state > target; st->state--) {
 		ret = cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
 		if (ret) {
+			pr_debug("CPUHP down callback failure (%d) for cpu %u at %s (%d)\n",
+				 ret, cpu, cpuhp_get_step(st->state)->name,
+				 st->state);
+
 			st->target = prev_state;
 			if (st->state < prev_state)
 				undo_cpu_down(cpu, st);
-- 
2.17.1

