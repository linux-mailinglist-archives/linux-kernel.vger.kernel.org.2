Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF8733D8F2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbhCPQRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbhCPQRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:17:34 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D43C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:17:34 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id f20so37741804ioo.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhXlLpunwgdGqmi7lTefsnkX5/gTgDLW0xKii60Gcgw=;
        b=lBhcK5IrLiroft2/P+7HH1z/nUhKX97GFLSyY8BgXSS+RaXp14xRd96D8fRxhFPHZI
         3OrcJnkaFO5+epsMFy3ib38bMI5lfSMF3tHdlZ56G8xQoYW+0RrgcG60ekPEHPWgAqI1
         QNizX+rYvrbbArES/So2gu30yDDArZSQBJal1xdy59qhI0ZLBg1qiLyJriHsUJX9EwzL
         U5jG0bcIgxKxtBXyI8kSCp9iXpI7ahCPbvS0nYmZ+d7JErXIIZOW7MwcL3nBc+3DiXL8
         WapG93nRyPeE6lYCrihbfot9iGSLLdf4s4MbLZbCmWRX/9tqi06C2k1toVELnKY5+4Yz
         hbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhXlLpunwgdGqmi7lTefsnkX5/gTgDLW0xKii60Gcgw=;
        b=gOdZ7J4v0Scc3gn2s80KKvlOIyMzWz435gN7yEhcogr2Y2YP0cp6GBGqvfPYjVu2Ub
         f+l86Z79qkPU7ALkWrhBoYfj4UJTi5zRYIC5gMMEoS3IN+yDx9W55bfbomun+1pWR6KB
         QImdDt7jV9Js6bCS/Seg85rfmikiiwte1S0YGM3jDOEY3vkPm0lv1GB13RA1/FLvygZs
         rEZzOMPoP3Kmqcbelj/KCtnmNjQWeF5UljK9QtDmGO7B6cQiCw57axrb4TQxcU1cRsRn
         ES0vmwN0N8V2r9I4R4piBB7rz+kXo4FXfT1Tjlz0ofGpN9H5f1NcCX5wi99518JU1Vks
         JfsQ==
X-Gm-Message-State: AOAM53276k+wlCBbySZp5qOYn/hoe62D8oxCrYBChgxeVuztsNKw2hZ1
        /EmoHs/kFMc7HDVgYRYl2M1yxmJLcf39A8jidq6hnYBb/xKFUA==
X-Google-Smtp-Source: ABdhPJxLBP2ZkqDsxUal5VTcqXIbNKFDPmc1d/5Wk7yMuG00a3vA7erNsm7zuQnLrCDjai8bSkBdTE+BeLmAE4pqCmQ=
X-Received: by 2002:a5e:8610:: with SMTP id z16mr3811755ioj.57.1615911453452;
 Tue, 16 Mar 2021 09:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210316094910.23827-1-sjpark@amazon.com> <20210316153930.29827-1-sjpark@amazon.com>
In-Reply-To: <20210316153930.29827-1-sjpark@amazon.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 16 Mar 2021 09:16:57 -0700
Message-ID: <CAJHvVcgBrpg0pq4b4Lisc4Qsx4W_y=0_piEvO6AJV_Q2+o4ArQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/shmem: Enclose shmem_mcopy_atomic_pte() with 'CONFIG_USERFAULTFD'
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, amit@kernel.org,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the build failure! I sent a new version of my patch with
this same fix on the 10th
(https://lore.kernel.org/patchwork/patch/1392464/), and I believe
Andrew has already included it in his tree.

On Tue, Mar 16, 2021 at 8:40 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> Commit 49eeab03fa0a ("userfaultfd: support minor fault handling for
> shmem") introduced shmem_mcopy_atomic_pte().  The function is declared
> in 'userfaultfd_k.h' when 'CONFIG_USERFAULTFD' is defined, and defined
> as 'BUG()' if the config is unset.  However, the definition of the
> function in 'shmem.c' is not protected by the '#ifdef' macro.  As a
> result, the build fails when the config is not set.  This commit fixes
> the problem.
>
> Fixes: 49eeab03fa0a ("userfaultfd: support minor fault handling for shmem")
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>
> Changes from v1
> - Remove unnecessary internal code review URL
>
> ---
>  mm/shmem.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 547df2b766f7..c0d3abefeb3f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2359,6 +2359,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
>         return inode;
>  }
>
> +#ifdef CONFIG_USERFAULTFD
>  int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>                            struct vm_area_struct *dst_vma,
>                            unsigned long dst_addr, unsigned long src_addr,
> @@ -2492,6 +2493,7 @@ int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>         shmem_inode_unacct_blocks(inode, 1);
>         goto out;
>  }
> +#endif
>
>  #ifdef CONFIG_TMPFS
>  static const struct inode_operations shmem_symlink_inode_operations;
> --
> 2.17.1
>
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>
>
