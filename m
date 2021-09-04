Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E5B400950
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 04:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350793AbhIDC1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 22:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhIDC1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 22:27:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54906C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 19:26:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bt14so1649339ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 19:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JeKEljdOKKIb0F4prVa6PwXBW4S9Qd2Aq67n9H76mXg=;
        b=e99RlrgvIirzTxeRgaSjtT8FR/bQd4M9OxtBgP+Z1pDYwQrRJjldv/ht9il4CXfCVy
         yMLApQZj1QHubSXqK+8kabdVjV4EGYRFNyup/8F/dd6M2p5K4JAAnyPlQrPfuo4QiiNm
         9FOR5CQeWQhF2qEncnrlNUd8B/Qg74qh6qnVtOLsG4xZ+oEX+CM45TabzIA5qIz5e4sR
         gek9TGQJoLCM2rMdbPNcH+xq37vEx+85gWuBqM8xfX/ByzGHJcMLz9ZG2zDdKHMSqLXn
         1k3H4cdR04UeDp1JVbk3bShQlhw1GfZzWGCLwaraeOvFDbXmRAInDuf3ljk9qC8c8q0y
         QpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JeKEljdOKKIb0F4prVa6PwXBW4S9Qd2Aq67n9H76mXg=;
        b=AMCc0woop3PHt8vQ2wVDvhEy+jhJCVUNTt0gvPsoyu/WTdru8jGgFKi9TXqu0HsIVq
         vtKBZ1XAp15XW3M95GFUZwUGD88pRQ02n3avFHZYpvCPl0uWMnvG3YJO6yS/d+uZsl9j
         0Db2trwVUAXvHYvQ8WgaNoIvYglVprXowcyxxjSK/hYdxIFJXzPdsaEtvC0g9GexxBVX
         89YZhGEVHgyOrUYxdB/yAPAsw7wt/k5kAF1M8sRwYLazVxIjHwJ9tyM/uk+mGVtqH3RE
         fq/UC0jnKZaL8M71jvnIb5iiNVhzQciTI1pIFiK6ZGOFiugsOIkeSjmXsuRARCrXDV2Q
         fUUQ==
X-Gm-Message-State: AOAM531bM3o+uvItgKj21w9k1lwXABHiwQHo4Bsisw/bPK0P64ULJ8uF
        v0NYhW46cJYj/JIFCvsQQiVR5/EQ9v0ZFfX9pVzhsIZyGsodGQ==
X-Google-Smtp-Source: ABdhPJyPf9MvkOrKIhPBBVvgU9WX98eFhjU8DYrMUBFQ6BdqO0o2taeATbqBy5USGO0xl31azZ3fJ9VTtTWiEWWb/kc=
X-Received: by 2002:a17:906:640f:: with SMTP id d15mr2085736ejm.419.1630722411886;
 Fri, 03 Sep 2021 19:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210818102612.864127-1-mudongliangabcd@gmail.com> <fc1dae76-eac1-e6f4-2ba6-f49e15ad0b46@oracle.com>
