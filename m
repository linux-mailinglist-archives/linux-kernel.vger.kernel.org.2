Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498A23F0EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbhHRXgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbhHRXgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:36:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF28C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:35:35 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so10042452pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CEDt8NCOEZPB4Z7GfSGC0FbxHSA8ztMo7IcRwvzT4BI=;
        b=SR4m4E/MHymIkai28JekEjKq7IQWgZWSMRh51nmSYdvwdSjmhOuJ1pEWXcrwl1C+NE
         29V2FoIoc7p01XeAitz1B19TuyKelxwIWwGMtl7xiF6uy8AXN3EmHxRNhCRNgq22yaC9
         snDPk6wGCyKEzqnSM+LkQgz4rTp8LHAsQX6sONjGDtCPPrlv+PkZmxPtSP56jDs1CBja
         aI7AlPOcFGUtlRpWi6qIexgzojQY9PREHyztwsNPsbuAo6pfzFrPgespRZ41/w25TYiW
         vi4GVEfHhMRCkBfwlWpAYM/oGCxMoJARfvTE/Hoi6w4ge16lSmB3qpegdBGYBsvREyGc
         eRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CEDt8NCOEZPB4Z7GfSGC0FbxHSA8ztMo7IcRwvzT4BI=;
        b=CodLrsCcd0ibHwrOAdgD2t3RMlgrKjhYZNLJ+Dz1AagjJTzaSPDvUAP6OKHTUrdMJy
         hSRYnIHMAJ8V+SMJTo6h0J8H+viVIMOrsdyCKhmFAfCaZxn852tgqBthFlxIRKAc+3vZ
         vTF+fO+UyWSApnGCWBfKJnbYvvB/CBXzZnW3FA2sso7lIQRcC1G+zVMiXiC07P6YIUNN
         gFDcxcw37v4j2D9CUkUJndunlY5d6y8oprI8eFnAdp+0Pofz+Uer4JCrXzLX/PpeIb7F
         5I6pGC5OoL7L1KpIumlFmTt8Y+AGqbKJuoOy+SjrftIH7FaA3LeSdvQsZ/EuI4VmDyf9
         epbQ==
X-Gm-Message-State: AOAM530apiFdXAu5YpEDAmqFfk+JQ9WHMawqTwuPSBW3U6TMB3lgFuez
        8qL4nd5fgNz8D/ZAnjU0VEOwV502jxHQlvCwX2xiwQ==
X-Google-Smtp-Source: ABdhPJwjBNC4/JTsF2CgndVSRumkPBfBb9COWWHvpFmQ8sm4i8um4Nk6c06yw4s3heDZN7vnnJdtIICpS9tGioSyPvM=
X-Received: by 2002:a17:90b:4a91:: with SMTP id lp17mr2608702pjb.24.1629329734926;
 Wed, 18 Aug 2021 16:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210811011056.770351-1-almasrymina@google.com> <9f76b103-ba81-d4e3-1071-89009fb585a5@oracle.com>
In-Reply-To: <9f76b103-ba81-d4e3-1071-89009fb585a5@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 18 Aug 2021 16:35:23 -0700
Message-ID: <CAHS8izOkTPYUn5aLYtma=YTAm6yYYraL7AqXjjC4hiqLXXSB-g@mail.gmail.com>
Subject: Re: [PATCH v2] mm, hugepages: add mremap() support for hugepage
 backed vma
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ken Chen <kenchen@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 4:40 PM Mike Kravetz <mike.kravetz@oracle.com> wrot=
e:
>
> Adding Michal, Vlastimil and Kirill as adding this type of support
> was discussed in this thread:
> https://lore.kernel.org/linux-mm/3ba05809-63a2-2969-e54f-fd0202fe336b@gmx=
.de/
>

Ack. I haven't gone through that thread but if there are any concerns
with what I whipped up here, do let me know.

