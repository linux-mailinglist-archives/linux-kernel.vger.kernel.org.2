Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D30418AE9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 22:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhIZUPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 16:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhIZUPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 16:15:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A6DC061570;
        Sun, 26 Sep 2021 13:13:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g7so664623edv.1;
        Sun, 26 Sep 2021 13:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gx6lFxQkcmAA7UZaMrtFU5WcmTs0VRARHeMqyf6mMgw=;
        b=XOUsdZi6IfUisgHpPzVVzWp5nCMmSjn6dsArQ9my3vPzDWLoTpPzvtrxPnlHoBCpFK
         IBv86vElDr5xqJ4piN31W85NBPJLTLcgi1kxVIMAoYfeHdpDaVmFV7zUOm1pw2xGZZ0k
         SpuQyMfcXQpjoElHcMxSow2DEKjTzp6NoVr9TF2dbLsOnokvXkozayWbpCkq07JSZv/P
         XX76jsFR4zcFS0SjaGDXlx23QnsR1La6iN/bGlyYHvdod6cCLTc5RJoqZDyngmOR/T6o
         +xkcEbOnskxqXtn8Pal7BB6Q4Ph1yrRG3uDY3K1Bo2suXnlDgWD2KuW6VJWLZscHcdcl
         2Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gx6lFxQkcmAA7UZaMrtFU5WcmTs0VRARHeMqyf6mMgw=;
        b=dTRy+m16THmGkdc8VpgwYGBu3CoZdQpj5ca8EiL2TozYV+uw1QAVUXKgZx2MGbur7J
         MRdZxjv9SZDKC3uaSqn+lxIBm/OV1Q2RK/u25x2b0riZ9snE2jo8wv4b5naUFGLVA67Y
         ekbqnQD4JdeJRO+QfhWBGeXD0whqOV8k6aQq4rtkorS0tdfn2HjKWrZfcVS1Y0Fz/dDJ
         6MsHUu4YqCfFGfFZ0SYkfVFSUzxUzq3awuAXhOg+9KwsyHb97GKx2ZhoZj7jpZOoYkTI
         ssWPqgh/b0RwejuW7NSXB5qya/k6UdamtGpmAzyosVMBSnkoUmNlfoQEp+49cSeqD6pw
         uK0g==
X-Gm-Message-State: AOAM530DgLcCxXvhDOpS4zq+B4yPKumebecwLdNWmK/8w+fKAE4wzt1F
        35f/sOa2udE2FvwmND74c3tV/vAJsOd19Jom/yI=
X-Google-Smtp-Source: ABdhPJz9/Pv7P2gR6ExTXpUFRabHHfvpk9V7zPQWM+yNAMmodQ395ri1yDMPSHB9Sv4PcvsD4/Dckh1MsG1PyBbVPj4=
X-Received: by 2002:a50:c31c:: with SMTP id a28mr20040301edb.384.1632687218431;
 Sun, 26 Sep 2021 13:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210926031339.40043-1-songmuchun@bytedance.com> <20210926031339.40043-3-songmuchun@bytedance.com>
In-Reply-To: <20210926031339.40043-3-songmuchun@bytedance.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 27 Sep 2021 09:13:27 +1300
Message-ID: <CAGsJ_4yvSwtxR7yWjS=Nb8JwT7TiaCm4s4=0YKEQpqOZeZOdyA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm: hugetlb: replace hugetlb_free_vmemmap_enabled
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

On Sun, Sep 26, 2021 at 4:15 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The page_head_if_fake() is used throughout memory management and the
> conditional check requires checking a global variable, although the
> overhead of this check may be small, it increases when the memory
> cache comes under pressure. Also, the global variable will not be
> modified after system boot, so it is very appropriate to use static
> key machanism.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

> ---
>  include/linux/hugetlb.h    |  6 ------
>  include/linux/page-flags.h | 18 +++++++++++++++---
>  mm/hugetlb_vmemmap.c       | 12 ++++++------
>  mm/memory_hotplug.c        |  2 +-
>  4 files changed, 22 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 3cbf60464398..a90cc88195da 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1055,12 +1055,6 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
>  }
>  #endif /* CONFIG_HUGETLB_PAGE */
>
> -#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> -extern bool hugetlb_free_vmemmap_enabled;
> -#else
> -#define hugetlb_free_vmemmap_enabled   false
> -#endif
> -
>  static inline spinlock_t *huge_pte_lock(struct hstate *h,
>                                         struct mm_struct *mm, pte_t *pte)
>  {
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index b49808e748ce..26e540fd3393 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -185,7 +185,14 @@ enum pageflags {
>  #ifndef __GENERATING_BOUNDS_H
>
>  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> -extern bool hugetlb_free_vmemmap_enabled;
> +DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> +                        hugetlb_free_vmemmap_enabled_key);
> +
> +static __always_inline bool hugetlb_free_vmemmap_enabled(void)
> +{
> +       return static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> +                                  &hugetlb_free_vmemmap_enabled_key);
> +}
>
>  /*
>   * If the feature of freeing some vmemmap pages associated with each HugeTLB
> @@ -205,7 +212,7 @@ extern bool hugetlb_free_vmemmap_enabled;
>   */
>  static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
>  {
> -       if (!hugetlb_free_vmemmap_enabled)
> +       if (!hugetlb_free_vmemmap_enabled())
>                 return page;
>
>         /*
> @@ -229,10 +236,15 @@ static __always_inline const struct page *page_fixed_fake_head(const struct page
>         return page;
>  }
>  #else
> -static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
> +static inline const struct page *page_fixed_fake_head(const struct page *page)
>  {
>         return page;
>  }
> +
> +static inline bool hugetlb_free_vmemmap_enabled(void)
> +{
> +       return false;
> +}
>  #endif
>
>  static __always_inline int page_is_fake_head(struct page *page)
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index f4a8fca691ee..22ecb5e21686 100644
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
> index 4ea91c3ff768..66eaa4e2e76f 100644
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
