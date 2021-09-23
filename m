Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C23E4167F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 00:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243478AbhIWWZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 18:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243451AbhIWWZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 18:25:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCE6C061756;
        Thu, 23 Sep 2021 15:24:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id u27so28014894edi.9;
        Thu, 23 Sep 2021 15:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CT7KCr5JzmhOzp1OYQQLzyUDx7iSATgAJPZ9wyLVnkI=;
        b=o5Xnf0ITeHNqTJoBcm0mowoAq7IDRRWUgZ+GRG1+fnouy0GcArivFUNZ9VpEQsELNl
         kI3oBEw1GqVfZbjuGr4REvG94qEn59tl9me/BuAZ5dlO4b96KbRT0euPgCEuF/oajemB
         BasmLrZJWcDc3tHgkzhssHOVk2SCZpaCBMoO6znTgP0uT5Cl0AZxxSBEFN8WpvFn+qJJ
         GSeVSeWWegawuQFt7uQcpEWgSWUjyEo4fRDxYxFYXXB6KwoeoFR1q/0F6B5sEHbfi4RT
         Tp/irL1+6RCTSC1dlCIKcEj/u4n7oAyGFoqBthPcIWZwTuZccMcItdQA5gOTGm1/4oQc
         idDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CT7KCr5JzmhOzp1OYQQLzyUDx7iSATgAJPZ9wyLVnkI=;
        b=FAj90YCj+5mVdGw2/qPJxAWYJ276fayZmTdhzKgh9J2azzEdr9SBVnePZuue6YgK74
         WBW+431amRGbyHHO7z+zRTSDwuysvpfAOUIOP2B+SBMhzEp8rvBZUZmJ/65QgThrkP1q
         PQjBznwh5sP6bFMPAdnLD7pgNpuCazZHmD0wG5d556syGwJZIKyLYQqOUVt6O7BzjmB4
         mTA3HV3zDlUK4FegDDHHe6SLYZFekxsVWTvY9uGDN/eWBoh4v+gchVJ/6Q4BXfXWpdzz
         oKfPdm2wJ0SeNCy0apPnakoCIMVdcy7huPWODCBbLZnHsvcBzQarH6nzYTV9soh3hJWA
         oGmw==
X-Gm-Message-State: AOAM533vlouHrjhtzBMvZr5sPBiet5SA+saxe59UVtJkLfIFXUSFtQKJ
        lguUTX8loEZa7RMoaTcPM3Vn/XINbWm1ixBfRvE=
X-Google-Smtp-Source: ABdhPJw+DXDQzdLXxBE3qxnoYiooEh2Ka+AByTiMPKUDWPoJ1ePyYaBK83sIryPyIHDdOKP4GqFNUMmE/bLFXmifTKU=
X-Received: by 2002:a50:cd87:: with SMTP id p7mr1547322edi.294.1632435850397;
 Thu, 23 Sep 2021 15:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210922102411.34494-1-songmuchun@bytedance.com> <20210922102411.34494-3-songmuchun@bytedance.com>
In-Reply-To: <20210922102411.34494-3-songmuchun@bytedance.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 24 Sep 2021 10:23:59 +1200
Message-ID: <CAGsJ_4zk8KfsByum89PqwNEkez=QUW9YH0tVy5nce2E0RhQ8dw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm: hugetlb: replace hugetlb_free_vmemmap_enabled
 with a static_key
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 10:27 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The page_head_if_fake() is used throughout memory management and the
> conditional check requires checking a global variable, although the
> overhead of this check may be small, it increases when the memory
> cache comes under pressure. Also, the global variable will not be
> modified after system boot, so it is very appropriate to use static
> key machanism.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/hugetlb.h    | 10 ++++++++--
>  include/linux/page-flags.h |  6 ++++--
>  mm/hugetlb_vmemmap.c       | 12 ++++++------
>  mm/memory_hotplug.c        |  2 +-
>  4 files changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1faebe1cd0ed..4cc647a5dbf8 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1066,9 +1066,15 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
>  #endif /* CONFIG_HUGETLB_PAGE */
>
>  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> -extern bool hugetlb_free_vmemmap_enabled;
> +static inline bool hugetlb_free_vmemmap_enabled(void)
> +{
> +       return static_key_enabled(&hugetlb_free_vmemmap_enabled_key);

could it be
       if (static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
                                &hugetlb_free_vmemmap_enabled_key))

then we are able to remove the duplication in page_fixed_fake_head()?

> +}
>  #else
> -#define hugetlb_free_vmemmap_enabled   false
> +static inline bool hugetlb_free_vmemmap_enabled(void)
> +{
> +       return false;
> +}
>  #endif
>
>  static inline spinlock_t *huge_pte_lock(struct hstate *h,
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index b47a7f51d2c3..54e119e44496 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -185,7 +185,8 @@ enum pageflags {
>  #ifndef __GENERATING_BOUNDS_H
>
>  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> -extern bool hugetlb_free_vmemmap_enabled;
> +DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> +                        hugetlb_free_vmemmap_enabled_key);
>
>  /*
>   * If the feature of freeing some vmemmap pages associated with each HugeTLB
> @@ -205,7 +206,8 @@ extern bool hugetlb_free_vmemmap_enabled;
>   */
>  static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
>  {
> -       if (!hugetlb_free_vmemmap_enabled)
> +       if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> +                                &hugetlb_free_vmemmap_enabled_key))
>                 return page;
>         /*
>          * Only addresses aligned with PAGE_SIZE of struct page may be fake head
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 527bcaa44a48..47517e878ed5 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -188,9 +188,9 @@
>  #define RESERVE_VMEMMAP_NR             1U
>  #define RESERVE_VMEMMAP_SIZE           (RESERVE_VMEMMAP_NR << PAGE_SHIFT)
>
> -bool hugetlb_free_vmemmap_enabled __read_mostly =
> -       IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
> -EXPORT_SYMBOL(hugetlb_free_vmemmap_enabled);
> +DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> +                       hugetlb_free_vmemmap_enabled_key);
> +EXPORT_SYMBOL(hugetlb_free_vmemmap_enabled_key);
>
>  static int __init early_hugetlb_free_vmemmap_param(char *buf)
>  {
> @@ -204,9 +204,9 @@ static int __init early_hugetlb_free_vmemmap_param(char *buf)
>                 return -EINVAL;
>
>         if (!strcmp(buf, "on"))
> -               hugetlb_free_vmemmap_enabled = true;
> +               static_branch_enable(&hugetlb_free_vmemmap_enabled_key);
>         else if (!strcmp(buf, "off"))
> -               hugetlb_free_vmemmap_enabled = false;
> +               static_branch_disable(&hugetlb_free_vmemmap_enabled_key);
>         else
>                 return -EINVAL;
>
> @@ -284,7 +284,7 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>         BUILD_BUG_ON(__NR_USED_SUBPAGE >=
>                      RESERVE_VMEMMAP_SIZE / sizeof(struct page));
>
> -       if (!hugetlb_free_vmemmap_enabled)
> +       if (!hugetlb_free_vmemmap_enabled())
>                 return;
>
>         vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0488eed3327c..89c1fde02162 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1341,7 +1341,7 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
>          *       populate a single PMD.
>          */
>         return memmap_on_memory &&
> -              !hugetlb_free_vmemmap_enabled &&
> +              !hugetlb_free_vmemmap_enabled() &&
>                IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
>                size == memory_block_size_bytes() &&
>                IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
> --
> 2.11.0
>

Thanks
barry
