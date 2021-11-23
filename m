Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDAD459D79
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhKWIK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbhKWIKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:10:55 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FD1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 00:07:48 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id g17so57192999ybe.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 00:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L7f/aUCx8NVGyPLAzQitqS+/TnPxMztetwJciVabBeY=;
        b=6zYWJZpyiKoP/AjChWdk1Mr9Z+WI7uA/FCe9DJ4VdNTGfHUGW6kovw2NXoBFhpBuoX
         dlpB/M+nkDCo/zUyd4459F4SRRQvlGSJuVTysZ2DaOizLM4EzXsiNoevCXU6PSUscy13
         OWPWbbmTJ5NQZ9DSVUebf9g93zxFh8Ioj3Ec4/eE2+qDJ5pytC/DU5WMSgxgUrz0VrVJ
         3O+PabJz3r7AI7YvtG+2K4CgxrUvvJsCZCvGI5RLFnDMyPTMlkbsWphicq2wyT5ZZcXH
         XaqjDK4q8/oe6I9pXBzNTyaqTbTEIzv4E9exyDBbk+0FF7E0UDgMIGAT2WRaz0VHl1kj
         dFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7f/aUCx8NVGyPLAzQitqS+/TnPxMztetwJciVabBeY=;
        b=t0C7EjxagOhkrmH/ScJYTyZ0dso81C5qbymtUrPq0vHTkeXEdnZB1dWDZF8rYp8huA
         xWsJv/GVwqViiHK8NXT+lCwzjygwyMIDbNCYp0hwHNiGzJvH/VSmOVXgdVcTx2J4riLp
         IeC2lHYJq3seGkEGpH24vaQABycOHO/61kFuxQsawKI3fDclJMzm/XGE79+ueBcT1AR8
         rJl8YmVNFPTr5w/+XsnqIp0/4UyGkdAlAru39E5kJFbhYtOdSeCqIo5TdB1Y+51JK8ak
         t9lXa5T2+95xKW3F3s1YMK2nMpevH1mxEVvG/AZFaNjUUuX2pEreAwzITpKs6tqv0wEa
         Jsmg==
X-Gm-Message-State: AOAM533ZTd9jtGQZWWH/nChaXQEFQfsqrIMXQOTXatQhodQKGXJ0SZo2
        YRtCKhaa5mu/T/1d/Vq6qJHBFAXRmrSQIrhkGO3BnW8ErhmrqjsD
X-Google-Smtp-Source: ABdhPJy3xKrLsQ0i80CPUA2i00XnDJy+VKNkyTyS6MSn4PZJcxsnkeGO5hPSCe+BtbPNtMbMhCHrOuQSPHwUs6nKpuY=
X-Received: by 2002:a25:38d6:: with SMTP id f205mr4321963yba.208.1637654867187;
 Tue, 23 Nov 2021 00:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20211122064126.76734-1-ligang.bdlg@bytedance.com>
In-Reply-To: <20211122064126.76734-1-ligang.bdlg@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 23 Nov 2021 16:07:08 +0800
Message-ID: <CAMZfGtWmpynXNgjBqDzat5JQAQ95Ja1p55AxR6En8AkZ8iXjKQ@mail.gmail.com>
Subject: Re: [PATCH v1] shmem: change shrinklist_lock form spinlock to mutex
 and move iput into it
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

