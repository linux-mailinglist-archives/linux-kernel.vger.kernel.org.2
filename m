Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF333DBA5F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbhG3OWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:22:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56108 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239257AbhG3OSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:18:15 -0400
Message-ID: <20210730135208.254890678@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=C2Vo4XXDlt6QXjXgpvqtBd+Wz/AeHGU1nda0oZEGxhw=;
        b=bP4uqnYrx5w7qSfuoy6mtyMRjezCblqWoNXSComDOxPkKOYOCSPgyaiESyb26Ne6Zuy+qe
        +T1vU3IfsBxmX0rkuDV5NeLQrNGgiHx8j43haAH5foYpHH17P616dorS0TvwPnnk8HIxjd
        InXpcKEFXHKsDOLHbIUEcvvzwgNY289f4oY09OTKAKVzD8zvK4EwAmXfpSL/onUMFJL8K7
        io1J651sqcshUeCnHzpd9fsIKpS9G2rpyE68r+vU0/RU/BvpgVhZWHC4phqSYFPakSN40A
        ZYosNjw156Eag84iqL0nHfnkLP7WJ9luKvAn9dt4A+PQ2DydNxXwoUD6RpbTXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=C2Vo4XXDlt6QXjXgpvqtBd+Wz/AeHGU1nda0oZEGxhw=;
        b=7sdp6s5PJmmbOQmu6YMzLdPC+ihNWYOuQ7LmxvEilE4jZ/bjUdL1tGdpnfNdlgu78Wsq3h
        epoaM+ygWaOH3JAg==
Date:   Fri, 30 Jul 2021 15:51:02 +0200
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
Subject: [patch 55/63] futex: Correct the number of requeued waiters for PI
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The accounting is wrong when either the PI sanity check or the
requeue PI operation fails. Adjust it in the failure path.

Will be simplified in the next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c |    4 ++++
 1 file changed, 4 insertions(+)
---
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2128,6 +2128,8 @@ static int futex_requeue(u32 __user *uad
 
 		/* Ensure we requeue to the expected futex for requeue_pi. */
 		if (requeue_pi && !match_futex(this->requeue_pi_key, &key2)) {
+			/* Don't account for it */
+			task_count--;
 			ret = -EINVAL;
 			break;
 		}
@@ -2169,6 +2171,8 @@ static int futex_requeue(u32 __user *uad
 				 */
 				this->pi_state = NULL;
 				put_pi_state(pi_state);
+				/* Don't account for it */
+				task_count--;
 				/*
 				 * We stop queueing more waiters and let user
 				 * space deal with the mess.

