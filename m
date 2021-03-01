Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2232232A016
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575272AbhCBDy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:54:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:38150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245292AbhCAWTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:19:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B108EAD29;
        Mon,  1 Mar 2021 22:18:48 +0000 (UTC)
Date:   Mon, 1 Mar 2021 23:18:46 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ira Weiny <ira.weiny@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v1] microblaze: tag highmem_setup() with __meminit
Message-ID: <20210301221846.GA4744@localhost.localdomain>
References: <20210301114749.47914-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301114749.47914-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 12:47:49PM +0100, David Hildenbrand wrote:
> With commit a0cd7a7c4bc0 ("mm: simplify free_highmem_page() and
> free_reserved_page()") the kernel test robot complains about a warning:
> 
> WARNING: modpost: vmlinux.o(.text.unlikely+0x23ac): Section mismatch in
>   reference from the function highmem_setup() to the function
>   .meminit.text:memblock_is_reserved()
> 
> This has been broken ever since microblaze added highmem support,
> because memblock_is_reserved() was already tagged with "__init" back then -
> most probably the function always got inlined, so we never stumbled over
> it.

It might be good to point out that we need __meminit instead of __init
because microblaze platform does not define CONFIG_ARCH_KEEP_MEMBLOCK,
and __init_memblock fallsback to that.

(I had to go and look as I was puzzled :-) )

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 2f2f371f8907 ("microblaze: Highmem support")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/microblaze/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
> index 181e48782e6c..05cf1fb3f5ff 100644
> --- a/arch/microblaze/mm/init.c
> +++ b/arch/microblaze/mm/init.c
> @@ -52,7 +52,7 @@ static void __init highmem_init(void)
>  	pkmap_page_table = virt_to_kpte(PKMAP_BASE);
>  }
>  
> -static void highmem_setup(void)
> +static void __meminit highmem_setup(void)
>  {
>  	unsigned long pfn;
>  
> -- 
> 2.29.2
> 
> 

-- 
Oscar Salvador
SUSE L3
