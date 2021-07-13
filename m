Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE303C73F6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhGMQQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhGMQQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80708C061787
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:13:19 -0700 (PDT)
Message-Id: <20210713160746.708726136@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nz6iNRswOxKTf/LxISV+nf59LcGBzNa2Ih1pkjs3ys4=;
        b=gi/GbJesdM/9CR63O1k1ppIVixuPK6gJPVmZZiB5q75bILWbyhiEwUSOjNToVBTHN+izhY
        FOCZmOZWn9j0jOA+JSvDbAfLQNw0T1UXOUAiVzPPoje6AL5G6bLBmgELgfSgVP/JFeAMkt
        41eK1/Jwh2FwTl4iB7SKcVDxy/B7klsWiZCQbEpJhtL/s+sVONaRCReT1yx8NBhvlwrSJV
        Zds3gm7vBqi9GbZVKfkWvvsdD/ZZBt9jJBrBWpxL7c3Ld5EO/vWCvlBZ83BzYPx3ecSNVp
        13D3latVKMiJdyJrpNQoy+iN4zWzTwcqPKlaVjSCYzSXEt5qo8BJ8i+N5svLAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nz6iNRswOxKTf/LxISV+nf59LcGBzNa2Ih1pkjs3ys4=;
        b=Dv0sqOHwfGfiy1oyNP9VeUcoe0n3xE1154Owj6oJTP8LDg/I49NrYDxo4/QJWVMdpI3VcM
        wovNHYYmHDIGivCQ==
Date:   Tue, 13 Jul 2021 17:11:02 +0200
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
Subject: [patch 08/50] rtmutex: Switch to try_cmpxchg()
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
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

