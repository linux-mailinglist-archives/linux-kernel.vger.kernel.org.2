Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4518D3FA1D7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 01:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhH0Xf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 19:35:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51448 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232405AbhH0Xf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 19:35:27 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17RKPA99002206
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=zOvdA8MvFnY8zyr9XjagORMb61ckIdTVPjD4J48nZys=;
 b=l2kkf4r9pE7PL2falhx+eRFacK0sGxKyz0CI4HWnz+ErHwNnX/WKt00hsAtHIW4gyy12
 upWCYLd5gxsJpeohgc+fQ+Ky5VqPTHq6D//ApFnn+cwpW43rRprK1MvMSMKRr9mlHauD
 rY8cA5MkbT5hITmNn+7UUNds8BvDtsK/nsTMTKqbUZFgQPq7epYVnt5E+YvkX1tQvuqK
 U8HDOB1KEV4ireEsbyXJ5JWjIY1vnA8xYNgx1oGgpQ+kAmL1gT9QYSXi1Zh1Uk0CgHXm
 +uvTSwcMn/pHZhgYVfj1dUs10E0EE/EC7/O/GUlAI3U4g0etmv++Na8OEOLncL1RzF/u 6A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=zOvdA8MvFnY8zyr9XjagORMb61ckIdTVPjD4J48nZys=;
 b=w0GC6X3yvhsnF2410US+KxWXXcu0GTx7eOwAgjM9nfFm+/a91O+Of0G5rZNTNd+BQt7w
 kVq8tLfS+BvqIc25YYrT/iBo3YlK82fFp99qkvREll00lIqYbja41pra0HPJL2b7Shud
 YqQSOtpN20UBFdUkU5me1SM8D0npgsLk3dId6MOSVwtgqM5cb8GrMn+D04KyPTBHM+DA
 j+aWnPcq27OzSMrE6MBtINhXQUs9XzrkZFrIdrKtXly516MPkRnmqSxfzQAo4SLlxr+X
 iL8bgvNuupyUDdgNUsMXV2QO2r1xzXwgIOwHoctp/BIVVB3MGX6DXQy73GyLklThlHK7 2g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3apvjr1sj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:34:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RNFWMl109062
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:34:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3030.oracle.com with ESMTP id 3aq2hv4mef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:34:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNGMJ+kA9POvk1Fo/EcydC6SPJYafvCNJ00qmdvuBbhojxGFNKDGG2F0LaKB3xX/U7YJnPM4i39iQKK9YUY513pjMBw1DJJuRyR93DieM5uRxqPgpFzrQi50r0JO5Q3/f2EVhOKfWucPf/W4TWudSUAu+8IkyFxCOcxopgOJqvQVp8tDpm5wK2WKI/tHv7QzyHKlBGoaxggxz/26PbdXVou34yVvsULgjgI1TcwjTo+OSMhjOGsObVIiYstKxvzdTJMxOuQC6Hk6IbHt47cD0WsX2ofQ6wjyh9S/nAY9njxTFROFACXMb+LBRDeQ2kIGDgGQ5cKdn06HXcPh4oG8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOvdA8MvFnY8zyr9XjagORMb61ckIdTVPjD4J48nZys=;
 b=Jz4EaZwISM7FWg3ft42dqbniGQGhKF7vpituMx+S5Ttap2m9f4NABOEGBPDk7DjpX/VufGxGbyzmXzndzDIcFhygxH3dwODCo20tC/hv9YI7wy7diFNKkNIh3bcORyJPwd/lq2ciM7SdEnL0Rt4yLE2G1Zcl4Dm3y4dcm3n3RrL1Xb//Yr88TzxDwl6PVY7/+edvLlmboLjwNJeKodk3vWT5pHvBwYDufmublb1fwEr4Gt4ThtzswsHbhtmXvF2+lVtoCXv1prg+0KHmX2vR5+xUghACohGddrqMuhxilsq9pX76RLv0X8E7orfOdwS+gjUpQJMCj9gDWL723kYHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOvdA8MvFnY8zyr9XjagORMb61ckIdTVPjD4J48nZys=;
 b=XdRwWgk0Quw6eZaAwBtttFt9BYpGn8QrDxNHkUn48dYK7RL5s2hRvRoLtV3h59s6qZFxGkEPwgv8pfvx7TN9PxcuO9phsgiQVBAvfnU1yoPzv/k6YIr7houNW9Vgwl6U0K5/2PvfPiBhrLisvOOkimkL4VHgUyySbhabgcJLowc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by SJ0PR10MB5520.namprd10.prod.outlook.com (2603:10b6:a03:3fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 23:34:35 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837%7]) with mapi id 15.20.4415.024; Fri, 27 Aug 2021
 23:34:35 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     prakash.sangappa@oracle.com
