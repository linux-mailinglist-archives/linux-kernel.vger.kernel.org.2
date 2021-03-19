Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C21342418
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCSSHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:07:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38668 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhCSSHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:07:22 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616177240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N/8Nu3USqDW0VZ0PQNVW7F6Z8q5r5aRdzpPPyhxSPnQ=;
        b=r03o7ug+2f07DjMuGAREBcUndDDmBfbmLY2CgkTC2F9Hf43eFnuPRyw81Gi01P11H/X7Nr
        rW6VHsktqPtQmIZuGQPGb2Lt1X5uqQ5Q0a/pXs0UQ0K/l8/Tphv+NzRqgwl3O7Aelax1r1
        yrHUOSjS6EW66CadpMFRA4R8vmu28L45ftroRKPOxp5ZENk5lUQ8QZO37jBGoOnRvPlZ7c
        cupnNKx3pbDv0U6BWmfIn1q4LaEjYvOTGLBJeni0pg95Subm1Cd0t5cY7opWyDw6kDD3gB
        +3PCajhGCDWiHemaxOOY9/032QvL0KWwtpOfdNegn16v/WfsWNyaQFla1Sdncg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616177240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N/8Nu3USqDW0VZ0PQNVW7F6Z8q5r5aRdzpPPyhxSPnQ=;
        b=WLd/MAV88ztjcdmZgt56koSN7b2ULlpg23UGyIx81nQqhtkjnJPg/MD7VmPfL58nOc0T6Z
        H9o3+KJnsxeRw0AA==
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4 4/9] kentry: Simplify the common syscall API
In-Reply-To: <0e04f8d34cb52320110057021184d8facec7e1a6.1616004689.git.luto@kernel.org>
References: <cover.1616004689.git.luto@kernel.org> <0e04f8d34cb52320110057021184d8facec7e1a6.1616004689.git.luto@kernel.org>
Date:   Fri, 19 Mar 2021 19:07:20 +0100
Message-ID: <87lfaj586f.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17 2021 at 11:12, Andy Lutomirski wrote:
> @@ -119,31 +119,12 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
>  void enter_from_user_mode(struct pt_regs *regs);
>  
>  /**
> + * kentry_syscall_begin - Prepare to invoke a syscall handler
>   * @regs:	Pointer to currents pt_regs
>   * @syscall:	The syscall number
>   *
>   * Invoked from architecture specific syscall entry code with interrupts
> - * enabled after invoking syscall_enter_from_user_mode_prepare() and extra
> - * architecture specific work.
> + * enabled after kentry_enter_from_usermode or a similar function.

Please write functions with () at the end. Also what the heck means
'similar function' here? I really spent quite some time to document this
stuff and it wants to stay that way.

>   *
> + * Called with IRQs on.  Returns with IRQs still on.

interrupts enabled please. This is technical documentation and not twatter.

> +void kentry_syscall_end(struct pt_regs *regs);

Thanks,

        tglx
