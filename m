Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D6D3551C5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbhDFLSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:18:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:54486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233034AbhDFLSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:18:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617707873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fSuO/VW+4decWYFfrvqFXfusfZIlDNCC7v2+c0XWZNo=;
        b=PAPEhIZfLegtekKTZbyfOl81UNz8pz/kgdVoCWlQ7KlRomwHba9R9oKWB7w9Fro7JYGctH
        JBUkAnWeVgDeuUYHC5hWZE8psWje/FUDf0OHOZlEGwVr885jT6I0PNz7c4TKgneYv7NhyW
        okifsrMShl9eL/r1m+KFPF8Amq2bFnw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C581FB155;
        Tue,  6 Apr 2021 11:17:52 +0000 (UTC)
Date:   Tue, 6 Apr 2021 13:17:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        Jordan Niethe <jniethe5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Yue Hu <huyue2@yulong.com>, Rafael Aquini <aquini@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: Re: [PATCH printk v2 2/5] printk: remove safe buffers
Message-ID: <YGxDXBJAolBCtojY@alley>
References: <20210330153512.1182-1-john.ogness@linutronix.de>
 <20210330153512.1182-3-john.ogness@linutronix.de>
 <YGW63/elFr/gYW1u@alley>
 <87a6qiqgzr.fsf@jogness.linutronix.de>
 <YGXV8LJarjUJDhvy@alley>
 <YGZ9+kfQKxASmVDR@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGZ9+kfQKxASmVDR@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-04-02 11:14:18, Sergey Senozhatsky wrote:
> On (21/04/01 16:17), Petr Mladek wrote:
> > > For the long term, we should introduce a printk-context API that allows
> > > callers to perfectly pack their multi-line output into a single
> > > entry. We discussed [0][1] this back in August 2020.
> > 
> > We need a "short" term solution. There are currently 3 solutions:
> > 
> > 1. Keep nmi_safe() and all the hacks around.
> > 
> > 2. Serialize nmi_cpu_backtrace() by a spin lock and later by
> >    the special lock used also by atomic consoles.
> > 
> > 3. Tell complaining people how to sort the messed logs.
> 
> Are we talking about nmi_cpu_backtrace()->dump_stack() or some
> other path?

It is about serializing

			if (regs)
				show_regs(regs);
			else
				dump_stack();

in nmi_cpu_backtrace() when it is triggered on many(all) CPUs
at the same time.


> dump_stack() seems to be already serialized by `dump_lock`. Hmm,
> show_regs() is not serialized, seems like it should be under the
> same `dump_lock` as dump_stack().

Ah, I think that you already mentioned it in the past and I forget it.

Yes, we would need to synchronize all these dump/show functions using
the same lock. It is already the lock that might be taken recursively
on the same CPU.

In each case, we must not introduce another lock in
nmi_cpu_backtrace() because it might cause deadlock with
@dump_lock.

Anyway, I would really like to keep the dumps serialized. So, we
either need to use the same lock everywhere or we need to keep
nmi_safe buffers for now.

I would like to remove the nmi_safe buffers in the long term
but I am fine with doing it later after the consoles rework.
I'll leave the prioritization for John who is doing the work
and might have some preferences.

Best Regards,
Petr
