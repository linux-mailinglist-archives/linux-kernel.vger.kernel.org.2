Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F5638FC06
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhEYH4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231640AbhEYH4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621929313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x070tQ5CLRrsBPg2h5b3DfLhZ5uEavvY3kDP5R48Mp4=;
        b=dipWXxEukWOQwA5mQgRnHfKIFTD62w093UwkWb+s9F1NcwfsvTx11YQTnixyYM3KWtvyP4
        B3YgHUgZ7QIBdYPGSuyjB9/VvQpXqqMpfDMtR5HiGfx0Kx++hSqnE4DFWmrznOMHp6qy0u
        pGckVqf2NGiKBCKvEb3hrlCSCq6O7OA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-HcrDiubvPiKOWUxNQa02GA-1; Tue, 25 May 2021 03:55:11 -0400
X-MC-Unique: HcrDiubvPiKOWUxNQa02GA-1
Received: by mail-wr1-f71.google.com with SMTP id j33-20020adf91240000b029010e4009d2ffso14214382wrj.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=x070tQ5CLRrsBPg2h5b3DfLhZ5uEavvY3kDP5R48Mp4=;
        b=WHjcyZKvxHCnzFX+mMuiwZkjXNk/RqJ6IzE6Ei5WKiG2cSrD1DHtTTiPgSrVb0dSD6
         LdM9sa22qQS8BQG/ViFcq+2ogd5FjFCkYa10peQNfWH9xoA26IfRpZnIFIItQ2AhtM74
         otMPY7ViY+1khBHlXioLmTvodDurXe5ZsdFamnKs4CECN5Q7XQxuAUXj/EQtzmwksnJc
         RgamomliQEOh9UIe4w8ZtJenFBGuc0gbozGQY3aE6gf3xhyQYLO0vTaxl8RZBi1IPXhR
         fTITkGyRZAvPSc6eMpQTp4L9y9Veod5ux2BumyFR1/5bdSXFBhcmZaZqQx0doYH0JMT/
         F6Sw==
X-Gm-Message-State: AOAM532t8U9FFND16mN9ZM2vWxhz6fvORV+Ydn30tBTd7OMPqwds7Pxr
        VZwCoG8MFHz+xWAq4G+ZGPUduwI5LzTK/IZUIJcs8TJ8HpE94aEZ4hWiW93trATmpbXQgmVplib
        1F0dVO6jyomFMElplhJa4lrNI
X-Received: by 2002:a1c:6355:: with SMTP id x82mr22644300wmb.178.1621929310339;
        Tue, 25 May 2021 00:55:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoK+ONNwRVXX+uxmWWrihpve5/LZGVZA6s7eNQLdabYEc3al9o19TUlVGHhEAxZ5DlmA3+Ag==
X-Received: by 2002:a1c:6355:: with SMTP id x82mr22644280wmb.178.1621929310132;
        Tue, 25 May 2021 00:55:10 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f38:2400:62f4:c5fa:ba13:ac32? (p200300d82f38240062f4c5faba13ac32.dip0.t-ipconnect.de. [2003:d8:2f38:2400:62f4:c5fa:ba13:ac32])
        by smtp.gmail.com with ESMTPSA id o21sm10050808wmr.44.2021.05.25.00.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 00:55:09 -0700 (PDT)
Subject: Re: [PATCH 4/5] mm: rename the global section array to mem_sections
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
References: <20210517112044.233138-1-aisheng.dong@nxp.com>
 <20210517112044.233138-5-aisheng.dong@nxp.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <a0db36d1-3ad0-ffc7-02ab-dabab346dae9@redhat.com>
