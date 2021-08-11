Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264343E90C0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbhHKMZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:25:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50550 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237986AbhHKMXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:25 -0400
Message-ID: <20210811121415.581699826@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=rVwGzvQPLMUsg69NUA8v9NgaYhkJ7rz2s+2TPWwsUac=;
        b=BYu4ApxWCNWOhk5JB5svHXLAuTA9A2EQ42HRIDH3ANOweLYDOt0VQK1bLmMCPftthwF7Xk
        CWCMyA7gY/bMLID3VyykeWrpW1CNV1CO+jrwC2r9X+fNKYuA80ihHKGWH8PkeAh6aoyJCh
        a45zWWrLLvyFlcRDEDSdugpQ/4vCiqEgMweaITjaGIGkhd7DIow4SgUNiog5ipNs6Z0Clw
        Tqn11/v6gUj9NSQT/zKhmkbKjmRITWxh6DsI7RUvUCZU7Ya1DUFXdFVeAFekKSh/QlAXWl
        hSAV2Ioi2QKlIk4zXv/isT+T/PPWZq/j8YJ/Gfukyv52kFgoEt/8CnMAnPVX5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=rVwGzvQPLMUsg69NUA8v9NgaYhkJ7rz2s+2TPWwsUac=;
        b=v1dc/ROPBg5b4CpHdP0OVTipBYzc8/paPSfrnvQejSWDfIFkB7+5cA4r5+ziN07SGc6yZT
        D/1DLZVJ8V8P77CA==
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
Subject: [patch V4 24/68] locking/rtmutex: Prevent future include recursion hell
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:00 +0200 (CEST)
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
 include/linux/rtmutex.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -15,7 +15,7 @@
 
 #include <linux/linkage.h>
 #include <linux/rbtree.h>
-#include <linux/spinlock_types.h>
+#include <linux/spinlock_types_raw.h>
 
 extern int max_lock_depth; /* for sysctl */
 

