Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66D93FFE16
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 12:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349005AbhICKSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 06:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbhICKSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 06:18:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD20C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 03:17:31 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d5800e0c92975d32b0bec.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5800:e0c9:2975:d32b:bec])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E6A81EC05A0;
        Fri,  3 Sep 2021 12:17:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630664245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RxubfiXbH774+lNGmFrxRDAKoJxNFAxMcUOpI4XGr4c=;
        b=F0i6Xft5KGZzhD8UikmT/I6yfhKqRSX3d8Xp3j21YbMxiW746xT3pJAsJN+bJbQh2lqRRR
        cg3gZiLWkrnWBv2sb9g3cUgNV2/Pg6uR8u6wz5T9vy+fqe166YAsmTwU5fJt/YJNFXzWEx
        DD2GY30gRWOxx68saCq9TaTxsFZjhTc=
Date:   Fri, 3 Sep 2021 12:17:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
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
Subject: Re: [PATCH v5 07/12] x86/traps: Add #VE support for TDX guest
Message-ID: <YTH2UjxhkFUEX8FW@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-8-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSTHMAUA1LjjOQPe@zn.tnic>
 <99c5f6e9-a747-1a4a-d0f4-95b8b28e0d02@linux.intel.com>
 <YSUwi2HraMFVanTP@zn.tnic>
 <42201ef7-6552-3fbc-23ef-013cb3e93649@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42201ef7-6552-3fbc-23ef-013cb3e93649@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 08:24:53AM -0700, Kuppuswamy, Sathyanarayanan wrote:
> If MSR read/write failed in tdx_handle_virtualization_exception(), it will
> return non zero return value which in turn will trigger ve_raise_fault().
> 
> If we don't call fixup_exception() for such case, it will trigger oops
> and eventually panic in TDX. For MSR read/write failures we don't want
> to panic.
> 
> #VE MSR read/write
>  -> exc_virtualization_exception()
>     -> tdx_handle_virtualization_exception()
>        ->tdx_write_msr_safe()
>     -> ve_raise_fault
>        -> fixup_exception()

Lemme see if I understand this correctly: you're relying on the kernel
exception handling fixup to end up in

	ex_handler_{rd,wr}msr_unsafe()

which would warn but succeed so that you return from ve_raise_fault()
before die()ing?

If so, I could use a comment in ve_raise_fault() in case we touch the
fixup exception machinery, like we're currently doing.

> Reason for calling die_addr() is to trigger oops for failed #VE handling, which
> is desirable for TDX. Also sending die notification may be useful for debuggers.
> 
> This sequence of calls are similar to exc_general_protection().

Ok.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