Date:   Tue, 25 May 2021 09:55:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517112044.233138-5-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.21 13:20, Dong Aisheng wrote:
> In order to distinguish the struct mem_section for a better code
> readability and align with kernel doc [1] name below, change the
> global mem section name to 'mem_sections' from 'mem_section'.
> 
> [1] Documentation/vm/memory-model.rst
> "The `mem_section` objects are arranged in a two-dimensional array
> called `mem_sections`."
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: kexec@lists.infradead.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   include/linux/mmzone.h | 10 +++++-----
>   kernel/crash_core.c    |  4 ++--
>   mm/sparse.c            | 16 ++++++++--------
>   3 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index fc23e36cb165..b348a06915c5 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1297,9 +1297,9 @@ struct mem_section {
>   #define SECTION_ROOT_MASK	(SECTIONS_PER_ROOT - 1)
>   
>   #ifdef CONFIG_SPARSEMEM_EXTREME
> -extern struct mem_section **mem_section;
> +extern struct mem_section **mem_sections;
>   #else
> -extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
> +extern struct mem_section mem_sections[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
>   #endif
>   
>   static inline unsigned long *section_to_usemap(struct mem_section *ms)
> @@ -1310,12 +1310,12 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
>   static inline struct mem_section *__nr_to_section(unsigned long nr)
>   {
>   #ifdef CONFIG_SPARSEMEM_EXTREME
> -	if (!mem_section)
> +	if (!mem_sections)
>   		return NULL;
>   #endif
> -	if (!mem_section[SECTION_NR_TO_ROOT(nr)])
> +	if (!mem_sections[SECTION_NR_TO_ROOT(nr)])
>   		return NULL;
> -	return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
> +	return &mem_sections[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
>   }
>   extern unsigned long __section_nr(struct mem_section *ms);
>   extern size_t mem_section_usage_size(void);
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 29cc15398ee4..fb1180d81b5a 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -414,8 +414,8 @@ static int __init crash_save_vmcoreinfo_init(void)
>   	VMCOREINFO_SYMBOL(contig_page_data);
>   #endif
>   #ifdef CONFIG_SPARSEMEM
> -	VMCOREINFO_SYMBOL_ARRAY(mem_section);
> -	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> +	VMCOREINFO_SYMBOL_ARRAY(mem_sections);
> +	VMCOREINFO_LENGTH(mem_sections, NR_SECTION_ROOTS);
>   	VMCOREINFO_STRUCT_SIZE(mem_section);
>   	VMCOREINFO_OFFSET(mem_section, section_mem_map);
>   	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
> diff --git a/mm/sparse.c b/mm/sparse.c
> index df4418c12f04..a96e7e65475f 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -24,12 +24,12 @@
>    * 1) mem_section	- memory sections, mem_map's for valid memory
>    */
>   #ifdef CONFIG_SPARSEMEM_EXTREME
> -struct mem_section **mem_section;
> +struct mem_section **mem_sections;
>   #else
> -struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
> +struct mem_section mem_sections[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
>   	____cacheline_internodealigned_in_smp;
>   #endif
> -EXPORT_SYMBOL(mem_section);
> +EXPORT_SYMBOL(mem_sections);
>   
>   #ifdef NODE_NOT_IN_PAGE_FLAGS
>   /*
> @@ -91,14 +91,14 @@ static int __meminit sparse_index_init(unsigned long section_nr, int nid)
>   	 *
>   	 * The mem_hotplug_lock resolves the apparent race below.
>   	 */
> -	if (mem_section[root])
> +	if (mem_sections[root])
>   		return 0;
>   
>   	section = sparse_index_alloc(nid);
>   	if (!section)
>   		return -ENOMEM;
>   
> -	mem_section[root] = section;
> +	mem_sections[root] = section;
>   
>   	return 0;
>   }
> @@ -131,7 +131,7 @@ unsigned long __section_nr(struct mem_section *ms)
>   #else
>   unsigned long __section_nr(struct mem_section *ms)
>   {
> -	return (unsigned long)(ms - mem_section[0]);
> +	return (unsigned long)(ms - mem_sections[0]);
>   }
>   #endif
>   
> @@ -286,8 +286,8 @@ static void __init memblocks_present(void)
>   #ifdef CONFIG_SPARSEMEM_EXTREME
>   	size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
>   	align = 1 << (INTERNODE_CACHE_SHIFT);
> -	mem_section = memblock_alloc(size, align);
> -	if (!mem_section)
> +	mem_sections = memblock_alloc(size, align);
> +	if (!mem_sections)
>   		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
>   		      __func__, size, align);
>   #endif
> 

Smells like unnecessary code churn. I'd rather just fix the doc because 
it doesn't really improve readability IMHO.

Anyhow, just my 2 cents.

-- 
Thanks,

David / dhildenb

