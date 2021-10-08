Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442AF426823
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 12:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbhJHKsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 06:48:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230032AbhJHKsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 06:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633689980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ZrmeghbzDGDCRJyBgnjXu1u/BJe351JSfBE0ppWVUo=;
        b=Ua9IIyVbrLWZuE0S7KvoSL1mC/1cGJ1122efGD0wkT57ir7dz9o4m92Ld1YweiMBn/sK8h
        ZWau+6rQsXR9HPXVMYEpGjP7XG5+UICIwix5MU8WG33dEqiuob7q4xIayDx+kg57JkWpD7
        KKTndx4HDEVZLcdkabL1yqwoAujYL4o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-fJMBBhATPpm7OzCFZ-_57Q-1; Fri, 08 Oct 2021 06:46:19 -0400
X-MC-Unique: fJMBBhATPpm7OzCFZ-_57Q-1
Received: by mail-wr1-f72.google.com with SMTP id k16-20020a5d6290000000b00160753b430fso7020805wru.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 03:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1ZrmeghbzDGDCRJyBgnjXu1u/BJe351JSfBE0ppWVUo=;
        b=mW8UFZWvzYuAmi9xL9dkC3QfiyhGcaxQY23BMHMhQVlqa2o/T+4p7gQzz3gTR7MNTg
         VhIHTptuGpLl854Y51mhwsk1E7/fOIy/+T77N3qgMtE+Gu7ELt0BCJXE9kuofQOiVijw
         PKPM8HCfXkWhkCbqPoWveaZVnZ9k/UX396QEXYe528W40xJ/7aTxA2sjE0E0k9XLA0sP
         tDp/LET5l3tvOeuvF+52TO4+VuJWnpEznRaDqZqRckI9QmZRZUfrSj4D7LcPl0HZE2JK
         DgWD2l498m+q97x6QJECCaZzcfPv4cgzld+cPHHByNeTnVtOS4G+1qxR+K8ON2/gFYbu
         eZ7g==
X-Gm-Message-State: AOAM530dTfsl5onT1mhD5x9kz8/lZjnxgBgDjpj0AaTWGcKniHlfuhJE
        ECCmjoWNv2Mf2lDK/7rMOVpamC3I2FmXIbbOZYAUX/XbWpyN3YcK868MxRFkAdkRg66mXbde/lr
        DWVo4IF7xjK5hDairdSeNZB5I
X-Received: by 2002:adf:f486:: with SMTP id l6mr2975692wro.375.1633689978350;
        Fri, 08 Oct 2021 03:46:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVvuDmQ2o7F+mPEUTq3C3d/JQl5S2sLgkDYkW1Y8AZnZBRM8c8KvitOhZtnoqmbIA0u2nEPg==
X-Received: by 2002:adf:f486:: with SMTP id l6mr2975673wro.375.1633689978156;
        Fri, 08 Oct 2021 03:46:18 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676e.dip0.t-ipconnect.de. [91.12.103.110])
        by smtp.gmail.com with ESMTPSA id f16sm2169829wrr.53.2021.10.08.03.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 03:46:17 -0700 (PDT)
Subject: Re: [PATCH] mm: Fix NULL page->mapping dereference in
 page_is_secretmem()
To:     Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, "Darrick J . Wong" <djwong@kernel.org>,
        Stephen <stephenackerman16@gmail.com>
References: <20211007231502.3552715-1-seanjc@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <97f7ae02-3124-8de5-f614-a2f7891645a5@redhat.com>
Date:   Fri, 8 Oct 2021 12:46:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211007231502.3552715-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.10.21 01:15, Sean Christopherson wrote:
> Check for a NULL page->mapping before dereferencing the mapping in
> page_is_secretmem(), as the page's mapping can be nullified while gup()
> is running, e.g. by reclaim or truncation.
> 
>    BUG: kernel NULL pointer dereference, address: 0000000000000068
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 0 P4D 0
>    Oops: 0000 [#1] PREEMPT SMP NOPTI
>    CPU: 6 PID: 4173897 Comm: CPU 3/KVM Tainted: G        W
>    RIP: 0010:internal_get_user_pages_fast+0x621/0x9d0
>    Code: <48> 81 7a 68 80 08 04 bc 0f 85 21 ff ff 8 89 c7 be
>    RSP: 0018:ffffaa90087679b0 EFLAGS: 00010046
>    RAX: ffffe3f37905b900 RBX: 00007f2dd561e000 RCX: ffffe3f37905b934
>    RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffe3f37905b900
>    ...
>    CR2: 0000000000000068 CR3: 00000004c5898003 CR4: 00000000001726e0
>    Call Trace:
>     get_user_pages_fast_only+0x13/0x20
>     hva_to_pfn+0xa9/0x3e0
>     try_async_pf+0xa1/0x270
>     direct_page_fault+0x113/0xad0
>     kvm_mmu_page_fault+0x69/0x680
>     vmx_handle_exit+0xe1/0x5d0
>     kvm_arch_vcpu_ioctl_run+0xd81/0x1c70
>     kvm_vcpu_ioctl+0x267/0x670
>     __x64_sys_ioctl+0x83/0xa0
>     do_syscall_64+0x56/0x80
>     entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: linux-mm@kvack.org
> Reported-by: Darrick J. Wong <djwong@kernel.org>
> Reported-by: Stephen <stephenackerman16@gmail.com>
> Tested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   include/linux/secretmem.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> index 21c3771e6a56..988528b5da43 100644
> --- a/include/linux/secretmem.h
> +++ b/include/linux/secretmem.h
> @@ -23,7 +23,7 @@ static inline bool page_is_secretmem(struct page *page)
>   	mapping = (struct address_space *)
>   		((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
>   
> -	if (mapping != page->mapping)
> +	if (!mapping || mapping != page->mapping)
>   		return false;
>   
>   	return mapping->a_ops == &secretmem_aops;
> 

I assume we want to add

Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Cc: <stable@vger.kernel.org> # v5.14

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

