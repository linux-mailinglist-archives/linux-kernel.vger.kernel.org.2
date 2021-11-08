Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A304944782E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 02:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhKHBOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 20:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhKHBOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 20:14:09 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27E0C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 17:11:25 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z21so10527065edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 17:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tsoy82MCNMxkTfmdJ0FN5A69lk+98vELhtoCFupA4+o=;
        b=l5LsvtDxY2jOj3F6tEWLRywt+Iz98/ClRdePVTuzFaZEbxMR3UG84T1smqUpL+/ucm
         JTj31GoaYjXwXMFGj/8lePx4MUdAjywNso5epEKdCK4TrVJaXjFNLCF1+N7vWw2Powdx
         6q+/qaZr3Y4skcXNoJ5FEBGuG3Bp8h7T+AhF0n+bkVbjYNhatTtpaRb1VsNy+oinFjZM
         VEblpUxhEkRrY/2U28x4HCjK/W+2+ENF3wxrTjOzoVjKMqR3GOk8SSrCsX36DSO18ED9
         6OgiCs5prTYC03VQwXcNxK+A+WV487CbpevrM4Y5HxBdrf4OeNs2TriUY/A8mrE9Jnge
         KD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tsoy82MCNMxkTfmdJ0FN5A69lk+98vELhtoCFupA4+o=;
        b=cHsJaNeBCdkokC8gteU4p/n5+vNal9aW0xXgRZ1aoBtlB6xjzEOzMmo+aMPirq1/94
         H4Rh0rY5kA81eepfxZeSEBEAD+GOQsyt9GxxCPLdk1biprnxnqiDwdIxnfquSS8BYPF0
         wwczDHqxc/dB2kBPZBb7Tqa6Qa9l3jIy4FVuAl6yBaXrjGpWQxW/renVZfxcP9xROfaJ
         jLTkel6Pp3aeEnJuTv44+wUIlOgFHUoJlQHotJ51R5bs1j7l0rTdUY/o2KO+fL0Fdm/5
         SvO46KxLzheQpXV23Mi8WRqDZqmlzIlpfMIqfMOIGU1nFegFRueig5ZiXNVaB5Te1lJQ
         eBIA==
X-Gm-Message-State: AOAM5324utnDwZSzTgzxRjV2ex+YeJ8KEWHdnIuy/z1vTDvTNw8p0le0
        b1fWoJeqs8b+C7msY6ruWoDIJsVZf1teouPrkayIVMIDE50rgEB/
X-Google-Smtp-Source: ABdhPJzutOb+o6Ghdq1oYjze1+nMzto/EXZXo2kNkf3AIz0EEwvEvkAvSHHhPFqmVTVX8XJSc3g4rQu1EY1ehZB3u3s=
X-Received: by 2002:a17:907:72d4:: with SMTP id du20mr24308556ejc.419.1636333883850;
 Sun, 07 Nov 2021 17:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20210904023800.1813036-1-mudongliangabcd@gmail.com>
 <CAD-N9QV5OMe0ryEKaUYkwmNyOtu+Sgi7h2B0JFSK5Jj9bbQPQQ@mail.gmail.com> <5678317c-9fd2-4557-6e28-984a8b74b99c@oracle.com>
In-Reply-To: <5678317c-9fd2-4557-6e28-984a8b74b99c@oracle.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 8 Nov 2021 09:10:57 +0800
Message-ID: <CAD-N9QXQ+E+j7d-+6oY4u0JWjiKSFoKj3mKEvHZ1CQiPbdLuMg@mail.gmail.com>
Subject: Re: [PATCH v2] JFS: fix memleak in jfs_mount
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 10:54 PM Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
>
> On 9/22/21 19:53, Dongliang Mu wrote:
> > Any update on this thread?
>
> Sorry for taking this long to get back to it. The patch looks good. It
> should show up in linux-next shortly.
>

Hi Dave,

In my local syzkaller testing, the upstream is still vulnerable to
this patch. How does the patch applied in linux-next propagate to
upstream?

