Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52299396ED6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhFAIYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233529AbhFAIYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622535781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qko+6OLUI0ASBUaG2AM+FeVy91xdoIP6u9Dh5KlRzDM=;
        b=UFvN4ygYZOzPlidMBpVUmHEKfS79l1xt4IJjKtjrcBv0EeKeaF2LtyWBnLpTLVnLWqAsg/
        L//CZHmF33DLT0hTdKcSVsWUO9e0FnWQkbZvPWRK8PKFR2mSlpQBnA0bZmGw3vD1i1VeNR
        P+E8ILLSWoaukVMcjOKk0cCSQRwSUXY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-5dQD8ZGYPhmT_gmsg70eTQ-1; Tue, 01 Jun 2021 04:22:57 -0400
X-MC-Unique: 5dQD8ZGYPhmT_gmsg70eTQ-1
Received: by mail-wr1-f69.google.com with SMTP id j33-20020adf91240000b029010e4009d2ffso4582020wrj.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qko+6OLUI0ASBUaG2AM+FeVy91xdoIP6u9Dh5KlRzDM=;
        b=gfdM0ot5OZg1ilQRoZyWcr4G6VqYx/gTkvzTks3EggaOuNNP9P3hSrCYAUzqiEVQvo
         OfOQ9Bng9tP/oafeeywvMKlBRcAyn6jnl/jr/58PF0B+SnzrCbe+dSDkltYcULd6POnH
         RHmFXq8XvVP1v8PXrSk1Lq0NWQhD8ZXx1B6LcB31Di/CYb/7J6TLbTrky/8hd7ludpmE
         Qq3+hMmyR1NoAmTKmtpcP2VEyK04zpDL/SfII8OTtnsrvev4i4G89T6PqtjpBI6ZJBKP
         iy7iUkcYZFuk94+O4WOV9MBAu2JDy0C57Fhz3QwoD2wXVoeygYR5IhTO6PquAb2qoRXR
         8olA==
X-Gm-Message-State: AOAM5320+Dt6mURPySEvL/TvklZdJtm6kev15jXoKQMowOamKgpAmisa
        7Netx0NniJmBL82ZVM55mUkq17LMomuaXD04dJNkAGAmomjt7Wzd5r2jnFqX+ZnHz7fkAL/Km17
        xHjGy9tD98fzJ9SofQtmdb3CH
X-Received: by 2002:adf:e3c8:: with SMTP id k8mr26044475wrm.212.1622535776735;
        Tue, 01 Jun 2021 01:22:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw12KgcgZ8BBy3UXy4SYPbp+iNY/jg5z1LMDTYyJdmcpHn2xiuwKa6oYIoF0d0arEpT0pG4GA==
X-Received: by 2002:adf:e3c8:: with SMTP id k8mr26044457wrm.212.1622535776531;
        Tue, 01 Jun 2021 01:22:56 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69ce.dip0.t-ipconnect.de. [91.12.105.206])
        by smtp.gmail.com with ESMTPSA id v18sm2485369wrb.10.2021.06.01.01.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 01:22:56 -0700 (PDT)
Subject: Re: [PATCH V2 4/6] mm: rename the global section array to
 mem_sections
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-5-aisheng.dong@nxp.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <42617372-c846-85fe-4739-abbe55eca8f6@redhat.com>
Date:   Tue, 1 Jun 2021 10:22:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210531091908.1738465-5-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.21 11:19, Dong Aisheng wrote:
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
> v1->v2:
>   * no changes
> ---
>   include/linux/mmzone.h | 10 +++++-----
>   kernel/crash_core.c    |  4 ++--
>   mm/sparse.c            | 16 ++++++++--------
>   3 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index a6bfde85ddb0..0ed61f32d898 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1302,9 +1302,9 @@ struct mem_section {
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
> @@ -1315,12 +1315,12 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
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
> index d02ee6bb7cbc..6412010478f7 100644
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
> @@ -66,8 +66,8 @@ static void __init sparse_alloc_section_roots(void)
>   
>   	size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
>   	align = 1 << (INTERNODE_CACHE_SHIFT);
> -	mem_section = memblock_alloc(size, align);
> -	if (!mem_section)
> +	mem_sections = memblock_alloc(size, align);
> +	if (!mem_sections)
>   		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
>   		      __func__, size, align);
>   }
> @@ -103,14 +103,14 @@ static int __meminit sparse_index_init(unsigned long section_nr, int nid)
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
> @@ -145,7 +145,7 @@ unsigned long __section_nr(struct mem_section *ms)
>   #else
>   unsigned long __section_nr(struct mem_section *ms)
>   {
> -	return (unsigned long)(ms - mem_section[0]);
> +	return (unsigned long)(ms - mem_sections[0]);
>   }
>   #endif
>   
> 

I repeat: unnecessary code churn IMHO.

-- 
Thanks,

David / dhildenb

