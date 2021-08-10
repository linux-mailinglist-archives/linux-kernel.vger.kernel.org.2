Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F023E81BF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 20:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbhHJSB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 14:01:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:60639 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234066AbhHJR6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 13:58:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="195224011"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="195224011"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 10:50:36 -0700
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="503213388"
Received: from chdubay-mobl1.amr.corp.intel.com (HELO [10.212.234.193]) ([10.212.234.193])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 10:50:36 -0700
Subject: Re: [PATCH 2/5] efi/x86: Implement support for unaccepted memory
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
References: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
 <20210810062626.1012-3-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <142bccc6-0e67-dfc1-9069-b773c2bad585@intel.com>
Date:   Tue, 10 Aug 2021 10:50:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210810062626.1012-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
> +void mark_unaccepted(struct boot_params *params, u64 start, u64 num)
> +{

Some of these interfaces like accept_memory() take a start/end physical
address.  Having this take a "num pages" is bound to cause confusion.
Could you make these all consistently take start/end physical addresses?

> +	u64 end = start + num * PAGE_SIZE;
> +	unsigned int npages;


Could you comment those, please?

	/*
	 * The accepted memory bitmap only works at PMD_SIZE
	 * granularity.  If a request comes in to mark memory
	 * as unaccepted which is not PMD_SIZE-aligned, simply
	 * accept the memory now since it can not be *marked* as
	 * unaccepted.
	 */

Then go on to comment the three cases:

	/* Check for ranges which do not span a whole PMD_SIZE area: */

> +	if ((start & PMD_MASK) == (end & PMD_MASK)) {
> +		npages = (end - start) / PAGE_SIZE;
> +		__accept_memory(start, start + npages * PAGE_SIZE);
> +		return;
> +	}

Hmm, is it possible to have this case hit, but neither of the two below
cases?  This seems to be looking for a case where the range is somehow
entirely contained in one PMD_SIZE area, but where it doesn't consume a
whole area.

Wouldn't that mean that 'start' or 'end' must be unaligned?


> +	if (start & ~PMD_MASK) {
> +		npages = (round_up(start, PMD_SIZE) - start) / PAGE_SIZE;
> +		__accept_memory(start, start + npages * PAGE_SIZE);
> +		start = round_up(start, PMD_SIZE);
> +	}
> +
> +	if (end & ~PMD_MASK) {
> +		npages = (end - round_down(end, PMD_SIZE)) / PAGE_SIZE;
> +		end = round_down(end, PMD_SIZE);
> +		__accept_memory(end, end + npages * PAGE_SIZE);
> +	}
> +	npages = (end - start) / PMD_SIZE;
> +	bitmap_set((unsigned long *)params->unaccepted_memory,
> +		   start / PMD_SIZE, npages);
> +}

Even though it's changed right there, it's a bit cruel to change the
units of 'npages' right in the middle of a function.  It's just asking
for bugs.

It would only take a single extra variable declaration to make this
unambiguous:

	u64 nr_unaccepted_bits;

or something, then you can do:

	nr_unaccepted_bits = (end - start) / PMD_SIZE;
	bitmap_set((unsigned long *)params->unaccepted_memory,
		   start / PMD_SIZE, nr_unaccepted_bits);

...
>  static efi_status_t allocate_e820(struct boot_params *params,
> +				  struct efi_boot_memmap *map,
>  				  struct setup_data **e820ext,
>  				  u32 *e820ext_size)
>  {
> -	unsigned long map_size, desc_size, map_key;
>  	efi_status_t status;
> -	__u32 nr_desc, desc_version;
> -
> -	/* Only need the size of the mem map and size of each mem descriptor */
> -	map_size = 0;
> -	status = efi_bs_call(get_memory_map, &map_size, NULL, &map_key,
> -			     &desc_size, &desc_version);
> -	if (status != EFI_BUFFER_TOO_SMALL)
> -		return (status != EFI_SUCCESS) ? status : EFI_UNSUPPORTED;

I noticed that there's no reference to EFI_BUFFER_TOO_SMALL in the hunks
you added back.  That makes me a bit nervous that this is going to
unintentionally change behavior.

It might be worth having a preparatory reorganization patch for
allocate_e820() before this new feature is added to make this more clear.

> +	__u32 nr_desc;
> +	bool unaccepted_memory_present = false;
> +	u64 max_addr = 0;
> +	int i;
>  
> -	nr_desc = map_size / desc_size + EFI_MMAP_NR_SLACK_SLOTS;
> +	status = efi_get_memory_map(map);
> +	if (status != EFI_SUCCESS)
> +		return status;
>  
> -	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
> -		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
> +	nr_desc = *map->map_size / *map->desc_size;
> +	if (nr_desc > ARRAY_SIZE(params->e820_table) - EFI_MMAP_NR_SLACK_SLOTS) {
> +		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table) -
> +			EFI_MMAP_NR_SLACK_SLOTS;
>  
>  		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
>  		if (status != EFI_SUCCESS)
>  			return status;
>  	}
>  
> +	if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
> +		return EFI_SUCCESS;
> +
> +	/* Check if there's any unaccepted memory and find the max address */
> +	for (i = 0; i < nr_desc; i++) {
> +		efi_memory_desc_t *d;
> +
> +		d = efi_early_memdesc_ptr(*map->map, *map->desc_size, i);
> +		if (d->type == EFI_UNACCEPTED_MEMORY)
> +			unaccepted_memory_present = true;
> +		if (d->phys_addr + d->num_pages * PAGE_SIZE > max_addr)
> +			max_addr = d->phys_addr + d->num_pages * PAGE_SIZE;
> +	}

This 'max_addr' variable looks a bit funky.

It *seems* like it's related only to EFI_UNACCEPTED_MEMORY, but it's not
underneath the EFI_UNACCEPTED_MEMORY check.  Is this somehow assuming
that once unaccepted memory as been found that *all* memory found in
later descriptors at higher addresses is also going to be unaccepted?

> +	/*
> +	 * If unaccepted memory present allocate a bitmap to track what memory
> +	 * has to be accepted before access.
> +	 *
> +	 * One bit in the bitmap represents 2MiB in the address space: one 4k
> +	 * page is enough to track 64GiB or physical address space.
> +	 *
> +	 * In the worst case scenario -- a huge hole in the middle of the
> +	 * address space -- we would need 256MiB to handle 4PiB of the address
> +	 * space.
> +	 *
> +	 * TODO: handle situation if params->unaccepted_memory has already set.
> +	 * It's required to deal with kexec.
> +	 */
> +	if (unaccepted_memory_present) {
> +		unsigned long *unaccepted_memory = NULL;
> +		u64 size = DIV_ROUND_UP(max_addr, PMD_SIZE * BITS_PER_BYTE);

Oh, so the bitmap has to be present for *all* memory, not just
unaccepted memory.  So, we really do need to know the 'max_addr' so that
we can allocate the bitmap for so that can be marked in the bitmap has
having been accepted.

> +		status = efi_allocate_pages(size,
> +					    (unsigned long *)&unaccepted_memory,
> +					    ULONG_MAX);
> +		if (status != EFI_SUCCESS)
> +			return status;
> +		memset(unaccepted_memory, 0, size);
> +		params->unaccepted_memory = (u64)unaccepted_memory;
> +	}

It might be nice to refer to setup_e820() here to mention that it is the
thing that actually fills out the bitmap.
