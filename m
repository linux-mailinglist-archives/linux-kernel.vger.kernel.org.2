Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF863F13FB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbhHSHC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234618AbhHSHCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629356504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhVHosNfawIyQK5RmFK8SONJExNGksIgOyq5OVKNQ4c=;
        b=UPlQG1n74bsmxhnWSLNekkXAgaPUV460NvpOjzJXtAiOJdDrqneKDKs80AIUbTJ9bzWq9P
        ITtW8C7OA7bU7tOlQKYlxCbN0fqMnFdMRL3DYV9Voy41qivfEgjb8OqB0QHgh8I5ShYaVS
        0Q0IAf6utqBZg4tP8eRur0p116s7JFA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-BHw_me7JM6eeHewuJ8hRoQ-1; Thu, 19 Aug 2021 03:01:43 -0400
X-MC-Unique: BHw_me7JM6eeHewuJ8hRoQ-1
Received: by mail-wr1-f69.google.com with SMTP id q19-20020adfbb93000000b00156a96f5178so1357910wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 00:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xhVHosNfawIyQK5RmFK8SONJExNGksIgOyq5OVKNQ4c=;
        b=sWP5CA1sCLQorIAGazlBo/9VtFWEtSGDQrIjrl2boWuZKR1f2mnnnXfGjmokzKc8jG
         eV524aEriN7kSPNG7rRdfltP/x5EfkrbkK2Is1yiKH5ABr18VeES1pI8WZrUjmQkx/i5
         KvMqZiXHCRvgzmsH5m8su5NXakwhsWYGACdhYarqp2UQ+yyNIX9NUs6Y0tYzt3tejWmZ
         9836LgL6IXPxXTfBL9e3d9XUQyqSmmatlHDzMgnDvld23wH/rvvMMCffRdN+2uAfRt/A
         sygUTqd0Y2j+8ni6Fq1CMeXNBk6VygF1bxZJiyb3aJwsQ8j2IUgKfGIz5BjwLrSvsq0y
         RZiw==
X-Gm-Message-State: AOAM530xRr+Fr5tiFBsHxcYkvuxFQCa5a+efHB1PJV9QHTdgq5fNE3u3
        khSuU3wXEpowWIMbOzXiiIEHKAjzaoi5EbNIRPcF85vVrdoPjPtLRytNnd8F86iSYg8k/Is2Xuf
        Pl3R92pr1dKQQcwVN9j9rNKv1
X-Received: by 2002:adf:979d:: with SMTP id s29mr1814073wrb.264.1629356501820;
        Thu, 19 Aug 2021 00:01:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPgcRMOO9d5aL/kke4yL0+nCtx2qzOwpYP3VaQCsuq/+pt+iZrukIeGZIVhuF0VsLGshS14w==
X-Received: by 2002:adf:979d:: with SMTP id s29mr1814047wrb.264.1629356501621;
        Thu, 19 Aug 2021 00:01:41 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6bd1.dip0.t-ipconnect.de. [91.12.107.209])
        by smtp.gmail.com with ESMTPSA id k13sm1640202wms.33.2021.08.19.00.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 00:01:41 -0700 (PDT)
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <20210819031858.98043-7-zhengqi.arch@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 6/9] mm: free user PTE page table pages
Message-ID: <5aa3020c-fcf2-87bd-31fe-e2b5c2aafcf2@redhat.com>
Date:   Thu, 19 Aug 2021 09:01:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819031858.98043-7-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.21 05:18, Qi Zheng wrote:
> Some malloc libraries(e.g. jemalloc or tcmalloc) usually
> allocate the amount of VAs by mmap() and do not unmap
> those VAs. They will use madvise(MADV_DONTNEED) to free
> physical memory if they want. But the page tables do not
> be freed by madvise(), so it can produce many page tables
> when the process touches an enormous virtual address space.
> 
> The following figures are a memory usage snapshot of one
> process which actually happened on our server:
> 
>          VIRT:  55t
>          RES:   590g
>          VmPTE: 110g
> 
> As we can see, the PTE page tables size is 110g, while the
> RES is 590g. In theory, the process only need 1.2g PTE page
> tables to map those physical memory. The reason why PTE page
> tables occupy a lot of memory is that madvise(MADV_DONTNEED)
> only empty the PTE and free physical memory but doesn't free
> the PTE page table pages. So we can free those empty PTE page
> tables to save memory. In the above cases, we can save memory
> about 108g(best case). And the larger the difference between
> the size of VIRT and RES, the more memory we save.
> 
> In this patch series, we add a pte_refcount field to the
> struct page of page table to track how many users of PTE page
> table. Similar to the mechanism of page refcount, the user of
> PTE page table should hold a refcount to it before accessing.
> The PTE page table page will be freed when the last refcount
> is dropped.
> 
> While we access ->pte_refcount of a PTE page table, any of the
> following ensures the pmd entry corresponding to the PTE page
> table stability:
> 
> 	- mmap_lock
> 	- anon_lock
> 	- i_mmap_lock
> 	- parallel threads are excluded by other means which
> 	  can make ->pmd stable(e.g. gup case)
> 
> This patch does not support THP temporarily, it will be
> supported in the next patch.

Can you clarify (and document here) who exactly takes a reference on the 
page table? Do I understand correctly that

a) each !pte_none() entry inside a page table take a reference to the 
page it's containted in.
b) each page table walker temporarily grabs a page table reference
c) The PMD tables the PTE is referenced in (->currently only ever a 
single one) does *not* take a reference.

So if there are no PTE entries left and nobody walks the page tables, 
you can remove it? You should really extend the 
description/documentation to make it clearer how exactly it's supposed 
to work.


It feels kind of strange to not introduce the CONFIG_FREE_USER_PTE 
Kconfig option in this patch. At least it took me a while to identify it 
in the previous patch.

Maybe you should introduce the empty stubs and use them in a separate 
patch, and then have this patch just introduce CONFIG_FREE_USER_PTE 
along with the actual refcounting magic inside the !stub implementation.

-- 
Thanks,

David / dhildenb

