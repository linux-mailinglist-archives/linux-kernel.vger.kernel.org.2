Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FEC430BDE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 21:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbhJQTvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 15:51:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33992 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhJQTv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 15:51:28 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634500157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f+Lyf6sWpCphHK2j6JWGIlPtdr+00/+WWvlm5aTxuug=;
        b=XNis93IOIYy9qMoJmDQkPECz/NaWYm4aUgulGzSbl3QSsX4XUnHSEUOWsRvSN4YbCef1V2
        HXXdLdUbZRa0nKgbJ0vK3/T3ye/T5r674ZozbEL2LUpefcSOG9hyvsxJ0HGBIxFGNNwc6s
        f37uO1oBCI+8BzB1ChLUqTpHHF+AHhTTFpRYD5o3izQI/DeCTri5cNfIusFMHrNgePWBqP
        hc5h88D3ALQcldNLqiDCyodE8s2jnsKdyKhgBNYrvhKhQT1qyWIolFnC9cFP7K+LiFylwG
        zD/a5Ohw0b/aCgcRGrZ0XPEj/de1UzA1vPfaBoeCgSV2PWzK0xTi2TqWy/UPAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634500157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f+Lyf6sWpCphHK2j6JWGIlPtdr+00/+WWvlm5aTxuug=;
        b=BoyczThmlFwoOGFB+QneRg7TQyaVgEXbjPUhr8D1MH1mmfKPk6NIYA6ah3HqnGJSnD1xKZ
        hok6VBk+ay9DZpDg==
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
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/6] x86/boot: Avoid #VE during boot for TDX platforms
In-Reply-To: <20211005230550.1819406-3-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211005230550.1819406-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005230550.1819406-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Sun, 17 Oct 2021 21:49:16 +0200
Message-ID: <87y26r3003.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05 2021 at 16:05, Kuppuswamy Sathyanarayanan wrote:
>  
>  	/* Enable PAE and LA57 (if required) paging modes */
> -	movl	$X86_CR4_PAE, %eax
> +	movl	%cr4, %eax
> +	/*
> +	 * Clear all bits except CR4.MCE, which is preserved.
> +	 * Clearing CR4.MCE will #VE in TDX guests.

Sure. But what's the side effect for non TDX?

> +	 */
> +	andl	$X86_CR4_MCE, %eax
> +	orl	$X86_CR4_PAE, %eax
>  	testl	%edx, %edx
>  	jz	1f
>  	orl	$X86_CR4_LA57, %eax
> @@ -662,8 +670,8 @@ SYM_CODE_START(trampoline_32bit_src)
>  	pushl	$__KERNEL_CS
>  	pushl	%eax
>  
> -	/* Enable paging again */
> -	movl	$(X86_CR0_PG | X86_CR0_PE), %eax
> +	/* Enable paging again. Avoid clearing X86_CR0_NE for TDX */

Ditto.

The changelog is not providing any information either.

Also instead of '... TDX' all over the place please add sensible defines
and add comments to those in one place. There is really no need to
sprinkle TDX all over the place.

Thanks,

        tglx
