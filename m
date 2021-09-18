Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D104103C8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 06:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhIRE5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 00:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhIRE5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 00:57:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B3AC061574;
        Fri, 17 Sep 2021 21:55:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v5so37230169edc.2;
        Fri, 17 Sep 2021 21:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ugNAmrfcnEDQKSRKVwaF/l+fOTrdNqkk/PXYk6xWiRg=;
        b=XrCJSfTfzio6OySF2BG05KJTBlfYMJt+/HoWhZGZ26+aCG+G5Ufn+4gGVri7R89eJr
         RzZBGhYPUMMipFg7IaBg5uOqz1UE+XZYH/7/PCMais2EJF/NGQ4fchoBy8MubH84B5dL
         icdLavBRh5sf7BNYTqJPFz4dWZpmrjugRD3CUo793l0lSP8gWCxUxXj5ZMZ9Z9sJ55oR
         SH2W4pgewQrn44G8nwu7k28hLH2j1+NJIc71KuD7nDOUs6sdpLq8m/He9YXHTWIm6tuE
         +mbpuZIcljHSIkYoW7hpIdiHSsXgbeWcxBG8OhUNc0HaNX/RnITob9GUlaD+JLBjCrpt
         qTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugNAmrfcnEDQKSRKVwaF/l+fOTrdNqkk/PXYk6xWiRg=;
        b=XVRgqn/nIfyw0Z9ALNghpDUmxh3tZvmBb0ll53QBSAB9jwFVYcWz2B+XKicy4sovZx
         qtZJv9pLtqD5+g924UBxhvF4fFZ0WNiVZFFVKwb4HBftJcVajdz9hJTNPwlU0dymJBYa
         auxTbW8I7mxTw8zMh0fMdYPkd8Zf7Z8A1z03UEVArinxsm4DQKCJBeN6+eImNpPzoy0K
         4RQqColkq3yuDQOhXbWmi97PUC0mjdhzy6G0XDb5dOwAmdzNU7NkxMa1MOLfTjYmlYWM
         S2n6lBRGfgdA0OB82qaz13NHf5A2gjRxwq/ezrDPptG/iV+5zftoasjFj3oJxZ/efHa4
         pzDQ==
X-Gm-Message-State: AOAM531eogVKaLWirFlfmInISD0Dxo4lPY4yDIk3AXpmhyMPXmqB9zx/
        kguQIwy0tgU8Ry1724YpGbUCYJaoq6DzwAqreq4=
X-Google-Smtp-Source: ABdhPJyluD/oiIDcmDEv0opbjIIC6hZzNYGqhAUaldypW6bYEwlI/rJccmkztulILIfdedaX4ECzzjgqaja6UePFL5I=
X-Received: by 2002:aa7:d7d5:: with SMTP id e21mr17147376eds.27.1631940947451;
 Fri, 17 Sep 2021 21:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210917034815.80264-1-songmuchun@bytedance.com> <20210917034815.80264-3-songmuchun@bytedance.com>
In-Reply-To: <20210917034815.80264-3-songmuchun@bytedance.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 18 Sep 2021 16:55:36 +1200
Message-ID: <CAGsJ_4ymutSL-pbWA_TykJ2vE8ZKc+JGn+w_WWy2j7Mn-q+ebA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/4] mm: hugetlb: replace hugetlb_free_vmemmap_enabled
 with a static_key
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, Andrew Morton <akpm@linux-foundation.org>,
        osalvador@suse.de, mhocko@suse.com,
        Barry Song <song.bao.hua@hisilicon.com>, david@redhat.com,
        chenhuang5@huawei.com, bodeddub@amazon.com,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 12:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
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
>  include/linux/hugetlb.h    |  6 +++++-
>  include/linux/page-flags.h |  6 ++++--
>  mm/hugetlb_vmemmap.c       | 10 +++++-----
>  3 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index f7ca1a3870ea..ee3ddf3d12cf 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1057,7 +1057,11 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
>  #endif /* CONFIG_HUGETLB_PAGE */
>
>  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> -extern bool hugetlb_free_vmemmap_enabled;
> +DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> +                        hugetlb_free_vmemmap_enabled_key);
> +#define hugetlb_free_vmemmap_enabled                                    \
> +       static_key_enabled(&hugetlb_free_vmemmap_enabled_key)
> +
>  #else
>  #define hugetlb_free_vmemmap_enabled   false
>  #endif
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 7b1a918ebd43..d68d2cf30d76 100644
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
> @@ -204,7 +205,8 @@ extern bool hugetlb_free_vmemmap_enabled;
>   */
>  static __always_inline const struct page *page_head_if_fake(const struct page *page)
>  {
> -       if (!hugetlb_free_vmemmap_enabled)
> +       if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
> +                                &hugetlb_free_vmemmap_enabled_key))

A question bothering me is that we still have hugetlb_free_vmemmap_enabled
defined as static_key_enabled(&hugetlb_free_vmemmap_enabled_key).
but here you are using static_branch_maybe() with the CONFIG and refer the key
directly.
Do we only need one of them? Or something is wrong?

>                 return page;
>
>         /*
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 527bcaa44a48..5b80129c684c 100644
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
> --
> 2.11.0
>

Thanks
barry
