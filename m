Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99824342179
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhCSQKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCSQJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:09:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7259DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:09:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616170193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jZQyZ/QFefmWJKshcvvXqnJfLZpWdC89uxHxfKKtAhI=;
        b=ofxxqTfqqS8aQhrw/Lp3lLeOskwOqoNd5m6+FnxJxtbXW7wCPDJI2CENj0Omf6Q9Sw8ySi
        h1EjiOSAC6RRoPjkaNpudKDXPI9TQ73d3eJkPm9Jf8KPyEW6KrZZC5dsuRAbu9Ml8l6q5U
        KhI9sUxcZ25OwfL2ucDr+n40AzjoEbpTKe9I+m2ze69A/MnURC/fYdaYnDkL8PvFHZPd5h
        /0C7rVyagZ9AK2cgGm/O45am5NIAiALfB3gywV9X6yVsf9gWdKiEk0kHyIryvRy4+eX10v
        nFyMcYyLuMnEEwSqdXUgqiZs5xfSdaSbdp88NnYJzvAWG3kaCwMHs/XaOxvrkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616170193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jZQyZ/QFefmWJKshcvvXqnJfLZpWdC89uxHxfKKtAhI=;
        b=wPrLU2HWlVloD7nkxwl9L5lARm+ziOX5y9u7N5es+iTVp6oQWHQGbfxzRW7TzyFsVm8f1O
        RvLOuNrhqdYwXcAA==
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4 4/9] kentry: Simplify the common syscall API
In-Reply-To: <0e04f8d34cb52320110057021184d8facec7e1a6.1616004689.git.luto@kernel.org>
References: <cover.1616004689.git.luto@kernel.org> <0e04f8d34cb52320110057021184d8facec7e1a6.1616004689.git.luto@kernel.org>
Date:   Fri, 19 Mar 2021 17:09:53 +0100
Message-ID: <87sg4r5dm6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17 2021 at 11:12, Andy Lutomirski wrote:
> The new common syscall API had a large and confusing API surface.  Simplify
> it.  Now there is exactly one way to use it.  It's a bit more verbose than
> the old way for the simple x86_64 native case, but it's much easier to use
> right,

and therefore much easier to get wrong...

>  __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
>  {
> -	nr = syscall_enter_from_user_mode(regs, nr);
> -
> +	kentry_enter_from_user_mode(regs);
> +	local_irq_enable();

... That needs to be _after_ instrumentation_begin(). If you fiddle
with this then please make sure that objtool validates noinstr...

> +	kentry_enter_from_user_mode(regs);
> +	local_irq_enable();

Ditto

> +	instrumentation_begin();
>  static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
>  {
>  	unsigned int nr = syscall_32_enter(regs);
> +	bool ret;
>  	int res;
>  
> -	/*
> -	 * This cannot use syscall_enter_from_user_mode() as it has to
> -	 * fetch EBP before invoking any of the syscall entry work
> -	 * functions.
> -	 */
> -	syscall_enter_from_user_mode_prepare(regs);
> -
> +	kentry_enter_from_user_mode(regs);
> +	local_irq_enable();

...

>  	instrumentation_begin();

Thanks,

        tglx