On Mon, Nov 22, 2021 at 2:41 PM Gang Li <ligang.bdlg@bytedance.com> wrote:
>
> This patch fixes commit 779750d20b93 ("shmem: split huge pages
> beyond i_size under memory pressure").
>
> iput out of sbinfo->shrinklist_lock will let shmem_evict_inode grab
> and delete the inode, which will berak the consistency between
> shrinklist_len and shrinklist. The simultaneous deletion of adjacent
> elements in the local list "list" by shmem_unused_huge_shrink and
> shmem_evict_inode will also break the list.
>
> iput must in lock or after lock, but shrinklist_lock is a spinlock
> which can not sleep and iput may sleep.[1]
>
> Fix it by changing shrinklist_lock from spinlock to mutex and moving iput
> into this lock.
>
> [1]. Link: http://lkml.kernel.org/r/20170131093141.GA15899@node.shutemov.name
> Fixes: 779750d20b93 ("shmem: split huge pages beyond i_size under memory pressure")
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> ---
>  include/linux/shmem_fs.h |  2 +-
>  mm/shmem.c               | 16 +++++++---------
>  2 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 166158b6e917..65804fd264d0 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -41,7 +41,7 @@ struct shmem_sb_info {
>         ino_t next_ino;             /* The next per-sb inode number to use */
>         ino_t __percpu *ino_batch;  /* The next per-cpu inode number to use */
>         struct mempolicy *mpol;     /* default memory policy for mappings */
> -       spinlock_t shrinklist_lock;   /* Protects shrinklist */
> +       struct mutex shrinklist_mutex;/* Protects shrinklist */
>         struct list_head shrinklist;  /* List of shinkable inodes */
>         unsigned long shrinklist_len; /* Length of shrinklist */
>  };
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 18f93c2d68f1..2165a28631c5 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -559,7 +559,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>         if (list_empty(&sbinfo->shrinklist))
>                 return SHRINK_STOP;
>
> -       spin_lock(&sbinfo->shrinklist_lock);
> +       mutex_lock(&sbinfo->shrinklist_mutex);
>         list_for_each_safe(pos, next, &sbinfo->shrinklist) {
>                 info = list_entry(pos, struct shmem_inode_info, shrinklist);
>
> @@ -586,7 +586,6 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>                 if (!--batch)
>                         break;
>         }
> -       spin_unlock(&sbinfo->shrinklist_lock);
>
>         list_for_each_safe(pos, next, &to_remove) {
>                 info = list_entry(pos, struct shmem_inode_info, shrinklist);
> @@ -643,10 +642,9 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>                 iput(inode);

It could lead to deadlock, since we could be the last user
of @inode, then shmem_evict_inode() will be called and
try to acquire the mutex lock. Notice that the mutex is already
held here.

Thanks.

>         }
>
> -       spin_lock(&sbinfo->shrinklist_lock);
>         list_splice_tail(&list, &sbinfo->shrinklist);
>         sbinfo->shrinklist_len -= removed;
> -       spin_unlock(&sbinfo->shrinklist_lock);
> +       mutex_unlock(&sbinfo->shrinklist_mutex);
>
>         return split;
>  }
> @@ -1137,12 +1135,12 @@ static void shmem_evict_inode(struct inode *inode)
>                 inode->i_size = 0;
>                 shmem_truncate_range(inode, 0, (loff_t)-1);
>                 if (!list_empty(&info->shrinklist)) {
> -                       spin_lock(&sbinfo->shrinklist_lock);
> +                   mutex_lock(&sbinfo->shrinklist_mutex);
>                         if (!list_empty(&info->shrinklist)) {
>                                 list_del_init(&info->shrinklist);
>                                 sbinfo->shrinklist_len--;
>                         }
> -                       spin_unlock(&sbinfo->shrinklist_lock);
> +                   mutex_unlock(&sbinfo->shrinklist_mutex);
>                 }
>                 while (!list_empty(&info->swaplist)) {
>                         /* Wait while shmem_unuse() is scanning this inode... */
> @@ -1954,7 +1952,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>                  * Part of the huge page is beyond i_size: subject
>                  * to shrink under memory pressure.
>                  */
> -               spin_lock(&sbinfo->shrinklist_lock);
> +               mutex_lock(&sbinfo->shrinklist_mutex);
>                 /*
>                  * _careful to defend against unlocked access to
>                  * ->shrink_list in shmem_unused_huge_shrink()
> @@ -1964,7 +1962,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>                                       &sbinfo->shrinklist);
>                         sbinfo->shrinklist_len++;
>                 }
> -               spin_unlock(&sbinfo->shrinklist_lock);
> +               mutex_unlock(&sbinfo->shrinklist_mutex);
>         }
>
>         /*
> @@ -3652,7 +3650,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>         raw_spin_lock_init(&sbinfo->stat_lock);
>         if (percpu_counter_init(&sbinfo->used_blocks, 0, GFP_KERNEL))
>                 goto failed;
> -       spin_lock_init(&sbinfo->shrinklist_lock);
> +       mutex_init(&sbinfo->shrinklist_mutex);
>         INIT_LIST_HEAD(&sbinfo->shrinklist);
>
>         sb->s_maxbytes = MAX_LFS_FILESIZE;
> --
> 2.20.1
>
