Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CE73C740E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhGMQQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:16:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54372 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhGMQQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:16:27 -0400
Message-Id: <20210713160748.193301909@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626192816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=r6+Tmh1fK+3G0fPXhZWNahGp7cta6WhkPmBzkc+Fdu0=;
        b=h8/No+2iiTWTGrxrpFkjHtH25eCvScxJPNbgHe4IfCsgFqxUEMdiqVT5/2g35SAA37h50Q
        ZczaADFP/2Adqtz4bBuKBHzeYL6gx+Ct+FeSc5euGKCE51LG3sJcSWDSf1ZHdxnu0SK6EG
        EiI6Zvd/qoU5N+NKDN5YIbD/29dJMwThTOTuqeb23V1CJpaM5Jx9uAsx/X7fRqqOShItcO
        95MsJ4hYFznDlrdEOwLvjtylQCBLhr+fR6UBWZHdyvOAEy3o7yH9HmIYjwG/5WwQy8x+qP
        Dw1jL2Y3Bn2vuX+fjoNAUFBilb3nbUSW54FCAo6KGhpRqt9kXsosGcSTnq9UBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626192816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=r6+Tmh1fK+3G0fPXhZWNahGp7cta6WhkPmBzkc+Fdu0=;
        b=S41fe9bGT1/dSRzEw/yHBdDYWoCsFnonHLImMiHx53mm4WT38i6kjo1+m3ih3gwORqMHFH
        Yex6J71oRgR2bJAQ==
Date:   Tue, 13 Jul 2021 17:11:17 +0200
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
Subject: [patch 23/50] locking/rtmutex: Include only rbtree types
References: <20210713151054.700719949@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

rtmutex.h needs the definition of struct rb_root_cached. rbtree.h includes
kernel.h which includes spinlock.h. That works nicely for non-RT enabled
kernels, but on RT enabled kernels spinlocks are based on rtmutexes which
creates another circular header dependency as spinlocks.h will require
rtmutex.h.

Include rbtree_types.h instead.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rtmutex.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 9c1c67f2d810..7bbee67720dc 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -14,7 +14,7 @@
 #define __LINUX_RT_MUTEX_H
 
 #include <linux/linkage.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <linux/spinlock_types_raw.h>
 
 extern int max_lock_depth; /* for sysctl */

