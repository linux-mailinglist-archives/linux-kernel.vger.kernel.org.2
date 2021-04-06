Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9323F355938
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbhDFQb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbhDFQb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:31:58 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E05C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 09:31:50 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 184so17204180ljf.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CQbQjwiqS3Fuv2v9NiVnBs1PnLKQ/Au13bVVJ6VtmQo=;
        b=S3TRJImHGHqA+aZZz7eYep7NHTFldhl/LmiyN9Vq3a5NaPbz1vXmNm+vh7CutT0FDL
         lVaCdlQAd5AfS6mif41aB5q5YhFxAgNnjMJKLuqXntRIXxQfyLMfguAT1xlm+lR3qw3z
         KdhrJSq87QI8Qcv9Xgo3+Vi1EzcEbqeozb7S3ufHRBVHKBGHWGYd9VGQKyeadwXm2m9y
         QVG5FZbJfKX6G7M2NklrvoZpRd9bEB0nresuMd3RMAFD3sRKTOJfTKL1qH6oIr/OkO44
         7YbvK5ONNtxt1sftEg1dzdL3GxBzEjGgn0dtfX0NDTVCIQBrlwLuE84wvRDcncAZFFxT
         GiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CQbQjwiqS3Fuv2v9NiVnBs1PnLKQ/Au13bVVJ6VtmQo=;
        b=pOnXYWHuA5lj4y3oPb4obQy7/SkCETtuoA/AHJPbBN94tmONBKEapSt1oo0vA171Kl
         sDKkbdOCzhuU/OLqEd+DgdlC9wVPIOwYsD15ZvUM9pjezxi2SzM6DxI2mwAivcRwUUq9
         Usmy6FKBrdnJvG58BDTMZR4AcWgium4bWcsd3YqDcVi3e5VgISR+Z/PElZ3F4qbtglBg
         IDep8ERJGHbEDpap7dYaeK5F6Qbzm9aKpW2jpPoQZ1xBGApZ75THhl2eYWtI93jo3S6e
         0sqadEhtfMNqgbjKIs+AoWp6MX3eSEqJxZA5WPLWHMIEDqz1g2ZMFBhFTbew1h3OMfnQ
         1qYQ==
X-Gm-Message-State: AOAM5322HiXUjVeJQIYcpGI89GNtEvwI2VVcBuex0zNT0B7rQoAOgW4a
        yThzCbuB60RLTanM2NSxYU5I/w==
X-Google-Smtp-Source: ABdhPJyKMp+huh2Pra2iFW6/A5WMkhrYQuNMnzSpSecl1gnQlx2Hc+xSjIussANa3uARnGVPSy+iUg==
X-Received: by 2002:a2e:924e:: with SMTP id v14mr19966683ljg.362.1617726708491;
        Tue, 06 Apr 2021 09:31:48 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g10sm2250656lfe.90.2021.04.06.09.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 09:31:47 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id AACE8101FF7; Tue,  6 Apr 2021 19:31:50 +0300 (+03)
Date:   Tue, 6 Apr 2021 19:31:50 +0300
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
        linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [RFC v1 25/26] x86/tdx: Make DMA pages shared
Message-ID: <20210406163150.cbmcybnu6hu5alk7@box>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0bc9209a36760ee7c8591322327ddbfe87351b09.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <cc8e2e73-9d08-894c-47f9-ec82b0642789@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc8e2e73-9d08-894c-47f9-ec82b0642789@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 02:01:15PM -0700, Dave Hansen wrote:
> > +int tdx_map_gpa(phys_addr_t gpa, int numpages, bool private)
> > +{
> > +	int ret, i;
> > +
> > +	ret = __tdx_map_gpa(gpa, numpages, private);
> > +	if (ret || !private)
> > +		return ret;
> > +
> > +	for (i = 0; i < numpages; i++)
> > +		tdx_accept_page(gpa + i*PAGE_SIZE);
> > +
> > +	return 0;
> > +}
> 
> Please do something like this:
> 
> enum tdx_max_type {
> 	TDX_MAP_PRIVATE,
> 	TDX_MAP_SHARED
> }
> 
> Then, your calls will look like:
> 
> 	tdx_map_gpa(gpa, nr, TDX_MAP_SHARED);
> 
> instead of:
> 
> 	tdx_map_gpa(gpa, nr, false);

Okay, makes sense.

