Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86ED5365CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhDTQBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232174AbhDTQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618934459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VLwDHA1T1kECXFVXDoESN93Xu3CIGiC8uj+j3Bh2ag=;
        b=L/hZoR2CF/2McZ8FvPDUAEqNRT5CCp+LOOGEQuxok9myXCdn/U6jwYZAYkR39JuzBBsORr
        17nF8zjZmDWqu/bmLYjpu2Mc5RCcdFWd/7GzFEkfDKVRSeNuF+nXE2R/AfbhqEWpVIuOpO
        V7Jz9mxc4fQZa+XqRWPVMQPetgp3yTI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-Bw8r28LgMV27SwkZkeVQKg-1; Tue, 20 Apr 2021 12:00:57 -0400
X-MC-Unique: Bw8r28LgMV27SwkZkeVQKg-1
Received: by mail-wm1-f70.google.com with SMTP id k26-20020a7bc41a0000b0290125f388fcfbso5838918wmi.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1VLwDHA1T1kECXFVXDoESN93Xu3CIGiC8uj+j3Bh2ag=;
        b=CjLAnfUALuMSBZ/W4qCMW/e0r/7gaplFaSBx7wXe6faqMldmIBjnXZW50ereRife4X
         JIRl0rx0eZpgRuxKRr8ufiiUP2bNvrd0kUf9tbcuvrckwRQBw6Y1pWvWfrcKLJs/gLWD
         JdhRy9w0pe3bmMeUTYN0K8NUXaPy6HkLS6wQQiWFa/cDE0zk2YRiUtr9jol/nWkDQNv+
         eiZNLnRzbnEwBo9LEPrScnKZf3WguksAzZjD6mvnZs7L6z8k4I6UxWCtg9U4Tc/L82d7
         y3XStQ3VlMsKXm4pJgYYDhZrv44kUiCCdl7xighGmf4Y2dF+nnGFfyBHatGQI9ms23H+
         4X0A==
X-Gm-Message-State: AOAM533JKuQUrIw8vVEP2p26B5Heh1T/B/fOvspdfrdExxelxGtnreu9
        R1Z+sNgE+mgz8ooiEzWEnt6V80nSUexgR1h/Ps3OWfag5bVt9IyVd+A9+TJU46PhMIHodSsf4ZB
        o+95mREhq8xeWEK6H2O6BGFqu
X-Received: by 2002:adf:d0cc:: with SMTP id z12mr21739748wrh.18.1618934456651;
        Tue, 20 Apr 2021 09:00:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxr5kh0sjqy8wW7F/IAJRwsgXm3O7rTTKuYEi9XNs0Np8ms/WxZijQLIJublkxDKy/HuPS98A==
X-Received: by 2002:adf:d0cc:: with SMTP id z12mr21739705wrh.18.1618934456321;
        Tue, 20 Apr 2021 09:00:56 -0700 (PDT)
Received: from [192.168.3.132] (p4ff2390a.dip0.t-ipconnect.de. [79.242.57.10])
        by smtp.gmail.com with ESMTPSA id o4sm9592968wrn.81.2021.04.20.09.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 09:00:56 -0700 (PDT)
Subject: Re: [PATCH v1 4/4] arm64: drop pfn_valid_within() and simplify
 pfn_valid()
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210420090925.7457-1-rppt@kernel.org>
 <20210420090925.7457-5-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <8e7171e7-a85c-6066-4ab6-d2bc98ec103b@redhat.com>
Date:   Tue, 20 Apr 2021 18:00:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420090925.7457-5-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.21 11:09, Mike Rapoport wrote:
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
> index c54e329aca15..370f33765b64 100644
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

What are the steps needed to get rid of custom pfn_valid() completely?

I'd assume we would have to stop freeing parts of the mem map during 
boot. How relevant is that for arm64 nowadays, especially with reduced 
section sizes?

-- 
Thanks,

David / dhildenb