> Shaggy
>
> >
> > On Sat, Sep 4, 2021 at 10:38 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> >>
> >> In jfs_mount, when diMount(ipaimap2) fails, it goes to errout35. However,
> >> the following code does not free ipaimap2 allocated by diReadSpecial.
> >>
> >> Fix this by refactoring the error handling code of jfs_mount. To be
> >> specific, modify the lable name and free ipaimap2 when the above error
> >> ocurrs.
> >>
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> >> ---
> >> v1->v2: change "return rc" to "goto out"; fix one coding style
> >>   fs/jfs/jfs_mount.c | 51 ++++++++++++++++++++--------------------------
> >>   1 file changed, 22 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
> >> index 5d7d7170c03c..aa4ff7bcaff2 100644
> >> --- a/fs/jfs/jfs_mount.c
> >> +++ b/fs/jfs/jfs_mount.c
> >> @@ -81,14 +81,14 @@ int jfs_mount(struct super_block *sb)
> >>           * (initialize mount inode from the superblock)
> >>           */
> >>          if ((rc = chkSuper(sb))) {
> >> -               goto errout20;
> >> +               goto out;
> >>          }
> >>
> >>          ipaimap = diReadSpecial(sb, AGGREGATE_I, 0);
> >>          if (ipaimap == NULL) {
> >>                  jfs_err("jfs_mount: Failed to read AGGREGATE_I");
> >>                  rc = -EIO;
> >> -               goto errout20;
> >> +               goto out;
> >>          }
> >>          sbi->ipaimap = ipaimap;
> >>
> >> @@ -99,7 +99,7 @@ int jfs_mount(struct super_block *sb)
> >>           */
> >>          if ((rc = diMount(ipaimap))) {
> >>                  jfs_err("jfs_mount: diMount(ipaimap) failed w/rc = %d", rc);
> >> -               goto errout21;
> >> +               goto err_ipaimap;
> >>          }
> >>
> >>          /*
> >> @@ -108,7 +108,7 @@ int jfs_mount(struct super_block *sb)
> >>          ipbmap = diReadSpecial(sb, BMAP_I, 0);
> >>          if (ipbmap == NULL) {
> >>                  rc = -EIO;
> >> -               goto errout22;
> >> +               goto err_umount_ipaimap;
> >>          }
> >>
> >>          jfs_info("jfs_mount: ipbmap:0x%p", ipbmap);
> >> @@ -120,7 +120,7 @@ int jfs_mount(struct super_block *sb)
> >>           */
> >>          if ((rc = dbMount(ipbmap))) {
> >>                  jfs_err("jfs_mount: dbMount failed w/rc = %d", rc);
> >> -               goto errout22;
> >> +               goto err_ipbmap;
> >>          }
> >>
> >>          /*
> >> @@ -139,7 +139,7 @@ int jfs_mount(struct super_block *sb)
> >>                  if (!ipaimap2) {
> >>                          jfs_err("jfs_mount: Failed to read AGGREGATE_I");
> >>                          rc = -EIO;
> >> -                       goto errout35;
> >> +                       goto err_umount_ipbmap;
> >>                  }
> >>                  sbi->ipaimap2 = ipaimap2;
> >>
> >> @@ -151,7 +151,7 @@ int jfs_mount(struct super_block *sb)
> >>                  if ((rc = diMount(ipaimap2))) {
> >>                          jfs_err("jfs_mount: diMount(ipaimap2) failed, rc = %d",
> >>                                  rc);
> >> -                       goto errout35;
> >> +                       goto err_ipaimap2;
> >>                  }
> >>          } else
> >>                  /* Secondary aggregate inode table is not valid */
> >> @@ -168,7 +168,7 @@ int jfs_mount(struct super_block *sb)
> >>                  jfs_err("jfs_mount: Failed to read FILESYSTEM_I");
> >>                  /* open fileset secondary inode allocation map */
> >>                  rc = -EIO;
> >> -               goto errout40;
> >> +               goto err_umount_ipaimap2;
> >>          }
> >>          jfs_info("jfs_mount: ipimap:0x%p", ipimap);
> >>
> >> @@ -178,41 +178,34 @@ int jfs_mount(struct super_block *sb)
> >>          /* initialize fileset inode allocation map */
> >>          if ((rc = diMount(ipimap))) {
> >>                  jfs_err("jfs_mount: diMount failed w/rc = %d", rc);
> >> -               goto errout41;
> >> +               goto err_ipimap;
> >>          }
> >>
> >> -       goto out;
> >> +       return rc;
> >>
> >>          /*
> >>           *      unwind on error
> >>           */
> >> -      errout41:                /* close fileset inode allocation map inode */
> >> +err_ipimap:
> >> +       /* close fileset inode allocation map inode */
> >>          diFreeSpecial(ipimap);
> >> -
> >> -      errout40:                /* fileset closed */
> >> -
> >> +err_umount_ipaimap2:
> >>          /* close secondary aggregate inode allocation map */
> >> -       if (ipaimap2) {
> >> +       if (ipaimap2)
> >>                  diUnmount(ipaimap2, 1);
> >> +err_ipaimap2:
> >> +       /* close aggregate inodes */
> >> +       if (ipaimap2)
> >>                  diFreeSpecial(ipaimap2);
> >> -       }
> >> -
> >> -      errout35:
> >> -
> >> -       /* close aggregate block allocation map */
> >> +err_umount_ipbmap:     /* close aggregate block allocation map */
> >>          dbUnmount(ipbmap, 1);
> >> +err_ipbmap:            /* close aggregate inodes */
> >>          diFreeSpecial(ipbmap);
> >> -
> >> -      errout22:                /* close aggregate inode allocation map */
> >> -
> >> +err_umount_ipaimap:    /* close aggregate inode allocation map */
> >>          diUnmount(ipaimap, 1);
> >> -
> >> -      errout21:                /* close aggregate inodes */
> >> +err_ipaimap:           /* close aggregate inodes */
> >>          diFreeSpecial(ipaimap);
> >> -      errout20:                /* aggregate closed */
> >> -
> >> -      out:
> >> -
> >> +out:
> >>          if (rc)
> >>                  jfs_err("Mount JFS Failure: %d", rc);
> >>
> >> --
> >> 2.25.1
> >>
