Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110853C741D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhGMQRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54590 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbhGMQQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:44 -0400
Message-Id: <20210713160749.555316784@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=lcAp2Ebv6+16F0mxDdVyBQ2nBOEkR1oO/tMuHXyVnUo=;
        b=Lpusjd14Ya4gPNRmOGE4TNoXGNGGmtRq+MegXd5VAc+0DZP22ENzGb/HtYTiwVFuTqdkET
        iELY/pAtlmgAhsEfkKGKYtCaNV6qt2T8uyDTNIj2BuGNDG+AKrTFX7FGX0awcZRzuNdJps
        ETvHl4wry8Hnmzoj6DJpzj2I9DTvlBnz29UQ+hBUJmoNafh1Qz4AFCjjHz2FYsAQVIhTIu
        wNgUYbEmnPuleCRs4k31cAEVuvnjS5Z12uKa1pM0Kxj8vP+1ZXxmJhXFbVuetq3f398ocE
        WGbhxpMUfo80xxhBtW2B3KSeCF/vvzET2P6lZakgjvkNYj9Tasar6VxDOztb+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=lcAp2Ebv6+16F0mxDdVyBQ2nBOEkR1oO/tMuHXyVnUo=;
        b=pXtZCf8yvaMqUhamsPyR1R1PRNQ9EDJNaZWGSCTIasLS9UmjcjtnMXoN0h9JGxO7hckH1o
        frX6GjyR/+zo7IAg==
Date:   Tue, 13 Jul 2021 17:11:31 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [patch 37/50] locking/mutex: Rearrange items in mutex.h
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Move the lockdep map initializer to a different place so it can be shared
with the upcoming RT variant of struct mutex.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mutex.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)
---
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 9183e3f7911d..827c32bb44bc 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -49,6 +49,16 @@
  *   locks and tasks (and only those tasks)
  */
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
+		, .dep_map = {					\
+			.name = #lockname,			\
+			.wait_type_inner = LD_WAIT_SLEEP,	\
+		}
+#else
+# define __DEP_MAP_MUTEX_INITIALIZER(lockname)
+#endif
+
 /*
  * Typedef _mutex_t for ww_mutex and core code to allow ww_mutex being
  * built on the regular mutex code in RT kernels while mutex itself is
@@ -104,16 +114,6 @@ do {									\
 	__mutex_t_init((mutex), name, key);				\
 } while (0)
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
-		, .dep_map = {					\
-			.name = #lockname,			\
-			.wait_type_inner = LD_WAIT_SLEEP,	\
-		}
-#else
-# define __DEP_MAP_MUTEX_INITIALIZER(lockname)
-#endif
-
 #define __MUTEX_INITIALIZER(lockname) \
 		{ .owner = ATOMIC_LONG_INIT(0) \
 		, .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \

