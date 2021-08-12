Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF293EA7E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbhHLPny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:43:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59346 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238106AbhHLPnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:43:53 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628783007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=mwLc/t8d7x93ygJgXx7xa7Km0ZCceRveuVCf+CGIO+Y=;
        b=tTJ748EkkIdoq1diljAxBZJa7G4EfZkqsMIDrJsh+90W3jQ0ZtQFiiWaYAhSH7ha0xKcVP
        HYQh5ImyamdE1g+s+9WeC34hn531mm4eXSSER9fVO09jPMky6dQHdeE9tciUNrka4WAH6q
        +inPOOgcQQrjt3cJYZOyD1BKERa7Ab1mocBlkgAdefyDJtUR/pstPQTN8Xi1UEfmt9IbHp
        HvoLVbBXEViQ32bIKjRtTukchKFuo68Nd327VodyJGNDE3yRTd2WpqW+RN7SWaI2ubRHcn
        cjFaD8vDwXSI9LgKmO40codD4/mFAtMBWgOZPdQ9AxhyPylxtkvDj8DYDR9WyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628783007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=mwLc/t8d7x93ygJgXx7xa7Km0ZCceRveuVCf+CGIO+Y=;
        b=YfyEXVuFXznJjIlZ35Ub0FFOce3S9HaWzGTIxomHmE0b/zMq/IQhaWl7OnVfW+2sBAvucj
        vb1BbRTYzRaSHeCw==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: debugobjects: Make them PREEMPT_RT aware
Date:   Thu, 12 Aug 2021 17:43:26 +0200
Message-ID: <87sfzehdnl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PREEMPT_RT enabled kernels it is not possible to refill the object pool
from atomic context (preemption or interrupts disabled) as the allocator
might acquire 'sleeping' spinlocks.

Guard the invocation of fill_pool() accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
---
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -557,7 +557,12 @@ static void
 	struct debug_obj *obj;
 	unsigned long flags;
 
-	fill_pool();
+	/*
+	 * On RT enabled kernels the pool refill must happen in preemptible
+	 * context:
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+		fill_pool();
 
 	db = get_bucket((unsigned long) addr);
 
