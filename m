Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD83ECB54
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhHOVcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:32:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48702 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhHOV3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:42 -0400
Message-ID: <20210815211305.416427548@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3ytooRkFdVoLIkQBvivN8bveK+9EeU1H5HgaN+p1d3E=;
        b=U+KNngYvLPsQXZitPOxxjws9mB2jRtBQrMjFhxa+1EVEMRaV7y0cWeebcfKKnHZmYptlgo
        NpPwF1CoUZG1dI8281RwNd+SEP2M8IYtEt+HPfkuioFApw6xlYKxpxM/EvzG1HLcIKyxws
        26V69WJWRnhXJYHEkJRG8pGuBGO+H4ZoBZm44Ox2G+TE6KRoUDNItRp4V0hX10Z1Sz7LUC
        UdStMc9oZHOSlXOL9k1tKoGE9jWyCN5ZqsgeJs4PdOApUOQg9MMTojRqpM4lyckS4K5C0A
        1M3B674xIL0HB6Nbq59tmSx0kPVZK2vnAf6nAkwZHOjIalxwQ3BHwXmIAvhMTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3ytooRkFdVoLIkQBvivN8bveK+9EeU1H5HgaN+p1d3E=;
        b=gFpM5b8cCtBrqL7CW0BSGU/Bki1WNcLE7OlTcZSSWWGg8UFhRogE2n4dk2OGm03eTMEeCf
        5uZ2lrs2LCHKESBA==
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
Subject: [patch V5 61/72] futex: Correct the number of requeued waiters for PI
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:29:10 +0200 (CEST)
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

