Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7063B3588A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhDHPgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhDHPgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:36:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B69C061760;
        Thu,  8 Apr 2021 08:36:09 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a7so3817567eju.1;
        Thu, 08 Apr 2021 08:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCM1YxgbwjDa/UiZCDRIqswFy+DIOr/sFxTICllXj8I=;
        b=kFPgcBwVMG/PCtonTKSX4FohjVNuwKc6i675Hi5xTheQioqn2zD+J0tRySoFWutZl+
         gwZYRzWL4WMqGaPEy8/+pzwpISZoA56JEGHsfpZdftLIKyTWdDJXi0520ffDVEMXVXx2
         H/IVAHOmfPp838yPjeFrDEFFO7H7ulWBehoNjj/QeBlYzH4bUw8h1h7qpHAHhqjPc+V6
         H9NQc6oNMcx876al8eHXGEfuPE3lrYKg81zBO8t0y18jhE7q7BXOUOfpSvDc7GxLWQXL
         olfsX+DvgIBtzQdaULqslrTNM+mHb9tmxybsuzwVvT1+VAxNQ1yJMaJJX047dn03r0gt
         RMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCM1YxgbwjDa/UiZCDRIqswFy+DIOr/sFxTICllXj8I=;
        b=VbR/xr4JzRoybcIgTMDu/Py96KaE9ysQz6L+RFJzHYs+5/Se0/yXlsi7eIrsRV3RcW
         B56NZKc9AEehPoID44zIML4mnB0fxJx4ocqVIEzTdkHqk8iAWGcEEU5bcrKqW8Csuj0k
         Ki0S8VrXetZGYb+Md32PQznt4/pee7lnlvNXtN81Xxs+heE+7A3jKJ3JJ/YCD1n3IEyj
         CaM7XVuDQqZri8VxVPh6bxB15Pfup8ZPt2Y1GOCyhhTJcLXTkNBoIn2L/YmJyxwY9++/
         FGxoGl0tcENb+tJBBDYK8Ek6t+Td5FKcj2/r1YNFGz3T+itXvBH0K/cC1/0Pgz/IoZ/1
         vFeg==
X-Gm-Message-State: AOAM533x15vLpB45nv0OOAUm+0vAo+n5MS26zrQojebnd9DLTyRXYagR
        Sw4b68FONhYJVhRwll4RiNIgFG2na8XRVZNVXlA=
X-Google-Smtp-Source: ABdhPJxDoMsr+CPBB62VRae5R1LASX+A3U45pYTbKbAjnQkDFng4DOhIxzTitcC7HphMovCw53v6f3lURM6praB9cng=
X-Received: by 2002:a17:906:8a7a:: with SMTP id hy26mr8283320ejc.509.1617896168093;
 Thu, 08 Apr 2021 08:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210408140824.62010-1-lujialin4@huawei.com>
In-Reply-To: <20210408140824.62010-1-lujialin4@huawei.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 9 Apr 2021 00:35:56 +0900
Message-ID: <CAKFNMo=T_Key8jLqW_Q5mp4u7q7jymW=rqey9uDheFyaxMg1Tg@mail.gmail.com>
Subject: Re: [PATCH -next] nilfs2: Fix typos in comments
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

Hi,

This patch partially overlaps the following fix that I previously sent to
Andrew:

  https://lkml.org/lkml/2021/4/8/114

Can you exclude two typo fixes of "retured -> returned" from yours ?

Thanks,
Ryusuke Konishi

On Thu, Apr 8, 2021 at 11:08 PM Lu Jialin <lujialin4@huawei.com> wrote:
>
> numer -> number in fs/nilfs2/cpfile.c and fs/nilfs2/segment.c
> retured -> returned and Decription -> Description in fs/nilfs2/ioctl.c
> isntance -> instance in fs/nilfs2/the_nilfs.c
> No functionality changed.
>
> Signed-off-by: Lu Jialin <lujialin4@huawei.com>
> ---
>  fs/nilfs2/cpfile.c    | 2 +-
>  fs/nilfs2/ioctl.c     | 6 +++---
>  fs/nilfs2/segment.c   | 4 ++--
>  fs/nilfs2/the_nilfs.c | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
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
> index b053b40315bf..cbb59a6c4b81 100644
> --- a/fs/nilfs2/ioctl.c
> +++ b/fs/nilfs2/ioctl.c
> @@ -979,7 +979,7 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
>   * and metadata are written out to the device when it successfully
>   * returned.
>   *
> - * Return Value: On success, 0 is retured. On errors, one of the following
> + * Return Value: On success, 0 is returned. On errors, one of the following
>   * negative error code is returned.
>   *
>   * %-EROFS - Read only filesystem.
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
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index cd4da9535aed..686c8ee7b29c 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -2214,7 +2214,7 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
>   * nilfs_construct_segment - construct a logical segment
>   * @sb: super block
>   *
> - * Return Value: On success, 0 is retured. On errors, one of the following
> + * Return Value: On success, 0 is returned. On errors, one of the following
>   * negative error code is returned.
>   *
>   * %-EROFS - Read only filesystem.
> @@ -2251,7 +2251,7 @@ int nilfs_construct_segment(struct super_block *sb)
>   * @start: start byte offset
>   * @end: end byte offset (inclusive)
>   *
> - * Return Value: On success, 0 is retured. On errors, one of the following
> + * Return Value: On success, 0 is returned. On errors, one of the following
>   * negative error code is returned.
>   *
>   * %-EROFS - Read only filesystem.
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
