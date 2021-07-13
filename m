Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F453C7429
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbhGMQR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:17:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54788 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhGMQQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:58 -0400
Message-Id: <20210713160750.658402081@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wk5BXs3QliWC0Aueq/uB6S39gsRmV857OufixmfHlos=;
        b=QR8K5W7zOm6eN7sqkAhbG/niWsI219i5TlHqbwo2XztqoxcFB7HB7H8OP3Md74bHggdNcT
        D2nKCWsxpf2DE9Q5tzYfUuJ+OoBd0OJGVbhvcaQK2mnWOg6Xp6tMIK9JzDyhxI47g41XDu
        XSsiC71S7GYySBqA0JvX9GQnAoGu505wup32Z5ch7MVA6vqkG66WsvJE6zlH0KDUrmWojt
        9CLLFt2p/D9LH0QV+skoOLYtxrzuOtUzHNjgxSiAAksHZLapTnMkMMudEL+0XvMPs0pOGn
        99h7fOM36vfqBlp8cUnMwTJH1kWzA3vOGM/dUyJi+QDxZxMSeWDqAc5iZOggXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wk5BXs3QliWC0Aueq/uB6S39gsRmV857OufixmfHlos=;
        b=/rlTTHET/s+k9D/gDxVIRfLjHyknm7bBVgN3nxgxBpyWHsq2V1HrsbXeuM21oB05bAGJxD
        q+ZWpXcuZ7GAs9Bw==
Date:   Tue, 13 Jul 2021 17:11:42 +0200
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
Subject: [patch 48/50] preempt: Adjust PREEMPT_LOCK_OFFSET for RT
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

On PREEMPT_RT regular spinlocks and rwlocks are substituted with rtmutex
based constructs. spin/rwlock held regions are preemptible on PREEMPT_RT,
so PREEMPT_LOCK_OFFSET has to be 0 to make the various cond_resched_*lock()
functions work correctly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/preempt.h |    4 ++++
 1 file changed, 4 insertions(+)
---
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -121,7 +121,11 @@
 /*
  * The preempt_count offset after spin_lock()
  */
+#if !defined(CONFIG_PREEMPT_RT)
 #define PREEMPT_LOCK_OFFSET	PREEMPT_DISABLE_OFFSET
+#else
+#define PREEMPT_LOCK_OFFSET	0
+#endif
 
 /*
  * The preempt_count offset needed for things like:

