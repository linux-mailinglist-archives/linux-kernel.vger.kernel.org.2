Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BA1359251
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 04:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhDIC7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 22:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhDIC7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 22:59:01 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2A9C061760;
        Thu,  8 Apr 2021 19:58:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l4so6267131ejc.10;
        Thu, 08 Apr 2021 19:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4pkGmtByhP2aITlEGQOOUqZPg4jAB0GZ7xHME3a0oG8=;
        b=XYs+D88PW716AZsRNzTFVJE/vNwOFR5G9+5w5XxQ2KToz15ouNopihw8Db2upVuyIs
         w66/4ue5dcecuWjFySN8Esz4VwhuHy1SngZ+59/fbNbTBQdsR6ZQ46q1cb5sxWis3/EV
         4gfWP9noIWbh/Y9u+Ao+Lqs96DX9ojo7F0sUQ+tMhl2Xd6m/tq+9E4cp1bjLORcg1WeM
         NUdcdVUQPlpl7fzZ4Vj/arg6lhMlgLPNoPd+GHROfDZRC/rgjLsuzrnb57pZpfGWK0R7
         tggBoMn3dm5vJkLCKmsxIluTQOwkXMl7B3aHDD55DRf4NOJYZjENr8b6pro6t0d2RYXb
         +Umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4pkGmtByhP2aITlEGQOOUqZPg4jAB0GZ7xHME3a0oG8=;
        b=kBPjzJmD+frhUNbV8crT9TsHIDi8r64S7xLrLNbxYjBdc7yX0X9pUEzMAk/mg9JsfN
         4bAMerckuQSBoUxrz6gibvaioGbh8YPaQVrqVgEhYOSmS4/lkG5oWOvtciLdUUG6TRn9
         6gOPROPqQr2bh3SeM7pjdQvN1YKuv5CcuScgWDeuCOWVTBMDE0jiilQnmbzjZ4pxasJ2
         XFEfuLI4rLbp7yGBajxHiDvMMnjalZc+30swIggOmPC2j+jCJHUvSBluZKbqnyvYrLLe
         FZMocXpWH1Wb9rxjHa6YXxDE44rX1EY+EKJuACqzevWnXjf1Xp5T2WmOPI7Gudgdv814
         Z+vQ==
X-Gm-Message-State: AOAM530ABW00xNbQ4yF8ClAicHzgDHGaVSFKxNr8nv/b5A2oslHi3nbf
        MbBGSlBy3PAaXm2GNNZPm61BokXrv+jzTOhzqfw=
X-Google-Smtp-Source: ABdhPJzJ0UMFIY53EPDqrsp+nc23um/q3LkzIXPtNrhndZCAylUcQNtkArw/PJ0FDp0N8zHHQkRGziTjfmQq2DG8K9Q=
X-Received: by 2002:a17:906:f283:: with SMTP id gu3mr13849081ejb.91.1617937127899;
 Thu, 08 Apr 2021 19:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210408140824.62010-1-lujialin4@huawei.com> <20210409022519.176988-1-lujialin4@huawei.com>
In-Reply-To: <20210409022519.176988-1-lujialin4@huawei.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 9 Apr 2021 11:58:36 +0900
Message-ID: <CAKFNMom6T1vDoS+ojD9rKgMGThU9AVK1ZH+5zxREo8xc+cwvkQ@mail.gmail.com>
Subject: Re: [PATCH v2 -next] nilfs2: Fix typos in comments
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     James Morris <jamorris@linux.microsoft.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Xiang Yang <xiangyang3@huawei.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Cui GaoSheng <cuigaosheng1@huawei.com>,
        Gong Ruiqi <gongruiqi1@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you.  Will apply this.

Ryusuke Konishi

On Fri, Apr 9, 2021 at 11:25 AM Lu Jialin <lujialin4@huawei.com> wrote:
>
> numer -> number in fs/nilfs2/cpfile.c
> Decription -> Description in fs/nilfs2/ioctl.c
> isntance -> instance in fs/nilfs2/the_nilfs.c
>
> Signed-off-by: Lu Jialin <lujialin4@huawei.com>
> ---
> v2:
> Exclude two typo fixes of "retured -> returned", which has been fixed in
> previous patch.
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
> 2.17.1
>
