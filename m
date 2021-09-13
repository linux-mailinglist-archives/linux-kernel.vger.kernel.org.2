Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D693E4083C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbhIMFZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhIMFZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:25:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5189AC061574;
        Sun, 12 Sep 2021 22:24:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id b10so11545874ejg.11;
        Sun, 12 Sep 2021 22:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUunGeHf0LHPUlfmyG4eNyWIw2Dv5WK+rZDWgXNFhME=;
        b=p9yGE+Spv/e7HEokTC7au7xbFpcAGiAiO8q+LuDJUf9wMbClHk7N6OZ4or9IQFHxj9
         90SE3QP+wSIX0LHmU9dJKV4kLHy/jbH9LruV8wUhZU+vJTmFUrvG2Jo83ipncXGnjjkS
         mqHNt0xS+GEP/SPiEt1HKZ4Ao/o3OI5cpNTvWSBhUYy6NbIEuWVzSlB+HdbkAgzQwvNQ
         HWZGfAOxq/zBQdmEs51JvJbebbhKJJQ3alQyfyhK38h+MEv7orniee9q3Jo0KwkfqhZG
         pP1EYVa60kNCGEpj5CHIkJ4Y5DG1EOvMwMEPT+C7UUDbQ8DjMCMS/vP6kNfs/EQVWIos
         lREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUunGeHf0LHPUlfmyG4eNyWIw2Dv5WK+rZDWgXNFhME=;
        b=ykNS3jKu71tFuWo0K/QHXKWxpORJR78BApdqurDyzLHGwEfkSUiHV35Ul6etkVGumE
         ZVVJFd1Ztl0DQJBkV+Av+MOXUhVmymnhwLGc1KeAJAwfrB0nUfbm24361N3EygpQ0cCr
         fawcJ/0UK2TdQlYROeTHqRpaUqVgng2Ky8vDtA6QGmntCds+nJVt0bZ9XEcbHe4kpjfo
         c1pe4H+8JjmkWZrHuvVR8QcXcwllqSXOg48ehxhjHW4A6Ox4LfO+axsdvQpHsveJGWsu
         GNmP6bjMAd8T80IvBOJuHlwkz3kxo24AbQNEjQQ/X4JUYedfSX0TihIxsCmApctnrOtT
         MEjQ==
X-Gm-Message-State: AOAM533WxVgr9j3Cb8t5wNjYTRS3H8emvt8RETanFikpj5PSnIwZDeyx
        2vzRtg+zfC7YmoaoaqOyLCWN5MvqQfrSC/rwIJw=
X-Google-Smtp-Source: ABdhPJxRYm8aughEVXXOBzdv6Iyl9W0Su3iFMdNSg5Cv/Sj7qVWADQk7V3+AuBgN6PBpEdVxz0HDIfsHcA5Up9xweHM=
X-Received: by 2002:a17:906:7250:: with SMTP id n16mr10730411ejk.147.1631510665781;
 Sun, 12 Sep 2021 22:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210906041330.2065214-1-mudongliangabcd@gmail.com>
 <CAD-N9QUHfoqOOxDuKniMi8VGLR2j6g50BBy45eAL0kPRrntmgA@mail.gmail.com>
 <aa2fb8c6-ef6b-a1ca-d598-b0814529a31d@gmail.com> <53fb4217-21b8-ac46-bb39-581a4c9837a4@gmail.com>
 <CAD-N9QUjd-yNVa2uOac434tgyd2wXEQ6Z=aA9Yu9-_UANv7YjA@mail.gmail.com>
In-Reply-To: <CAD-N9QUjd-yNVa2uOac434tgyd2wXEQ6Z=aA9Yu9-_UANv7YjA@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 13 Sep 2021 13:23:59 +0800
Message-ID: <CAD-N9QVa08v6BU2XF6hohUBpjqgZys80UPf8ywLzUCv7WnkpcQ@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix memory leak in nilfs_sysfs_create_device_group
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many commits related to memory leak fix in nilfs_sysfs.

4 days nilfs2: fix memory leak in nilfs_sysfs_delete_snapshot_group
4 days nilfs2: fix memory leak in nilfs_sysfs_create_snapshot_group
4 days nilfs2: fix memory leak in nilfs_sysfs_delete_##name##_group
4 days nilfs2: fix memory leak in nilfs_sysfs_create_##name##_group
4 days nilfs2: fix NULL pointer in nilfs_##name##_attr_release
4 days nilfs2: fix memory leak in nilfs_sysfs_create_device_group

