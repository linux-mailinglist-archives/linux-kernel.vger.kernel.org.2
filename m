Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D0E331EEF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 07:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhCIF7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 00:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhCIF72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 00:59:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47CAC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 21:59:27 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x4so18399139lfu.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 21:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LfdWGUGUgt3KVZT4oX5kzvvtwfjtBAs6OhZr398cIDI=;
        b=EuAmSWd7pNIIhIt8rKjIV46zt+Ex+tlABUJ+OuQXOZRK0eZAqZOd0hBuvwxjY3OlZA
         TWfx5jwu71V6+Owjq1nHK8OKxmgaw0xcvs3XKmo0FoKANFry8DkrY3Qf4c2L5fr/79Mq
         2Uj/7UAJhUCXNtfM47OZwyo03cn3j8U7hciKf8weFzMvC2tj9O48U13O2fD/QZEg3smn
         oEf3nsvYAucFBxsWF7/0tnpWB4wyphVgZWpRdMFQLo8N2q8xOo7TlUfTDFIJRnAZ4Zaw
         serQTx0K2b3T7v6gnSGipN8ipfNkPo89gMXaFMQdZXfqL8PJlJFwj/Bn83hRepr0KuXu
         OumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfdWGUGUgt3KVZT4oX5kzvvtwfjtBAs6OhZr398cIDI=;
        b=k3WdWNOI+CbRff41DJoqLvFqQ6WYJWF/U0qt27+93drDdtM/MCrPQ/qkkN9xRN5zN7
         3j6Bzkf0YoSAU0h0DyQHuubm7D+5wNSud+5yL4bCskZOAApk2HlQbWDKVQVy4VREu7V2
         q1FYb4U2xRmNyXj2nLbz5748EbIV13soCJ0djCvcATaxanb7lECprInYYSZ+KNoJSoig
         kyIO7zS2pnrNSz4Vfg8BIQyJ2YyNWpDdXmKwbb3wzsvxk+B/na+zM5oKjNp4g1lkA7+3
         lyjLjdhmp92zwTWxlR1haeeeOkbdT0CpiQAGAt9Ungcaq1fZGfOlPl6TuUqIJbU0m8sn
         y2iA==
X-Gm-Message-State: AOAM531iwlwhAW6Y24Qy1Lto6TYOHmf0/En8lJs3z2u0LeTb/aCiOQcs
        McjyMx6c+PhiMHjUo+poQSkVZYyPRA9lMv5APxs=
X-Google-Smtp-Source: ABdhPJwh6mrHgK8pcW7M7PP1PqbpDjLBUIEL61wejMHMf3cKXLRjHQtOeVeKZJztIsFwcWGrnkuVMiKCFkCQHy6715M=
X-Received: by 2002:ac2:47ea:: with SMTP id b10mr15758232lfp.499.1615269566318;
 Mon, 08 Mar 2021 21:59:26 -0800 (PST)
MIME-Version: 1.0
References: <CAGyP=7dpTbbj39uO37YrNMg9h4Nzmkszc3MoZg9n8ALir_A52g@mail.gmail.com>
 <YEZcVKbPzfMVK2aK@zeniv-ca.linux.org.uk>
In-Reply-To: <YEZcVKbPzfMVK2aK@zeniv-ca.linux.org.uk>
From:   Palash Oswal <oswalpalash@gmail.com>
Date:   Tue, 9 Mar 2021 11:29:14 +0530
Message-ID: <CAGyP=7fHhyrTP-u0tqCy5ZHzZN0v_0dAoj6dCHnFuBbqtfnBmQ@mail.gmail.com>
Subject: Re: kernel panic: Attempted to kill init!
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     akpm@linux-foundation.org, dave@stgolabs.net,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, rppt@linux.vnet.ibm.com, sds@tycho.nsa.gov,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 10:50 PM Al Viro <viro@zeniv.linux.org.uk> wrote:

> I'd suggest to add printk(KERN_ERR "got to %d", __LINE__); in fs/fhandle.c at
>         beginning of do_handle_open()
>         right before each copy_from_user() in handle_to_path()
>         right before and right after the call of do_handle_to_path() (in the same)
> and try your reproducers on the resulting kernel.

While applying this diff and re-running the reproducer, I see the following:
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 01263ffbc4c0..4e0b171ec9af 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -180,6 +180,7 @@ static int handle_to_path(int mountdirfd, struct
file_handle __user *ufh,
                retval = -EPERM;
                goto out_err;
        }
