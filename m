Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9EF3A1515
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhFINFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhFINF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:05:26 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A276061108;
        Wed,  9 Jun 2021 13:03:30 +0000 (UTC)
Date:   Wed, 9 Jun 2021 09:03:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 8/9] tracing: Add osnoise tracer
Message-ID: <20210609090329.53679e79@oasis.local.home>
In-Reply-To: <06d72b7d-4beb-1dff-b537-e7449abf3d4e@redhat.com>
References: <cover.1621024265.git.bristot@redhat.com>
        <bd09a2be9cd0cecee86374dbb49235dd2ef9d750.1621024265.git.bristot@redhat.com>
        <20210604172803.527aa070@oasis.local.home>
        <06d72b7d-4beb-1dff-b537-e7449abf3d4e@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 14:14:17 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> On 6/4/21 11:28 PM, Steven Rostedt wrote:
> >> +#ifdef CONFIG_X86_LOCAL_APIC  
> > I wonder if we should move this into a separate file, making the
> > __trace_irq_entry() a more name space safe name and have it call that.
> > I have a bit of a distaste for arch specific code in a generic file.
> >   
> 
> I am placing the intel specific file in:
> 
> arch/x86/kernel/trace_osnoise.c

I would make it just arch/x86/kernel/trace.c

so that it can hold all arch specific tracing information, and not need
to create a file for anything else we might need later.

> 
> and the kernel/trace/trace_osnoise.h looks like this:
> 
> #ifdef CONFIG_X86_LOCAL_APIC
> int osnoise_arch_register(void);
> int osnoise_arch_unregister(void);
> #else /* CONFIG_X86_LOCAL_APIC */
> #define osnoise_arch_register() do {} while (0)
> #define osnoise_arch_unregister() do {} while (0)
> #endif /* CONFIG_X86_LOCAL_APIC */
> 
> This can be used by other archs as well...
> 
> sound reasonable?
> 

The proper way to d that is to use weak functions in the C code in the
generic file.

int __weak osnoise_arch_register(void)
{
	return 0;
}

int __weak osnoise_arch_unregister(void)
{
	return 0;
}

Hmm, does the unregister really need a return value?

-- Steve
