Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DA3424587
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbhJFSEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 14:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238855AbhJFSEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:04:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD457C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 11:02:08 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d3600a30656d48e985313.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3600:a306:56d4:8e98:5313])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 566901EC0409;
        Wed,  6 Oct 2021 20:02:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633543327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9MBoxa57qBl8EbucXNm+6+CDpU5nKK5R74q/P2wZco=;
        b=H7xG2/CZdsJ/MgTkVy02gONTaZR27/eEb8eziA0uR/iuTgre+5stpHsyVREuNjgrjHCp6g
        bmhYzQf0zzkQzASGHVERJdiYJk/VnFDTPONvN+LBMOC1RVRDEqFSYQJVczKo0HXgcqS+AO
        MuM0ddrmTX8mhkwyf433Av16nBJGp0I=
Date:   Wed, 6 Oct 2021 20:02:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/11] x86/tdx: Add Intel ARCH support to
 cc_platform_has()
Message-ID: <YV3kmuIksOXMl11G@zn.tnic>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005211611.ys42txybaed4ffpz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211005211611.ys42txybaed4ffpz@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 02:16:11PM -0700, Josh Poimboeuf wrote:
> I assume this needs a rebase on -tip since cc_platform.c already has an
> empty version of this function (and it's static so it doesn't need to be
> declared in a header).

Yes:

arch/x86/kernel/cc_platform.c:16:28: error: static declaration of ‘intel_cc_platform_has’ follows non-static declaration
   16 | static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
      |                            ^~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/mem_encrypt.h:17,
                 from arch/x86/kernel/cc_platform.c:12:
./arch/x86/include/asm/mem_encrypt.h:105:6: note: previous declaration of ‘intel_cc_platform_has’ was here
  105 | bool intel_cc_platform_has(enum cc_attr attr);
      |      ^~~~~~~~~~~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:277: arch/x86/kernel/cc_platform.o] Error 1
make[1]: *** [scripts/Makefile.build:540: arch/x86/kernel] Error 2
make: *** [Makefile:1868: arch/x86] Error 2
make: *** Waiting for unfinished jobs....

I had already started that function there - please add all TDX logic in
cc_platform.c.

When you do your next set, you can use tip/master as a base. This should
be used for all x86 patchsets anyway.

> > +	/**
> > +	 * @CC_ATTR_GUEST_TDX: Trusted Domain Extension Support
> > +	 *
> > +	 * The platform/OS is running as a TDX guest/virtual machine.
> > +	 *
> > +	 * Examples include Intel TDX.
> > +	 */
> > +	CC_ATTR_GUEST_TDX,
> 
> Examples of TDX include TDX? :-)

Yeah, so whether we should be naming the actual conf. computing
implementation came up during the cc_platform_has() review and looking
forward in this patchset:

+       if (cc_platform_has(CC_ATTR_GUEST_TDX))
+               return tdx_kvm_hypercall(nr, 0, 0, 0, 0);

you really need to test for TDX because you're doing a TDX-specific
hypercall.

Which brings me back to the fastpath use of is_idx_guest(): this
looks to me like a fastpath use - dunno how often one needs to do TDX
hypercalls so I can imagine that for this, the is_tdx_guest() check
should use a static branch.

But only with numbers to show the need for it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
