Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593B83DBA41
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbhG3OUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbhG3ORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:17:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B142BC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:17:12 -0700 (PDT)
Message-ID: <20210730135205.607325924@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627654631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qoh8d3hfSvvuGtm/7GyzaEgA5QXxkK7VldYhzUcnH+E=;
        b=2yvbyaLQYyXgkTxA7V9nTfYAcNtYkF9TKVgWbELNc1v9mcHwCnNLJBcpMtjwvrbymmyD17
        sfcj83m5xfX7eAcIdRZhV0oBFgVSKK8drF+isFNta1aK+Sfth+Kb/sOYc57jKOZEd9+iml
        KDzsobxMzSd/3RmsxdwuO/2w3f/m5W7oSHXYnANOHFvRDh0GdDnbKNiopt5cel4O0h5SNv
        eg4R0pDhd5XtMWaSdpbzGAx8pV2SZdYeb5QvACOUrUMdzNyocIrvjINwjYl/K6NVDHoisO
        Dwxf7x6Rt09W57sQ5cGnb2SGWcTL7/TglnRm0caSywNNuJYYZTbSPae4ivuV2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627654631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qoh8d3hfSvvuGtm/7GyzaEgA5QXxkK7VldYhzUcnH+E=;
        b=Mz2+oMZxvJdc7PTiBxZzfRM3cE4YPkSZu3MBSLYR2Bs1LOqoz+4ETWtn2C2t2pqxfur5mr
        RHpzUvnCsl5Fk1BA==
Date:   Fri, 30 Jul 2021 15:50:15 +0200
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
Subject: [patch 08/63] rtmutex: Remove rt_mutex_is_locked()
References: <20210730135007.155909613@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

No more users.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rtmutex.h |   11 -----------
 1 file changed, 11 deletions(-)

--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -67,17 +67,6 @@ do { \
 #define DEFINE_RT_MUTEX(mutexname) \
 	struct rt_mutex mutexname = __RT_MUTEX_INITIALIZER(mutexname)
 
-/**
- * rt_mutex_is_locked - is the mutex locked
- * @lock: the mutex to be queried
- *
- * Returns 1 if the mutex is locked, 0 if unlocked.
- */
-static inline int rt_mutex_is_locked(struct rt_mutex *lock)
-{
-	return lock->owner != NULL;
-}
-
 extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC

