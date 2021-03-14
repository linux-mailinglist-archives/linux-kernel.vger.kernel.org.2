Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7EA33A579
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 16:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbhCNPkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 11:40:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58086 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhCNPkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 11:40:23 -0400
Date:   Sun, 14 Mar 2021 15:39:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615736422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=i7yEYORQeN4Stu+g8HfLn3y/YUFekmSilctO59NRSZc=;
        b=AHViYEglV6GmBu6Gj+ekiOegURVRILpTCxPLWeiRu3yVs84KbXCViIgl8uuKOOe14QMBxF
        R2nLwj+VZCjxAJ1y9NuLUv2zzRA/v7qjXJZKkxg+QqJlBLLqLthnWsYe2C0c//QF662GTW
        bOtk4v4d7Ou2e84ecCNzANrjqiVKRPiUQU2SJNqlKaq+VyxFzgfzXew9/Cqp6FBHQsi2vx
        Lh2uCAP8c2MUum4ArXle3BVMVO3en8dq98oSJV8sUZLRExMIjQYz0DK7N3uLDLbZtc+JVT
        3GTPu42eAoEjXyNGhwP1dLrzJiuZ9ivN94vxuQRBaxH+MmSr/wJ5pyH77/zFmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615736422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=i7yEYORQeN4Stu+g8HfLn3y/YUFekmSilctO59NRSZc=;
        b=14OYnA8nQW1f273du5/4KNPyOUpEcr1LsUzdIryNGjyGB7Hb4c2cE6RGyzl4auvQSNhPtE
        0irTmqowyD+gzSCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for v5.12-rc3
Message-ID: <161573639668.27979.17827928369874291298.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-03-14

up to:  4817a52b3061: seqlock,lockdep: Fix seqcount_latch_init()


A couple of locking fixes:
 
 - A fix for the static_call mechanism so it handles unaligned
   addresses correctly.

 - Make u64_stats_init() a macro so every instance gets a seperate lockdep
   key.

 - Make seqcount_latch_init() a macro as well to preserve the static
   variable which is used for the lockdep key.

Thanks,

	tglx

------------------>
Peter Zijlstra (3):
      static_call: Fix the module key fixup
      u64_stats,lockdep: Fix u64_stats_init() vs lockdep
      seqlock,lockdep: Fix seqcount_latch_init()


 include/linux/seqlock.h        | 5 +----
 include/linux/u64_stats_sync.h | 7 ++++---
 kernel/static_call.c           | 7 ++++---
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 2f7bb92b4c9e..f61e34fbaaea 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -664,10 +664,7 @@ typedef struct {
  * seqcount_latch_init() - runtime initializer for seqcount_latch_t
  * @s: Pointer to the seqcount_latch_t instance
  */
-static inline void seqcount_latch_init(seqcount_latch_t *s)
-{
-	seqcount_init(&s->seqcount);
-}
+#define seqcount_latch_init(s) seqcount_init(&(s)->seqcount)
 
 /**
  * raw_read_seqcount_latch() - pick even/odd latch data copy
diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index c6abb79501b3..e81856c0ba13 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -115,12 +115,13 @@ static inline void u64_stats_inc(u64_stats_t *p)
 }
 #endif
 
+#if BITS_PER_LONG == 32 && defined(CONFIG_SMP)
+#define u64_stats_init(syncp)	seqcount_init(&(syncp)->seq)
+#else
 static inline void u64_stats_init(struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG == 32 && defined(CONFIG_SMP)
-	seqcount_init(&syncp->seq);
-#endif
 }
+#endif
 
 static inline void u64_stats_update_begin(struct u64_stats_sync *syncp)
 {
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 6906c6ec4c97..ae825295cf68 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -349,7 +349,8 @@ static int static_call_add_module(struct module *mod)
 	struct static_call_site *site;
 
 	for (site = start; site != stop; site++) {
-		unsigned long addr = (unsigned long)static_call_key(site);
+		unsigned long s_key = (long)site->key + (long)&site->key;
+		unsigned long addr = s_key & ~STATIC_CALL_SITE_FLAGS;
 		unsigned long key;
 
 		/*
@@ -373,8 +374,8 @@ static int static_call_add_module(struct module *mod)
 			return -EINVAL;
 		}
 
-		site->key = (key - (long)&site->key) |
-			    (site->key & STATIC_CALL_SITE_FLAGS);
+		key |= s_key & STATIC_CALL_SITE_FLAGS;
+		site->key = key - (long)&site->key;
 	}
 
 	return __static_call_init(mod, start, stop);

