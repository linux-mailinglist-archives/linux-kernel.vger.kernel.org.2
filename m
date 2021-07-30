Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BE13DBA61
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbhG3OWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:22:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56072 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239250AbhG3OSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:18:12 -0400
Message-ID: <20210730135208.145227915@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=35IiguvMjyN9HS4qOQgfmae19noJXTGdkXOwXWuAzuM=;
        b=pVguvrUrowCeNuWkmsJ5HLTPEz0K2Iq6NneExYEJMFxnsuqdMVnVrtEk+K2HWGB5/60iWQ
        7rjxOxFR2rm/jJe7vLB+HW7i8Sv3dvMnkKoV6wuvcBAu5xv0fk9CjRt64e8XMu5KdEq1Vf
        UA5OfD/M9uXlq4KChi323rwAuwQ9Wdbdoik5AdMJ1Wf55AL+m/f9CNBx2t8WV6a8WEb0I0
        TZPAmoj/BSokiDUeeA28yOKJva8OFef4BtJg785YVo4Ezii8K4AcBRPmqmj1nnlu0tTj+k
        5QPqrvNfOz9gfT8rUftEZZ0BNsuZGwPSPv9E70ENrHXHTBohKo3xoK++rXOOTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=35IiguvMjyN9HS4qOQgfmae19noJXTGdkXOwXWuAzuM=;
        b=yz8MInCJ5o29cKH7WXJ9IWVZQxuFe8qJoIp0XCS8fxyvYFpDmBBVQE1dnegJ0aB0aEc4+M
        tWkX5UBOB+6/ZYBg==
Date:   Fri, 30 Jul 2021 15:51:00 +0200
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
Subject: [patch 53/63] futex: Validate waiter correctly in
 futex_proxy_trylock_atomic()
References: <20210730135007.155909613@linutronix.de>
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

