Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7763C740D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhGMQQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhGMQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7526CC0613EF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:13:35 -0700 (PDT)
Message-Id: <20210713160747.999380797@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ybL4eQWJRMPJIx6nf99W6RVd4rsxPXFJjQkLHNfZ2Dg=;
        b=0WENqb0ySiHRdf21757dgrWqV7Hv/iYCfYt6kgsKaUpS7cLAoTKrhEN1IMW6LY4U43NTEC
        9MB9mGlA/PvS2oLlJtxIcN9iC0A10xNO2uq7cMMhRhRc26orDyQ6hlC0rS2CcygpfJs4hN
        Qpgy5t6UQcAO8xxQDWVPk+d6K1YLjJmkljNpjZBA0QKm/BYlRjhI4/lbLiDv7+WuWqzq1D
        IGp3iky8LBY/F7EVzBgIXAMxJFrn1umCTfWTpKkxNUjMyuLR7FqZqAFWLP5R4AM/3eI8A2
        pqljVvj9u+XkyqnKBoBUzgzsvmZxia2C2uiyg3PMKdv7Rsiqlt8cuqbYmaJOHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ybL4eQWJRMPJIx6nf99W6RVd4rsxPXFJjQkLHNfZ2Dg=;
        b=7DdDV1yfP7gcybMjhoX7YYwFLRpgtXPuOZaIP3hUyyaE9enO5nJ58GESDNJtiUYuQgvzoI
        qdlg7G5oKy+Kw7Cg==
Date:   Tue, 13 Jul 2021 17:11:15 +0200
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
Subject: [patch 21/50] locking/lockdep: Reduce includes in debug_locks.h
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The inclusion of printk.h leads to a circular dependency if spinlock_t is
based on rtmutexes on RT enabled kernels.

Include only atomic.h (xchg()) and cache.h (__read_mostly) which is all
what debug_locks.h requires.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/debug_locks.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
---
diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index edb5c186b0b7..3f49e65169c6 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -3,8 +3,7 @@
 #define __LINUX_DEBUG_LOCKING_H
 
 #include <linux/atomic.h>
-#include <linux/bug.h>
-#include <linux/printk.h>
+#include <linux/cache.h>
 
 struct task_struct;
 

