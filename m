Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7998F410166
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 00:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbhIQWkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 18:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbhIQWkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:40:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238FEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 15:38:47 -0700 (PDT)
Date:   Sat, 18 Sep 2021 00:38:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631918322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=f17NSAv1jzczG2r+B4PpWFbaApmikOHTORAA+K+txX4=;
        b=x/7gbyC6oUeXTigd+tJFoMB0+Mj38RCV52vHdSX8r5HjF4azalfbqA3tcAAGxApNXsiMTa
        ELEsn7mPtpLXs4Al0+3f+RYuQlybHvj12H1b5raKzGVl10vNZdjjHel35xE3pM02BzorNC
        Nyp5JpmUS9lY4n+nUvnUoDMkG0t/USAyJyxwgPBvtTDBT33PNgWHxXCgPZ0hGhr1XN6pJd
        jsM942425jEGqIvPYgwPAsYfqiJofVyZ6ll/dDgw93kspPFMWEtG164aaMMYYfQAKG2SSv
        GyeJepleT492sdR16eQly7h4DbJWJ5qlzaxVLUApweZHvWWK2TrZkorfUkDigQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631918322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=f17NSAv1jzczG2r+B4PpWFbaApmikOHTORAA+K+txX4=;
        b=v7ndSLk3pxkM5G9YBigOxeigotgGGVj8rMxzpQyo+b/wVgSx1ZCfo05ITlhqF7NlZz6woy
        vdl4dlWlwHYeYTAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] genirq: Disable irqpoll on PREEMPT_RT.
Message-ID: <20210917223841.c6j6jcaffojrnot3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>
Date: Fri, 3 Jul 2009 08:29:57 -0500

The support for misrouted IRQs is used on old / legacy systems and is
not feasible on PREEMPT_RT.
Polling for interrupts reduces the overall system performance.
Additionally the interrupt latency depends on the polling frequency and
delays are not desired for real time workload.

Disable IRQ polling on PREEMPT_RT and let the user know that it is not
enabled.

[ bigeasy: changelog, IS_ENABLED ]

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/irq/spurious.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index c481d84583257..02b2daf074414 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -447,6 +447,10 @@ MODULE_PARM_DESC(noirqdebug, "Disable irq lockup detection when true");
 
 static int __init irqfixup_setup(char *str)
 {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		pr_warn("irqfixup boot option not supported with PREEMPT_RT\n");
+		return 1;
+	}
 	irqfixup = 1;
 	printk(KERN_WARNING "Misrouted IRQ fixup support enabled.\n");
 	printk(KERN_WARNING "This may impact system performance.\n");
@@ -459,6 +463,10 @@ module_param(irqfixup, int, 0644);
 
 static int __init irqpoll_setup(char *str)
 {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		pr_warn("irqpoll boot option not supported with PREEMPT_RT\n");
+		return 1;
+	}
 	irqfixup = 2;
 	printk(KERN_WARNING "Misrouted IRQ fixup and polling support "
 				"enabled\n");
-- 
2.33.0

