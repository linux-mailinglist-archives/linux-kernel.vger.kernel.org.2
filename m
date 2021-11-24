Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951BC45B42F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 07:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhKXGMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 01:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhKXGMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 01:12:16 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292DBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 22:09:07 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id e136so4165625ybc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 22:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xZ6Wg5PvZru5LD5B8dWO+XcKqQibFBlU/C/w3xxwkE=;
        b=eosEpYlgyct2YZGmwA0crcSObY7/DLFxo89aB34kgcvW3rG4DEPKRKPecudxI/MZ7o
         tjjW9UxHVgtgMFfv7BCXXby+l4i/PNp9NMPGRSr3ilVVeCQL5YmGuLAYtlC9eetivVTD
         xKC7btQwI+kOVmpbjf4D+QNMSV/Zf1q+D7Cp55C1QyjrGzBv0brP1KA+6d7McWsna53n
         2Xv6A9n9FM5zv4HMuJcawwAs6wEYpTPU34woplOX0IlqDoopTRSRgYM2vSaUF52wW77O
         LXyjONE3Z3TzXofSaYI++9fiPmvkflv+DIjDxb/1qqQ9oaD9fJGVaaGov+rt8hPD/yWr
         B4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xZ6Wg5PvZru5LD5B8dWO+XcKqQibFBlU/C/w3xxwkE=;
        b=O0k11PYAfQ39+gxILJFVnx3xU+P8bwLXQRFWhFjfwalyPa8SbmVsEBS26BX9nYcjMs
         LpH+YhUU8GlhujZw+ExJT4lNOLMsVUODAHlqOtZW2W4Vy6xzT4SzKaMMeb1KVwvCeTEV
         RyipkeLEaYy4tlBPwU6KU8iA+hnR1DGufnyuRu2kro3CrPqdUmsaun9cIN/v4ABwLSo0
         rFt8gkTtbMm4npBTrhPH8+WxqwCJ5Vwg5pvdWR7f1Tcu2oFF+mvItmQcgfo1WJKsVxJE
         aE57KIe2DsWFqjR8hQ5kwQjaT1iCsJ0Q/GmYTd+dE2heINSIQ7++j80ZdUBAvA+gffMz
         DpcA==
X-Gm-Message-State: AOAM531voRwAG7BQhT371BCE/WPv5iu1RVc66MkSe/TehceiGHlfLdUi
        Ozm8/lF8SMZOaLhzoFsi93RhhdXs87PK+22J1xn0gg==
X-Google-Smtp-Source: ABdhPJw0k56qfLhVsuVRU1Ch2ITsZyiJv3M9GRlTIHkYdoPvAp1Lt0eau7/+WqVE+67avpMiQCmnerAhDAYfj0lK2c4=
X-Received: by 2002:a05:6902:1144:: with SMTP id p4mr14900478ybu.404.1637734146305;
 Tue, 23 Nov 2021 22:09:06 -0800 (PST)
MIME-Version: 1.0
References: <20211124030840.88455-1-ligang.bdlg@bytedance.com>
In-Reply-To: <20211124030840.88455-1-ligang.bdlg@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 24 Nov 2021 14:08:27 +0800
Message-ID: <CAMZfGtWpWo4KGx02=RuZ3DiFW8b1-SuU90UR3+ccP90+qAeKhA@mail.gmail.com>
Subject: Re: [PATCH v2] shmem: move spinlock to the front of iput
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 11:08 AM Gang Li <ligang.bdlg@bytedance.com> wrote:
>
> This patch fixes a data race in commit 779750d20b93 ("shmem: split huge pages
> beyond i_size under memory pressure").
>
> Call Trace 1:
>  shmem_unused_huge_shrink+0x3ae/0x410
>  ? __list_lru_walk_one.isra.5+0x33/0x160
>  super_cache_scan+0x17c/0x190
>  shrink_slab.part.55+0x1ef/0x3f0
>  shrink_node+0x10e/0x330
>  kswapd+0x380/0x740
>  kthread+0xfc/0x130
>  ? mem_cgroup_shrink_node+0x170/0x170
>  ? kthread_create_on_node+0x70/0x70
>  ret_from_fork+0x1f/0x30
>
> Call Trace 2:
>  shmem_evict_inode+0xd8/0x190
>  evict+0xbe/0x1c0
>  do_unlinkat+0x137/0x330
>  do_syscall_64+0x76/0x120
>  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
>
> iput out of sbinfo->shrinklist_lock will let shmem_evict_inode grab
> and delete the inode, which will berak the consistency between
> shrinklist_len and shrinklist. The simultaneous deletion of adjacent
> elements in the local list "list" by shmem_unused_huge_shrink and
> shmem_evict_inode will also break the list.
>
> Fix it by moving shrinklist_lock to the front of iput.
>
> Fixes: 779750d20b93 ("shmem: split huge pages beyond i_size under memory pressure")
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>

I suggest changing the subject to "shmem: fix a race between
shmem_unused_huge_shrink and shmem_evict_inode". And please Cc
stable@vger.kernel.org as well.

I do not know if others see what happens here, here is a simple explanation.

Image there are 3 items in the local list (@list).

In the first traversal, A is not deleted from @list.

  1) A->B->C
     ^
     |
    pos (leave)

