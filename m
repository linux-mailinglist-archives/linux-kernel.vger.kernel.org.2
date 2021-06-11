Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213CF3A41B8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhFKML2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:11:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57638 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhFKMLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:11:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15BC4VGb026930;
        Fri, 11 Jun 2021 12:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=XxWGP9qVjzmbqLpGQRLEtkp2gUj+LVIndtsBapSYphk=;
 b=UPiPdHXu3QqLZx77I0CS1dno//AUjJtgepGGtT7U8mwpjFKMq5xciAD0yiD4VbuHV0fR
 FAqzenyc+HUddYRVBf89r/25YJinbESjAHlzUeVhdmgMLA8LcRz8u5TLj5NJ5msCNO6P
 SU4dZ/AGPQKVmw/v/ADyu3M3A+6QMBAjmUQdNv3grUcPzxRD26Z2aS2ybKIIlgmyz2WK
 JnuYVth14LfTa/4Q0ApZYT2BP+jFYVupl+SHea7oUUPg90q5rmPXVLbxJ4PY5vP2Jd07
 T4Dd6VcaPRcE89gC3PjziymgTvS+YI1jwE7p5XCHwXrFzX8rLTJwOuKUtpPODJEk0+Mn QQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3914quw2gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 12:09:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15BC129m063389;
        Fri, 11 Jun 2021 12:09:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3030.oracle.com with ESMTP id 38yyaddmtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 12:09:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSqRQBETKh0cIzBb58F4kmCriV87cIJGlHL80Ho0jNGCc5czJhB7kLt2h5QxFEaeT0EixTCJM0AaPwVUGb1B1S9JeO/TdlUnfzOTW7lzTULYoKSbB/KqqL1+F9p60R0vAKvUcVI9UGE2rATjf1bsgKHF4bIOA64oS+aZc0Fn0K1kUazAnyjHyi0fNVcIxgR1inONaoUDNDXbFptHfb8OvyPNXg1cqkEN3Yudn5BvTdgo/ILh6hdSFv88QswtTaLSbFbMwl7Pdwe+TQnuigho82dPR1NR49Swewpv3dFzjQXrXhG8yDDD8wqSW+NsLHq1+OqeZZmNnhHwuwa+mTgVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxWGP9qVjzmbqLpGQRLEtkp2gUj+LVIndtsBapSYphk=;
 b=a8xAwuEGtSBJrPzqekY/2XjRRQ7iO+ag45gXDq++BVL1U3ZWyleadC5NzeoVFpWfavkdYXi5I9xCD62CrD+ju5qHp+0djIiBlnaPnE0l5/+AmNXwLBnPRc4E3sh2GvSfxt4cMwHylrMc34D6926htyC/f0UelRRDsfaiWxmiffCmAH+SVwcxzxo4AKy1GQKxstnzsg27IWuivIWNIyG7EiuX6eS1PaQ4m9eP5pMgNWtg7fp1PYfDevqahsqXBgKLfhOqTib4VD24/hyOkXgxR27t2Zz5BtpzIJ2MZmiaJwFCOZCdR30kBPpXZA9Otn22RZytKbdbmANq/fhTZ5MZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxWGP9qVjzmbqLpGQRLEtkp2gUj+LVIndtsBapSYphk=;
 b=SpXJLLZcw98isOlE4vBgFA8jLUnbEL56dBnWUUlTUAwn1BNRKpmPc6oU2RyWNdeUpJ8XRnPmvCf+XvBvG8Rl57fgA2sHmbHOInKxpEE6KxXvrUSpbKfZrMdMLssvI2ALoAsMKet7ybl5S7AsZR0Lywdvm7Spx/fwbzlYJRYq+5s=
