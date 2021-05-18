Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60638387D39
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350546AbhERQT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242950AbhERQT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:19:56 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD10C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 09:18:37 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id k15so7350853pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 09:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3ZRMKj6tmjKZGH2i7vTWIhD5fIZJb9lrkgsZ9UxuNmI=;
        b=YMJhgMCYSTsHYeKDS5BMETJOqvkQ8kh0RB+N5CE/JgN9A+6HSiFStNZNre4mACEB9F
         DCpF/ZvzI+RAhXg9eVp1hjjYZ7pX7wFUE/fABmtFOxh6NP+uJRj+iwoIIX8WMoBuQYOq
         JdKFUceVPGgd2GDYZJ7nvwzluevoLd2W0NFqOxP84uxXHx3E2j8esV573pfgBUSPGOcM
         fH6+QTmKNp/HwZCIB3VWAMgLMcSlsRaxftyM50m4ZVHVpxI0v44rGP/OG17bt3bIH7Z3
         FSoRTUtvLSkFNAtusMHwQ23Jq5DCBb4AkhuDaBsfcfFbnieAf48bF71CM/iIuGw+VqQ/
         PHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3ZRMKj6tmjKZGH2i7vTWIhD5fIZJb9lrkgsZ9UxuNmI=;
        b=NhKNepksTDSkBQOi7xNzU1vXcDBgRBLkr91/eWdrX/od1AwEW9GWgB6UYL+AYm1lP+
         taxdXfs6gUFzZ3zRFbpOf1i/wBXCQVZxs6CwIxIXr1qdpmEA2u1zVjxTpK7qQJ29SxDH
         ZOEyt2Gy4Y30Pw4ZNUX/LBMARUZAZhOhbG8wrml4EqdLii1B0gC7528ya9TOssZ+pW+N
         Ct475uluAlwkFT9gSy1VmQTUwJqfagqM7frBP8N66eBX7EvA0UG8EoSf6wMJQ5uzlg3j
         xM2G7ecWrR5Ei5A7pTWhY576Px4IS51Yg3cGFjo1JX7PWEiob2VbmUoA6VjbWl4aWy86
         kauw==
X-Gm-Message-State: AOAM5311TCqQANvB/vjsZpNl7N9CZzh/hqZsuaYnlyCDi3YAP3N2D36/
        UKoyeCewihr+AxWXIy75wC+mSw==
X-Google-Smtp-Source: ABdhPJzhf3e2zkJSdBy9ezZFmXDhtdUeI2zlqfEhYiHf6j7QUEpXLQ+5IY9UGr5GjvBcfBqv68C1HA==
X-Received: by 2002:a62:1a0d:0:b029:2da:21a6:6838 with SMTP id a13-20020a621a0d0000b02902da21a66838mr5912942pfa.76.1621354717174;
        Tue, 18 May 2021 09:18:37 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id mp21sm2360060pjb.50.2021.05.18.09.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 09:18:36 -0700 (PDT)
Date:   Tue, 18 May 2021 16:18:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Handle in-kernel MMIO
Message-ID: <YKPo2Zde5b0QxIPJ@google.com>
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021, Dave Hansen wrote:
> On 5/17/21 5:48 PM, Kuppuswamy Sathyanarayanan wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > In traditional VMs, MMIO tends to be implemented by giving a
> > guest access to a mapping which will cause a VMEXIT on access.
> > That's not possible in TDX guest.
> 
> Why is it not possible?

It is possible, and in fact KVM will cause a VM-Exit on the first access to a
given MMIO page.  The problem is that guest state is inaccessible and so the VMM
cannot do the front end of MMIO instruction emulation.

> > So use #VE to implement MMIO support. In TDX guest, MMIO triggers #VE
> > with EPT_VIOLATION exit reason.

It's more accurate to say that the VMM will configure EPT entries for pages that
require instruction emulation to cause #VE.