Subject: [RFC PATCH 0/3] Provide fast access to thread-specific data
Date:   Fri, 27 Aug 2021 16:42:13 -0700
Message-Id: <1630107736-18269-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0034.namprd07.prod.outlook.com
 (2603:10b6:803:2d::15) To BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-ThinkCentre-M82.us.oracle.com (2606:b400:8024:1010::1501) by SN4PR0701CA0034.namprd07.prod.outlook.com (2603:10b6:803:2d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4457.19 via Frontend Transport; Fri, 27 Aug 2021 23:34:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cec3a3f-bbff-4002-2e79-08d969b33a70
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5520D8E6E1CC20BC6C5DF25EE4C89@SJ0PR10MB5520.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9kTuBXoy7z433bP5yw/AyIXNClQ4eZy8+Qf23etEKWEInyFCztPwOtm//DcDUZ/RQ7Otdm436yS6jVk+0Hn3MtHJzbWxl4jupWrzzE/LYzgsSbx3OPYwAmrw8zOeBflkkqjIPWx9qr9/jFl2nbMS+7dIy/pluiZduVlMcsybj2ZXhj1Ipeb63AHIRsKm26XMqbmX6iXkSDmctdtsURqEWPQH4HvhWpqwuEBTm5lRb3SBRjT5Q/iN1fKrhF57cOVx6z4BliWLBbgFkarmSQ0twMxKTsQ8kHboSdWUoath8k1L7OA3TJ+XImybE5bNL/eY62ZHkYQF7WvTIC0sEjIJp6OTBqZzH6dddvPX1kCkzqTn6m7cxLYFVGb0Dj1ZMW839OQ1TCnxuY7Jry5TCt8dizr4/BN1fK/B+JnemPS2rLgIl4csdTthjLVJGuiCsa6PfVvxtSftr46YLXOM/VfjcHTmgFVIKBRMzFqv8DDANSLihtm0jsb5AopP9sU/XxDJxTbqO6faobs9vFWTTM99MCcFozc/Tn7iI3/LUuBgOWJKl4TdPujjVlMuMry6ZEQQ5SWyrbD/2QJCx+GZlkguM3LdMr1MQ0lOLtR2WOh66XLavkZKDWLedHTrvIaaWiHkEN1hXV56HBDVIJSGOKi/Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(366004)(346002)(136003)(7696005)(52116002)(38100700002)(8676002)(83380400001)(186003)(6486002)(107886003)(4326008)(66476007)(2616005)(44832011)(2906002)(6666004)(478600001)(86362001)(8936002)(5660300002)(66556008)(36756003)(316002)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lOqHohJNLgzvOrol+/j3EigRZOF/zBI5pzT/bKXxyQqRkRpYzwQ7Q2ONKIrz?=
 =?us-ascii?Q?jP/eKBTqUevhVffrhAs48DHIqu/GeXAUQP265pJ+SagVfRJGjHRCwMKWzbwq?=
 =?us-ascii?Q?0w3Tg8z5DGvYbXgYgYNS6zT3Lu9pislRJ5ebbU8l4zqUm8v0kNy1EdTSWcd/?=
 =?us-ascii?Q?i8xY/uQt/dbxSLyNTZ5VTT4u9G88ULCBI0PS90onPhnO2TZtVi8F7SdoIPpe?=
 =?us-ascii?Q?6/sDRtlIUaJuB8acNY1zeg/z1+0XsKU/GJ1CKHcJzg66YEolfh2QKMpmOPkv?=
 =?us-ascii?Q?xQkoxOghVlabofLwM0yuZvZAuW4aLOlWk4UiBfYFdygF6Aukh2BZlTKYRPBP?=
 =?us-ascii?Q?vrUnbHC4t+2T0N5Yuxf6p4Kdq7zFC0LGzASR8DoaHOLiwdkCBcnGx7A2VMT3?=
 =?us-ascii?Q?lPo1y5GujRXskqZeQuhhyKrOwKiJf/ElnyTHIFaqcrVY4IGu1d7kqjg9dejF?=
 =?us-ascii?Q?TDekglT4uqDpxsLprppr2J8a2vKROXaHlPmPR74tVX0Z4Jp/RbM7DhBwVarr?=
 =?us-ascii?Q?aB01DMU5gJ0DPuAFhELNVyc5/GB+9wQOJKSOMJwOq13HaROM96cElvuy5yEC?=
 =?us-ascii?Q?pw5+mVJmWFs7mdyLW9VHpTIYcBkuWvimn8FxFWJn2ravLqwJQkjh20U7j8DZ?=
 =?us-ascii?Q?2uq2AVz/Pro1vKdJud6p/JFSKWPWTulNR82c5HLJ7KlIPw3KsE24u4kvKt4I?=
 =?us-ascii?Q?L3FZQeODwLq6+R67FDymPKGG88EXnHCpmeEzuVI/9DoT3zhvPkDZA7BH06fp?=
 =?us-ascii?Q?PEz3aDFvwQHLxpCfAkAZluh6yyngSWEJT12S/ZJJkOz4OQUius8o1sVKuOXG?=
 =?us-ascii?Q?PXERna1JjBwD6xk4unz6oU+trE/3I2uI1Wy7Ldnb+iSAvsCFDDES6RUWeWyK?=
 =?us-ascii?Q?lGFKesKmCzWag7gS3lmCW0gRqgdIh14iigd9VivrrUr3IQR1sGk0ItVMO4pJ?=
 =?us-ascii?Q?ufgvfxUDUgP1W5MdQnwvX1D25clhWprbc3tPwrhsGXyh46G3BchZ8FzNkYAP?=
 =?us-ascii?Q?bTWx+KJvg+uABhU8l39Lo5/HoqoqpwdLjFo8VhE91MKUO3kgS3gyYlzXwHt0?=
 =?us-ascii?Q?Zr1YPaXHwkZ0kcWIEt4GZ+vY3FEJYahsmsGJgKM7Rj9YG0a/6nIkoZI+J/vK?=
 =?us-ascii?Q?R/bRvrM5kZSg2OkisNnCs/SPEhcwbDZ0f4tZcJwrumJUoSteL2c8Hn4ng1+p?=
 =?us-ascii?Q?OiXH1rS8GP2NYDzjkGNLjoS4I/RqtvU/TJGk4SIQjlRNjm+eEKLm7rg0ZIjM?=
 =?us-ascii?Q?x6mmD8aauaFkqXXvERsepN5PKafhuMt+hdSdcCGki8KxQHb6HxdiVkeUOack?=
 =?us-ascii?Q?pj5PkhtBXA2/mayKh56LVWGmMvQXZ4gxeMvxBnywCMnlFegFMOcS9EImaYms?=
 =?us-ascii?Q?vZjEVA8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cec3a3f-bbff-4002-2e79-08d969b33a70
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 23:34:35.3037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFGZNq58Hb5BO3I0+k47ISAQThDmgBAFX5veJWqPAMaF0T9UxcmT8xe3Votntd4VBjr7D6WZt96TV/jDDFR16LuDZgMQ6ZQ30sfueSECXj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5520
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10089 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270139
X-Proofpoint-GUID: TLjdveH6aImNp02-NcMt-BUX-SMFAsQL
X-Proofpoint-ORIG-GUID: TLjdveH6aImNp02-NcMt-BUX-SMFAsQL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending this as RFC, looking for feedback.

Some applications, like a Databases require reading thread specific stats
frequently from the kernel in latency sensitive codepath. The overhead of
reading stats from kernel using system call affects performance.
One use case is reading thread's scheduler stats from /proc schedstat file
(/proc/pid/schedstat) to collect time spent by a thread executing on the
cpu(sum_exec_runtime), time blocked waiting on runq(run_delay). These
scheduler stats, read several times per transaction in latency-sensitive
codepath, are used to measure time taken by DB operations.

This patch proposes to introduce a mechanism for kernel to share thread
stats thru a per thread shared structure shared between userspace and
kernel. The per thread shared structure is allocated on a page shared
mapped between user space and kernel, which will provide a way for fast
communication between user and kernel. Kernel publishes stats in this
shared structure. Application thread can read from it in user space
without requiring system calls.

Similarly, there can be other use cases for such shared structure
mechanism.

Introduce 'off cpu' time:

The time spent executing on a cpu(sum_exec_runtime) by a thread,
currently available thru thread's schedstat file, can be shared thru
the shared structure mentioned above. However, when a thread is running 
on the cpu, this time gets updated periodically, can take upto 1ms or
more as part of scheduler tick processing. If the application has to 
measure cpu time consumed across some DB operations, using
'sum_exec_runtime' will not be accurate. To address this the proposal
is to introduce a thread's 'off cpu' time, which is measured at context
switch, similar to time on runq(ie run_delay in schedstat file) is and
should be more accurate. With that the application can determine cpu time
consumed by taking the elapsed time and subtracting off cpu time. The
off cpu time will be made available thru the shared structure along with
the other schedstats from /proc/pid/schedstat file.

The elapsed time itself can be measured using clock_gettime, which is
vdso optimized and would be fast. The schedstats(runq time & off cpu time)
published in the shared structure will be accumulated time, same as what
is available thru schedstat file, all in units of nanoseconds. The
application would take the difference of the values from before and after
the operation for measurement.

Preliminary results from a simple cached read Database workload shows
performance benefit, when the database uses shared struct for reading
stats vs reading from /proc directly.

Implementation:

A new system call is added to request use of shared structure by a user
thread. Kernel will allocate page(s), shared mapped with user space in
which per-thread shared structures will be allocated. These structures
are padded to 128 bytes. This will contain struct members or nested
structures corresponding to supported stats, like the thread's schedstats,
published by the kernel for user space consumption. More struct members
can be added as new feature support is implemented. Multiple such shared
structures will be allocated from a page(upto 32 per 4k page) and avoid
having to allocate one page per thread of a process. Although, will need
optimizing for locality. Additional pages will be allocated as needed to
accommodate more threads requesting use of shared structures. Aim is to
not expose the layout of the shared structure itself to the application,
which will allow future enhancements/changes without affecting the API.

The system call will return a pointer(user space mapped address) to the per
thread shared structure members. Application would save this per thread
pointer in a TLS variable and reference it.

The system call is of the form.
int task_getshared(int option, int flags, void __user *uaddr)

// Currently only TASK_SCHEDSTAT option is supported - returns pointer
// to struct task_schedstat. The struct task_schedstat is nested within
// the shared structure.

struct task_schedstat {
        volatile u64    sum_exec_runtime;
        volatile u64    run_delay;
        volatile u64    pcount;
        volatile u64    off_cpu;
};

Usage:

__thread struct task_schedstat *ts;
task_getshared(TASK_SCHEDSTAT, 0, &ts);

Subsequently the stats are accessed using the 'ts' pointer by the thread

Prakash Sangappa (3):
  Introduce per thread user-kernel shared structure
  Publish tasks's scheduler stats thru the shared structure
  Introduce task's 'off cpu' time

 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/mm_types.h               |   2 +
 include/linux/sched.h                  |   9 +
 include/linux/syscalls.h               |   2 +
 include/linux/task_shared.h            |  92 ++++++++++
 include/uapi/asm-generic/unistd.h      |   5 +-
 include/uapi/linux/task_shared.h       |  23 +++
 kernel/fork.c                          |   7 +
 kernel/sched/deadline.c                |   1 +
 kernel/sched/fair.c                    |   1 +
 kernel/sched/rt.c                      |   1 +
 kernel/sched/sched.h                   |   1 +
 kernel/sched/stats.h                   |  55 ++++--
 kernel/sched/stop_task.c               |   1 +
 kernel/sys_ni.c                        |   3 +
 mm/Makefile                            |   2 +-
 mm/task_shared.c                       | 314 +++++++++++++++++++++++++++++++++
 18 files changed, 501 insertions(+), 20 deletions(-)
 create mode 100644 include/linux/task_shared.h
 create mode 100644 include/uapi/linux/task_shared.h
 create mode 100644 mm/task_shared.c

-- 
2.7.4

