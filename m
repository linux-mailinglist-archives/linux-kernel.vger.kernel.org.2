Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6430037F345
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 08:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhEMG4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 02:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhEMG4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 02:56:25 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EFAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 23:55:14 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id u126-20020a3792840000b02902e769005fe1so18938607qkd.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Bz3JxoEii4Fx6S2XL+V4iDTq2CHrqR+zl6djxVQifMg=;
        b=rHkz0lJ+RywJQ9YxYbyM1EALS/0sSXhaM90r9VJjnPOsbYkE0qLlAE8vbMjlxMgWwA
         PqT3GFBO7+ozmZxUPtJou9t29OizWhyMUzeksiKrfEu4qAyQFVa4adN0F+XoPzA5w5PY
         3GDkfJyziKvviASZ/syVG50da0L+yfgXXioL6QiCY/W9PJCQuq20uqn1JdDY6NAYiKJT
         NizBlbFaOsxrefiA50+BnRtv+NagYb4kzfAu5/jx7nbxkpdBwGxfd7P9JWMXd6huVYnW
         JlkHOK/g/Tkt+TMMAZXg2+GIPvXdkjOLhop+sX3IRul/NS17TTHdo8DoM2FbWlCb/004
         wxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Bz3JxoEii4Fx6S2XL+V4iDTq2CHrqR+zl6djxVQifMg=;
        b=q9PdxujSYdE//uyylEO+vGOpJn2c0Oc3fkGncTGFSVnCTnUOeJlerpZMba5AxdtJhm
         EvCSWFx2yG+LXmZnQpc0QQd6PBhJwEaGVSRn8/Tc+nf6N+HR/3FdnHhF/I869FPWGVN0
         MFUcCErYQ8tqqP0g6gch+EMdRsdP8BJXUj/Kxl7lw2DN6JI7P/SCRxY34fCnDO2McGsQ
         iGnbOtY+qdgLW8KhZa3+3rnKG5OmIHRo/X4Jlm2FhZROnewCO2Yda55CMBjYzjnumxsu
         5upBsIZGdkaR05IJaSZ9ruJQd8zwFo+3GdUsZ446P0I6QP1D1Bx0XwMWEgtxJ2LMZnQq
         sqwA==
X-Gm-Message-State: AOAM533ts+5bw/+Dk3i6yvovqEiEY7PeDvWrvzvK57JO4LDNB5ZqhpSU
        wA8Otyq3oISoLvY54xh4lTqif/2wDXCvY2o=
X-Google-Smtp-Source: ABdhPJy5UbN6LGe3Z+4CMWncow1dUwIPjX+3aEJfIuTgKNE8skLGNm6WXa3449r5rYEs1yo51hXUOzL/opL02/8=
X-Received: from liumartin.ntc.corp.google.com ([2401:fa00:fc:202:7e5:c43a:7562:b75d])
 (user=liumartin job=sendgmr) by 2002:a0c:e14b:: with SMTP id
 c11mr5553032qvl.56.1620888913863; Wed, 12 May 2021 23:55:13 -0700 (PDT)
Date:   Thu, 13 May 2021 14:54:57 +0800
Message-Id: <20210513065458.941403-1-liumartin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH] kthread: Fix kthread_mod_delayed_work vs kthread_cancel_delayed_work_sync
 race
From:   Martin Liu <liumartin@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     minchan@google.com, www@google.com, davidchao@google.com,
        jenhaochen@google.com, Martin Liu <liumartin@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We encountered a system hang issue while doing the tests. The callstack
is as following

	schedule+0x80/0x100
	schedule_timeout+0x48/0x138
	wait_for_common+0xa4/0x134
	wait_for_completion+0x1c/0x2c
	kthread_flush_work+0x114/0x1cc
	kthread_cancel_work_sync.llvm.16514401384283632983+0xe8/0x144
	kthread_cancel_delayed_work_sync+0x18/0x2c
	xxxx_pm_notify+0xb0/0xd8
	blocking_notifier_call_chain_robust+0x80/0x194
	pm_notifier_call_chain_robust+0x28/0x4c
	suspend_prepare+0x40/0x260
	enter_state+0x80/0x3f4
	pm_suspend+0x60/0xdc
	state_store+0x108/0x144
	kobj_attr_store+0x38/0x88
	sysfs_kf_write+0x64/0xc0
	kernfs_fop_write_iter+0x108/0x1d0
	vfs_write+0x2f4/0x368
	ksys_write+0x7c/0xec

When we started investigating, we found race between
kthread_mod_delayed_work vs kthread_cancel_delayed_work_sync. The race's
result could be simply reproduced as a kthread_mod_delayed_work with
a following kthread_flush_work call.

Thing is we release kthread_mod_delayed_work kspin_lock in
__kthread_cancel_work so it opens a race window for
kthread_cancel_delayed_work_sync to change the canceling count used to
prevent dwork from being requeued before calling kthread_flush_work.
However, we don't check the canceling count after returning from
__kthread_cancel_work and then insert the dwork to the worker. It
results the following kthread_flush_work inserts flush work to dwork's
tail which is at worker's dealyed_work_list. Therefore, flush work will
never get moved to the worker's work_list to be executed. Finally,
kthread_cancel_delayed_work_sync will NOT be able to get completed and
wait forever. The code sequence diagram is as following

Thread A                Thread B
kthread_mod_delayed_work
  spin_lock
   __kthread_cancel_work
    canceling =3D 1
    spin_unlock
                        kthread_cancel_delayed_work_sync
                          spin_lock
                            kthread_cancel_work
                          canceling =3D 2
                          spin_unlock
    del_timer_sync
    spin_lock
    canceling =3D 1 // canceling count gets update in ThreadB before
  queue_delayed_work // dwork is put into the woker=E2=80=99s dealyed_work_=
list
                        without checking the canceling count
 spin_unlock
                          kthread_flush_work
                            spin_lock
                            Insert flush work // at the tail of the
			                         dwork which is at
						 the worker=E2=80=99s
						 dealyed_work_list
                            spin_unlock
                            wait_for_completion // Thread B stuck here as
			                           flush work will never
						   get executed

The canceling count could change in __kthread_cancel_work as the spinlock
get released and regained in between, let's check the count again before
we queue the delayed work to avoid the race.

Fixes: 37be45d49dec2 ("kthread: allow to cancel kthread work")
Tested-by: David Chao <davidchao@google.com>
Signed-off-by: Martin Liu <liumartin@google.com>
---
 kernel/kthread.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index fe3f2a40d61e..064eae335c1f 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1181,6 +1181,19 @@ bool kthread_mod_delayed_work(struct kthread_worker =
*worker,
 		goto out;
=20
 	ret =3D __kthread_cancel_work(work, true, &flags);
+
+	/*
+	 * Canceling could run in parallel from kthread_cancel_delayed_work_sync
+	 * and change work's canceling count as the spinlock is released and rega=
in
+	 * in __kthread_cancel_work so we need to check the count again. Otherwis=
e,
+	 * we might incorrectly queue the dwork and further cause
+	 * cancel_delayed_work_sync thread waiting for flush dwork endlessly.
+	 */
+	if (work->canceling) {
+		ret =3D false;
+		goto out;
+	}
+
 fast_queue:
 	__kthread_queue_delayed_work(worker, dwork, delay);
 out:
--=20
2.31.1.607.g51e8a6a459-goog

