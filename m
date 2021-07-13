Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB253C740C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhGMQQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54378 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhGMQQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:23 -0400
Message-Id: <20210713160747.902630183@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=i7HyY2Fv1ATuICos3Hbcoi1haSh6/ZP6tFeLWVQ9KVc=;
        b=kakFTWhu+m3Z5uJDl5lfZqCt1ZOJCsUJsiqAHf6EBjiC+b4VSVnVDk5PD+bANyD5WM3p0X
        6mpKoNF4jFtJScQm+WvYxk/JWjFm9dNsXSgfmBeC1k8f/+m8frFUz55RBlpSQCiejv3z//
        LRXaseJT8JDuvC/nrCx2GoiJnwuQa53KbMZcq1aFhZ23PAoFP6aygGJsbIFOFVj029Iwpj
        iMQoYeAK6reRW7kHWlXjZXlYY1MGlmGk8RhFJd3DnWd2t2CRbPrv6ye2vNmHDDnBIEnwCp
        s2DLogg8akv0NjzoAE0VhmS8Tyu4UYrd7kjvdFV7HS4CiSJydHQ9MGZgZ6ecJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=i7HyY2Fv1ATuICos3Hbcoi1haSh6/ZP6tFeLWVQ9KVc=;
        b=05Q1LFdFPdv6v68mGrm24xEv9farFVs39aFenRBVQomDu3imlHgdw9ucpGflxRtrZjL3Er
        OFNcUPSm6DtwaBAg==
Date:   Tue, 13 Jul 2021 17:11:14 +0200
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
Subject: [patch 20/50] locking/rtmutex: Prevent future include recursion hell
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

rtmutex only needs raw_spinlock_t, but it includes spinlock_types.h which
is not a problem on an non RT enabled kernel.

RT kernels substitute regular spinlocks with 'sleeping' spinlocks which
are based on rtmutexes and therefore must be able to include rtmutex.h.

Include spinlock_types_raw.h instead.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rtmutex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index d1672de9ca89..9c1c67f2d810 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -15,7 +15,7 @@
 
 #include <linux/linkage.h>
 #include <linux/rbtree.h>
-#include <linux/spinlock_types.h>
+#include <linux/spinlock_types_raw.h>
 
 extern int max_lock_depth; /* for sysctl */
 

