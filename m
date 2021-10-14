Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6DE42DB81
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhJNO36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhJNO35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:29:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E33EC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 07:27:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634221670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k8zryRQvwI325YNtxkoamfj1r/s73jL1asi97x/YPR4=;
        b=iaFQKFbmt47QnM4ehrm4cSrbB+VCDwL+QLPwDVlZhdyIX7P9uGmfzRkZP4NqWy13DSTsmm
        JM++1YgCeEFoqj7ih2tHITDKEX8O5p/1260P8DaVRMeOoi0D5bci2G07xo8FFn/yKKJi8k
        qDQaiKvcV9nTwkhiHWKh3tCaAom4THBixcaqtnwuZCZRhrazFKoBigDh+D8ctxmxShengz
        +/ii8qLghhP6t2bycY0Mb8sepBocgyQq+VPHPJ5ts97AJOgPLoi5MqhawzGhdeWS67IejR
        dBTwo8aWrM01U/LtqiQTjSxoREWLZONOfSYw4qQNcT8Dba5dAmK1uQDie4h/JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634221670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k8zryRQvwI325YNtxkoamfj1r/s73jL1asi97x/YPR4=;
        b=g/l777vqrPA6Hlimeyxq4VALCaYExxVt1IwMAoeXVXALN/tV1z43QigWg3EURuGAuSka4i
        Ycx+oYdPy5+FI5Ag==
To:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
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
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 10/11] x86/tdx: Don't write CSTAR MSR on Intel
In-Reply-To: <641e8b18-230d-699c-6ec5-1aa107d7d5bb@linux.intel.com>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-11-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87czo77uia.ffs@tglx>
 <641e8b18-230d-699c-6ec5-1aa107d7d5bb@linux.intel.com>
Date:   Thu, 14 Oct 2021 16:27:49 +0200
Message-ID: <87r1cn65qy.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14 2021 at 06:47, Andi Kleen wrote:

>>> -	wrmsrl(MSR_CSTAR, (unsigned long)entry_SYSCALL_compat);
>>> +	/*
>>> +	 * CSTAR is not needed on Intel because it doesn't support
>>> +	 * 32bit SYSCALL, but only SYSENTER. On a TDX guest
>>> +	 * it leads to a #GP.
>> Sigh. Above you write it raises #VE, but now it's #GP !?!
>
>
> The unhandled #VE trap is handled like a #GP, which is then caught by 
> the kernel wrmsr code.

That's completely irrelevant because that's an implementation detail of
the #VE handler. It raises #VE in the first place and that's unwanted no
matter what the #VE handler does with it. It could just pretent that
it's fine and move on.

Thanks,

        tglx


