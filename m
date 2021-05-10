Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1524737825E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhEJKez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:34:55 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:51027 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231966AbhEJKbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1620642618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=V2ytsjP3EsID+/tMb1wDfcjuDCKtWK9bQbmrDULn1DU=;
        b=k+8g3I7LLoMwYBqXAVrsIOoWAn6luWkIb+xuv/YYrdYr0Eagw4M9gWNvxCfLYajGMrq6RB
        aZkD8cP4mdycARe/yh/k3X7to4af3QS+QD+oL7Men8XLjT3Mv+yLOqiIgklRkWHqQ6/8yd
        E90lcuiR+BqyPcj3UhOi5AvdXbLGliw=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2054.outbound.protection.outlook.com [104.47.5.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-32-9g9Ko-JcObSOYge445FAmg-1; Mon, 10 May 2021 12:30:16 +0200
X-MC-Unique: 9g9Ko-JcObSOYge445FAmg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApppqyW6G+Eh9M8X5MU4uuKvUhhTeyRXeeChxTKnW+D2H0OGkYleMu+2e1X3gwaB9Zrcx0l3PjX8Hslb5T6rblnmtd0N1L3uoj2ODu6PWC09HISj6WhEb2WoGj+QKmhIO5UKR3+FFhy8g/hGNu2aJbAKVjsN+JRcukcw+P+yZL3MSf5M58IZHVHYbdHkXRw5kEzddnw8JxYPhOMCkngKKB33g4noHgHASPv+4uHjF2nEvaMRR8XhTpXKqZ8CHIJTLr8U9/U3fOSnkUNpXGD5GTha8To8vYA2O+oh/nxp+aFRpX2bdRJkWwHg9DDMz+gBGB9HR3F/UL3twoCc0oiyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QMfSMMyCRleyxHOLIodYuKAjuGSfla6YzfzpPIfjBE=;
 b=I6/NFhYijeCn+n6bOJqnd0CEziiUkLqzMFO3U4K+pGVzmOqxSuUVcJWD7aii7NrmdTpwv+mUeRLFn249fd+fV7BMKk4tor8tBmci//6VG47umJ7DsKpoqyEqCJ9iN5IdelD4/zYTWKd0ja973bAOJPcXfEjnL/nWcb8V2RyfVxbKEK3q3pwdXUvKXkXUEVslYuGpWh/w0qQaiiaqoVCzN6ZlvanuzKKuD2Izqxpdb1pCpMvA3vQRQgZBOz+rqVLKwjttiFe2IS163EhLcUVIXc6t7/DcxUI6BlrKbxUPFCGxl/LV70DarbaKkZO6YkntST4O7THiMufRXtw2gSwoqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com (2603:10a6:208:128::18)
 by AM9PR04MB8260.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 10:30:15 +0000
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::756a:86b8:8283:733d]) by AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::756a:86b8:8283:733d%6]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 10:30:15 +0000
From:   Varad Gautam <varad.gautam@suse.com>
To:     linux-kernel@vger.kernel.org
CC:     varad.gautam@suse.com,
        Matthias von Faber <matthias.vonfaber@aox-tech.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        James Morris <jamorris@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH v4] ipc/mqueue, msg, sem: Avoid relying on a stack reference past its expiry
