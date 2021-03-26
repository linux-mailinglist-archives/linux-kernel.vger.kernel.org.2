Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CE234AC35
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhCZQCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:02:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55940 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhCZQBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:01:46 -0400
Message-Id: <20210326153944.341734608@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616774505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SUetKN6Dowta8u6U+2fHm2aPhHmi8x/OTOyI4/8aZFs=;
        b=vYEDTtuN6YumvDd8ezOyd0jcKrenVhF9yr1U+MCDc41pHTjBe9cwr8uq1AWVPU1/A+jBZz
        ghK1iwXuwLTdQHCBYCBl9ujFapBkGxRc64AoJ29tT5ViVcwrkqUKET+Z1iO6DhrrxD5ILc
        H0u3qESus84wxYAJJwaEH9rgIJdnobcdEX/GmhiG4UDGV2A0REJrk9eFx3ISp2VvjOH7P0
        f85UovHYQ+buJEvqdkVf36dVgJk38RyHPcGDRB9zCHwMcZBo3N/fUFRB+uDv7QxlAkxzka
        X3AY9oJJVVA4T3HWAL/ncum87J6abwnkBuc8A9H2DyEOJ7V5K+DwDbuL6JsJBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616774505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SUetKN6Dowta8u6U+2fHm2aPhHmi8x/OTOyI4/8aZFs=;
        b=nIlFQ0CXFvtvKGZ3QsTAXTYfjxO8Bo7b4FhFRExM6+AriQth7Jx5tB3HFU37IL8FCnIeGG
        F8t4dPAZmlxJnJAA==
Date:   Fri, 26 Mar 2021 16:29:42 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 13/15] locking/rtmutex: Fix misleading comment in
 rt_mutex_postunlock()
References: <20210326152929.709289883@linutronix.de>
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
 

