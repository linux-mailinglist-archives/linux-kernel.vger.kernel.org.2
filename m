Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD9E3ECB33
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhHOVak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhHOV3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBABC061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 14:28:22 -0700 (PDT)
Message-ID: <20210815211303.598003167@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ESojF0ouGJ8E5RptvVYIZYWqmjwBVCvmh9a1bEqWj44=;
        b=XbTQbYXUmtAReE6+CG1ez2L5z7hrzK5IWWQJ9kaO1rxImNIDtG35ajrcmWO1xlbR92sMQv
        plVEsAbZo3bGGv2cRdCT5JyPGDIR09e9cP15wFNfpxEX8a7o060aK0Y9oifUeFbCJ6UpNG
        LevrMIjpiJvb9nm1bvK44L6UFQWTba1Q1IQXDUSfJzLengfn1rl/GTNTYojqmj0+p3vpmw
        P+k2IksiGVPjLZrawq8vyqqJDU2GtkFjLuJJIZQ2mKJvrSiUO8n+Pxr6EoN44oJRQB1YB2
        3f34Rz9c0jFMYIOvdJxCB/dkK5uNI0TqnrzU41Fxhm2bcc5aPw1I4C0AmreZQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ESojF0ouGJ8E5RptvVYIZYWqmjwBVCvmh9a1bEqWj44=;
        b=hNiaouncJDhMX93QTIAOKVGe9fHU33EqDtmdMZuAckiwSDsgOfZFwB0m2c36azC3Y7BS95
        iRTwxxLHL5l2MkCA==
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
Subject: [patch V5 29/72] locking/rtmutex: Include only rbtree types
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:20 +0200 (CEST)
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
 include/linux/rtmutex.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -15,7 +15,7 @@
 
 #include <linux/compiler.h>
 #include <linux/linkage.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <linux/spinlock_types_raw.h>
 
 extern int max_lock_depth; /* for sysctl */

