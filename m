Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF89376636
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 15:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbhEGNeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 09:34:04 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:25331 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234545AbhEGNeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 09:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1620394381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JP6LVVoBRNQ+1992UMXKWG+/IakDX8oJNasx74lVNnc=;
        b=S6sp8dTUusSk/6kt6O/PrLiOJ/vG1ZhEKtQB0om+FdLFQcuvsQqRmr3PI4fWX9xUMUgFFX
        2ZjQx7gJpySNZDNWjJgin5USGB8rb7Y6VEerglzqNZUHO+/rDymOrTKEWRU5ZFMUA3cLSq
        1ISdJjoYn91BouSFh3wI2SnITt6VaXc=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-18-wJV3rJAgMje7COe0Baft5Q-1; Fri, 07 May 2021 15:33:00 +0200
X-MC-Unique: wJV3rJAgMje7COe0Baft5Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJTtLiYV3LAEEyw4e9mLNQvYwzk/9XYZe1T/RGQ/ct4gLdhpLvvSiW5ZKsQbYNdsTHdDcrjW/eeeJzTSub8nQg/BS6v8x/A9xTI/69QcisZqLNz7GYSTPZPTuzZat1e9rGQMVOvRja89zr2SuD2ki81l3sajoGl4jsD1blbtie65U5ZYIIcCNsWmwarRfjngoSN+AzOAkBzGz6Z4h4Pz8Vx9mqdG49MkvUHZcoGU7V0v01spCpAoNYO8svTwhqF0AcBryTKu3mHrGv05+ncdPWCMY63z+o6CSjkdTqQiMBCeX3Tabdn9k5B//qyeYQX8aZxwEFztw5Wfo4bzlSMlfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZRRDJB5smId83PO/zzsRiLZxKMwAC4n7S9k4yzmry8=;
 b=Xh6mmkqNdweMAXXXgZyxYWq0VAw0oh2MlTqmanjZXPb9/JD3120aPmEfkiFyZq94LnuS9L/8N/J8o9wS/4rhRnDLlxnUXhpTNeHSF4MD30oSFREZwiLO+DmSHNUvC1YDCFxbteA2ak/uBs5sfCrNR39JDu76zfK8B9CkI05BWPetHKpdy/3xirWo3SqhOeaaVPeirVQJfeOfoo7CmEXAxQotnyc/Gvv0YoBfSH6GpXfrZtA4SXIxm5vMBoHnV5fvI5SsVTAd9MIFLaHkgPpIqL/a4B9IEBm/514G5XtRTIB/cVYlGyGeKQ0ljtcgwizt7Z50wg1w4Hk+bz7T82OxgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com (2603:10a6:208:128::18)
 by AM0PR04MB6771.eurprd04.prod.outlook.com (2603:10a6:208:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Fri, 7 May
 2021 13:32:59 +0000
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::756a:86b8:8283:733d]) by AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::756a:86b8:8283:733d%6]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 13:32:59 +0000
To:     Hillf Danton <hdanton@sina.com>
CC:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>
References: <20210506065621.9292-1-varad.gautam@suse.com>
 <20210506091839.2380-1-hdanton@sina.com>
 <20210507032418.2518-1-hdanton@sina.com>
From:   Varad Gautam <varad.gautam@suse.com>
Subject: Re: [PATCH v2] ipc/mqueue: Avoid relying on a stack reference past
 its expiry