> On 8/10/21 6:10 PM, Mina Almasry wrote:
> > Support mremap() for hugepage backed vma segment by simply repositionin=
g
> > page table entries. The page table entries are repositioned to the new
> > virtual address on mremap().
> >
> > Hugetlb mremap() support is of course generic; my motivating use case
> > is a library (hugepage_text), which reloads the ELF text of executables
> > in hugepages. This significantly increases the execution performance of
> > said executables.
> >
> > Restricts the mremap operation on hugepages to up to the size of the
> > original mapping as the underlying hugetlb reservation is not yet
> > capable of handling remapping to a larger size.
>
> We will need to document this in the man page.
>

I looked up how to do that and it seems easy enough. I assume when
this patch is picked up by Andrew and looks to be on its way to
mainstream then I'll submit a patch to update the docs, yes? Let me
know if you want to see it now.

> >
> > During the mremap() operation we detect pmd_share'd mappings and we
> > unshare those during the mremap(). On access and fault the sharing is
> > established again.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Ken Chen <kenchen@google.com>
> > Cc: Chris Kennelly <ckennelly@google.com>
> >
> > ---
> >
> > Changes in v2:
> > - Re-wrote comment around clear_vma_resv_huge_pages() to make it clear
> > that the resv_map has been moved to the new VMA and why we need to clea=
r it
> > from the current VMA.
> > - We detect huge_pmd_shared() pte's and unshare those rather than bug o=
n
> > hugetlb_vma_shareable().
> > - This case now returns EFAULT:
> >  if (!vma || vma->vm_start > addr)
> >              goto out;
> > - Added kselftests for mremap() support.
> >
> > ---
> >  include/linux/hugetlb.h                      |  24 +++
> >  mm/hugetlb.c                                 | 125 +++++++++++++-
> >  mm/mremap.c                                  |  30 +++-
> >  tools/testing/selftests/vm/.gitignore        |   1 +
> >  tools/testing/selftests/vm/Makefile          |   1 +
> >  tools/testing/selftests/vm/hugepage-mremap.c | 163 +++++++++++++++++++
> >  tools/testing/selftests/vm/userfaultfd.c     |   0
>
> I don't think you intended to submit a mode change to userfaultfd.c?
>

Sorry, removed.

> I would prefer to see the testing changes in a separate patch.
>

Will be fixed in v3.

