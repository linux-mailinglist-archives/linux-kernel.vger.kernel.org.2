Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36DE3FD496
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242713AbhIAHmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:42:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40054 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242660AbhIAHmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:42:24 -0400
Received: from zn.tnic (p200300ec2f0f3000ff66408ba4c79392.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:3000:ff66:408b:a4c7:9392])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF5B31EC051E;
        Wed,  1 Sep 2021 09:41:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630482083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=b0wiLdV/sTJcclFf0mgjAxzhXW/epoX+CHp2TKm2RDM=;
        b=cOVczLGHd4PSquOG6P9RC+m3pH5VcA0R8z72qAqhOuUZlrB5LnNeuM/ag7b81+oPr7Ps6q
        +eHJW/2C+LUVF0f5YgK4+CtCcG6Lnoi0qtbWbfSZK/UvsiVBWdHj5Kl4+W6VEgn3rLA5fF
        IOIN7BzTjybnMOGo9Vw7Bb2nUFvD+PQ=
Date:   Wed, 1 Sep 2021 09:42:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/12] x86/tdx: Add HLT support for TDX guest
Message-ID: <YS8uy5YGGE1LGoHF@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-9-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSUaAQPiBUqubBHM@zn.tnic>
 <YSUnDQUrGYc8aY9j@google.com>
 <YSUsBVx2DD7MCyn/@zn.tnic>
 <0d2421ac-c501-d33f-d3fc-be9dac7e221c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d2421ac-c501-d33f-d3fc-be9dac7e221c@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 01:49:54PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Regarding details about _tdx_hypercall() wrapper usage, do you want me
> to document the ABI details?
> 
> For example for MSR read,
> 
> static u64 tdx_read_msr_safe(unsigned int msr, int *err)
> {
>         struct tdx_hypercall_output out = {0};
>         u64 ret;
> 
>         WARN_ON_ONCE(tdx_is_context_switched_msr(msr));
> 
>         /*
>          * TDX MSR READ Hypercall ABI:
>          *
>          * Input Registers:
>          *
>          * R11(EXIT_REASON_MSR_READ) - hypercall sub function id
>          * R12(msr) - MSR index
>          *
>          * Output Registers:
>          *
>          * R10(out.r10) - Hypercall return error code
>          * R11(out.r11) - MSR read value
>          * RAX(ret) - TDCALL error code
>          */
>         ret = _tdx_hypercall(EXIT_REASON_MSR_READ, msr, 0, 0, 0, &out);
> 
> Let me know if you agree with above format?

Yes, that's nice, thanks.

Alternatively, you could simply point at the relevant place in the TDX
documentation so that people can go look at it and find out how, for
example, a MSR read is done, ABI-wise.

With all those confidential computing solutions and the amount of specs
out there, one can get lost pretty easily so having doc references
should be very helpful.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
