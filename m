Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34B03FA1D8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 01:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhH0Xfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 19:35:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52064 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232433AbhH0Xf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 19:35:28 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17RLpcS8025386
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=aZ4WDt/h8+qYipuziT+mxYIUreeVWlGmg1dfeDMnE20=;
 b=J0RSKDZPqKzSnkgsPm5CjNvtoQex5uS57x4bQB/ekWGtN9SCc9jj7hVt52A2DusLK62e
 Lj9DRXjDXVlamNW+QGF2qSI7EPFGQkkCIcyefg5Ic60fOsRYgUrvo9Baain1I7odZxMv
 APuTN7+1CoXqKY4152YD260vE3afAAjcRUHMps92ywEtU0ooFbiIehOGuec4lQDTYo/i
 4C6ahki1+wxwyA8Iuvgt3/7iElbh4OdTmpFVcoyDdRB6XnHAEeBEGGhiTGj1DiFQlNPd
 CVUYKGmtf8ckUuGDKs2ZAZ4+e4eW/YkRs5F8p66djFmD4gDcPxYMjKJktuiEKJOjHcO8 Dg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=aZ4WDt/h8+qYipuziT+mxYIUreeVWlGmg1dfeDMnE20=;
 b=yphPeqMWD9JtbJBEX+nNtATlTQ78c+jvxpq5ELg4e7zJp/MQkilI5e1pffkBUEdyHvN/
 xtZooEPPWDs60Wmbhjk9iM56UfPXLFiAq3LZ8GXMMjBG8gWcjSgmECYV9F+6L1fcqWuh
 nSNDozEJd4UOSpeb6I9DGwyYB8xVqFJaht4proNtBKeo0euQQGrJgVO8BYLHjCdFZGTw
 p8i46jy6e+qFuPtuFvA8B0z5Sjfjw0w3SMfO4VeBV6iHiLS/e/V9IqTdU708KX9SWUw6
 ai+ngjARdbLS7RHBQhGLsfglzY9PegXvXTIcUjSza4DQOpBGgfU0vQ4ZfnSszCi0GR4W Ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aq1kvh1fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:34:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RNFWMm109062
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:34:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3030.oracle.com with ESMTP id 3aq2hv4mef-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:34:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki3Ba69YZqm4VEtwPUqD6SuchsM5vbr0dTv8p6lC7Z+uiAMiVCLA7NUu8hzjed+XmbduKCczt8gsjhfXSX70mbcTSmt3/yefC+fOR5DWn7XDxo0/qzxJLvZkEK5rzkbN927tIZQDpzsaRxafYv3v5N9P9h735php71NUXt2qyQjXZQvd2JzYhTM8KrJu8kP5pKdKi5kxEi5PHZg7PE6N4qO6Eg10+KCNJpSRt+pfboogAlpHZ9qO5I4XyUrSxs7h7hxAn+KFrFk94BJbcJp8QWlPjDjUErZGvNCKfdQzF9KKsREakvCgruGfySAl7nNYFGpoHgNO8oHaBdHlqdzNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ4WDt/h8+qYipuziT+mxYIUreeVWlGmg1dfeDMnE20=;
 b=kq13TD4YCgXGj47mBTreZ1AROGXbXLlwhbbxXZidWl1Uqs05YZyYnJJ5pUWDntWgQ17oUXAJttpXxZy7J7WQeDxVC0qsoJH5XhpYmg0jCXjh7HwuLPHRR9LsgxmW10go8fwMRj8zGgD8GxJWqfkf2qXHt0RlT2Kbutbz2F2KbOPZJRz9tc2HSfw9DhgxiLnG2gOQ68u7SZ44MMSxfbvownT1hwN6JB7nA1FcMhEnKp3Z+2VChVB1XHhS4LQuHw/r+XqoJ4pGZdjF5bowmP7aV5i/u5IH1MTXWQ80XAB7slIS3KODC8cSwuexhbmxd2YQDrOwVC9ZPMov9xE777nvAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ4WDt/h8+qYipuziT+mxYIUreeVWlGmg1dfeDMnE20=;
 b=dKQtvY32eL1z0BzfhCIQrir/94z6Mpt/nrrtfBHMQVgkYWHi74rNA3Fk8ZodblplOb86zQDHh4fxb4lNcoUY337YlFPK64gGlVUeOMP2bBBBNLMnLZr9zbbM5wDHlVWpp5Coe9CaNTRWGbUt8VIIAGFYVu5eBRPGVORMdZCCpF0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by SJ0PR10MB5520.namprd10.prod.outlook.com (2603:10b6:a03:3fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 23:34:36 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837%7]) with mapi id 15.20.4415.024; Fri, 27 Aug 2021
 23:34:36 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     prakash.sangappa@oracle.com
