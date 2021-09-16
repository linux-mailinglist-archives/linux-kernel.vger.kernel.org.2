Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F1C40D37D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhIPG4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhIPG4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:56:48 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E90C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:55:26 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id g11so4698224qtk.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 23:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HB7lc7Zk+ueXYqzb3xDFQckZBoKqtKKETr6UlAuAz58=;
        b=JeaNx4p8CAXN8qfhzvAJf05bDu3KHMjBuj81Pe5mXZfsMBumfTz2oOgt6m2uacGmdL
         6HodPqxRGO4pUuT4KY16soJORATK9RuxV3/kSNA33WpvbdT2QE4NeyRGGoSoffVFYZpK
         bQr18U7Q730pBcMDDKhnFiwT0FrGZr6BLh5GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HB7lc7Zk+ueXYqzb3xDFQckZBoKqtKKETr6UlAuAz58=;
        b=sSpH+UnJNLyrs6FPGEICu+Nx94ZO9efWU8BGPmWHryhnc4YStG+/voS4qfsN+SJ6VQ
         wkTyR1QtYUOgyqlayc6GZTJqhuUx9XG3v/bFxsbbfvbiuk8zSAb7y+zBsGjKguQncyp2
         2czfjDwR9fiEW9HxgR/7XNDomAhWh4jUZNb/hdUoz40bHqzBjHrWrgyHBT429Ksmj7ag
         aIDmQojaGXxkvKolSblJeTN9jXZ089IFTzF2ilykfDfeRS7hjvY3tRZKzhjZ10R8l3Ah
         75nlzMmIO75Wg7/7TJQkCgkMh+EeX7ISJP/IpQAijFdPDVVwfRrz7y0+Bekrx3ZM7YxW
         mwJw==
X-Gm-Message-State: AOAM5307q7Z0p621MQMB6Eaieh0Dp1X+zU4f8i2qmmrY8zl0tIXVUaJ0
        NZ1fzhEiTE9ba2T63wdJZ9g9GdLANS9doNZKL4U=
X-Google-Smtp-Source: ABdhPJztFY7KjKx6Cg5lTgytbk28bBWMe8Y3BdOK/3kMpi5B8NvPpSlCFSYJb3oclU92SRLEZ3Ne/+4A7xf1aozEczM=
X-Received: by 2002:a05:622a:15d2:: with SMTP id d18mr3541637qty.145.1631775326026;
 Wed, 15 Sep 2021 23:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bd7c8a05c719ecf2@google.com> <20210721033703.949-1-hdanton@sina.com>
 <20210721043034.GB7444@lst.de> <39ac87a8-42ac-acf7-11eb-ba0b6a9f4a95@gmail.com>
