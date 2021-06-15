Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49E83A7CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFOLGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhFOLG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:06:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A0CC0617AF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:04:23 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x24so20718799lfr.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=AR9qZ9nPf3y/DYti7LQfXe9NuHVDwgf+ocWHVKASceM=;
        b=R1M1EUfZxcte72PpHDhurkvvCCLD2ySQZ/mF+1iHxCElfsAKIstoqjl05WD/v3V3rV
         GSi3L0mEX2dAXDmh7BflXJ0cNhAcrQiKJU+vwGBLFwz91F4fFMz0njgaRXyUYXHpfbWT
         7LDBZ+9T9SyK7ZV00hdEtKf5OwVTvAvS3yvZcFn1CAjqsJlLJlbMA+kYQ6ZRgDerhVbe
         GnedPh8uxJTekmfy5LX3Dd4SPN0N4V2X+ZRP9p1uat7LXvRnXfE9YgYKZXlo3Tr2M0I4
         nLJoriTN1i4vtD9tIZJggM0t8DaGK3Skn4/hzSenjmA5QuWYNGb30E9T6vn0Me8KKF0A
         eO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=AR9qZ9nPf3y/DYti7LQfXe9NuHVDwgf+ocWHVKASceM=;
        b=CdNg/NZaDjR4JKXAvokW8fuefGC8DCHgZn5+RUzZqsUSjPdDswXjvfWfZFJULoDhxu
         M4FalkW0FDMQfo4CXsPa4gPGo86nbW7oVDuvst3VA/YGTCC9HGpKxmzoA6MrqsU4N7DT
         rf5KAPo2y/4maYqyzf42mq5bkjVK5FQvuzQhT1nvORzE3AwZNnF1ifsqQi1x7YcbXztb
         uBxcu0RrXWmCP9xxvAL1L0bqAiDieKXqFuIratW3LRAtmobk09B7oYycJhjg12zYe/Mq
         PcQM+HxBwqa1c4ZoVhqm4jrYxfOhBj2rkkGP6z4inKVYcStMY2+KpvAmoUSGjsWym/YF
         oEjg==
X-Gm-Message-State: AOAM531231TODdXxCXoG185CxDpywzHSVq4MmUq7Fn5zp8rMXy3DPM69
        OvwNR4Aly0OtBl0CsCzpHrAwcco3+HtBi+CRN7HbCQ==
X-Google-Smtp-Source: ABdhPJx4EMns+LSi3v/rh93wV9hZpyJgk+942FvO+OlhWp4SzZTldg5/YppsCthQaGzJoUm/b39bzKnZl7e9uCYfar8=
X-Received: by 2002:a05:6512:754:: with SMTP id c20mr15120356lfs.356.1623755059592;
 Tue, 15 Jun 2021 04:04:19 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Tue, 15 Jun 2021 13:03:53 +0200
Message-ID: <CAG48ez23q0Jy9cuVnwAe7t_fdhMk2S7N5Hdi-GLcCeq5bsfLxw@mail.gmail.com>
Subject: page refcount race between prep_compound_gigantic_page() and __page_cache_add_speculative()?
To:     Linux-MM <linux-mm@kvack.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Youquan Song <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

== short summary ==
sysfs/sysctl writes can invoke prep_compound_gigantic_page(), which
forcibly zeroes the refcount of a page with refcount >=1. in the
extremely rare case where the refcount is >1 because of a temporary
reference from concurrent __page_cache_add_speculative(), stuff will
probably blow up.


Because of John Hubbard's question on the "[PATCH v2] mm/gup: fix
try_grab_compound_head() race with split_huge_page()" thread
(https://lore.kernel.org/linux-mm/50d828d1-2ce6-21b4-0e27-fb15daa77561@nvidia.com/),
I was looking around in related code, and stumbled over this old
commit, whose changes are still present in the current kernel, and
which looks wrong to me.

I'm not currently planning to try to fix this (because I'm not
familiar with the compaction code and its interaction with the page
allocator); so if someone who is more familiar with this stuff wants
to pick this up, feel free to do so.