> What does the #VE handler do to resolve the exception?
> 
> > For now we only handle a subset of instructions that the kernel
> > uses for MMIO operations. User-space access triggers SIGBUS.
> 
> How do you know which instructions the kernel uses?  How do you know
> that the compiler won't change them?
>
> I guess the kernel won't boot far if this happens, but this still sounds
> like trial-and-error programming.

If a driver accesses MMIO through a struct overlay, all bets are off.  The I/O
APIC code does this, but that problem is "solved" by forcefully disabling the
I/O APIC since it's useless for the current incarnation of TDX.  IIRC, some of
the console code also accesses MMIO via a struct (or maybe just through generic
C code), and the compiler does indeed employ a wider variety of instructions.

So yeah, whack-a-mole.
 
> > Also, reasons for supporting #VE based MMIO in TDX guest are,
> > 
> > * MMIO is widely used and we'll have more drivers in the future.
> 
> OK, but you've also made a big deal about having to go explicitly audit
> these drivers.  I would imagine converting these over to stop using MMIO
> would be _relatively_ minor compared 

For drivers that use the kernel's macros, converting them to use TDVMCALL
directly will be trivial and shouldn't even require any modifications to the
driver.  For drivers that use a struct overlay or generic C code, the "conversion"
could require a complete rewrite of the driver.

> to a big security audit and new fuzzing infrastructure.
> 
> > * We don't want to annotate every TDX specific MMIO readl/writel etc.
> 
> 				    ^ TDX-specific
> 
> > * If we didn't annotate we would need to add an alternative to every
> >   MMIO access in the kernel (even though 99.9% will never be used on
> >   TDX) which would be a complete waste and incredible binary bloat
> >   for nothing.
> 
> That sounds like something objective we can measure.  Does this cost 1
> byte of extra text per readl/writel?  10?  100?

Agreed.  And IMO, it's worth converting the common case (macros) if the overhead
is acceptable, while leaving the #VE handling in place for non-standard code.

> > +static int tdg_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 
...

> > +		return 0;
> > +	}
> > +
> > +	kernel_insn_init(&insn, (void *) regs->ip, MAX_INSN_SIZE);
> > +	insn_get_length(&insn);
> > +	insn_get_opcode(&insn);
> > +
> > +	write = ve->exit_qual & 0x2;
> > +
> > +	size = insn.opnd_bytes;
> > +	switch (insn.opcode.bytes[0]) {
> > +	/* MOV r/m8	r8	*/
> > +	case 0x88:
> > +	/* MOV r8	r/m8	*/
> > +	case 0x8A:
> > +	/* MOV r/m8	imm8	*/
> > +	case 0xC6:
> 
> FWIW, I find that *REALLY* hard to read.

Why does this code exist at all?  TDX and SEV-ES absolutely must share code for
handling MMIO reflection.  It will require a fair amount of refactoring to move
the guts of vc_handle_mmio() to common code, but there is zero reason to maintain
two separate versions of the opcode cracking.

Ditto for string I/O in vc_handle_ioio().

> What happens if this is an MMIO operation that *partially* touches MMIO
> and partially touches normal memory?  Let's say I wrote two bytes
> (0x1234), starting at the last byte of a RAM page that ran over into an
> MMIO page.  The fault would occur trying to write 0x34 to the MMIO, but
> the instruction cracking would result in trying to write 0x1234 into the
> MMIO.
> 
> It doesn't seem *that* outlandish that an MMIO might cross a page
> boundary.  Would this work for a two-byte MMIO that crosses a page?

I'm pretty sure we can get away with panic (kernel) and SIGBUS (userspace) on
a reflected memory access that splits a page.  Yes, it's theoretically possible
and probably even "works", but practically speaking no emulated MMIO device is
going to have a single logical register/thing split a page, and I can't think of
any reason to allow accessing multiple registers/things across a page split.

The existing SEV-ES #VC handlers appear to be missing page split checks, so that
needs to be fixed.
