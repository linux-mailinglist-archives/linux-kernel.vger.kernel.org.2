Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C8532A966
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580868AbhCBSVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:21:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1578832AbhCBP10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:27:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D0A664EFC;
        Tue,  2 Mar 2021 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614698288;
        bh=8soWKlSoVNnPoAkd1PBkbCRz19PnjYruzmRd9uawI4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cAql3LROA80o+6BbuPrq0OpDbb1VtcJlTGtODpnzz0LSiYJm2ImPp337OWZFMSopa
         sdj9bFtFwiwxGbAhKvOMf94lUIJ5EXexwluSfcydDbRGg8w0fOIhWLRMgPr2c3adoq
         xYaWlamsJ9SILroE1anTVnZC7nHe4gtdM4DFUTFCiMXiMghQW1dwHEZh6fndRbTl0/
         y7Rd3uyoINbXLGF0n3ZVKgaooEprCmZh9OmB3kx9n7V4uzUr2RLXu+qQirofHNegJc
         J/jnYSbComqBoqnJQu1HwKic82qv2aSpMfw+ZqgRVNvqQbdMG45tAmfgMFwlGNtFyk
         T88+cpI42tGGQ==
Date:   Tue, 2 Mar 2021 17:17:58 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3 1/2] x86/setup: consolidate early memory reservations
Message-ID: <YD5XJrtJDgdmMt42@kernel.org>
References: <20210302100406.22059-1-rppt@kernel.org>
 <20210302100406.22059-2-rppt@kernel.org>
 <20210302130409.GA2962@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302130409.GA2962@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 09:04:09PM +0800, Baoquan He wrote:
