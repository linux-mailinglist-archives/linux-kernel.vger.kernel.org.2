Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20A530CAD4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbhBBTBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239265AbhBBS7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:59:39 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD45C0617AB
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:57:50 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id e2so14797400pgg.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2jALOnR02DelYQsUJSUDQ9Zj6pptUDPmbQP0oTGAN5k=;
        b=Iev1zX72MfK7mD5itgi9KXbRFo17KVmLsFSv3pkVFuJA56XKPonwgx4fyJLFQFFuPQ
         1qqgfd5EZyJ8faqztnNf/X34uP3WvAVpLYuKv9yoShz8iwOBTAwHzQDi5WzTnVveprJs
         RrpoX6LFPZfYUIZ7tqxPpOYwi3i2hMR3gtYumreFEWQLAGsIlKQK7wULg3yjsIVQ/t1v
         a/kR6kdfBC7uLLm3D7koCOuPg+I5Tbsy00wlJ50eCxZtvliRdbiYFuT22Xro5nrXnJpt
         newSqu6vAiwQB6Zj3k4hWYYfNYE0vRdzBp5rYeG2ENS1o+/mXCiWd660JKRKVumOrNpK
         sbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2jALOnR02DelYQsUJSUDQ9Zj6pptUDPmbQP0oTGAN5k=;
        b=CPhC03YSzRVVO1oOXeNKNGdOTg+Y2pwmygVVyoH7F22Ef2MpTNSQSZcQGzNWYP3Rf1
         tUA9S7QFw6AmxnZJUZJIIjKWJ/ZicecesbG61fBfryOtr/cnm1LAH2ctZ3JDP1uwOgLy
         pxyCIRH50BZuLwl9dtfuePgSuLk6v/jPKbWXmJN34offp2r21/U1c4lk66Bfzd2VKotB
         SQbCU+6mznDw5uAjJY8LB2ZFQoPSAmho+veTt/ZjFqO7iFIt6VDLWilDz94/C3wp73Ok
         UZu12djtKgYnFKpy9x1ACRoU4ygIM37H29wEJIiv39lCflnS9JZqA+hzFotVthYcwdRV
         T2Qw==
X-Gm-Message-State: AOAM531qQDw9B3RtfYHPRIohVFJ+WIgnLrQzkmgnvSq1wN34mFCiL8mR
        LpjJT/Ke5UXYM5hyCcmrcpspRbv95uNGumW/RUdZZuanGgBg3GJ3kqZ2BBDd51BxstcGFqsEn1I
        m6U0efzTJms3QRCijr9SjU+JHA2jYQtrKXyPMfmTlUTmQKS4DCNYTfRXZ+e04u6hbP3VsYpb2
X-Google-Smtp-Source: ABdhPJxT7zsP4FMf12L3RkWtR7DMzVl1GMgVhCc5fj2RYAmrngkxUabKWYjAkS0v/TGl4HDYLG4nU9xuFPXy
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:9090:561:5a98:6d47])
 (user=bgardon job=sendgmr) by 2002:a17:902:7c88:b029:e1:c7d:c271 with SMTP id
 y8-20020a1709027c88b02900e10c7dc271mr24095510pll.74.1612292269427; Tue, 02
 Feb 2021 10:57:49 -0800 (PST)
Date:   Tue,  2 Feb 2021 10:57:12 -0800
In-Reply-To: <20210202185734.1680553-1-bgardon@google.com>
Message-Id: <20210202185734.1680553-7-bgardon@google.com>
Mime-Version: 1.0
References: <20210202185734.1680553-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 06/28] locking/rwlocks: Add contention detection for rwlocks
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

rwlocks do not currently have any facility to detect contention
like spinlocks do. In order to allow users of rwlocks to better manage
latency, add contention detection for queued rwlocks.

CC: Ingo Molnar <mingo@redhat.com>
CC: Will Deacon <will@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 include/asm-generic/qrwlock.h | 24 ++++++++++++++++++------
 include/linux/rwlock.h        |  7 +++++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 84ce841ce735..0020d3b820a7 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -14,6 +14,7 @@
 #include <asm/processor.h>
 
 #include <asm-generic/qrwlock_types.h>
+#include <asm-generic/qspinlock.h>
 
 /*
  * Writer states & reader shift and bias.
@@ -116,15 +117,26 @@ static inline void queued_write_unlock(struct qrwlock *lock)
 	smp_store_release(&lock->wlocked, 0);
 }
 
+/**
+ * queued_rwlock_is_contended - check if the lock is contended
+ * @lock : Pointer to queue rwlock structure
+ * Return: 1 if lock contended, 0 otherwise
+ */
+static inline int queued_rwlock_is_contended(struct qrwlock *lock)
+{
+	return arch_spin_is_locked(&lock->wait_lock);
+}
+
 /*
  * Remapping rwlock architecture specific functions to the corresponding
  * queue rwlock functions.
  */
-#define arch_read_lock(l)	queued_read_lock(l)
-#define arch_write_lock(l)	queued_write_lock(l)
-#define arch_read_trylock(l)	queued_read_trylock(l)
-#define arch_write_trylock(l)	queued_write_trylock(l)
-#define arch_read_unlock(l)	queued_read_unlock(l)
-#define arch_write_unlock(l)	queued_write_unlock(l)
+#define arch_read_lock(l)		queued_read_lock(l)
+#define arch_write_lock(l)		queued_write_lock(l)
+#define arch_read_trylock(l)		queued_read_trylock(l)
+#define arch_write_trylock(l)		queued_write_trylock(l)
+#define arch_read_unlock(l)		queued_read_unlock(l)
+#define arch_write_unlock(l)		queued_write_unlock(l)
+#define arch_rwlock_is_contended(l)	queued_rwlock_is_contended(l)
 
 #endif /* __ASM_GENERIC_QRWLOCK_H */
diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 3dcd617e65ae..7ce9a51ae5c0 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -128,4 +128,11 @@ do {								\
 	1 : ({ local_irq_restore(flags); 0; }); \
 })
 
+#ifdef arch_rwlock_is_contended
+#define rwlock_is_contended(lock) \
+	 arch_rwlock_is_contended(&(lock)->raw_lock)
+#else
+#define rwlock_is_contended(lock)	((void)(lock), 0)
+#endif /* arch_rwlock_is_contended */
+
 #endif /* __LINUX_RWLOCK_H */
-- 
2.30.0.365.g02bc693789-goog

