Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DBF356DBE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242086AbhDGNsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:48:03 -0400
Received: from foss.arm.com ([217.140.110.172]:57462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233758AbhDGNsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:48:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29C521063;
        Wed,  7 Apr 2021 06:47:51 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 504F33F792;
        Wed,  7 Apr 2021 06:47:50 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: Add __init section marker to some functions
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210330135449.4dcffd7f@xhacker.debian>
From:   Steven Price <steven.price@arm.com>
Message-ID: <ee23634b-c70a-6125-c8dc-3692f100672a@arm.com>
Date:   Wed, 7 Apr 2021 14:48:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330135449.4dcffd7f@xhacker.debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2021 06:54, Jisheng Zhang wrote:
> They are not needed after booting, so mark them as __init to move them
> to the .init section.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
> Since v1:
>   - add __init section mark to __vdso_init() and __aarch32_alloc_vdso_pages()
> 
>   arch/arm64/include/asm/ptdump.h | 2 +-
>   arch/arm64/kernel/vdso.c        | 4 ++--
>   arch/arm64/mm/ptdump.c          | 4 ++--
>   arch/arm64/mm/ptdump_debugfs.c  | 2 +-
>   4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> index 38187f74e089..b1dd7ecff7ef 100644
> --- a/arch/arm64/include/asm/ptdump.h
> +++ b/arch/arm64/include/asm/ptdump.h
> @@ -23,7 +23,7 @@ struct ptdump_info {
>   
>   void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
>   #ifdef CONFIG_PTDUMP_DEBUGFS
> -void ptdump_debugfs_register(struct ptdump_info *info, const char *name);
> +void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
>   #else
>   static inline void ptdump_debugfs_register(struct ptdump_info *info,
>   					   const char *name) { }
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index cee5d04ea9ad..d1fa288518a7 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -86,7 +86,7 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
>   	return 0;
>   }
>   
> -static int __vdso_init(enum vdso_abi abi)
> +static int __init __vdso_init(enum vdso_abi abi)
>   {
>   	int i;
>   	struct page **vdso_pagelist;
> @@ -326,7 +326,7 @@ static int aarch32_alloc_sigpage(void)
>   	return 0;
>   }
>   
> -static int __aarch32_alloc_vdso_pages(void)
> +static int __init __aarch32_alloc_vdso_pages(void)
>   {
>   
>   	if (!IS_ENABLED(CONFIG_COMPAT_VDSO))
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index 0e050d76b83a..a50e92ea1878 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -337,7 +337,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
>   	ptdump_walk_pgd(&st.ptdump, info->mm, NULL);
>   }
>   
> -static void ptdump_initialize(void)
> +static void __init ptdump_initialize(void)
>   {
>   	unsigned i, j;
>   
> @@ -381,7 +381,7 @@ void ptdump_check_wx(void)
>   		pr_info("Checked W+X mappings: passed, no W+X pages found\n");
>   }
>   
> -static int ptdump_init(void)
> +static int __init ptdump_init(void)
>   {
>   	address_markers[PAGE_END_NR].start_address = PAGE_END;
>   #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
> index d29d722ec3ec..68bf1a125502 100644
> --- a/arch/arm64/mm/ptdump_debugfs.c
> +++ b/arch/arm64/mm/ptdump_debugfs.c
> @@ -16,7 +16,7 @@ static int ptdump_show(struct seq_file *m, void *v)
>   }
>   DEFINE_SHOW_ATTRIBUTE(ptdump);
>   
> -void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
> +void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name)
>   {
>   	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
>   }
> 

