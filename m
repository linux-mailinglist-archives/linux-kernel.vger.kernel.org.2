Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757C53BBC87
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhGEMCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 08:02:11 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:46036 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230435AbhGEMCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 08:02:11 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 165Bw4DG029827;
        Mon, 5 Jul 2021 04:59:24 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-0064b401.pphosted.com with ESMTP id 39khgvretd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jul 2021 04:59:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeztCLL+C9l86VJ5ucCGn3UBvKemWJCN2pKjyNlX1ddmjvoB0iga9e7FKH8HKgJ+LuUK90xDa84eZUivcyINcEbLYHQc+y9euhInTSJHoX7B552hKKpwRhXCuNASnoJx3OGPDSV3RJ7ikfcuOYmsIx5BVltVWElzPogxFXvifGPT/zCSKbrAQuV6ggy3Cz5crY0HpZ5DLnO+6NuMmyfvm36jFijjELI9tkrx+dbSgqRHoDBC/td+0uwmcA61zI3iqmH6p1o/hLYNGAkhGnhssJC3CvpTQok/jwSkulZCl7M7EOiYtPTUD3pe1VyBJ90/sE1brnO7c8kYI+A0jrhdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhzaD0URY5cKGk5lZ9yc2ZvFA7lMKLgLJ3TI/ZucNtI=;
 b=NvyNmaO+5vtGTxj8lD7y7Ewu04y8b40Cp3c8edgoZfwcfs2CQveZrtRYPvHgQGO3REsA+YoB8Iy8bRO4rRb6+n6jcNBcKh+EsVDyjgL+XbCN1RD8On2jr3ygEmWIyDyYOyfPzgeioV2ci/VaUJMyKf3AudiKCCwrZqTFOo8rmxzkrMrbCgGopCXgJUqT8TDkV+axBx6mZUld1KcZLCQZnhz2inXepMUxnFSUwbO3i3VUBh2JEzgiNV/poTTx3y5MKfNoyj7nAHP2vC/nw2m+rzszymc5LVbKG1cDXov7lzl9PmtsFAKHdGl+tfj+rXu1w8/zOQG+UypyKkN0NSw3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhzaD0URY5cKGk5lZ9yc2ZvFA7lMKLgLJ3TI/ZucNtI=;
 b=UOLTkIQzOJZxRwlbwXWrZDpX+BAKNPorZ8Z6Rpqs7RD2G5VTvBG8auOe7xXMT6x3pCfOzZQaO3cNK6wFgN8ZHA3a8HEPbZkQ4IpUivYo5NSzKHoKaSWlQ7c3OAy5WbpcJdpwFYhh/TV3ufMSkrRtd8n1Qw8xwhg9vX5lUbYlrMc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB2603.namprd11.prod.outlook.com (2603:10b6:5:c6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.31; Mon, 5 Jul 2021 11:59:21 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::bce8:81f7:f5a1:af19]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::bce8:81f7:f5a1:af19%6]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 11:59:21 +0000
Subject: Re: [RFC][PATCH 1/4] locking/mutex: Use try_cmpxchg()
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        longman@redhat.com, boqun.feng@gmail.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210630153516.832731403@infradead.org>
 <20210630154114.834438545@infradead.org>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <cac55711-585a-4e08-3b5e-a6890e2f548d@windriver.com>
