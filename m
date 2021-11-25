Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4750A45D8C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhKYLJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 06:09:51 -0500
Received: from foss.arm.com ([217.140.110.172]:49480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232624AbhKYLHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:07:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B1DB1042;
        Thu, 25 Nov 2021 03:04:39 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.79.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7F2F3F66F;
        Thu, 25 Nov 2021 03:04:37 -0800 (PST)
Date:   Thu, 25 Nov 2021 11:04:31 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Subject: Re: [PATCH] scripts/sorttable: Unify arm64 & x86 sort functions
Message-ID: <YZ9tv8stXfdSfvAr@FVFF77S0Q05N>
References: <20211108114220.32796-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108114220.32796-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Ingo and Peter]

TIP folk, is this something you'd be happy to pick up?

arm64 and x86 simply raced to add the same logic to sorttable.c for v5.16-rc1,
and it'd be nice to clean those up for v5.16-rc3 or so, since the riscv folk
want to use the same logic for v5.17 or so:

  https://lore.kernel.org/r/20211118192605.57e06d6b@xhacker

Will's acked this patch in the reply at:

  https://lore.kernel.org/r/20211116100406.GA9851@willie-the-truck

Thanks
Mark.

On Mon, Nov 08, 2021 at 11:42:20AM +0000, Mark Rutland wrote:
> The format of the arm64 and x86 exception table entries is essentially
> the same as of commits:
> 
>   46d28947d9876fc0 ("x86/extable: Rework the exception table mechanics")
>   d6e2cc5647753825 ("arm64: extable: add `type` and `data` fields")
> 
> Both use a 12-byte entry consisting of two 32-bit relative offsets and
> 32 bits of (absolute) data, and their sort functions are identical aside
> from commentary, with arm64 saying:
> 
>    /* Don't touch the fixup type or data */
> 
> ... and x86 saying:
> 
>   /* Don't touch the fixup type */
> 
> Unify the two behind a common sort_relative_table_with_data() function,
> retaining the arm64 commentary.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  scripts/sorttable.c | 36 +++---------------------------------
>  1 file changed, 3 insertions(+), 33 deletions(-)
> 
> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> index b7c2ad71f9cf..ca9db62bf766 100644
> --- a/scripts/sorttable.c
> +++ b/scripts/sorttable.c
> @@ -231,7 +231,7 @@ static void sort_relative_table(char *extab_image, int image_size)
>  	}
>  }
>  
> -static void arm64_sort_relative_table(char *extab_image, int image_size)
> +static void sort_relative_table_with_data(char *extab_image, int image_size)
>  {
>  	int i = 0;
>  
> @@ -259,34 +259,6 @@ static void arm64_sort_relative_table(char *extab_image, int image_size)
>  	}
>  }
>  
> -static void x86_sort_relative_table(char *extab_image, int image_size)
> -{
> -	int i = 0;
> -
> -	while (i < image_size) {
> -		uint32_t *loc = (uint32_t *)(extab_image + i);
> -
> -		w(r(loc) + i, loc);
> -		w(r(loc + 1) + i + 4, loc + 1);
> -		/* Don't touch the fixup type */
> -
> -		i += sizeof(uint32_t) * 3;
> -	}
> -
> -	qsort(extab_image, image_size / 12, 12, compare_relative_table);
> -
> -	i = 0;
> -	while (i < image_size) {
> -		uint32_t *loc = (uint32_t *)(extab_image + i);
> -
> -		w(r(loc) - i, loc);
> -		w(r(loc + 1) - (i + 4), loc + 1);
> -		/* Don't touch the fixup type */
> -
> -		i += sizeof(uint32_t) * 3;
> -	}
> -}
> -
>  static void s390_sort_relative_table(char *extab_image, int image_size)
>  {
>  	int i;
> @@ -364,15 +336,13 @@ static int do_file(char const *const fname, void *addr)
>  
>  	switch (r2(&ehdr->e_machine)) {
>  	case EM_386:
> +	case EM_AARCH64:
>  	case EM_X86_64:
> -		custom_sort = x86_sort_relative_table;
> +		custom_sort = sort_relative_table_with_data;
>  		break;
>  	case EM_S390:
>  		custom_sort = s390_sort_relative_table;
>  		break;
> -	case EM_AARCH64:
> -		custom_sort = arm64_sort_relative_table;
> -		break;
>  	case EM_PARISC:
>  	case EM_PPC:
>  	case EM_PPC64:
> -- 
> 2.11.0
> 
