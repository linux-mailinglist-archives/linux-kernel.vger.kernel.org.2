Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A973C7421
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhGMQRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54698 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhGMQQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:49 -0400
Message-Id: <20210713160749.961050050@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=35IiguvMjyN9HS4qOQgfmae19noJXTGdkXOwXWuAzuM=;
        b=YkO68uKN/+nUuPh4Oiy+tXzhg2sJh7ru68wEnOjOEcth5ZUrw3YLyLhCQhb5pqsSIhZPaS
        RyUpoHNnWx97XiM3pXymB24xsmUl0cW4f3kZyk4romgsHBqDMrRgLfxR5565+BnAghMwSB
        USnf+nwcZwai7XY/Wa+yqHnaTeeQExdusFx0y38sU0GzG2oN8VLESTNluP4awtBu+uY039
        FXEKnmHx1Z3jfkfy1dEzivfvWFMP2X3lzGf7dtXsJLTaHO7yD5zxurGAmh+N3IjLNBCI8q
        U+GFBA2AhljT80uM3pjOGybuHd6N3uMeSjqReiIo3RC2lDIlswO6EIFYqtB81g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=35IiguvMjyN9HS4qOQgfmae19noJXTGdkXOwXWuAzuM=;
        b=rhgoLui0l9iQ1QNg4u/voiRa2HEErlocL1O2CR3m2fCa2nHknNRDgUnbBq4p5QgmRq/TZX
        +hD7QTQMOZk0wQBg==
Date:   Tue, 13 Jul 2021 17:11:35 +0200
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
Subject: [patch 41/50] futex: Validate waiter correctly in
 futex_proxy_trylock_atomic()
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The loop in futex_requeue() has a sanity check for the waiter which is
missing in futex_proxy_trylock_atomic(). In theory the key2 check is
sufficient, but futexes are cursed so add it for completness and paranoia
sake.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c |    4 ++++
 1 file changed, 4 insertions(+)
---
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1879,6 +1879,10 @@ futex_proxy_trylock_atomic(u32 __user *p
 	if (!top_waiter)
 		return 0;
 
+	/* Ensure that this is a waiter sitting in futex_wait_requeue_pi() */
+	if (!top_waiter->rt_waiter || top_waiter->pi_state)
+		ret = -EINVAL;
+
 	/* Ensure we requeue to the expected futex. */
 	if (!match_futex(top_waiter->requeue_pi_key, key2))
 		return -EINVAL;

