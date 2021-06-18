Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F68E3ACDD8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 16:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhFROt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 10:49:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48062 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbhFROtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:49:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 836EA21ACB;
        Fri, 18 Jun 2021 14:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624027659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ofS7wVEDsIrS30FJCm8VcnZVpnOGoYipKdIZZ4xEpsA=;
        b=MW8ncgLSjk3Wrh8A5faRk3XwqAqJUaIzrECob2rzsFJT1qQNusNDuYRyn77DM7wk9ntO60
        sADqxfJWJN4mqjKVWaX0ZVeXALbH0sch5GcQfu7MePe/M8wOp28SXDddGSdGMLe/69g4BE
        jjHrIuZcmNb8SURTdUmkVUr7hjFS03M=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 64EFCA3BCF;
        Fri, 18 Jun 2021 14:47:39 +0000 (UTC)
Date:   Fri, 18 Jun 2021 16:47:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
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
Message-ID: <YMyyCwMt549micJE@alley>
References: <20210617095051.4808-1-john.ogness@linutronix.de>
 <20210617095051.4808-2-john.ogness@linutronix.de>
 <20210617093243.795b4853@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617093243.795b4853@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-06-17 09:32:43, Steven Rostedt wrote:
> On Thu, 17 Jun 2021 11:56:50 +0206
> John Ogness <john.ogness@linutronix.de> wrote:
> 
> > dump_stack() implements its own cpu-reentrant spinning lock to
> > best-effort serialize stack traces in the printk log. However,
> > there are other functions (such as show_regs()) that can also
> > benefit from this serialization.
> > 
> > Move the cpu-reentrant spinning lock (cpu lock) into new helper
> > functions printk_cpu_lock_irqsave()/printk_cpu_unlock_irqrestore()
> > so that it is available for others as well. For !CONFIG_SMP the
> > cpu lock is a NOP.
> > 
> > Note that having multiple cpu locks in the system can easily
> > lead to deadlock. Code needing a cpu lock should use the
> > printk cpu lock, since the printk cpu lock could be acquired
> > from any code and any context.
> > 
> > Also note that it is not necessary for a cpu lock to disable
> > interrupts. However, in upcoming work this cpu lock will be used
> > for emergency tasks (for example, atomic consoles during kernel
> > crashes) and any interruptions while holding the cpu lock should
> > be avoided if possible.
> > 
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > ---
> 
> Can we add this lock to early_printk() ?
> 
> This would make early_printk() so much more readable.

Good point! Just to be sure. Do you see the messed output with plain
kernel? Or do you need the extra patches (from Peter Zijlstra) that
redirect normal printk() to early_printk()?

My understanding is that early_printk() is used only for very early
boot message in plain kernel. And that there is not much concurrency
at that time.

That said. I always wanted to upstream Peter's patchset. But I never
found time to clean it up.

Best Regards,
Petr
