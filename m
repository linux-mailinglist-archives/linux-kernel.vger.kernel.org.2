Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734073AB4CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhFQNe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231654AbhFQNey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:34:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62E776044F;
        Thu, 17 Jun 2021 13:32:45 +0000 (UTC)
Date:   Thu, 17 Jun 2021 09:32:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH next v4 1/2] lib/dump_stack: move cpu lock to printk.c
Message-ID: <20210617093243.795b4853@gandalf.local.home>
In-Reply-To: <20210617095051.4808-2-john.ogness@linutronix.de>
References: <20210617095051.4808-1-john.ogness@linutronix.de>
        <20210617095051.4808-2-john.ogness@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 11:56:50 +0206
John Ogness <john.ogness@linutronix.de> wrote:

> dump_stack() implements its own cpu-reentrant spinning lock to
> best-effort serialize stack traces in the printk log. However,
> there are other functions (such as show_regs()) that can also
> benefit from this serialization.
> 
> Move the cpu-reentrant spinning lock (cpu lock) into new helper
> functions printk_cpu_lock_irqsave()/printk_cpu_unlock_irqrestore()
> so that it is available for others as well. For !CONFIG_SMP the
> cpu lock is a NOP.
> 
> Note that having multiple cpu locks in the system can easily
> lead to deadlock. Code needing a cpu lock should use the
> printk cpu lock, since the printk cpu lock could be acquired
> from any code and any context.
> 
> Also note that it is not necessary for a cpu lock to disable
> interrupts. However, in upcoming work this cpu lock will be used
> for emergency tasks (for example, atomic consoles during kernel
> crashes) and any interruptions while holding the cpu lock should
> be avoided if possible.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---

Can we add this lock to early_printk() ?

This would make early_printk() so much more readable.

-- Steve

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 421c35571797..2b749c745c1f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2259,6 +2259,7 @@ struct console *early_console;
 
 asmlinkage __visible void early_printk(const char *fmt, ...)
 {
+	unsigned long flags;
 	va_list ap;
 	char buf[512];
 	int n;
@@ -2270,7 +2271,9 @@ asmlinkage __visible void early_printk(const char *fmt, ...)
 	n = vscnprintf(buf, sizeof(buf), fmt, ap);
 	va_end(ap);
 
+	printk_cpu_lock_irqsave(flags);
 	early_console->write(early_console, buf, n);
+	printk_cpu_unlock_irqrestore(flags);
 }
 #endif
 
