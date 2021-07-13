Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849703C7423
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhGMQRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbhGMQQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A99EC0613EE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:14:02 -0700 (PDT)
Message-Id: <20210713160750.164344616@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=C2Vo4XXDlt6QXjXgpvqtBd+Wz/AeHGU1nda0oZEGxhw=;
        b=Ko3h5c0cRGrDPtsA0XPoUdMK8Utr59uIAoh2AELWAvyt7uQqIRhxub2WRPN8jOrPopPkTh
        WCPZBR+2CmiW5Ms+79RxXNy+ryEhGinfAadTUCsN2909l2eAmjEg0gTgtRg5WYl2vUq5Xk
        6T2safp6g3jdwqfsqd43giyG6DrQuM5tTO3kkqQH3g24JjSXaknK8Amnfa6chl1ANhhYah
        pI0hQanNI3qUOEMIY8o5/DkRJ9aOaKJXtiHoJhz7GWi2BrXaV0RLRDDVlCKzSDVegUh7lg
        mFZYOZd7LT8znccHKCFEcCWJun8yzdySVySoCb+MB4mRskOfxcfOrwLSwRyRkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=C2Vo4XXDlt6QXjXgpvqtBd+Wz/AeHGU1nda0oZEGxhw=;
        b=QiCQ8mZrT7rM5hRdGv+JILnCKtabgJ1SUHJ2vS+f3xu11JDEPsxzCGfhVyBR6tT5kCTi14
        vXAYcQeTx5kQ4QCg==
Date:   Tue, 13 Jul 2021 17:11:37 +0200
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
Subject: [patch 43/50] futex: Correct the number of requeued waiters for PI
References: <20210713151054.700719949@linutronix.de>
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