In-Reply-To: <39ac87a8-42ac-acf7-11eb-ba0b6a9f4a95@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 16 Sep 2021 06:55:13 +0000
Message-ID: <CACPK8XfUWoOHr-0RwRoYoskia4fbAbZ7DYf5wWBnv6qUnGq18w@mail.gmail.com>
Subject: Re: [syzbot] WARNING in internal_create_group
To:     Pavel Skripkin <paskripkin@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+9937dc42271cd87d4b98@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Eric Sandeen <sandeen@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 21:39, Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> On 7/21/21 7:30 AM, Christoph Hellwig wrote:
> > On Wed, Jul 21, 2021 at 11:37:03AM +0800, Hillf Danton wrote:
> >> On Tue, 20 Jul 2021 11:53:27 -0700
> >> >syzbot has found a reproducer for the following issue on:
> >> >
> >> >HEAD commit:    8cae8cd89f05 seq_file: disallow extremely large seq buffer..
> >> >git tree:       upstream
> >> >console output: https://syzkaller.appspot.com/x/log.txt?x=116f92ec300000
> >> >kernel config:  https://syzkaller.appspot.com/x/.config?x=7273c75708b55890
> >> >dashboard link: https://syzkaller.appspot.com/bug?extid=9937dc42271cd87d4b98
> >> >syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fc287c300000
> >> >C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178cbf6a300000
> >
> > <snip>
> >
> >> >WARNING: CPU: 0 PID: 8435 at fs/sysfs/group.c:116 internal_create_group+0x911/0xb20 fs/sysfs/group.c:116
> >
> > <snip>
> >
> >> The device_add(ddev) in register_disk() may fail but it proceeds to register
> >> block queue even at the failure ... this falls in the class of known issue
> >> given the comment line.
> >>
> >>  * FIXME: error handling
> >>  */
> >> static void __device_add_disk(struct device *parent, struct gendisk *disk,
> >
> > Yes, Luis is working on actually fixing this - but it requires changes
> > to every single block driver.  How does a cap on the seq_buf size
> > propagate here, though?
> >
>
> Hi!
>
> I've looked into this, and, I think, we can add sanity check for
> first_minor. If user will pass too big index (syzbot's repro passes
> 1048576) this value will be shifted to part_shift and then truncated to
> byte in __device_add_disk() and assigned to dev->devt. User may be
> confused about why he passed 1048576, but sysfs warns about duplicate
> creation of /dev/block/43:0
>
> So, these type of errors can be handled before passing wrong values to
> sysfs API like this:
>
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index c38317979f74..600e9bab5d43 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1725,7 +1725,17 @@ static int nbd_dev_add(int index)
>         refcount_set(&nbd->refs, 1);
>         INIT_LIST_HEAD(&nbd->list);
>         disk->major = NBD_MAJOR;
> +
> +       /* Too big first_minor can cause duplicate creation of
> +        * sysfs files/links, since first_minor will be truncated to
> +        * byte in __device_add_disk().
> +        */
>         disk->first_minor = index << part_shift;
> +       if (disk->first_minor > 0xff) {
> +               err = -EINVAL;
> +               goto out_free_idr;
> +       }
> +
>         disk->minors = 1 << part_shift;
>         disk->fops = &nbd_fops;
>         disk->private_data = nbd;
>

This one got backported to v5.10.65, and causes a warning on boot:

[    7.114976] ------------[ cut here ]------------
[    7.116811] WARNING: CPU: 0 PID: 1 at block/blk-mq.c:3045
blk_mq_release+0x84/0x114
[    7.117510] Modules linked in:
[    7.118593] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.65 #196
[    7.118691] Hardware name: Generic DT based system
[    7.119088] Backtrace:
[    7.119675] [<8093aff0>] (dump_backtrace) from [<8093b294>]
(show_stack+0x20/0x24)
[    7.120052]  r7:00000009 r6:60000153 r5:00000000 r4:80e75938
[    7.120223] [<8093b274>] (show_stack) from [<80940938>]
(dump_stack+0xc8/0xe4)
[    7.120298] [<80940870>] (dump_stack) from [<80123174>] (__warn+0xe8/0x154)
[    7.120355]  r7:00000009 r6:00000be5 r5:804bc594 r4:80b53c80
[    7.120415] [<8012308c>] (__warn) from [<8093b9b4>]
(warn_slowpath_fmt+0x6c/0xe4)
[    7.120465]  r7:00000009 r6:00000be5 r5:80b53c80 r4:00000000
[    7.120537] [<8093b94c>] (warn_slowpath_fmt) from [<804bc594>]
(blk_mq_release+0x84/0x114)
[    7.120594]  r8:80b53c80 r7:857b7390 r6:00000001 r5:80ea6efd r4:00000000
[    7.120656] [<804bc510>] (blk_mq_release) from [<804ad65c>]
(blk_release_queue+0xb8/0x128)
[    7.120756]  r9:00000001 r8:80eee400 r7:00000000 r6:857b7390
r5:00000001 r4:857b73d8
[    7.120836] [<804ad5a4>] (blk_release_queue) from [<8052f87c>]
(kobject_put+0xc8/0x210)
[    7.120891]  r7:00000000 r6:00000000 r5:80e751bc r4:857b73d8
[    7.120948] [<8052f7b4>] (kobject_put) from [<804a9b00>]
(blk_put_queue+0x1c/0x20)
[    7.120998]  r7:00000000 r6:857b3800 r5:00000000 r4:857b3860
[    7.121055] [<804a9ae4>] (blk_put_queue) from [<804c2784>]
(disk_release+0xb0/0x118)
[    7.121118] [<804c26d4>] (disk_release) from [<805f717c>]
(device_release+0x40/0xb4)
[    7.121168]  r7:00000000 r6:00000000 r5:00000000 r4:857b3860
[    7.121224] [<805f713c>] (device_release) from [<8052f87c>]
(kobject_put+0xc8/0x210)
[    7.121265]  r5:80e81154 r4:857b3860
[    7.121318] [<8052f7b4>] (kobject_put) from [<804c1c74>] (put_disk+0x24/0x28)
[    7.121368]  r7:ffffffea r6:00000008 r5:857b3800 r4:857bca00
[    7.121440] [<804c1c50>] (put_disk) from [<806286f4>]
(nbd_dev_add+0x214/0x27c)
[    7.121670] [<806284e0>] (nbd_dev_add) from [<80d22f80>]
(nbd_init+0xec/0x120)
[    7.121740]  r10:80ec7000 r9:80c06b34 r8:80d39834 r7:00000000
r6:80e82aa8 r5:00000009
[    7.121777]  r4:00000000
[    7.121842] [<80d22e94>] (nbd_init) from [<80102364>]
(do_one_initcall+0x50/0x274)
[    7.121893]  r7:00000000 r6:00000007 r5:8116d180 r4:80d22e94
[    7.121956] [<80102314>] (do_one_initcall) from [<80d012e8>]
(kernel_init_freeable+0x1b8/0x240)
[    7.122005]  r7:80d39854 r6:00000007 r5:8116d180 r4:80d5e788
[    7.122067] [<80d01130>] (kernel_init_freeable) from [<80947bac>]
(kernel_init+0x18/0x130)
[    7.122126]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:80947b94
[    7.122161]  r4:00000000
[    7.122218] [<80947b94>] (kernel_init) from [<80100168>]
(ret_from_fork+0x14/0x2c)
[    7.122413] Exception stack(0x810b7fb0 to 0x810b7ff8)
[    7.122936] 7fa0:                                     00000000
00000000 00000000 00000000
[    7.123287] 7fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    7.123545] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    7.123728]  r5:80947b94 r4:00000000
[    7.124011] ---[ end trace d69e5842dc8c9352 ]---

There's been a bit going on in this driver since v5.10, so I assume
it's missing some dependent changes.

Cheers,

Joel
