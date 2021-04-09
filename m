Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD969359435
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 06:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhDIEye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 00:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhDIEyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 00:54:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7168C061760;
        Thu,  8 Apr 2021 21:54:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a25so6639690ejk.0;
        Thu, 08 Apr 2021 21:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dHS8UwKs/ahOQn9Zdri45LDjk6M6yUDTd6hAAfFIfj8=;
        b=EPZGi1dpU3BiTgjEmEbHYTlkUQdMf0dl8DQFnrpZxun7RQhjaaTbqQE+/wGpuWGu3f
         D3CbEkvrSuPNz/FM+fl0xG5X7kPciMh8xMYUezItQLdsXh6LeN4rOIPL7Z9HD7GycBwZ
         6vlgykqT338CIqFsWfNgahXdQv5gqfLajtO8PgiS0cF3LP27VeItZ2ltq1183CGwQwDv
         EDAgd/P+b0+VmXy/wLvIK3gPclblC/VnaWpiolbzjG6n+sq2ETBExs3OQWMHQe1VnioP
         qDo0jxjrM7aYgP37l63wvHHFLEB+2s7/xxJZsUSV9zsmYoKfQbSZz2WMZ3n8t5Jukxkw
         bDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dHS8UwKs/ahOQn9Zdri45LDjk6M6yUDTd6hAAfFIfj8=;
        b=sM5ODZCWHxY3AULfrfblwIa7VEfxrJpR7gOvBhbmITIJy2ShEEVSulGCPmoK2DU+5J
         4xgwBH70fRaH55dJ+Izo7kI/hcmC21MpViZa9tQLOJGwUd0r7kzAbW32VB5QKD+BfG6b
         4YOTuusVi81PM58cWaXkUuBvFBrYi2JpAlFgvvLi03vDsEiK5pUlFHeVdFpiIylTSlQM
         YVmbBfUpUAmTPsyN21aPbtGKkTxNOZ96Bn4s6EC9SBmQ0H9HCGNYR73ufDejC6riDtTf
         Q9ncsqIPtBjpjblC2mBQr28Hq2G51JZnp2uXqgxv+g6sDJfstuI7hp1yu5DHWLPPH96v
         GfQA==
X-Gm-Message-State: AOAM531KL472KRNvMLSDq1VOk2wqBA8WrSx69aptnfZctu9rEOAC4j2f
        GhxdmBltqw7ei0JVOZb8XxzKiXBlOU+HRV+dxGFol9uho/o=
X-Google-Smtp-Source: ABdhPJydEP/FSuV5X/DaYS1tAKDh2vMFrf+4thIYBD/zuIs/NYfxE6yP/I71tmcCKvNYacHD1qG+kGMLaHygRrtDR2o=
X-Received: by 2002:a17:906:8a7a:: with SMTP id hy26mr11480061ejc.509.1617944057543;
 Thu, 08 Apr 2021 21:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <1617942951-14631-1-git-send-email-konishi.ryusuke@gmail.com>
In-Reply-To: <1617942951-14631-1-git-send-email-konishi.ryusuke@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 9 Apr 2021 13:54:05 +0900
Message-ID: <CAKFNMomrx6=_7oByM9zs5YUunNQrHVquNYoQnqrkRimu82ajQQ@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: Fix typos in comments
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Please also queue this typo fix patch that came separately.

Thanks,
Ryusuke Konishi

On Fri, Apr 9, 2021 at 1:35 PM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> From: Lu Jialin <lujialin4@huawei.com>
>
> numer -> number in fs/nilfs2/cpfile.c
> Decription -> Description in fs/nilfs2/ioctl.c
> isntance -> instance in fs/nilfs2/the_nilfs.c
>
> Signed-off-by: Lu Jialin <lujialin4@huawei.com>
> Link: https://lore.kernel.org/r/20210409022519.176988-1-lujialin4@huawei.com
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> ---
>  fs/nilfs2/cpfile.c    | 2 +-
>  fs/nilfs2/ioctl.c     | 4 ++--
>  fs/nilfs2/the_nilfs.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
> index 025fb082575a..ce144776b4ef 100644
> --- a/fs/nilfs2/cpfile.c
> +++ b/fs/nilfs2/cpfile.c
> @@ -293,7 +293,7 @@ void nilfs_cpfile_put_checkpoint(struct inode *cpfile, __u64 cno,
>   * nilfs_cpfile_delete_checkpoints - delete checkpoints
>   * @cpfile: inode of checkpoint file
>   * @start: start checkpoint number
> - * @end: end checkpoint numer
> + * @end: end checkpoint number
>   *
>   * Description: nilfs_cpfile_delete_checkpoints() deletes the checkpoints in
>   * the period from @start to @end, excluding @end itself. The checkpoints
> diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
> index b053b40315bf..d1db73030085 100644
> --- a/fs/nilfs2/ioctl.c
> +++ b/fs/nilfs2/ioctl.c
> @@ -1058,7 +1058,7 @@ static int nilfs_ioctl_resize(struct inode *inode, struct file *filp,
>   * @inode: inode object
>   * @argp: pointer on argument from userspace
>   *
> - * Decription: nilfs_ioctl_trim_fs is the FITRIM ioctl handle function. It
> + * Description: nilfs_ioctl_trim_fs is the FITRIM ioctl handle function. It
>   * checks the arguments from userspace and calls nilfs_sufile_trim_fs, which
>   * performs the actual trim operation.
>   *
> @@ -1100,7 +1100,7 @@ static int nilfs_ioctl_trim_fs(struct inode *inode, void __user *argp)
>   * @inode: inode object
>   * @argp: pointer on argument from userspace
>   *
> - * Decription: nilfs_ioctl_set_alloc_range() function defines lower limit
> + * Description: nilfs_ioctl_set_alloc_range() function defines lower limit
>   * of segments in bytes and upper limit of segments in bytes.
>   * The NILFS_IOCTL_SET_ALLOC_RANGE is used by nilfs_resize utility.
>   *
> diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
> index 221a1cc597f0..8b7b01a380ce 100644
> --- a/fs/nilfs2/the_nilfs.c
> +++ b/fs/nilfs2/the_nilfs.c
> @@ -195,7 +195,7 @@ static int nilfs_store_log_cursor(struct the_nilfs *nilfs,
>  /**
>   * load_nilfs - load and recover the nilfs
>   * @nilfs: the_nilfs structure to be released
> - * @sb: super block isntance used to recover past segment
> + * @sb: super block instance used to recover past segment
>   *
>   * load_nilfs() searches and load the latest super root,
>   * attaches the last segment, and does recovery if needed.
> --
> 1.8.3.1
>
