Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57C13DEEE6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbhHCNNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbhHCNNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:13:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F079C061764
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 06:13:08 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627996385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YrVcD8ygaFjwAnuxINro61t3A9aQfh8ZamB2CFd3jhk=;
        b=gcgMBAhwyVAMXqC4uuTXYVp1dcSdpln/lAUtuECym+NJZaQLzAApQUWRoE3WS63RBxfHFZ
        Yg/OiCEhKyGX3wcUMoHqYaTnwppyWaZX5UMXw6kcvGGA+Wa5ZZ3axrccKy84fo4QY63a0s
        8bm1yho/8xZ8UjB53gkob+CDULq2rm83TH+VKB/XEmGIF1IGnHNARyBMABUQ5MdWqAuW57
        N97geq/IGvUSjbviFLSeZykvde42ud6HNb9pP781UiRQVTSfgeWUuj8CYrFl1WYs5MiwSR
        LtceLqeYjRlitAJRLCzLCOfLAYypaLCyyNjwQygnFqX/prSJ/h4ohMiLzJLSrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627996385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YrVcD8ygaFjwAnuxINro61t3A9aQfh8ZamB2CFd3jhk=;
        b=4K6kVET+39M5t/VjLgk8/OajILonh7E9bxt6LVvKHCzyzSvPWDcL0Ew96AY7fnOqshHJts
        DfnConNRCWwYcmBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v1 05/10] printk: call boot_delay_msec() in printk_delay()
Date:   Tue,  3 Aug 2021 15:18:56 +0206
Message-Id: <20210803131301.5588-6-john.ogness@linutronix.de>
In-Reply-To: <20210803131301.5588-1-john.ogness@linutronix.de>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

boot_delay_msec() is always called immediately before printk_delay()
so just call it from within printk_delay().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8bdfac4c9ee9..d07d98c1e846 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1877,8 +1877,10 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
 
 int printk_delay_msec __read_mostly;
 
-static inline void printk_delay(void)
+static inline void printk_delay(int level)
 {
+	boot_delay_msec(level);
+
 	if (unlikely(printk_delay_msec)) {
 		int m = printk_delay_msec;
 
@@ -2350,8 +2352,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		in_sched = true;
 	}
 
-	boot_delay_msec(level);
-	printk_delay();
+	printk_delay(level);
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
-- 
2.20.1

