Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00BF430BE6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 21:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242793AbhJQUAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 16:00:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34028 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242719AbhJQUAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 16:00:47 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634500716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nayAYxRaMWLhlwjlwBCKqCn9Mc1r6wv7O0VDxjFDwbo=;
        b=xxPqPbXkwStGcwGk97vgo3gQwK+9SIIutD1PFI5W+Yy8wKFtrrQBNqjfqsDN3Gthen7BuW
        6Ya+P1wrpX0rbnqtwwpZfhFMo+qH88PRJCiubRU0FaajvrSNZUqgBPaVaGAvUZsJLDsDYV
        7zbDOeO0Vs4SXEGbIYDKM69DX4NmBwHPtQTdqWCf7gWxYHOgaLTC2dR68Rvmjs8RxJzs/y
        93jg3gJkRWyLNtYM+D5guYl+jRqRe7Y8rib/tJSvUjFR5I04COZbDyQdE8cKUw8yHbvx+P
        BRqHmKZeqnIrV6BqqzHH7W+cq2PWntMwGwOJcWQIHTzXGI3TC6iRDT+9sUQE3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634500716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nayAYxRaMWLhlwjlwBCKqCn9Mc1r6wv7O0VDxjFDwbo=;
        b=nOgIU5sdnBldu0pc04Vbom9ze/HDO6e12owG/8UTIPsUD5EAIDfgvZ8JjdPzFwxCzuNQIF
        itNuBVc3UhQ+ojCg==
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/10] x86/tdx: Handle port I/O
In-Reply-To: <20211005204136.1812078-6-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211005204136.1812078-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005204136.1812078-6-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Sun, 17 Oct 2021 21:58:35 +0200
Message-ID: <87v91v2zkk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05 2021 at 13:41, Kuppuswamy Sathyanarayanan wrote:
>  									\
>  static inline void outs##bwl(int port, const void *addr, unsigned long count) \
>  {									\
> -	if (sev_key_active()) {						\
> +	if (sev_key_active() ||						\
> +	    cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\

Instead of adding an extra check, can you please replace that
sev_key_active() with cc_platform_has() completely?

> +/*
> + * tdx_handle_early_io() cannot be re-used in #VE handler for handling
> + * I/O because the way of handling string I/O is different between
> + * normal and early I/O case. Also, once trace support is enabled,
> + * tdx_handle_io() will be extended to use trace calls which is also
> + * not valid for early I/O cases.
> + */
> +static void tdx_handle_io(struct pt_regs *regs, u32 exit_qual)
> +{
> +	struct tdx_hypercall_output outh;
> +	int out, size, port, ret;
> +	bool string;
> +	u64 mask;
> +
> +	string = VE_IS_IO_STRING(exit_qual);
> +
> +	/* I/O strings ops are unrolled at build time. */

Fancy. The compiler can evaluate sev_key_active() and
cc_platform_has() at build time?

Thanks,

        tglx
