Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DB24154D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 02:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbhIWAze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 20:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbhIWAzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 20:55:32 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6E4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 17:54:01 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v10so12272437edj.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 17:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JtxnXX0Zz37aXmCGF7NCAeAU4u0TOULNgnuj5xvQ+vk=;
        b=OtSRzojsbDGJ56UGIJBgr9gyujkLp+c/QQl3+lNLl3SgCXsChOEcx768sAMmVXdVjh
         NNa6Uq3vdsdlcx4t4Jeqs3wbKrvFbxmz3hQMyGLD87769JM8U02SpVwvXWWZy94015uS
         +TtKehkAK7Is5rg4RvzKibR4jSfka0CF85HH/yVyqlCiFW5uhrydLXlbhK++t7VcFFWW
         Sefz8AigQJhZeuGFyyX2ZKHP2234npMSWRK6dHX8BAfGkdDcgyMimXoNsrkNIxkST6nA
         gBSToDdMtX+YxUEPhjC4kmR3bQivs65WXuNCwZxaQ+noE2pSu2dUZkNhiGe82pwECHKD
         b6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JtxnXX0Zz37aXmCGF7NCAeAU4u0TOULNgnuj5xvQ+vk=;
        b=BMg4c/QEs/jPG0o36xwJTCgTjZVgo85TFUFL0bgmpqm2x8hJywb6KUNzfpdKchXZ2H
         vRfnMKakuq6ETMmRtK2HktkzvAEgC94ZEmN5qFC9dHVMNgsDN+Ei+kVwNdYMfg2dL6P4
         9Pp6iOnU0NLnUQvHp5jSodhqjib7+3hWo9XAH3YLp1SCdrFbqAz38/QxX3wk/+NIprL2
         4nEGRexIV4RcWhpYkkUlbzaCiw+RDr/kiSLFPryqSQz8w0KkF/P+Rh3hbuZBDMnOeRz7
         WEl47kT3kQI+3Tz6qzru18LjxHZ/AsZuV3PftGOoqvNAVAZdjjMGdL/5kop9rMuP8UmC
         c6Lw==
X-Gm-Message-State: AOAM530s0OHfghQfVu/svX4GGoxv1n+lUndGRRCABENEK8QbLceg6G3G
        QEHl+ObxbwRpq1pyi3Sd+ES39ra2x1Y7qXTc3z0=
X-Google-Smtp-Source: ABdhPJw7pFRqE/fMdJsyDgu/hzVen2ey6wN3BNuq6I3GBBupfD6dNPoupABjjqanjL5LdIA70omMoxuMveXAVTJVZT8=
X-Received: by 2002:a17:906:974d:: with SMTP id o13mr2149832ejy.563.1632358440491;
 Wed, 22 Sep 2021 17:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210904023800.1813036-1-mudongliangabcd@gmail.com>
In-Reply-To: <20210904023800.1813036-1-mudongliangabcd@gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 23 Sep 2021 08:53:34 +0800
Message-ID: <CAD-N9QV5OMe0ryEKaUYkwmNyOtu+Sgi7h2B0JFSK5Jj9bbQPQQ@mail.gmail.com>
Subject: Re: [PATCH v2] JFS: fix memleak in jfs_mount
To:     Dave Kleikamp <shaggy@kernel.org>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any update on this thread?