In-Reply-To: <fc1dae76-eac1-e6f4-2ba6-f49e15ad0b46@oracle.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Sat, 4 Sep 2021 10:26:25 +0800
Message-ID: <CAD-N9QWihGFBf8WgwynNe295TC5rdyaO3kXgW+-MvqF4O5xvKg@mail.gmail.com>
Subject: Re: [PATCH] JFS: fix memleak in jfs_mount
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 4, 2021 at 5:51 AM Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
>
> Thanks for waiting. I have just a couple comments, but this looks good.
> I appreciate the clean up.
>
> On 8/18/21 5:25 AM, Dongliang Mu wrote:
> > In jfs_mount, when diMount(ipaimap2) fails, it goes to errout35. However,
> > the following code does not free ipaimap2 allocated by diReadSpecial.
> >
> > Fix this by refactoring the error handling code of jfs_mount. To be
> > specific, modify the lable name and free ipaimap2 when the above error
> > ocurrs.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >   fs/jfs/jfs_mount.c | 53 +++++++++++++++++++---------------------------
> >   1 file changed, 22 insertions(+), 31 deletions(-)
> >
> > diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
> > index 5d7d7170c03c..638a4ecc4069 100644
> > --- a/fs/jfs/jfs_mount.c
> > +++ b/fs/jfs/jfs_mount.c
> > @@ -81,14 +81,14 @@ int jfs_mount(struct super_block *sb)
> >        * (initialize mount inode from the superblock)
> >        */
> >       if ((rc = chkSuper(sb))) {
> > -             goto errout20;
> > +             return rc;
>
> This may have been intentional, but it isn't mentioned in the patch header.
>
> If chkSuper fails, we will no longer call
>         jfs_err("Mount JFS Failure: %d", rc);
>
> I don't necessarily see this as a bad thing. In many cases, chkSuper
> prints a more helpful message. In the case where it silently fails, it's
> not even recognizing the superblock as a supported version of JFS and
> this message isn't particularly helpful. In fact this jfs_err()
> statement might be best deleted in its entirety.

I see. Let me change "return rc" to "goto out", the same as "goto errout20".

This will put back the jfs_err message output.

>
> >       }
> >
> >       ipaimap = diReadSpecial(sb, AGGREGATE_I, 0);
> >       if (ipaimap == NULL) {
> >               jfs_err("jfs_mount: Failed to read AGGREGATE_I");
> >               rc = -EIO;
> > -             goto errout20;
> > +             goto out;
> >       }
> >       sbi->ipaimap = ipaimap;
> >
> > @@ -99,7 +99,7 @@ int jfs_mount(struct super_block *sb)
> >        */
> >       if ((rc = diMount(ipaimap))) {
> >               jfs_err("jfs_mount: diMount(ipaimap) failed w/rc = %d", rc);
> > -             goto errout21;
> > +             goto err_ipaimap;
> >       }
> >
> >       /*
> > @@ -108,7 +108,7 @@ int jfs_mount(struct super_block *sb)
> >       ipbmap = diReadSpecial(sb, BMAP_I, 0);
> >       if (ipbmap == NULL) {
> >               rc = -EIO;
> > -             goto errout22;
> > +             goto err_umount_ipaimap;
> >       }
> >
> >       jfs_info("jfs_mount: ipbmap:0x%p", ipbmap);
> > @@ -120,7 +120,7 @@ int jfs_mount(struct super_block *sb)
> >        */
> >       if ((rc = dbMount(ipbmap))) {
> >               jfs_err("jfs_mount: dbMount failed w/rc = %d", rc);
> > -             goto errout22;
> > +             goto err_ipbmap;
> >       }
> >
> >       /*
> > @@ -139,7 +139,7 @@ int jfs_mount(struct super_block *sb)
> >               if (!ipaimap2) {
> >                       jfs_err("jfs_mount: Failed to read AGGREGATE_I");
> >                       rc = -EIO;
> > -                     goto errout35;
> > +                     goto err_umount_ipbmap;
> >               }
> >               sbi->ipaimap2 = ipaimap2;
> >
> > @@ -151,7 +151,7 @@ int jfs_mount(struct super_block *sb)
> >               if ((rc = diMount(ipaimap2))) {
> >                       jfs_err("jfs_mount: diMount(ipaimap2) failed, rc = %d",
> >                               rc);
> > -                     goto errout35;
> > +                     goto err_ipaimap2;
> >               }
> >       } else
> >               /* Secondary aggregate inode table is not valid */
> > @@ -168,7 +168,7 @@ int jfs_mount(struct super_block *sb)
> >               jfs_err("jfs_mount: Failed to read FILESYSTEM_I");
> >               /* open fileset secondary inode allocation map */
> >               rc = -EIO;
> > -             goto errout40;
> > +             goto err_umount_ipaimap2;
> >       }
> >       jfs_info("jfs_mount: ipimap:0x%p", ipimap);
> >
> > @@ -178,41 +178,32 @@ int jfs_mount(struct super_block *sb)
> >       /* initialize fileset inode allocation map */
> >       if ((rc = diMount(ipimap))) {
> >               jfs_err("jfs_mount: diMount failed w/rc = %d", rc);
> > -             goto errout41;
> > +             goto err_ipimap;
> >       }
> >
> > -     goto out;
> > +     return rc;
> >
> >       /*
> >        *      unwind on error
> >        */
> > -      errout41:              /* close fileset inode allocation map inode */
> > +err_ipimap:
> > +     /* close fileset inode allocation map inode */
> >       diFreeSpecial(ipimap);
> > -
> > -      errout40:              /* fileset closed */
> > -
> > +err_umount_ipaimap2:
> >       /* close secondary aggregate inode allocation map */
> > -     if (ipaimap2) {
> > -             diUnmount(ipaimap2, 1);
> > -             diFreeSpecial(ipaimap2);
> > -     }
> > -
> > -      errout35:
> > -
> > -     /* close aggregate block allocation map */
> > +     if (ipaimap2) diUnmount(ipaimap2, 1);
>
> Coding style: this should be split between two lines:
>         if (ipaimap2)
>                 diUnmount(ipaimap2, 1);
>
> > +err_ipaimap2:
> > +     /* close aggregate inodes */
> > +     if (ipaimap2) diFreeSpecial(ipaimap2);
>
> Same here.

Will modify it in the v2 version.

>
> > +err_umount_ipbmap:   /* close aggregate block allocation map */
> >       dbUnmount(ipbmap, 1);
> > +err_ipbmap:          /* close aggregate inodes */
> >       diFreeSpecial(ipbmap);
> > -
> > -      errout22:              /* close aggregate inode allocation map */
> > -
> > +err_umount_ipaimap:  /* close aggregate inode allocation map */
> >       diUnmount(ipaimap, 1);
> > -
> > -      errout21:              /* close aggregate inodes */
> > +err_ipaimap:         /* close aggregate inodes */
> >       diFreeSpecial(ipaimap);
> > -      errout20:              /* aggregate closed */
> > -
> > -      out:
> > -
> > +out:
> >       if (rc)
> >               jfs_err("Mount JFS Failure: %d", rc);
> >
> >
