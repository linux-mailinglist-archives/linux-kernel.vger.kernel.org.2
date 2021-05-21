Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D4838C9ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbhEUPTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbhEUPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:19:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24A6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:18:13 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ea400b1711cbbd717391b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a400:b171:1cbb:d717:391b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 73E181EC064A;
        Fri, 21 May 2021 17:18:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621610292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=75BcPGwrcRtrwM8LJ/DvHobJKJ1eSVXvjytheUa1d6U=;
        b=chSLrDknUeNDot1Da/nFuLKm4fBmFGPqXAk5YCmIQwlHN62zsxbaa6i3lM2r0NdOGjzHUr
        VoTx90T4Ypym9g7Dbkff3NzwIC2bwoIw48k4e0qC4x1VWIvrHF+hTGKYNe14YaSoKMgd6x
        /iknf8L/w8q+p6IS3pLFHUvatFtDw0c=
Date:   Fri, 21 May 2021 17:18:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
Message-ID: <YKfPLlulaqwypNkO@zn.tnic>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <eaaa692ce1ed897f66f864bbfa2df8683768d79e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <b884067a-19d6-105f-9f8c-28feb3b43446@intel.com>
 <312879fb-d201-a16d-2568-150152044c54@linux.intel.com>
 <797c95bf-9516-8aee-59d0-f5259d77bb75@linux.intel.com>
 <5b4b4fc0-aaa8-3407-6602-537d59572bc1@intel.com>
 <YJm5QY8omAvdpBO9@google.com>
 <YJpP/S8MajKNhBl4@zn.tnic>
 <0e233779-9c10-11df-b527-ef61e003ea35@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e233779-9c10-11df-b527-ef61e003ea35@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 01:12:58PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> I see many variants of SEV/SME related checks in the common code path
> between TDX and SEV/SME. Can a generic call like
> protected_guest_has(MEMORY_ENCRYPTION) or is_protected_guest()
> replace all these variants?

It depends...

> We will not be able to test AMD related features. So I need to confirm
> it with AMD code maintainers/developers before making this change.

Lemme add two to Cc.

So looking at those examples, you guys are making it not very
suspenceful for TDX - it is the same function in all. :)

> arch/x86/include/asm/io.h:313:	if (sev_key_active() || is_tdx_guest()) {			\
> arch/x86/include/asm/io.h:329:	if (sev_key_active() || is_tdx_guest()) {			\

So I think the static key on the AMD side is not really needed and it
could be replaced with

	sev_active() && !sev_es_active()

i.e. SEV but but not SEV-ES. A vendor-agnostic function would do here
probably something like:

	protected_guest_has(ENC_UNROLL_STRING_IO)

and inside it, it would do:

	if (AMD)
		amd_protected_guest_has(...)
	else if (Intel)
		intel_protected_guest_has(...)
	else
		WARN()

and both vendors would each implement that function with the respective
low-level query functions.

> arch/x86/kernel/pci-swiotlb.c:52:	if (sme_active() || is_tdx_guest())

That can be probably

	protected_guest_has(ENC_HOST_MEM_ENCRYPT);

as on AMD that means SME but not SEV. I guess on Intel you guys want to
do bounce buffers in the guest? or so...

> arch/x86/mm/ioremap.c:96:	if (!sev_active() && !is_tdx_guest())

So that function should simply be replaced with:

        if (!(desc->flags & IORES_MAP_ENCRYPTED)) {
		/* ... comment bla explaining what this is... */
		if ((sev_active() || is_tdx_guest()) &&
		    (res->desc != IORES_DESC_NONE &&
		     res->desc != IORES_DESC_RESERVED))
				desc->flags |= IORES_MAP_ENCRYPTED;
	}

as to the first check I guess:

	protected_guest_has(ENC_GUEST_ENABLED)

or so to mean, kernel is running as an encrypted guest...

> arch/x86/mm/pat/set_memory.c:1984:	if (!mem_encrypt_active() && !is_tdx_guest())

That should probably be

	protected_guest_has(ENC_ACTIVE);

to denote the generic "I'm running some sort of memory encryption..."

Yeah, this is all rough and should show the main idea - to have a
vendor-agnostic accessor in such common code paths and then abstract
away the differences in cpu/amd.c and cpu/intel.c, respectively and thus
keep the code sane.

How does that sound?

ENC_ being an ENCryption prefix, ofc.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
