Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA235583D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345916AbhDFPid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345886AbhDFPiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:38:02 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968C9C061761
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:37:54 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u4so17005324ljo.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B6AsOasHJ/8olkeybToj+AE1MYUVBlnM2zm/hIEcHPg=;
        b=WgdqPBQQQxu2opddc9N2eoSga4ozGBsYmPRzBv+e9KfJyhdWdNnHcc8rOlhbN5ZVen
         Bjv32lELnztqXLa+qeJA1FLDVRnM2Jh1p08o8YU8cfwc0r1S3MGf8jjF50zVnNr1M2MG
         dYVD3/EFuq+hFuyZ6EafpeO6s/1m6hgI5rShr3Wl0tftcrqIS0X8IS+r5Omcy5iYlOqW
         VgliObQ3v+JaiElzvUV8TS43lUE//YEbBU66FVRPH73XV1nmogfnxUM+dt33XZaVVzGJ
         4oqjKw3khy4pmY7s5GwbryxBxrQnFLzjZLAW5ao2/fwNeobQymQFKEJ0eLxIHL4Xycm6
         9b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B6AsOasHJ/8olkeybToj+AE1MYUVBlnM2zm/hIEcHPg=;
        b=oEVLOtyY298fFLI8tqd2fq4c0VM6YS5Y14TPOpOs4iL+xvNhS05nr81/Vf5TCCnzHv
         Sqn2shEJjmbUYU1Vk7FwEC92+G8VfaBw5VQ3pcIhgPLWfwBmKmrs9xzM2cDNDkDn0U80
         dOZyBVReOJwheDcb3raJ4xy3tMW5OdPuTk/R0m5OUMYh+DHQiiQfI8iWHekR9CYK50FY
         R5z0KtiUj97OUo61UCFgtBxZ9D8tfCHDJYB5nDt7rh4EM4ez2A6CRFo1JyiJq2BzpVqb
         faN4iQKT6Ur5fhhhYJZ/+5DaeWkTeusJf8YnuCgw44dJ+YAFnxg5ssBlRSwEU8YqAEZ9
         ZGkg==
X-Gm-Message-State: AOAM533jFp9lS6QyE4wIKDfQG1dzNmIK9IoAHTv06lJL+QIaMSMj+cyL
        cMScwJi4mivFFRSV7FzcRpugAQ==
X-Google-Smtp-Source: ABdhPJwatTbznV/bDAm+LlG6HNKt8oylfNKY8GznZTbUcruwp5L7zKtXzit3oaPvOAGHdoftEEdrkQ==
X-Received: by 2002:a05:651c:211a:: with SMTP id a26mr19181870ljq.373.1617723473093;
        Tue, 06 Apr 2021 08:37:53 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u3sm2193843lfu.24.2021.04.06.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 08:37:52 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3BCD2101FF7; Tue,  6 Apr 2021 18:37:55 +0300 (+03)
Date:   Tue, 6 Apr 2021 18:37:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 21/26] x86/mm: Move force_dma_unencrypted() to common
 code
Message-ID: <20210406153755.evphkyms3bwo7scc@box>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <444fe9c7c035417f6abc3e0be2a4861cb573ab28.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d4eb7452-f6dd-2e0e-a790-76abdbbbfee9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4eb7452-f6dd-2e0e-a790-76abdbbbfee9@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 01:06:29PM -0700, Dave Hansen wrote:
> On 2/5/21 3:38 PM, Kuppuswamy Sathyanarayanan wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > Intel TDX doesn't allow VMM to access guest memory. Any memory that is
> > required for communication with VMM suppose to be shared explicitly by
> 
> s/suppose to/must/

Right.

> > setting the bit in page table entry. The shared memory is similar to
> > unencrypted memory in AMD SME/SEV terminology.
> 
> In addition to setting the page table bit, there's also a dance to go
> through to convert the memory.  Please mention the procedure here at
> least.  It's very different from SME.

"
  After setting the shared bit, the conversion must be completed with
  MapGPA TDVMALL. The call informs VMM about the conversion and makes it
  remove the GPA from the S-EPT mapping.
"

> > force_dma_unencrypted() has to return true for TDX guest. Move it out of
> > AMD SME code.
> 
> You lost me here.  What does force_dma_unencrypted() have to do with
> host/guest shared memory?

"
  AMD SEV makes force_dma_unencrypted() return true which triggers
  set_memory_decrypted() calls on all DMA allocations. TDX will use the
  same code path to make DMA allocations shared.
"

> > Introduce new config option X86_MEM_ENCRYPT_COMMON that has to be
> > selected by all x86 memory encryption features.
> 
> Please also mention what will set it.  I assume TDX guest support will
> set this option.  It's probably also worth a sentence to say that
> force_dma_unencrypted() will have TDX-specific code added to it.  (It
> will, right??)

"
  Only AMD_MEM_ENCRYPT uses the option now. TDX will be the second one.
"

> > This is preparation for TDX changes in DMA code.
> 
> Probably best to also mention that this effectively just moves code
> around.  This patch should have no functional changes at runtime.

Isn't it what the subject says? :P

> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 0374d9f262a5..8fa654d61ac2 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1538,14 +1538,18 @@ config X86_CPA_STATISTICS
> >  	  helps to determine the effectiveness of preserving large and huge
> >  	  page mappings when mapping protections are changed.
> >  
> > +config X86_MEM_ENCRYPT_COMMON
> > +	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
> > +	select DYNAMIC_PHYSICAL_MASK
> > +	def_bool n
> > +
> >  config AMD_MEM_ENCRYPT
> >  	bool "AMD Secure Memory Encryption (SME) support"
> >  	depends on X86_64 && CPU_SUP_AMD
> >  	select DMA_COHERENT_POOL
> > -	select DYNAMIC_PHYSICAL_MASK
> >  	select ARCH_USE_MEMREMAP_PROT
> > -	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
> >  	select INSTRUCTION_DECODER
> > +	select X86_MEM_ENCRYPT_COMMON
> >  	help
> >  	  Say yes to enable support for the encryption of system memory.
> >  	  This requires an AMD processor that supports Secure Memory
> > diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> > index 30a3b30395ad..95e534cffa99 100644
> > --- a/arch/x86/include/asm/io.h
> > +++ b/arch/x86/include/asm/io.h
> > @@ -257,10 +257,12 @@ static inline void slow_down_io(void)
> >  
> >  #endif
> >  
> > -#ifdef CONFIG_AMD_MEM_ENCRYPT
> >  #include <linux/jump_label.h>
> >  
> >  extern struct static_key_false sev_enable_key;
> 
> This _looks_ odd.  sev_enable_key went from being under
> CONFIG_AMD_MEM_ENCRYPT to being unconditionally referenced.

Not referenced, but declared.

> Could you explain a bit more?
> 
> I would have expected it tot at *least* be tied to the new #ifdef.

Looks like a fixup got folded into a wrong patch. It supposed to be in
"x86/kvm: Use bounce buffers for TD guest".

This declaration allows to get away without any #ifdefs in
mem_encrypt_init() when !CONFIG_AMD_MEM_ENCRYPT: sev_active() is
false at compile-time and sev_enable_key never referenced.

Sathya, could move it to the right patch?

> > +#ifdef CONFIG_AMD_MEM_ENCRYPT
> > +
> >  static inline bool sev_key_active(void)
> >  {
> >  	return static_branch_unlikely(&sev_enable_key);
> > diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> > index 5864219221ca..b31cb52bf1bd 100644
> > --- a/arch/x86/mm/Makefile
> ...

-- 
 Kirill A. Shutemov