Date:   Mon, 10 May 2021 12:29:46 +0200
Message-ID: <20210510102950.12551-1-varad.gautam@suse.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [95.90.93.216]
X-ClientProxiedBy: PR0P264CA0123.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::15) To AM0PR04MB5650.eurprd04.prod.outlook.com
 (2603:10a6:208:128::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xps13.suse.de (95.90.93.216) by PR0P264CA0123.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1a::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 10:30:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 498f6570-e236-4e62-ae18-08d9139e9979
X-MS-TrafficTypeDiagnostic: AM9PR04MB8260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9PR04MB82606F77B94CE9F3AFBB2918E0549@AM9PR04MB8260.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQrQPaUGFVnRRnZX5EYlDd07HyRidBYcmVS/C4B6i6qgdDl4YrfACEJGIlmfUAeH4jcuOSYd7zJWY6Pg9uPx5P3ZOif5afJ9lv79Y06ccNPUiyo5HAQqrfqK/L8hjTimBPudaUsCH4ndx2JlTy9vmerkIKVqKFCCiDZ0/ZY/AOBHEZbtVL0xZvZ0xoV3HzuDpyggvG5ATZr5mvoTq+Ong1fpNGuhDIVSDwxq7aZToBQ0MMBXVaB3XdIoyM+65uc8u8AWBnD5/c5fohQI/Tt2MLTMKRz2F7u8R4bJHiNDELZv8XkP1/VGO3WqIdHFLiPQ6IXHSPJzoPpJOuIzpqOy55dSyDpTKnSTjoogOnyqzxzqNVJBrFxbRnouj8fDvmajFgX43p/pmDHnU1Ko5icpaFL6mOElmUvMFVrR32Ov3qC5hS9kC5giXL1wrgz4sun/VCimOJXfzlB9If3gzmT8C2gAK6B5sIlfrKd5zaIra2ys3e+kc+/D+zTbP1b1ZzSvpGuiVDVfSZwlhVF82LKQVtdEsGUn/95FiAfrSQaL1OstGxz6l3QNCIN+urYPap6zofJPxeYqX0IJNsg6pTg6TRkPYV7M/+Vja9i3j0+DfZXhECRX5emHCCt9Az1X4XLqdyNAZ9B+tQc9ZULSha6vmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5650.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(366004)(39860400002)(5660300002)(478600001)(956004)(52116002)(2616005)(6486002)(6916009)(6666004)(6512007)(1076003)(54906003)(66946007)(38100700002)(38350700002)(6506007)(44832011)(66476007)(66556008)(8676002)(16526019)(186003)(4326008)(26005)(8936002)(2906002)(316002)(36756003)(7416002)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OAx1BgRCRKX8Dd7MTmfIJ2YgokLkpLeyFYs0gojPU/Yv/Va8os4T852aZmze?=
 =?us-ascii?Q?aqhgA3IQkXi7McDb+bsCOSeNPb9X1eVkevpyu8CIkJc3BOj+qwLEJvH3as6r?=
 =?us-ascii?Q?qDLAt6sOVsX/aZ9bWxJaCd4+HMw6O460IojJXUanZsZMwY/vghbBIA/TeCxc?=
 =?us-ascii?Q?C+fQggazxGuXAfi6T68XA0ThOYEoK09f6Hzwa63UZMYo1gcYE5xKCiCbOkSe?=
 =?us-ascii?Q?IQEM2ffWmGQGmaQN2dnqn4E4Ts8RN3DDo46jFPF95PHWvjhLxWbFcUb/kYQn?=
 =?us-ascii?Q?GGvFDsvbTeHNYsciPsNol7LT+4rGNe5X1W5CEH4JOJHJB0fESgfjN7AK4VBo?=
 =?us-ascii?Q?wEJELtP8dXeDmggHVAQjg1OZVMOip1a+v4r0dcT9jDZoCZ+o5+AmLbUOqPZW?=
 =?us-ascii?Q?Ne7+IiJoaF4SEAOx9PSQ04ioz0q2vJF8OLhwtc06H7NTzhOCaHSSOlqJtoBq?=
 =?us-ascii?Q?QnpF7kYMBC+udiQHeTXC1SCQktgGtv6jZm44yAq1SAVDQdhm7gM8/gV0ld6i?=
 =?us-ascii?Q?tSrdTwerNEwDKH96nGiA0D4LG9Z4atTIPeptHs2nfIKtEIM9pQyVkNlVnRGF?=
 =?us-ascii?Q?GW18W95c1rie01g/R2QfB1tYkjEGjOWc1YnMeApWPigD5Z7R38RMgx4dLLU1?=
 =?us-ascii?Q?NXaOQnRMQw2XON050K1ezDU8HD6pKkvlIGoCWdVVnKjGoMHXgdktedLYEt9k?=
 =?us-ascii?Q?VT/ZEvtItoWc28irfib5rRXq62HmO1fHrHGLly+GnGKBFer5xQc0Lfy1x2hK?=
 =?us-ascii?Q?nlnN3DXnNQOVHoaxHo+gGyeyZw+IpBnta0lxhCH9cAEB6gEehIxywvZLBVyn?=
 =?us-ascii?Q?ni9vpqCw90Hcd+8ANIPp5JhEgTYSVweZx5+A+bkbQWxELlZSOP+UugWsJ2uP?=
 =?us-ascii?Q?wwnFMy1ZVlYuH3wVUzcyyKvebR9VmRaUGjG1V0w1kQA7frG2Z4C8dvwYrTSs?=
 =?us-ascii?Q?fmK/JuQTqjjL+lR9oSYNaBKZLzjyKncW83ZfkRTaSSQK2uL6GI/l5toWujHw?=
 =?us-ascii?Q?FecBskE7W4Raom4gKOxHnkdVLk9WlMdWWb8brdIUzA8grSO+/irDpDXC8Q0E?=
 =?us-ascii?Q?QJGj7EzQdzE0R4qG60gHChVhlCI2bHsHG+6MMVtvmAGM5X2KF61TC9raWXu3?=
 =?us-ascii?Q?CC0MUiZLsRQxOTCt32MfFae78DObnnZxKDF738CAiQ57diRnNPZ7Lr11hkfR?=
 =?us-ascii?Q?2btd/3vamWqsJw1DXSc+OBG5k3Q0Dv8u+JH/kDfss4WDrEYoWxkT7YxCtrJo?=
 =?us-ascii?Q?KqzeOFik9AIE4LKkXwBXBD/y6m6tQb9KQdhpsdb+SoLaZtJuzWf/mL29iy//?=
 =?us-ascii?Q?M7C6p5a0mg57cuHfc9f9EvBU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498f6570-e236-4e62-ae18-08d9139e9979
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5650.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 10:30:15.1554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRCz9t8Jyc1OfKOJBToxp/QZ2kH3YlIy8Az9VuTJJ6MBl7fk1/ePcVZSy2VHm9rdJep3aT4BUGPNvXXeIOTzYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8260
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_mq_timedreceive calls wq_sleep with a stack local address. The
sender (do_mq_timedsend) uses this address to later call
pipelined_send.

This leads to a very hard to trigger race where a do_mq_timedreceive call
might return and leave do_mq_timedsend to rely on an invalid address,
causing the following crash:

[  240.739977] RIP: 0010:wake_q_add_safe+0x13/0x60
[  240.739991] Call Trace:
[  240.739999]  __x64_sys_mq_timedsend+0x2a9/0x490
[  240.740003]  ? auditd_test_task+0x38/0x40
[  240.740007]  ? auditd_test_task+0x38/0x40
[  240.740011]  do_syscall_64+0x80/0x680
[  240.740017]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  240.740019] RIP: 0033:0x7f5928e40343

