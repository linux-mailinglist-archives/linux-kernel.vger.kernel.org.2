Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B9E3EAC4A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 23:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhHLVPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 17:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhHLVPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:15:04 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A280C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 14:14:38 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d4so15883960lfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 14:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O9Ui4Q6PbF0T/rKVbRolnp389K3oQYeJwugtlRVK+Bo=;
        b=nt7t6noInmS46fO73mQssKdC9yvBRGkXwZCI0IBinN70xxUtKdg7mZT6iZmKZWQQmq
         EL1PYad5hI1ZbyEBEWTfZdmrWe/N5mQ4U3zNUL4lfDFG1bVGVg2MsK31R4mZJzCrczMN
         Mk+dfziQ1XP8urPfCtCmbdrQyXqDNzdXR+CmKp2JshpW92JEtRU9AO0NiA9uyCGuQe4L
         uZpC1EeRbCURCLiHHRDc40Y8mrlfJ3vz/+LG6YalsIN0TFaDWib7qVaL9+ZB45PcyB35
         /LO0Cdy5YA6xyLSNYTTMle5uJtufletrPU3xEr5wJnRRwAdBCDw8OA02yiK+m5Hfq5K4
         maOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O9Ui4Q6PbF0T/rKVbRolnp389K3oQYeJwugtlRVK+Bo=;
        b=sdONGqNoR2alNaEp2ATlGnL56um2ZWYfsZj2rJ887jogUzMfN0nSPHvuWBu7U/RO60
         FZN/EDkaEAjLrU8T8FsK9xvHbU0675N6bf0dhNW3g81YEod4+0PD+57px1KsfpxLmWwG
         QmoQUHIH7Vp2g695owVNmzOTRU20DLblI2S5gNkGwWzripq5DtydypjvcUmZhh9dsFVX
         0MrAYFXZN09xpDC/Pu0f3oujCz5CcSkQTgSY1xAedxsmVEazWk8cdTB52Y49n+CAUlDr
         CBmpPh8Q2nZlBC7Ef+jWWKN47GWMlqX5FOffk/PTskPUEsD3bWvpAR/BD9ckSGiv3RXY
         TP5A==
X-Gm-Message-State: AOAM532gEPzU3GmYx1n+31/VCRFNIK4aGVpG7r0vPbuBZXBncmvfn4EZ
        ao5bovjMA5jhoRJjvfKkz6Vggg==
X-Google-Smtp-Source: ABdhPJxCnDou6x8BHSKfwHgrInMCW0EOGw+eNpa6BoJHZhlZVjwD62MZzkIh4Yo37zkF5U4ACBw85Q==
X-Received: by 2002:ac2:5fcf:: with SMTP id q15mr3904047lfg.597.1628802876962;
        Thu, 12 Aug 2021 14:14:36 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f16sm371871lfv.115.2021.08.12.14.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 14:14:36 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E31FB102BEE; Fri, 13 Aug 2021 00:14:49 +0300 (+03)
Date:   Fri, 13 Aug 2021 00:14:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 2/5] efi/x86: Implement support for unaccepted memory
Message-ID: <20210812211449.5bsblj6lphtu7zsd@box.shutemov.name>
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
 <20210810062626.1012-3-kirill.shutemov@linux.intel.com>
 <142bccc6-0e67-dfc1-9069-b773c2bad585@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <142bccc6-0e67-dfc1-9069-b773c2bad585@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 10:50:33AM -0700, Dave Hansen wrote:
> ...
> > +void mark_unaccepted(struct boot_params *params, u64 start, u64 num)
> > +{
> 
> Some of these interfaces like accept_memory() take a start/end physical
> address.  Having this take a "num pages" is bound to cause confusion.
> Could you make these all consistently take start/end physical addresses?

Okay.

> 
> > +	u64 end = start + num * PAGE_SIZE;
> > +	unsigned int npages;
> 
> 
> Could you comment those, please?
> 
> 	/*
> 	 * The accepted memory bitmap only works at PMD_SIZE
> 	 * granularity.  If a request comes in to mark memory
> 	 * as unaccepted which is not PMD_SIZE-aligned, simply
> 	 * accept the memory now since it can not be *marked* as
> 	 * unaccepted.
> 	 */
> 
> Then go on to comment the three cases:
> 
> 	/* Check for ranges which do not span a whole PMD_SIZE area: */

Okay.

> > +	if ((start & PMD_MASK) == (end & PMD_MASK)) {
> > +		npages = (end - start) / PAGE_SIZE;
> > +		__accept_memory(start, start + npages * PAGE_SIZE);
> > +		return;
> > +	}
> 
> Hmm, is it possible to have this case hit, but neither of the two below
> cases?  This seems to be looking for a case where the range is somehow
> entirely contained in one PMD_SIZE area, but where it doesn't consume a
> whole area.
> 
> Wouldn't that mean that 'start' or 'end' must be unaligned?

The problem is that if both of them unaligned round_up() and round_down()
in the cases below would step outside the requested range.

> > +	if (start & ~PMD_MASK) {
> > +		npages = (round_up(start, PMD_SIZE) - start) / PAGE_SIZE;
> > +		__accept_memory(start, start + npages * PAGE_SIZE);
> > +		start = round_up(start, PMD_SIZE);
> > +	}
> > +
> > +	if (end & ~PMD_MASK) {
> > +		npages = (end - round_down(end, PMD_SIZE)) / PAGE_SIZE;
> > +		end = round_down(end, PMD_SIZE);
> > +		__accept_memory(end, end + npages * PAGE_SIZE);
> > +	}
> > +	npages = (end - start) / PMD_SIZE;
> > +	bitmap_set((unsigned long *)params->unaccepted_memory,
> > +		   start / PMD_SIZE, npages);
> > +}
> 
> Even though it's changed right there, it's a bit cruel to change the
> units of 'npages' right in the middle of a function.  It's just asking
> for bugs.
> 
> It would only take a single extra variable declaration to make this
> unambiguous:
> 
> 	u64 nr_unaccepted_bits;
> 
> or something, then you can do:
> 
> 	nr_unaccepted_bits = (end - start) / PMD_SIZE;
> 	bitmap_set((unsigned long *)params->unaccepted_memory,
> 		   start / PMD_SIZE, nr_unaccepted_bits);

Okay.

> 
> ...
> >  static efi_status_t allocate_e820(struct boot_params *params,
> > +				  struct efi_boot_memmap *map,
> >  				  struct setup_data **e820ext,
> >  				  u32 *e820ext_size)
> >  {
> > -	unsigned long map_size, desc_size, map_key;
> >  	efi_status_t status;
> > -	__u32 nr_desc, desc_version;
> > -
> > -	/* Only need the size of the mem map and size of each mem descriptor */
> > -	map_size = 0;
> > -	status = efi_bs_call(get_memory_map, &map_size, NULL, &map_key,
> > -			     &desc_size, &desc_version);
> > -	if (status != EFI_BUFFER_TOO_SMALL)
> > -		return (status != EFI_SUCCESS) ? status : EFI_UNSUPPORTED;
> 
> I noticed that there's no reference to EFI_BUFFER_TOO_SMALL in the hunks
> you added back.  That makes me a bit nervous that this is going to
> unintentionally change behavior.
> 
> It might be worth having a preparatory reorganization patch for
> allocate_e820() before this new feature is added to make this more clear.

Okay. Will do.
> 
> > +	__u32 nr_desc;
> > +	bool unaccepted_memory_present = false;
> > +	u64 max_addr = 0;
> > +	int i;
> >  
> > -	nr_desc = map_size / desc_size + EFI_MMAP_NR_SLACK_SLOTS;
> > +	status = efi_get_memory_map(map);
> > +	if (status != EFI_SUCCESS)
> > +		return status;
> >  
> > -	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
> > -		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
> > +	nr_desc = *map->map_size / *map->desc_size;
> > +	if (nr_desc > ARRAY_SIZE(params->e820_table) - EFI_MMAP_NR_SLACK_SLOTS) {
> > +		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table) -
> > +			EFI_MMAP_NR_SLACK_SLOTS;
> >  
> >  		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
> >  		if (status != EFI_SUCCESS)
> >  			return status;
> >  	}
> >  
> > +	if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
> > +		return EFI_SUCCESS;
> > +
> > +	/* Check if there's any unaccepted memory and find the max address */
> > +	for (i = 0; i < nr_desc; i++) {
> > +		efi_memory_desc_t *d;
> > +
> > +		d = efi_early_memdesc_ptr(*map->map, *map->desc_size, i);
> > +		if (d->type == EFI_UNACCEPTED_MEMORY)
> > +			unaccepted_memory_present = true;
> > +		if (d->phys_addr + d->num_pages * PAGE_SIZE > max_addr)
> > +			max_addr = d->phys_addr + d->num_pages * PAGE_SIZE;
> > +	}
> 
> This 'max_addr' variable looks a bit funky.
> 
> It *seems* like it's related only to EFI_UNACCEPTED_MEMORY, but it's not
> underneath the EFI_UNACCEPTED_MEMORY check.  Is this somehow assuming
> that once unaccepted memory as been found that *all* memory found in
> later descriptors at higher addresses is also going to be unaccepted?

You got it right below :P

> > +	/*
> > +	 * If unaccepted memory present allocate a bitmap to track what memory
> > +	 * has to be accepted before access.
> > +	 *
> > +	 * One bit in the bitmap represents 2MiB in the address space: one 4k
> > +	 * page is enough to track 64GiB or physical address space.
> > +	 *
> > +	 * In the worst case scenario -- a huge hole in the middle of the
> > +	 * address space -- we would need 256MiB to handle 4PiB of the address
> > +	 * space.
> > +	 *
> > +	 * TODO: handle situation if params->unaccepted_memory has already set.
> > +	 * It's required to deal with kexec.
> > +	 */
> > +	if (unaccepted_memory_present) {
> > +		unsigned long *unaccepted_memory = NULL;
> > +		u64 size = DIV_ROUND_UP(max_addr, PMD_SIZE * BITS_PER_BYTE);
> 
> Oh, so the bitmap has to be present for *all* memory, not just
> unaccepted memory.  So, we really do need to know the 'max_addr' so that
> we can allocate the bitmap for so that can be marked in the bitmap has
> having been accepted.

Right we need a bit for every 2M. Accepted or not.

> > +		status = efi_allocate_pages(size,
> > +					    (unsigned long *)&unaccepted_memory,
> > +					    ULONG_MAX);
> > +		if (status != EFI_SUCCESS)
> > +			return status;
> > +		memset(unaccepted_memory, 0, size);
> > +		params->unaccepted_memory = (u64)unaccepted_memory;
> > +	}
> 
> It might be nice to refer to setup_e820() here to mention that it is the
> thing that actually fills out the bitmap.

Okay.

-- 
 Kirill A. Shutemov
