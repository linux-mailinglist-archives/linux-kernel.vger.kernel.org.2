Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563DB3E1889
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242859AbhHEPqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:46:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44026 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242509AbhHEPmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:42:46 -0400
Message-ID: <20210805153956.051961951@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=L89kb3bK/8i7QLZQxNCKbjHrAz7lR5evlX/81M/CJ6U=;
        b=kElMHNfmvfG9ssjeyjhpTaTctLAjFmr/4kdv2HDweuOF1JWswmJMXGegxTQ2Ri84vDIZHj
        ELhJnIqtqFA0IHSyu/9zBiIJG4zfuGg1b1E+u3fQA7Wk5/5bCAoulM6Dfv+Sa/wBUvSvRv
        DxkxQ9PR0B7Ifo7feY3QvIbdhEswbvOhQwmbeXR2FFDOZWWJF6Tt3jkcJ3VqDh/33Mfl/3
        hIE+TrMWDUtniv8sRqD0nB0djJuiAFDxkPMmQALyIFaEgnMRIePy6hEqS6ocIPTMfpYbVv
        kGLU4bmLdkLGasfwPEnFj2sMJ8qXMHb2AEDABFVKSn2qfv6OZluhsHWGYlxr2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=L89kb3bK/8i7QLZQxNCKbjHrAz7lR5evlX/81M/CJ6U=;
        b=1TlWqzGwPHunNzWhfFZCPU8QapZz3hAg/lfCEQPAG4Lj+jZD4MKy+CY1qB5b4gr14cZm0A
        sSSHGDP88A+s2vAQ==
Date:   Thu, 05 Aug 2021 17:13:56 +0200
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
Subject: [patch V3 56/64] futex: Correct the number of requeued waiters for PI
References: <20210805151300.330412127@linutronix.de>
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
@@ -2131,6 +2131,8 @@ static int futex_requeue(u32 __user *uad
 
 		/* Ensure we requeue to the expected futex for requeue_pi. */
 		if (requeue_pi && !match_futex(this->requeue_pi_key, &key2)) {
+			/* Don't account for it */
+			task_count--;
 			ret = -EINVAL;
 			break;
 		}
@@ -2172,6 +2174,8 @@ static int futex_requeue(u32 __user *uad
 				 */
 				this->pi_state = NULL;
 				put_pi_state(pi_state);
+				/* Don't account for it */
+				task_count--;
 				/*
 				 * We stop queueing more waiters and let user
 				 * space deal with the mess.

