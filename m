Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDD23522C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbhDAW0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhDAW0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:26:31 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96500C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 15:26:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x126so2416070pfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 15:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=18g3azgNpXLBiDy1fceNEHeBAHJw5ajsbhSUXk66/jI=;
        b=h0vjJ8ucH3NMUushuqVRXFeMYpppdeszEB1TYaxkpVp0oJ1QMA2NvhQtZRNiprQkhW
         Fw+RiLelIVFd0DCHgSja38PaLxnh3NRJmRBBiuel+bEtfb2xhMht0xyoZjKnxzWl7Zfo
         uTO/rOS2EQkVTZvzigUR/qacysDeN7uNf0F4Bynpim1aXofMBkAu6EBgyUT0LBj7sSpX
         r3+ec/5CPAJWAT2h2byuJBq9idcyhCnTYKR3WPDKyFrwTXjU5PXDSXvD1R0x/7aTkH+y
         E2jhRw0NqfD/0wig4srCsMJTReToDgKKRsaZN2/47mPsGlQVx73joukWeaDZ+YerYAhH
         iJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=18g3azgNpXLBiDy1fceNEHeBAHJw5ajsbhSUXk66/jI=;
        b=kwwdNvKAlSL4xmx3AAGn9/FQtaCNTPcKzW6vnq+dkVOtIsGpkPVKR8DVQITtjA4ZhP
         16J2Rfqx+ILSIJEG0guFE18RQB/ebqWe28nXBK8wClKQVDcyE+5W3hMspH0S9lkZC7Lp
         VmaYjtWJbidAdYPgO4oExr5krHC8iqLYGcKMdMkbEwp9Z4g4p9SmirbDWwK6iSE/vcCh
         lh5Znpd0Zt8YjpTSUvK+GUBDm9wGRBDSW4nrZgnum/A2ToG9G6cHQgdb6i2mmVyFK/IM
         knlgppkq6Tym2IWMQaQvoeTysInxuSKqA/6upBT7T08a2uo/KFF/66WZepXhqBg5XE5h
         zQpQ==
X-Gm-Message-State: AOAM531wIJ19yKAiAfRMpVjMWFfMRizElI2ROp7A1luqTyE4ftvEIG14
        zX/IFvaSmn4jlPHh++k0G4Pelg==
X-Google-Smtp-Source: ABdhPJzxaQY6FyUjw5pZCnv0nbBgIb7TP/OCuVAMsRFKkADjoBP2kUzz2jW8nlR/GSsNsZEIx9xlEg==
X-Received: by 2002:aa7:9aaa:0:b029:1f3:dd0e:282d with SMTP id x10-20020aa79aaa0000b02901f3dd0e282dmr9219192pfi.38.1617315990897;
        Thu, 01 Apr 2021 15:26:30 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id g21sm6438669pfk.30.2021.04.01.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 15:26:30 -0700 (PDT)
Date:   Thu, 1 Apr 2021 22:26:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 12/26] x86/tdx: Handle in-kernel MMIO
Message-ID: <YGZIks0DsfPS2IMk@google.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <94a9847072098e554146ca4fa3c6f28fc1ac5b22.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3e43ff6b-2f19-69f1-3017-d8d67abcfd9f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e43ff6b-2f19-69f1-3017-d8d67abcfd9f@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021, Dave Hansen wrote:
> On 2/5/21 3:38 PM, Kuppuswamy Sathyanarayanan wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > Handle #VE due to MMIO operations. MMIO triggers #VE with EPT_VIOLATION
> > exit reason.
> > 
> > For now we only handle subset of instruction that kernel uses for MMIO
> > oerations. User-space access triggers SIGBUS.
> ..
> > +	case EXIT_REASON_EPT_VIOLATION:
> > +		ve->instr_len = tdx_handle_mmio(regs, ve);
> > +		break;
> 
> Is MMIO literally the only thing that can cause an EPT violation for TDX
> guests?

Any EPT Violation, or specifically EPT Violation #VE?  Any memory access can
cause an EPT violation, but the VMM will get the ones that lead to VM-Exit.  The
guest will only get the ones that cause #VE.

Assuming you're asking about #VE... No, any shared memory access can take a #VE
since the VMM controls the shared EPT tables and can clear the SUPPRESS_VE bit 
at any time.  But, if the VMM is friendly, #VE should be limited to MMIO.

There's also the unaccepted private memory case, but if Linux gets an option to
opt out of that, then #VE is limited to shared memory.

> Forget userspace for a minute.  #VE's from userspace are annoying, but
> fine.  We can't control what userspace does.  If an action it takes
> causes a #VE in the TDX architecture, tough cookies, the kernel must
> handle it and try to recover or kill the app.
> 
> The kernel is very different.  We know in advance (must know,
> actually...) which instructions might cause exceptions of any kind.
> That's why we have exception tables and copy_to/from_user().  That's why
> we can handle kernel page faults on userspace, but not inside spinlocks.
> 
> Binary-dependent OSes are also very different.  It's going to be natural
> for them to want to take existing, signed drivers and use them in TDX
> guests.  They might want to do something like this.
> 
> But for an OS where we have source for the *ENTIRE* thing, and where we
> have a chokepoint for MMIO accesses (arch/x86/include/asm/io.h), it
> seems like an *AWFUL* idea to:
> 1. Have the kernel set up special mappings for I/O memory
> 2. Kernel generates special instructions to access that memory
> 3. Kernel faults on that memory
> 4. Kernel cracks its own special instructions to see what they were
>    doing
> 5. Kernel calls up to host to do the MMIO
> 
> Instead of doing 2/3/4, why not just have #2 call up to the host
> directly?  This patch seems a very slow, roundabout way to do
> paravirtualized MMIO.
> 
> BTW, there's already some SEV special-casing in io.h.

I implemented #2 a while back for build_mmio_{read,write}(), I'm guessing the
code is floating around somewhere.  The gotcha is that there are nasty little
pieces of the kernel that don't use the helpers provided by io.h, e.g. the I/O
APIC code likes to access MMIO via a struct overlay, so the compiler is free to
use any instruction that satisfies the constraint.

The I/O APIC can and should be forced off, but dollars to donuts says there are
more special snowflakes lying in wait.  If the kernel uses an allowlist for
drivers, then in theory it should be possible to hunt down all offenders.  But
I think we'll want fallback logic to handle kernel MMIO #VEs, especially if the
kernel needs ISA cracking logic for userspace.  Without fallback logic, any MMIO
#VE from the kernel would be fatal, which is too harsh IMO since the behavior
isn't so obviously wrong, e.g. versus the split lock #AC purge where there's no
legitimate reason for the kernel to generate a split lock.
