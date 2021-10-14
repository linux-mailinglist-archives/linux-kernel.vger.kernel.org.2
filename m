Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE8342D76C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhJNKtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhJNKts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:49:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C27C061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 03:47:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634208461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4mQ0/BPi7a3gE3UHuSg88Qq0Kh05Mxa+eW16IU4Tkmc=;
        b=MQLUhc2hXSHFlXDHYZuXZaw2AZfWeVjpBB/EXa9H9eTalVwsZVCOiPQYUZaIBAS/EmpMlI
        THx7s0oxvuOSCNSc9nfVn50x3tIYAmWzREJTlABnYWLSmf0fHwXo/zLsgfaSuYjOFtzbnV
        UZvLz6ZAX9G1DU+HrrbetrtDL/7M0U7/3U+x1d11KVc7vY4ElkgitDDFs871iVdsyj8HKp
        8x/2ZgyJsV5e3v0sQX+K6kASVvA6NFYzQsT7g30ohImEHdjzm33idWk+yStWmglZG+pEOS
        XCOqdpHLqGN+6TG/iQhCojkWROWtlYVVLl/BBg8DGrkW9pIGlgd/4rDSfn6fTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634208461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4mQ0/BPi7a3gE3UHuSg88Qq0Kh05Mxa+eW16IU4Tkmc=;
        b=NOfCnCKcN2Py3IC0XTvOFg2/+GcSix/x0LS21uOUYnKhG7/aMgMS63JKwZlRrUltgSwGu6
        E4uKezQLS28A4SDQ==
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 10/11] x86/tdx: Don't write CSTAR MSR on Intel
In-Reply-To: <20211009053747.1694419-11-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-11-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Thu, 14 Oct 2021 12:47:41 +0200
Message-ID: <87czo77uia.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08 2021 at 22:37, Kuppuswamy Sathyanarayanan wrote:
> From: Andi Kleen <ak@linux.intel.com>
>
> On Intel CPUs writing the CSTAR MSR is not really needed. Syscalls
> from 32bit work using SYSENTER and 32bit SYSCALL is an illegal opcode.
> But the kernel did write it anyways even though it was ignored by
> the CPU. Inside a TDX guest this actually leads to a #VE which in
> turn will trigger ve_raise_fault() due to failed MSR write. Inside
> ve_raise_fault() before it recovers from this error, it prints an
> ugly message at boot. Since such warning message is pointless for
> CSTAR MSR write failure, add exception to skip CSTAR msr write on
> Intel CPUs.

Ugly messages are a technical reason? The above is word salad.

   Intel CPUs do not support SYSCALL in 32-bit mode, but the kernel
   initializes MSR_CSTAR unconditionally. That MSR write is normaly
   ignored by the CPU, but in a TDX guest it raises a #VE trap.

   Exlude Intel CPUs from the MSR_CSTAR initialization.

>  #ifdef CONFIG_IA32_EMULATION
> -	wrmsrl(MSR_CSTAR, (unsigned long)entry_SYSCALL_compat);
> +	/*
> +	 * CSTAR is not needed on Intel because it doesn't support
> +	 * 32bit SYSCALL, but only SYSENTER. On a TDX guest
> +	 * it leads to a #GP.

Sigh. Above you write it raises #VE, but now it's #GP !?!

        Intel CPUs do not support 32-bit SYSCALL. Writing to MSR_CSTAR
        is normaly ignored by the CPU, but raises a #VE trap in a TDX
        guest.

Hmm?

Thanks,

        tglx
