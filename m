Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB143CED91
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385740AbhGSTIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1384935AbhGSSlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626722482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTwq4PuX2DzHsZtvOO0BQjYNFm+9mjIm5nAUk4EcBYk=;
        b=iyUM+VhAaBggTiZOwy03jtKuLoZFScNH0QW/p+0/jDlELixHycY4FGtWsjB4ajbZm+U0oz
        pPxGiSbrzNO7hUGBdMl9KHXBvFvoh/WYnErEpbnIk1ri7O/cOzNWI+Wp9mbEroJsnRj38u
        BDQCtnb/whg8acegHFeCO1SyJQnCFnE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-MKklWKgmMsCUY88pUXXW1A-1; Mon, 19 Jul 2021 15:21:21 -0400
X-MC-Unique: MKklWKgmMsCUY88pUXXW1A-1
Received: by mail-wm1-f69.google.com with SMTP id g13-20020a05600c4ecdb0290242a8f4cf9cso423733wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bTwq4PuX2DzHsZtvOO0BQjYNFm+9mjIm5nAUk4EcBYk=;
        b=WKxePNtve/W+LTj5iMqsEeZqgDecGi1bHclPP8WbNcdsc0ZnD9qxsl5arodiZrho/C
         FhS6qmI/icPG+CB5gCIPEEaNzN3C0mrn7GxoCC3aRSwPCWysjCOMzDCoICqkFtt7T3YE
         w9V0fV0vpdN93F+woLbOQnhVKZ3laMIdjQlHWoEE22AO+o85qCR+BSlEoxhrIQv9YROJ
         sXCC0q+Z9xdlEe77XcWuoIRZnVVtWAxghG98+wmxraK9//bl0iM4HgFWtiLIMaSEPbx+
         yiOOy0bDzFf9dHk778Gy7/t5QVAwzblCGEuYFYC4GwlmpYlB7xECYCuC3RkJ1LRSEHMb
         T+sQ==
X-Gm-Message-State: AOAM533AvSkNTWzXSwIjAheJlWJgdHkjobAfzNUponk1ZlBuzlIG5wDO
        uWh9J4BB3PjpZvYrgZT6W14v8X+R2+dYR8ZfwCYWVYl4GlJtOfYAgCCMYVUOCFrAYZLZDslpacb
        +fBuQZxPqw2xNTMMTAQDKstjQ
X-Received: by 2002:a05:6000:10d0:: with SMTP id b16mr5980504wrx.332.1626722479903;
        Mon, 19 Jul 2021 12:21:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHS0AwxkuMU+B+rIqWnOeSf01dX6b1TkG+iLkkBuz0iDHECPP6ZWmOrT1DQ9QifA6xEGP3ig==
