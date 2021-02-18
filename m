Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D63031E838
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhBRJcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:32:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50594 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhBRITs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:19:48 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613636303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TI8jKw/bM8hX+GytHg3FHpvo+uHYr21S5Xx+X0cbFsE=;
        b=whcAj2EgmUSDhPGvZWLRlmbBRMk80Wk23rB8jODqNCx8js3frYErVBTYla+LC9d3VgGWUl
        dnfF+Q5huvXilh89ya2R5eTgzgL8JBqQglmjdhVkumnw6FkEB3BovdYNJ0MJo+pVa1Nxru
        opg2yg9ZzFo6CLuNiZ+8xAQbU6nd3xCOIep0rcKBcHCdBg8Kc6etn9WhiL717Ty4HU1suW
        vzDvZSDz0pJrw+R0pJeepB6Igh69Jl1O5eoN+yxlRasSEei13pI03BDOxRqysRgkyuazsd
        q6BSwDpG/z0PITGkBFaKSenoOSR90EiH4g2JYm4k6Fl/Y2kZJodw1jGRYwjZEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613636303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TI8jKw/bM8hX+GytHg3FHpvo+uHYr21S5Xx+X0cbFsE=;
        b=xz+9TRmHPxpl2HEcttYLa2dvNR6tlr5mv4PQ44/IedanVy//W74VyvrNVGF0dMXTgghelk
        bwlwUsLPnr+PeJBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk-rework 13/14] printk: kmsg_dump: use kmsg_dump_rewind
Date:   Thu, 18 Feb 2021 09:18:16 +0100
Message-Id: <20210218081817.28849-14-john.ogness@linutronix.de>
In-Reply-To: <20210218081817.28849-1-john.ogness@linutronix.de>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmsg_dump() is open coding the kmsg_dump_rewind(). Call
kmsg_dump_rewind() instead.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 744b806d5457..23d525e885e7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3347,7 +3347,6 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 {
 	struct kmsg_dumper_iter iter;
 	struct kmsg_dumper *dumper;
-	unsigned long flags;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(dumper, &dump_list, list) {
@@ -3366,10 +3365,7 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 
 		/* initialize iterator with data about the stored records */
 		iter.active = true;
-		printk_safe_enter_irqsave(flags);
-		iter.cur_seq = latched_seq_read_nolock(&clear_seq);
-		iter.next_seq = prb_next_seq(prb);
-		printk_safe_exit_irqrestore(flags);
+		kmsg_dump_rewind(&iter);
 
 		/* invoke dumper which will iterate over records */
 		dumper->dump(dumper, reason, &iter);
-- 
2.20.1