> >  7 files changed, 337 insertions(+), 7 deletions(-)
> >  create mode 100644 tools/testing/selftests/vm/hugepage-mremap.c
> >  mode change 100644 =3D> 100755 tools/testing/selftests/vm/userfaultfd.=
c
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index f7ca1a3870ea5..62da774802715 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -124,6 +124,7 @@ struct hugepage_subpool *hugepage_new_subpool(struc=
t hstate *h, long max_hpages,
> >  void hugepage_put_subpool(struct hugepage_subpool *spool);
> >
> >  void reset_vma_resv_huge_pages(struct vm_area_struct *vma);
> > +void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
> >  int hugetlb_sysctl_handler(struct ctl_table *, int, void *, size_t *, =
loff_t *);
> >  int hugetlb_overcommit_handler(struct ctl_table *, int, void *, size_t=
 *,
> >               loff_t *);
> > @@ -132,6 +133,8 @@ int hugetlb_treat_movable_handler(struct ctl_table =
*, int, void *, size_t *,
> >  int hugetlb_mempolicy_sysctl_handler(struct ctl_table *, int, void *, =
size_t *,
> >               loff_t *);
> >
> > +int move_hugetlb_page_tables(struct vm_area_struct *vma, unsigned long=
 old_addr,
> > +                          unsigned long new_addr, unsigned long len);
> >  int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, st=
ruct vm_area_struct *);
> >  long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
> >                        struct page **, struct vm_area_struct **,
> > @@ -190,6 +193,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
> >                      unsigned long addr, unsigned long sz);
> >  int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
> >                               unsigned long *addr, pte_t *ptep);
> > +int huge_pmd_shared(struct vm_area_struct *vma, pte_t *ptep);
> >  void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
> >                               unsigned long *start, unsigned long *end)=
;
> >  struct page *follow_huge_addr(struct mm_struct *mm, unsigned long addr=
ess,
> > @@ -211,6 +215,8 @@ unsigned long hugetlb_change_protection(struct vm_a=
rea_struct *vma,
> >
> >  bool is_hugetlb_entry_migration(pte_t pte);
> >  void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
> > +bool hugetlb_vma_shareable(struct vm_area_struct *vma, unsigned long a=
ddr);
> > +
> >
> >  #else /* !CONFIG_HUGETLB_PAGE */
> >
> > @@ -218,6 +224,10 @@ static inline void reset_vma_resv_huge_pages(struc=
t vm_area_struct *vma)
> >  {
> >  }
> >
> > +static inline void clear_vma_resv_huge_pages(struct vm_area_struct *vm=
a)
> > +{
> > +}
> > +
> >  static inline unsigned long hugetlb_total_pages(void)
> >  {
> >       return 0;
> > @@ -229,6 +239,10 @@ static inline struct address_space *hugetlb_page_m=
apping_lock_write(
> >       return NULL;
> >  }
> >
> > +static int huge_pmd_shared(struct vm_area_struct *vma, pte_t *ptep) {
> > +     return 0;
> > +}
> > +
> >  static inline int huge_pmd_unshare(struct mm_struct *mm,
> >                                       struct vm_area_struct *vma,
> >                                       unsigned long *addr, pte_t *ptep)
> > @@ -265,6 +279,12 @@ static inline int copy_hugetlb_page_range(struct m=
m_struct *dst,
> >       return 0;
> >  }
> >
> > +#define move_hugetlb_page_tables(vma, old_addr, new_addr, len)        =
         \
> > +     ({                                                               =
      \
> > +             BUG();                                                   =
      \
> > +             0;                                                       =
      \
> > +     })
> > +
> >  static inline void hugetlb_report_meminfo(struct seq_file *m)
> >  {
> >  }
> > @@ -402,6 +422,10 @@ static inline vm_fault_t hugetlb_fault(struct mm_s=
truct *mm,
> >
> >  static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma=
) { }
> >
> > +bool hugetlb_vma_shareable(struct vm_area_struct *vma, unsigned long a=
ddr) {
> > +     return 0;
> > +}
> > +
> >  #endif /* !CONFIG_HUGETLB_PAGE */
> >  /*
> >   * hugepages at page global directory. If arch support
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 528947da65c8f..aac3308037ae4 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1004,6 +1004,35 @@ void reset_vma_resv_huge_pages(struct vm_area_st=
ruct *vma)
> >               vma->vm_private_data =3D (void *)0;
> >  }
> >
> > +/*
> > + * Reset and decrement one ref on hugepage private reservation.
> > + * Called with mm->mmap_sem writer semaphore held.
> > + * This function should be only used by move_vma() and operate on
> > + * same sized vma. It should never come here with last ref on the
> > + * reservation.
> > + */
> > +void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
> > +{
> > +     /*
> > +      * Clear the old hugetlb private page reservation.
> > +      * It has already been transferred to new_vma.
> > +      *
> > +      * During a mremap() operation of a hugetlb vma we call move_vma(=
)
> > +      * which copies *vma* into *new_vma* and unmaps *vma*. After the =
copy
> > +      * operation both *new_vma* and *vma* share a reference to the re=
sv_map
> > +      * struct, and at that point *vma* is about to be unmapped. We do=
n't
> > +      * want to return the reservation to the pool at unmap of *vma* b=
ecause
> > +      * the reservation still lives on in new_vma, so simply decrement=
 the
> > +      * ref here and remove the resv_map reference from this vma.
> > +      */
> > +     struct resv_map *reservations =3D vma_resv_map(vma);
> > +
> > +     if (reservations && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
> > +             kref_put(&reservations->refs, resv_map_release);
> > +
> > +     reset_vma_resv_huge_pages(vma);
> > +}
> > +
> >  /* Returns true if the VMA has associated reserve pages */
> >  static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
> >  {
> > @@ -4429,6 +4458,79 @@ int copy_hugetlb_page_range(struct mm_struct *ds=
t, struct mm_struct *src,
> >       return ret;
> >  }
> >
> > +static void move_huge_pte(struct vm_area_struct *vma, unsigned long ol=
d_addr,
> > +                       unsigned long new_addr, pte_t *src_pte)
> > +{
> > +     struct hstate *h =3D hstate_vma(vma);
> > +     struct mm_struct *mm =3D vma->vm_mm;
> > +     pte_t *dst_pte, pte;
> > +     spinlock_t *src_ptl, *dst_ptl;
> > +
> > +     /* Shared pmd's need to be unshared, not moved, and we should nev=
er
> > +      * reach here.
> > +      */
> > +     BUG_ON(huge_pmd_shared(vma, src_pte));
>
> IMO, the BUG_ON and huge_pmd_shared are overkill.  There is only one
> caller of move_huge_pte and we unshared before calling here.
>

Removed in v3.

> > +
> > +     dst_pte =3D huge_pte_offset(mm, new_addr, huge_page_size(h));
> > +     dst_ptl =3D huge_pte_lock(h, mm, dst_pte);
> > +     src_ptl =3D huge_pte_lockptr(h, mm, src_pte);
> > +     /*
> > +      * We don't have to worry about the ordering of src and dst ptloc=
ks
> > +      * because exclusive mmap_sem (or the i_mmap_lock) prevents deadl=
ock.
> > +      */
> > +     if (src_ptl !=3D dst_ptl)
> > +             spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> > +
> > +     pte =3D huge_ptep_get_and_clear(mm, old_addr, src_pte);
> > +     set_huge_pte_at(mm, new_addr, dst_pte, pte);
> > +
> > +     if (src_ptl !=3D dst_ptl)
> > +             spin_unlock(src_ptl);
> > +     spin_unlock(dst_ptl);
> > +}
> > +
> > +int move_hugetlb_page_tables(struct vm_area_struct *vma, unsigned long=
 old_addr,
> > +                          unsigned long new_addr, unsigned long len)
> > +{
> > +     struct hstate *h =3D hstate_vma(vma);
> > +     struct address_space *mapping =3D vma->vm_file->f_mapping;
> > +     unsigned long sz =3D huge_page_size(h);
> > +     struct mm_struct *mm =3D vma->vm_mm;
> > +     unsigned long old_end =3D old_addr + len;
> > +     unsigned long old_addr_copy;
> > +     pte_t *src_pte, *dst_pte;
> > +     struct mmu_notifier_range range;
> > +
> > +     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, old=
_addr,
> > +                             old_end);
> > +     mmu_notifier_invalidate_range_start(&range);
>
> The range to invalidate may be larger than [old_addr - old_end] in the
> case of shared pmds.  See try_to_unmap_one()'s use of
> adjust_range_if_pmd_sharing_possible().
>

Thanks, removed in v3.

> > +     /* Prevent race with file truncation */
> > +     i_mmap_lock_write(mapping);
> > +     for (; old_addr < old_end; old_addr +=3D sz, new_addr +=3D sz) {
> > +             src_pte =3D huge_pte_offset(mm, old_addr, sz);
> > +             if (!src_pte)
> > +                     continue;
> > +             if (huge_pte_none(huge_ptep_get(src_pte)))
> > +                     continue;
> > +
> > +             old_addr_copy =3D old_addr;
>
> A comment on the need/use of old_addr_copy would be useful for the
> casual reader.
>

Done.

> > +
> > +             if(huge_pmd_unshare(mm, vma, &old_addr_copy, src_pte))
> > +                     continue;
> > +
> > +             dst_pte =3D huge_pte_alloc(mm, vma, new_addr, sz);
>
> This should be passed the destination vma.  Since the vma argument is
> only used in the case of pmd sharing, and we just unshared one line
> above, you get away with passing the incorrect vma.  However, this is
> wrong and should be changed.
>

Done.

> > +             if (!dst_pte)
> > +                     break;
> > +
> > +             move_huge_pte(vma, old_addr, new_addr, src_pte);
> > +     }
> > +     i_mmap_unlock_write(mapping);
> > +     flush_tlb_range(vma, old_end - len, old_end);
> > +     mmu_notifier_invalidate_range_end(&range);
> > +
> > +     return len + old_addr - old_end;
> > +}
> > +
> >  void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_str=
uct *vma,
> >                           unsigned long start, unsigned long end,
> >                           struct page *ref_page)
> > @@ -5900,7 +6002,7 @@ static unsigned long page_table_shareable(struct =
vm_area_struct *svma,
> >       return saddr;
> >  }
> >
> > -static bool vma_shareable(struct vm_area_struct *vma, unsigned long ad=
dr)
> > +bool hugetlb_vma_shareable(struct vm_area_struct *vma, unsigned long a=
ddr)
> >  {
> >       unsigned long base =3D addr & PUD_MASK;
> >       unsigned long end =3D base + PUD_SIZE;
> > @@ -5919,7 +6021,7 @@ bool want_pmd_share(struct vm_area_struct *vma, u=
nsigned long addr)
> >       if (uffd_disable_huge_pmd_share(vma))
> >               return false;
> >  #endif
> > -     return vma_shareable(vma, addr);
> > +     return hugetlb_vma_shareable(vma, addr);
> >  }
> >
> >  /*
> > @@ -5963,8 +6065,8 @@ void adjust_range_if_pmd_sharing_possible(struct =
vm_area_struct *vma,
> >   * NOTE: This routine is only called from huge_pte_alloc.  Some caller=
s of
> >   * huge_pte_alloc know that sharing is not possible and do not take
> >   * i_mmap_rwsem as a performance optimization.  This is handled by the
> > - * if !vma_shareable check at the beginning of the routine. i_mmap_rws=
em is
> > - * only required for subsequent processing.
> > + * if !hugetlb_vma_shareable check at the beginning of the routine. i_=
mmap_rwsem
> > + * is only required for subsequent processing.
> >   */
>
> This comment is obsolete.  Sorry!
>
> The check for !vma_shareable no longer exists.  No need to update an
> obsolete comment.  Please remove the entire NOTE.
>

Done.


> >  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma=
,
> >                     unsigned long addr, pud_t *pud)
> > @@ -6042,7 +6144,22 @@ int huge_pmd_unshare(struct mm_struct *mm, struc=
t vm_area_struct *vma,
> >       return 1;
> >  }
> >
> > +int huge_pmd_shared(struct vm_area_struct *vma, pte_t *ptep)
> > +{
> > +     i_mmap_assert_write_locked(vma->vm_file->f_mapping);
> > +     BUG_ON(page_count(virt_to_page(ptep)) =3D=3D 0);
> > +     if (page_count(virt_to_page(ptep)) =3D=3D 1)
> > +             return 0;
> > +
> > +     return 1;
> > +}
> > +
> >  #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
> > +static bool hugetlb_vma_shareable(struct vm_area_struct *vma, unsigned=
 long addr)
> > +{
> > +     return false;
> > +}
> > +
> >  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma=
,
> >                     unsigned long addr, pud_t *pud)
> >  {
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index badfe17ade1f0..5f3a7f9362865 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -489,6 +489,9 @@ unsigned long move_page_tables(struct vm_area_struc=
t *vma,
> >       old_end =3D old_addr + len;
> >       flush_cache_range(vma, old_addr, old_end);
> >
> > +     if (is_vm_hugetlb_page(vma))
> > +             return move_hugetlb_page_tables(vma, old_addr, new_addr, =
len);
> > +
> >       mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm=
_mm,
> >                               old_addr, old_end);
> >       mmu_notifier_invalidate_range_start(&range);
> > @@ -642,6 +645,10 @@ static unsigned long move_vma(struct vm_area_struc=
t *vma,
> >               mremap_userfaultfd_prep(new_vma, uf);
> >       }
> >
> > +     if (is_vm_hugetlb_page(vma)) {
> > +             clear_vma_resv_huge_pages(vma);
> > +     }
> > +
> >       /* Conceal VM_ACCOUNT so old reservation is not undone */
> >       if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
> >               vma->vm_flags &=3D ~VM_ACCOUNT;
> > @@ -736,9 +743,6 @@ static struct vm_area_struct *vma_to_resize(unsigne=
d long addr,
> >                       (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
> >               return ERR_PTR(-EINVAL);
> >
> > -     if (is_vm_hugetlb_page(vma))
> > -             return ERR_PTR(-EINVAL);
> > -
> >       /* We can't remap across vm area boundaries */
> >       if (old_len > vma->vm_end - addr)
> >               return ERR_PTR(-EFAULT);
> > @@ -949,6 +953,26 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsig=
ned long, old_len,
> >
>
> Earlier in mremap code, this following lines exist:
>
>         old_len =3D PAGE_ALIGN(old_len);
>         new_len =3D PAGE_ALIGN(new_len);
>
> So, the passed length values are page aligned.  This allows 'sloppy'
> values to be passed by users.
>
> Should we do the same for hugetlb mappings?  In mmap we have different
> requirements for hugetlb mappings:
>
> " Huge page (Huge TLB) mappings
>        For mappings that employ huge pages, the requirements for the argu=
ments
>        of  mmap()  and munmap() differ somewhat from the requirements for=
 map=E2=80=90
>        pings that use the native system page size.
>
>        For mmap(), offset must be a multiple of the underlying huge page =
size.
>        The system automatically aligns length to be a multiple of the und=
erly=E2=80=90
>        ing huge page size.
>
>        For munmap(), addr and length must both be a multiple of the under=
lying
>        huge page size.
> "
>
> I actually wish arguments for hugetlb mappings would be treated the same
> as for base page size mappings.  We can not change mmap as legacy code
> may depend on the different requirements.  Since mremap for hugetlb is
> new, should we treat arguments for hugetlb mappings the same as for base
> pages (align to huge page boundary)?  My vote is yes, but it would be
> good to get other opinions.
>
> If we do not align for hugetlb mappings as we do for base page mappings,
> then this will also need to be documented.
>
> Another question,
> Should we possibly check addr and new_addr alignment here as well?
> addr has been previously checked for PAGE alignment and new_addr is
> checked for PAGE alignment at the beginning of mremap_to().
>

I'll yield to whatever you decide here because I reckon you have much
more experience and better judgement here. But my thoughts:

'Sane' usage of mremap() is something like:
1. mmap() a hugetlbfs vma.
2. Pass the vma received from step (1) to mremap() to remap it to a
different location.

I don't know if there is another usage pattern I need to worry about
but given the above, old_addr and old_len will be hugepage aligned
already since they are values returned by the previous mmap() call
which aligns them, no? So, I think aligning old_addr and old_len to
the hugepage boundary is fine.

With this support we don't allow mremap() expansion. In my use case
old_len=3D=3Dnew_len acutally. I think it's fine to also align new_len to
the hugepage boundary

I already have this code that errors out if the lengths are not aligned:

if (old_len & ~huge_page_mask(h) || new_len & ~huge_page_mask(h))
    goto out;

I think aligning new_addr breaks my use case though. In my use case
new_addr is the start of the text segment in the ELF executable, and I
don't think that's guaranteed to be anything but page aligned.
Aligning new_addr seems like it would break my use case. If you insist
though I'm happy aligning new_addr in the upstream kernel and not
doing that in our kernel, but if I'm not particularly happy with the
hugepage alignment I'd say it is likely future users of hugetlb
mremap() also won't like the hugepage alignement, but I yield to you
here.


> >       if (mmap_write_lock_killable(current->mm))
> >               return -EINTR;
> > +     vma =3D find_vma(mm, addr);
> > +     if (!vma || vma->vm_start > addr) {
> > +             ret =3D EFAULT;
> > +             goto out;
> > +     }
> > +
> > +     if (is_vm_hugetlb_page(vma)) {
> > +             struct hstate *h __maybe_unused =3D hstate_vma(vma);
> > +
> > +             if (old_len & ~huge_page_mask(h) ||
> > +                             new_len & ~huge_page_mask(h))
> > +                     goto out;
> > +
> > +             /*
> > +              * Don't allow remap expansion, because the underlying hu=
getlb
> > +              * reservation is not yet capable to handle split reserva=
tion.
> > +              */
> > +             if (new_len > old_len)
> > +                     goto out;
> > +     }
> >
> >       if (flags & (MREMAP_FIXED | MREMAP_DONTUNMAP)) {
> >               ret =3D mremap_to(addr, old_len, new_addr, new_len,
> > diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/self=
tests/vm/.gitignore
> > index b02eac613fdda..2e7e86e852828 100644
> > --- a/tools/testing/selftests/vm/.gitignore
> > +++ b/tools/testing/selftests/vm/.gitignore
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  hugepage-mmap
> > +hugepage-mremap
> >  hugepage-shm
> >  khugepaged
> >  map_hugetlb
> > diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selfte=
sts/vm/Makefile
> > index d9605bd10f2de..1607322a112c9 100644
> > --- a/tools/testing/selftests/vm/Makefile
> > +++ b/tools/testing/selftests/vm/Makefile
> > @@ -29,6 +29,7 @@ TEST_GEN_FILES =3D compaction_test
> >  TEST_GEN_FILES +=3D gup_test
> >  TEST_GEN_FILES +=3D hmm-tests
> >  TEST_GEN_FILES +=3D hugepage-mmap
> > +TEST_GEN_FILES +=3D hugepage-mremap
> >  TEST_GEN_FILES +=3D hugepage-shm
> >  TEST_GEN_FILES +=3D khugepaged
> >  TEST_GEN_FILES +=3D madv_populate
> > diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testi=
ng/selftests/vm/hugepage-mremap.c
> > new file mode 100644
> > index 0000000000000..b55052d4eadc9
> > --- /dev/null
> > +++ b/tools/testing/selftests/vm/hugepage-mremap.c
> > @@ -0,0 +1,163 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * hugepage-mremap:
> > + *
> > + * Example of remapping huge page memory in a user application using t=
he
> > + * mremap system call.  Before running this application, make sure tha=
t the
> > + * administrator has mounted the hugetlbfs filesystem (on some directo=
ry
> > + * like /mnt) using the command mount -t hugetlbfs nodev /mnt. In this
> > + * example, the app is requesting memory of size 10MB that is backed b=
y
> > + * huge pages.
> > + *
> > + */
>
> Didn't take a close look, but when building got these:
>
> hugepage-mremap.c: In function =E2=80=98register_region_with_uffd=E2=80=
=99:
> hugepage-mremap.c:64:6: warning: unused variable =E2=80=98s=E2=80=99 [-Wu=
nused-variable]
>    64 |  int s;
>       |      ^
> hugepage-mremap.c:106:1: warning: control reaches end of non-void functio=
n [-Wreturn-type]
>   106 | }
>       | ^
>

Fixed in v3.

> > +
> > +#define _GNU_SOURCE
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <sys/mman.h>
> > +#include <fcntl.h>
> > +#include <errno.h>
> > +#include <fcntl.h> /* Definition of O_* constants */
> > +#include <sys/syscall.h> /* Definition of SYS_* constants */
> > +#include <unistd.h>
> > +#include <linux/userfaultfd.h>
> > +#include <sys/ioctl.h>
> > +
> > +#define LENGTH (1UL * 1024 * 1024 * 1024)
> > +
> > +#define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
> > +#define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
> > +
> > +static void check_bytes(char *addr)
> > +{
> > +     printf("First hex is %x\n", *((unsigned int *)addr));
> > +}
> > +
> > +static void write_bytes(char *addr)
> > +{
> > +     unsigned long i;
> > +
> > +     for (i =3D 0; i < LENGTH; i++) {
> > +             *(addr + i) =3D (char)i;
> > +     }
> > +}
> > +
> > +static int read_bytes(char *addr)
> > +{
> > +     unsigned long i;
> > +
> > +     check_bytes(addr);
> > +     for (i =3D 0; i < LENGTH; i++)
> > +             if (*(addr + i) !=3D (char)i) {
> > +                     printf("Mismatch at %lu\n", i);
> > +                     return 1;
> > +             }
> > +     return 0;
> > +}
> > +
> > +static int register_region_with_uffd(char *addr, size_t len)
> > +{
> > +     long uffd; /* userfaultfd file descriptor */
> > +     struct uffdio_api uffdio_api;
> > +     struct uffdio_register uffdio_register;
> > +     int s;
> > +
> > +     /* Create and enable userfaultfd object. */
> > +
> > +     uffd =3D syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> > +     if (uffd =3D=3D -1) {
> > +             perror("userfaultfd");
> > +             exit(1);
> > +     }
> > +
> > +     uffdio_api.api =3D UFFD_API;
> > +     uffdio_api.features =3D 0;
> > +     if (ioctl(uffd, UFFDIO_API, &uffdio_api) =3D=3D -1) {
> > +             perror("ioctl-UFFDIO_API");
> > +             exit(1);
> > +     }
> > +
> > +     /* Create a private anonymous mapping. The memory will be
> > +        demand-zero paged--that is, not yet allocated. When we
> > +        actually touch the memory, it will be allocated via
> > +        the userfaultfd. */
> > +
> > +     addr =3D mmap(NULL, len, PROT_READ | PROT_WRITE,
> > +                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +     if (addr =3D=3D MAP_FAILED) {
> > +             perror("mmap");
> > +             exit(1);
> > +     }
> > +
> > +     printf("Address returned by mmap() =3D %p\n", addr);
> > +
> > +     /* Register the memory range of the mapping we just created for
> > +        handling by the userfaultfd object. In mode, we request to tra=
ck
> > +        missing pages (i.e., pages that have not yet been faulted in).=
 */
> > +
> > +     uffdio_register.range.start =3D (unsigned long)addr;
> > +     uffdio_register.range.len =3D len;
> > +     uffdio_register.mode =3D UFFDIO_REGISTER_MODE_MISSING;
> > +     if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) =3D=3D -1) {
> > +             perror("ioctl-UFFDIO_REGISTER");
> > +             exit(1);
> > +     }
> > +}
> > +
> > +int main(void)
> > +{
> > +     int ret =3D 0;
> > +
> > +     int fd =3D open("/mnt/huge/test", O_CREAT | O_RDWR, 0755);
> > +     if (fd < 0) {
> > +             perror("Open failed");
> > +             exit(1);
> > +     }
> > +
> > +     /* mmap to a PUD aligned address to hopefully trigger pmd sharing=
. */
> > +     unsigned long suggested_addr =3D 0x7eaa40000000;
> > +     void *haddr =3D mmap((void *)suggested_addr, LENGTH, PROTECTION,
> > +                        MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0=
);
> > +     printf("Returned address is %p\n", haddr);
> > +     if (haddr =3D=3D MAP_FAILED) {
> > +             perror("mmap1");
> > +             exit(1);
> > +     }
> > +
> > +     /* mmap again to a dummy address to hopefully trigger pmd sharing=
. */
> > +     suggested_addr =3D 0x7daa40000000;
> > +     void *daddr =3D mmap((void *)suggested_addr, LENGTH, PROTECTION,
> > +                        MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0=
);
> > +     printf("Returned address is %p\n", daddr);
> > +     if (haddr =3D=3D MAP_FAILED) {
>
> Should be checking daddr.
>

Fixed in v3.

> > +             perror("mmap3");
> > +             exit(1);
> > +     }
> > +
> > +     suggested_addr =3D 0x7faa40000000;
> > +     void *vaddr =3D mmap((void*)suggested_addr, LENGTH, PROTECTION, F=
LAGS, -1, 0);
> > +     printf("Returned address is %p\n", vaddr);
> > +     if (vaddr =3D=3D MAP_FAILED) {
> > +             perror("mmap2");
> > +             exit(1);
> > +     }
> > +
> > +     register_region_with_uffd(haddr, LENGTH);
> > +
> > +     void *addr =3D mremap(haddr, LENGTH, LENGTH,
> > +                     MREMAP_MAYMOVE | MREMAP_FIXED, vaddr);
> > +     if (addr =3D=3D MAP_FAILED) {
> > +             perror("mremap");
> > +             exit(1);
> > +     }
> > +
> > +     printf("Returned address is %p\n", addr);
> > +     check_bytes(addr);
> > +     write_bytes(addr);
> > +     ret =3D read_bytes(addr);
> > +
> > +     munmap(addr, LENGTH);
> > +
> > +     return ret;
> > +}
> > diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/s=
elftests/vm/userfaultfd.c
> > old mode 100644
> > new mode 100755
> > --
> > 2.32.0.605.g8dce9f2422-goog
> >
>
>
> --
> Mike Kravetz
