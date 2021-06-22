Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCA33AFC3D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 06:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFVEyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 00:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhFVEyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 00:54:16 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DD7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 21:51:59 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id 17so4755804ill.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 21:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2eUQ1JQ3Tk8ujWMBisZWI5OG9A2UClHrB5qb/5Rbsk=;
        b=A4H6y9SyUVDBx9RJHfS8A6zwwQLCzMyshwDtr94yxklD3dEZKDOQ4IIWato8vus4pB
         rwDdMZYy6Wj5uWDETg2Y/HdDqkiF884srx2SMtSHx0yIEznLHT4MKv7kW11XClWAjvum
         7kvZDJ6SxIUOc15FdidQZ06yuOdzbMALWSAFC6rRDeiQBEDkoRPG1+PtHPRJopUHtaFR
         g9xthWSb0AEkYWF9J2bWy8byWit7q6NSsWwsLY7vzECiPkwcVCAqOEoEWYPvNlMOC8Cm
         zPihLkxRJBMmxcOIUnXTgQ4uhLnlV3/AoHMXT6V7xl6/xBfmAEH87S07YGTtlPfvZwfM
         PtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2eUQ1JQ3Tk8ujWMBisZWI5OG9A2UClHrB5qb/5Rbsk=;
        b=m60R1WmpBnoegyhyfqUwpn94vCp5aILf5bGucY6ZP2UI4DnqSKaUvJvcOTd/yBY12H
         MkW9Yt59I4nSPSIsBZRT9IhqQzPGnANfTwKA5/+6pltKVZqjThso1l439hd560Zy3mNB
         F102tXdAOljdaxuMh04cGnsSwCpe5CHH7Es72bkifFhdlsJY5eIrEiS82wbxl7to6vwK
         VVgcQgZU2zyWu49BCH8S505egjv8WK1fjQL2T+zy7dANFPoBUFqyP0e27rgs7sdmnoBY
         Z2r+Xcu2UgShops2/rCLkj4Z5S66wJNx5PAGPtBLIe6L4FCIdWUTBZgUkyxXOIe/LXlh
         iaCw==
X-Gm-Message-State: AOAM531UMBFl6+pBz9IwbzMKx6tftROqonx2Hsm3R1WHGK7Jb+29XZEQ
        SVXbuAYACQ67zsZohE+Hpw293SeHEKZl0b8LVGc=
X-Google-Smtp-Source: ABdhPJzmwIe0h+U03G7uNsF39IWuo2kIIy1AUyUd8jqPwpF1OaP93nf+Y3k54A7Bi+KW3GlYDNCC945uKQsWmTguoUk=
X-Received: by 2002:a05:6e02:16c5:: with SMTP id 5mr1298669ilx.72.1624337519256;
 Mon, 21 Jun 2021 21:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c5b77105b4c3546e@google.com> <000000000000df47be05bf165394@google.com>
 <20210618040135.950-1-hdanton@sina.com> <23ba225593be391c384109af527bd0f3cb122a0d.camel@linux.ibm.com>
