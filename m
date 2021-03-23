Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF23346B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhCWVln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:41:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35976 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbhCWVj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:39:57 -0400
Message-Id: <20210323213708.809432652@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616535595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SUetKN6Dowta8u6U+2fHm2aPhHmi8x/OTOyI4/8aZFs=;
        b=LAggu9fpSgNnRzf58+xneOfo2v2LDi9PFo6WVHRbx3XVLg0BugjohsmZEsA1uT+1eVoMeG
        5bZgc1NJQfcZZK5M56pFD18XrSHtaQkqMrFjQbwR5W5X7C54cvM6cx6RCHfnWcXIc7e06B
        grkNrpNdcFy7gxrYCtth5vz2KLhxsiKJEyv3z0FI/H5+meVpVC5WCFmM6r9vACmhzQh+c8
        u9NhxPYoDlkMrk0Q3LffuBjtiB5wzlPkf6odV+RWAL2aQO/ZSYJb5O6HIAha4KmpG8DErK
        mxPELj71a+YA3feK3MgJ+z4nl6hDgpojhKqkp6Lev7kOvx+30Vr8/E2jIwyt4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616535595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SUetKN6Dowta8u6U+2fHm2aPhHmi8x/OTOyI4/8aZFs=;
        b=xKgnZ3YaWaVdar9lDG0xeRTJhTGiuXHTFkvMOgih15z7CBBZGB9vS0u9f7OEHXT1YcmGSa
        BvVDNcd/6lgB2fAA==
Date:   Tue, 23 Mar 2021 22:30:32 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 13/14] locking/rtmutex: Fix misleading comment in
 rt_mutex_postunlock()
References: <20210323213019.217008708@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preemption is disabled in mark_wakeup_next_waiter() not in
rt_mutex_slowunlock().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1305,7 +1305,7 @@ void __sched rt_mutex_postunlock(struct
 {
 	wake_up_q(wake_q);
 
-	/* Pairs with preempt_disable() in rt_mutex_slowunlock() */
+	/* Pairs with preempt_disable() in mark_wakeup_next_waiter() */
 	preempt_enable();
 }
 

