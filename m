Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F34442640D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 07:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhJHF2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 01:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJHF2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 01:28:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52712C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 22:26:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y12so18468056eda.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 22:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=looF01hX1KIHTw6RXU9MnOlgNqM3cRFB1AmcaiSRvII=;
        b=W0TleFp1S63lTX9NagfTDYT5kLi6djiDVKmhvDvB+xmFYrl+3br7RSyjJb0XZ8Uc0Q
         af4fqF4SFsByHGqvMlrhfuU/ALEGx21AUngvR5qslsQ4/yJqJ9A/p3rWMWyMpsQX5o8I
         T6cZJYdAiSWAhSKrKNBVj+zWLpP9EElmAKuDJxwOSP6DmdTx8LltWl5oQCatBzDsQ3eU
         zhCObSAGUrlcN+eK7oHjIQ3uEngTQkQk+/a32cbdmYOgDV3FFtaqIwszUic+AIyBi/VS
         tIsdbFmtuvpWedBzvdO4QAnu+yCFVP7oAKcl93fOCl1e2bm9vmNzEsecE0Fmzmzm1T//
         029A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=looF01hX1KIHTw6RXU9MnOlgNqM3cRFB1AmcaiSRvII=;
        b=KDGOosREiw4rPLxQoJN5PCzD4KzliRm+DvQvvcjauIClmly/DCO8ho9ZblIR5LSUD7
         K7aMTgFZjPYJky5TuvObQ9kf2NTY7TC6hsg8Wc1S21pSqkhvdfcmTaAmnUhm+22yfqeK
         q8eIto7+l8W0Dyffc8Y7h9n+/oz7pGFbA/0LWK7bW491o5Y1KOLpfevvVY3TxUzw0Efu
         3d24gTrR3MqevJFhWFtWpjn4KWcOf0ybxC8CmTSfqYqMgJLkZkmhTPpkCY9muilAkAt6
         61w1t2dWXtHqWQhhbdeDNLWDgMPsqPmV2uAgkJEoX5ERU95BhGDv+ScTQulJ1NCqi0ZI
         Kizw==
X-Gm-Message-State: AOAM533q0eCXbfu34urD1wIK3gaoYKoiAQVpOTU0VAi7syZn/I5rS0xE
        JLmjqBZ+Sd1zTiy5GndwTzOxL8lyrSsqG/O3edg=
X-Google-Smtp-Source: ABdhPJwz4FJvFqQ0Mqs0twnX8nmeRTmAo64UswdbcuZWcwZcEWbF3hrOjA7p/KJ0Q8NiIzHHU/Z0dSVg7FkZGyr0O9w=
X-Received: by 2002:a17:907:76e1:: with SMTP id kg1mr1548900ejc.329.1633670763767;
 Thu, 07 Oct 2021 22:26:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211001174947.135123-1-eric.dumazet@gmail.com>
