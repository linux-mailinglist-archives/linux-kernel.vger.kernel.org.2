Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB8A3E1852
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242366AbhHEPmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:42:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241840AbhHEPlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:41:32 -0400
Message-ID: <20210805153953.330389528@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qoh8d3hfSvvuGtm/7GyzaEgA5QXxkK7VldYhzUcnH+E=;
        b=G5LiPg5EuCaYAo0EdtqfTnHtXuqi7+5o9vLP9ZvCQuoj+QAG3Gcpzsd7yaN+nfGjFK7LFL
        E38omGm+2PGL+VCOBlGRmpyOcGbOSVsB630m3ulacesaLXhkCBdCDfcjzLQrfpduJyCc0A
        78SRtg8MgOPt6hD0YE3K2KXfGEuZWRWZOIVpzQGbYNq2lr5ns60dMNqoy1g7DNGku5bQLh
        DP9MLMtmJXYzdairHfU1XZbQMbrCWObN3ZN7OGTlIOYyrWWZCM5i+dtpvfAwBIlcIPPQVh
        BUrruQ50NCk7D0T1xG68q87N/j1us8vE5e4vwDstmm+85kspC/Yz/30zcmfl6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qoh8d3hfSvvuGtm/7GyzaEgA5QXxkK7VldYhzUcnH+E=;
        b=KJjhJYkrDJJ1u+0fBOijL+KTAelpND0u7z2Wwl+5ltHv/MWYSm1PiOsrnPOinN7bO3Pi1Y
        stWem+z2Mzo1vKAQ==
Date:   Thu, 05 Aug 2021 17:13:09 +0200
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
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: [patch V3 09/64] rtmutex: Remove rt_mutex_is_locked()
References: <20210805151300.330412127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

No more users.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rtmutex.h |   11 -----------
 1 file changed, 11 deletions(-)

--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -67,17 +67,6 @@ do { \
 #define DEFINE_RT_MUTEX(mutexname) \
 	struct rt_mutex mutexname = __RT_MUTEX_INITIALIZER(mutexname)
 
-/**
- * rt_mutex_is_locked - is the mutex locked
- * @lock: the mutex to be queried
- *
- * Returns 1 if the mutex is locked, 0 if unlocked.
- */
-static inline int rt_mutex_is_locked(struct rt_mutex *lock)
-{
-	return lock->owner != NULL;
-}
-
 extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC

