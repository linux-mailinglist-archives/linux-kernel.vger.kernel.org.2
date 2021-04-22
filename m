Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2507E368063
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbhDVM2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236290AbhDVM2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:28:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC4D361164;
        Thu, 22 Apr 2021 12:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619094461;
        bh=ZxDzUmCaPFarls0Ci9yMZk7qkp2yroU/HJfRz/kxUTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N4CXRVTKKwlPu+wA5xxyn54vCVFUw/FM7WL/Z+652Dvw7j9CCR6T1RsF8SO5IycoT
         H4VMNdUmY3Y9txN1wg1EY7duGwGMjJ+L9j02XSvJEQWTO2EKO8wJv3PcR4Tbxvgk6E
         1dmAfuZLbpBu3XFyVNfuDfjdKrxT6yz06T/8CNwIm9ft7OeuA7oPIEieLjXpTsqvh9
         uqmYX9xwKD8dFZUvmGuUdIvQ0ZX6LajE1tBJ8P7sbFj6Ukt31aPFbQKRCpShlsvXdm
         xZ79auF9sPe2fOqFCG/5QwzQYFIfy5qcal8oH0k49BU5Yv2Aaa9XiLrhEXKedy4JQL
         hNiy+X30aL6Ww==
From:   legion@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-mm@kvack.org
Cc:     Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v11 3/9] Use atomic_t for ucounts reference counting
Date:   Thu, 22 Apr 2021 14:27:10 +0200
Message-Id: <94d1dbecab060a6b116b0a2d1accd8ca1bbb4f5f.1619094428.git.legion@kernel.org>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <cover.1619094428.git.legion@kernel.org>
References: <cover.1619094428.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Gladkov <legion@kernel.org>

The current implementation of the ucounts reference counter requires the
use of spin_lock. We're going to use get_ucounts() in more performance
critical areas like a handling of RLIMIT_SIGPENDING.

Now we need to use spin_lock only if we want to change the hashtable.

v10:
* Always try to put ucounts in case we cannot increase ucounts->count.
  This will allow to cover the case when all consumers will return
  ucounts at once.

v9:
* Use a negative value to check that the ucounts->count is close to
  overflow.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/linux/user_namespace.h |  4 +--
 kernel/ucount.c                | 53 ++++++++++++----------------------
 2 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index f71b5a4a3e74..d84cc2c0b443 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -92,7 +92,7 @@ struct ucounts {
 	struct hlist_node node;
 	struct user_namespace *ns;
 	kuid_t uid;
-	int count;
+	atomic_t count;
 	atomic_long_t ucount[UCOUNT_COUNTS];
 };
 
@@ -104,7 +104,7 @@ void retire_userns_sysctls(struct user_namespace *ns);
 struct ucounts *inc_ucount(struct user_namespace *ns, kuid_t uid, enum ucount_type type);
 void dec_ucount(struct ucounts *ucounts, enum ucount_type type);
 struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid);
-struct ucounts *get_ucounts(struct ucounts *ucounts);
+struct ucounts * __must_check get_ucounts(struct ucounts *ucounts);
 void put_ucounts(struct ucounts *ucounts);
 
 #ifdef CONFIG_USER_NS
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 50cc1dfb7d28..365865f368ec 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -11,7 +11,7 @@
 struct ucounts init_ucounts = {
 	.ns    = &init_user_ns,
 	.uid   = GLOBAL_ROOT_UID,
-	.count = 1,
+	.count = ATOMIC_INIT(1),
 };
 
 #define UCOUNTS_HASHTABLE_BITS 10
@@ -139,6 +139,15 @@ static void hlist_add_ucounts(struct ucounts *ucounts)
 	spin_unlock_irq(&ucounts_lock);
 }
 
+struct ucounts *get_ucounts(struct ucounts *ucounts)
+{
+	if (ucounts && atomic_add_negative(1, &ucounts->count)) {
+		put_ucounts(ucounts);
+		ucounts = NULL;
+	}
+	return ucounts;
+}
+
 struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 {
 	struct hlist_head *hashent = ucounts_hashentry(ns, uid);
@@ -155,7 +164,7 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 
 		new->ns = ns;
 		new->uid = uid;
-		new->count = 0;
+		atomic_set(&new->count, 1);
 
 		spin_lock_irq(&ucounts_lock);
 		ucounts = find_ucounts(ns, uid, hashent);
@@ -163,33 +172,12 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 			kfree(new);
 		} else {
 			hlist_add_head(&new->node, hashent);
-			ucounts = new;
+			spin_unlock_irq(&ucounts_lock);
+			return new;
 		}
 	}
-	if (ucounts->count == INT_MAX)
-		ucounts = NULL;
-	else
-		ucounts->count += 1;
 	spin_unlock_irq(&ucounts_lock);
-	return ucounts;
-}
-
-struct ucounts *get_ucounts(struct ucounts *ucounts)
-{
-	unsigned long flags;
-
-	if (!ucounts)
-		return NULL;
-
-	spin_lock_irqsave(&ucounts_lock, flags);
-	if (ucounts->count == INT_MAX) {
-		WARN_ONCE(1, "ucounts: counter has reached its maximum value");
-		ucounts = NULL;
-	} else {
-		ucounts->count += 1;
-	}
-	spin_unlock_irqrestore(&ucounts_lock, flags);
-
+	ucounts = get_ucounts(ucounts);
 	return ucounts;
 }
 
@@ -197,15 +185,12 @@ void put_ucounts(struct ucounts *ucounts)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&ucounts_lock, flags);
-	ucounts->count -= 1;
-	if (!ucounts->count)
+	if (atomic_dec_and_test(&ucounts->count)) {
+		spin_lock_irqsave(&ucounts_lock, flags);
 		hlist_del_init(&ucounts->node);
-	else
-		ucounts = NULL;
-	spin_unlock_irqrestore(&ucounts_lock, flags);
-
-	kfree(ucounts);
+		spin_unlock_irqrestore(&ucounts_lock, flags);
+		kfree(ucounts);
+	}
 }
 
 static inline bool atomic_long_inc_below(atomic_long_t *v, int u)
-- 
2.29.3

