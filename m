Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE0B3FF47C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242646AbhIBUCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhIBUCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:02:37 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91F7C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 13:01:38 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id l10so3044989ilh.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 13:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GdgdNsxiSZP/MSbqFXqR9uQRLa6Q7IngCFWYs2vSGBk=;
        b=WL8mvDiWuj3UK+pphmJGVPWnN4v8v9+M26+Ahtlg6BC7fPka4010huRB4mmjQNas8X
         KgGgEL2YzJaYXZU1TUdxctjFMZG1r2QIVdkBXcoRO4aRVRCk+mSBTGnCNR7KVTTf70+/
         tDzoLi+sBGEOD3UUhsHLjBGCyapTQWLSr54wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GdgdNsxiSZP/MSbqFXqR9uQRLa6Q7IngCFWYs2vSGBk=;
        b=kNDkyqua7K3+nzzpXbZGnbTkzxojZjeLAtcQTHMEiBKVfH8oq4yTUbT+h3CAPjnXnS
         TB76IDstpAu9nELmhferxb6V/ZDQgwuBj2W2JgJNEkzaxIbxUvo29NWIztSLedZnX1AV
         OtRXkBuOxpUaiFLA7ZNlLm2Te2DFauWpFsWzn/i2tAx61gHqwpfZo95uAD/8jsg3ZwJd
         V63TGmCa5hA8qRNliTsuPAKPemD4BsFU2kkAE3btlG21gavsidCIvtxpptumqnT9jknN
         mBBADph9ipz65BA5p3FhxsRb7E/6hDsP8jSzlAGRKoZ3eptuDWvi+P+N/JtzhVGACIt+
         2qQQ==
X-Gm-Message-State: AOAM533r0q1OKul8j6p31CmKxvIo5Sj/Oup/OKANQw3HLreUJzHtzx5w
        uG4CSYzYTSEqIuPAswmd5+BXEw==
X-Google-Smtp-Source: ABdhPJxug8ouQGxumNMaoW3mw4RjqG+DfTAR3M6FrOKphDpwG6RCQbYaNFfoEciaT0RweFim33dmww==
X-Received: by 2002:a92:db06:: with SMTP id b6mr3588305iln.305.1630612898015;
        Thu, 02 Sep 2021 13:01:38 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l15sm1450838ilo.22.2021.09.02.13.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 13:01:37 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     tj@kernel.org, jiangshanlai@gmail.com, akpm@linux-foundation.org,
        elver@google.com, andreyknvl@gmail.com, dvyukov@google.com,
        walter-zh.wu@mediatek.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] workqueue: Don't record workqueue stack holding raw_spin_lock
Date:   Thu,  2 Sep 2021 14:01:34 -0600
Message-Id: <20210902200134.25603-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PROVE_RAW_LOCK_NESTING=y and CONFIG_KASAN are enabled,
kasan_record_aux_stack() runs into "BUG: Invalid wait context" when
it tries to allocate memory attempting to acquire spinlock in page
allocation code while holding workqueue pool raw_spinlock.

There are several instances of this problem when block layer tries
to __queue_work(). Call trace from one of these instances is below:

    kblockd_mod_delayed_work_on()
      mod_delayed_work_on()
        __queue_delayed_work()
          __queue_work() (rcu_read_lock, raw_spin_lock pool->lock held)
            insert_work()
	      kasan_record_aux_stack()
                kasan_save_stack()
		  stack_depot_save()
                    alloc_pages()
                      __alloc_pages()
                        get_page_from_freelist()
                          rm_queue()
                            rm_queue_pcplist()
                              local_lock_irqsave(&pagesets.lock, flags);
                              [ BUG: Invalid wait context triggered ]

Fix it by calling kasan_record_aux_stack() conditionally only when
CONFIG_PROVE_RAW_LOCK_NESTING is not enabled. After exploring other
options such as calling kasan_record_aux_stack() after releasing the
pool lock, opting for a least disruptive path of stubbing this record
function to avoid nesting raw spinlock and spinlock.

=============================
 [ BUG: Invalid wait context ]
 5.14.0-rc7+ #8 Not tainted
 -----------------------------
 snap/532 is trying to lock:
 ffff888374f32ba0 (lock#2){..-.}-{3:3}, at: get_page_from_freelist (mm/page_alloc.c:3665 mm/page_alloc.c:3703 mm/page_alloc.c:4165)
 other info that might help us debug this:
 context-{5:5}
 3 locks held by snap/532:
 #0: ffff888139fa4408 (&type->i_mutex_dir_key#10){.+.+}-{4:4}, at: walk_component (fs/namei.c:1663 fs/namei.c:1959)
 #1: ffffffffab870c40 (rcu_read_lock){....}-{1:3}, at: __queue_work (./arch/x86/include/asm/preempt.h:80 ./include/linux/rcupdate.h:68 ./include/linux/rcupdate.h:685 kernel/workqueue.c:1421)
 #2: ffff888374f36cd8 (&pool->lock){-.-.}-{2:2}, at: __queue_work (kernel/workqueue.c:1466)
 stack backtrace:
 CPU: 14 PID: 532 Comm: snap Not tainted 5.14.0-rc7+ #8
 Hardware name: LENOVO 90Q30008US/3728, BIOS O4ZKT1CA 09/16/2020
 Call Trace:
 dump_stack_lvl (lib/dump_stack.c:106 (discriminator 4))
 dump_stack (lib/dump_stack.c:113)
 __lock_acquire.cold (kernel/locking/lockdep.c:4666 kernel/locking/lockdep.c:4727 kernel/locking/lockdep.c:4965)
 ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4873)
 ? lock_is_held_type (kernel/locking/lockdep.c:5368 kernel/locking/lockdep.c:5668)
 lock_acquire (kernel/locking/lockdep.c:438 kernel/locking/lockdep.c:5627 kernel/locking/lockdep.c:5590)
 ? get_page_from_freelist (mm/page_alloc.c:3665 mm/page_alloc.c:3703 mm/page_alloc.c:4165)
 ? lock_release (kernel/locking/lockdep.c:5593)
 ? __kasan_check_read (mm/kasan/shadow.c:32)
 ? __lock_acquire (kernel/locking/lockdep.c:5019)
 ? __zone_watermark_ok (./include/linux/list.h:282 ./include/linux/mmzone.h:111 mm/page_alloc.c:3908)
 get_page_from_freelist (./include/linux/local_lock_internal.h:43 mm/page_alloc.c:3665 mm/page_alloc.c:3703 mm/page_alloc.c:4165)
 ? get_page_from_freelist (mm/page_alloc.c:3665 mm/page_alloc.c:3703 mm/page_alloc.c:4165)
 ? lock_is_held_type (kernel/locking/lockdep.c:5368 kernel/locking/lockdep.c:5668)
 ? is_bpf_text_address (./arch/x86/include/asm/preempt.h:85 ./include/linux/rcupdate.h:73 ./include/linux/rcupdate.h:719 kernel/bpf/core.c:708)
 ? lock_downgrade (kernel/locking/lockdep.c:5633)
 ? __zone_watermark_ok (mm/page_alloc.c:4054)
 __alloc_pages (mm/page_alloc.c:5391)
 ? __alloc_pages_slowpath.constprop.0 (mm/page_alloc.c:5354)
 ? create_prof_cpu_mask (kernel/stacktrace.c:82)
? _find_first_bit (lib/find_bit.c:83)
 alloc_pages (mm/mempolicy.c:2249)
 stack_depot_save (lib/stackdepot.c:304)
 ? lock_is_held_type (kernel/locking/lockdep.c:5368 kernel/locking/lockdep.c:5668)
 kasan_save_stack (mm/kasan/common.c:41)
 ? kasan_save_stack (mm/kasan/common.c:39)
 ? kasan_record_aux_stack (mm/kasan/generic.c:348)
 ? insert_work (./include/linux/instrumented.h:71 ./include/asm-generic/bitops/instrumented-non-atomic.h:134 kernel/workqueue.c:616 kernel/workqueue.c:623 kernel/workqueue.c:1335)
 ? __queue_work (kernel/workqueue.c:1501)
 ? __queue_delayed_work (kernel/workqueue.c:1657)
 ? mod_delayed_work_on (kernel/workqueue.c:1720)
 ? kblockd_mod_delayed_work_on (block/blk-core.c:1633)
 ? __blk_mq_delay_run_hw_queue (block/blk-mq.c:1567)
 ? blk_mq_run_hw_queue (block/blk-mq.c:1610)
 ? blk_mq_sched_insert_request (block/blk-mq-sched.c:480)
 ? blk_mq_submit_bio (block/blk-mq.c:2276)

Fixes: e89a85d63fb2 ("workqueue: kasan: record workqueue stack")
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes since v1:
-- Instead of changing when record happens, disable record
   when CONFIG_PROVE_RAW_LOCK_NESTING=y
 
 kernel/workqueue.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f148eacda55a..435970ef81ae 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1328,8 +1328,16 @@ static void insert_work(struct pool_workqueue *pwq, struct work_struct *work,
 {
 	struct worker_pool *pool = pwq->pool;
 
-	/* record the work call stack in order to print it in KASAN reports */
+	/*
+	 * record the work call stack in order to print it in KASAN reports
+	 * Doing this when CONFIG_PROVE_RAW_LOCK_NESTING is enabled results
+	 * in nesting raw spinlock with page allocation spinlock.
+	 *
+	 * Avoid recording when CONFIG_PROVE_RAW_LOCK_NESTING is enabled.
+	 */
+#if !defined(CONFIG_PROVE_RAW_LOCK_NESTING)
 	kasan_record_aux_stack(work);
+#endif
 
 	/* we own @work, set data and link */
 	set_work_pwq(work, pwq, extra_flags);
-- 
2.30.2

