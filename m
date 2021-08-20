Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A333F3768
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 01:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbhHTXsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 19:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232954AbhHTXsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 19:48:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A2FB6117A;
        Fri, 20 Aug 2021 23:47:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mHEEb-004rkV-DM; Fri, 20 Aug 2021 19:47:37 -0400
Message-ID: <20210820234737.244832083@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 20 Aug 2021 19:46:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Chunyu Hu <chuhu@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH RT 1/2] locking/rwsem-rt: Remove might_sleep() in __up_read()
References: <20210820234638.295553375@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.10.59-rt52-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Andrew Halaney <ahalaney@redhat.com>

There's no chance of sleeping here, the reader is giving up the
lock and possibly waking up the writer who is waiting on it.

Reported-by: Chunyu Hu <chuhu@redhat.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/locking/rwsem-rt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
index 274172d5bb3a..b61edc4dcb73 100644
--- a/kernel/locking/rwsem-rt.c
+++ b/kernel/locking/rwsem-rt.c
@@ -198,7 +198,6 @@ void __up_read(struct rw_semaphore *sem)
 	if (!atomic_dec_and_test(&sem->readers))
 		return;
 
-	might_sleep();
 	raw_spin_lock_irq(&m->wait_lock);
 	/*
 	 * Wake the writer, i.e. the rtmutex owner. It might release the
-- 
2.30.2
