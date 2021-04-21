Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99377366FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241651AbhDUQEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:04:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235921AbhDUQEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619021039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o5xCsnUmbDkLK6Ie7CD9WdC/xTFrBc/CtLYnez0aj5Y=;
        b=gkHtfjJiYc7yKzE9xCtxfm29q6c+/ii0RW/xCht1Rlqtj4GEMe1SRy4pbQQqjsOCNiSoa3
        vHUjok9Oon49dlm1Ua2/XWReIVFoqxxDQ3dXD+3X0bmzVYAVBV4BufVPD9soimDpIPedKc
        igzEzuOkkK+uQjZIcZ02aBNRNSfQ5uo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-Jz3bE2cPNRiFTtp8f3fWVQ-1; Wed, 21 Apr 2021 12:03:56 -0400
X-MC-Unique: Jz3bE2cPNRiFTtp8f3fWVQ-1
Received: by mail-qv1-f69.google.com with SMTP id y14-20020a0cf14e0000b029019ff951fd16so12979285qvl.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 09:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o5xCsnUmbDkLK6Ie7CD9WdC/xTFrBc/CtLYnez0aj5Y=;
        b=jKuSjVipVmAGqyTyCk50cVY1gyKwfNKDN/cUv5A57dZEolE1Lg2V1pfnvyF/ZhktPn
         C1VGUmEo+QGY55BF7i5c23WABTJW+TVjW3bwkdUOukhatyEvppDMbwFbtkGvp0gxIXgP
         CqaI+lhm2OPKMLnHWjsnjUg7YqEXlJKui0NSsRffFmDJR0vH7JnBVb1+1f3yULG4b/eR
         eY57iT7gEEwwCitejcUtRmSZtbHLOYODhhP2BCGrw4wT+Qz7HXyLafMZLS2gYWX2AwLc
         IHTmDegJoH6XbBro9jg1/TZfiTdZmUeWhipFPxz8l1d1/rGk9XvBiwhP5neo+qNluzq8
         iD+A==
X-Gm-Message-State: AOAM530/NKqgncu91fjKf+zq6YQIf20cov/IIxeIL/Hf0Btd21oYVkTl
        EIcxnAdFTKyFZyi/aGbI/ThO6fqWmTTX3iHkS8LPqqdwaPFcJoyHOa/XmCIfF6ZEaFc+Xz6TRpo
        hemzDRj6RmdlYgvyn0vpT4NARBmvLJcVmnlxks9dVLsv+W6FW9kWx+ZaNFuzRtfZqv/kE+it5OA
        ==
X-Received: by 2002:ac8:5c8b:: with SMTP id r11mr22745536qta.140.1619021035604;
        Wed, 21 Apr 2021 09:03:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4zpSg7GDpsVsL2VE+xrFr/rH2YDi3sobTtqGO1x+M1QPE5f/M4NNfiysX3RuyHXZmglEP6Q==
X-Received: by 2002:ac8:5c8b:: with SMTP id r11mr22745465qta.140.1619021035031;
        Wed, 21 Apr 2021 09:03:55 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id k127sm2394251qkc.88.2021.04.21.09.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 09:03:54 -0700 (PDT)
