Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7926132D80D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbhCDQsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:48:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238327AbhCDQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614876419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZB1BYdhnS28mvVlHU1SQfHJ74JIHfhkk8EnsSzDlslM=;
        b=G3GVNHhzO+wnxhQfPz08B/vRtEAXOqd6o6y5JLD+64CESm5eIQGUPfE1BMEgEv4COmsIYS
        EDVUJQOuL+gFk6louiHgtj1DnbFfxtJgvtozWbcdzHUj87hF7hhg+oOt1K+aqyhZy6dnRr
        QslCFpPRMqxVRx04UfjGITSB9PcaAN8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-ddN1yo0aMwyazPvLatloLw-1; Thu, 04 Mar 2021 11:46:56 -0500
X-MC-Unique: ddN1yo0aMwyazPvLatloLw-1
Received: by mail-qv1-f71.google.com with SMTP id q104so20962926qvq.20
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 08:46:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZB1BYdhnS28mvVlHU1SQfHJ74JIHfhkk8EnsSzDlslM=;
        b=NEXfWV9egDqUkOFdAiw4OF+U7ukfioc8/X4Os3Jnc1fSGQHJa6DkAKCizBu/P+KSfO
         0inCjtDBYIP3WbaOtJG8MOtvq1viLGvQ2W43MkEiMX+y6Md4H2DtVVLkOEzC5WVwl4M5
         U2DKYGxDhEqtt3LbZ+FyqU5nPiCxL2HPbkJCmNjEbcQfBiosy5svQVShwY5PVO1sq61x
         luQ6kL3HHQL5hgUlLgfhfsfo2BFkMGTIDK219zDFBj169HIIT50fOsyooVa+a1MZwIYE
         nmASlCvlQG4kO8HomS9YEaJyOo5zxMBIVqNPXMvIEDutJxXMcEEo8sC5Os0mT4ED7qUl
         euiQ==
X-Gm-Message-State: AOAM532OMbaMhD/8oAWpZVrxs5++uVCMWWIbfjBCv1Cz2D5juQJMg1bC
        ZF0flPYn6MSFvkVGRAZ7q0WVaEuQ+Lq1EUX5uNyB32E49gi3mnQaHbielyLpvxGnOiXNfq36ZuC
        AZDhKpdlc5IekLHzqbfRtM3t7
X-Received: by 2002:ac8:1209:: with SMTP id x9mr4114057qti.89.1614876416135;
        Thu, 04 Mar 2021 08:46:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYkIsLzg6JUUcyZVUmA4NY4lPA+155G5Kne2Lt5u80pP60k8ZWh3uE4h4ro2+NZCPvyt/Low==
X-Received: by 2002:ac8:1209:: with SMTP id x9mr4114023qti.89.1614876415803;
        Thu, 04 Mar 2021 08:46:55 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id e15sm51099qtp.58.2021.03.04.08.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 08:46:54 -0800 (PST)
Date:   Thu, 4 Mar 2021 11:46:53 -0500
From:   Peter Xu <peterx@redhat.com>
To:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 1/4] hugetlb: Pass vma into huge_pte_alloc() and
 huge_pmd_share()
Message-ID: <20210304164653.GB397383@xz-x1>
References: <20210218230633.15028-2-peterx@redhat.com>
 <202103050012.xQIxbA9h-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202103050012.xQIxbA9h-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 12:31:00AM +0800, kernel test robot wrote:
> Hi Peter,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on linux/master linus/master v5.12-rc1 next-20210304]
> [cannot apply to hnaz-linux-mm/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Peter-Xu/hugetlb-Disable-huge-pmd-unshare-for-uffd-wp/20210219-071334
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> config: mips-randconfig-m031-20210304 (attached as .config)
> compiler: mipsel-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/7ede06d6f63e59db4b9dee54f78eeac0c9ca17e4
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Peter-Xu/hugetlb-Disable-huge-pmd-unshare-for-uffd-wp/20210219-071334
>         git checkout 7ede06d6f63e59db4b9dee54f78eeac0c9ca17e4
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> mm/hugetlb.c:5376:8: error: conflicting types for 'huge_pmd_share'
>     5376 | pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct vma,
>          |        ^~~~~~~~~~~~~~
>    In file included from mm/hugetlb.c:39:
>    include/linux/hugetlb.h:155:8: note: previous declaration of 'huge_pmd_share' was here
>      155 | pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>          |        ^~~~~~~~~~~~~~
> 
> 
> vim +/huge_pmd_share +5376 mm/hugetlb.c
> 
>   5343	
>   5344	/*
>   5345	 * unmap huge page backed by shared pte.
>   5346	 *
>   5347	 * Hugetlb pte page is ref counted at the time of mapping.  If pte is shared
>   5348	 * indicated by page_count > 1, unmap is achieved by clearing pud and
>   5349	 * decrementing the ref count. If count == 1, the pte page is not shared.
>   5350	 *
>   5351	 * Called with page table lock held and i_mmap_rwsem held in write mode.
>   5352	 *
>   5353	 * returns: 1 successfully unmapped a shared pte page
>   5354	 *	    0 the underlying pte page is not shared, or it is the last user
>   5355	 */
>   5356	int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>   5357						unsigned long *addr, pte_t *ptep)
>   5358	{
>   5359		pgd_t *pgd = pgd_offset(mm, *addr);
>   5360		p4d_t *p4d = p4d_offset(pgd, *addr);
>   5361		pud_t *pud = pud_offset(p4d, *addr);
>   5362	
>   5363		i_mmap_assert_write_locked(vma->vm_file->f_mapping);
>   5364		BUG_ON(page_count(virt_to_page(ptep)) == 0);
>   5365		if (page_count(virt_to_page(ptep)) == 1)
>   5366			return 0;
>   5367	
>   5368		pud_clear(pud);
>   5369		put_page(virt_to_page(ptep));
>   5370		mm_dec_nr_pmds(mm);
>   5371		*addr = ALIGN(*addr, HPAGE_SIZE * PTRS_PER_PTE) - HPAGE_SIZE;
>   5372		return 1;
>   5373	}
>   5374	#define want_pmd_share()	(1)
>   5375	#else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
> > 5376	pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct vma,
>   5377			      unsigned long addr, pud_t *pud)
>   5378	{
>   5379		return NULL;
>   5380	}
>   5381	

Sorry for this!  I think we need to squash below into this patch for
!CONFIG_ARCH_WANT_HUGE_PMD_SHARE:

-----8<-----
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fc62932c31cb..94ac419f88cd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5415,7 +5415,7 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 }
 
 #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
-pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct vma,
+pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
                      unsigned long addr, pud_t *pud)
 {
        return NULL;
-----8<-----

Andrew, please kindly let me know when a repost is needed.

Thanks,

-- 
Peter Xu

