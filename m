Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7FE3D3B35
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 15:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhGWMt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbhGWMtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:49:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0504DC061575;
        Fri, 23 Jul 2021 06:30:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id he41so3683266ejc.6;
        Fri, 23 Jul 2021 06:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hh2qQyV0e2ZUg+zl/VVNwTimvapqj+B4o1vSa2p3lFE=;
        b=S7IGk/AW41JjfZBmwuLwKk/gXcjZZJQvKRS3UGBxtrpLuHq98VbkUnb7K8Dp3oCYPb
         LyFucS1yf5F9ONLvvCZDVvZX+IAr2+nlIa0X9iTnsJ9elFYsgRUYenAG0Nh7q1rb/8/b
         3DZ8iQzx5bdK+q/farrljjlJARX0llttk64kfnvLv0bLCVQ6pQHZg/8e7ppX9hvRY7Zq
         GdgxtzlPgHvYAopLdj/j0NuzJV27Zta47RL/WaDvQdWUrd9Bj3bXKGHixGR/QaIZGdnn
         Z2JZgXskmhhbr3bLwHogwHfp8hkmm63SPpMXTgYlBgJWC4ZKQg3KCmsFfG0kMbV/YCNk
         W+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hh2qQyV0e2ZUg+zl/VVNwTimvapqj+B4o1vSa2p3lFE=;
        b=F1VvUSrMsJvKkTRJctuVbTAap2E1gGQOm8eQLIbL5UfITngo1uQZCkCnjEjH7ApFTJ
         LxdSYV1duCjIntqtGc9G9CSkPWi5L6KCMJimr/B6ws+HTFTq4C8aQH+f3xyuxAY1VZSW
         RzxHkuZehHRpLLFxhSFv4vw3j2AXGf/xUtIK0H8mO/BQTkhA5Y97gUmYqh04ifhX7K2L
         SCbmXZS8jlo5uQTdBOoFGheW9t/O2ezdwovJ3NoNIZNeoMRof7iOmLnHsSwj0RxlAi/4
         hHhiNyLPpmYahcEwEGDdED4llVWNX7lqZWDPGwIkzT9Sia41E8mCfN9swQ81KwQiiDRi
         dDKQ==
X-Gm-Message-State: AOAM531JXta/XC2Puigb7OB/73c4Kosqhh24zv1IB8Yg+Hdlc6n96E6G
        cIfSS3tEYSgwn5Lap/c2qa/NHGFqRNfwPPovUxU=
X-Google-Smtp-Source: ABdhPJyh9rVEh/TiP20JKVxKQoSCCKRb1SDRhz4hd1pZBrexxwTYaoeUif4GxghImDj6TeUzxG4b5cJnysIB2dH0Ssg=
X-Received: by 2002:a17:906:32d8:: with SMTP id k24mr4711049ejk.422.1627047023886;
 Fri, 23 Jul 2021 06:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210723012317.4146-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210723012317.4146-1-thunder.leizhen@huawei.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 23 Jul 2021 22:30:11 +0900
Message-ID: <CAKFNMonmM09Btxm+0E=39fNLJLvyZd0pryFT0d_y7rz-10rcKA@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: use refcount_dec_and_lock() to fix potential UAF
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 23, 2021 at 10:28 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> When the refcount is decreased to 0, the resource reclamation branch is
> entered. Before CPU0 reaches the race point (1), CPU1 may obtain the
> spinlock and traverse the rbtree to find 'root', see nilfs_lookup_root().
> Although CPU1 will call refcount_inc() to increase the refcount, it is
> obviously too late. CPU0 will release 'root' directly, CPU1 then accesses
> 'root' and triggers UAF.
>
> Use refcount_dec_and_lock() to ensure that both the operations of decrease
> refcount to 0 and link deletion are lock protected eliminates this risk.
>
>      CPU0                      CPU1
> nilfs_put_root():
>                             <-------- (1)
> spin_lock(&nilfs->ns_cptree_lock);
> rb_erase(&root->rb_node, &nilfs->ns_cptree);
> spin_unlock(&nilfs->ns_cptree_lock);
>
> kfree(root);
>                             <-------- use-after-free
>
> ========================================================================
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 2 PID: 9476 at lib/refcount.c:28 \
> refcount_warn_saturate+0x1cf/0x210 lib/refcount.c:28
> Modules linked in:
> CPU: 2 PID: 9476 Comm: syz-executor.0 Not tainted 5.10.45-rc1+ #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ...
> RIP: 0010:refcount_warn_saturate+0x1cf/0x210 lib/refcount.c:28
> ... ...
> Call Trace:
>  __refcount_sub_and_test include/linux/refcount.h:283 [inline]
>  __refcount_dec_and_test include/linux/refcount.h:315 [inline]
>  refcount_dec_and_test include/linux/refcount.h:333 [inline]
>  nilfs_put_root+0xc1/0xd0 fs/nilfs2/the_nilfs.c:795
>  nilfs_segctor_destroy fs/nilfs2/segment.c:2749 [inline]
>  nilfs_detach_log_writer+0x3fa/0x570 fs/nilfs2/segment.c:2812
>  nilfs_put_super+0x2f/0xf0 fs/nilfs2/super.c:467
>  generic_shutdown_super+0xcd/0x1f0 fs/super.c:464
>  kill_block_super+0x4a/0x90 fs/super.c:1446
>  deactivate_locked_super+0x6a/0xb0 fs/super.c:335
>  deactivate_super+0x85/0x90 fs/super.c:366
>  cleanup_mnt+0x277/0x2e0 fs/namespace.c:1118
>  __cleanup_mnt+0x15/0x20 fs/namespace.c:1125
>  task_work_run+0x8e/0x110 kernel/task_work.c:151
>  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:164 [inline]
>  exit_to_user_mode_prepare+0x13c/0x170 kernel/entry/common.c:191
>  syscall_exit_to_user_mode+0x16/0x30 kernel/entry/common.c:266
>  do_syscall_64+0x45/0x80 arch/x86/entry/common.c:56
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> There is no reproduction program, and the above is only theoretical
> analysis.
>
> Fixes: ba65ae4729bf ("nilfs2: add checkpoint tree to nilfs object")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Thank you for sending this patch.   I understand the purpose of
the correction.   I feel we need more review for  the life cycle
management of nilfs_root structure related to kobject.

Anyway,  I would like to apply this patch itself.

Thanks,
Ryusuke Konishi


> ---
>  fs/nilfs2/the_nilfs.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
> index 8b7b01a380ce..c8bfc01da5d7 100644
> --- a/fs/nilfs2/the_nilfs.c
> +++ b/fs/nilfs2/the_nilfs.c
> @@ -792,14 +792,13 @@ nilfs_find_or_create_root(struct the_nilfs *nilfs, __u64 cno)
>
>  void nilfs_put_root(struct nilfs_root *root)
>  {
> -       if (refcount_dec_and_test(&root->count)) {
> -               struct the_nilfs *nilfs = root->nilfs;
> +       struct the_nilfs *nilfs = root->nilfs;
>
> -               nilfs_sysfs_delete_snapshot_group(root);
> -
> -               spin_lock(&nilfs->ns_cptree_lock);
> +       if (refcount_dec_and_lock(&root->count, &nilfs->ns_cptree_lock)) {
>                 rb_erase(&root->rb_node, &nilfs->ns_cptree);
>                 spin_unlock(&nilfs->ns_cptree_lock);
> +
> +               nilfs_sysfs_delete_snapshot_group(root);
>                 iput(root->ifile);
>
>                 kfree(root);
> --
> 2.25.1
>
