Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881E8397558
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhFAOXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:23:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33426 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhFAOXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:23:35 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622557313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vp14N/OtaMF+++0wwMO+RMeYGWaezhP3Asy6f5kCSiY=;
        b=dQ3Qr2xLrInFujZweW0uOi/0bPl/QQmCnqjY3PasqzgTbxZeOHGTOA1YXIcgA/plFhpmmD
        I5W83k4/J+TFA+sN54iVDaTIUQDOin4NXj3B6Z7JovKiBy4hXv6AyUe07v0wV7qRetzJzT
        sKtg3eyxg7oiYJ2UY2+gJynza+tQUGrst7hgV8A3zlBNtM0Sjliv0W79c3gBKvOpnlCa2p
        48IG5B3ElWMMAJ5r8m6w+X7tzDLMUlSRTmCs0PXOHAGaeVjeJ3TQl6uIK5ajebtAxhkx+p
        muvWuhCIvVDjbIrrBSj31XRNuQT3IY0hkxzP/AsKaeOyZB7cFymrHHqSD7E2OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622557313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vp14N/OtaMF+++0wwMO+RMeYGWaezhP3Asy6f5kCSiY=;
        b=bpd8tDXFmchE4Qy8+jl68q+K/V6FS+USo8rtLPnct77soC6keBBmO/gGqFIjMLqKaz/12o
        fA1H6FXpwp/Hx9Aw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH next v1 1/2] dump_stack: move cpu lock to printk.c
In-Reply-To: <YLY9NR7C1IFuNI4A@alley>
References: <20210531162051.2325-1-john.ogness@linutronix.de> <20210531162051.2325-2-john.ogness@linutronix.de> <YLY9NR7C1IFuNI4A@alley>
Date:   Tue, 01 Jun 2021 16:21:52 +0200
Message-ID: <874keh3bsv.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-01, Petr Mladek <pmladek@suse.com> wrote:
>> +void printk_cpu_lock(unsigned int *cpu_store, unsigned long *flags)
>
> I think about calling this printk_cpu_lock_irqsave() to make it clear
> that it disables interrupts.

Agreed.

> Strictly speaking, it should be enough to disable preemption. If it is
> safe when interrupted by NMI, it must be safe also when interrupted
> by a normal interrupt.
>
> I guess that the interrupts are disabled because it reduces the risk
> of nested (messed) backtraces.

If it was just about synchronizing output triggered by sysreq, then it
probably would be acceptable to leave interrupts active. But when atomic
consoles are involved, we are talking about a crashing machine that is
trying to get log messages out. Any interrupt is a risk that the machine
may not survive long enough to return from that interruption.

John Ogness
