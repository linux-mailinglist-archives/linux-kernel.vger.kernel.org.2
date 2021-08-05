Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8FC3E1865
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242615AbhHEPn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242389AbhHEPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:41:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDB9C0617B1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 08:41:42 -0700 (PDT)
Message-ID: <20210805153954.219339421@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628178100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=rVwGzvQPLMUsg69NUA8v9NgaYhkJ7rz2s+2TPWwsUac=;
        b=kfydsCtmizBoPrPu+0K0SJ9Fs5mBPmNLCmu23uMYaQt2yCyO+rw6jnEvwab6net7zhz7Dl
        pitpY+X9+C6g7o9Dr4bBwNs9/UsOdRWUdj0pRGaJmnBc7g+z5MB2dINdLiDpOCSJ8FrdT7
        q99Or32sDayvbgO7yNSK6DHRUGsOM6HBJTK8CmaMhXuvo9IICe9KAWMCSP22kqY4UAHB+I
        5eRC97c18tTsmrKvlwPlQgfeeCx/JDGt43UbWh2fC2FU0vuMPJZaUlR9PJrh3McZr/9elQ
        VxiTZpHFpD91x+Xvo3MIRxZmNW/1xDHbY7qbrNAYKqi/C+dhrT2R5GrksGfwFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628178100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=rVwGzvQPLMUsg69NUA8v9NgaYhkJ7rz2s+2TPWwsUac=;
        b=6UMVzXVxOH+/eCba39S9QywO+7XsSXL0N2Ik9PiC8Jd3kvYTWTjIq4uTfKNqsgxUxiPBgk
        9wfqBdC54LMbeqCg==
Date:   Thu, 05 Aug 2021 17:13:24 +0200
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
Subject: [patch V3 24/64] locking/rtmutex: Prevent future include recursion hell
References: <20210805151300.330412127@linutronix.de>
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
 

