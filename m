Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E053375268
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhEFKfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:35:03 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:33180 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234443AbhEFKfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1620297242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=raMVzE9PatJ2ViIWvzcxkzJ04YUQ615n4IFa1A849eY=;
        b=KPJ8CT58Bls+rcMIesyYo922gxMaDtb5H0a/3z6A8L0UoCvAAONa6CuguwMqKsL3WDnOH+
        zbYveRFqK2MKJ2tsbebRS0y+AhZ+gcEh1fKDDHcGawz7B6H0wfda3TxE1kIV4LgtxPoGxl
        l+0gJWvKkT8gWRnclXOJHiFFR6utMpU=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2059.outbound.protection.outlook.com [104.47.6.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-33-r60tH4_eMy6lB37fAu5sLg-1; Thu, 06 May 2021 12:34:01 +0200
X-MC-Unique: r60tH4_eMy6lB37fAu5sLg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfK0ynhoxWkaBynZtTlfhxH6h96o3X7LEhzYxXo96Pn30K8VjxZnHa763JbEeEHLUqfVm9DpYye/5rXp57WYwXPoOSihpQ1caHFQL4pZtm6bcCwoSOVNpxlCPDZg7U5QfY+IGqmovk2+TEXggBIpxHnCbxJcQ3ea7SxeH8U/IlrO9nfGFql/eTm3Cj/jlT7/D1RDOj6PNJNfCwrkflWUJK67si2yTXr8//rctZHI4qEBunD103vUM7x5eBef8t7aWUq+kpfIed8qYKE8fNMrGqi0DOoakfxLt+RyQzl/bZ0JO1a4GgywoVArGfE++qOLxZlF7S2svZ7YBsM5Db1Q2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0X7BRMquziibbV8munmA6gBl6WrmtMm/0QwzMAfPrPI=;
 b=MjEx/7AGW9BGikRzBSf1m7aa46PYpTWodvToCOmFi2NC1PTGahThDrSms+YY6Fy4/1UjZnTvc8R6IdTT+mviYZLWhaLpjKXmurG0ULBLM0B2ANdQ9sW1pwsxWQU0fGCvLtDLybYchvBf8yDP0lFS8HGLQhjBJistgL28DH0axfQVq1HENCnm/wuEUTEeNdiF65bwYphMfEEOrWC041xmH0Dn8XmbfixH1OCukL8VK5dPStTMLACjLcXElVfx0AaEonio3W7Bxeew1+vzmitdd3ixvLdGZnfe87uWj4MfNwuy3/DQa41Rk8HIlSoyFdMrUiS8GnRLTvae/he3rLWhqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com (2603:10a6:208:128::18)
 by AM0PR04MB5313.eurprd04.prod.outlook.com (2603:10a6:208:c7::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.44; Thu, 6 May
 2021 10:34:00 +0000
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::756a:86b8:8283:733d]) by AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::756a:86b8:8283:733d%6]) with mapi id 15.20.4108.027; Thu, 6 May 2021
 10:34:00 +0000
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
From:   Varad Gautam <varad.gautam@suse.com>
Subject: Re: [PATCH v2] ipc/mqueue: Avoid relying on a stack reference past
 its expiry
Message-ID: <4a021d0f-23cf-2554-a692-a853450b43a3@suse.com>
Date:   Thu, 6 May 2021 12:33:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210506091839.2380-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [95.90.93.216]
X-ClientProxiedBy: FR3P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::21) To AM0PR04MB5650.eurprd04.prod.outlook.com
 (2603:10a6:208:128::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.77.47] (95.90.93.216) by FR3P281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.12 via Frontend Transport; Thu, 6 May 2021 10:33:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2300bcf-ab40-45c7-7a72-08d9107a75d5
