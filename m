Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6EC3ECB31
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhHOVae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:30:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48124 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhHOV2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:49 -0400
Message-ID: <20210815211303.428224188@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7ECrBPXXAlXHpveZ2WMzu194KMk7VXKUfyuQBw86xDU=;
        b=RjdTEnAgO6FyzNl4yq1L79iUgI/DUEh44XpIojG423vHfC84A8gfxxEIHFNX16hTITDlso
        hBTfOKNOXJgya2CCwMdFw2lXmW2A91clkwiDfV/emVyxNGfORuk3kcn8tKpCbAy2bnqlXs
        G/2lvoLTDVNS1JedP5LVBHWA3z6MSUsQFcNhTVXWHvN+dTDkQh2TWTiXNT0OrRepRX7DX/
        8sJf8Nts7oCSk6eLayN8LF3gfdzpqFVcG86Vh6qmLXK4Cv799gNiIK7Rzy54lVe+OV8atu
        qonGkvMeIgsnco2uRRG4QY69qR17nkdnPLr2MHBHsfdoNtAnWpajoWregQGm/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7ECrBPXXAlXHpveZ2WMzu194KMk7VXKUfyuQBw86xDU=;
        b=omKjY0djONs4o1k52dF55ZWwwmN1KiEn8EtnwqirDMhCjxflCm1NNzaWtBTznXqR08s0A4
        lW/mHfCyF4d7PcBQ==
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
Subject: [patch V5 26/72] locking/rtmutex: Prevent future include recursion hell
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:28:16 +0200 (CEST)
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
@@ -16,7 +16,7 @@
 #include <linux/compiler.h>
 #include <linux/linkage.h>
 #include <linux/rbtree.h>
-#include <linux/spinlock_types.h>
+#include <linux/spinlock_types_raw.h>
 
 extern int max_lock_depth; /* for sysctl */
 