Message-ID: <95688538-1ca8-9e7f-d9ea-4339f5bdc247@suse.com>
Date:   Fri, 7 May 2021 15:32:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210507032418.2518-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [95.90.93.216]
X-ClientProxiedBy: AM4PR0302CA0006.eurprd03.prod.outlook.com
 (2603:10a6:205:2::19) To AM0PR04MB5650.eurprd04.prod.outlook.com
 (2603:10a6:208:128::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.77.188] (95.90.93.216) by AM4PR0302CA0006.eurprd03.prod.outlook.com (2603:10a6:205:2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Fri, 7 May 2021 13:32:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59d26e75-ecd2-4ad6-21f5-08d9115ca119
X-MS-TrafficTypeDiagnostic: AM0PR04MB6771:
X-Microsoft-Antispam-PRVS: <AM0PR04MB677122E602AC2E0840686977E0579@AM0PR04MB6771.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99YiR5unVOi19MSuiIHKElYXcCBo4rW6kY3KYnrj1CtWYbW5oBxMWl7PaYdOi7vVj2Gl/CFmaDW2z5YTAtdyrgAXc4dpwRBZuhyFhFFD2+tLzn+EsnLPzcr8B8wcKDc/lALd4BkLoKOfe1k2H3S1cRMXKSFtMi2C4FhSXQHQBX0ClAKOSacm+NIi/u1fa8LLkjIPdTWHSMYwuVRh7IoR6sxP3eq0FQQ+K/jvYIzJuECw+0jCR+SUD3ipzBasN/vU5Kuyp9uAR7RfyVkNtRNAv7zLsJJ7f+czYnsb2qYrcJDvGAOqJ2znw6gHUOvazyH6EPZ3TiR2r2ifs0zPEKdsjmMBDWUEESXYKFwXDom5pVDGE/9KTx4QAn5GS2R26f0EumPMJFhb7yEpPk1svkKOMUqLc7kqtfZGdL9+fAEHLOHHGr9hYvc5SgeUPYfY6bOu5lyJu+fQd4l4saVnJG0A982WFMVDqJ20iLbfg4vvD6aCyxxQ8T2Ucm16fKO/HkWXjVEWzcKCXhqNw9NrX92nQ3ZsHA528K4NMpaKONgNh3PKLUwnMIH98pq+rkjCqrJnTchgklT/GdhBgP7FuvJnKryg3I3XhcHHuCnU8xzS/f33oNGGFCy3fRBd9SN9qMujDV03N+TMp2f9h8ZnCtSE3qUF3NvrQyNO/IYKbpBIKhz6wqDU/jBFyBlWtHLfIHdGCsLA2vf4apSQQlq16F7z5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5650.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39850400004)(346002)(396003)(376002)(38350700002)(52116002)(38100700002)(36756003)(66946007)(83380400001)(66574015)(6666004)(31696002)(4326008)(26005)(5660300002)(316002)(16576012)(478600001)(66476007)(8936002)(66556008)(956004)(16526019)(54906003)(2906002)(44832011)(53546011)(186003)(2616005)(6916009)(8676002)(6486002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AoP3Ha1mfy7RuJHtVI6VjtRBcdejaXsiqsHqnOOt7PhqRfbA8uXmQO3CSiQg?=
 =?us-ascii?Q?LDiY9NWAb02SaqRwXRkrUpxyLMCouK0KL+KSheieqi+hdZUgpIlfm8NJqpIV?=
 =?us-ascii?Q?O5F/Srf2WD81GpvOP6/zjjPh5wfA9q5/5zlQclj8WU+j6WZUnBt++cz1k8ae?=
 =?us-ascii?Q?mCRnRycfjkqgALNwW1T1MVyCARr8YBoFzEmag8/dO8UFF9UQzr0cMUYxrhEn?=
 =?us-ascii?Q?BmpstV9AZEfsmf4OTm/tgfbcElA+v0PbRKqi2ccwYHe+Sx87HuXeK1l3IobD?=
 =?us-ascii?Q?t+vF2o2qF6E+HYHrekAU8zb8stTmccKIxf0Tf1R2YFwkAcqW49dnttbFdR9B?=
 =?us-ascii?Q?ZV+MU/OlMPsn3eLwUk4LgleAk353grYdAAzaTYSJqUO0ZajEwOpwc6rUMbEq?=
 =?us-ascii?Q?1SbayPYHVCco8cA+KkSUK1Sy9VKgNwSadF7X7pD0GIgGrRjPG5anFnFpkO65?=
 =?us-ascii?Q?ZQu7QXbTkzrqOlpnr8utU7cs5A8lBCBaM66cV2GTx0Txhic6/vcgBFzyG2yu?=
 =?us-ascii?Q?sTEqcM0e1veXX0LNrejyH4Bg42X1LmYZh4Anmsoi/DKDyCvJK5qFXUnGuH7+?=
 =?us-ascii?Q?lsI9XANFv/vfW7maW02ITwlbtxPYa/WmEbjGKncYApU9Y94azSefSXh05Oqy?=
 =?us-ascii?Q?bqhg2xKbbjrXGUPavOPv4BIg7HGlfCAfj4qI/1PyN8XRVp4jYTYQNxEZ8i2w?=
 =?us-ascii?Q?iMlQqm3XR2NxqPwwmDxMbYCG6UkrTp1TTpnQ/Ha2lQO/VGRwb2GRkoT17s6i?=
 =?us-ascii?Q?A9It/A4K7fa+pJB9CmQCotEjMWMzUKpBM2QI+6YRfIRi7WBzLkQ0Whf2zxPP?=
 =?us-ascii?Q?oXJBbi10acfT284fX/9/iLSeaa/nF5+kLHcLZ2BsheScdfFWHCvo2Wi6v+Gr?=
 =?us-ascii?Q?w4oQwC9cbSMrve4ljn9o3dCDiG/1GcrYGhS1RJ9ftXMssHeDR2Sj4LjQrkX9?=
 =?us-ascii?Q?juN/Joiba9mcWMJO5PAK3qo0kTD4d3qWAKlgBsKuSD6hGnrX+BuWV8qiISsv?=
 =?us-ascii?Q?Wa77gElNAIkmgiuYrFfEhRC+EZdCB9WiwyA2iEw/RWVZss5LvCp28Fjs0W/N?=
 =?us-ascii?Q?kj3dliFATUr0dXX6Mun8wS8GUo3MTld/KQ+E/fApuj0gHSjsnaylCxd3VOKo?=
 =?us-ascii?Q?SepBulKwNeJ49rHo7MjLkyPQtTNk0atl0RegS0kean8oX76SyYTtRHWPaJPF?=
 =?us-ascii?Q?Zv7JCSw97LZUsIu/umX5yxLgXqAv/zPClGDd4Gzfn4BVaE7M2qaZH63OCtUC?=
 =?us-ascii?Q?RrHoo7Ev6K969502fi3N5rU+Gp4XIts5IZve/RwiVUtQJbVAYp2m9R/op3lN?=
 =?us-ascii?Q?b0Yxz3t4aJgn2iqm4rdzJGbq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d26e75-ecd2-4ad6-21f5-08d9115ca119
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5650.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 13:32:58.9356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynd/hajuaJkOJ+0u4EhuwNUgZi/mlXF881RVZboDNXy6x/QEDi1iN4WrX6gprCvivpS5cmZMEZtFUTKr/ZSE9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6771
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

On 5/7/21 5:24 AM, Hillf Danton wrote:
> On Thu, 6 May 2021 12:33:56 Varad Gautam wrote:
>> On 5/6/21 11:18 AM, Hillf Danton wrote:
>>> On Thu,  6 May 2021 08:56:19
>>>> do_mq_timedreceive calls wq_sleep with a stack local address. The
>>>> sender (do_mq_timedsend) uses this address to later call
>>>> pipelined_send.
>>>>
>>>> This leads to a very hard to trigger race where a do_mq_timedreceive c=
al=3D
>> l
>>>> might return and leave do_mq_timedsend to rely on an invalid address,
>>>> causing the following crash:
>>>>
>>>> [  240.739977] RIP: 0010:wake_q_add_safe+0x13/0x60
>>>> [  240.739991] Call Trace:
>>>> [  240.739999]  __x64_sys_mq_timedsend+0x2a9/0x490
>>>> [  240.740003]  ? auditd_test_task+0x38/0x40
>>>> [  240.740007]  ? auditd_test_task+0x38/0x40
>>>> [  240.740011]  do_syscall_64+0x80/0x680
>>>> [  240.740017]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>> [  240.740019] RIP: 0033:0x7f5928e40343
>>>>
>>>> The race occurs as:
>>>>
>>>> 1. do_mq_timedreceive calls wq_sleep with the address of
>>>> `struct ext_wait_queue` on function stack (aliased as `ewq_addr` here)
>>>> - it holds a valid `struct ext_wait_queue *` as long as the stack has
>>>> not been overwritten.
>>>>
>>>> 2. `ewq_addr` gets added to info->e_wait_q[RECV].list in wq_add, and
>>>> do_mq_timedsend receives it via wq_get_first_waiter(info, RECV) to cal=
l
>>>> __pipelined_op.
>>>>
>>>> 3. Sender calls __pipelined_op::smp_store_release(&this->state, STATE_=
RE=3D
>> ADY=3D
>>>> ).
>>>> Here is where the race window begins. (`this` is `ewq_addr`.)
>>>>
>>>> 4. If the receiver wakes up now in do_mq_timedreceive::wq_sleep, it
>>>> will see `state =3D=3D STATE_READY` and break. `ewq_addr` gets remov=
=3D
>> ed from
>>>> info->e_wait_q[RECV].list.
>>>>
>>>> 5. do_mq_timedreceive returns, and `ewq_addr` is no longer guaranteed
>>>> to be a `struct ext_wait_queue *` since it was on do_mq_timedreceive's
>>>> stack. (Although the address may not get overwritten until another
>>>> function happens to touch it, which means it can persist around for an
>>>> indefinite time.)
>>>>
>>>> 6. do_mq_timedsend::__pipelined_op() still believes `ewq_addr` is a
>>>> `struct ext_wait_queue *`, and uses it to find a task_struct to pass
>>>> to the wake_q_add_safe call. In the lucky case where nothing has
>>>> overwritten `ewq_addr` yet, `ewq_addr->task` is the right task_struct.
>>>> In the unlucky case, __pipelined_op::wake_q_add_safe gets handed a
>>>> bogus address as the receiver's task_struct causing the crash.
>>>>
>>>> do_mq_timedsend::__pipelined_op() should not dereference `this` after
>>>> setting STATE_READY, as the receiver counterpart is now free to return=
.
>>>> Change __pipelined_op to call wake_q_add before setting STATE_READY
>>>> which ensures that the receiver's task_struct can still be found via
>>>> `this`.
>>>>
>>>> Fixes: c5b2cbdbdac563 ("ipc/mqueue.c: update/document memory barriers"=
)
>>>> Signed-off-by: Varad Gautam <varad.gautam@suse.com>
>>>> Reported-by: Matthias von Faber <matthias.vonfaber@aox-tech.de>
>>>> Cc: <stable@vger.kernel.org> # 5.6
>>>> Cc: Christian Brauner <christian.brauner@ubuntu.com>
>>>> Cc: Oleg Nesterov <oleg@redhat.com>
>>>> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
>>>> Cc: Manfred Spraul <manfred@colorfullife.com>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Davidlohr Bueso <dbueso@suse.de>
>>>> ---
>>>> v2: Call wake_q_add before smp_store_release, instead of using a
>>>>     get_task_struct/wake_q_add_safe combination across
>>>>     smp_store_release. (Davidlohr Bueso)
>>>>
>>>>  ipc/mqueue.c | 33 ++++++++++++++++++++++++---------
>>>>  1 file changed, 24 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
>>>> index 8031464ed4ae..bfcb6f81a824 100644
>>>> --- a/ipc/mqueue.c
>>>> +++ b/ipc/mqueue.c
>>>> @@ -78,11 +78,13 @@ struct posix_msg_tree_node {
>>>>   * MQ_BARRIER:
>>>>   * To achieve proper release/acquire memory barrier pairing, the stat=
e =3D
>> is =3D
>>>> set to
>>>>   * STATE_READY with smp_store_release(), and it is read with READ_ONC=
E =3D
>> fol=3D
>>>> lowed
>>>> - * by smp_acquire__after_ctrl_dep(). In addition, wake_q_add_safe() i=
s =3D
>> use=3D
>>>> d.
>>>> + * by smp_acquire__after_ctrl_dep(). The state change to STATE_READY =
mu=3D
>> st =3D
>>>> be
>>>> + * the last write operation, after which the blocked task can immedia=
te=3D
>> ly
>>>> + * return and exit.
>>>>   *
>>>>   * This prevents the following races:
>>>>   *
>>>> - * 1) With the simple wake_q_add(), the task could be gone already be=
fo=3D
>> re
>>>> + * 1) With wake_q_add(), the task could be gone already before
>>>>   *    the increase of the reference happens
>>>>   * Thread A
>>>>   *				Thread B
>>>> @@ -97,10 +99,25 @@ struct posix_msg_tree_node {
>>>>   * sys_exit()
>>>>   *				get_task_struct() // UaF
>>>>   *
>>>> - * Solution: Use wake_q_add_safe() and perform the get_task_struct() =
be=3D
>> for=3D
>>>> e
>>>> - * the smp_store_release() that does ->state =3D STATE_READY.
>>>> + * 2) With wake_q_add(), the receiver task could have returned from t=
he
>>>> + *    syscall and had its stack-allocated waiter overwritten before t=
he
>>>> + *    sender could add it to the wake_q
>>>> + * Thread A
>>>> + *				Thread B
>>>> + * WRITE_ONCE(wait.state, STATE_NONE);
>>>> + * schedule_hrtimeout()
>>>> + *				->state =3D STATE_READY
>>>> + * <timeout returns>
>>>> + * if (wait.state =3D=3D STATE_READY) return;
>>>> + * sysret to user space
>>>> + * overwrite receiver's stack
>>>> + *				wake_q_add(A)
>>>> + *				if (cmpxchg()) // corrupted waiter
>>>>   *
>>>> - * 2) Without proper _release/_acquire barriers, the woken up task
>>>> + * Solution: Queue the task for wakeup before the smp_store_release()=
 t=3D
>> hat
>>>> + * does ->state =3D STATE_READY.
>>>> + *
>>>> + * 3) Without proper _release/_acquire barriers, the woken up task
>>>>   *    could read stale data
>>>>   *
>>>>   * Thread A
>>>> @@ -116,7 +133,7 @@ struct posix_msg_tree_node {
>>>>   *
>>>>   * Solution: use _release and _acquire barriers.
>>>>   *
>>>> - * 3) There is intentionally no barrier when setting current->state
>>>> + * 4) There is intentionally no barrier when setting current->state
>>>>   *    to TASK_INTERRUPTIBLE: spin_unlock(&info->lock) provides the
>>>>   *    release memory barrier, and the wakeup is triggered when holdin=
g
>>>>   *    info->lock, i.e. spin_lock(&info->lock) provided a pairing
>>>> @@ -1005,11 +1022,9 @@ static inline void __pipelined_op(struct wake_q=
_h=3D
>> ead=3D
>>>>  *wake_q,
>>>>  				  struct ext_wait_queue *this)
>>>>  {
>>>>  	list_del(&this->list);
>>>> -	get_task_struct(this->task);
>>>> -
>>>> +	wake_q_add(wake_q, this->task);
>>>>  	/* see MQ_BARRIER for purpose/pairing */
>>>>  	smp_store_release(&this->state, STATE_READY);
>>>> -	wake_q_add_safe(wake_q, this->task);
>>>>  }
>>>
>>> Given the smp_mb() in __wake_q_add(), and more crucially the position o=
f
>>> wake_q_add() corrected in this work, that mb helps prevent waiter from
>>> reading stale data at least in case of pipelined_send(). Update comment
>>> if that is true.
>>>
>>
>> This race IIUC is covered by 3) under MQ_BARRIER after this patch. But
>> instead of the smp_mb() in __wake_q_add(), it is guarded by the use of
>> smp_store_release(STATE_READY), which ensures that the waiter only sees
>> STATE_READY after wake_q_add and after updating receiver->msg in
>> pipelined_send().
>=20
> Even after this work, if I dont misread you, waiter takes care only for
> READY and nothing more; otherwise feel free to show the reasons why
> wake_q_add is a concern for instance on the waiter side, because READY
> does nothing to prevent a waiter from going home and timeout can arrive
> with no idea of wake_q_add.
>=20
> Given that wake_q_add wont make sense without wakeup on the waker side,
> what is the win by requiring the order in between READY and wake_q_add
> before wakeup?
>=20

If the waiter timed out and did not see STATE_READY, it will spin on
info->lock before exiting.

If it saw STATE_READY, it will exit and leave the waker with an invalid
parameter in __pipelined_op.

Thanks,
Varad

> Hillf
>=20

--=20
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 N=C3=BCrnberg
Germany

HRB 36809, AG N=C3=BCrnberg
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer

