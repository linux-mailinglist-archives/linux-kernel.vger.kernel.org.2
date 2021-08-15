Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D533ECB42
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhHOVbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:31:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47904 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhHOV21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:27 -0400
Message-ID: <20210815211302.668958502@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nz6iNRswOxKTf/LxISV+nf59LcGBzNa2Ih1pkjs3ys4=;
        b=qfRgr5Cf+eOPl20iz7SwruapugD5pHNhwNzxza71/OtzX47g82eq6zhLHpWiOpwu1P/XC/
        5+ZAw6aP315zVHB7J+x1rnQVblxi3KbXjcJA9Ka3PdzK+HNj3SlmwbtFaF7baTaZ1C3A1+
        cElOG2tW6pkoMLwdUrcXzuZOTDSK1cDmtO+xgv03J71y4Fd5iw0nHpRhfoOcy5mX+3C4Gp
        qgwiFOxE4NXQURsOocPrLlNSUap818O/0lvMGj28m8mJvS4LankDbrQvAzyqzn1+XkHsOt
        O0grD5NM2HJGKLLVJ53x0B9BWHVrrX/8zy+MS4dv5/afqjuSoJItBAmz/ss6Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nz6iNRswOxKTf/LxISV+nf59LcGBzNa2Ih1pkjs3ys4=;
        b=QrYqhQgegUfiHDSIqODIck7JIWu1vjkkXwymLZMDuT1RxyQ8mV8/MtpO99u9b3BHN2vQqi
        tgCe3Dwv++NOKyDw==
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
Subject: [patch V5 13/72] rtmutex: Switch to try_cmpxchg()
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:27:55 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Allows the compiler to generate better code depending on the architecture.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -145,14 +145,14 @@ static __always_inline bool rt_mutex_cmp
 						     struct task_struct *old,
 						     struct task_struct *new)
 {
-	return cmpxchg_acquire(&lock->owner, old, new) == old;
+	return try_cmpxchg_acquire(&lock->owner, &old, new);
 }
 
 static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
 {
-	return cmpxchg_release(&lock->owner, old, new) == old;
+	return try_cmpxchg_release(&lock->owner, &old, new);
 }
 
 /*

