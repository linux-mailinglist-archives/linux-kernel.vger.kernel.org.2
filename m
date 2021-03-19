Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA9D34153B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 07:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhCSGBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 02:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbhCSGBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 02:01:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF48C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 23:01:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a63so51261604yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 23:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=3iSzzHG13xS4oKLdccr35cH9OM0PQUa1NRme/bdDtFo=;
        b=Jv7BlRnI0FkFfy+IF/zxIjNpYuo0gMFUcshd8KYyyq7PHNEANZQxVFjfFaXxqzv/DQ
         y76WhTGXRrjvKsLubMuuDlHpz2PzzqbUF0WlM6QlQ4sPMTrOLZjDjO3yeqRZwVyBYa8i
         hfhe/Z8HK/jBPVjqDj/ug5u25DPKnXHA9F5E688ftjYg08H7aeBe06IGtWl3yI1/I6s3
         oSOCt4HMsLKk4gYKAWad1K1s3mdJystNkevskKfiLB9lWj6zAHOoZm6xrNrCDpZPEov4
         y8Xaaw4k89RcxiY30Ihlmx3RyOsEyuTnpBVObn1j6KvPhg36YRcjYtBrYc94SFDikCzQ
         80Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=3iSzzHG13xS4oKLdccr35cH9OM0PQUa1NRme/bdDtFo=;
        b=KQxaJsy+YfR1t6AvyLrru3O80BPbLqQ7R5AVFudExYMx6jogvsDKOVvaFWTXHlTjTz
         MW9yUtzHhs2SW6psBqPnz+t6KgJbmPnH3c3BN404y5xzlPq6H/y3pxtbwo7SZdLJCkWk
         FSDa3BJ8HkD5y8+pvl0/u9uj3CdKVteU8GDk7HmH7vw31SYIDFoR7IVbDnlBqDzMCF1x
         Os4I7oCBPQi0jf9ybm0jva76sioaqVV/MZINRALSsWnWw1xSP1S7DgdX7BaJgISnxVeq
         1NsmciA8m6hV9gUxIUXoPdeEzLVqEsyZajGHjTdIdWCg7kCau7FrIcLHsPyvvu7PQd5o
         q5sA==
X-Gm-Message-State: AOAM5302qRWdfEKLaQDi75W4QpfDA8JKnUCkBg11ZOrsRm/XwrnslZSx
        RgfAgVlEXE73YUy48QmT30hxSw5Qccw=
X-Google-Smtp-Source: ABdhPJytXaewBGnVauF20NUpM9+6Ztyyfj26Hc/5sgVy7wzk7j/QiNmOH0aMUaWEjFnKFyiw39dcj1Hz+XE=
X-Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2cd:202:9e0:5db9:bd51:afa7])
 (user=khazhy job=sendgmr) by 2002:a25:6e02:: with SMTP id j2mr4211117ybc.247.1616133693523;
 Thu, 18 Mar 2021 23:01:33 -0700 (PDT)
Date:   Thu, 18 Mar 2021 23:00:15 -0700
Message-Id: <20210319060015.3979352-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH] bfq: silence lockdep for bfqd/ioc lock inversion
From:   Khazhismel Kumykov <khazhy@google.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lockdep warns of circular locking due to inversion between
bfq_insert_requests and bfq_exit_icq. If we end freeing a request when
merging, we *may* grab an ioc->lock if that request is the last refcount
to that ioc. bfq_bio_merge also potentially could have this ordering.
bfq_exit_icq, conversely, grabs bfqd but is always called with ioc->lock
held.

bfq_exit_icq may either be called from put_io_context_active with ioc
refcount raised, ioc_release_fn after the last refcount was already
dropped, or ioc_clear_queue, which is only called while queue is
quiesced or exiting, so the inverted orderings should never conflict.