> On 03/02/21 at 12:04pm, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The early reservations of memory areas used by the firmware, bootloader,
> > kernel text and data are spread over setup_arch(). Moreover, some of them
> > happen *after* memblock allocations, e.g trim_platform_memory_ranges() and
> > trim_low_memory_range() are called after reserve_real_mode() that allocates
> > memory.
> > 
> > There was no corruption of these memory regions because memblock always
> > allocates memory either from the end of memory (in top-down mode) or above
> > the kernel image (in bottom-up mode). However, the bottom up mode is going
> > to be updated to span the entire memory [1] to avoid limitations caused by
> > KASLR.
> > 
> > Consolidate early memory reservations in a dedicated function to improve
> > robustness against future changes. Having the early reservations in one
> > place also makes it clearer what memory must be reserved before we allow
> > memblock allocations.
> > 
> > [1] https://lore.kernel.org/lkml/20201217201214.3414100-2-guro@fb.com
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Acked-by: Borislav Petkov <bp@suse.de>
> > ---
> >  arch/x86/kernel/setup.c | 92 ++++++++++++++++++++---------------------
> >  1 file changed, 44 insertions(+), 48 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index d883176ef2ce..3e3c6036b023 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -645,18 +645,6 @@ static void __init trim_snb_memory(void)
> >  	}
> >  }
> >  
> > -/*
> > - * Here we put platform-specific memory range workarounds, i.e.
> > - * memory known to be corrupt or otherwise in need to be reserved on
> > - * specific platforms.
> > - *
> > - * If this gets used more widely it could use a real dispatch mechanism.
> > - */
> > -static void __init trim_platform_memory_ranges(void)
> > -{
> > -	trim_snb_memory();
> > -}
> > -
> >  static void __init trim_bios_range(void)
> >  {
> >  	/*
> > @@ -729,7 +717,38 @@ static void __init trim_low_memory_range(void)
> >  {
> >  	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
> >  }
> > -	
> > +
> > +static void __init early_reserve_memory(void)
> > +{
> > +	/*
> > +	 * Reserve the memory occupied by the kernel between _text and
> > +	 * __end_of_kernel_reserve symbols. Any kernel sections after the
> > +	 * __end_of_kernel_reserve symbol must be explicitly reserved with a
> > +	 * separate memblock_reserve() or they will be discarded.
> > +	 */
> > +	memblock_reserve(__pa_symbol(_text),
> > +			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
> > +
> > +	/*
> > +	 * Make sure page 0 is always reserved because on systems with
> > +	 * L1TF its contents can be leaked to user processes.
> > +	 */
> > +	memblock_reserve(0, PAGE_SIZE);
> > +
> > +	early_reserve_initrd();
> > +
> > +	if (efi_enabled(EFI_BOOT))
> > +		efi_memblock_x86_reserve_range();
> > +
> > +	memblock_x86_reserve_range_setup_data();
> 
> This patch looks good to me, thanks for the effort.
> 
> While at it, wondering if we can rename the above function to
> memblock_reserve_setup_data() just as its e820 counterpart
> e820__reserve_setup_data(), adding 'x86' to a function under arch/x86
> seems redundant.

I'd rather keep these names for now. First, it's easier to dig to them in the git
history and second, I'm planning more changes in this area and these names
are as good as FIXME: to remind what still needs to be checked :)
 
> FWIW,
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>

Thanks!
 
> Thanks
> Baoquan
> 
> > +
> > +	reserve_ibft_region();
> > +	reserve_bios_regions();
> > +
> > +	trim_snb_memory();
> > +	trim_low_memory_range();
> > +}
> > +
> >  /*
> >   * Dump out kernel offset information on panic.
> >   */
> > @@ -764,29 +783,6 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
> >  
> >  void __init setup_arch(char **cmdline_p)
> >  {
> > -	/*
> > -	 * Reserve the memory occupied by the kernel between _text and
> > -	 * __end_of_kernel_reserve symbols. Any kernel sections after the
> > -	 * __end_of_kernel_reserve symbol must be explicitly reserved with a
> > -	 * separate memblock_reserve() or they will be discarded.
> > -	 */
> > -	memblock_reserve(__pa_symbol(_text),
> > -			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
> > -
> > -	/*
> > -	 * Make sure page 0 is always reserved because on systems with
> > -	 * L1TF its contents can be leaked to user processes.
> > -	 */
> > -	memblock_reserve(0, PAGE_SIZE);
> > -
> > -	early_reserve_initrd();
> > -
> > -	/*
> > -	 * At this point everything still needed from the boot loader
> > -	 * or BIOS or kernel text should be early reserved or marked not
> > -	 * RAM in e820. All other memory is free game.
> > -	 */
> > -
> >  #ifdef CONFIG_X86_32
> >  	memcpy(&boot_cpu_data, &new_cpu_data, sizeof(new_cpu_data));
> >  
> > @@ -910,8 +906,18 @@ void __init setup_arch(char **cmdline_p)
> >  
> >  	parse_early_param();
> >  
> > -	if (efi_enabled(EFI_BOOT))
> > -		efi_memblock_x86_reserve_range();
> > +	/*
> > +	 * Do some memory reservations *before* memory is added to
> > +	 * memblock, so memblock allocations won't overwrite it.
> > +	 * Do it after early param, so we could get (unlikely) panic from
> > +	 * serial.
> > +	 *
> > +	 * After this point everything still needed from the boot loader or
> > +	 * firmware or kernel text should be early reserved or marked not
> > +	 * RAM in e820. All other memory is free game.
> > +	 */
> > +	early_reserve_memory();
> > +
> >  #ifdef CONFIG_MEMORY_HOTPLUG
> >  	/*
> >  	 * Memory used by the kernel cannot be hot-removed because Linux
> > @@ -938,9 +944,6 @@ void __init setup_arch(char **cmdline_p)
> >  
> >  	x86_report_nx();
> >  
> > -	/* after early param, so could get panic from serial */
> > -	memblock_x86_reserve_range_setup_data();
> > -
> >  	if (acpi_mps_check()) {
> >  #ifdef CONFIG_X86_LOCAL_APIC
> >  		disable_apic = 1;
> > @@ -1032,8 +1035,6 @@ void __init setup_arch(char **cmdline_p)
> >  	 */
> >  	find_smp_config();
> >  
> > -	reserve_ibft_region();
> > -
> >  	early_alloc_pgt_buf();
> >  
> >  	/*
> > @@ -1054,8 +1055,6 @@ void __init setup_arch(char **cmdline_p)
> >  	 */
> >  	sev_setup_arch();
> >  
> > -	reserve_bios_regions();
> > -
> >  	efi_fake_memmap();
> >  	efi_find_mirror();
> >  	efi_esrt_init();
> > @@ -1081,9 +1080,6 @@ void __init setup_arch(char **cmdline_p)
> >  
> >  	reserve_real_mode();
> >  
> > -	trim_platform_memory_ranges();
> > -	trim_low_memory_range();
> > -
> >  	init_mem_mapping();
> >  
> >  	idt_setup_early_pf();
> > -- 
> > 2.28.0
> > 
> 

-- 
Sincerely yours,
Mike.
