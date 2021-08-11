Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF08E3E90BD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbhHKMYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238063AbhHKMXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:23:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865A4C06139E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:23:05 -0700 (PDT)
Message-ID: <20210811121415.761272293@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ePGbhKE2F+pdLqGDckaId6eUuM3YumbfHtNk25es/Qs=;
        b=j8bN7kUX2mWu7yDulNSbcUnP7i/tiWw6N/XsgZ//cj9npY44mFsoM5a0szIXerMpPW/iP1
        qG/HXn45nYaQTuRlaecVosWIdX85g0OJdJAELMXOqo/GuFjpocByMJf2KR722RhpjMLgUG
        k8QYAwD+tkPhv1W626+WPNAgoLKLJGwOFsvBQ/cxyJJzNvhJeakCZVpunjpzCk2K7wvoMZ
        oNi2+ADLTFI58BtZm+ObxkvJNQYvrtXYIXkDLgJK+FG9MuCL6GyhuVxH9OY1VmeYdUAllp
        j+/BJvlremmM6KYVjoMdmf/paCwtcToExw9OHb9mjNwQTLU2ZCsp1xkCw7ecVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ePGbhKE2F+pdLqGDckaId6eUuM3YumbfHtNk25es/Qs=;
        b=wTz4wLI/lqRhDclgLeB6zCuGWAuO0+z0pd2ubLDklxgPnRXuEvHwYwPgkgFmhrE5bVG+ut
        tNhXYIsceF/k2XBg==
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
Subject: [patch V4 27/68] locking/rtmutex: Include only rbtree types
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:03 +0200 (CEST)
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
@@ -14,7 +14,7 @@
 #define __LINUX_RT_MUTEX_H
 
 #include <linux/linkage.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_types.h>
 #include <linux/spinlock_types_raw.h>
 
 extern int max_lock_depth; /* for sysctl */