This thread can be closed.

Best regards,
Dongliang Mu

On Tue, Sep 7, 2021 at 12:00 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Tue, Sep 7, 2021 at 12:47 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
> >
> > On 9/6/21 18:56, Pavel Skripkin wrote:
> > > On 9/6/21 08:43, Dongliang Mu wrote:
> > >> On Mon, Sep 6, 2021 at 12:13 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> > >>>
> > >>> The commit 8fd0c1b0647a ("nilfs2: fix memory leak in
> > >>> nilfs_sysfs_delete_device_group") adds a kobject_put to free the leaking
> > >>> object name. However, it is incomplete to only add kobject_put in the
> > >>> nilfs_sysfs_delete_device_group. The function
> > >>> nilfs_sysfs_create_device_group also needs the kobject_put to
> > >>> free the object name in the error handling part.
> > >>>
> > >>> Fix this by adding kobject_put in the error handling code of
> > >>> nilfs_sysfs_create_device_group.
> > >>
> > >> Even after I add this patch, my local syzkaller still reports this
> > >> memory leak one hour later. Therefore, there are some other paths or
> > >> magics which can trigger the memory leak. I need to dig deeper.
> > >>
> > >> Pavel, do you have any idea about this crash report?
> > >>
> > >> BUG: memory leak
> > >> unreferenced object 0xffff88804a1a8a60 (size 32):
> > >>    comm "syz-executor", pid 14551, jiffies 4294960586 (age 14.780s)
> > >>    hex dump (first 32 bytes):
> > >>      6c 6f 6f 70 35 00 00 00 00 00 00 00 00 00 00 00  loop5...........
> > >>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >>    backtrace:
> > >>      [<ffffffff814750c6>] kstrdup+0x36/0x70
> > >>      [<ffffffff81475153>] kstrdup_const+0x53/0x80
> > >>      [<ffffffff822773a2>] kvasprintf_const+0xc2/0x110
> > >>      [<ffffffff82337c5b>] kobject_set_name_vargs+0x3b/0xe0
> > >>      [<ffffffff823385ed>] kobject_init_and_add+0x6d/0xc0
> > >>      [<ffffffff81d2bd08>] nilfs_sysfs_create_device_group+0x98/0x3a0
> > >>      [<ffffffff81d14fc4>] init_nilfs+0x424/0x580
> > >>      [<ffffffff81d02962>] nilfs_mount+0x532/0x8c0
> > >>      [<ffffffff815c754b>] legacy_get_tree+0x2b/0x90
> > >>      [<ffffffff81565158>] vfs_get_tree+0x28/0x100
> > >>      [<ffffffff815a3a82>] path_mount+0xb92/0xfe0
> > >>      [<ffffffff815a3f71>] do_mount+0xa1/0xc0
> > >>      [<ffffffff815a4584>] __x64_sys_mount+0xf4/0x160
> > >>      [<ffffffff8433fd35>] do_syscall_64+0x35/0xb0
> > >>      [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >>
> > >>
> > >
> > > Hi, Dongliang!
> > >
> > >
> > > This report says nothing to me... It shows, that there is missing
> > > kobject_put() somewhere. I think, we need a reproducer for this leak,
> > > otherwise only code review can help :(
> > >
> > >
> > >
> >
> > Hm, I guess, I see... We should call kobject_put() in case of
> > kobject_init_and_add() failure:
> >
> > lib/kobject.c:459
> >
> >   * If this function returns an error, kobject_put() must be called to
> >   * properly clean up the memory associated with the object.  This is the
> >
> >
> > so I suggest:
> >
> > diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
> > index 68e8d61e28dd..e8717f4ba2a1 100644
> > --- a/fs/nilfs2/sysfs.c
> > +++ b/fs/nilfs2/sysfs.c
> > @@ -1026,6 +1026,7 @@ int nilfs_sysfs_create_device_group(struct
> > super_block *sb)        kobject_del(&nilfs->ns_dev_kobj);
> >
> >   free_dev_subgroups:
> > +       kobject_put(&nilfs->ns_dev_kobj);
> >         kfree(nilfs->ns_dev_subgroups);
> >
> >   failed_create_device_group:
> >
> >
> > This patch should fix 2 memory leaks :)
>
> Yes. We should move kobject_put from the label cleanup_dev_kobject to
> free_dev_subgroups.
>
> However, I tried the syz reproducer just sent to you. The memory leak
> is still there.
>
> >
> >
> >
> >
> > With regards,
> > Pavel Skripkin