Subject: [RFC PATCH 1/3] Introduce per thread user-kernel shared structure
Date:   Fri, 27 Aug 2021 16:42:14 -0700
Message-Id: <1630107736-18269-2-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630107736-18269-1-git-send-email-prakash.sangappa@oracle.com>
References: <1630107736-18269-1-git-send-email-prakash.sangappa@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0034.namprd07.prod.outlook.com
 (2603:10b6:803:2d::15) To BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-ThinkCentre-M82.us.oracle.com (2606:b400:8024:1010::1501) by SN4PR0701CA0034.namprd07.prod.outlook.com (2603:10b6:803:2d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4457.19 via Frontend Transport; Fri, 27 Aug 2021 23:34:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40f7a99c-c41a-409b-a060-08d969b33b17
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5520B4A6BBC61A39FB67DF9DE4C89@SJ0PR10MB5520.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sxF8a/j7EQlJMF+/+rtnW7VGyBhoEWj65+ccncauzp0JNCsUx1gvAfa8Rj077qqvfVGpu3fjiKcsNhCoaK0xVGipV9RdwXG1465gOnd1t/1/q0DuYAZkmlsFFdt9qXRN5PCBJUcPn1Z4uNjGIJDnLBOGfyBQoRlY+yWwqRS9xOS09A7oDTI7oDkDqS6Zf8YuEWWUhXuef1g7hRtnJt8a6f21Re2Q01gT0QYt7DAY+FoIe8TDebiO6A6wlMCPiagCQTxloqUPbEn1Lbz3MxYV6fgCT5v5BPSmC2fL60+6FHMxSpOOcZETpmQk6OGZOKQYESSCxaCNjOv+I4MuH/pgYY9FLDNeDu8XIgEyuX/7jgO3yyd2uLa6p0XP31aQC0ZgEt92BF/MgQH8rfiovhzNyMulLj3zrHnhfrH56YrbjIjKFX6aaQJRubdICPeQzWFr3T1dhqQ1Iq2FvCzqJl60+4OiC0aEylHhh4DrTKnojJy7l0t1dnSMFNFNdzB/tceJwGmUJ/ZK82AykHTMva4dkSwSjr+TjddpJYR+mI4aguEKOqKLlkw2mr2ZxXGp9Ic6/Qmz5kLxed1kfs3DZlQhIqkEZUuA3h4mj4Z/+APR6t/YQEB4Z/Zj8lJWyoLKOGETcHu+uV30uXauF9pXq8gPlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(366004)(346002)(136003)(7696005)(52116002)(38100700002)(8676002)(83380400001)(186003)(6486002)(107886003)(4326008)(66476007)(2616005)(44832011)(30864003)(2906002)(6666004)(478600001)(86362001)(8936002)(5660300002)(66556008)(36756003)(316002)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uZeG9clbz4Dvy7w+xUofppwU/I0FgvV4R0mX+apXCjHTN7/73iKsqiJijAJb?=
 =?us-ascii?Q?xmjvjh0qI3zY6NgsClgfniSxqsPUKR5MAiA8cAqrT11TMR7XNYHIdH0JA9ca?=
 =?us-ascii?Q?OUm+C5XRaDZQHugX9w4Vnohc2odRBtoMWsm2b0jWEtjhun2SvM7fKMxXu9dP?=
 =?us-ascii?Q?8QUdr4D2dYppaX1G+sZN57pLp7Fa/uYtU12lX+YTWVMoLaYvALCul3ajvioL?=
 =?us-ascii?Q?H2hyIZCpvNfvmI4NxYQ8opf//MK0sK/v4J4aFHsY/u0qEavLAQuR1BGA3vuO?=
 =?us-ascii?Q?WLRWznMIK5Vw8Eus/Mz0SkPr4IPxwfiHG3GWflL0j8U0O0LWqIS1354bsu0b?=
 =?us-ascii?Q?OVfpOJnwtMkqU/2cZnm5DP6BnTDqxYtQNojR2PvT/MX+B488wNLRq9FX6MEL?=
 =?us-ascii?Q?JCz1OZLGkXOvD4j+p0mJPiinUXQx+ysCv8sfjumaD9gbCNumfB0FpZvnzji0?=
 =?us-ascii?Q?Js6ndB2M3aPFaPMcr2YTgtetE//js86jDlq/P9j4JwY4gQuQqfPu8ap7SOb2?=
 =?us-ascii?Q?JWOuGa6NQkGcpM/G4onchm4aneAQ26ecs8XnGr7kKx+hcH4C/+vOvpG/urdW?=
 =?us-ascii?Q?kfmGuFeOQaTM1UB9zGMWcZXyQOVdMhd5bRO4XZ4bc5JlGxtMXAa1J9L8Vz2U?=
 =?us-ascii?Q?4VwanFToaAu4nOiT1iBJHTUUh6nMsTzyRnMYLa8vtQSqA8HbutqMQVXa3vUj?=
 =?us-ascii?Q?VRd8dLHHIpmQ9jbmB/FlxWmnuH7UiIr+Cweek/YOicBttXxEijrjFVQFDvZ5?=
 =?us-ascii?Q?LRh0C2MbSsk+L1+vrT1rYm1TEQ/57XlSTZFio/AMNRqoNffuZ7ZILibdxkbd?=
 =?us-ascii?Q?2GUivohToxhInIy8SQvMutRtZpeUYjEPQSd+pAjfFv57KW1W91+zpz8Vj3DV?=
 =?us-ascii?Q?Qco5Rr3PrdR7IjQbcPW0m+we3mJjY7nBapJHp0wR45Q4n4SklUhNaCjmgIxZ?=
 =?us-ascii?Q?8ey8FrLOEDlxLXJCX8iRr4i7N7EnbG9m+Y1EWejqpfz1kOXoSg3dQyKUFkir?=
 =?us-ascii?Q?Ww9t5wkd8G9IuVOwupjMbCRBqQrz59kjOLZLcdUXXLkdD430Vpb15AtVygAM?=
 =?us-ascii?Q?GTpbXsUsT41DpBvJlVyCtyJS4+h6mS5pNGHROjdEC86X4Aw1p+ahBM9B/MbO?=
 =?us-ascii?Q?syBzdhzB/bieqR5Z/HzO4z89+ovoav+F0ZDUu9EJSOTkCtsPJMHBSZoy33uY?=
 =?us-ascii?Q?ggmK/ygU6TBOCZwwCjm8Hsdv7/z6I0ttLiPcA/t/QEitmwx+Do1RHkgMsVBV?=
 =?us-ascii?Q?CqB/yTz4FSutEmEwVc3a9EAO/1d7MvUNzcghoSkCxjPi5i9C48XhXdtKj5c9?=
 =?us-ascii?Q?W2QQcdNCVlJgl5wuqjOfBxlCxYTFKjbn4XzvvzKp/QD+FNC1jNUf86jHZGzr?=
 =?us-ascii?Q?TISbBaQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f7a99c-c41a-409b-a060-08d969b33b17
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 23:34:36.4740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kf2GtPV4EXdOEZ7glC+4zX2kbqVzYvOZlY424HhYdQvPBsdcyyZ3+72WCPeaXDIjrwiasUAfuLR53bHTf40XKEgSO+QC30atQ71hHNrcoYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5520
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10089 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270139
X-Proofpoint-GUID: nwe_fXCo2yZQjLUtmmFaLiHSEuQGneEs
X-Proofpoint-ORIG-GUID: nwe_fXCo2yZQjLUtmmFaLiHSEuQGneEs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A structure per thread is allocated from a page that is shared mapped
between user space and kernel as means for faster communication. This will
facilitate sharing information, Ex: per thread stats shared between kernel
and user space, that can be read by applications without the need for
making frequent system calls in latency sensitive code path.

A new system call is added, which will allocate the shared structure and
return its mapped user address. Multiple such structures will be allocated
on a page to accommodate requests from different threads of a multithreaded
process. Available space on a page is managed using a bitmap. When a thread
exits, the shared structure is freed and can get reused for another thread
that requests the shared structure. More pages will be allocated and used as
needed based on the number of threads requesting use of shared structures.
These pages are all freed when the process exits.

Each of these shared structures are rounded to 128 bytes. Available space
in this structure can be used to accommodate additional per thread stats,
state etc as needed. In future, if more space beyond 128 bytes, is
needed, multiple such shared structures per thread could be allocated and
managed by the kernel. Although, space in shared structure for sharing any
kind of stats or state should be sparingly used. Therefore shared structure
layout is not exposed to user space. the system call will return the
mapped user address of a specific member or nested structure within the
shared structure corresponding to stats requested, This would allow future
enhancements/changes without breaking the API.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/mm_types.h               |   2 +
 include/linux/sched.h                  |   3 +
 include/linux/syscalls.h               |   2 +
 include/linux/task_shared.h            |  57 +++++++
 include/uapi/asm-generic/unistd.h      |   5 +-
 kernel/fork.c                          |   7 +
 kernel/sys_ni.c                        |   3 +
 mm/Makefile                            |   2 +-
 mm/task_shared.c                       | 301 +++++++++++++++++++++++++++++++++
 11 files changed, 382 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/task_shared.h
 create mode 100644 mm/task_shared.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ce763a1..a194581 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -452,3 +452,4 @@
 445	i386	landlock_add_rule	sys_landlock_add_rule
 446	i386	landlock_restrict_self	sys_landlock_restrict_self
 447	i386	memfd_secret		sys_memfd_secret
+448	i386	task_getshared		sys_task_getshared
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f6b5779..9dda907 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -369,6 +369,7 @@
 445	common	landlock_add_rule	sys_landlock_add_rule
 446	common	landlock_restrict_self	sys_landlock_restrict_self
 447	common	memfd_secret		sys_memfd_secret
+448	common	task_getshared		sys_task_getshared
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 52bbd2b..5ec26ed 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -572,6 +572,8 @@ struct mm_struct {
 #ifdef CONFIG_IOMMU_SUPPORT
 		u32 pasid;
 #endif
+		/* user shared pages */
+		void *usharedpg;
 	} __randomize_layout;
 
 	/*
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ec8d07d..237aa21 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1400,6 +1400,9 @@ struct task_struct {
 	struct llist_head               kretprobe_instances;
 #endif
 
+	/* user shared struct */
+	void *task_ushrd;
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 69c9a70..09680b7 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1052,6 +1052,8 @@ asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type ru
 asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
 asmlinkage long sys_memfd_secret(unsigned int flags);
 
+asmlinkage long sys_task_getshared(long opt, long flags, void __user *uaddr);
+
 /*
  * Architecture-specific system calls
  */
diff --git a/include/linux/task_shared.h b/include/linux/task_shared.h
new file mode 100644
index 0000000..de17849
--- /dev/null
+++ b/include/linux/task_shared.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef	__TASK_SHARED_H__
+#define	__TASK_SHARED_H__
+
+#include <linux/mm_types.h>
+
+/*
+ * Track user-kernel shared pages referred by mm_struct
+ */
+struct ushared_pages {
+	struct list_head plist;
+	struct list_head frlist;
+	unsigned long pcount;
+};
+
+/*
+ * Following is the per task struct shared with kernel for
+ * fast communication.
+ */
+struct task_ushared {
+	long version;
+};
+
+/*
+ * Following is used for cacheline aligned allocations in a page.
+ */
+union  task_shared {
+	struct task_ushared tu;
+	char    s[128];
+};
+
+/*
+ * Struct to track per page slots
+ */
+struct ushared_pg {
+	struct list_head list;
+	struct list_head fr_list;
+	struct page *pages[2];
+	u64 bitmap; /* free slots */
+	int slot_count;
+	unsigned long kaddr;
+	unsigned long vaddr; /* user address */
+	struct vm_special_mapping ushrd_mapping;
+};
+
+/*
+ * Following struct is referred by tast_struct
+ */
+struct task_ushrd_struct {
+	struct task_ushared *kaddr; /* kernel address */
+	struct task_ushared *uaddr; /* user address */
+	struct ushared_pg *upg;
+};
+
+extern void task_ushared_free(struct task_struct *t);
+extern void mm_ushared_clear(struct mm_struct *mm);
+#endif /* __TASK_SHARED_H__ */
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a9d6fcd..7c985b1 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -878,8 +878,11 @@ __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
 __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
 #endif
 
+#define __NR_task_getshared 448
+__SYSCALL(__NR_task_getshared, sys_task_getshared)
+
 #undef __NR_syscalls
-#define __NR_syscalls 448
+#define __NR_syscalls 449
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/fork.c b/kernel/fork.c
index bc94b2c..f84bac0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -97,6 +97,7 @@
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
+#include <linux/task_shared.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -903,6 +904,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (err)
 		goto free_stack;
 
+	/* task's ushared struct not inherited across fork */
+	tsk->task_ushrd =  NULL;
+
 #ifdef CONFIG_SECCOMP
 	/*
 	 * We must handle setting up seccomp filters once we're under
@@ -1049,6 +1053,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	mm->pmd_huge_pte = NULL;
 #endif
+	mm->usharedpg = NULL;
 	mm_init_uprobes_state(mm);
 
 	if (current->mm) {
@@ -1099,6 +1104,7 @@ static inline void __mmput(struct mm_struct *mm)
 	ksm_exit(mm);
 	khugepaged_exit(mm); /* must run before exit_mmap */
 	exit_mmap(mm);
+	mm_ushared_clear(mm);
 	mm_put_huge_zero_page(mm);
 	set_mm_exe_file(mm, NULL);
 	if (!list_empty(&mm->mmlist)) {
@@ -1308,6 +1314,7 @@ static int wait_for_vfork_done(struct task_struct *child,
 static void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
 	uprobe_free_utask(tsk);
+	task_ushared_free(tsk);
 
 	/* Get rid of any cached register state */
 	deactivate_mm(tsk, mm);
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 30971b1..8fbdc55 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -481,3 +481,6 @@ COND_SYSCALL(setuid16);
 
 /* restartable sequence */
 COND_SYSCALL(rseq);
+
+/* task shared */
+COND_SYSCALL(task_getshared);
diff --git a/mm/Makefile b/mm/Makefile
index e343674..03f88fe 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -52,7 +52,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o percpu.o slab_common.o \
 			   compaction.o vmacache.o \
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o gup.o mmap_lock.o $(mmu-y)
+			   debug.o gup.o mmap_lock.o task_shared.o $(mmu-y)
 
 # Give 'page_alloc' its own module-parameter namespace
 page-alloc-y := page_alloc.o
diff --git a/mm/task_shared.c b/mm/task_shared.c
new file mode 100644
index 0000000..3ec5eb6
--- /dev/null
+++ b/mm/task_shared.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/uio.h>
+#include <linux/sched.h>
+#include <linux/sched/mm.h>
+#include <linux/highmem.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/task_shared.h>
+
+/* Shared page */
+
+#define TASK_USHARED_SLOTS (PAGE_SIZE/sizeof(union task_shared))
+
+/*
+ * Called once to init struct ushared_pages pointer.
+ */
+static int init_mm_ushared(struct mm_struct *mm)
+{
+	struct ushared_pages *usharedpg;
+
+	usharedpg = kmalloc(sizeof(struct ushared_pages), GFP_KERNEL);
+	if (usharedpg == NULL)
+		return 1;
+
+	INIT_LIST_HEAD(&usharedpg->plist);
+	INIT_LIST_HEAD(&usharedpg->frlist);
+	usharedpg->pcount = 0;
+	mmap_write_lock(mm);
+	if (mm->usharedpg == NULL) {
+		mm->usharedpg = usharedpg;
+		usharedpg = NULL;
+	}
+	mmap_write_unlock(mm);
+	if (usharedpg != NULL)
+		kfree(usharedpg);
+	return 0;
+}
+
+static int init_task_ushrd(struct task_struct *t)
+{
+	struct task_ushrd_struct *ushrd;
+
+	ushrd = kzalloc(sizeof(struct task_ushrd_struct), GFP_KERNEL);
+	if (ushrd == NULL)
+		return 1;
+
+	mmap_write_lock(t->mm);
+	if (t->task_ushrd == NULL) {
+		t->task_ushrd = ushrd;
+		ushrd = NULL;
+	}
+	mmap_write_unlock(t->mm);
+	if (ushrd != NULL)
+		kfree(ushrd);
+	return 0;
+}
+
+/*
+ * Called from __mmput(), mm is going away
+ */
+void mm_ushared_clear(struct mm_struct *mm)
+{
+	struct ushared_pg *upg;
+	struct ushared_pg *tmp;
+	struct ushared_pages *usharedpg;
+
+	if (mm == NULL || mm->usharedpg == NULL)
+		return;
+
+	usharedpg = mm->usharedpg;
+	if (list_empty(&usharedpg->frlist))
+		goto out;
+
+	list_for_each_entry_safe(upg, tmp, &usharedpg->frlist, fr_list) {
+		list_del(&upg->fr_list);
+		put_page(upg->pages[0]);
+		kfree(upg);
+	}
+out:
+	kfree(mm->usharedpg);
+	mm->usharedpg = NULL;
+
+}
+
+void task_ushared_free(struct task_struct *t)
+{
+	struct task_ushrd_struct *ushrd = t->task_ushrd;
+	struct mm_struct *mm = t->mm;
+	struct ushared_pages *usharedpg;
+	int slot;
+
+	if (mm == NULL || mm->usharedpg == NULL || ushrd == NULL)
+		return;
+
+	usharedpg = mm->usharedpg;
+	mmap_write_lock(mm);
+
+	if (ushrd->upg == NULL)
+		goto out;
+
+	slot = (unsigned long)((unsigned long)ushrd->uaddr
+		 - ushrd->upg->vaddr) / sizeof(union task_shared);
+	clear_bit(slot, (unsigned long *)(&ushrd->upg->bitmap));
+
+	/* move to head */
+	if (ushrd->upg->slot_count == 0) {
+		list_del(&ushrd->upg->fr_list);
+		list_add(&ushrd->upg->fr_list, &usharedpg->frlist);
+	}
+
+	ushrd->upg->slot_count++;
+
+	ushrd->uaddr = ushrd->kaddr = NULL;
+	ushrd->upg = NULL;
+
+out:
+	t->task_ushrd = NULL;
+	mmap_write_unlock(mm);
+	kfree(ushrd);
+}
+
+/* map shared page */
+static int task_shared_add_vma(struct ushared_pg *pg)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm =  current->mm;
+	unsigned long ret = 1;
+
+
+	if (!pg->vaddr) {
+		/* Try to map as high as possible, this is only a hint. */
+		pg->vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE,
+					PAGE_SIZE, 0, 0);
+		if (pg->vaddr & ~PAGE_MASK) {
+			ret = 0;
+			goto fail;
+		}
+	}
+
+	vma = _install_special_mapping(mm, pg->vaddr, PAGE_SIZE,
+			VM_SHARED|VM_READ|VM_MAYREAD|VM_DONTCOPY,
+			&pg->ushrd_mapping);
+	if (IS_ERR(vma)) {
+		ret = 0;
+		pg->vaddr = 0;
+		goto fail;
+	}
+
+	pg->kaddr = (unsigned long)page_address(pg->pages[0]);
+fail:
+	return ret;
+}
+
+/*
+ * Allocate a page, map user address and add to freelist
+ */
+static struct ushared_pg *ushared_allocpg(void)
+{
+
+	struct ushared_pg *pg;
+	struct mm_struct *mm = current->mm;
+	struct ushared_pages *usharedpg = mm->usharedpg;
+
+	if (usharedpg == NULL)
+		return NULL;
+	pg = kzalloc(sizeof(*pg), GFP_KERNEL);
+
+	if (unlikely(!pg))
+		return NULL;
+	pg->ushrd_mapping.name = "[task_shared]";
+	pg->ushrd_mapping.fault = NULL;
+	pg->ushrd_mapping.pages = pg->pages;
+	pg->pages[0] = alloc_page(GFP_KERNEL);
+	if (!pg->pages[0])
+		goto out;
+	pg->pages[1] = NULL;
+	pg->bitmap = 0;
+
+	/*
+	 * page size should be 4096 or 8192
+	 */
+	pg->slot_count = TASK_USHARED_SLOTS;
+
+	mmap_write_lock(mm);
+	if (task_shared_add_vma(pg)) {
+		list_add(&pg->fr_list, &usharedpg->frlist);
+		usharedpg->pcount++;
+		mmap_write_unlock(mm);
+		return pg;
+	}
+	mmap_write_unlock(mm);
+
+out:
+	__free_page(pg->pages[0]);
+	kfree(pg);
+	return NULL;
+}
+
+
+/*
+ * Allocate task_ushared struct for calling thread.
+ */
+static int task_ushared_alloc(void)
+{
+	struct mm_struct *mm = current->mm;
+	struct ushared_pg *ent = NULL;
+	struct task_ushrd_struct *ushrd;
+	struct ushared_pages *usharedpg;
+	int tryalloc = 0;
+	int slot = -1;
+	int ret = -ENOMEM;
+
+	if (mm->usharedpg == NULL && init_mm_ushared(mm))
+		return ret;
+
+	if (current->task_ushrd == NULL && init_task_ushrd(current))
+		return ret;
+
+	usharedpg = mm->usharedpg;
+	ushrd = current->task_ushrd;
+repeat:
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	ent = list_empty(&usharedpg->frlist) ? NULL :
+		list_entry(usharedpg->frlist.next,
+		struct ushared_pg, fr_list);
+
+	if (ent == NULL || ent->slot_count == 0) {
+		if (tryalloc == 0) {
+			mmap_write_unlock(mm);
+			(void)ushared_allocpg();
+			tryalloc = 1;
+			goto repeat;
+		} else {
+			ent = NULL;
+		}
+	}
+
+	if (ent) {
+		slot = find_first_zero_bit((unsigned long *)(&ent->bitmap),
+		  TASK_USHARED_SLOTS);
+		BUG_ON(slot >=  TASK_USHARED_SLOTS);
+
+		set_bit(slot, (unsigned long *)(&ent->bitmap));
+
+		ushrd->uaddr = (struct task_ushared *)(ent->vaddr +
+		  (slot * sizeof(union task_shared)));
+		ushrd->kaddr = (struct task_ushared *)(ent->kaddr +
+		  (slot * sizeof(union task_shared)));
+		ushrd->upg = ent;
+		ent->slot_count--;
+		/* move it to tail */
+		if (ent->slot_count == 0) {
+			list_del(&ent->fr_list);
+			list_add_tail(&ent->fr_list, &usharedpg->frlist);
+		}
+
+	       ret = 0;
+	}
+
+out:
+	mmap_write_unlock(mm);
+	return ret;
+}
+
+
+/*
+ * Task Shared : allocate if needed, and return address of shared struct for
+ * this thread/task.
+ */
+static long task_getshared(u64 opt, u64 flags, void __user *uaddr)
+{
+	struct task_ushrd_struct *ushrd = current->task_ushrd;
+
+	/* We have address, return. */
+	if (ushrd != NULL && ushrd->upg != NULL) {
+		if (copy_to_user(uaddr, &ushrd->uaddr,
+			sizeof(struct task_ushared *)))
+			return (-EFAULT);
+		return 0;
+	}
+
+	task_ushared_alloc();
+	ushrd = current->task_ushrd;
+	if (ushrd != NULL && ushrd->upg != NULL) {
+		if (copy_to_user(uaddr, &ushrd->uaddr,
+			sizeof(struct task_ushared *)))
+			return (-EFAULT);
+		return 0;
+	}
+	return (-ENOMEM);
+}
+
+
+SYSCALL_DEFINE3(task_getshared, u64, opt, u64, flags, void __user *, uaddr)
+{
+	return task_getshared(opt, flags, uaddr);
+}
-- 
2.7.4

