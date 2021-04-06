Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674E535499B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 02:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242943AbhDFAQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 20:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbhDFAQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 20:16:00 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FE7C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 17:15:52 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u4so14422690ljo.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 17:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=Yp7vvWni51LV8EH8AK8AP/Z8kIvz7Dlwt8s0OEZWhTU=;
        b=u94Nzhwf1aopm5vCcjdO0RYqds0EHpaKSuc/nLxE5Eu4Qz6VvqUVJthq9kNsrz/7Nf
         7OGziOdkgqU/cMgqUujqVxOTwGb32vTkSnGudlsCB8Iv4Itiw/jkHJWNXW/gCovxUiEq
         bWsIZGVhylzhTe3g4xh81OlJNZ6zZBpz2vx9WyX0oOqRJH+mrJoWaU3VYsoeUP5SHgQQ
         V/XJIS7v6S3a0MrkAutaFSWBtwXVOdeHhFHEa6PrkgZOTUJOetSEAdclOcAqqun7VRAQ
         60O4pl+iPvlD0MQyoZGzPYR6J0riRB8NfPkY1SsdMIorXB3DHlabpFQsmlhOKLZ5F7XN
         Kaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=Yp7vvWni51LV8EH8AK8AP/Z8kIvz7Dlwt8s0OEZWhTU=;
        b=ig9mqXnSxQZreawLGznLLC68axH1/PPIto+3JIYO4WusWxl2GeT57oEKok/DgkjCdx
         HOYP3DIXEaLBxBGhcYWj/RT1qKVVHpe/otnxNqTAEuBPjzDl588aEvK3wnQbNvzUCgG+
         6UKB0q/Yc1Zq7M87ZZn1gdy0laUmgNC8ojXWmFP7qqb+GaZLeasrJuxVMVmpmZtfPoEg
         hnTVJcAdZ1U2/vQD/W2O3X1aO02/iEoBfQikCk34UQIxJ95a65MOClqTNizYl0yayChL
         QHfR3KLdJ2WkTHmlrgc/iPsHqRzVsXqy1xYG3/+HMg+aH8X7ztMxU4bs5oe6+0j3rAKf
         ktTg==
X-Gm-Message-State: AOAM532FNJN2Ywdp5UYUe+x0gSZozYPLOKRmK8bH1XU+ToS254Onp6wf
        ttiIBHQiOFZEL8zIC1c1hipbi4WQx3V1p/SG+s6o+w==
X-Received: by 2002:a2e:b0d0:: with SMTP id g16mt7992674ljl.382.1617668150982;
 Mon, 05 Apr 2021 17:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210322215823.962758-1-cfijalkovich@google.com>
In-Reply-To: <20210322215823.962758-1-cfijalkovich@google.com>
From:   Collin Fijalkovich <cfijalkovich@google.com>
Date:   Mon, 5 Apr 2021 17:15:40 -0700
Message-ID: <CAL+PeoEpuOMOOL7=TTu7dKhHxO3Yb5CoTiMFeYGskx23bXkXhg@mail.gmail.com>
Subject: Re: [PATCH] mm, thp: Relax the VM_DENYWRITE constraint on file-backed THPs
Cc:     Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Hugh Dickins <hughd@google.com>,
        Tim Murray <timmurray@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 has been uploaded with performance testing results:
https://lore.kernel.org/patchwork/patch/1408266/



On Mon, Mar 22, 2021 at 2:59 PM Collin Fijalkovich
<cfijalkovich@google.com> wrote:
>
> Transparent huge pages are supported for read-only non-shmem filesystems,
> but are only used for vmas with VM_DENYWRITE. This condition ensures that
> file THPs are protected from writes while an application is running
> (ETXTBSY).  Any existing file THPs are then dropped from the page cache
> when a file is opened for write in do_dentry_open(). Since sys_mmap
> ignores MAP_DENYWRITE, this constrains the use of file THPs to vmas
> produced by execve().
>
> Systems that make heavy use of shared libraries (e.g. Android) are unable
> to apply VM_DENYWRITE through the dynamic linker, preventing them from
> benefiting from the resultant reduced contention on the TLB.
>
> This patch reduces the constraint on file THPs allowing use with any
> executable mapping from a file not opened for write (see
> inode_is_open_for_write()). It also introduces additional conditions to
> ensure that files opened for write will never be backed by file THPs.
>
> Restricting the use of THPs to executable mappings eliminates the risk that
> a read-only file later opened for write would encounter significant
> latencies due to page cache truncation.
>
> The ld linker flag '-z max-page-size=(hugepage size)' can be used to
> produce executables with the necessary layout. The dynamic linker must
> map these file's segments at a hugepage size aligned vma for the mapping to
> be backed with THPs.
>
> Signed-off-by: Collin Fijalkovich <cfijalkovich@google.com>
> ---
>  fs/open.c       | 13 +++++++++++--
>  mm/khugepaged.c | 16 +++++++++++++++-
>  2 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/fs/open.c b/fs/open.c
> index e53af13b5835..f76e960d10ea 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -852,8 +852,17 @@ static int do_dentry_open(struct file *f,
>          * XXX: Huge page cache doesn't support writing yet. Drop all page
>          * cache for this file before processing writes.
>          */
> -       if ((f->f_mode & FMODE_WRITE) && filemap_nr_thps(inode->i_mapping))
> -               truncate_pagecache(inode, 0);
> +       if (f->f_mode & FMODE_WRITE) {
> +               /*
> +                * Paired with smp_mb() in collapse_file() to ensure nr_thps
> +                * is up to date and the update to i_writecount by
> +                * get_write_access() is visible. Ensures subsequent insertion
> +                * of THPs into the page cache will fail.
> +                */
> +               smp_mb();
> +               if (filemap_nr_thps(inode->i_mapping))
> +                       truncate_pagecache(inode, 0);
> +       }
>
>         return 0;
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a7d6cb912b05..4c7cc877d5e3 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -459,7 +459,8 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
>
>         /* Read-only file mappings need to be aligned for THP to work. */
>         if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
> -           (vm_flags & VM_DENYWRITE)) {
> +           !inode_is_open_for_write(vma->vm_file->f_inode) &&
> +           (vm_flags & VM_EXEC)) {
>                 return IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
>                                 HPAGE_PMD_NR);
>         }
> @@ -1872,6 +1873,19 @@ static void collapse_file(struct mm_struct *mm,
>         else {
>                 __mod_lruvec_page_state(new_page, NR_FILE_THPS, nr);
>                 filemap_nr_thps_inc(mapping);
> +               /*
> +                * Paired with smp_mb() in do_dentry_open() to ensure
> +                * i_writecount is up to date and the update to nr_thps is
> +                * visible. Ensures the page cache will be truncated if the
> +                * file is opened writable.
> +                */
> +               smp_mb();
> +               if (inode_is_open_for_write(mapping->host)) {
> +                       result = SCAN_FAIL;
> +                       __mod_lruvec_page_state(new_page, NR_FILE_THPS, -nr);
> +                       filemap_nr_thps_dec(mapping);
> +                       goto xa_locked;
> +               }
>         }
>
>         if (nr_none) {
> --
> 2.31.0.rc2.261.g7f71774620-goog
>
