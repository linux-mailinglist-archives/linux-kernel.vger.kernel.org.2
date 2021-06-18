Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4065B3AD60F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 01:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhFRXmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 19:42:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48442 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231697AbhFRXmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 19:42:00 -0400
Received: from zn.tnic (p200300ec2f0dd80047b5b1fd1153f566.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d800:47b5:b1fd:1153:f566])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 69CA71EC056D;
        Sat, 19 Jun 2021 01:39:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624059589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uzD+CRq9e3tCGtxdW12AZAUDuKDuE835JN1hDqc1yMI=;
        b=l2Pqz7PImrWy2EtK7Xzf/0TUMV76f0g/36l3T7vSgEO4iGZubtnUgTiGh8nsurwjFnMZtM
        xEwXUWS8vYDGaZQXODhbF1CypSYU+a9pMb93piPHVstRqkZuokPhXpjgAdK44kBjK6RJXb
        5kaUs6FFXywBpwfipdfLlRVQrrbB5mI=
Date:   Sat, 19 Jun 2021 01:39:39 +0200
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
Subject: Re: [PATCH v3 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <YM0uoTnAi7TpU5fF@zn.tnic>
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210618225755.662725-4-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210618225755.662725-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 03:57:47PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Add CPU feature detection for Trusted Domain Extensions support. TDX
> feature adds capabilities to keep guest register state and memory
> isolated from hypervisor.
> 
> For TDX guest platforms, executing CPUID(eax=0x21, ecx=0) will return
> following values in EAX, EBX, ECX and EDX.
> 
> EAX:  Maximum sub-leaf number:  0
> EBX/EDX/ECX:  Vendor string:
> 
> EBX =  "Inte"
> EDX =  "lTDX"
> ECX =  "    "
> 
> So when above condition is true, set X86_FEATURE_TDX_GUEST feature cap
> bit.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> Changes since v2:
>  * Fixed debug prints as per Borislav suggestion.
> 
> Changes since v1:
>  * Fixed commit log issues reported by Borislav.
>  * Moved header file include to the start of tdx.h.
>  * Added pr_fmt for TDX.
>  * Simplified cpuid_has_tdx_guest() implementation as per
>    Borislav comments.

From Documentation/process/submitting-patches.rst:

"Both Tested-by and Reviewed-by tags, once received on mailing list from tester
or reviewer, should be added by author to the applicable patches when sending
next versions.  However if the patch has changed substantially in following
version, these tags might not be applicable anymore and thus should be removed.
Usually removal of someone's Tested-by or Reviewed-by tags should be mentioned
in the patch changelog (after the '---' separator)."

IOW, for the next revisions of your patchsets, you should drop
Reviewed-by: tags on patches when they've changed more than trivially
because otherwise those tags have no meaning at all.

Also, please take the time to peruse the above document on the kernel
process while waiting.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
