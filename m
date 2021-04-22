Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF33F368061
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbhDVM2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236175AbhDVM2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:28:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79B9B61139;
        Thu, 22 Apr 2021 12:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619094455;
        bh=1p3tRbPn08LXUleX/SF1fIkiOMrYPYpqC5W1zRTTEnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQLKxwZJCvOdzh3TChKcCXWZrQ7FeIxSryYYP5MY06GQm3WSP+3RJm1yM2on2dn5c
         XFLTQ2DzA8OtJ2RHHnNn4hEIaDU7KdnaBOvmrTFcfCyIbAHwXTK88ZhjqjL7wIH66E
         A9rzrQcqis7a6ZTPtN/To3lRrxVD7wyyPTbUFfw+MuUWMwHD5bkDuiI+TOLvmYwnSc
         gsRnvbCUZf61Q7+h/S5/7ZVLYmMkc8TbG/cfS4CGnCm9H0pjUuQUrL7Kshl8W64n1z
         d9LH+i0EcWnR3sZf09QywuzyBDZrJX/piYc9EkOzErq0h1VfrWY+h0HyUZv2JWmjQk
         3dkjlpNyhGrXg==
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
Subject: [PATCH v11 1/9] Increase size of ucounts to atomic_long_t
Date:   Thu, 22 Apr 2021 14:27:08 +0200
Message-Id: <257aa5fb1a7d81cf0f4c34f39ada2320c4284771.1619094428.git.legion@kernel.org>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <cover.1619094428.git.legion@kernel.org>
References: <cover.1619094428.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Gladkov <legion@kernel.org>

RLIMIT_MSGQUEUE and RLIMIT_MEMLOCK use unsigned long to store their
counters. As a preparation for moving rlimits based on ucounts, we need
to increase the size of the variable to long.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/linux/user_namespace.h |  4 ++--
 kernel/ucount.c                | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 64cf8ebdc4ec..0bb833fd41f4 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -85,7 +85,7 @@ struct user_namespace {
 	struct ctl_table_header *sysctls;
 #endif
 	struct ucounts		*ucounts;
-	int ucount_max[UCOUNT_COUNTS];
+	long ucount_max[UCOUNT_COUNTS];
 } __randomize_layout;
 
 struct ucounts {
@@ -93,7 +93,7 @@ struct ucounts {
 	struct user_namespace *ns;
 	kuid_t uid;
 	int count;
-	atomic_t ucount[UCOUNT_COUNTS];
+	atomic_long_t ucount[UCOUNT_COUNTS];
 };
 
 extern struct user_namespace init_user_ns;
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 11b1596e2542..04c561751af1 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -175,14 +175,14 @@ static void put_ucounts(struct ucounts *ucounts)
 	kfree(ucounts);
 }
 
-static inline bool atomic_inc_below(atomic_t *v, int u)
+static inline bool atomic_long_inc_below(atomic_long_t *v, int u)
 {
-	int c, old;
-	c = atomic_read(v);
+	long c, old;
+	c = atomic_long_read(v);
 	for (;;) {
 		if (unlikely(c >= u))
 			return false;
-		old = atomic_cmpxchg(v, c, c+1);
+		old = atomic_long_cmpxchg(v, c, c+1);
 		if (likely(old == c))
 			return true;
 		c = old;
@@ -196,17 +196,17 @@ struct ucounts *inc_ucount(struct user_namespace *ns, kuid_t uid,
 	struct user_namespace *tns;
 	ucounts = get_ucounts(ns, uid);
 	for (iter = ucounts; iter; iter = tns->ucounts) {
-		int max;
+		long max;
 		tns = iter->ns;
 		max = READ_ONCE(tns->ucount_max[type]);
-		if (!atomic_inc_below(&iter->ucount[type], max))
+		if (!atomic_long_inc_below(&iter->ucount[type], max))
 			goto fail;
 	}
 	return ucounts;
 fail:
 	bad = iter;
 	for (iter = ucounts; iter != bad; iter = iter->ns->ucounts)
-		atomic_dec(&iter->ucount[type]);
+		atomic_long_dec(&iter->ucount[type]);
 
 	put_ucounts(ucounts);
 	return NULL;
@@ -216,7 +216,7 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
 {
 	struct ucounts *iter;
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		int dec = atomic_dec_if_positive(&iter->ucount[type]);
+		long dec = atomic_long_dec_if_positive(&iter->ucount[type]);
 		WARN_ON_ONCE(dec < 0);
 	}
 	put_ucounts(ucounts);
-- 
2.29.3

