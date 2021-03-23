Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A59346B45
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhCWVl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:41:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35868 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbhCWVjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:39:49 -0400
Message-Id: <20210323213708.195031688@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616535588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=erVQNMrM1P/5eIpWf0Wv6X7PSPbYJedxbQMK3vysrrw=;
        b=hDTYP5gPamcoNwqu5TbvpfI5yhxF2xN23ZLMQdTfVujXizEDE1lBG0M6jk+RXQD+BYjEeP
        f06U7Xgfm0LS2n4lgnoEgUZtECOEk0PGE7iU2zqU79IBBWZzpZseZyRaJpqNrxSppaAEhM
        TegYJzG//5kNV8qbpEXfuczH3igx6V5lG5ZL1iypnb+7gDgIaJni/F75jAhx7v1JR8hoS3
        P+SXXT0EYChVylOGCc4xS5m+oDxp69+9vUFudGFY15CQSVoEpm1Xs1Bf0JWu7nxsPMEsSV
        upIDkEiF8MCuLSHaRoNpQD8JqS1AqXroL6lkvwb///fhO7p2jCr5w7K5qyMV5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616535588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=erVQNMrM1P/5eIpWf0Wv6X7PSPbYJedxbQMK3vysrrw=;
        b=Ir/kVzg7yIfg626XDK44l7lxPBHoDoQkTgfyg1bEizlIcDX4aD1lquNzRCnTplVju0csMQ
        PA+PKQDJKWdNLoDA==
Date:   Tue, 23 Mar 2021 22:30:26 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 07/14] locking/rtmutex: Inline chainwalk depth check
References: <20210323213019.217008708@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point for this wrapper at all.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -343,14 +343,9 @@ static void rt_mutex_adjust_prio(struct
 static bool rt_mutex_cond_detect_deadlock(struct rt_mutex_waiter *waiter,
 					  enum rtmutex_chainwalk chwalk)
 {
-	/*
-	 * This is just a wrapper function for the following call,
-	 * because debug_rt_mutex_detect_deadlock() smells like a magic
-	 * debug feature and I wanted to keep the cond function in the
-	 * main source file along with the comments instead of having
-	 * two of the same in the headers.
-	 */
-	return debug_rt_mutex_detect_deadlock(waiter, chwalk);
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEX))
+		return waiter != NULL;
+	return chwalk == RT_MUTEX_FULL_CHAINWALK;
 }
 
 /*