commit 58a84aa92723d1ac3e1cc4e3b0ff49291663f7e1
Author: Youquan Song <youquan.song@intel.com>
Date:   Thu Dec 8 14:34:18 2011 -0800

    thp: set compound tail page _count to zero

    Commit 70b50f94f1644 ("mm: thp: tail page refcounting fix") keeps all
    page_tail->_count zero at all times.  But the current kernel does not
    set page_tail->_count to zero if a 1GB page is utilized.  So when an
    IOMMU 1GB page is used by KVM, it wil result in a kernel oops because a
    tail page's _count does not equal zero.

      kernel BUG at include/linux/mm.h:386!
      invalid opcode: 0000 [#1] SMP
      Call Trace:
        gup_pud_range+0xb8/0x19d
        get_user_pages_fast+0xcb/0x192
        ? trace_hardirqs_off+0xd/0xf
        hva_to_pfn+0x119/0x2f2
        gfn_to_pfn_memslot+0x2c/0x2e
        kvm_iommu_map_pages+0xfd/0x1c1
        kvm_iommu_map_memslots+0x7c/0xbd
        kvm_iommu_map_guest+0xaa/0xbf
        kvm_vm_ioctl_assigned_device+0x2ef/0xa47
        kvm_vm_ioctl+0x36c/0x3a2
        do_vfs_ioctl+0x49e/0x4e4
        sys_ioctl+0x5a/0x7c
        system_call_fastpath+0x16/0x1b
      RIP  gup_huge_pud+0xf2/0x159

    Signed-off-by: Youquan Song <youquan.song@intel.com>
    Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
    Cc: <stable@vger.kernel.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bb28a5f9db8d..73f17c0293c0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -576,6 +576,7 @@ static void prep_compound_gigantic_page(struct
page *page, unsigned long order)
        __SetPageHead(page);
        for (i = 1; i < nr_pages; i++, p = mem_map_next(p, page, i)) {
                __SetPageTail(p);
+               set_page_count(p, 0);
                p->first_page = page;
        }
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9dd443d89d8b..850009a7101e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -356,8 +356,8 @@ void prep_compound_page(struct page *page,
unsigned long order)
        __SetPageHead(page);
        for (i = 1; i < nr_pages; i++) {
                struct page *p = page + i;
-
                __SetPageTail(p);
+               set_page_count(p, 0);
                p->first_page = page;
        }
 }



__page_cache_add_speculative() can run on pages that have already been
allocated, and the only thing that can stop it from temporarily
lifting the page refcount is the page refcount being zero. So if these
set_page_count() calls have any effect (outside __init code), and the
refcount is not zero when they occur, then that means we can have a
race where a refcount is forcibly zeroed while
__page_cache_add_speculative() is holding temporary references; and
then we can end up with a use-after-free of struct page.

As far as I can tell, on the normal compound page allocation path
(prep_compound_page()), the whole compound page is coming fresh off
the allocator freelist (except for some __init logic) and only the
refcount of the head page has been initialized in post_alloc_hook();
and so all its tail pages are guaranteed to have a zero refcount. So
on that path the proper fix is probably to just replace the
set_page_count() call with a VM_BUG_ON_PAGE().

The messier path, as the original commit describes, is "gigantic" page
allocation. In that case, we'll go through the following path (if we
ignore CMA):

  alloc_fresh_huge_page():
    alloc_gigantic_page()
      alloc_contig_pages()
        __alloc_contig_pages()
          alloc_contig_range()
            isolate_freepages_range()
              split_map_pages()
                post_alloc_hook() [FOR EVERY PAGE]
                  set_page_refcounted()
                    set_page_count(page, 1)
    prep_compound_gigantic_page()
      set_page_count(p, 0) [FOR EVERY TAIL PAGE]

so all the tail pages are initially allocated with refcount 1 by the
page allocator, and then we overwrite those refcounts with zeroes.


Luckily, the only non-__init codepath that can get here is
__nr_hugepages_store_common(), which is only invoked from privileged
writes to sysfs/sysctls.