The race occurs as:

1. do_mq_timedreceive calls wq_sleep with the address of
`struct ext_wait_queue` on function stack (aliased as `ewq_addr` here)
- it holds a valid `struct ext_wait_queue *` as long as the stack has
not been overwritten.

2. `ewq_addr` gets added to info->e_wait_q[RECV].list in wq_add, and
do_mq_timedsend receives it via wq_get_first_waiter(info, RECV) to call
__pipelined_op.

3. Sender calls __pipelined_op::smp_store_release(&this->state, STATE_READY=
).
Here is where the race window begins. (`this` is `ewq_addr`.)

4. If the receiver wakes up now in do_mq_timedreceive::wq_sleep, it
will see `state =3D=3D STATE_READY` and break.

5. do_mq_timedreceive returns, and `ewq_addr` is no longer guaranteed
to be a `struct ext_wait_queue *` since it was on do_mq_timedreceive's
stack. (Although the address may not get overwritten until another
function happens to touch it, which means it can persist around for an
indefinite time.)

6. do_mq_timedsend::__pipelined_op() still believes `ewq_addr` is a
`struct ext_wait_queue *`, and uses it to find a task_struct to pass
to the wake_q_add_safe call. In the lucky case where nothing has
overwritten `ewq_addr` yet, `ewq_addr->task` is the right task_struct.
In the unlucky case, __pipelined_op::wake_q_add_safe gets handed a
bogus address as the receiver's task_struct causing the crash.