X-Received: by 2002:a05:6000:10d0:: with SMTP id b16mr5980475wrx.332.1626722479595;
        Mon, 19 Jul 2021 12:21:19 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id n16sm21493126wrr.73.2021.07.19.12.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 12:21:19 -0700 (PDT)
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>
References: <20210715201422.211004-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 00/26] userfaultfd-wp: Support shmem and hugetlbfs
Message-ID: <251ed5e3-d898-efdc-ca5c-7b047dc80cb4@redhat.com>
Date:   Mon, 19 Jul 2021 21:21:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.21 22:13, Peter Xu wrote:
> This is v5 of uffd-wp shmem & hugetlbfs support, which completes uffd-wp as a
> full feature.  It's based on v5.14-rc1.
> 
> I reposted the whole series majorly to trigger the syzbot tests again; sorry if
> it brings a bit of noise.  Please let me know if there's easier way to trigger
> the syzbot test instead of reposting the whole series.
> 
> Meanwhile, recently discussion around soft-dirty shows that soft-dirty may have
> similar requirement as uffd-wp on persisting the dirty information:
> 
> https://lore.kernel.org/lkml/20210714152426.216217-1-tiberiu.georgescu@nutanix.com/
> 
> Then the mechanism provided in this patchset may be suitable for soft-dirty too.
> 
> The whole series can also be found online [1].
> 
> v5 changelog:
> - Fix two issues spotted by syzbot
> - Compile test with (1) !USERFAULTFD, (2) USERFAULTFD && !USERFAULTFD_WP
> 
> Previous versions:
> 
> RFC: https://lore.kernel.org/lkml/20210115170907.24498-1-peterx@redhat.com/
> v1:  https://lore.kernel.org/lkml/20210323004912.35132-1-peterx@redhat.com/
> v2:  https://lore.kernel.org/lkml/20210427161317.50682-1-peterx@redhat.com/
> v3:  https://lore.kernel.org/lkml/20210527201927.29586-1-peterx@redhat.com/
> v4:  https://lore.kernel.org/lkml/20210714222117.47648-1-peterx@redhat.com/
> 
> About Swap Special PTE
> ======================
> 
> In short, the so-called "swap special pte" in this patchset is a new type of
> pte that doesn't exist in the past, but it got used initially in this series in
> file-backed memories.  It is used to persist information even if the ptes got
> dropped meanwhile when the page cache still existed.  For example, when
> splitting a file-backed huge pmd, we could be simply dropping the pmd entry
> then wait until another fault coming.  It's okay in the past since all
> information in the pte can be retained from the page cache when the next page
> fault triggers.  However in this case, uffd-wp is per-pte information which
> cannot be kept in page cache, so that information needs to be maintained
> somehow still in the pgtable entry, even if the pgtable entry is going to be
> dropped.  Here instead of replacing with a none entry, we used the "swap
> special pte".  Then when the next page fault triggers, we can observe orig_pte
> to retain this information.
> 
> I'm copy-pasting some commit message from the patch "mm/swap: Introduce the
> idea of special swap ptes", where it tried to explain this pte in another angle:
> 
>      We used to have special swap entries, like migration entries, hw-poison
>      entries, device private entries, etc.
> 
>      Those "special swap entries" reside in the range that they need to be at least
>      swap entries first, and their types are decided by swp_type(entry).
> 
>      This patch introduces another idea called "special swap ptes".
> 
>      It's very easy to get confused against "special swap entries", but a speical
>      swap pte should never contain a swap entry at all.  It means, it's illegal to
>      call pte_to_swp_entry() upon a special swap pte.
> 
>      Make the uffd-wp special pte to be the first special swap pte.
> 
>      Before this patch, is_swap_pte()==true means one of the below:
> 
>         (a.1) The pte has a normal swap entry (non_swap_entry()==false).  For
>               example, when an anonymous page got swapped out.
> 
>         (a.2) The pte has a special swap entry (non_swap_entry()==true).  For
>               example, a migration entry, a hw-poison entry, etc.
> 
>      After this patch, is_swap_pte()==true means one of the below, where case (b) is
>      added:
> 
>       (a) The pte contains a swap entry.
> 
>         (a.1) The pte has a normal swap entry (non_swap_entry()==false).  For
>               example, when an anonymous page got swapped out.
> 
>         (a.2) The pte has a special swap entry (non_swap_entry()==true).  For
>               example, a migration entry, a hw-poison entry, etc.
> 
>       (b) The pte does not contain a swap entry at all (so it cannot be passed
>           into pte_to_swp_entry()).  For example, uffd-wp special swap pte.
> 
> Hugetlbfs needs similar thing because it's also file-backed.  I directly reused
> the same special pte there, though the shmem/hugetlb change on supporting this
> new pte is different since they don't share code path a lot.
> 
> Patch layout
> ============
> 
> Part (1): Shmem support, this is where the special swap pte is introduced.
> Some zap rework is needed within the process:
> 
>    mm/shmem: Unconditionally set pte dirty in mfill_atomic_install_pte
>    shmem/userfaultfd: Take care of UFFDIO_COPY_MODE_WP
>    mm: Clear vmf->pte after pte_unmap_same() returns
>    mm/userfaultfd: Introduce special pte for unmapped file-backed mem
>    mm/swap: Introduce the idea of special swap ptes
>    shmem/userfaultfd: Handle uffd-wp special pte in page fault handler
>    mm: Drop first_index/last_index in zap_details
>    mm: Introduce zap_details.zap_flags
>    mm: Introduce ZAP_FLAG_SKIP_SWAP
>    shmem/userfaultfd: Persist uffd-wp bit across zapping for file-backed
>    shmem/userfaultfd: Allow wr-protect none pte for file-backed mem
>    shmem/userfaultfd: Allows file-back mem to be uffd wr-protected on thps
>    shmem/userfaultfd: Handle the left-overed special swap ptes
>    shmem/userfaultfd: Pass over uffd-wp special swap pte when fork()
> 
> Part (2): Hugetlb supportdisable huge pmd sharing for uffd-wp patches have been
> merged.  The rest is the changes required to teach hugetlbfs understand the
> special swap pte too that introduced with the uffd-wp change:
> 
>    mm/hugetlb: Drop __unmap_hugepage_range definition from hugetlb.h
>    mm/hugetlb: Introduce huge pte version of uffd-wp helpers
>    hugetlb/userfaultfd: Hook page faults for uffd write protection
>    hugetlb/userfaultfd: Take care of UFFDIO_COPY_MODE_WP
>    hugetlb/userfaultfd: Handle UFFDIO_WRITEPROTECT
>    mm/hugetlb: Introduce huge version of special swap pte helpers
>    hugetlb/userfaultfd: Handle uffd-wp special pte in hugetlb pf handler
>    hugetlb/userfaultfd: Allow wr-protect none ptes
>    hugetlb/userfaultfd: Only drop uffd-wp special pte if required
> 
> Part (3): Enable both features in code and test (plus pagemap support)
> 
>    mm/pagemap: Recognize uffd-wp bit for shmem/hugetlbfs
>    userfaultfd: Enable write protection for shmem & hugetlbfs
>    userfaultfd/selftests: Enable uffd-wp for shmem/hugetlbfs
> 
> Tests
> =====
> 
> I've tested it using either userfaultfd kselftest program, but also with
> umapsort [2] which should be even stricter.  Tested page swapping in/out during
> umapsort.
> 
> If anyone would like to try umapsort, need to use an extremely hacked version
> of umap library [3], because by default umap only supports anonymous.  So to
> test it we need to build [3] then [2].
> 
> Any comment would be greatly welcomed.  Thanks,

Hi Peter,

I just stumbled over copy_page_range() optimization

	/*
	 * Don't copy ptes where a page fault will fill them correctly.
	 * Fork becomes much lighter when there are big shared or private
	 * readonly mappings. The tradeoff is that copy_page_range is more
	 * efficient than faulting.
	 */
	if (!(src_vma->vm_flags & (VM_HUGETLB | VM_PFNMAP | VM_MIXEDMAP)) &&
	    !src_vma->anon_vma)
		return 0;

IIUC, that means you'll not copy the WP bits for shmem and,
therefore, lose them during fork.

-- 
Thanks,

David / dhildenb

