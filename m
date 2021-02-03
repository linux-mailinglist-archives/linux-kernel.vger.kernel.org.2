Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BC330E2F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhBCS5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhBCS5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:57:09 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65D4C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 10:56:29 -0800 (PST)
Received: from zn.tnic (p200300ec2f0c84009b5670f942e9d280.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8400:9b56:70f9:42e9:d280])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6055B1EC04BF;
        Wed,  3 Feb 2021 19:56:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612378588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=K8nOFh6JLe/Vzhm200Cg+IJZ6YmWcAnqNRvjfWkQIzQ=;
        b=gkaMfCMlEu1dP1MvbpwbjAB/U+aYwSg6kCiZjmG+oaS8kgTiR1lInlaRVXGTAfntzYWyv4
        1PsqF6ShTpOOyVvhHqlx9pNxadXZM3UK+/sXPorMPT5qbx3H8zvgUrfkndWOOmWaRkD5o7
        uwbLuFJdX0rjRewfUawE3r8x8R8CZ8w=
Date:   Wed, 3 Feb 2021 19:56:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 07/11] x86/fault: Split the OOPS code out from
 no_context()
Message-ID: <20210203185517.GH13819@zn.tnic>
References: <cover.1612113550.git.luto@kernel.org>
 <c5f715daf95fc7e94e279f0486908b53e1cdba3c.1612113550.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5f715daf95fc7e94e279f0486908b53e1cdba3c.1612113550.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 09:24:38AM -0800, Andy Lutomirski wrote:
> Not all callers of no_context() want to run exception fixups.
> Separate the OOPS code out from the fixup code in no_context().
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/mm/fault.c | 116 +++++++++++++++++++++++---------------------
>  1 file changed, 62 insertions(+), 54 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 1939e546beae..6f43d080e1e8 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -618,53 +618,20 @@ static void set_signal_archinfo(unsigned long address,
>  }
>  
>  static noinline void
> -no_context(struct pt_regs *regs, unsigned long error_code,
> -	   unsigned long address, int signal, int si_code)
> +page_fault_oops(struct pt_regs *regs, unsigned long error_code,

Not sure about this name - it still tries to recover:
efi_recover_from_page_fault().

Judging by where it is called, maybe no_context_tail() or
no_context_oops() or no_context_finish_me_already()...

Yah, I haz no better idea. :-\

...

> @@ -739,6 +692,61 @@ no_context(struct pt_regs *regs, unsigned long error_code,
>  	oops_end(flags, regs, sig);
>  }
>  
> +static noinline void
> +no_context(struct pt_regs *regs, unsigned long error_code,
> +	   unsigned long address, int signal, int si_code)
> +{
> +	if (user_mode(regs)) {
> +		/*
> +		 * This is an implicit supervisor-mode access from user
> +		 * mode.  Bypass all the kernel-mode recovery code and just
> +		 * OOPS.
> +		 */
> +		goto oops;

Just do

		return page_fault_oops(...);

here and get rid of the label.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