Authentication-Results: brauner.io; dkim=none (message not signed)
 header.d=none;brauner.io; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA2PR10MB4617.namprd10.prod.outlook.com (2603:10b6:806:118::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Fri, 11 Jun
 2021 12:09:19 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::9ded:a005:f4da:7741]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::9ded:a005:f4da:7741%8]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 12:09:19 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     christian@brauner.io
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RFC POC] pidfd: make ptrace and pidfd work together
Date:   Fri, 11 Jun 2021 13:09:08 +0100
Message-Id: <20210611120908.4709-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.31.0.253.gdec51257f3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2001:8b0:1101:10::2]
X-ClientProxiedBy: LO4P123CA0256.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::9) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loom.srvr.nix (2001:8b0:1101:10::2) by LO4P123CA0256.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:194::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Fri, 11 Jun 2021 12:09:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1517f7be-5ad3-4d82-6888-08d92cd1bdb9
X-MS-TrafficTypeDiagnostic: SA2PR10MB4617:
X-Microsoft-Antispam-PRVS: <SA2PR10MB4617CD958BCD0AB7E74427BA8B349@SA2PR10MB4617.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5XF5Wg1oHftKP06NAMlpOFfRylMTpi+F4Bns39QaZakVBQWofzroJ60/An3pHweZNO59CjIKh3D7zDVrADsCxL1Ltzv+DqSUVMM5JBYZ+i3qjFwSPVwDTej7oUJu3nh0ZQeQ1oS6zANO18y7r3CSQ40Mwt7qsoRj6RACZ6DV0oC3rMYQcw6KgA3bnlEvgrOxeSEl0YPFCPV+cdsjfFdAsQq2zxuRVsEW16a5JsOHZItMFb+QjVshwmL2zy7SSfU6rjeE04Yxwj7mtuah+RIORtc4H86a6PDSjgXSZeP+efSQsG5wSyTag5DLb3LPaUVaYFh6VpfIDxYzlMtvG0W7gzW6coP9yl1dZB0u8UpYzTb1J/2xNK9Pc2+T/cCrbmHqGXTVgnedhgaz1qzvyBjksDU2HKnjmPWXdOqNamEuwGRd3aDdtMIy9cXFK6CtpYrzzxsaEq1GxOVU/S/UrQUFsU8kFKkMOjXOZ4jUyiaBQid+Qby1tviVTy+SjoAxow9/nXXM5DWptaqRqS0ZdWnRrATN8m0wVvskQVgsXn/3UXjlUE1JTWMRFoVGoN/CUJ01yusEZ4vXqb3sf5vXqkZ7QH3rR/I5XUmetd2xxl7lMf/Oax/6Jtdaar7/8E+8mvMCMWs2mKe3VuCZYlyKt3YOj/dtggxlS50Uqc8YuGj76RqPV74V03w5fEkJ1Jsc3uC3DEbl4mF6gOlVA7eeYEODfbJuQEF95+zYEacV9aFZXNmxy8tMWqvS0RtTcKq008ZH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(396003)(136003)(6666004)(5660300002)(2616005)(38100700002)(1076003)(86362001)(8936002)(52116002)(6916009)(8676002)(66476007)(66556008)(186003)(16526019)(6486002)(6506007)(2906002)(6512007)(44832011)(316002)(966005)(66946007)(36756003)(83380400001)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CQjF2/uv4S+A2TV4MT2ARZhwAByAABdjs1sHTPVklsxmnPkPG3eUQFaMrydJ?=
 =?us-ascii?Q?zbf8R54GsxJ+2gqecAGq6J449A9vWY0J12UVMsvSrY3MACw2N6GNWSoEQdaE?=
 =?us-ascii?Q?hK59/q6GR5oANn1FFVdX7YLlPTLvQ1YzpnF0zqXBeQ6Q9+WPEW0xyJ51XxZ6?=
 =?us-ascii?Q?ZBzCE0ebxm3OxjCOp7R+KmtmGAdQift86T2CCzgLUklhXRa9lDCvC8kO36EY?=
 =?us-ascii?Q?Cu69Q6KQ/vZlYMc8WRrc7CT0xaW5BDfBJBcvtPYTTwz3XYf1AlnF+u40c6zA?=
 =?us-ascii?Q?Wsvwrb7alQGpRqeOQ9bXJNEcjkNCRtxiy5y8JYDkNNNf4YzNCkTOg82Anhc7?=
 =?us-ascii?Q?pf2Y+sJnm2SDdBvuT3w88K6lVRmOFcYcr8lIIF7VcikRH30TJ+j6keN/2xGo?=
 =?us-ascii?Q?NuPMTyAlXUFNejnMQt8YxKjAVsfPy4G7yjxmw/kaWha4OeXYTienDlai8z43?=
 =?us-ascii?Q?/ev6HbfKfYonR1jAQiS013KJvyVcJLMS6YpYTXvQVbt9SN5fDZsJohSh3KYW?=
 =?us-ascii?Q?jwobiYBr1xqrSfHHtbXc9EiDaDSTDCJXdVf8l4OFReJwqTS6xueCjgAj3DO5?=
 =?us-ascii?Q?O/I7GQa1/I9Y39FhL88PjMJsU/LWh+QSq+39cupqgTtfGBJLIcVkj5OYP62e?=
 =?us-ascii?Q?PWue57nZkPR1UZ6xn9zG4nCr9sC7v5OMDvzu9fY7fa6Q6JMIKmvQ2lEU8VxF?=
 =?us-ascii?Q?VYWkcd6qKw37mlqGuAX8BqOU2OSkJQS6XCELvWeQSGKbbfrC3B/Snt6+4hHq?=
 =?us-ascii?Q?PTKzYKZKrnsG/2YDDCGyndMjXWsNP56XYi2ZyHtz9ZT2dR2zQzjgSu48vJzC?=
 =?us-ascii?Q?h9gG2zTYyWzRU8YI2c9sXFmubPGPXDWhP48LMD0Lbi0rH54Rp8bxZTObhJOR?=
 =?us-ascii?Q?PV02r8ZU3fU6fSFpwE64cMP+0etpKXuEq7knJ6j+kdwcvb95/OU1xQGo1Lrs?=
 =?us-ascii?Q?c3JZl5udm1EcVO28kUCuEgIV+udwZXQdGP5zzdxjtTKQ/o8YeIGOKkjRVAq9?=
 =?us-ascii?Q?K6kVQHo1/dATuTHFLRY1AetZPcXS5TbgmJJY8Q3LqsDG1E+Fe8Mf+7byVR8H?=
 =?us-ascii?Q?RdOKSwV4bf88ZHeqW5fIkcrIYsV31dQLVBQsnsScXmwnSQ1Z6Cn6OUtXVKPJ?=
 =?us-ascii?Q?nCH9MMunjBq81ZEpk/hgR/P9bQz39Wd4+bc260yyISm9RVM1X1zC7NoYFQ4P?=
 =?us-ascii?Q?qWDw5q9CK/pqDc0s1R5fipQI9p08+a8PM3YvdOBPAToZ/FmuTS1QP5pqMU4U?=
 =?us-ascii?Q?AdMcopi9fNHrB5q84NU2kyBYteohNYzLkQrA3enDC+V+KMKBRywpjNwpsug2?=
 =?us-ascii?Q?slOHWmLWwMWBBD9h5q7o6zUtt+Zssvrfw07YfKNis2v+iQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1517f7be-5ad3-4d82-6888-08d92cd1bdb9
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 12:09:19.3781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2QUi2t/cTyelEoy81crSiZdi3ZciCttShUEs9WEbrMr1Ma5a2jubSNlFgbZsT9OlWbmqmEGcJR6xcABfsO/kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4617
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106110077
X-Proofpoint-ORIG-GUID: m2x5epmgAqI3C862spf84NfP7Jehn4Th
X-Proofpoint-GUID: m2x5epmgAqI3C862spf84NfP7Jehn4Th
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10011 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106110077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes are a proof-of-concept to show how pidfd might be usable
to determine when a waitpid on a ptraced process would yield a response
without blocking.  This can be useful if you want a 'ptrace helper'
thread (or process) that accepts messages regarding what ptrace work
needs doing and also ptrace-monitors other processes to do that work.
It is obviously best to do the interprocess messaging part via a file
descriptor, but that means you have to poll() it, and if you're stuck in
poll() you can't wake up in time when one of your ptrace-monitored
processes needs attention, since waitpid does not yield an fd.  This
situation is tailor-made for pidfds!

