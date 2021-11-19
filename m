Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D4345677F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 02:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhKSBjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 20:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhKSBjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 20:39:09 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F9CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 17:36:08 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 206so2128891pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 17:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0siYFiisAqHr/97Ze11iN/VK6lSDS+auEVlo++cpff0=;
        b=TH4FHegUqejaldo7dCYtnUM06tnTPpFwUhy7SPxR6roVN2VmHE0Mt5hQwChU5GqQI3
         3dFTc1Co7q/ptfcZPG3zn8wVvT418cWTWhlRW1hVXXzGmof+AbRolxPAh59vaLqY34lB
         +fATqj5MPETz4+K1vUkV4fhKvkvLhMCQ2DebNC6grDUtZwtZRgvM3azZAloc3JBXEKGA
         GM/7clwS5xojCLV2EKuT5v3Uki/EP1O6lWwmkSmSnL0IEm3NNkKo3QHtQK6Uu6spdGo0
         u2/LMDw54H9d9XLg/wFmkp+wexKVzVSfLZGeDdNUVF0qit+EpkQ/sxiK7PfHAKswUs54
         1g9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0siYFiisAqHr/97Ze11iN/VK6lSDS+auEVlo++cpff0=;
        b=GriXj+yGiVokqGpfIpMwEPtcmUpOG5QjTPD/ijtBuJ5UibTfRDZn0jn3ETPBBErVKZ
         jO81s9YF344jOB0V5ji3wjMGf8tJ+/6AxNoOU55NkFhA2akPB6JoOxNwlQIIxlbiHsWN
         zj34pDuTRNf7e77iWACntnApNBKVVbn1m6/LCpokMhq2sgHhBTEaNGpQWvqsuuV5+R46
         HGvsD1NkNZTX8wuREcriK11x2TA6sPVAuNZWrMnWvUu/9fU/48gz7McOA7HNc7Jq8BcA
         agnEThL6YSlwJOXV6APnXWbybbwLS5Yp1GR01AcF6Tow1T2qy0BxQGRkl+wahcvAsh3z
         jABA==
X-Gm-Message-State: AOAM530Fmp8srEtC5pn5u0GXX9fG0S5qCkKuQPucL43BmKiSXUAJg7qK
        vvVn61ZjBwcWwgW7U3yw0etGAXWV7g7rVXXb1KPCXw==
X-Google-Smtp-Source: ABdhPJxDVwRXpuH635vv64jKm/oKcgtRJBhlnW1rW9plKxO9nrbNpeEpuyEQkQjnF15mjqMJY1h27YeqeIojkJAifAg=
X-Received: by 2002:a63:6302:: with SMTP id x2mr14826874pgb.5.1637285768022;
 Thu, 18 Nov 2021 17:36:08 -0800 (PST)
MIME-Version: 1.0
References: <YZb7PgQ6Bw26cpsh@google.com>
In-Reply-To: <YZb7PgQ6Bw26cpsh@google.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 18 Nov 2021 17:35:57 -0800
Message-ID: <CAPcyv4h_S_fgD8EY2qX9zqFPz__1uCByZUoPvosZDUvjRp3Jzg@mail.gmail.com>
Subject: Re: mm: gdb fails if binary is on a DAX-enabled filesystem
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 5:18 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Hello,
>
> We are running into issues on a DAX enabled system: both
> __copy_from_user_inatomic() fail.
>
> [   28.914865] ------------[ cut here ]------------
> [   28.915800] WARNING: CPU: 0 PID: 106 at mm/memory.c:2822 wp_page_copy+0x136/0x320
> [   28.916857] CPU: 0 PID: 106 Comm: gdb Not tainted 5.15.0-01277-g6be711548944 #1
> [   28.917823] Hardware name: ChromiumOS crosvm, BIOS 0
> [   28.918455] RIP: 0010:wp_page_copy+0x136/0x320
> [   28.919001] Code: f1 79 00 4c 89 7b 50 48 8b 43 38 31 d2 49 39 07 75 23 48 8b 7d c8 48 8b 75 c0 ba 00 10 00 00 e8 6f 23 78 00 b2 01 85 c0 74 0b <0f> 0b 48 8b 7d c8 e8 8e 1f 78 00 48 8b 7b 58 88 55 c8 e8 2e f2 79
> [   28.920642] RSP: 0018:ffffc900005dfbd8 EFLAGS: 00010206
> [   28.921135] RAX: 0000000000001000 RBX: ffffc900005dfc40 RCX: 0000000000001000
> [   28.921762] RDX: 0000000000001001 RSI: 0000000000448000 RDI: ffff8880007bb000
> [   28.922410] RBP: ffffc900005dfc28 R08: ffff8880031884c8 R09: 0000000000000000
> [   28.923058] R10: ffff88800f8234c8 R11: 0000000000000000 R12: ffffea000001eec0
> [   28.923718] R13: 0000000000000000 R14: ffff88800e18e630 R15: ffff888000884240
> [   28.924404] FS:  00007e5b49744180(0000) GS:ffff88800f800000(0000) knlGS:0000000000000000
> [   28.925146] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   28.925688] CR2: 0000000000448000 CR3: 000000000e0d6000 CR4: 0000000000350eb0
> [   28.926368] Call Trace:
> [   28.926622]  __handle_mm_fault+0x67e/0xbd7
> [   28.927018]  handle_mm_fault+0x16b/0x23d
> [   28.927390]  __get_user_pages+0x2d6/0x4b7
> [   28.927797]  __get_user_pages_remote+0xbe/0x20c
> [   28.928224]  __access_remote_vm+0xb3/0x1c8
> [   28.928655]  ptrace_access_vm+0x97/0xb0
> [   28.929036]  generic_ptrace_pokedata+0x22/0x31
> [   28.929452]  arch_ptrace+0x1ce/0x1dd
> [   28.929801]  __do_sys_ptrace+0xa9/0xda
> [   28.930161]  do_syscall_64+0x75/0x8b
> [   28.930511]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   28.930996] RIP: 0033:0x7e5b4c86fe5a
> [   28.931332] Code: 70 41 83 f8 03 c7 44 24 10 08 00 00 00 48 89 44 24 18 48 8d 44 24 30 8b 70 08 4c 0f 43 d1 48 89 44 24 20 b8 65 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 3e 48 85 c0 78 06 41 83 f8 02 76 1b 48 8b 4c
> [   28.933086] RSP: 002b:00007ffdc3369150 EFLAGS: 00000202 ORIG_RAX: 0000000000000065
> [   28.933767] RAX: ffffffffffffffda RBX: 0000000000448620 RCX: 00007e5b4c86fe5a
> [   28.934476] RDX: 0000000000448620 RSI: 000000000000006d RDI: 0000000000000005
> [   28.935206] RBP: 0000000000000001 R08: 0000000000000004 R09: 0000000000448620
> [   28.935916] R10: 00841f0f2e6666cc R11: 0000000000000202 R12: 0000000000000001
> [   28.936672] R13: 00841f0f2e6666cc R14: 0000000000000000 R15: 00007e5b49743958
> [   28.937389] ---[ end trace 2808c0ffd7259839 ]---
> Program received signal SIGSEGV, Segmentation fault.
>
> Is there anything we can do about it?

I'll take a look, can you send a bit more info about your
configuration? Which filesystem, and which driver is providing the dax
access?