On Sat, Sep 4, 2021 at 10:38 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> In jfs_mount, when diMount(ipaimap2) fails, it goes to errout35. However,
> the following code does not free ipaimap2 allocated by diReadSpecial.
>
> Fix this by refactoring the error handling code of jfs_mount. To be
> specific, modify the lable name and free ipaimap2 when the above error
> ocurrs.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
> v1->v2: change "return rc" to "goto out"; fix one coding style
>  fs/jfs/jfs_mount.c | 51 ++++++++++++++++++++--------------------------
>  1 file changed, 22 insertions(+), 29 deletions(-)
>
> diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
> index 5d7d7170c03c..aa4ff7bcaff2 100644
> --- a/fs/jfs/jfs_mount.c
> +++ b/fs/jfs/jfs_mount.c
> @@ -81,14 +81,14 @@ int jfs_mount(struct super_block *sb)
>          * (initialize mount inode from the superblock)
>          */
>         if ((rc = chkSuper(sb))) {
> -               goto errout20;
> +               goto out;
>         }
>
>         ipaimap = diReadSpecial(sb, AGGREGATE_I, 0);
>         if (ipaimap == NULL) {
>                 jfs_err("jfs_mount: Failed to read AGGREGATE_I");
>                 rc = -EIO;
> -               goto errout20;
> +               goto out;
>         }
>         sbi->ipaimap = ipaimap;
>
> @@ -99,7 +99,7 @@ int jfs_mount(struct super_block *sb)
>          */
>         if ((rc = diMount(ipaimap))) {
>                 jfs_err("jfs_mount: diMount(ipaimap) failed w/rc = %d", rc);
> -               goto errout21;
> +               goto err_ipaimap;
>         }
>
>         /*
> @@ -108,7 +108,7 @@ int jfs_mount(struct super_block *sb)
>         ipbmap = diReadSpecial(sb, BMAP_I, 0);
>         if (ipbmap == NULL) {
>                 rc = -EIO;
> -               goto errout22;
> +               goto err_umount_ipaimap;
>         }
>
>         jfs_info("jfs_mount: ipbmap:0x%p", ipbmap);
> @@ -120,7 +120,7 @@ int jfs_mount(struct super_block *sb)
>          */
>         if ((rc = dbMount(ipbmap))) {
>                 jfs_err("jfs_mount: dbMount failed w/rc = %d", rc);
> -               goto errout22;
> +               goto err_ipbmap;
>         }
>
>         /*
> @@ -139,7 +139,7 @@ int jfs_mount(struct super_block *sb)
>                 if (!ipaimap2) {
>                         jfs_err("jfs_mount: Failed to read AGGREGATE_I");
>                         rc = -EIO;
> -                       goto errout35;
> +                       goto err_umount_ipbmap;
>                 }
>                 sbi->ipaimap2 = ipaimap2;
>
> @@ -151,7 +151,7 @@ int jfs_mount(struct super_block *sb)
>                 if ((rc = diMount(ipaimap2))) {
>                         jfs_err("jfs_mount: diMount(ipaimap2) failed, rc = %d",
>                                 rc);
> -                       goto errout35;
> +                       goto err_ipaimap2;
>                 }
>         } else
>                 /* Secondary aggregate inode table is not valid */
> @@ -168,7 +168,7 @@ int jfs_mount(struct super_block *sb)
>                 jfs_err("jfs_mount: Failed to read FILESYSTEM_I");
>                 /* open fileset secondary inode allocation map */
>                 rc = -EIO;
> -               goto errout40;
> +               goto err_umount_ipaimap2;
>         }
>         jfs_info("jfs_mount: ipimap:0x%p", ipimap);
>
> @@ -178,41 +178,34 @@ int jfs_mount(struct super_block *sb)
>         /* initialize fileset inode allocation map */
>         if ((rc = diMount(ipimap))) {
>                 jfs_err("jfs_mount: diMount failed w/rc = %d", rc);
> -               goto errout41;
> +               goto err_ipimap;
>         }
>
> -       goto out;
> +       return rc;
>
>         /*
>          *      unwind on error
>          */
> -      errout41:                /* close fileset inode allocation map inode */
> +err_ipimap:
> +       /* close fileset inode allocation map inode */
>         diFreeSpecial(ipimap);
> -
> -      errout40:                /* fileset closed */
> -
> +err_umount_ipaimap2:
>         /* close secondary aggregate inode allocation map */
> -       if (ipaimap2) {
> +       if (ipaimap2)
>                 diUnmount(ipaimap2, 1);
> +err_ipaimap2:
> +       /* close aggregate inodes */
> +       if (ipaimap2)
>                 diFreeSpecial(ipaimap2);
> -       }
> -
> -      errout35:
> -
> -       /* close aggregate block allocation map */
> +err_umount_ipbmap:     /* close aggregate block allocation map */
>         dbUnmount(ipbmap, 1);
> +err_ipbmap:            /* close aggregate inodes */
>         diFreeSpecial(ipbmap);
> -
> -      errout22:                /* close aggregate inode allocation map */
> -
> +err_umount_ipaimap:    /* close aggregate inode allocation map */
>         diUnmount(ipaimap, 1);
> -
> -      errout21:                /* close aggregate inodes */
> +err_ipaimap:           /* close aggregate inodes */
>         diFreeSpecial(ipaimap);
> -      errout20:                /* aggregate closed */
> -
> -      out:
> -
> +out:
>         if (rc)
>                 jfs_err("Mount JFS Failure: %d", rc);
>
> --
> 2.25.1
>