Up until now I've handled this with a really rather ugly hack on the old
(long-rejected) waitfd, see
e.g. https://github.com/oracle/dtrace-linux-kernel/commit/81e92377b8e2f89fc0cde898738321dd869f21d2.
This commit is nasty in all sorts of ways and pidfds would be better in
every respect were it not that right now pidfds don't wake up pollers in
response to ptrace-induced waits.[1]

This patch fixes it!  But...  it's not good enough, because fixing it by
just lifting those restrictions breaks pidfd's interface contract in two
ways: of necessity it causes poll() to wake up if a ptraced child is
ready to respond, which might confuse existing users that use ptrace with
unexpected wakeups, but also ptrace's signalling is thread-directed, and
relates to single threads, so we must lift the restriction that pidfds
can only be used on thread-group leaders.

I don't know why this restriction was imposed, so I don't know what
ramifications lifting it might have. So both are best placed under pidfd
flags to make sure that pidfd users only get this behaviour if they want
it, perhaps named PIDFD_THREADS and PIDFD_PTRACE: to avoid possible
problems with non-ptrace-directed pthread usage, perhaps PIDFD_THREADS
should currently only be allowed in conjunction with PIDFD_PTRACE.
But... PIDFD_PTRACE needs to take effect after pidfd_create, at poll time
(in order to invoke do_notify_pidfd only when the flag is passed), but
I can see nowhere obvious to stash this flag -- and I'm not even sure this
approach makes sense.  So this certainly needs fixing and this patch must
for now just stand as evidence that having waitfds wake up ptraced waiters
is *really easy*.  I'd be very happy if you could suggest any way to get
flags from waitfd_open down into poll, so this could turn into something
that doesn't break the interface contract and is actually useful to other
people...

