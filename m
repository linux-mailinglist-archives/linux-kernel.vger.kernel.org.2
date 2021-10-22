Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E9C437709
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 14:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbhJVMZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 08:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232796AbhJVMZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 08:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634905368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lm3PNIF2S0K4K4WLBOwjvTNY9grqBtS5TFJa0ZgTsDk=;
        b=eCdu275zAZvc9MEEmwnif43/X1WdIsIDxHEGwLh0OKmhR4s5nVtXAxV3VHlwIDzmd7iNVn
        tRZuJ53X0lZbLTGya69N/tOaG7oz76WBpozLSiJ0pAyrs4pQPYCDW0lrSkg3WOoWBFj3TC
        4/q6b6+IoAkZHvsvX1M0SE/hYh8cER4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-mn3usaUZPWugGbMT3iKWNg-1; Fri, 22 Oct 2021 08:22:47 -0400
X-MC-Unique: mn3usaUZPWugGbMT3iKWNg-1
Received: by mail-wm1-f69.google.com with SMTP id k126-20020a1ca184000000b003231d0e329bso1084668wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 05:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Lm3PNIF2S0K4K4WLBOwjvTNY9grqBtS5TFJa0ZgTsDk=;
        b=jvIsHoNCzb4qZBxsB+cj6waDV8A14G/sDF9wZumc0E/TgXiXcRiAAzbS0WVY6zrUap
         NMkaA77C0lkXAKmvTOsyRO53fGvZPbf1hWS+ZW1PGnoy7+nm3mrn6VVfTvGTxlgFjXFm
         ZtLJwoGL3idorE1evKpSGvo/2pqh1tlgszhM/ijqOXPIlb2AnaPRUf2olb7zTRxlU3IZ
         Ln/HPwzb4RTQMjPt8UN/LdpzKuOeSW0RFtX+eqGzey9IPUiqLf39Jd6brSVpp04FWFse
         lej9ifaSglqEO+dPGSVKTkZiFHmv8tgC8VCtUmliDM9rRsH1q6jeFtOqCC88S7/Ytu5G
         v+SQ==
X-Gm-Message-State: AOAM532OJft4PHjGv3XlWEaRBlhbvtxTRUhYR7OaOJ3X38VHe3srpOIR
        +tQAQGj010V6yVKVExQDNwWn4o8OM796oxGnJbRKPcy+qnDuP4du82K6smtuIqmH308V8hI7Z6d
        S5Hnd06AE5fBWHsdHa3ZnpdK5
X-Received: by 2002:a5d:6442:: with SMTP id d2mr15549579wrw.356.1634905366092;
        Fri, 22 Oct 2021 05:22:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9Ax08EtLUCC0p7CmqxJQykoibwilBZDOykjM7r34VB3UtotJaWTHceuBHMMxN5DPCje07gQ==
X-Received: by 2002:a5d:6442:: with SMTP id d2mr15549549wrw.356.1634905365864;
        Fri, 22 Oct 2021 05:22:45 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6324.dip0.t-ipconnect.de. [91.12.99.36])
        by smtp.gmail.com with ESMTPSA id k17sm7652830wrc.93.2021.10.22.05.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 05:22:45 -0700 (PDT)
Message-ID: <3cd2d3d2-6d97-3cd6-b273-6e52aa6066c9@redhat.com>
Date:   Fri, 22 Oct 2021 14:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 2/2] memblock: exclude MEMBLOCK_NOMAP regions from
 kmemleak
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20211021070929.23272-1-rppt@kernel.org>
 <20211021070929.23272-3-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211021070929.23272-3-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.21 09:09, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Vladimir Zapolskiy reports:
> 
> commit a7259df76702 ("memblock: make memblock_find_in_range method private")
> invokes a kernel panic while running kmemleak on OF platforms with nomaped
> regions:
> 
>   Unable to handle kernel paging request at virtual address fff000021e00000
>   [...]
>     scan_block+0x64/0x170
>     scan_gray_list+0xe8/0x17c
>     kmemleak_scan+0x270/0x514
>     kmemleak_write+0x34c/0x4ac
> 
> The memory allocated from memblock is registered with kmemleak, but if it
> is marked MEMBLOCK_NOMAP it won't have linear map entries so an attempt to
> scan such areas will fault.
> 
> Ideally, memblock_mark_nomap() would inform kmemleak to ignore
> MEMBLOCK_NOMAP memory, but it can be called before kmemleak interfaces
> operating on physical addresses can use __va() conversion.
> 
> Make sure that functions that mark allocated memory as MEMBLOCK_NOMAP take
> care of informing kmemleak to ignore such memory.
> 
> Link: https://lore.kernel.org/all/8ade5174-b143-d621-8c8e-dc6a1898c6fb@linaro.org
> Link: https://lore.kernel.org/all/c30ff0a2-d196-c50d-22f0-bd50696b1205@quicinc.com
> Fixes: a7259df76702 ("memblock: make memblock_find_in_range method private")
> Reported-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  drivers/acpi/tables.c        | 3 +++
>  drivers/of/of_reserved_mem.c | 2 ++
>  mm/memblock.c                | 3 +++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index f9383736fa0f..71419eb16e09 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -21,6 +21,7 @@
>  #include <linux/earlycpio.h>
>  #include <linux/initrd.h>
>  #include <linux/security.h>
> +#include <linux/kmemleak.h>
>  #include "internal.h"
>  
>  #ifdef CONFIG_ACPI_CUSTOM_DSDT
> @@ -601,6 +602,8 @@ void __init acpi_table_upgrade(void)
>  	 */
>  	arch_reserve_mem_area(acpi_tables_addr, all_tables_size);
>  
> +	kmemleak_ignore_phys(acpi_tables_addr);
> +
>  	/*
>  	 * early_ioremap only can remap 256k one time. If we map all
>  	 * tables one time, we will hit the limit. Need to map chunks
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 59c1390cdf42..9da8835ba5a5 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -21,6 +21,7 @@
>  #include <linux/sort.h>
>  #include <linux/slab.h>
>  #include <linux/memblock.h>
> +#include <linux/kmemleak.h>
>  
>  #include "of_private.h"
>  
> @@ -46,6 +47,7 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
>  		err = memblock_mark_nomap(base, size);
>  		if (err)
>  			memblock_free(base, size);
> +		kmemleak_ignore_phys(base);
>  	}
>  
>  	return err;
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 184dcd2e5d99..dab804b09d62 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -932,6 +932,9 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
>   * covered by the memory map. The struct page representing NOMAP memory
>   * frames in the memory map will be PageReserved()
>   *
> + * Note: if the memory being marked %MEMBLOCK_NOMAP was allocated from
> + * memblock, the caller must inform kmemleak to ignore that memory
> + *
>   * Return: 0 on success, -errno on failure.
>   */
>  int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