In-Reply-To: <23ba225593be391c384109af527bd0f3cb122a0d.camel@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 22 Jun 2021 07:51:47 +0300
Message-ID: <CAOQ4uxjYJTG3p2ALXAWnAY+6Kmoi_L0=Z42okT6R+ovzQ7dQoQ@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in ovl_maybe_copy_up
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+c18f2f6a7b08c51e3025@syzkaller.appspotmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 5:32 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Fri, 2021-06-18 at 12:01 +0800, Hillf Danton wrote:
> > On Sun, 4 Apr 2021 11:10:48 +0300 Amir Goldstein wrote:
> > >On Sat, Apr 3, 2021 at 10:18 PM syzbot wrote:
> > >>
> > >> syzbot has found a reproducer for the following issue on:
> > >>
> > >> HEAD commit:    454c576c Add linux-next specific files for 20210401
> > >> git tree:       linux-next
> > >> console output: https://syzkaller.appspot.com/x/log.txt?x=1616e07ed00000
> > >> kernel config:  https://syzkaller.appspot.com/x/.config?x=920cc274cae812a5
> > >> dashboard link: https://syzkaller.appspot.com/bug?extid=c18f2f6a7b08c51e3025
> > >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13da365ed00000
> > >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ca9d16d00000
> > >>
> > >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > >> Reported-by: syzbot+c18f2f6a7b08c51e3025@syzkaller.appspotmail.com
> > >>
> > >> ======================================================
> > >> WARNING: possible circular locking dependency detected
> > >> 5.12.0-rc5-next-20210401-syzkaller #0 Not tainted
> > >> ------------------------------------------------------
> > >> syz-executor144/9166 is trying to acquire lock:
> > >> ffff888144cf0460 (sb_writers#5){.+.+}-{0:0}, at: ovl_maybe_copy_up+0x11f/0x190 fs/overlayfs/copy_up.c:995
> > >>
> > >> but task is already holding lock:
> > >> ffff8880256d42c0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x3a8/0x17e0 security/integrity/ima/ima_main.c:253
> > >>
> > >> which lock already depends on the new lock.
> > >>
> > >>
> > >> the existing dependency chain (in reverse order) is:
> > >>
> > >> -> #1 (&iint->mutex){+.+.}-{3:3}:
> > >>        __mutex_lock_common kernel/locking/mutex.c:949 [inline]
> > >>        __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1096
> > >>        process_measurement+0x3a8/0x17e0 security/integrity/ima/ima_main.c:253
> > >>        ima_file_check+0xb9/0x100 security/integrity/ima/ima_main.c:499
> > >>        do_open fs/namei.c:3361 [inline]
> > >>        path_openat+0x15b5/0x27e0 fs/namei.c:3492
> > >>        do_filp_open+0x17e/0x3c0 fs/namei.c:3519
> > >>        do_sys_openat2+0x16d/0x420 fs/open.c:1187
> > >>        do_sys_open fs/open.c:1203 [inline]
> > >>        __do_sys_open fs/open.c:1211 [inline]
> > >>        __se_sys_open fs/open.c:1207 [inline]
> > >>        __x64_sys_open+0x119/0x1c0 fs/open.c:1207
> > >>        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> > >>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >>
> > >> -> #0 (sb_writers#5){.+.+}-{0:0}:
> > >>        check_prev_add kernel/locking/lockdep.c:2938 [inline]
> > >>        check_prevs_add kernel/locking/lockdep.c:3061 [inline]
> > >>        validate_chain kernel/locking/lockdep.c:3676 [inline]
> > >>        __lock_acquire+0x2a17/0x5230 kernel/locking/lockdep.c:4902
> > >>        lock_acquire kernel/locking/lockdep.c:5512 [inline]
> > >>        lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5477
> > >>        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
> > >>        __sb_start_write include/linux/fs.h:1758 [inline]
> > >>        sb_start_write include/linux/fs.h:1828 [inline]
> > >>        mnt_want_write+0x6e/0x3e0 fs/namespace.c:375
> > >>        ovl_maybe_copy_up+0x11f/0x190 fs/overlayfs/copy_up.c:995
> > >>        ovl_open+0xba/0x270 fs/overlayfs/file.c:149
> > >>        do_dentry_open+0x4b9/0x11b0 fs/open.c:826
> > >>        vfs_open fs/open.c:940 [inline]
> > >>        dentry_open+0x132/0x1d0 fs/open.c:956
> > >>        ima_calc_file_hash+0x2d2/0x4b0 security/integrity/ima/ima_crypto.c:557
> > >>        ima_collect_measurement+0x4ca/0x570 security/integrity/ima/ima_api.c:252
> > >>        process_measurement+0xd1c/0x17e0 security/integrity/ima/ima_main.c:330
> > >>        ima_file_check+0xb9/0x100 security/integrity/ima/ima_main.c:499
> > >>        do_open fs/namei.c:3361 [inline]
> > >>        path_openat+0x15b5/0x27e0 fs/namei.c:3492
> > >>        do_filp_open+0x17e/0x3c0 fs/namei.c:3519
> > >>        do_sys_openat2+0x16d/0x420 fs/open.c:1187
> > >>        do_sys_open fs/open.c:1203 [inline]
> > >>        __do_sys_open fs/open.c:1211 [inline]
> > >>        __se_sys_open fs/open.c:1207 [inline]
> > >>        __x64_sys_open+0x119/0x1c0 fs/open.c:1207
> > >>        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> > >>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >>
> > >> other info that might help us debug this:
> > >>
> > >>  Possible unsafe locking scenario:
> > >>
> > >>        CPU0                    CPU1
> > >>        ----                    ----
> > >>   lock(&iint->mutex);
> > >>                                lock(sb_writers#5);
> > >>                                lock(&iint->mutex);
> > >>   lock(sb_writers#5);
> > >>
> > >>  *** DEADLOCK ***
> > >>
> > >> 1 lock held by syz-executor144/9166:
> > >>  #0: ffff8880256d42c0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x3a8/0x17e0 security/integrity/ima/ima_main.c:253
> > >>
> >
> > It is reported again.
> >   https://lore.kernel.org/lkml/00000000000067d24205c4d0e599@google.com/
> > >
> > >It's a false positive lockdep warning due to missing annotation of
> > >stacking layer on iint->mutex in IMA code.
> >
> > Add it by copying what's created for ovl, see below.
> > >
> > >To fix it properly, iint->mutex, which can be taken in any of the
> > >stacking fs layers, should be annotated with stacking depth like
> > >ovl_lockdep_annotate_inode_mutex_key()
> > >
> > >I think it's the same root cause as:
> > >https://syzkaller.appspot.com/bug?extid=18a1619cceea30ed45af
> > >https://syzkaller.appspot.com/bug?extid=ae82084b07d0297e566b
> > >
> > >I think both of the above were marked "fixed" by a paper over.
> > >The latter was marked "fixed" by "ovl: detect overlapping layers"
> > >but if you look at the repro, the fact that 'workdir' overlaps with
> > >'lowerdir' has nothing to do with the lockdep warning, so said
> > >"fix" just papered over the IMA lockdep warning.
> > >
> > >Thanks,
> > >Amir.
> >
> > +++ x/security/integrity/iint.c
> > @@ -85,6 +85,45 @@ static void iint_free(struct integrity_i
> >       kmem_cache_free(iint_cache, iint);
> >  }
> >
> > +/*
> > + * a copy from ovl_lockdep_annotate_inode_mutex_key() in a bit to fix
> > +
> > +   Possible unsafe locking scenario:
> > +
> > +     CPU0                    CPU1
> > +       ----                    ----
> > +     lock(&iint->mutex);
> > +                               lock(sb_writers#5);
> > +                               lock(&iint->mutex);
> > +     lock(sb_writers#5);
> > +
> > +     *** DEADLOCK ***
> > +
> > +It's a false positive lockdep warning due to missing annotation of
> > +stacking layer on iint->mutex in IMA code. [1]
> > +
> > +[1] https://lore.kernel.org/linux-unionfs/CAOQ4uxjk4XYuwz5HCmN-Ge=Ld=tM1f7ZxVrd5U1AC2Wisc9MTA@mail.gmail.com/
> > +*/
> > +static void iint_annotate_mutex_key(struct integrity_iint_cache *iint,
> > +                                     struct inode *inode)
> > +{
> > +#ifdef CONFIG_LOCKDEP
> > +     static struct lock_class_key
> > +             iint_mutex_key[FILESYSTEM_MAX_STACK_DEPTH],
> > +             iint_mutex_dir_key[FILESYSTEM_MAX_STACK_DEPTH];
> > +
> > +     int depth = inode->i_sb->s_stack_depth - 1;
> > +
> > +     if (WARN_ON_ONCE(depth < 0 || depth >= FILESYSTEM_MAX_STACK_DEPTH))
> > +             depth = 0;
> > +
> > +     if (S_ISDIR(inode->i_mode))
> > +             lockdep_set_class(&iint->mutex, &iint_mutex_dir_key[depth]);
> > +     else
> > +             lockdep_set_class(&iint->mutex, &iint_mutex_key[depth]);
> > +#endif
> > +}
>
> The iint cache is only for regular files.
>
> > +
> >  /**
> >   * integrity_inode_get - find or allocate an iint associated with an inode
> >   * @inode: pointer to the inode
> > @@ -113,6 +152,7 @@ struct integrity_iint_cache *integrity_i
> >       iint = kmem_cache_alloc(iint_cache, GFP_NOFS);
> >       if (!iint)
> >               return NULL;
> > +     iint_annotate_mutex_key(iint, inode);
> >
> >       write_lock(&integrity_iint_lock);
>
> Should annotating the iint be limited to files on overlay filesystems?
>

Not to overlay files specifically but to files on stacked fs,
i.e. (inode->i_sb->s_stack_depth > 0)
Assuming that this patch is tested(?), how come it did not hit the
WARN_ON_ONCE(depth < 0... above?

Thanks,
Amir.