> >  static __cpuidle void tdx_halt(void)
> >  {
> >  	register long r10 asm("r10") = TDVMCALL_STANDARD;
> > diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
> > index 964e04152417..b6d93b0c5dcf 100644
> > --- a/arch/x86/mm/mem_encrypt_common.c
> > +++ b/arch/x86/mm/mem_encrypt_common.c
> > @@ -15,9 +15,9 @@
> >  bool force_dma_unencrypted(struct device *dev)
> >  {
> >  	/*
> > -	 * For SEV, all DMA must be to unencrypted/shared addresses.
> > +	 * For SEV and TDX, all DMA must be to unencrypted/shared addresses.
> >  	 */
> > -	if (sev_active())
> > +	if (sev_active() || is_tdx_guest())
> >  		return true;
> >  
> >  	/*
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index 16f878c26667..6f23a9816ef0 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -27,6 +27,7 @@
> >  #include <asm/proto.h>
> >  #include <asm/memtype.h>
> >  #include <asm/set_memory.h>
> > +#include <asm/tdx.h>
> >  
> >  #include "../mm_internal.h"
> >  
> > @@ -1977,8 +1978,8 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
> >  	struct cpa_data cpa;
> >  	int ret;
> >  
> > -	/* Nothing to do if memory encryption is not active */
> > -	if (!mem_encrypt_active())
> > +	/* Nothing to do if memory encryption and TDX are not active */
> > +	if (!mem_encrypt_active() && !is_tdx_guest())
> >  		return 0;
> 
> So, this is starting to look like the "enc" naming is wrong, or at least
> a little misleading.   Should we be talking about "protection" or
> "guards" or something?

Are you talking about the function argument or function name too?

> >  	/* Should not be working on unaligned addresses */
> > @@ -1988,8 +1989,14 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
> >  	memset(&cpa, 0, sizeof(cpa));
> >  	cpa.vaddr = &addr;
> >  	cpa.numpages = numpages;
> > -	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
> > -	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
> > +	if (is_tdx_guest()) {
> > +		cpa.mask_set = __pgprot(enc ? 0 : tdx_shared_mask());
> > +		cpa.mask_clr = __pgprot(enc ? tdx_shared_mask() : 0);
> > +	} else {
> > +		cpa.mask_set = __pgprot(enc ? _PAGE_ENC : 0);
> > +		cpa.mask_clr = __pgprot(enc ? 0 : _PAGE_ENC);
> > +	}
> 
> OK, this is too hideous to live.  It sucks that the TDX and SEV/SME bits
> are opposite polarity, but oh well.
> 
> To me, this gets a lot clearer, and opens up room for commenting if you
> do something like:
> 
> 	if (is_tdx_guest()) {
> 		mem_enc_bits   = 0;
> 		mem_plain_bits = tdx_shared_mask();
> 	} else {
> 		mem_enc_bits   = _PAGE_ENC;
> 		mem_plain_bits = 0
> 	}
> 
> 	if (enc) {
> 		cpa.mask_set = mem_enc_bits;
> 		cpa.mask_clr = mem_plain_bits;  // clear "plain" bits
> 	} else {
> 		
> 		cpa.mask_set = mem_plain_bits;
> 		cpa.mask_clr = mem_enc_bits;	// clear encryption bits
> 	}

I'm not convinced that your approach it clearer. If you add the missing
__pgprot() it going to as ugly as the original.

But if a maintainer wants... :)

> >  	cpa.pgd = init_mm.pgd;
> >  
> >  	/* Must avoid aliasing mappings in the highmem code */
> > @@ -1999,7 +2006,8 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
> >  	/*
> >  	 * Before changing the encryption attribute, we need to flush caches.
> >  	 */
> > -	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
> > +	if (!enc || !is_tdx_guest())
> > +		cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
> 
> That "!enc" looks wrong to me.  Caches would need to be flushed whenever
> encryption attributes *change*, not just when they are set.
> 
> Also, cpa_flush() flushes caches *AND* the TLB.  How does TDX manage to
> not need TLB flushes?

I will double-check everthing, but I think we can skip *both* cpa_flush()
for private->shared conversion. VMM and TDX module will take care about
TLB and cache flush in response to MapGPA TDVMCALL.

> >  	ret = __change_page_attr_set_clr(&cpa, 1);
> >  
> > @@ -2012,6 +2020,11 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
> >  	 */
> >  	cpa_flush(&cpa, 0);
> >  
> > +	if (!ret && is_tdx_guest()) {
> > +		ret = tdx_map_gpa(__pa(addr), numpages, enc);
> > +		// XXX: need to undo on error?
> > +	}
> 
> Time to fix this stuff up if you want folks to take this series more
> seriously.

My bad, will fix it.

-- 
 Kirill A. Shutemov