A trivial testcase (with a trivial singlethreaded child, and no
messaging layer) is provided so you can see the sort of thing I'm trying
to make work.

[1] It is also true that pidfds integrate with *waitid()*, not
    waitpid(), and waitid() cannot be used to interact with ptrace --
    but that's OK, because you can use a pidfd awakening from poll as
    proof that waitpid() would return with ptraced info if called, and
    then call waitpid() on the PID directly, without going via the
    pidfd.  This is not ideal, since it would be nice to be able to use
    waitid with P_PIDFD to get the info directly without also needing
    the associated process ID, but as long as waitid() masks out and
    throws away information returned by waitpid() for ptraced waits, it
    is the best we can do.  This is implied by the ptrace manpage, which
    never mentions waitid, because only waitpid works.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---
 kernel/fork.c                                 |  9 +-
 kernel/pid.c                                  |  5 +-
 kernel/signal.c                               | 10 ++-
 tools/testing/selftests/pidfd/.gitignore      |  1 +
 tools/testing/selftests/pidfd/Makefile        |  2 +-
 .../selftests/pidfd/pidfd_ptrace_test.c       | 82 +++++++++++++++++++
 6 files changed, 93 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_ptrace_test.c

Christian: I briefly mentioned this after your talk at the 2019 LPC,
and have finally got round to trying it and coming up with a testcase.
With this patch, things work!  Only of course they break everyone else
so we need to find a way not to do that :)

The full-sized monster userspace code that inspired this is here:
<https://github.com/oracle/dtrace-utils/blob/dev/libdtrace/dt_proc.c#L939>
and here for the ptrace side
<https://github.com/oracle/dtrace-utils/blob/dev/libproc/Pcontrol.c#L717>.
(The ad-hoc protocol this implements to get ptrace requests from the
rest of the process is here, though you will probably not find this
too interesting except as evidence that if this thread is processing
those messages it can't also be spending all its time blocked inside
a blocking waitpid:
<https://github.com/oracle/dtrace-utils/blob/dev/libdtrace/dt_proc.c#L1124>)
Changes needed to make it work with waitpids instead of waitfds:
<https://github.com/oracle/dtrace-utils/commit/1c15a5c4ac26507f6bdb53cf86a1c4d2baba2390>
(Yes, that's *it*.)

diff --git a/kernel/fork.c b/kernel/fork.c
index dc06afd725cb..0ba53b2858a1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1787,14 +1787,7 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 
 	poll_wait(file, &pid->wait_pidfd, pts);
 
-	/*
-	 * Inform pollers only when the whole thread group exits.
-	 * If the thread group leader exits before all other threads in the
-	 * group, then poll(2) should block, similar to the wait(2) family.
-	 */
-	if (thread_group_exited(pid))
-		poll_flags = EPOLLIN | EPOLLRDNORM;
-
+	poll_flags = EPOLLIN | EPOLLRDNORM;
 	return poll_flags;
 }
 
diff --git a/kernel/pid.c b/kernel/pid.c
index ebdf9c60cd0b..98703b44c29f 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -596,10 +596,7 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
 	if (!p)
 		return -ESRCH;
 
-	if (pid_has_task(p, PIDTYPE_TGID))
-		fd = pidfd_create(p, flags);
-	else
-		fd = -EINVAL;
+	fd = pidfd_create(p, flags);
 
 	put_pid(p);
 	return fd;
diff --git a/kernel/signal.c b/kernel/signal.c
index f7c6ffcbd044..2b2693e7f934 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1940,11 +1940,12 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
-static void do_notify_pidfd(struct task_struct *task)
+static void do_notify_pidfd(struct task_struct *task, int warn)
 {
 	struct pid *pid;
 
-	WARN_ON(task->exit_state == 0);
+	if (warn)
+	  WARN_ON(task->exit_state == 0);
 	pid = task_pid(task);
 	wake_up_all(&pid->wait_pidfd);
 }
@@ -1973,7 +1974,7 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
 
 	/* Wake up all pidfd waiters */
-	do_notify_pidfd(tsk);
+	do_notify_pidfd(tsk, 1);
 
 	if (sig != SIGCHLD) {
 		/*
@@ -2083,6 +2084,9 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
 		parent = tsk->real_parent;
 	}
 
+	/* Wake up all pidfd waiters */
+	do_notify_pidfd(tsk, 0);
+
 	clear_siginfo(&info);
 	info.si_signo = SIGCHLD;
 	info.si_errno = 0;
diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
index 973198a3ec3d..ebb5c30ba691 100644
--- a/tools/testing/selftests/pidfd/.gitignore
+++ b/tools/testing/selftests/pidfd/.gitignore
@@ -6,3 +6,4 @@ pidfd_wait
 pidfd_fdinfo_test
 pidfd_getfd_test
 pidfd_setns_test
+pidfd_ptrace_test
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index f4a2f28f926b..c2dd13fd9557 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -2,7 +2,7 @@
 CFLAGS += -g -I../../../../usr/include/ -pthread
 
 TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
-	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test
+	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test pidfd_ptrace_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/pidfd/pidfd_ptrace_test.c b/tools/testing/selftests/pidfd/pidfd_ptrace_test.c
new file mode 100644
index 000000000000..29c58190a466
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_ptrace_test.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <sys/ptrace.h>
+#include <poll.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include "pidfd.h"
+#include "../kselftest.h"
+
+#ifndef PTRACE_O_EXITKILL
+#define PTRACE_O_EXITKILL           (1 << 20)
+#endif
+
+int main(int argc, char **argv)
+{
+	int pidfd, forkblock[2];
+	pid_t pid;
+	int ret = 1;
+	struct pollfd pfd[1];
+	const char *err;
+
+	ksft_set_plan(1);
+
+	if (pipe(forkblock) < 0) {
+		ksft_print_msg("%s - failed to set up pipes\n", strerror(errno));
+		goto on_error;
+	}
+
+	if ((pid = fork()) < 0) {
+		ksft_print_msg("%s - failed to fork\n", strerror(errno));
+		goto on_error;
+	}
+
+	if (pid == 0) { /* child */
+		int dummy;
+		close(forkblock[1]);
+		read(forkblock[0], &dummy, 1);
+		close(forkblock[0]);
+		execlp("true", "true", NULL);
+		_exit(127);
+	}
+	close(forkblock[0]);
+
+	if (ptrace(PTRACE_SEIZE, pid, 0, PTRACE_O_EXITKILL |
+		   PTRACE_O_TRACEEXEC | PTRACE_O_TRACEEXIT) < 0) {
+		ksft_print_msg("%s - failed to ptrace\n");
+		kill(pid, SIGKILL);
+		goto on_error;
+	}
+	close(forkblock[1]);
+
+	pidfd = sys_pidfd_open(pid, 0);
+	if (pidfd < 0) {
+		ksft_print_msg(
+			"%s - failed to to open pidfd for pid %i\n",
+			strerror(errno), pid);
+		goto on_error;
+	}
+
+	pfd[0].events = POLLIN;
+	pfd[0].fd = pidfd;
+
+	while (errno = EINTR,
+	       poll((struct pollfd *) pfd, 1, 10000) <= 0 && errno == EINTR)
+		continue;
+
+	if (pfd[0].revents == 0) {
+		ksft_test_result_fail("timed out: pfd polling insensitive to ptrace awakens: failed\n");
+	} else {
+		ksft_test_result_pass("pfd polling sensitive to ptrace awakens: passed\n");
+	}
+
+	ret = 0;
+
+on_error:
+	if (pidfd >= 0)
+		close(pidfd);
+
+	return !ret ? ksft_exit_pass() : ksft_exit_fail();
+}

base-commit: 231bc539066760aaa44d46818c85b14ca2f56d9f
prerequisite-patch-id: 230338bd1e3bed095efd9b46607113f64b99bd97
-- 
2.31.0.253.gdec51257f3