X-MS-TrafficTypeDiagnostic: AM0PR04MB5313:
X-Microsoft-Antispam-PRVS: <AM0PR04MB5313CDEABFB8EE7BBB91A7BEE0589@AM0PR04MB5313.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4c2jgsIWhooqH00N5P/VPT7GjolSqI9o9E2I4igugC95pU92kT9Z6T7HjfagEBKH0MgdUlidWo4oCSsblbnHJykXGkiv+bwotLiTm0+k3MGxd/vYQUodyPm3LAcsMuX15q5ugAmLjSY7ArU+FRGTx9reci0SZx+7m4/TvyXhWgv5yBJAEXXgJMq71J57vC30gaBCsRtGQqtIyNZ3qm2gfTJSwe5WBr8tM9Rb8Tr20L/P2Nhx7GwWCOAokVMAA+hFtEyhQ84brdzzJ6R4nDkCVFcSfM90+XX5KeA52bXMychsjsAiEpi5KLgIbAAdrMcnrOJfFoivlyP6vz9JhB8A+MPgFyIOeVPyNjFN8Xme5izLua1ro3h4rGypHtsFXheYZG2AQ1nApLepU3AchIqEti3DTCaGdlU2fqN9aax8aALuylr486KkOjfMmkVlAleZrZqYw597Ob3EqHO4RlLs8IFwHNYoWtGEMiPQfEQUCHZjjKS0Qi7xQRhVrP/n/wwXUS5iYf6GH8INPi8CQwZP7tV4g1hJ4oSgXU/Z4psq1xvRI2so83fwO+a8jjr+Mfh8PM2RZMRXPMa7S7bB47WEy01TUXbF/1omvO1FBAJ7nydS86Ot3rxUy7MS13rlMiIgSeLuPfVWuWwyQ/esJqOOS9DfK4yWQavfPJ78WkMLiLRWLKzi0lZmn7uYXB5f70e8H23JToI9GgJpLIatRtype1mcVE9pG5z5Mh+CtdjnPbe/dSTwbFZ503aLUaaCVI1p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5650.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(136003)(39860400002)(36756003)(83380400001)(38100700002)(31686004)(16526019)(6916009)(31696002)(53546011)(6666004)(16576012)(38350700002)(2906002)(26005)(66574015)(54906003)(316002)(44832011)(2616005)(6486002)(4326008)(8676002)(8936002)(66946007)(478600001)(66556008)(86362001)(5660300002)(186003)(66476007)(956004)(52116002)(43740500002)(45980500001)(299355004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WLxC5a5BAdWPZYHlM68iksO7kCigWSq+LhkHTugbWNyY/pOmX0F1cwYOfygA?=
 =?us-ascii?Q?EOQ51IVWuW5MZBgTqt9xIf317J73nJRv10U1xFZvMiPaCUUTOvD81lpMpENG?=
 =?us-ascii?Q?8c20M/CKC8vmljLtp7IjiErcDUI0CQyHx9pfiUxpP1uV36BAnZj7e/5TEemY?=
 =?us-ascii?Q?TPEQHOkjv2XbYfWieKHUoMdstmrNP74BrodhZ4OscU0Aa9YB/ozIaI68atmh?=
 =?us-ascii?Q?WUDD4dh4RU7rwPJTM72J1mus/1/FOD91HxckrYfM/q6qBifBwps1frBNGVO6?=
 =?us-ascii?Q?cl7yQPsW9+stwOTBt/uxXlgwATghd2COs1tm2OHZIqw6PKuNHM0EcMw86c4u?=
 =?us-ascii?Q?o/g4RYY26Lj4Ba/LOiZ61yaV8xtxpr/5Ke+Ilk9og6Gk7iNrgNaH286v0s5H?=
 =?us-ascii?Q?Zh9ZsTjWIRUYGm3Q7LAfU2caddUIE1O2nxg/tzhP0OsC5pgiCRfI1Qni9T9I?=
 =?us-ascii?Q?mTgvuinoknWosgLTS8dLABnPrZ6GVysA5SqwyT6H/o25BdVZv8JkfPQxslJg?=
 =?us-ascii?Q?ovgaIjsRchmfJTvOBs3VGyUoGVTX53kICvHX87YUlPNK0qTVOVAMrjxyMpGJ?=
 =?us-ascii?Q?9co5p7ixUKHxC2K9cYZe4Fexw5BkVNBxXKnJWvgJ7y8fAw44l8QdVBoqYlHo?=
 =?us-ascii?Q?W3kHKKZ8MGrXLEWJMRdjF6SXdoyXDHEpZdPp/N0TSxRiKdHcjSyVWmoB9snT?=
 =?us-ascii?Q?zZhjJ0nzcjaZKqsdl5L4z6cV+ynGPmKXHWrJChBvTjGPxZKHHHJHRe1XhgvH?=
 =?us-ascii?Q?udm32q3Tbh1idHZ2eyUYQDCSFbOEa8VwjS99k60XXhD3iVQ2nLi+9D2N5nTp?=
 =?us-ascii?Q?wIWbGjkdjuF4S7RC8RUKc36BS9LmVCzjLEkr/bMzNC3lpbk7HyFJu0/pePoh?=
 =?us-ascii?Q?1FAAoq+IQSbEAhN5kF+nUH492wKn18rEEyTn9PAbFolHc/7EyNte0EkgFrja?=
 =?us-ascii?Q?4VfaMLZgElFZRXBBw5WidbGXTbugL/9WvEMYOaUBQ792jDjbKEodWamn7nAB?=
 =?us-ascii?Q?wRvXoRDBt6P6NPbHHNBOyzjGn6T6eOaA/QKRcpfCpwZdcfJbHbP9pcRXVD5P?=
 =?us-ascii?Q?x5xfIA90GhfYVRn6h8Ah300gsgwCaXumYjG1RfOayx9KWRrGB6CMKKxaNT4+?=
 =?us-ascii?Q?uCtFii9sKC3cUbDcx831nRajeBDEVRlOIFoUa2XHMtd9l9NjuNXzffHw/Jjq?=
 =?us-ascii?Q?jJp8/mNsDzMJI96WKqDO/k8gGvBtkngUmw7WBDgw2MYfmlr41y0U/+efYM+m?=
 =?us-ascii?Q?B1jkpuBRFhgWBxuNpkv7ZFPBVa9FodjV5kaXVweSJcZkyDXu1EnYPIXZoCJe?=
 =?us-ascii?Q?dDLukrEzCkhU38l79u4hfvod?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2300bcf-ab40-45c7-7a72-08d9107a75d5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5650.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 10:33:59.9994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z18d7T8j7B/0E9HHxOUNxR9e2DoRgJH5ClqA9ZYugZjlMQaBBne0z4GVlr1BuVknv+JVuyduAbDaDsQWGqJFSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5313
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/21 11:18 AM, Hillf Danton wrote:
> On Thu,  6 May 2021 08:56:19=20
>> do_mq_timedreceive calls wq_sleep with a stack local address. The
>> sender (do_mq_timedsend) uses this address to later call
>> pipelined_send.
>>
>> This leads to a very hard to trigger race where a do_mq_timedreceive cal=
l
>> might return and leave do_mq_timedsend to rely on an invalid address,
>> causing the following crash:
>>
>> [  240.739977] RIP: 0010:wake_q_add_safe+0x13/0x60
>> [  240.739991] Call Trace:
>> [  240.739999]  __x64_sys_mq_timedsend+0x2a9/0x490
>> [  240.740003]  ? auditd_test_task+0x38/0x40
>> [  240.740007]  ? auditd_test_task+0x38/0x40
>> [  240.740011]  do_syscall_64+0x80/0x680
>> [  240.740017]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [  240.740019] RIP: 0033:0x7f5928e40343
>>
>> The race occurs as:
>>
>> 1. do_mq_timedreceive calls wq_sleep with the address of
>> `struct ext_wait_queue` on function stack (aliased as `ewq_addr` here)
>> - it holds a valid `struct ext_wait_queue *` as long as the stack has
>> not been overwritten.
>>
>> 2. `ewq_addr` gets added to info->e_wait_q[RECV].list in wq_add, and
>> do_mq_timedsend receives it via wq_get_first_waiter(info, RECV) to call
>> __pipelined_op.
>>
>> 3. Sender calls __pipelined_op::smp_store_release(&this->state, STATE_RE=
ADY=3D
>> ).
>> Here is where the race window begins. (`this` is `ewq_addr`.)
>>
>> 4. If the receiver wakes up now in do_mq_timedreceive::wq_sleep, it
>> will see `state =3D3D=3D3D STATE_READY` and break. `ewq_addr` gets remov=
ed from
>> info->e_wait_q[RECV].list.
>>
>> 5. do_mq_timedreceive returns, and `ewq_addr` is no longer guaranteed
>> to be a `struct ext_wait_queue *` since it was on do_mq_timedreceive's
>> stack. (Although the address may not get overwritten until another
>> function happens to touch it, which means it can persist around for an
>> indefinite time.)
>>
>> 6. do_mq_timedsend::__pipelined_op() still believes `ewq_addr` is a
>> `struct ext_wait_queue *`, and uses it to find a task_struct to pass
>> to the wake_q_add_safe call. In the lucky case where nothing has
>> overwritten `ewq_addr` yet, `ewq_addr->task` is the right task_struct.
>> In the unlucky case, __pipelined_op::wake_q_add_safe gets handed a
>> bogus address as the receiver's task_struct causing the crash.
>>
>> do_mq_timedsend::__pipelined_op() should not dereference `this` after
>> setting STATE_READY, as the receiver counterpart is now free to return.
>> Change __pipelined_op to call wake_q_add before setting STATE_READY
>> which ensures that the receiver's task_struct can still be found via
>> `this`.
>>
>> Fixes: c5b2cbdbdac563 ("ipc/mqueue.c: update/document memory barriers")
>> Signed-off-by: Varad Gautam <varad.gautam@suse.com>
>> Reported-by: Matthias von Faber <matthias.vonfaber@aox-tech.de>
>> Cc: <stable@vger.kernel.org> # 5.6
>> Cc: Christian Brauner <christian.brauner@ubuntu.com>
>> Cc: Oleg Nesterov <oleg@redhat.com>
>> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
>> Cc: Manfred Spraul <manfred@colorfullife.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Davidlohr Bueso <dbueso@suse.de>
>> ---
>> v2: Call wake_q_add before smp_store_release, instead of using a
>>     get_task_struct/wake_q_add_safe combination across
>>     smp_store_release. (Davidlohr Bueso)
>>
>>  ipc/mqueue.c | 33 ++++++++++++++++++++++++---------
>>  1 file changed, 24 insertions(+), 9 deletions(-)
>>
>> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
>> index 8031464ed4ae..bfcb6f81a824 100644
>> --- a/ipc/mqueue.c
>> +++ b/ipc/mqueue.c
>> @@ -78,11 +78,13 @@ struct posix_msg_tree_node {
>>   * MQ_BARRIER:
>>   * To achieve proper release/acquire memory barrier pairing, the state =
is =3D
>> set to
>>   * STATE_READY with smp_store_release(), and it is read with READ_ONCE =
fol=3D
>> lowed
>> - * by smp_acquire__after_ctrl_dep(). In addition, wake_q_add_safe() is =
use=3D
>> d.
>> + * by smp_acquire__after_ctrl_dep(). The state change to STATE_READY mu=
st =3D
>> be
>> + * the last write operation, after which the blocked task can immediate=
ly
>> + * return and exit.
>>   *
>>   * This prevents the following races:
>>   *
>> - * 1) With the simple wake_q_add(), the task could be gone already befo=
re
>> + * 1) With wake_q_add(), the task could be gone already before
>>   *    the increase of the reference happens
>>   * Thread A
>>   *				Thread B
>> @@ -97,10 +99,25 @@ struct posix_msg_tree_node {
>>   * sys_exit()
>>   *				get_task_struct() // UaF
>>   *
>> - * Solution: Use wake_q_add_safe() and perform the get_task_struct() be=
for=3D
>> e
>> - * the smp_store_release() that does ->state =3D3D STATE_READY.
>> + * 2) With wake_q_add(), the receiver task could have returned from the
>> + *    syscall and had its stack-allocated waiter overwritten before the
>> + *    sender could add it to the wake_q
>> + * Thread A
>> + *				Thread B
>> + * WRITE_ONCE(wait.state, STATE_NONE);
>> + * schedule_hrtimeout()
>> + *				->state =3D3D STATE_READY
>> + * <timeout returns>
>> + * if (wait.state =3D3D=3D3D STATE_READY) return;
>> + * sysret to user space
>> + * overwrite receiver's stack
>> + *				wake_q_add(A)
>> + *				if (cmpxchg()) // corrupted waiter
>>   *
>> - * 2) Without proper _release/_acquire barriers, the woken up task
>> + * Solution: Queue the task for wakeup before the smp_store_release() t=
hat
>> + * does ->state =3D3D STATE_READY.
>> + *
>> + * 3) Without proper _release/_acquire barriers, the woken up task
>>   *    could read stale data
>>   *
>>   * Thread A
>> @@ -116,7 +133,7 @@ struct posix_msg_tree_node {
>>   *
>>   * Solution: use _release and _acquire barriers.
>>   *
>> - * 3) There is intentionally no barrier when setting current->state
>> + * 4) There is intentionally no barrier when setting current->state
>>   *    to TASK_INTERRUPTIBLE: spin_unlock(&info->lock) provides the
>>   *    release memory barrier, and the wakeup is triggered when holding
>>   *    info->lock, i.e. spin_lock(&info->lock) provided a pairing
>> @@ -1005,11 +1022,9 @@ static inline void __pipelined_op(struct wake_q_h=
ead=3D
>>  *wake_q,
>>  				  struct ext_wait_queue *this)
>>  {
>>  	list_del(&this->list);
>> -	get_task_struct(this->task);
>> -
>> +	wake_q_add(wake_q, this->task);
>>  	/* see MQ_BARRIER for purpose/pairing */
>>  	smp_store_release(&this->state, STATE_READY);
>> -	wake_q_add_safe(wake_q, this->task);
>>  }
>=20
> Given the smp_mb() in __wake_q_add(), and more crucially the position of
> wake_q_add() corrected in this work, that mb helps prevent waiter from
> reading stale data at least in case of pipelined_send(). Update comment
> if that is true.
>=20

This race IIUC is covered by 3) under MQ_BARRIER after this patch. But inst=
ead
of the smp_mb() in __wake_q_add(), it is guarded by the use of
smp_store_release(STATE_READY), which ensures that the waiter only sees
STATE_READY after wake_q_add and after updating receiver->msg in
pipelined_send().

Thanks,
Varad

--=20
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 N=C3=BCrnberg
Germany

HRB 36809, AG N=C3=BCrnberg
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer

