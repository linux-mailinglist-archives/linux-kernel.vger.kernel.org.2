Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6218A406796
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhIJHVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhIJHVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:21:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9382C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 00:20:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m9so1223217wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 00:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iJFJNO7HazxASKzot89fdkmKjYKn2fCY5T7vhzDa3ZE=;
        b=aJNUKlOco3x9JVQo8mM8b7SI39D0X28LE6YJ/X0wv4lXsAQBm8Uov2WVExwV6zJcgo
         NXRRlJSvErPHxZpOJn+vCOsee0K/MbuT7lpP8xjttsdIrA62MF6Of1xB9YwdkPCVFe0X
         3w8xe/H022F8C2+ELDburFr5DVFja/H0trZDh6Cy1c8s1Y17I+SMxWUOQED+IrxY1uES
         0/DoHSqN0wV2gV7GZSTWDLji/ZEplZaAaQLKqWDPoEM0hHVLUMhugK8KYzkhHz2HWnjW
         4xKJ21iGedNiLp0NqtSWmexYOGDQPKPO7NfFdArtN/rKeMoID0o8LTZAcZf5TnDr1tP0
         zJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iJFJNO7HazxASKzot89fdkmKjYKn2fCY5T7vhzDa3ZE=;
        b=ZUDiit1WBSJAJ432ESPgJ86yiTwryl0m3i+fUgtYmo0IX9y1YaT1qBbAkkC5NmgyYq
         Bui38AGAYYgaEotMDATXOCxE/J6U+OlvyE2h6kiScMwOjDyS6cKYpnR5Xp7ePnxwOPAb
         /WhRuxYUU92WaYKLLvkigutslByPxLvU+BJ8fLsb6IlokxopZIeVMow7YTD7p4Jhp5TC
         TO7IqTsNMkRi5whvHGW9aU4lPZPdZQE1zp6+M9mZIao5fRYPIZ8LbytjmKLFJ9rE/26u
         eQigakE6w3Q1bj99v2Q3A9gZXFWLleWsKnrWBFgVxvh8ThTORXMhXAOs5HA11ppMJNWp
         VlZw==
X-Gm-Message-State: AOAM530V7GUGmrxjHA4vDhlwhRBVUdEydNKJ3ZzyKIz0dR2LZzbGl0hx
        gPE09hBOCgktiGWZ0srEciE=
X-Google-Smtp-Source: ABdhPJxwSYrjEYINQzeNtpSQeiBkPn0jnGKiDaNIMU3B05a1EjAV2kvm+OJMs3eZydU3K1nSxksKXw==
X-Received: by 2002:adf:f984:: with SMTP id f4mr8064712wrr.331.1631258404565;
        Fri, 10 Sep 2021 00:20:04 -0700 (PDT)
Received: from [10.20.1.172] ([185.138.176.94])
        by smtp.gmail.com with ESMTPSA id a133sm3778778wme.5.2021.09.10.00.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 00:20:04 -0700 (PDT)
Subject: Re: [PATCH 24/24] x86/syscall/64: Move the checking for sysret to C
 code
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-25-jiangshanlai@gmail.com>
From:   Nikolay Borisov <n.borisov.lkml@gmail.com>
Message-ID: <0801d530-9a86-fbc8-9c27-6beae1f114f3@gmail.com>
Date:   Fri, 10 Sep 2021 10:20:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210831175025.27570-25-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.08.21 г. 20:50, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Like do_fast_syscall_32() which checks whether it can return to userspace
> via fast instructions before the function returns, do_syscall_64()
> also checks whether it can use sysret to return to userspace before
> do_syscall_64() returns via C code.  And a bunch of ASM code can be removed.
> 
> No functional change intended.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

<snip>

> +/*
> + * Check if it can use SYSRET.
> + *
> + * Try to use SYSRET instead of IRET if we're returning to
> + * a completely clean 64-bit userspace context.
> + *
> + * Returns 0 to return using IRET or 1 to return using SYSRET.
> + */
> +static __always_inline int can_sysret(struct pt_regs *regs)

nit: Since this is a predicate function why not simply return bool ?

> +{
> +	/* In the Xen PV case we must use iret anyway. */
> +	if (static_cpu_has(X86_FEATURE_XENPV))
> +		return 0;
> +
> +	/* SYSRET requires RCX == RIP && R11 == RFLAGS */
> +	if (regs->ip != regs->cx || regs->flags != regs->r11)
> +		return 0;
> +
> +	/* CS and SS must match SYSRET */
> +	if (regs->cs != __USER_CS || regs->ss != __USER_DS)
> +		return 0;
> +
> +	/*
> +	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
> +	 * in kernel space.  This essentially lets the user take over
> +	 * the kernel, since userspace controls RSP.
> +	 */
> +	if (regs->cx != canonical_address(regs->cx))
> +		return 0;
> +
> +	/*
> +	 * SYSCALL clears RF when it saves RFLAGS in R11 and SYSRET cannot
> +	 * restore RF properly. If the slowpath sets it for whatever reason, we
> +	 * need to restore it correctly.
> +	 *
> +	 * SYSRET can restore TF, but unlike IRET, restoring TF results in a
> +	 * trap from userspace immediately after SYSRET.  This would cause an
> +	 * infinite loop whenever #DB happens with register state that satisfies
> +	 * the opportunistic SYSRET conditions.  For example, single-stepping
> +	 * this user code:
> +	 *
> +	 *           movq	$stuck_here, %rcx
> +	 *           pushfq
> +	 *           popq %r11
> +	 *   stuck_here:
> +	 *
> +	 * would never get past 'stuck_here'.
> +	 */
> +	if (regs->r11 & (X86_EFLAGS_RF | X86_EFLAGS_TF))
> +		return 0;
> +
> +	return 1;
> +}
> +
> +/* Returns 0 to return using IRET or 1 to return using SYSRET. */
> +__visible noinstr int do_syscall_64(struct pt_regs *regs, int nr)

nit: Ditto about bool

>  {
>  	add_random_kstack_offset();
>  	nr = syscall_enter_from_user_mode(regs, nr);
> @@ -84,6 +154,7 @@ __visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
>  
>  	instrumentation_end();
>  	syscall_exit_to_user_mode(regs);
> +	return can_sysret(regs);
>  }
>  #endif
>  

<snip>
