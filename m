Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2A03FDAC3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244101AbhIAMew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 08:34:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245725AbhIAMdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 08:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630499532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Dbvlu5ZSAjtRqG1EufqlUFTIvkyoUz8z7Cc+P05CuE=;
        b=DfwZjh2lGxeQQaF7DKVtU05jIxIl9veN/drFt8hmQzbhDWEoP/WKVIga9VKIVHrppREiE+
        ktoEBGSw+ocWto/vNd7djrM49k3tSTm+D9h5Klt6h9nkyxWcBXfzDCd+a+1NwF6hUB8LJA
        BB/GOJ98ZA9Hvgae11islIRcHkUPtDE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-Qeevcr5bMTGtJ4v3s9TtvA-1; Wed, 01 Sep 2021 08:32:11 -0400
X-MC-Unique: Qeevcr5bMTGtJ4v3s9TtvA-1
Received: by mail-wm1-f69.google.com with SMTP id u1-20020a05600c210100b002e74fc5af71so949641wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 05:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6Dbvlu5ZSAjtRqG1EufqlUFTIvkyoUz8z7Cc+P05CuE=;
        b=BSHuPlbheGehzISuJSGBtQXbVndo1i6PpYzLvDNiRCSyeDH9Ejg8u/pA8oggtgzIkb
         Scg1vo3r/hWF7tWk8fzJ+BdnNa3BHrS661ZcNUw3grKcPOxvlszHQLMzQGOPRGH9VP1s
         TpVzPu/5rhjP3N5stZmIrMMXYuEmBarEvGtQpUejHWz/FG7hpGbzdx11oYN2p67gr3Tn
         XGZJgaUAaMfaLGxvn0lH5la4pBTs/w1UljjnLoB66IhCrTlqrL8poH1Xrp/8pkg+qmeT
         lwvUO6Ksw0fARs7hLeuTvD84/uoWPie1Am5oCway+Zn3Imj1ljSF6iVYMsCe5MPcKI6S
         dsmg==
X-Gm-Message-State: AOAM531VIh2y8VimHOci2wg/NmKUrMvq68f6WEcux6ED/h24lAoCyuTc
        GEz0n9A/5xVGZFxu7kGTdl0zoL34eVLZ3aaafOvcGrSuIJRPajNXUBZZuRhePE/5DDkxiUb9tNk
        4cPgCEs99m5wMhjGiz0dpXuD8
X-Received: by 2002:adf:d239:: with SMTP id k25mr9857051wrh.314.1630499530023;
        Wed, 01 Sep 2021 05:32:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgQ3pleHAmLNS3ldiuaJSpYI6aLKAmT2AqtxZ6KQPbyagrUETSbVHG4/qEex808Z3/iRij4A==
X-Received: by 2002:adf:d239:: with SMTP id k25mr9857023wrh.314.1630499529802;
        Wed, 01 Sep 2021 05:32:09 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23f71.dip0.t-ipconnect.de. [79.242.63.113])
        by smtp.gmail.com with ESMTPSA id l15sm4846090wms.38.2021.09.01.05.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 05:32:09 -0700 (PDT)
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 0/9] Free user PTE page table pages
Message-ID: <5b9348fc-95fe-5be2-e9df-7c906e0c9b81@redhat.com>
Date:   Wed, 1 Sep 2021 14:32:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.21 05:18, Qi Zheng wrote:
> Hi,
> 
> This patch series aims to free user PTE page table pages when all PTE entries
> are empty.
> 
> The beginning of this story is that some malloc libraries(e.g. jemalloc or
> tcmalloc) usually allocate the amount of VAs by mmap() and do not unmap those VAs.
> They will use madvise(MADV_DONTNEED) to free physical memory if they want.
> But the page tables do not be freed by madvise(), so it can produce many
> page tables when the process touches an enormous virtual address space.
> 
> The following figures are a memory usage snapshot of one process which actually
> happened on our server:
> 
> 	VIRT:  55t
> 	RES:   590g
> 	VmPTE: 110g
> 
> As we can see, the PTE page tables size is 110g, while the RES is 590g. In
> theory, the process only need 1.2g PTE page tables to map those physical
> memory. The reason why PTE page tables occupy a lot of memory is that
> madvise(MADV_DONTNEED) only empty the PTE and free physical memory but
> doesn't free the PTE page table pages. So we can free those empty PTE page
> tables to save memory. In the above cases, we can save memory about 108g(best
> case). And the larger the difference between the size of VIRT and RES, the
> more memory we save.
> 
> In this patch series, we add a pte_refcount field to the struct page of page
> table to track how many users of PTE page table. Similar to the mechanism of
> page refcount, the user of PTE page table should hold a refcount to it before
> accessing. The PTE page table page will be freed when the last refcount is
> dropped.
> 
> Testing:
> 
> The following code snippet can show the effect of optimization:
> 
> 	mmap 50G
> 	while (1) {
> 		for (; i < 1024 * 25; i++) {
> 			touch 2M memory
> 			madvise MADV_DONTNEED 2M
> 		}
> 	}
> 
> As we can see, the memory usage of VmPTE is reduced:
> 
> 			before		                after
> VIRT		       50.0 GB			      50.0 GB
> RES		        3.1 MB			       3.6 MB
> VmPTE		     102640 kB			       248 kB
> 
> I also have tested the stability by LTP[1] for several weeks. I have not seen
> any crash so far.
> 
> The performance of page fault can be affected because of the allocation/freeing
> of PTE page table pages. The following is the test result by using a micro
> benchmark[2]:
> 
> root@~# perf stat -e page-faults --repeat 5 ./multi-fault $threads:
> 
> threads         before (pf/min)                     after (pf/min)
>      1                32,085,255                         31,880,833 (-0.64%)
>      8               101,674,967                        100,588,311 (-1.17%)
>     16               113,207,000                        112,801,832 (-0.36%)
> 
> (The "pfn/min" means how many page faults in one minute.)
> 
> The performance of page fault is ~1% slower than before.
> 
> This series is based on next-20210812.
> 
> Comments and suggestions are welcome.
> 
> Thanks,
> Qi.
> 


Some high-level feedback after studying the code:

1. Try introducing the new dummy primitives ("API") first, and then 
convert each subsystem individually; especially, maybe convert the whole 
pagefault handling in a single patch, because it's far from trivial. 
This will make this series much easier to digest.

Then, have a patch that adds actual logic to the dummy primitives via a 
config option.

2. Minimize the API.

a) pte_alloc_get{,_map,_map_lock}() is really ugly. Maybe restrict it to 
pte_alloc_get().

b) pmd_trans_unstable_or_pte_try_get() and friends are really ugly.

Handle it independently for now, even if it implies duplicate runtime 
checks.

if (pmd_trans_unstable() || !pte_try_get()) ...

We can always optimize later, once we can come up with something cleaner.

3. Merge #6, and #7, after factoring out all changes to other subsystems 
to use the API

4. Merge #8 into #6. There is a lot of unnecessary code churn back and 
forth, and IMHO the whole approach might not make sense without RCU due 
to the additional locking overhead.

Or at least, try to not modify the API you introduced in patch #6 or #7 
in #8 again. Converting all call sites back and forth just makes review 
quite hard.


I am preparing some some cleanups that will make get_locked_pte() and 
similar a little nicer to handle. I'll send them out this or next week.

-- 
Thanks,

David / dhildenb