do_mq_timedsend::__pipelined_op() should not dereference `this` after
setting STATE_READY, as the receiver counterpart is now free to return.
Change __pipelined_op to call wake_q_add_safe on the receiver's
task_struct returned by get_task_struct, instead of dereferencing
`this` which sits on the receiver's stack.

As Manfred pointed out, the race potentially also exists in
ipc/msg.c::expunge_all and ipc/sem.c::wake_up_sem_queue_prepare. Fix
those in the same way.

Fixes: c5b2cbdbdac563 ("ipc/mqueue.c: update/document memory barriers")
Fixes: 8116b54e7e23ef ("ipc/sem.c: document and update memory barriers")
Fixes: 0d97a82ba830d8 ("ipc/msg.c: update and document memory barriers")
Signed-off-by: Varad Gautam <varad.gautam@suse.com>
Reported-by: Matthias von Faber <matthias.vonfaber@aox-tech.de>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Manfred Spraul <manfred@colorfullife.com>
---
v2: Call wake_q_add before smp_store_release, instead of using a
    get_task_struct/wake_q_add_safe combination across
    smp_store_release. (Davidlohr Bueso)
v3: Comment/commit message fixup.
v4: - v2 / v3 have potential for introducing lost wakeups. Return to v1
    as the path-of-least-surprises to fix the race at hand.
    - Also fix ipc/msg.c and ipc/sem.c which have the same usage
    pattern.(Manfred Spraul)

 ipc/mqueue.c | 6 ++++--
 ipc/msg.c    | 6 ++++--
 ipc/sem.c    | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 8031464ed4ae..4e4e61111500 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1004,12 +1004,14 @@ static inline void __pipelined_op(struct wake_q_hea=
d *wake_q,
 				  struct mqueue_inode_info *info,
 				  struct ext_wait_queue *this)
 {
+	struct task_struct *task;
+
 	list_del(&this->list);
-	get_task_struct(this->task);
+	task =3D get_task_struct(this->task);
=20
 	/* see MQ_BARRIER for purpose/pairing */
 	smp_store_release(&this->state, STATE_READY);
-	wake_q_add_safe(wake_q, this->task);
+	wake_q_add_safe(wake_q, task);
 }
=20
 /* pipelined_send() - send a message directly to the task waiting in
diff --git a/ipc/msg.c b/ipc/msg.c
index acd1bc7af55a..6e6c8e0c9380 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -251,11 +251,13 @@ static void expunge_all(struct msg_queue *msq, int re=
s,
 	struct msg_receiver *msr, *t;
=20
 	list_for_each_entry_safe(msr, t, &msq->q_receivers, r_list) {
-		get_task_struct(msr->r_tsk);
+		struct task_struct *r_tsk;
+
+		r_tsk =3D get_task_struct(msr->r_tsk);
=20
 		/* see MSG_BARRIER for purpose/pairing */
 		smp_store_release(&msr->r_msg, ERR_PTR(res));
-		wake_q_add_safe(wake_q, msr->r_tsk);
+		wake_q_add_safe(wake_q, r_tsk);
 	}
 }
=20
diff --git a/ipc/sem.c b/ipc/sem.c
index f6c30a85dadf..7d9c06b0ad6e 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -784,12 +784,14 @@ static int perform_atomic_semop(struct sem_array *sma=
, struct sem_queue *q)
 static inline void wake_up_sem_queue_prepare(struct sem_queue *q, int erro=
r,
 					     struct wake_q_head *wake_q)
 {
-	get_task_struct(q->sleeper);
+	struct task_struct *sleeper;
+
+	sleeper =3D get_task_struct(q->sleeper);
=20
 	/* see SEM_BARRIER_2 for purpuse/pairing */
 	smp_store_release(&q->status, error);
=20
-	wake_q_add_safe(wake_q, q->sleeper);
+	wake_q_add_safe(wake_q, sleeper);
 }
=20
 static void unlink_queue(struct sem_array *sma, struct sem_queue *q)
--=20
2.30.2