Date:   Mon, 5 Jul 2021 19:59:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210630154114.834438545@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:d0::16) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HKAPR04CA0006.apcprd04.prod.outlook.com (2603:1096:203:d0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 11:59:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 062e5b4f-ec0f-43d4-2032-08d93fac535e
X-MS-TrafficTypeDiagnostic: DM6PR11MB2603:
X-Microsoft-Antispam-PRVS: <DM6PR11MB2603DE4D96E18C367B0B40F3E41C9@DM6PR11MB2603.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3y4xRLNrzhTVxdYreA46sRfDrSbRZOw2/mXioZDcJ0HR3lzMfZBIhc/TP10hBUYdEjyG2p9bKuKWvxu12Tn+8EYwYQ4MfF+G5htKv4SHnKeYsc+H94dabvwmrchHy1pd3j/n0AjFMmFqF0dzh7wQKsMZw6MC40tXmtVdebi4cODhYnNYkeXCqhAk9Q4rV2sCtdsmB59cuj2aMD3AHPFa8OMLmDKBLJu6K+Rw8+dAKKo9IMX5b9kdugVJbZxKag5ZznFWoB1/Ut64OifGfzBOHpLbopQaD7A7m7wNnNmSaFN2AQLSNHd04chaR4YETDYYLQ468DH5+Z3vljHQsW4pyOwaJzY7gT6tBPzG4POtUm3ZfFC4PzfCA4ddDSAOeWP/dREvaUMjl29EtYzXqcfmGRswkAyYEFzLdMg/oKZmqSWxv1smUQSxPT3cOAYa2ebBrAMiaitIDelkV4Ct9hjkLQi2Bttqj4WVMu0H+LEXOc+VNRmmEi6Gnz87KzrMA9rN8nwF4pXtlbZnlLV6k9q2XLnOzORE2TD54chi1fa+MJ7oZ1s9z+IFsuxBTvo8YMHk1mIyaEHS1aS7WK0G2YI5DA56GeDj/2b3l1+C8yDV9lT5anr03yDAGlxwnnGqDSQp+zQ2hM8DceUHhNCVEx5UGbEEtHba++GuiVxohJZ1iVeZmsPe7ZGCF4iFtpNDxuyE5oROHkjFSC9xLDJBM/PExyjrGnL9u9dZ9lA+EB6Q+ug5SLTXgZnURLUcvSnVv5L7jNsAUYl9esCA3enbyxEA05QTgJOJJAQ/AesmhxcTvDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(396003)(366004)(136003)(376002)(2906002)(4326008)(31696002)(38100700002)(6706004)(86362001)(186003)(83380400001)(16526019)(31686004)(36756003)(6666004)(6486002)(478600001)(8936002)(38350700002)(8676002)(5660300002)(316002)(16576012)(26005)(2616005)(53546011)(66946007)(66556008)(52116002)(66476007)(956004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rjl1R21OM2p3ZisvR2VXeUxKQ1grd2lwZnpOZms4cDlEUzdCRDluakxTM1ht?=
 =?utf-8?B?V243bTRDYmNjMFVaek5uSGU4Q0VHeHk1UkhHRm5HSFRJTWVJcEJENlFrOXRj?=
 =?utf-8?B?dzVQN1BzVEUwSmxGYmZXOWExamFzcU9hQ3o1VW4zTG13NkRuek00dlpjUnlO?=
 =?utf-8?B?S0Y0bnF6WW9Lbi9mTW5uem1xNUpuQ1FqL3RKRnV1RTY5MXVheVpta0ZNT2Yw?=
 =?utf-8?B?N2o1QURNa1Q4SE9lanA5Y25vcnA0WkpEWWRjWHhYNVJOMEthZ2JBd0FTYU1K?=
 =?utf-8?B?NkFkbWMydXBOUnlwWFlJbjR5NDY5VE1ZQmJrSHg5VDlLa2dLbWlXV09PTzBa?=
 =?utf-8?B?RmhMSlJFaERtZmc5VVVrTDNtMllRVldVYi9zcUVCZlNUSDZMUUNUWWEySE84?=
 =?utf-8?B?MWxtdGlZTHVOQjJxZDF2d2ZtQ0F4RGVrSmc0SnNxRk9PcWZrdGphRFJHRnlv?=
 =?utf-8?B?aGVSeXJvajEwKzY0TWJSRGtrYlZSVmVjWm9kYnJzSC8vK0JQL2RoblZOWm83?=
 =?utf-8?B?R0pZd1BPc1RBOWhUOHp2Z1hLVXorTHU5QU9qUWV3cnRTV2xvOWRRbEdNVzA0?=
 =?utf-8?B?cWpxNmZTYkhNMkpSUnJ5cGJ5c05KUitBTVZmMGF2L2hKWUp6UFlZVDVkN1VO?=
 =?utf-8?B?L3JuZVZSUW9ENW13R3IzUC9CYVhUNEU1WU5jaTVnU1U5bGtHbHpvMDdxZzlh?=
 =?utf-8?B?VXhOaHhXd2xCVUhRNFJRSXNBWllzUWU4TXZGa2crU1NrQW9mQjlYTGxpZmhz?=
 =?utf-8?B?bEhoUmYwTkZJVHRHeDFhdG02N0I4YjNtNmlvQzNaNXN2eFdwWWZ0cXNnMStS?=
 =?utf-8?B?NGxEZk5ad2ozL0VzN0hENVNjcm10TWJndkZCUzZoblpEMEJydi9ZdjlkUzk2?=
 =?utf-8?B?ejB5LzFSQ1dOYlA4dC9sMEdPRDZxbVZqUGJ1SVU4STZZZnJvY0pBTUcxQVA5?=
 =?utf-8?B?N05IbUFpcjhJVlVvaGVWZFNKUlI4OGtWb2xWSnhvbEs1UDVqRi9UWVFmTWNR?=
 =?utf-8?B?N2FTM212WXFzQnpIMEw2cmpKNWtLZFl6MTBuc2cvTnlqaFo5QUoya094dGVv?=
 =?utf-8?B?SEV2R1UxRExvQUJFUGsxejNqUWRyZ0JZZFg3WlBGd3g0bDBiT3ZkbE9vN3Nn?=
 =?utf-8?B?TjRndWw3R0ZFN2c2aUZEL0NpbGRoMXFKRXFGaGh5eFdHblRqNjdEOHBFSWFy?=
 =?utf-8?B?UlhlY1JZWEU0NHFUK1ZEVTRxdXhMV3M4SlFzajZZbHBlL1hnNGRNUVBydlJT?=
 =?utf-8?B?eGxWM2R5UkdLZXZqQ0FlVUxHRTU4Qm96UlFvbTkxN0U1TmRaa3pDS1ByRnBS?=
 =?utf-8?B?dVN5UURhY1FwVlF5SzJxV3lRYnh2NlJORU8xalZESCtHa0U3dHpMV1BnbzJD?=
 =?utf-8?B?d3U0djA3YUVOeGdMMEFvbEI0NFVvWTJOWEJpRVBvaGtjVnFFQTZpMnpDYUJp?=
 =?utf-8?B?U2N0SUZOSTZuVW1UQi9EZlUyYkI1Zm93RGl3cHJacG4xQWlJU2h6K1R0eFNX?=
 =?utf-8?B?dHFXYzNiblFtSXVTK1NFT096YzYwTFZIdlhJSW01aURiOURYV01VMHNJNVl5?=
 =?utf-8?B?VHhaWjFDV3laZ1JSS3R2anl2VHNucVI3MjU1UVY4eUtRS0p0NjY2NmcrQ2Rh?=
 =?utf-8?B?MHUyMjU5K2lRR3RmbzFwMnRpNkJtaGJKZlcrNTdFQmZ3OWxQWnYyWFVlSUt2?=
 =?utf-8?B?bjVWeC9yQ0NEN000NytSWjg5VUlMZzZuQmVQbVNESG1xeTBLZFZQN2R5eDlQ?=
 =?utf-8?Q?tBUxRnu45FcX4/S7ABsl/hFyFeVnPjUz6tzCcmn?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062e5b4f-ec0f-43d4-2032-08d93fac535e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 11:59:21.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/iWVvZahMe60kDhoK4cOEBediNjyQPeb12QwQTCM+0y9R8flAUU+E7DEERVO7jugHfg9NHsr0bFeZiNAyPjdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2603
X-Proofpoint-ORIG-GUID: JN2Y7o5UIQLZvOBlnjLUnQBc7hg3eYp4
X-Proofpoint-GUID: JN2Y7o5UIQLZvOBlnjLUnQBc7hg3eYp4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-05_07:2021-07-02,2021-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107050064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/21 11:35 PM, Peter Zijlstra wrote:
> For simpler and better code.
> 
> Signed-off-by: Peter Zijlstra (Intel)<peterz@infradead.org>
> ---
>   kernel/locking/mutex.c |   27 ++++++---------------------
>   1 file changed, 6 insertions(+), 21 deletions(-)

Hi Peter,

I read the mutex codes today, and find there seems something wrong for 
the patch. Should we consider the race condition as blow?

 From 4035f50c96e17cbe3febab768b64da5c000e5b76 Mon Sep 17 00:00:00 2001
From: Yanfei Xu <yanfei.xu@windriver.com>
Date: Mon, 5 Jul 2021 17:56:58 +0800
Subject: [PATCH] locking/mutex: fix the endless loop when racing against
  mutex.owner

if a race condition happened on mutex.owner after we fetch its value,
atomic_long_try_cmpxchg_acquire/release invoked on &mutex.owner will
return false. Then we need to reassign the temporary variable which
saves mutex.owner value if in loop, or it will lead an endless loop.

Fixes: 9265e48a579d ("locking/mutex: Use try_cmpxchg()")

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
  kernel/locking/mutex.c | 15 ++++++++-------
  1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5e6a811ac733..ec6b6724c118 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -95,12 +95,12 @@ static inline unsigned long __owner_flags(unsigned 
long owner)

  static inline struct task_struct *__mutex_trylock_common(struct mutex 
*lock, bool handoff)
  {
-       unsigned long owner, curr = (unsigned long)current;
+       unsigned long flags, owner, task, curr = (unsigned long)current;

-       owner = atomic_long_read(&lock->owner);
         for (;;) { /* must loop, can race against a flag */
-               unsigned long flags = __owner_flags(owner);
-               unsigned long task = owner & ~MUTEX_FLAGS;
+               owner = atomic_long_read(&lock->owner);
+               flags = __owner_flags(owner);
+               task = owner & ~MUTEX_FLAGS;

                 if (task) {
                         if (flags & MUTEX_FLAG_PICKUP) {
@@ -231,10 +231,10 @@ __mutex_remove_waiter(struct mutex *lock, struct 
mutex_waiter *waiter)
   */
  static void __mutex_handoff(struct mutex *lock, struct task_struct *task)
  {
-       unsigned long owner = atomic_long_read(&lock->owner);
+       unsigned long owner, new;

         for (;;) {
-               unsigned long new;
+               owner = atomic_long_read(&lock->owner);

                 MUTEX_WARN_ON(__owner_task(owner) != current);
                 MUTEX_WARN_ON(owner & MUTEX_FLAG_PICKUP);
@@ -1227,8 +1227,9 @@ static noinline void __sched 
__mutex_unlock_slowpath(struct mutex *lock, unsigne
          * Except when HANDOFF, in that case we must not clear the 
owner field,
          * but instead set it to the top waiter.
          */
-       owner = atomic_long_read(&lock->owner);
         for (;;) {
+               owner = atomic_long_read(&lock->owner);
+
                 MUTEX_WARN_ON(__owner_task(owner) != current);
                 MUTEX_WARN_ON(owner & MUTEX_FLAG_PICKUP);

-- 
2.29.2
