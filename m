Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D640A40160D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 07:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbhIFFo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 01:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhIFFo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 01:44:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA84BC061575;
        Sun,  5 Sep 2021 22:43:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id e21so11044063ejz.12;
        Sun, 05 Sep 2021 22:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsxGV1RP9Qi0JMIFcPUgri7gLr8bvFdyAKQBx+2bqDQ=;
        b=XS0PIbA0p2E3/rdHhXs2C/OtTi+suafl5NnoBSza8txXP/vcVueLKhPBLk4IQP0B3R
         S1PwWMo7p6V+ihljnquaObMu1zYSM+uo3hzNG+b39OQ5e4oWudvWN1FYEol87VvFJcAy
         tKrx+Pjd9RKCQYxwhD22qNgnkDh5URnQbFAKnqA/QwCu3/wWnD+4+HZP0YcUey7y98cH
         4YqnYyUfJiwFazHIczoJGIi1eiof62yXsh/snv2pNQitZLwY927vbrZmL2ymqNUi6nzr
         iOvwC3rTW1sMfUcH88EuFCELA3jIW8lny1e1T/n0PhERdaOphpUqjkHb0hgUWkwA8JUd
         56pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsxGV1RP9Qi0JMIFcPUgri7gLr8bvFdyAKQBx+2bqDQ=;
        b=qtzE1bZGNzb1bqT0Orj9q4vnJd0Szt9MU+muQL25LC9lc1MHABc/C//6NHGiLUqNB/
         MVFrXm/Lme9QTaEVIW/DVc2fg40fKc1ExG3O75PPSAAbQqUNFIi6Fa/BPLi4tAq7D2sT
         /ElplGK32GBnMYnbfM+LbQ75rm6Lnx+3Yd26W0QPum0jk014uZB5T89oZiMXYnZ3/qZA
         H0bQPT04PhxzTDAut4eBxgsJAIcNewfxV+CpkRduK06uewmkItN7JcMYV5Ggf3zDu3GB
         HuwsLSYfO4FEo/e17/UhJMZW+qTfxWmZH7we5Cq1NsGUk8VBLfqAnDQX/hbxC0AWB5Bl
         m5tA==
X-Gm-Message-State: AOAM532Hhas9ysnzvX7TkQuqcjlUONU552eU4sNH0qPXUhexfYOSFneN
        +vTFhQFogvLUhrjC8oEV01Oz/bg2A3fmGysxM/dNDQPasU2PZR6m
X-Google-Smtp-Source: ABdhPJziIuA6kiI1zFi7BQAYo+peyr0Zjg6UTC5M0V0BuTbahvCl8SJzeFjZPErL+CJdvuTawJ4UfTzgbZTUgRcr4PM=
X-Received: by 2002:a17:906:ce24:: with SMTP id sd4mr11923804ejb.329.1630907032449;
 Sun, 05 Sep 2021 22:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210906041330.2065214-1-mudongliangabcd@gmail.com>
In-Reply-To: <20210906041330.2065214-1-mudongliangabcd@gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 6 Sep 2021 13:43:26 +0800
Message-ID: <CAD-N9QUHfoqOOxDuKniMi8VGLR2j6g50BBy45eAL0kPRrntmgA@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix memory leak in nilfs_sysfs_create_device_group
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, linux-nilfs@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 12:13 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> The commit 8fd0c1b0647a ("nilfs2: fix memory leak in
> nilfs_sysfs_delete_device_group") adds a kobject_put to free the leaking
> object name. However, it is incomplete to only add kobject_put in the
> nilfs_sysfs_delete_device_group. The function
> nilfs_sysfs_create_device_group also needs the kobject_put to
> free the object name in the error handling part.
>
> Fix this by adding kobject_put in the error handling code of
> nilfs_sysfs_create_device_group.

Even after I add this patch, my local syzkaller still reports this
memory leak one hour later. Therefore, there are some other paths or
magics which can trigger the memory leak. I need to dig deeper.

Pavel, do you have any idea about this crash report?

BUG: memory leak
unreferenced object 0xffff88804a1a8a60 (size 32):
  comm "syz-executor", pid 14551, jiffies 4294960586 (age 14.780s)
  hex dump (first 32 bytes):
    6c 6f 6f 70 35 00 00 00 00 00 00 00 00 00 00 00  loop5...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814750c6>] kstrdup+0x36/0x70
    [<ffffffff81475153>] kstrdup_const+0x53/0x80
    [<ffffffff822773a2>] kvasprintf_const+0xc2/0x110
    [<ffffffff82337c5b>] kobject_set_name_vargs+0x3b/0xe0
    [<ffffffff823385ed>] kobject_init_and_add+0x6d/0xc0
    [<ffffffff81d2bd08>] nilfs_sysfs_create_device_group+0x98/0x3a0
    [<ffffffff81d14fc4>] init_nilfs+0x424/0x580
    [<ffffffff81d02962>] nilfs_mount+0x532/0x8c0
    [<ffffffff815c754b>] legacy_get_tree+0x2b/0x90
    [<ffffffff81565158>] vfs_get_tree+0x28/0x100
    [<ffffffff815a3a82>] path_mount+0xb92/0xfe0
    [<ffffffff815a3f71>] do_mount+0xa1/0xc0
    [<ffffffff815a4584>] __x64_sys_mount+0xf4/0x160
    [<ffffffff8433fd35>] do_syscall_64+0x35/0xb0
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae


>
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  fs/nilfs2/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
> index 68e8d61e28dd..7ab60711ca76 100644
> --- a/fs/nilfs2/sysfs.c
> +++ b/fs/nilfs2/sysfs.c
> @@ -1024,6 +1024,7 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
>
>  cleanup_dev_kobject:
>         kobject_del(&nilfs->ns_dev_kobj);
> +       kobject_put(&nilfs->ns_dev_kobj);
>
>  free_dev_subgroups:
>         kfree(nilfs->ns_dev_subgroups);
> --
> 2.25.1
>
