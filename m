Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35753E90E2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbhHKM00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:26:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51114 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbhHKMYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:24:08 -0400
Message-ID: <20210811121417.647465659@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3ytooRkFdVoLIkQBvivN8bveK+9EeU1H5HgaN+p1d3E=;
        b=ra2j/ouDwTmzcNhoU5W19aQStyGSVtVx0MqnMkmYzpFA1obsLb1iEMowEvh5uHWk48r1xH
        RTghQzKzkMO02FHWEhjsQ7sh3Sr4m5fisSQAyv+WXBXKyEmc4C9tNAy6QMF5o+hG6YxFhk
        erourHIrMLQGGwqOl2CqcAMwhDrPJn3fneHz1jpwzgAS5FNVuPLu21PZkcvIf7JKdeOrJm
        OK4gXbvTGVLERVF4rQiKa6TP7cwsQs48z5ibgkHXuLamJIEzr+8wKjkZsUNPEO6MuZsTlJ
        60SK8c6Y9MP/YkU/cBc1qu9FuLO2fTOwz8/OvAKrvqLY1TRdHAbN7+oItmb2yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3ytooRkFdVoLIkQBvivN8bveK+9EeU1H5HgaN+p1d3E=;
        b=iOU1AuaQdjz+Oa9YtOaYjS/ZoOsPT9jIxL14Yej50jYzIUjL3OsyzjX5N6a+a3JDrY7QEE
        sWAfrLCCY0N1LEBQ==
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
Subject: [patch V4 59/68] futex: Correct the number of requeued waiters for PI
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:43 +0200 (CEST)
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
@@ -2116,6 +2116,8 @@ static int futex_requeue(u32 __user *uad
 
 		/* Ensure we requeue to the expected futex for requeue_pi. */
 		if (requeue_pi && !match_futex(this->requeue_pi_key, &key2)) {
+			/* Don't account for it */
+			task_count--;
 			ret = -EINVAL;
 			break;
 		}
@@ -2157,6 +2159,8 @@ static int futex_requeue(u32 __user *uad
 				 */
 				this->pi_state = NULL;
 				put_pi_state(pi_state);
+				/* Don't account for it */
+				task_count--;
 				/*
 				 * We stop queueing more waiters and let user
 				 * space deal with the mess.

