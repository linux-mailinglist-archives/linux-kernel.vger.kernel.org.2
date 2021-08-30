Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5319E3FB24A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 10:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhH3IQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbhH3IQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 04:16:27 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5FCC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:15:33 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eb14so11129974edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PULVD8Tt/i1F2Zu50bq8VYUQ0dJK4dOLAdcFqlBPDxM=;
        b=Bm2659KE37r3KLmF5KXzNzVgCMphfHBJ4AeM4UEHLCfKRPtyqlp277y+Cd/zwVThis
         QKWU2s+hDCRpLAkRSIrV+qMTqKJKbqUg0+6Re5wlWxubRAXK0XoAzgJK7FdbudpZJOFp
         ntSnU75MSeK566FnGjFw8pt8T2Wq6n5owWONTAMWnaUpvZoa2vMwTVhDL6rf71TGeTkH
         h6N631M0VCAaMNlNo1cN6TevdkhVI2yxLC58Xw7Usx5e/mt6mG/a6oo0SKp49K1BPpFH
         Bw9GoJhsUZqlXIstlKFLuyq4JRfsRgYILL7l/Ri4x+VB4VL09OQMX2OpnE6sLwBeqQZm
         MB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PULVD8Tt/i1F2Zu50bq8VYUQ0dJK4dOLAdcFqlBPDxM=;
        b=hAJgC0w+laJEcuOWdDy3kfaMRlOPw0qHfBKRDzoOQ8UIB1i5G3cuIMdNUS8GHnYlTW
         qGfg77srbPdULSEfyUPTTEZue/toRJ4VAFmI3yHetOoa37DeIevlXvUF9e9/SbejVNOe
         WglmAZ9qhealjYh8PO0+zj4lX05laj3m17gqoqbXZhSznCQxXIMTw7r3hXVgiyLtgZSL
         gfNDRMuIz14Ng1lfm41lGtSBnNlkCSSb5C3S1r7Damx40x1KmCaK7UdnSfziY5CLINDp
         EZJYTAE6KMH8K2Os8V3F+vyOQiwBHh2DIQuw3/9F9d0u8Bq1aYaZW4i9YYy2+rTxvNVC
         J8wg==
X-Gm-Message-State: AOAM531tSkLQYbEMIDNL2wj9Q7qKvpEUYFzEOsFIVd3KzUkbKAvrfLFL
        pwFmB5km3CCQJOoUHAf+vz01XDYS0VwT9xaMJgI=
X-Google-Smtp-Source: ABdhPJyYDZGYZSNfbAWTuOL+qZ9is47kppZD33wj9EyK9D6ofHPz3x0/QBFlb/K4tvwggtTHJSXZAqiEWvWm7du2+eU=
X-Received: by 2002:aa7:c88e:: with SMTP id p14mr23257354eds.174.1630311331667;
 Mon, 30 Aug 2021 01:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210818102612.864127-1-mudongliangabcd@gmail.com>
In-Reply-To: <20210818102612.864127-1-mudongliangabcd@gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 30 Aug 2021 16:15:05 +0800
Message-ID: <CAD-N9QUQ1p_Zu1zdL3ZOtxmyw3z4CR3K3VL2FkLP=aJYhT8cUQ@mail.gmail.com>
Subject: Re: [PATCH] JFS: fix memleak in jfs_mount
To:     Dave Kleikamp <shaggy@kernel.org>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 6:26 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> In jfs_mount, when diMount(ipaimap2) fails, it goes to errout35. However,
> the following code does not free ipaimap2 allocated by diReadSpecial.
>
> Fix this by refactoring the error handling code of jfs_mount. To be
> specific, modify the lable name and free ipaimap2 when the above error
> ocurrs.
>

Hi maintainers,

any comment on this patch?

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  fs/jfs/jfs_mount.c | 53 +++++++++++++++++++---------------------------
>  1 file changed, 22 insertions(+), 31 deletions(-)
>
> diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
> index 5d7d7170c03c..638a4ecc4069 100644
> --- a/fs/jfs/jfs_mount.c
> +++ b/fs/jfs/jfs_mount.c
> @@ -81,14 +81,14 @@ int jfs_mount(struct super_block *sb)
>          * (initialize mount inode from the superblock)
>          */
>         if ((rc = chkSuper(sb))) {
> -               goto errout20;
> +               return rc;
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
> @@ -178,41 +178,32 @@ int jfs_mount(struct super_block *sb)
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
> -               diUnmount(ipaimap2, 1);
> -               diFreeSpecial(ipaimap2);
> -       }
> -
> -      errout35:
> -
> -       /* close aggregate block allocation map */
> +       if (ipaimap2) diUnmount(ipaimap2, 1);
> +err_ipaimap2:
> +       /* close aggregate inodes */
> +       if (ipaimap2) diFreeSpecial(ipaimap2);
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
