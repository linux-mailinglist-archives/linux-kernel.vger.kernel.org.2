Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E511838CDC4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhEUSvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:51:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41900 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231494AbhEUSvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:51:23 -0400
Received: from zn.tnic (p200300ec2f0ea400fbcd5718c7a034c2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a400:fbcd:5718:c7a0:34c2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BEBD81EC06F0;
        Fri, 21 May 2021 20:49:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621622998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3LJAZhxKWmjimDmIEpS1OanKuj4fPuQC6Ji2my1ffes=;
        b=LhfojBS1PUhodfjrWgeTAsonPiAiCqCd5Qw+d14N+N+2WZLh9Y31jKKS0w2FYp/RjaIfbz
        rcoKwns8hndz4ox1V1miUKrT+cJtA1H6A9J59ERyre1a2ABx2qzoS6JsBCQhC14gGfazQV
        ET0gfdk8nnGDaIpBMXAP3jjtV4hwOkI=
Date:   Fri, 21 May 2021 20:49:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
Message-ID: <YKgA1od/SqycWWds@zn.tnic>
References: <eaaa692ce1ed897f66f864bbfa2df8683768d79e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <b884067a-19d6-105f-9f8c-28feb3b43446@intel.com>
 <312879fb-d201-a16d-2568-150152044c54@linux.intel.com>
 <797c95bf-9516-8aee-59d0-f5259d77bb75@linux.intel.com>
 <5b4b4fc0-aaa8-3407-6602-537d59572bc1@intel.com>
 <YJm5QY8omAvdpBO9@google.com>
 <YJpP/S8MajKNhBl4@zn.tnic>
 <0e233779-9c10-11df-b527-ef61e003ea35@linux.intel.com>
 <YKfPLlulaqwypNkO@zn.tnic>
 <f5e64c61-7f3c-3936-1b8e-7874ec81d83e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5e64c61-7f3c-3936-1b8e-7874ec81d83e@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 11:19:15AM -0500, Tom Lendacky wrote:
> In arch/x86/mm/mem_encrypt.c, sme_early_init() (should have renamed that
> when SEV support was added), we do:
> 	if (sev_active())
> 		swiotlb_force = SWIOTLB_FORCE;
> 
> TDX should be able to do a similar thing without having to touch
> arch/x86/kernel/pci-swiotlb.c.
> 
> That would remove any confusion over SME being part of a
> protected_guest_has() call.

Even better.

> I kinda like the separate function, though.

Only if you clean it up and get rid of the inverted logic and drop that
silly switch-case.

> Except mem_encrypt_active() covers both SME and SEV, so
> protected_guest_has() would be confusing.

I don't understand - the AMD-specific function amd_protected_guest_has()
would return sme_me_mask just like mem_encrypt_active() does and we can
get rid of latter.

Or do you have a problem with the name protected_guest_has() containing
"guest" while we're talking about SME here?

If so, feel free to suggest a better one - the name does not have to
have "guest" in it.

Thx.


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
