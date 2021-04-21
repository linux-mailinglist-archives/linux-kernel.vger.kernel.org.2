Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06F9366668
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbhDUHtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55888 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229536AbhDUHtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618991346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yo0aeP/gZ7xIL1Br7EZck8Ru/9tRz4VORS9chdtNmnw=;
        b=KQrDT+q35jKv8xnO82y8isMWTMGp2ydKtga/3QuAG/4DI+OxLqFHgf8vPGMklBWltkF3OF
        jzSRHeVTbuLM20aCaVMp14iAUF2A9XFnO+qD0sbuT5BeB0jl7qtmItBKhdwyTtVaOYFCOs
        RVdr1Wr0Pfvng5nAJbyxeqLuhQUH0Xw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-QcSEQerkNHu_LwHuV6jVjQ-1; Wed, 21 Apr 2021 03:49:04 -0400
X-MC-Unique: QcSEQerkNHu_LwHuV6jVjQ-1
Received: by mail-ed1-f72.google.com with SMTP id c13-20020a05640227cdb0290385526e5de5so4504354ede.21
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yo0aeP/gZ7xIL1Br7EZck8Ru/9tRz4VORS9chdtNmnw=;
        b=k4vFuK3QFq6qRNE7K6Rks5acU2rLnK/TMAOmUeJpU7YqmmiA5aGt+NDEajHxVZKW9m
         I6gTJMmW7AIN6dzGouV5ahO9f8LWJ7aR2Pgeeu7BXC+CLWRdNXk5RIQTZABKUnOG3Kdv
         lvJOh2Eeu6PljvnH0NSdJrgc7UyBhwe6Sck7W1Bd8o6zRaSCA3yjD7HeDoQlmlRJTwdI
         d034J7ztFj6jg6zGSC1ZXgonaFuCKcl859Hw6OCAppzG4WMs1OMMP4iGEJ0oDiKtp2un
         +ufp8y7U07jNGVdoHDNro9WkbtubcsjXcCC8vreQxkrkTZfU/DR+o77IsHlgpuLDjxZP
         A5VA==
X-Gm-Message-State: AOAM53131CfJ/w5Kt4EJNkNGKITWX+eBGz8BN2vnwy5Cj6mitCdAA83y
        dYvq7nH0lvf/rnWZAKihoShxbKlWJp603f9U75YGQPvGd5JEcZtTSPQip0z39puAPfg7EmPG//5
        kr3oOwiyB9SDuXymAvO8+hNOX
X-Received: by 2002:a17:906:a0c2:: with SMTP id bh2mr30655388ejb.394.1618991343593;
        Wed, 21 Apr 2021 00:49:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCI5v3IslAnTd1D5vuwywZ+19uA0jnaa9i2DYeKnzLSV7LTGXv7KAxF6ZWHxxr+Z98bKaYGg==
X-Received: by 2002:a17:906:a0c2:: with SMTP id bh2mr30655371ejb.394.1618991343356;
        Wed, 21 Apr 2021 00:49:03 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64b8.dip0.t-ipconnect.de. [91.12.100.184])
        by smtp.gmail.com with ESMTPSA id ju23sm1495102ejc.17.2021.04.21.00.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 00:49:03 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] arm64: drop pfn_valid_within() and simplify
 pfn_valid()
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210421065108.1987-1-rppt@kernel.org>
 <20210421065108.1987-5-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <24edab0c-226c-7ff6-2151-7a8b218c7c44@redhat.com>
Date:   Wed, 21 Apr 2021 09:49:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210421065108.1987-5-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.04.21 08:51, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The arm64's version of pfn_valid() differs from the generic because of two
> reasons:
> 
> * Parts of the memory map are freed during boot. This makes it necessary to
>    verify that there is actual physical memory that corresponds to a pfn
>    which is done by querying memblock.
> 
> * There are NOMAP memory regions. These regions are not mapped in the
>    linear map and until the previous commit the struct pages representing
>    these areas had default values.
> 
> As the consequence of absence of the special treatment of NOMAP regions in
> the memory map it was necessary to use memblock_is_map_memory() in
> pfn_valid() and to have pfn_valid_within() aliased to pfn_valid() so that
> generic mm functionality would not treat a NOMAP page as a normal page.
> 
> Since the NOMAP regions are now marked as PageReserved(), pfn walkers and
> the rest of core mm will treat them as unusable memory and thus
> pfn_valid_within() is no longer required at all and can be disabled by
> removing CONFIG_HOLES_IN_ZONE on arm64.
> 
> pfn_valid() can be slightly simplified by replacing
> memblock_is_map_memory() with memblock_is_memory().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   arch/arm64/Kconfig   | 3 ---
>   arch/arm64/mm/init.c | 4 ++--
>   2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e4e1b6550115..58e439046d05 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1040,9 +1040,6 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>   	def_bool y
>   	depends on NUMA
>   
> -config HOLES_IN_ZONE
> -	def_bool y
> -
>   source "kernel/Kconfig.hz"
>   
>   config ARCH_SPARSEMEM_ENABLE
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index dc03bdc12c0f..eb3f56fb8c7c 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -243,7 +243,7 @@ int pfn_valid(unsigned long pfn)
>   
>   	/*
>   	 * ZONE_DEVICE memory does not have the memblock entries.
> -	 * memblock_is_map_memory() check for ZONE_DEVICE based
> +	 * memblock_is_memory() check for ZONE_DEVICE based
>   	 * addresses will always fail. Even the normal hotplugged
>   	 * memory will never have MEMBLOCK_NOMAP flag set in their
>   	 * memblock entries. Skip memblock search for all non early
> @@ -254,7 +254,7 @@ int pfn_valid(unsigned long pfn)
>   		return pfn_section_valid(ms, pfn);
>   }
>   #endif
> -	return memblock_is_map_memory(addr);
> +	return memblock_is_memory(addr);
>   }
>   EXPORT_SYMBOL(pfn_valid);
>   
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

