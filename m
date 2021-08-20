Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB243F2EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 17:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241006AbhHTPRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 11:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbhHTPQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 11:16:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD8CC061756
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:16:21 -0700 (PDT)
Received: from zn.tnic (p200300ec2f107b003f09257bf467226c.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:7b00:3f09:257b:f467:226c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC5B01EC0531;
        Fri, 20 Aug 2021 17:16:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629472575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WnzRHPjY4NwfK9a1GkOYkVew9ln/KLd6Cj2tbizZfmU=;
        b=bpzcMBLsy7+rJlnGI6Ux7AUKcgaieqtNgk85MAp16vpnWLxnD3cKkNNJxWNzIKW4X34aiv
        8SH9KjJF8d43A1rPTbSMjmdsbNVWQXtlTnyft7SnawM/tkxTDZk5ZhKpkTgCCB7BYb5Asm
        AY45HdlLU378wUrGQYNDESu4Y7uL494=
Date:   Fri, 20 Aug 2021 17:16:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/12] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <YR/HZuvry/xfDKDl@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-6-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210804181329.2899708-6-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 11:13:22AM -0700, Kuppuswamy Sathyanarayanan wrote:
> +SYM_FUNC_START(__tdx_hypercall)
> +	FRAME_BEGIN
> +
> +	/* Move argument 7 from caller stack to RAX */
> +	movq ARG7_SP_OFFSET(%rsp), %rax
> +
> +	/* Check if caller provided an output struct */
> +	test %rax, %rax
> +	/* If out pointer is NULL, return -EINVAL */
> +	jz 1f
> +
> +	/* Save callee-s ved GPRs as mandated by the x86_64 ABI */

That should be "callee-saved" ofc. "s ved" is not a word. :-)

...

> +	/*
> +	 * Zero out registers exposed to the VMM to avoid
> +	 * speculative execution with VMM-controlled values.
> +	 * This needs to include all registers present in
> +	 * TDVMCALL_EXPOSE_REGS_MASK (except R12-R15).
> +	 * R12-R15 context will be restored.
> +	 */
> +	xor %r10d, %r10d
> +	xor %r11d, %r11d
> +
> +	/* Restore state of R9 register */
> +	pop %r9
> +
> +	/* Restore callee-s ved GPRs as mandated by the x86_64 ABI */

Here too.

Otherwise, LGTM. Thanks for documenting the ABI - looks good.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
