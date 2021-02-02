Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA12830CB46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbhBBTTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239280AbhBBS7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:59:49 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA49C061354
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:57:53 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id h8so12566983pls.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YXSGE321Hb1spvDtzkP5gbN2dNsISQr8m2Sxt2hfEQw=;
        b=Uce/HAumEGErTei5sAOxj/z26CYF6m1y5IaCuTDbahOpmbAfKeJwIsZ5/C9Nce4Y32
         HqvUsSlvypprHj8Y0NYn7Ja5rjDiPQc9yBViVpS6NuVm3tM3DobmSbuSKMc1pk11vKDL
         j0huOX5yXeEkRbrZ/2doRnG8aB9CgoIiSaAHV4+n4sylBtmzYrD2ikUF08UgicRMNXHu
         pVWFBcLzueg/GlszziuntcVgpptkJhEnhpFB2wqeBVa9zDnTa5VSqDB0ClwfvxIUlZht
         fU3+gyQGHX1EcXTK0KGQRCAIV58t0eMe6M84n7/jkdv0+t1lkz8m3y45zTaXZbgkh5qZ
         +LEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YXSGE321Hb1spvDtzkP5gbN2dNsISQr8m2Sxt2hfEQw=;
        b=cmcSb4jxAzJ7KOAkHNe/UjiVzlF/ub/XeY4u2AxVc7EG2kMc7HShWil6ZRAS+fp1fF
         wpQpTb5ilmWLb3j6gGfxDAoAJ37b7RZOLT7K9tV/8XlZ/+nG/xR+tNcrFRYSLFaF+lri
         Uvhe58ZcPIUndOaaI4/lEuoZUM2DaoTBMdc8yQHIKuQf3a5d3zr6d9wOkKn49c5K4auw
         Wu/zQ2jen9nOmwbYv3XwN39evQUc00ZtILEuywztlGCF/b4wyZcY7wHphdDgAoWTPUpO
         FxFcrR3Vop7/JHuHjGq7Q8NA47P7ZW7JsAe7hdM0wcwOoaf0EeCiqynkWffYvsl4QZNk
         /7aA==
X-Gm-Message-State: AOAM533WlvKUg3pumABlD0Bczyz0TloOgMmEsT8NsrxcZO/F5z8NQhaW
        eNPDEFwmNNODR/NoW45LklgXIOlFx1hblvwujLZDRw6ZAbYJ54dFzv9FNTJ5ZVe8JLFVPJCJWOF
        L9JAGL8P/Isa+4CXYKrgqsiBY3a77ngIRfwuFdsQ/W4RlPrJ4HHQloirSyHLL12SwkxZQ8Qv3
X-Google-Smtp-Source: ABdhPJwGrxjV6sQ+79aRBFvtmuGCi22q1OfdwPYkSNZ1JHZ4zNkLjV9kBH8bIzdmXik79XvPQNVs1fxLRmzv
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:9090:561:5a98:6d47])
 (user=bgardon job=sendgmr) by 2002:aa7:9a48:0:b029:1b7:bb17:38c9 with SMTP id
 x8-20020aa79a480000b02901b7bb1738c9mr23164029pfj.51.1612292272799; Tue, 02
 Feb 2021 10:57:52 -0800 (PST)
Date:   Tue,  2 Feb 2021 10:57:14 -0800
In-Reply-To: <20210202185734.1680553-1-bgardon@google.com>
Message-Id: <20210202185734.1680553-9-bgardon@google.com>
Mime-Version: 1.0
References: <20210202185734.1680553-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 08/28] sched: Add cond_resched_rwlock
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Ben Gardon <bgardon@google.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Safely rescheduling while holding a spin lock is essential for keeping
long running kernel operations running smoothly. Add the facility to
cond_resched rwlocks.

CC: Ingo Molnar <mingo@redhat.com>
CC: Will Deacon <will@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 include/linux/sched.h | 12 ++++++++++++
 kernel/sched/core.c   | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5d1378e5a040..3052d16da3cf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1883,12 +1883,24 @@ static inline int _cond_resched(void) { return 0; }
 })
 
 extern int __cond_resched_lock(spinlock_t *lock);
+extern int __cond_resched_rwlock_read(rwlock_t *lock);
+extern int __cond_resched_rwlock_write(rwlock_t *lock);
 
 #define cond_resched_lock(lock) ({				\
 	___might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);\
 	__cond_resched_lock(lock);				\
 })
 
+#define cond_resched_rwlock_read(lock) ({			\
+	__might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
+	__cond_resched_rwlock_read(lock);			\
+})
+
+#define cond_resched_rwlock_write(lock) ({			\
+	__might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
+	__cond_resched_rwlock_write(lock);			\
+})
+
 static inline void cond_resched_rcu(void)
 {
 #if defined(CONFIG_DEBUG_ATOMIC_SLEEP) || !defined(CONFIG_PREEMPT_RCU)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ff74fca39ed2..efed1bf202d1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6709,6 +6709,46 @@ int __cond_resched_lock(spinlock_t *lock)
 }
 EXPORT_SYMBOL(__cond_resched_lock);
 
+int __cond_resched_rwlock_read(rwlock_t *lock)
+{
+	int resched = should_resched(PREEMPT_LOCK_OFFSET);
+	int ret = 0;
+
+	lockdep_assert_held_read(lock);
+
+	if (rwlock_needbreak(lock) || resched) {
+		read_unlock(lock);
+		if (resched)
+			preempt_schedule_common();
+		else
+			cpu_relax();
+		ret = 1;
+		read_lock(lock);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(__cond_resched_rwlock_read);
+
+int __cond_resched_rwlock_write(rwlock_t *lock)
+{
+	int resched = should_resched(PREEMPT_LOCK_OFFSET);
+	int ret = 0;
+
+	lockdep_assert_held_write(lock);
+
+	if (rwlock_needbreak(lock) || resched) {
+		write_unlock(lock);
+		if (resched)
+			preempt_schedule_common();
+		else
+			cpu_relax();
+		ret = 1;
+		write_lock(lock);
+	}
+	return ret;
+}
+EXPORT_SYMBOL(__cond_resched_rwlock_write);
+
 /**
  * yield - yield the current processor to other threads.
  *
-- 
2.30.0.365.g02bc693789-goog

