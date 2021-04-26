Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2D336AC6E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 08:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhDZGyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 02:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhDZGya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 02:54:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC93C061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 23:53:47 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f15-20020a05600c4e8fb029013f5599b8a9so2501606wmq.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 23:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pztt8Wk71RNkkzrtl1o4xHEFmBSxcCXDlHqJEhnOJyQ=;
        b=G2qaGHSCvHB8XzskGhObrZ+o21NjyHuWiSPY9heAoJtFitrVC93R69xTJ0bBVdKZRo
         AKQcW0np83kB9sTonB3jz3iP/tvnobwthsbTgPbqiSe3K15hC5V3Mn3yh86o470gM5cn
         WBDZUNrMdw7/cdVODZXS13A/taiWLZjatvQLhxaqlo9ivGAABRoMGkOv/snePeJHF5WN
         v7CpsxHm+Tl3lSQvdRdksApwdstSyFKYonKl11auAYtCyvQFzxGytQ9nDlqjUXSjjowh
         mAXMyIixVuAPHKnUtDd9SCqvCpBuoe/0P/D8DGlpK7iB7XZHRDZhsnN97gMpRDOVDBXv
         3CFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pztt8Wk71RNkkzrtl1o4xHEFmBSxcCXDlHqJEhnOJyQ=;
        b=nHYJIYCuSMdkscRo3itHK2VlfbAdtVfb3oxD6fbqEaZOTFwqYiDFjpPVDHXCOSvE2X
         Ws5D8X/uZJO7vpcsy8WBzOZsgWdrGcni95I7ZVpnmbZAr+NiGrCnu57sOJ2OR8UtYbb3
         HK0IVuw7msKjpaDMN6xTp+zkVYHj+lTu70KYu3n7B929eR5ZxYGmqs5F/Fv6OUu61yde
         Slds/zcPJ8pwzDT6gUT4yaN6sEmfnQoluPowHBRK8NnG5luxFxWcEskcdwCua0OT956Y
         r+hwXIQIlY9Lnvartkkqo/xNQo/avmUBFvq+1zJ9jFWpeVv+nz7nkMRBIepnfjKJ3NoN
         mX7w==
X-Gm-Message-State: AOAM532SKl07gK0/HRBW7ycTQIB4crWU2694p0nruemG705sm1IaIvq3
        6oQpn/EirgDNlx3BYOVITZWsaDh5Guhw1gOA4dpsUg==
X-Google-Smtp-Source: ABdhPJzXdTIZWGLS1AdpPGVNLIa863MGLencqacznclQQcOLxUQlH3JZO3gpprcqrzyQz1s9NcwyEzb0MbAptbPeJrQ=
X-Received: by 2002:a1c:4e01:: with SMTP id g1mr18641817wmh.48.1619420026371;
 Sun, 25 Apr 2021 23:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210425095419.3830298-1-linmiaohe@huawei.com> <20210425095419.3830298-5-linmiaohe@huawei.com>
In-Reply-To: <20210425095419.3830298-5-linmiaohe@huawei.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 26 Apr 2021 00:53:34 -0600
Message-ID: <CAOUHufZbT06isT_TU=x8d3P+AEHG8W=xd9GyX_5GHPNBT9KT9g@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm/shmem: fix shmem_swapin() race with swapoff
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, dennis@kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, alexs@kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 3:54 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> When I was investigating the swap code, I found the below possible race
> window:
>
> CPU 1                                         CPU 2
> -----                                         -----
> shmem_swapin
>   swap_cluster_readahead
>     if (likely(si->flags & (SWP_BLKDEV | SWP_FS_OPS))) {
>                                               swapoff
>                                                 ..
>                                                 si->swap_file = NULL;
>                                                 ..
>     struct inode *inode = si->swap_file->f_mapping->host;[oops!]
>
> Close this race window by using get/put_swap_device() to guard against
> concurrent swapoff.
>
> Fixes: 8fd2e0b505d1 ("mm: swap: check if swap backing device is congested or not")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/shmem.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 26c76b13ad23..2dafd65b0b42 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1696,6 +1696,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>         struct address_space *mapping = inode->i_mapping;
>         struct shmem_inode_info *info = SHMEM_I(inode);
>         struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
> +       struct swap_info_struct *si;
>         struct page *page;
>         swp_entry_t swap;
>         int error;
> @@ -1704,6 +1705,12 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>         swap = radix_to_swp_entry(*pagep);
>         *pagep = NULL;
>
> +       /* Prevent swapoff from happening to us. */
> +       si = get_swap_device(swap);
> +       if (!si) {
> +               error = EINVAL;
> +               goto failed;
> +       }

page is uninitialized?

>         /* Look it up and read it in.. */
>         page = lookup_swap_cache(swap, NULL, 0);
>         if (!page) {
> @@ -1765,6 +1772,8 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>         swap_free(swap);
>
>         *pagep = page;
> +       if (si)
> +               put_swap_device(si);
>         return 0;
>  failed:
>         if (!shmem_confirm_swap(mapping, index, swap))
> @@ -1775,6 +1784,9 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>                 put_page(page);
>         }
>
> +       if (si)
> +               put_swap_device(si);
> +
>         return error;
>  }
>
> --
> 2.23.0
>
>
