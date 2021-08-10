Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED0E3E865A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhHJXP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbhHJXPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:15:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56642C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:15:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id f13so543626edq.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GUPlvlIHsVV1HyaB0WHrhJqrkm62V56QQdb99OyYrME=;
        b=d548327fMFrF4HElne/pg8ZqB2axWgruQV3eF98nujz9NYnC+r6K/uE8dl1ll2yvWU
         HrL6VLhRBFsZIiJeWHg/92oQjvsa9voWfSaUIv3v2mzWjTyTGxRyC49zS0Blaetkpewe
         HsPYSFAbQSosuutny2je80yTuPqRd+C+UVW2+PqGEzK+Eib6MQ+pSSmryahjRVE28uYD
         WsG6XiVsRbzOZZmePrjTgsRpum3tpLHurlDCpKtJmjMeoUYWNTyAe+ZMbn5ebWxpoFDO
         jubdfL3e546ZAAc7dKRZfcTZa9RQoPuvM0T6HGhJjYFCaMd3iHCBzcYjgLO/1r/X7IVi
         gR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GUPlvlIHsVV1HyaB0WHrhJqrkm62V56QQdb99OyYrME=;
        b=V+USThNCm1mDc6lUwv0wqXKAIqCK1FiU+Hrf+ph6PgFOjcGCc/1zIVwy7QxuxBN7c+
         jfPKUdWGU66lqIGM7lCQo5ENvT4djRXZs5smTMVxYti6DiWQV6/MePBq6Ma9xRh6Y9nT
         c1cLZg8LenS3WGQBElF2YlPjuBFzB3v4cr2liDbT9aursJcuHqQ/VZczieeokUViSc5s
         1oNFzWLGTTOV2zj4J1boxtDGSBV+pzkHt2Ag5NkvU4mqAdb2s/tftqxeSQDH2DRsx9Uz
         4ep41OAw16V96y4OvltCLSmshuBgbbvNrRwY7sJV0AClUy8r8U2btcz2G0i3pAyeSF0m
         T1Ww==
X-Gm-Message-State: AOAM531tuk1C3ToZsboBukhy3LEp9PfaxNBHGOS3S5pPbVFm1+B2/Ltg
        FJd3dEUpFSHGwxdN3/me2BhdB7lmxbpl0nv82dg=
X-Google-Smtp-Source: ABdhPJxxoE6GGiwyiU+8OQ6VLJJz2j17ieL2oT4PyQDdF9V5sGkUgy9f2f+bfNF3WYpY+hQCVYSrZHyvGX/gHpWsRDg=
X-Received: by 2002:a50:954c:: with SMTP id v12mr7793777eda.313.1628637300909;
 Tue, 10 Aug 2021 16:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210810202936.2672-1-shy828301@gmail.com> <20210810202936.2672-2-shy828301@gmail.com>
In-Reply-To: <20210810202936.2672-2-shy828301@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 10 Aug 2021 16:14:49 -0700
Message-ID: <CAHbLzkoWyY+SvR2suej8c7nRArTt5Y6490QXrV1RTfdYX0HJVQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Revert "mm/shmem: fix shmem_swapin() race with swapoff"
To:     Hugh Dickins <hughd@google.com>, Huang Ying <ying.huang@intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 1:29 PM Yang Shi <shy828301@gmail.com> wrote:
>
> Due to the change about how block layer detects congestion the
> justification of commit 8fd2e0b505d1 ("mm: swap: check if swap backing device
> is congested or not") doesn't stand anymore, so the commit could be just
> reverted in order to solve the race reported by commit 2efa33fc7f6e ("mm/shmem:
> fix shmem_swapin() race with swapoff"), so the fix commit could be just
> reverted as well.

The updated commit log per the discussion with Hugh:

Due to the change about how block layer detects congestion the
justification of commit 8fd2e0b505d1 ("mm: swap: check if swap backing device
is congested or not") doesn't stand anymore, so the commit could be just
reverted in order to solve the race reported by commit 2efa33fc7f6e ("mm/shmem:
fix shmem_swapin() race with swapoff"), so the fix commit could be just
reverted as well.

And that fix is also kind of buggy as discussed by [1] and [2].

[1] https://lore.kernel.org/linux-mm/24187e5e-069-9f3f-cefe-39ac70783753@google.com/
[2] https://lore.kernel.org/linux-mm/e82380b9-3ad4-4a52-be50-6d45c7f2b5da@google.com/

>
> Suggested-by: Hugh Dickins <hughd@google.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/shmem.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index dcc07d14162e..d5427de5bf02 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1699,8 +1699,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>         struct address_space *mapping = inode->i_mapping;
>         struct shmem_inode_info *info = SHMEM_I(inode);
>         struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
> -       struct swap_info_struct *si;
> -       struct page *page = NULL;
> +       struct page *page;
>         swp_entry_t swap;
>         int error;
>
> @@ -1708,12 +1707,6 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>         swap = radix_to_swp_entry(*pagep);
>         *pagep = NULL;
>
> -       /* Prevent swapoff from happening to us. */
> -       si = get_swap_device(swap);
> -       if (!si) {
> -               error = EINVAL;
> -               goto failed;
> -       }
>         /* Look it up and read it in.. */
>         page = lookup_swap_cache(swap, NULL, 0);
>         if (!page) {
> @@ -1775,8 +1768,6 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>         swap_free(swap);
>
>         *pagep = page;
> -       if (si)
> -               put_swap_device(si);
>         return 0;
>  failed:
>         if (!shmem_confirm_swap(mapping, index, swap))
> @@ -1787,9 +1778,6 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>                 put_page(page);
>         }
>
> -       if (si)
> -               put_swap_device(si);
> -
>         return error;
>  }
>
> --
> 2.26.2
>