+       printk(KERN_ERR "got to %d", __LINE__);
        if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle))) {
                retval = -EFAULT;
                goto out_err;
@@ -197,14 +198,16 @@ static int handle_to_path(int mountdirfd, struct
file_handle __user *ufh,
        }
        /* copy the full handle */
        *handle = f_handle;
+       printk(KERN_ERR "got to %d", __LINE__);
        if (copy_from_user(&handle->f_handle,
                           &ufh->f_handle,
                           f_handle.handle_bytes)) {
                retval = -EFAULT;
                goto out_handle;
        }
-
+       printk(KERN_ERR "got to %d", __LINE__);
        retval = do_handle_to_path(mountdirfd, handle, path);
+       printk(KERN_ERR "got to %d", __LINE__);

 out_handle:
        kfree(handle);
@@ -215,6 +218,7 @@ static int handle_to_path(int mountdirfd, struct
file_handle __user *ufh,
 static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
                           int open_flag)
 {
+       printk(KERN_ERR "got to %d", __LINE__);
        long retval = 0;
        struct path path;
        struct file *file

root@sandbox:~# ./repro
[    8.325247] got to 221
[    8.325270] got to 183
[    8.326433] got to 201
[    8.327620] got to 208
[    8.328983] got to 210
[    8.360955] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    8.362261] CPU: 0 PID: 1 Comm: systemd Not tainted 5.11.2+ #20
[    8.363015] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.14.0-1 04/01/2014
[    8.364044] Call Trace:
[    8.364357]  dump_stack+0xb2/0xe4
[    8.364782]  panic+0x196/0x502
[    8.365171]  do_exit.cold+0x70/0x108
[    8.365624]  do_group_exit+0x78/0x120
[    8.366087]  get_signal+0x22e/0xd60
[    8.366528]  arch_do_signal_or_restart+0xef/0x890
[    8.367120]  exit_to_user_mode_prepare+0x102/0x190
[    8.367724]  irqentry_exit_to_user_mode+0x9/0x20
[    8.368303]  irqentry_exit+0x19/0x30
[    8.368759]  exc_page_fault+0xc3/0x240
[    8.369220]  ? asm_exc_page_fault+0x8/0x30
[    8.369726]  asm_exc_page_fault+0x1e/0x30
[    8.370217] RIP: 0033:0x7fa902b4cf10
[    8.370661] Code: Unable to access opcode bytes at RIP 0x7fa902b4cee6.
[    8.371444] RSP: 002b:00007ffc391b20b8 EFLAGS: 00010246
[    8.372081] RAX: 0000000000000000 RBX: 0000559276a67f40 RCX: 00007fa902b7d2e3
[    8.372935] RDX: 00007ffc391b2240 RSI: 00007ffc391b2370 RDI: 0000000000000007
[    8.373860] RBP: 0000000000000007 R08: 0000000000000000 R09: 000000000000000b
[    8.374714] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffc399afaa0
[    8.375568] R13: 0000000000000001 R14: ffffffffffffffff R15: 0000000000000002
[    8.376574] Kernel Offset: disabled
[    8.376992] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---

When I add this change on top of the previous diff:
@@ -263,6 +267,7 @@ SYSCALL_DEFINE3(open_by_handle_at, int, mountdirfd,
                flags |= O_LARGEFILE;

        ret = do_handle_open(mountdirfd, handle, flags);
+       printk(KERN_ERR "got to %d", __LINE__);
        return ret;
 }
I observe the following result(notice the segfault in systemd):
root@sandbox:~# ./repro
[    9.457767] got to 221
[    9.457791] got to 183
[    9.459144] got to 201
[    9.459471] got to 208
[    9.459773] got to 210
[    9.462602] got to 270
[    9.488551] systemd[1]: segfault at 7ffe59fd7fb8 ip
000055be8f20b466 sp 00007ffe59fd7fc0 error 6 in
systemd[55be8f15f000+ed000]
[    9.490723] Code: 00 00 00 00 41 57 41 56 41 55 41 54 55 53 89 fd
48 81 ec 48 01 00 00 64 48 8b 04 25 28 00 00 00 48 89 84 24 38 01 00
00 31 c0 <e8> f5 bf f7 ff 83 f8 01 0f 84 b7 00 00 00 48 8d 9c 240
[    9.492637] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    9.493421] CPU: 0 PID: 1 Comm: systemd Not tainted 5.11.2+ #22
[    9.494067] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.14.0-1 04/01/2014
[    9.495082] Call Trace:
[    9.495348]  dump_stack+0xb2/0xe4
[    9.495709]  panic+0x196/0x502
[    9.496041]  do_exit.cold+0x70/0x108
[    9.496429]  do_group_exit+0x78/0x120
[    9.496822]  get_signal+0x22e/0xd60
[    9.497205]  arch_do_signal_or_restart+0xef/0x890
[    9.497708]  exit_to_user_mode_prepare+0x102/0x190
[    9.498217]  irqentry_exit_to_user_mode+0x9/0x20
[    9.498713]  irqentry_exit+0x19/0x30
[    9.499097]  exc_page_fault+0xc3/0x240
[    9.499498]  ? asm_exc_page_fault+0x8/0x30
[    9.499935]  asm_exc_page_fault+0x1e/0x30
[    9.500364] RIP: 0033:0x55be8f20b466
[    9.500748] Code: 00 00 00 00 41 57 41 56 41 55 41 54 55 53 89 fd
48 81 ec 48 01 00 00 64 48 8b 04 25 28 00 00 00 48 89 84 24 38 01 00
00 31 c0 <e8> f5 bf f7 ff 83 f8 01 0f 84 b7 00 00 00 48 8d 9c 240
[    9.502787] RSP: 002b:00007ffe59fd7fc0 EFLAGS: 00010246
[    9.503364] RAX: 0000000000000000 RBX: 000055be9029bf40 RCX: 00007f4aaec4a2e3
[    9.504102] RDX: 00007ffe59fd8140 RSI: 00007ffe59fd8270 RDI: 0000000000000007
[    9.504839] RBP: 0000000000000007 R08: 0000000000000000 R09: 000000000000000b
[    9.505577] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe5a7d5fa0
[    9.506315] R13: 0000000000000001 R14: ffffffffffffffff R15: 0000000000000002
[    9.507126] Kernel Offset: disabled
[    9.507534] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---