In-Reply-To: <20211001174947.135123-1-eric.dumazet@gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 8 Oct 2021 13:25:37 +0800
Message-ID: <CAD-N9QVtBrWrtAFQkyd=zRwnA4AjnBBeqhD_P-QFXz-QtUOzog@mail.gmail.com>
Subject: Re: [PATCH] mm/mempolicy: do not allow illegal MPOL_F_NUMA_BALANCING
 | MPOL_LOCAL in mbind()
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "Huang, Ying" <ying.huang@intel.com>, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 2, 2021 at 1:49 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> syzbot reported access to unitialized memory in mbind() [1]
>
> Issue came with commit bda420b98505 ("numa balancing: migrate on
> fault among multiple bound nodes")
>
> This commit added a new bit in MPOL_MODE_FLAGS, but only checked
> valid combination (MPOL_F_NUMA_BALANCING can only be used with MPOL_BIND)
> in do_set_mempolicy()
>
> This patch moves the check in sanitize_mpol_flags() so that it
> is also used by mbind()
>
> [1]
> BUG: KMSAN: uninit-value in __mpol_equal+0x567/0x590 mm/mempolicy.c:2260
>  __mpol_equal+0x567/0x590 mm/mempolicy.c:2260
>  mpol_equal include/linux/mempolicy.h:105 [inline]
>  vma_merge+0x4a1/0x1e60 mm/mmap.c:1190
>  mbind_range+0xcc8/0x1e80 mm/mempolicy.c:811
>  do_mbind+0xf42/0x15f0 mm/mempolicy.c:1333
>  kernel_mbind mm/mempolicy.c:1483 [inline]
>  __do_sys_mbind mm/mempolicy.c:1490 [inline]
>  __se_sys_mbind+0x437/0xb80 mm/mempolicy.c:1486
>  __x64_sys_mbind+0x19d/0x200 mm/mempolicy.c:1486
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Uninit was created at:
>  slab_alloc_node mm/slub.c:3221 [inline]
>  slab_alloc mm/slub.c:3230 [inline]
>  kmem_cache_alloc+0x751/0xff0 mm/slub.c:3235
>  mpol_new mm/mempolicy.c:293 [inline]
>  do_mbind+0x912/0x15f0 mm/mempolicy.c:1289
>  kernel_mbind mm/mempolicy.c:1483 [inline]
>  __do_sys_mbind mm/mempolicy.c:1490 [inline]
>  __se_sys_mbind+0x437/0xb80 mm/mempolicy.c:1486
>  __x64_sys_mbind+0x19d/0x200 mm/mempolicy.c:1486
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> =====================================================
> Kernel panic - not syncing: panic_on_kmsan set ...
> CPU: 0 PID: 15049 Comm: syz-executor.0 Tainted: G    B             5.15.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1ff/0x28e lib/dump_stack.c:106
>  dump_stack+0x25/0x28 lib/dump_stack.c:113
>  panic+0x44f/0xdeb kernel/panic.c:232
>  kmsan_report+0x2ee/0x300 mm/kmsan/report.c:186
>  __msan_warning+0xd7/0x150 mm/kmsan/instrumentation.c:208
>  __mpol_equal+0x567/0x590 mm/mempolicy.c:2260
>  mpol_equal include/linux/mempolicy.h:105 [inline]
>  vma_merge+0x4a1/0x1e60 mm/mmap.c:1190
>  mbind_range+0xcc8/0x1e80 mm/mempolicy.c:811
>  do_mbind+0xf42/0x15f0 mm/mempolicy.c:1333
>  kernel_mbind mm/mempolicy.c:1483 [inline]
>  __do_sys_mbind mm/mempolicy.c:1490 [inline]
>  __se_sys_mbind+0x437/0xb80 mm/mempolicy.c:1486
>  __x64_sys_mbind+0x19d/0x200 mm/mempolicy.c:1486
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f4a41b2c709
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f4a3f0a3188 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
> RAX: ffffffffffffffda RBX: 00007f4a41c30f60 RCX: 00007f4a41b2c709
> RDX: 0000000000002001 RSI: 0000000000c00007 RDI: 0000000020012000
> RBP: 00007f4a41b86cb4 R08: 0000000000000000 R09: 0000010000000002
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f4a42164b2f R14: 00007f4a3f0a3300 R15: 0000000000022000
>

Hi Eric,

this crash seems like the bug report [1] on Syzbot dashboard.

[1] https://syzkaller.appspot.com/bug?id=028833194204bb15c2c43d822b8f7401360d57f5

If yes, maybe you can push a patch testing request.

> Fixes: bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> ---
>  mm/mempolicy.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 1592b081c58ef6dd63c6f075ad24722f2be7cb5d..7a7abdbec7af66f88bb68cb4f47e9722d56bfd5b 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -856,16 +856,6 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
>                 goto out;
>         }
>
> -       if (flags & MPOL_F_NUMA_BALANCING) {
> -               if (new && new->mode == MPOL_BIND) {
> -                       new->flags |= (MPOL_F_MOF | MPOL_F_MORON);
> -               } else {
> -                       ret = -EINVAL;
> -                       mpol_put(new);
> -                       goto out;
> -               }
> -       }
> -
>         ret = mpol_set_nodemask(new, nodes, scratch);
>         if (ret) {
>                 mpol_put(new);
> @@ -1458,7 +1448,11 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
>                 return -EINVAL;
>         if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
>                 return -EINVAL;
> -
> +       if (*flags & MPOL_F_NUMA_BALANCING) {
> +               if (mode != MPOL_BIND)
> +                       return -EINVAL;
> +               *flags |= (MPOL_F_MOF | MPOL_F_MORON);
> +       }
>         return 0;
>  }
>
> --
> 2.33.0.800.g4c38ced690-goog
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/20211001174947.135123-1-eric.dumazet%40gmail.com.