Fixes: aee69d78dec0 ("block, bfq: introduce the BFQ-v0 I/O scheduler as
an extra scheduler")

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/bfq-iosched.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Noticed this lockdep running xfstests (generic/464) on top of a bfq
block device. I was also able to tease it out w/ binary trying to issue
requests that would end up merging while rapidly swapping the active
scheduler. As far as I could see, the deadlock would not actually occur,
so this patch opts to change lock class for the inverted case.

bfqd -> ioc :
[ 2995.524557] __lock_acquire+0x18f5/0x2660
[ 2995.524562] lock_acquire+0xb4/0x3a0
[ 2995.524565] _raw_spin_lock_irqsave+0x3f/0x60
[ 2995.524569] put_io_context+0x33/0x90. =C2=A0-> ioc->lock grabbed
[ 2995.524573] blk_mq_free_request+0x51/0x140
[ 2995.524577] blk_put_request+0xe/0x10
[ 2995.524580] blk_attempt_req_merge+0x1d/0x30
[ 2995.524585] elv_attempt_insert_merge+0x56/0xa0
[ 2995.524590] blk_mq_sched_try_insert_merge+0x4b/0x60
[ 2995.524595] bfq_insert_requests+0x9e/0x18c0. =C2=A0 =C2=A0-> bfqd->lock =
grabbed
[ 2995.524598] blk_mq_sched_insert_requests+0xd6/0x2b0
[ 2995.524602] blk_mq_flush_plug_list+0x154/0x280
[ 2995.524606] blk_finish_plug+0x40/0x60
[ 2995.524609] ext4_writepages+0x696/0x1320
[ 2995.524614] do_writepages+0x1c/0x80
[ 2995.524621] __filemap_fdatawrite_range+0xd7/0x120
[ 2995.524625] sync_file_range+0xac/0xf0
[ 2995.524642] __x64_sys_sync_file_range+0x44/0x70
[ 2995.524646] do_syscall_64+0x31/0x40
[ 2995.524649] entry_SYSCALL_64_after_hwframe+0x44/0xae

ioc -> bfqd
[ 2995.524490] _raw_spin_lock_irqsave+0x3f/0x60
[ 2995.524498] bfq_exit_icq+0xa3/0xe0 -> bfqd->lock grabbed
[ 2995.524512] put_io_context_active+0x78/0xb0 -> ioc->lock grabbed
[ 2995.524516] exit_io_context+0x48/0x50
[ 2995.524519] do_exit+0x7e9/0xdd0
[ 2995.524526] do_group_exit+0x54/0xc0
[ 2995.524530] __x64_sys_exit_group+0x18/0x20
[ 2995.524534] do_syscall_64+0x31/0x40
[ 2995.524537] entry_SYSCALL_64_after_hwframe+0x44/0xae

Another trace where we grab ioc -> bfqd through bfq_exit_icq is when
changing elevator
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-> #1 (&(&bfqd->lock=
)->rlock){-.-.}:
[ =C2=A0646.890820] =C2=A0 =C2=A0 =C2=A0 =C2=A0lock_acquire+0x9b/0x140
[ =C2=A0646.894868] =C2=A0 =C2=A0 =C2=A0 =C2=A0_raw_spin_lock_irqsave+0x3b/=
0x50
[ =C2=A0646.899707] =C2=A0 =C2=A0 =C2=A0 =C2=A0bfq_exit_icq_bfqq+0x47/0x1f0
[ =C2=A0646.904196] =C2=A0 =C2=A0 =C2=A0 =C2=A0bfq_exit_icq+0x21/0x30
[ =C2=A0646.908160] =C2=A0 =C2=A0 =C2=A0 =C2=A0ioc_destroy_icq+0xf3/0x130
[ =C2=A0646.912466] =C2=A0 =C2=A0 =C2=A0 =C2=A0ioc_clear_queue+0xb8/0x140
[ =C2=A0646.916771] =C2=A0 =C2=A0 =C2=A0 =C2=A0elevator_switch_mq+0xa4/0x3c=
0
[ =C2=A0646.921333] =C2=A0 =C2=A0 =C2=A0 =C2=A0elevator_switch+0x5f/0x340

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 95586137194e..cb50ac0ffe80 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5027,7 +5027,14 @@ static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic,=
 bool is_sync)
 	if (bfqq && bfqd) {
 		unsigned long flags;
=20
-		spin_lock_irqsave(&bfqd->lock, flags);
+		/* bfq_exit_icq is usually called with ioc->lock held, which is
+		 * inverse order from elsewhere, which may grab ioc->lock
+		 * under bfqd->lock if we merge requests and drop the last ioc
+		 * refcount. Since exit_icq is either called with a refcount,
+		 * or with queue quiesced, use a differnet lock class to
+		 * silence lockdep
+		 */
+		spin_lock_irqsave_nested(&bfqd->lock, flags, 1);
 		bfqq->bic =3D NULL;
 		bfq_exit_bfqq(bfqd, bfqq);
 		bic_set_bfqq(bic, NULL, is_sync);
--=20
2.31.0.rc2.261.g7f71774620-goog