Date:   Wed, 21 Apr 2021 12:03:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/23] userfaultfd-wp: Support shmem and hugetlbfs
Message-ID: <20210421160352.GJ4440@xz-x1>
References: <20210323004912.35132-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 08:48:49PM -0400, Peter Xu wrote:
> This patchset is based on tag v5.12-rc3-mmots-2021-03-17-22-26.  To run the
> selftest, need to apply the two patches to fix minor mode page leak:
> 
> https://lore.kernel.org/lkml/20210322175132.36659-1-peterx@redhat.com/
> https://lore.kernel.org/lkml/20210322204836.1650221-1-axelrasmussen@google.com/
> 
> Since I didn't get any NACK in the previous RFC series for months, I decided to
> remove the RFC tag starting from this version, so this is v1 of uffd-wp support
> on shmem & hugetlb.
> 
> The whole series can also be found online [1].
> 
> The major comment I'd like to get is on the new idea of swap special pte.  That
> comes from suggestions from both Hugh and Andrea and I appreciated a lot for
> those discussions.
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
>     We used to have special swap entries, like migration entries, hw-poison
>     entries, device private entries, etc.
> 
>     Those "special swap entries" reside in the range that they need to be at least
>     swap entries first, and their types are decided by swp_type(entry).
> 
>     This patch introduces another idea called "special swap ptes".
> 
>     It's very easy to get confused against "special swap entries", but a speical
>     swap pte should never contain a swap entry at all.  It means, it's illegal to
>     call pte_to_swp_entry() upon a special swap pte.
> 
>     Make the uffd-wp special pte to be the first special swap pte.
> 
>     Before this patch, is_swap_pte()==true means one of the below:
> 
>        (a.1) The pte has a normal swap entry (non_swap_entry()==false).  For
>              example, when an anonymous page got swapped out.
> 
>        (a.2) The pte has a special swap entry (non_swap_entry()==true).  For
>              example, a migration entry, a hw-poison entry, etc.
> 
>     After this patch, is_swap_pte()==true means one of the below, where case (b) is
>     added:
> 
>      (a) The pte contains a swap entry.
> 
>        (a.1) The pte has a normal swap entry (non_swap_entry()==false).  For
>              example, when an anonymous page got swapped out.
> 
>        (a.2) The pte has a special swap entry (non_swap_entry()==true).  For
>              example, a migration entry, a hw-poison entry, etc.
> 
>      (b) The pte does not contain a swap entry at all (so it cannot be passed
>          into pte_to_swp_entry()).  For example, uffd-wp special swap pte.
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
>   shmem/userfaultfd: Take care of UFFDIO_COPY_MODE_WP
>   mm: Clear vmf->pte after pte_unmap_same() returns
>   mm/userfaultfd: Introduce special pte for unmapped file-backed mem
>   mm/swap: Introduce the idea of special swap ptes
>   shmem/userfaultfd: Handle uffd-wp special pte in page fault handler
>   mm: Drop first_index/last_index in zap_details
>   mm: Introduce zap_details.zap_flags
>   mm: Introduce ZAP_FLAG_SKIP_SWAP
>   mm: Pass zap_flags into unmap_mapping_pages()
>   shmem/userfaultfd: Persist uffd-wp bit across zapping for file-backed
>   shmem/userfaultfd: Allow wr-protect none pte for file-backed mem
>   shmem/userfaultfd: Allows file-back mem to be uffd wr-protected on thps
>   shmem/userfaultfd: Handle the left-overed special swap ptes
>   shmem/userfaultfd: Pass over uffd-wp special swap pte when fork()
> 
> Part (2): Hugetlb support, we need to disable huge pmd sharing for uffd-wp
> because not compatible just like uffd minor mode.  The rest is the changes
> required to teach hugetlbfs understand the special swap pte too that introduced
> with the uffd-wp change:
> 
>   hugetlb/userfaultfd: Hook page faults for uffd write protection
>   hugetlb/userfaultfd: Take care of UFFDIO_COPY_MODE_WP
>   hugetlb/userfaultfd: Handle UFFDIO_WRITEPROTECT
>   hugetlb: Pass vma into huge_pte_alloc()
>   hugetlb/userfaultfd: Forbid huge pmd sharing when uffd enabled
>   mm/hugetlb: Introduce huge version of special swap pte helpers
>   mm/hugetlb: Move flush_hugetlb_tlb_range() into hugetlb.h
>   hugetlb/userfaultfd: Unshare all pmds for hugetlbfs when register wp
>   hugetlb/userfaultfd: Handle uffd-wp special pte in hugetlb pf handler
>   hugetlb/userfaultfd: Allow wr-protect none ptes
>   hugetlb/userfaultfd: Only drop uffd-wp special pte if required
> 
> Part (3): Enable both features in code and test
> 
>   userfaultfd: Enable write protection for shmem & hugetlbfs
>   userfaultfd/selftests: Enable uffd-wp for shmem/hugetlbfs
> 
> Tests
> =========
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
> 
> [1] https://github.com/xzpeter/linux/tree/uffd-wp-shmem-hugetlbfs
> [2] https://github.com/LLNL/umap-apps
> [3] https://github.com/xzpeter/umap/tree/peter-shmem-hugetlbfs

Hugh, Mike, Andrew,

Any comment for this series?

Thanks,

-- 
Peter Xu

