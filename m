Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09A344783D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 02:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbhKHBSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 20:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhKHBSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 20:18:31 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B710AC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 17:15:47 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v11so53388921edc.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 17:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTjYV3f1HkMSkMYdNQDcb8Fpc3JDFNrMzhJhsj3l/7c=;
        b=qfUCKQNnO8SZSYmAB4c0/oEYmNEn7DpbxszUU52HEPh9lIGWWweQG8rVv4y/DmzJ1B
         uR8tsJbOr9MhP2ytO9CuMhc30n8m3mYUb1YmjhbwAmoDUTEpa6FhNrXgO2bJ1xfu9kBX
         v5I/VmwUbFW6ky1xt/C2oQi6olZs/5GFDEvduw1+OAXnrP55XpBas4dw1TpBJJpV0B+g
         o5CaLpLI7KBCJFWY02lKWDbBVu1LaOalIQtp6P6AhISFTSqFlHy02NodWlWmiMzfgqLZ
         gsj2ds5WdSR4ngBF7fEyLmpjtwNA4RMmZjNM7f0I1K0p43WWji9ylBVrEzfNaVkGyzxG
         E1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTjYV3f1HkMSkMYdNQDcb8Fpc3JDFNrMzhJhsj3l/7c=;
        b=YCaRhCvgrnbOl+JIzHGl8LlYMz4Z6LS/jLsPKbp3bbiVUqAFIA3BAAfK/AQZt0BT3B
         TteZcG41YSKpGzo1MATKD1tBHbrH6LVIs05as0hp0FtsfD5N7ouO6FgIi/e600IVNKG/
         adz6kDEqkb5UgPrt8NmZWiOezhEWhbH+gODULC3i7k7F6fUItRlxjJus0LSUlTyL5pYD
         vUZEwHBXcIPhHp1TEX23MX2Ft1V3LDim9vmcrafiMqoe+CB8KZT71M+6/7sezACXjQON
         5LPe/ptQG9K+vdsfMiox/bDdqWK9mYWcvUQTR+n1N7Kz9qNwO2p9MxpSmaglVJfA74v8
         97MA==
X-Gm-Message-State: AOAM533eQ/4uT1WRpTdX+a+cynJp7S9cAiWS070k0bgVPu4AHzZM8b6h
        yVcppo4BA85IJPh39yx0ZnO1Q7VpKjPyyYB2RXM=
X-Google-Smtp-Source: ABdhPJwZi8awbVTnDx+yL8ObGWQ8QTGBWiWuLJ2XTDOOC7SQhAgIk/pTTTAkYKncGBYPOEDfkoc7Zs0OCa0zxuFzdyk=
X-Received: by 2002:a05:6402:50d4:: with SMTP id h20mr45206180edb.80.1636334146267;
 Sun, 07 Nov 2021 17:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20210904023800.1813036-1-mudongliangabcd@gmail.com>
 <CAD-N9QV5OMe0ryEKaUYkwmNyOtu+Sgi7h2B0JFSK5Jj9bbQPQQ@mail.gmail.com>
 <5678317c-9fd2-4557-6e28-984a8b74b99c@oracle.com> <CAD-N9QXQ+E+j7d-+6oY4u0JWjiKSFoKj3mKEvHZ1CQiPbdLuMg@mail.gmail.com>
In-Reply-To: <CAD-N9QXQ+E+j7d-+6oY4u0JWjiKSFoKj3mKEvHZ1CQiPbdLuMg@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 8 Nov 2021 09:15:19 +0800
Message-ID: <CAD-N9QVa0MQkuDMMrooTNEDR3Mqc0fE+j-+aq+Uu=GX6x=akJQ@mail.gmail.com>
Subject: Re: [PATCH v2] JFS: fix memleak in jfs_mount
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 9:10 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Thu, Sep 23, 2021 at 10:54 PM Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
> >
> > On 9/22/21 19:53, Dongliang Mu wrote:
> > > Any update on this thread?
> >
> > Sorry for taking this long to get back to it. The patch looks good. It
> > should show up in linux-next shortly.
> >
>
> Hi Dave,
>
> In my local syzkaller testing, the upstream is still vulnerable to
> this patch. How does the patch applied in linux-next propagate to
> upstream?

Please ignore it. I have found the commit in the upstream.

