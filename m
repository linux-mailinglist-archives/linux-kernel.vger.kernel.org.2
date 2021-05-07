Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1A9376D7D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 01:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhEGXs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 19:48:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:50000 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229970AbhEGXsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 19:48:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63708B036;
        Fri,  7 May 2021 23:47:24 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     a.darwish@linutronix.de
Cc:     bigeasy@linutronix.de, peterz@infradead.org, tglx@linutronix.de,
        shung-hsi.yu@suse.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH v2] seqlock,lockdep: Only check for preemption_disabled in non-rt
Date:   Fri,  7 May 2021 16:47:13 -0700
Message-Id: <20210507234713.86097-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210507233951.78950-1-dave@stgolabs.net>
References: <20210507233951.78950-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This silences the writer hitting this nonsensical warning on PREEMPT_RT.

Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---

v2: Resending because I had left out some small comments I had meant to add.

 include/linux/seqlock.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index f61e34fbaaea..2ce3e1efc9a9 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -268,7 +268,9 @@ static inline bool __seqprop_preemptible(const seqcount_t *s)
 
 static inline void __seqprop_assert(const seqcount_t *s)
 {
+#ifndef CONFIG_PREEMPT_RT
 	lockdep_assert_preemption_disabled();
+#endif
 }
 
 #define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
@@ -529,6 +531,8 @@ static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
  * only if the seqcount write serialization lock is associated, and
  * preemptible.  If readers can be invoked from hardirq or softirq
  * context, interrupts or bottom halves must be respectively disabled.
+ * The PREEMPT_RT case relies on the reader serializing via LOCK+UNLOCK,
+ * so the context is preemptible.
  */
 #define write_seqcount_begin(s)						\
 do {									\
-- 
2.26.2

