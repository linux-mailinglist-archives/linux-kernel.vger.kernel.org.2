Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2B632A6E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836889AbhCBPy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:54:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39433 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1447467AbhCBNaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614691719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q3lcceJNMuhGV5gOmnXWRxilJICm39vdcV7GSA5hqqM=;
        b=Z9WPlybCjIkKKhwkpqjGXME2cxfZjG/qzUdHfNLkssq8Zkt22TVVbuauNpE+Zsttm54I6/
        BAqaTiojGt8xANXWEGv8PSTBeQ9LowlyaPOQuXEyBIZWN9PGSd4f2Onax0b+Qy9KWg6Z1Z
        WFTTn5w3x9wqhTAFTu5w3QqoM4IBBwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-yCJ1Q7l7Pfy3sCOqMUzYCg-1; Tue, 02 Mar 2021 08:04:18 -0500
X-MC-Unique: yCJ1Q7l7Pfy3sCOqMUzYCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5637B85EE62;
        Tue,  2 Mar 2021 13:04:16 +0000 (UTC)
Received: from localhost (ovpn-12-141.pek2.redhat.com [10.72.12.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD4CF5C1C2;
        Tue,  2 Mar 2021 13:04:11 +0000 (UTC)
Date:   Tue, 2 Mar 2021 21:04:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <20210302130409.GA2962@MiWiFi-R3L-srv>
References: <20210302100406.22059-1-rppt@kernel.org>
 <20210302100406.22059-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302100406.22059-2-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 at 12:04pm, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The early reservations of memory areas used by the firmware, bootloader,
> kernel text and data are spread over setup_arch(). Moreover, some of them
> happen *after* memblock allocations, e.g trim_platform_memory_ranges() and
> trim_low_memory_range() are called after reserve_real_mode() that allocates
> memory.
> 
> There was no corruption of these memory regions because memblock always
> allocates memory either from the end of memory (in top-down mode) or above
> the kernel image (in bottom-up mode). However, the bottom up mode is going
> to be updated to span the entire memory [1] to avoid limitations caused by
> KASLR.
> 
> Consolidate early memory reservations in a dedicated function to improve
> robustness against future changes. Having the early reservations in one
> place also makes it clearer what memory must be reserved before we allow
> memblock allocations.
> 
> [1] https://lore.kernel.org/lkml/20201217201214.3414100-2-guro@fb.com
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/kernel/setup.c | 92 ++++++++++++++++++++---------------------
>  1 file changed, 44 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index d883176ef2ce..3e3c6036b023 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -645,18 +645,6 @@ static void __init trim_snb_memory(void)
>  	}
>  }
>  
> -/*
> - * Here we put platform-specific memory range workarounds, i.e.
> - * memory known to be corrupt or otherwise in need to be reserved on
> - * specific platforms.
> - *
> - * If this gets used more widely it could use a real dispatch mechanism.
> - */
> -static void __init trim_platform_memory_ranges(void)
> -{
> -	trim_snb_memory();
> -}
> -
>  static void __init trim_bios_range(void)
>  {
>  	/*
> @@ -729,7 +717,38 @@ static void __init trim_low_memory_range(void)
>  {
>  	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
>  }
> -	
> +
> +static void __init early_reserve_memory(void)
> +{
> +	/*
> +	 * Reserve the memory occupied by the kernel between _text and
> +	 * __end_of_kernel_reserve symbols. Any kernel sections after the
> +	 * __end_of_kernel_reserve symbol must be explicitly reserved with a
> +	 * separate memblock_reserve() or they will be discarded.
> +	 */
> +	memblock_reserve(__pa_symbol(_text),
> +			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
> +
> +	/*
> +	 * Make sure page 0 is always reserved because on systems with
> +	 * L1TF its contents can be leaked to user processes.
> +	 */
> +	memblock_reserve(0, PAGE_SIZE);
> +
> +	early_reserve_initrd();
> +
> +	if (efi_enabled(EFI_BOOT))
> +		efi_memblock_x86_reserve_range();
> +
> +	memblock_x86_reserve_range_setup_data();

This patch looks good to me, thanks for the effort.

While at it, wondering if we can rename the above function to
memblock_reserve_setup_data() just as its e820 counterpart
e820__reserve_setup_data(), adding 'x86' to a function under arch/x86
seems redundant.

FWIW,

Reviewed-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> +
> +	reserve_ibft_region();
> +	reserve_bios_regions();
> +
> +	trim_snb_memory();
> +	trim_low_memory_range();
> +}
> +
>  /*
>   * Dump out kernel offset information on panic.
>   */
> @@ -764,29 +783,6 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
>  
>  void __init setup_arch(char **cmdline_p)
>  {
> -	/*
> -	 * Reserve the memory occupied by the kernel between _text and
> -	 * __end_of_kernel_reserve symbols. Any kernel sections after the
> -	 * __end_of_kernel_reserve symbol must be explicitly reserved with a
> -	 * separate memblock_reserve() or they will be discarded.
> -	 */
> -	memblock_reserve(__pa_symbol(_text),
> -			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
> -
> -	/*
> -	 * Make sure page 0 is always reserved because on systems with
> -	 * L1TF its contents can be leaked to user processes.
> -	 */
> -	memblock_reserve(0, PAGE_SIZE);
> -
> -	early_reserve_initrd();
> -
> -	/*
> -	 * At this point everything still needed from the boot loader
> -	 * or BIOS or kernel text should be early reserved or marked not
> -	 * RAM in e820. All other memory is free game.
> -	 */
> -
>  #ifdef CONFIG_X86_32
>  	memcpy(&boot_cpu_data, &new_cpu_data, sizeof(new_cpu_data));
>  
> @@ -910,8 +906,18 @@ void __init setup_arch(char **cmdline_p)
>  
>  	parse_early_param();
>  
> -	if (efi_enabled(EFI_BOOT))
> -		efi_memblock_x86_reserve_range();
> +	/*
> +	 * Do some memory reservations *before* memory is added to
> +	 * memblock, so memblock allocations won't overwrite it.
> +	 * Do it after early param, so we could get (unlikely) panic from
> +	 * serial.
> +	 *
> +	 * After this point everything still needed from the boot loader or
> +	 * firmware or kernel text should be early reserved or marked not
> +	 * RAM in e820. All other memory is free game.
> +	 */
> +	early_reserve_memory();
> +
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  	/*
>  	 * Memory used by the kernel cannot be hot-removed because Linux
> @@ -938,9 +944,6 @@ void __init setup_arch(char **cmdline_p)
>  
>  	x86_report_nx();
>  
> -	/* after early param, so could get panic from serial */
> -	memblock_x86_reserve_range_setup_data();
> -
>  	if (acpi_mps_check()) {
>  #ifdef CONFIG_X86_LOCAL_APIC
>  		disable_apic = 1;
> @@ -1032,8 +1035,6 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	find_smp_config();
>  
> -	reserve_ibft_region();
> -
>  	early_alloc_pgt_buf();
>  
>  	/*
> @@ -1054,8 +1055,6 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	sev_setup_arch();
>  
> -	reserve_bios_regions();
> -
>  	efi_fake_memmap();
>  	efi_find_mirror();
>  	efi_esrt_init();
> @@ -1081,9 +1080,6 @@ void __init setup_arch(char **cmdline_p)
>  
>  	reserve_real_mode();
>  
> -	trim_platform_memory_ranges();
> -	trim_low_memory_range();
> -
>  	init_mem_mapping();
>  
>  	idt_setup_early_pf();
> -- 
> 2.28.0
> 

