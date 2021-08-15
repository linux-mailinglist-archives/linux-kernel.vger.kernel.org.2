Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0584D3ECB5E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhHOVdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:33:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48676 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhHOV3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:53 -0400
Message-ID: <20210815211305.804246275@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wk5BXs3QliWC0Aueq/uB6S39gsRmV857OufixmfHlos=;
        b=iPZhgxGEoKV5Dq51OFseto6VMdWdjwE+uY8e1prak5toBE0/FAaTjkD8Eai88V2BJGTloa
        LeTAOyAZ2IKsZiIsEddme+lftSAiVl4T1hWDGaYFvHK4SB8HH15Bg4y1cNni5QKtNX/G/K
        dXdwyso8KsOsUBY3Kd0wUQbfZkbEXHfcLDAgSwXKNixwIAaM+A8GnfdX1xteoGpx2rxUZx
        M821I5M6tR4mUcJbRFSyH1AhfYnPsXDQf0OYX0AFO2oVa9DcZYkzxY8WpU/aDxqrfI5cFB
        E4mJdd9W3LZEiPbk6FZ9rjiF/4TJVTGdCk3FBGkhP3w+cflsSv+XPQ+fOWZagQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wk5BXs3QliWC0Aueq/uB6S39gsRmV857OufixmfHlos=;
        b=VUh4Y0rfUFlA9EcGXkafiC0OmwCqBbIMRXwQX6rMe7kojZyuzJx/hJuvjVVqzbrcwRmfB3
        FlPKhzjBaGtxbOBg==
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
Subject: [patch V5 68/72] preempt: Adjust PREEMPT_LOCK_OFFSET for RT
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:29:22 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

On PREEMPT_RT regular spinlocks and rwlocks are substituted with rtmutex
based constructs. spin/rwlock held regions are preemptible on PREEMPT_RT,
so PREEMPT_LOCK_OFFSET has to be 0 to make the various cond_resched_*lock()
functions work correctly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/preempt.h |    4 ++++
 1 file changed, 4 insertions(+)
---
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -121,7 +121,11 @@
 /*
  * The preempt_count offset after spin_lock()
  */
+#if !defined(CONFIG_PREEMPT_RT)
 #define PREEMPT_LOCK_OFFSET	PREEMPT_DISABLE_OFFSET
+#else
+#define PREEMPT_LOCK_OFFSET	0
+#endif
 
 /*
  * The preempt_count offset needed for things like:

