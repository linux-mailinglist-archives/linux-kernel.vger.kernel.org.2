Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4CD372D6D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhEDP5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:57:40 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:55492 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230512AbhEDP5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1620143803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=q2GiZPtJwmu4VDYvPpK6XiMIk4KQ2qSQrkEgbApiyXE=;
        b=YwuSw4DHZSqcqPKRLnooS9MJSJzbX1MrybK8DxvqsTPsX40QDs4fjg1bV2TAeogmIg0lYp
        rTngKO0AWemP+q33U/RuOjAga8jdjyqbbOpsbB2qWxSL5TChlu+3tZkgOlc/AMF8wPkXVd
        c5JGmkDs+qFODtbM/Pr4UvjF9fWtl2w=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-31-GvnZGkTZMhSq0cdqQHchXw-1; Tue, 04 May 2021 17:56:42 +0200
X-MC-Unique: GvnZGkTZMhSq0cdqQHchXw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJS+SSXWCbFBnTCmBVE1z7EwT8HP9QNEnGDhBE4bu8SVuD7KLdH6UXv1E/e+UShWk3w7gpas+MsMt+zzfRZHHwscvFIZu3UCLyCwtIAOc6Pfp6v1wlcckJ88wGsZ8Zr+DMPftPSSUXmpgfID21Gx0Dv7EtBGxgxF/bOETA8PjXZbxFY+136b+PfnjXK08k/nFAvUOLLit/4LN6IAaE52C/6KnG9lq5IYKnEPnxrPBXwqCnikoNIx7OZTbwsQLhtjern9Z/S8clyo1wfZQ0usCvK2MHtWIZ5RyIfTx+aibsnjh+Gop6Yk+nMzRoXfaYpqtNSGagSC7/MxnJSY193Kpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqZdr4fe1oeID4+/CllF3yIlaNBBvdcazomFkO+Any4=;
 b=lNsSGBypeS3/zGjh68JWJbXu/+jmTrl/rkJfiaO5Wcx59VmlseTrVeVmDPWIrRTpOaaZBTcRUl8uPUdtafWUrJCuJwvZzAuSgIdECATC+Bj1C2sqOBME9+7GVSGkUj5TyznLUq1OVL4oQQziOQ2P9e++l0dxC0b5lxJfBM8I/657BWoevHiPDbE+OIVYcmMEz/0MWii+k0ZESs7Gvl+MDBa5mDktB+pfl1ZVSAYKBR3t3Vkz6DY06+xw2vUXJfQNj9rSrCH4CL/6wrKBa3TZiI2gyddzs5OnSDBHrc+9s6a/PRkprEDyl5NA72k5SsKw/fdY6MN+9psGQ1AjleavBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com (2603:10a6:208:128::18)
 by AM0PR04MB7058.eurprd04.prod.outlook.com (2603:10a6:208:195::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.42; Tue, 4 May
 2021 15:56:41 +0000
Received: from AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::756a:86b8:8283:733d]) by AM0PR04MB5650.eurprd04.prod.outlook.com
 ([fe80::756a:86b8:8283:733d%6]) with mapi id 15.20.4087.043; Tue, 4 May 2021
 15:56:41 +0000
From:   Varad Gautam <varad.gautam@suse.com>
To:     linux-kernel@vger.kernel.org
CC:     varad.gautam@suse.com,
        Matthias von Faber <matthias.vonfaber@aox-tech.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] ipc/mqueue: Avoid relying on a stack reference past its expiry
Date:   Tue,  4 May 2021 17:55:33 +0200
Message-ID: <20210504155534.17270-1-varad.gautam@suse.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [95.90.93.216]
X-ClientProxiedBy: FR3P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::14) To AM0PR04MB5650.eurprd04.prod.outlook.com
 (2603:10a6:208:128::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xps13.suse.de (95.90.93.216) by FR3P281CA0067.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend Transport; Tue, 4 May 2021 15:56:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a77c150e-42c2-4358-abe2-08d90f1534fb
X-MS-TrafficTypeDiagnostic: AM0PR04MB7058:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB7058A1AF7A8FA20F4C110CF2E05A9@AM0PR04MB7058.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hyTmbKMTI4SyrbrJZx0sZPVuY/y4jn4FeSi6/gnwV9k8pXJOaP49eyI87b8vDjbx0YzSh5fL7q/9+r1OZiOXBEEOBdlNf1JBxfu7LcEgENSNnDFNqc0BPn4DA3q1V4x/oxqBu2UaI1R+yPfT2xKvHKu0jkzsayD9z7wg/J3x4e6aewCcG/BKMyMij2yL7/sh89ElKdB82PtrpNQYXDbkW/99HelhE/qGc2YdgotUmHO2z3laXn2w931Cym6nZjGkGTh6S/jIPMXn4MVVL8mDxKk37LvApcDWo1XhEOMdLoTEEyCRW/yMxjutOdhVwhQvAk7FzMsOhJXfF3+T2XmzZztgH1GYtRG/p8snz3PAD8j0+n3fZ1gRkcyHv+A3zyos5+f07NR92TODNQl7ixG6xig1f0rfUjKS0xtG9NgoqPP8IHK+Tc+3P2gUmoiheGVwRrBjAePnzlY5lIi2u99Mljxrohfdz3KgHp4ftbbYg4OTxCe/OIecHvNsFBfdd0ngCeU6mywsIg8rBLhZJ02xqhDizLqSN1cn1zMCqF+vLNMTDRlBylr5wnL27dgGVn7IDgnJJ6Ycjz9rDb5W/hn+UEwgOk05TUlUcvUsio7wJAWTxqStw8zISvOWTQZntChTkbs00/hFXnxLBze7bioCgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5650.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(39850400004)(366004)(346002)(8676002)(6512007)(186003)(316002)(38100700002)(1076003)(66556008)(38350700002)(83380400001)(8936002)(478600001)(54906003)(6666004)(6916009)(4326008)(44832011)(36756003)(5660300002)(26005)(66476007)(6486002)(6506007)(956004)(66946007)(86362001)(52116002)(2906002)(16526019)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?geSIJbZiqfmIB/KkHq/TNfC9ICkRFp92wcBDh/E1plmdMIgFP/7yvmIbrJae?=
 =?us-ascii?Q?yfwjYlnW0ZXAvvZfpcFxvAWiPP2TqKmS+n1jhKRQPrng3TAaZwdWkqvPOaBA?=
 =?us-ascii?Q?dvAiL1cGcQGx8+Z/8cYN7kmOdYlPDGvXhU9U52a/hLtq5GEaO0ymZ2xfc2+8?=
 =?us-ascii?Q?cv+PaRrehxXWCnxwJJImw6+YyqYiqYjRtEBOZ09+173Z+f19wZU63FVGISRh?=
 =?us-ascii?Q?gBo2hbbKFUT1N79ZSWNEOGlhaS3i6VfVq3+C0xQnRlWIlG0dHzaj6YVX8Mrc?=
 =?us-ascii?Q?MTr5qbD+GztoIjfqrYu7ti2oUtjCywLH2xd5cGXFhVMhf4w0SkZ4IbNICCu0?=
 =?us-ascii?Q?ml1Hsunm4TUTSHxwQcmIkSxZi51X2NSZr9fHtBn/w9QHHlaLpm/NqWEjBegw?=
 =?us-ascii?Q?eBKycLA6OG72IGcrc5/+OdmFkRyeQobGXUTBFP8eGAkKa5WBQw+RJcKV4fqV?=
 =?us-ascii?Q?weuU9tSVSzar5zZAhOb17ptAlywfLcsGS627aTx8xuckDjdFZaBIHvlWGiPb?=
 =?us-ascii?Q?JDO5+Ig8aQf9hKBW9MWM9rvZDuy79keLENJVnk3OxqAy9GtFhBWimChtyXZA?=
 =?us-ascii?Q?ZkxuPMEb0xGaQBmktlYB6rlAylJyhpTkh6xGpN4Ntrbl/9bU5nwImz3sjrjv?=
 =?us-ascii?Q?WAvDTjM9UPdky7ZEG8KYyR8VIQKRLZkU99iV/w0hN2COa2MfLfU/imVIsXKM?=
 =?us-ascii?Q?+4Mqlag2KKGFDdTkpD0YFVP//BSRre7gbuTVMaPWeB3PRuIg3Rc+t+cfPmEZ?=
 =?us-ascii?Q?Rfwsm/SnAIZbwiqA9vtAEt7WTfnSHJmFHXaWSogJhesMqIb8Os2VmIq28d+w?=
 =?us-ascii?Q?fV15FkTMMdKohQnCNh3PmmAuSwKajZhUWNFwQL7KpZGeHxTv52rAojXykTHd?=
 =?us-ascii?Q?Ob6Nx9HQH9C/pK6/4vmJFcid/7V9CAOdXZf7XbrSLwRjkT/iG6Q3mQC1GDAT?=
 =?us-ascii?Q?JIZREJHflzVPAyqjrIR4GseKRncpQi+OnuENngzVqRVTqNOT27Fg/MSMQzTA?=
 =?us-ascii?Q?VAdXtuDhutGnnf5OXEwWG4RFhG+k8kXsHAjStat5DesWbKqWJRUyWhAVyb8v?=
 =?us-ascii?Q?l2+1mLXGTz0dQWYCq0VzNn2v360DutToE04iQPZrKC3VAuYjAWCP4D6ea+sh?=
 =?us-ascii?Q?hpNKEdlekvXi/htbrRLaSgYIT4LjhuS47MKnqJz6sX/4Snf9XCn6zZlXOzrm?=
 =?us-ascii?Q?1+C7LqL0bQhUQEiQZkgAZamUZOxrXQFstb1V1oeRjIf+tozkJ4NBEJ+c4tUi?=
 =?us-ascii?Q?lFUiJ4AID8tFdS/EK4kyf4oH/GZQYyqIDvUU9PRWGfFtN8Z05DTl8T8fywTJ?=
 =?us-ascii?Q?mwiVuelSiHSmPef8aX9kxdfD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77c150e-42c2-4358-abe2-08d90f1534fb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5650.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 15:56:40.8893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8Bn/W/Vx4u5AZm7kizGIpwp1uNqEeJW/mZInkW5BBra5TXlq+5483V5oKXGKiswYjQjlES85MEY0U+B0ddM8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7058
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
will see `state =3D=3D STATE_READY` and break. `ewq_addr` gets removed from
info->e_wait_q[RECV].list.

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

Fixes: c5b2cbdbdac563 ("ipc/mqueue.c: update/document memory barriers")
Signed-off-by: Varad Gautam <varad.gautam@suse.com>
Reported-by: Matthias von Faber <matthias.vonfaber@aox-tech.de>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>

---
 ipc/mqueue.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 8031464ed4ae2..8f78057c6be53 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1004,12 +1004,14 @@ static inline void __pipelined_op(struct wake_q_hea=
d *wake_q,
 				  struct mqueue_inode_info *info,
 				  struct ext_wait_queue *this)
 {
+	struct task_struct *t;
+
 	list_del(&this->list);
-	get_task_struct(this->task);
+	t =3D get_task_struct(this->task);
=20
 	/* see MQ_BARRIER for purpose/pairing */
 	smp_store_release(&this->state, STATE_READY);
-	wake_q_add_safe(wake_q, this->task);
+	wake_q_add_safe(wake_q, t);
 }
=20
 /* pipelined_send() - send a message directly to the task waiting in
--=20
2.30.2