>
> > Shaggy
> >
> > >
> > > On Sat, Sep 4, 2021 at 10:38 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> > >>
> > >> In jfs_mount, when diMount(ipaimap2) fails, it goes to errout35. However,
> > >> the following code does not free ipaimap2 allocated by diReadSpecial.
> > >>
> > >> Fix this by refactoring the error handling code of jfs_mount. To be
> > >> specific, modify the lable name and free ipaimap2 when the above error
> > >> ocurrs.
> > >>
> > >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > >> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > >> ---
> > >> v1->v2: change "return rc" to "goto out"; fix one coding style
> > >>   fs/jfs/jfs_mount.c | 51 ++++++++++++++++++++--------------------------
> > >>   1 file changed, 22 insertions(+), 29 deletions(-)
> > >>
> > >> diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
> > >> index 5d7d7170c03c..aa4ff7bcaff2 100644
> > >> --- a/fs/jfs/jfs_mount.c
> > >> +++ b/fs/jfs/jfs_mount.c
> > >> @@ -81,14 +81,14 @@ int jfs_mount(struct super_block *sb)
> > >>           * (initialize mount inode from the superblock)
> > >>           */
> > >>          if ((rc = chkSuper(sb))) {
> > >> -               goto errout20;
> > >> +               goto out;
> > >>          }
> > >>
> > >>          ipaimap = diReadSpecial(sb, AGGREGATE_I, 0);
> > >>          if (ipaimap == NULL) {
> > >>                  jfs_err("jfs_mount: Failed to read AGGREGATE_I");
> > >>                  rc = -EIO;
> > >> -               goto errout20;
> > >> +               goto out;
> > >>          }
> > >>          sbi->ipaimap = ipaimap;
> > >>
> > >> @@ -99,7 +99,7 @@ int jfs_mount(struct super_block *sb)
> > >>           */
> > >>          if ((rc = diMount(ipaimap))) {
> > >>                  jfs_err("jfs_mount: diMount(ipaimap) failed w/rc = %d", rc);
> > >> -               goto errout21;
> > >> +               goto err_ipaimap;
> > >>          }
> > >>
> > >>          /*
> > >> @@ -108,7 +108,7 @@ int jfs_mount(struct super_block *sb)
> > >>          ipbmap = diReadSpecial(sb, BMAP_I, 0);
> > >>          if (ipbmap == NULL) {
> > >>                  rc = -EIO;
> > >> -               goto errout22;
> > >> +               goto err_umount_ipaimap;
> > >>          }
> > >>
> > >>          jfs_info("jfs_mount: ipbmap:0x%p", ipbmap);
> > >> @@ -120,7 +120,7 @@ int jfs_mount(struct super_block *sb)
> > >>           */
> > >>          if ((rc = dbMount(ipbmap))) {
> > >>                  jfs_err("jfs_mount: dbMount failed w/rc = %d", rc);
> > >> -               goto errout22;
> > >> +               goto err_ipbmap;
> > >>          }
> > >>
> > >>          /*
> > >> @@ -139,7 +139,7 @@ int jfs_mount(struct super_block *sb)
> > >>                  if (!ipaimap2) {
> > >>                          jfs_err("jfs_mount: Failed to read AGGREGATE_I");
> > >>                          rc = -EIO;
> > >> -                       goto errout35;
> > >> +                       goto err_umount_ipbmap;
> > >>                  }
> > >>                  sbi->ipaimap2 = ipaimap2;
> > >>
> > >> @@ -151,7 +151,7 @@ int jfs_mount(struct super_block *sb)
> > >>                  if ((rc = diMount(ipaimap2))) {
> > >>                          jfs_err("jfs_mount: diMount(ipaimap2) failed, rc = %d",
> > >>                                  rc);
> > >> -                       goto errout35;
> > >> +                       goto err_ipaimap2;
> > >>                  }
> > >>          } else
> > >>                  /* Secondary aggregate inode table is not valid */
> > >> @@ -168,7 +168,7 @@ int jfs_mount(struct super_block *sb)
> > >>                  jfs_err("jfs_mount: Failed to read FILESYSTEM_I");
> > >>                  /* open fileset secondary inode allocation map */
> > >>                  rc = -EIO;
> > >> -               goto errout40;
> > >> +               goto err_umount_ipaimap2;
> > >>          }
> > >>          jfs_info("jfs_mount: ipimap:0x%p", ipimap);
> > >>
> > >> @@ -178,41 +178,34 @@ int jfs_mount(struct super_block *sb)
> > >>          /* initialize fileset inode allocation map */
> > >>          if ((rc = diMount(ipimap))) {
> > >>                  jfs_err("jfs_mount: diMount failed w/rc = %d", rc);
> > >> -               goto errout41;
> > >> +               goto err_ipimap;
> > >>          }
> > >>
> > >> -       goto out;
> > >> +       return rc;
> > >>
> > >>          /*
> > >>           *      unwind on error
> > >>           */
> > >> -      errout41:                /* close fileset inode allocation map inode */
> > >> +err_ipimap:
> > >> +       /* close fileset inode allocation map inode */
> > >>          diFreeSpecial(ipimap);
> > >> -
> > >> -      errout40:                /* fileset closed */
> > >> -
> > >> +err_umount_ipaimap2:
> > >>          /* close secondary aggregate inode allocation map */
> > >> -       if (ipaimap2) {
> > >> +       if (ipaimap2)
> > >>                  diUnmount(ipaimap2, 1);
> > >> +err_ipaimap2:
> > >> +       /* close aggregate inodes */
> > >> +       if (ipaimap2)
> > >>                  diFreeSpecial(ipaimap2);
> > >> -       }
> > >> -
> > >> -      errout35:
> > >> -
> > >> -       /* close aggregate block allocation map */
> > >> +err_umount_ipbmap:     /* close aggregate block allocation map */
> > >>          dbUnmount(ipbmap, 1);
> > >> +err_ipbmap:            /* close aggregate inodes */
> > >>          diFreeSpecial(ipbmap);
> > >> -
> > >> -      errout22:                /* close aggregate inode allocation map */
> > >> -
> > >> +err_umount_ipaimap:    /* close aggregate inode allocation map */
> > >>          diUnmount(ipaimap, 1);
> > >> -
> > >> -      errout21:                /* close aggregate inodes */
> > >> +err_ipaimap:           /* close aggregate inodes */
> > >>          diFreeSpecial(ipaimap);
> > >> -      errout20:                /* aggregate closed */
> > >> -
> > >> -      out:
> > >> -
> > >> +out:
> > >>          if (rc)
> > >>                  jfs_err("Mount JFS Failure: %d", rc);
> > >>
> > >> --
> > >> 2.25.1
> > >>