In the second traversal, B is deleted from @list. Concurrently, A is
deleted from
@list through shmem_evict_inode() since last reference counter of
inode is dropped
by other thread. Then the @list is corrupted.

  2) A->B->C
        ^
        |
       pos (drop)

We should make sure the item is either on the global list or deleted from
any local list before iput().

> ---
>
> Changes in v2:
> - Move spinlock to the front of iput instead of changing lock type
>   since iput will call evict which may cause deadlock by requesting
>   shrinklist_lock.
> - Add call trace in commit message.
>
> v1: https://lore.kernel.org/lkml/20211122064126.76734-1-ligang.bdlg@bytedance.com/
>
> ---
>  mm/shmem.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 9023103ee7d8..2f70a16fc588 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -569,7 +569,6 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>                 /* inode is about to be evicted */
>                 if (!inode) {
>                         list_del_init(&info->shrinklist);
> -                       removed++;
>                         goto next;
>                 }
>
> @@ -577,15 +576,16 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>                 if (round_up(inode->i_size, PAGE_SIZE) ==
>                                 round_up(inode->i_size, HPAGE_PMD_SIZE)) {
>                         list_move(&info->shrinklist, &to_remove);
> -                       removed++;
>                         goto next;
>                 }
>
>                 list_move(&info->shrinklist, &list);
>  next:
> +               removed++;
>                 if (!--batch)
>                         break;
>         }
> +       sbinfo->shrinklist_len -= removed;
>         spin_unlock(&sbinfo->shrinklist_lock);
>
>         list_for_each_safe(pos, next, &to_remove) {
> @@ -602,7 +602,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>                 inode = &info->vfs_inode;
>
>                 if (nr_to_split && split >= nr_to_split)
> -                       goto leave;
> +                       goto move_back;
>
>                 page = find_get_page(inode->i_mapping,
>                                 (inode->i_size & HPAGE_PMD_MASK) >> PAGE_SHIFT);
> @@ -616,38 +616,38 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>                 }
>
>                 /*
> -                * Leave the inode on the list if we failed to lock
> -                * the page at this time.
> +                * Move the inode on the list back to shrinklist if we failed
> +                * to lock the page at this time.
>                  *
>                  * Waiting for the lock may lead to deadlock in the
>                  * reclaim path.
>                  */
>                 if (!trylock_page(page)) {
>                         put_page(page);
> -                       goto leave;
> +                       goto move_back;
>                 }
>
>                 ret = split_huge_page(page);
>                 unlock_page(page);
>                 put_page(page);
>
> -               /* If split failed leave the inode on the list */
> +               /* If split failed move the inode on the list back to shrinklist */
>                 if (ret)
> -                       goto leave;
> +                       goto move_back;
>
>                 split++;
>  drop:
>                 list_del_init(&info->shrinklist);
> -               removed++;
> -leave:
> +               goto put;
> +move_back:

I think we should add a comment here to notice why it's
necessary to add @pos to the global list before iput().

> +               spin_lock(&sbinfo->shrinklist_lock);
> +               list_move(pos, &sbinfo->shrinklist);

I suggest using `list_move(&info->shrinklist, &sbinfo->shrinklist)`
here, it's more consistent with previous list_del_init().

> +               sbinfo->shrinklist_len++;
> +               spin_unlock(&sbinfo->shrinklist_lock);
> +put:
>                 iput(inode);
>         }
>
> -       spin_lock(&sbinfo->shrinklist_lock);
> -       list_splice_tail(&list, &sbinfo->shrinklist);
> -       sbinfo->shrinklist_len -= removed;
> -       spin_unlock(&sbinfo->shrinklist_lock);
> -
>         return split;
>  }
>
> --
> 2.20.1
>
