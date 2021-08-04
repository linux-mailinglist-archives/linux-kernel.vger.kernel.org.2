Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B273E015F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbhHDMos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238140AbhHDMop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:44:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83596C061799
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 05:44:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id yk17so3458827ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 05:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHpM1wB8GC7B0gndgKLXatkqmK6m0EnOPisfXQMQMVs=;
        b=KB7qH+Qi2MihcmOrId/b+1JPq1nNYa8yJnPN4pHgd/UkXmLoc5+vtEmrKojo3mN7ag
         rogzWJZQJzGt0oeT5F3iQOn5FowESBrgCfAm1g2BGtY/w1MTc7RaO813ueQQKhZL1XPC
         aiNCcLemuIlBAMawSlpxd0lQuudzwR5jR8+E1uO1LqABqtyapj6bFbHILx/atswIdyVf
         x86I/WkXRRjRn+H6tOpt/AibL8pca5QMEHKFcuGgEKZLoTumf954rfP7dquKZv+QMOZB
         pQnGKgsSqTc4P24eGUMldCVAEttM6SlJxUiWdkJAqeKTKVUbai4uQoB7ymmL+DHf5jBF
         XVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHpM1wB8GC7B0gndgKLXatkqmK6m0EnOPisfXQMQMVs=;
        b=bCFRZkyQKXAjBe2iu8p4MZetH1R7OcN7/RgmSA8TgcnTwwZnduN2LxlaQDWK9Dnw+3
         sqzlve06p+QMP7pZ0zlx819LnK0Jj7G7i6dJtEAIxZOMet6Aki3HAZYaTpK9BteSG2MM
         21eVyLxWJGLWfG0pBzPTviKSwy37CF5KI3wlolYyBqeO81Z7hhFsZSc2h2wzXVVWf8ay
         3G6C91MyW80n6wdbnBqVgpMewsZ+PgS4EvBtACXNJDB8pRXJdFNujzkml9dp225gP3P3
         geiitLk+/vLjNp47PfIngO+SUY2cQkBPCjM8W3Dag4pO8OJ0KrC0LvzTmvnmjQFU7Tnt
         Aruw==
X-Gm-Message-State: AOAM532ZTBDjZVy2qAJrXjs2FAaBCRu+GBjt6k5r0M0MwCmUSKlSIn9s
        bUF64Hft9t8wTiNW3Tkm0bKrIQjwmW0YGlo1rhE=
X-Google-Smtp-Source: ABdhPJxLXyga9pGI26y+2jHG2/O5eyxA3lfBtQ75gsUCrsRnEPZpuBvoYtBWGjhtF1HKkw9sbPQ62MCSUI8JseT0vG4=
X-Received: by 2002:a17:906:f112:: with SMTP id gv18mr25819921ejb.439.1628081070045;
 Wed, 04 Aug 2021 05:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210804090957.12393-1-Kuan-Ying.Lee@mediatek.com> <20210804090957.12393-2-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20210804090957.12393-2-Kuan-Ying.Lee@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 4 Aug 2021 14:44:19 +0200
Message-ID: <CA+fCnZfTfXt9_invV=wfyf_Z-Db_nutGjzf_MiFpnfdbm487Ww@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kasan, kmemleak: reset tags when scanning block
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Nicholas Tang <nicholas.tang@mediatek.com>,
        Andrew Yang <andrew.yang@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 11:10 AM Kuan-Ying Lee
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> Kmemleak need to scan kernel memory to check memory leak.
> With hardware tag-based kasan enabled, when it scans on
> the invalid slab and dereference, the issue will occur
> as below.
>
> Hardware tag-based KASAN doesn't use compiler instrumentation, we
> can not use kasan_disable_current() to ignore tag check.
>
> Based on the below report, there are 11 0xf7 granules, which amounts to
> 176 bytes, and the object is allocated from the kmalloc-256 cache. So
> when kmemleak accesses the last 256-176 bytes, it causes faults, as
> those are marked with KASAN_KMALLOC_REDZONE == KASAN_TAG_INVALID ==
> 0xfe.
>
> Thus, we reset tags before accessing metadata to avoid from false positives.
>
> [  151.905804] ==================================================================
> [  151.907120] BUG: KASAN: out-of-bounds in scan_block+0x58/0x170
> [  151.908773] Read at addr f7ff0000c0074eb0 by task kmemleak/138
> [  151.909656] Pointer tag: [f7], memory tag: [fe]
> [  151.910195]
> [  151.910876] CPU: 7 PID: 138 Comm: kmemleak Not tainted 5.14.0-rc2-00001-g8cae8cd89f05-dirty #134
> [  151.912085] Hardware name: linux,dummy-virt (DT)
> [  151.912868] Call trace:
> [  151.913211]  dump_backtrace+0x0/0x1b0
> [  151.913796]  show_stack+0x1c/0x30
> [  151.914248]  dump_stack_lvl+0x68/0x84
> [  151.914778]  print_address_description+0x7c/0x2b4
> [  151.915340]  kasan_report+0x138/0x38c
> [  151.915804]  __do_kernel_fault+0x190/0x1c4
> [  151.916386]  do_tag_check_fault+0x78/0x90
> [  151.916856]  do_mem_abort+0x44/0xb4
> [  151.917308]  el1_abort+0x40/0x60
> [  151.917754]  el1h_64_sync_handler+0xb4/0xd0
> [  151.918270]  el1h_64_sync+0x78/0x7c
> [  151.918714]  scan_block+0x58/0x170
> [  151.919157]  scan_gray_list+0xdc/0x1a0
> [  151.919626]  kmemleak_scan+0x2ac/0x560
> [  151.920129]  kmemleak_scan_thread+0xb0/0xe0
> [  151.920635]  kthread+0x154/0x160
> [  151.921115]  ret_from_fork+0x10/0x18
> [  151.921717]
> [  151.922077] Allocated by task 0:
> [  151.922523]  kasan_save_stack+0x2c/0x60
> [  151.923099]  __kasan_kmalloc+0xec/0x104
> [  151.923502]  __kmalloc+0x224/0x3c4
> [  151.924172]  __register_sysctl_paths+0x200/0x290
> [  151.924709]  register_sysctl_table+0x2c/0x40
> [  151.925175]  sysctl_init+0x20/0x34
> [  151.925665]  proc_sys_init+0x3c/0x48
> [  151.926136]  proc_root_init+0x80/0x9c
> [  151.926547]  start_kernel+0x648/0x6a4
> [  151.926987]  __primary_switched+0xc0/0xc8
> [  151.927557]
> [  151.927994] Freed by task 0:
> [  151.928340]  kasan_save_stack+0x2c/0x60
> [  151.928766]  kasan_set_track+0x2c/0x40
> [  151.929173]  kasan_set_free_info+0x44/0x54
> [  151.929568]  ____kasan_slab_free.constprop.0+0x150/0x1b0
> [  151.930063]  __kasan_slab_free+0x14/0x20
> [  151.930449]  slab_free_freelist_hook+0xa4/0x1fc
> [  151.930924]  kfree+0x1e8/0x30c
> [  151.931285]  put_fs_context+0x124/0x220
> [  151.931731]  vfs_kern_mount.part.0+0x60/0xd4
> [  151.932280]  kern_mount+0x24/0x4c
> [  151.932686]  bdev_cache_init+0x70/0x9c
> [  151.933122]  vfs_caches_init+0xdc/0xf4
> [  151.933578]  start_kernel+0x638/0x6a4
> [  151.934014]  __primary_switched+0xc0/0xc8
> [  151.934478]
> [  151.934757] The buggy address belongs to the object at ffff0000c0074e00
> [  151.934757]  which belongs to the cache kmalloc-256 of size 256
> [  151.935744] The buggy address is located 176 bytes inside of
> [  151.935744]  256-byte region [ffff0000c0074e00, ffff0000c0074f00)
> [  151.936702] The buggy address belongs to the page:
> [  151.937378] page:(____ptrval____) refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x100074
> [  151.938682] head:(____ptrval____) order:2 compound_mapcount:0 compound_pincount:0
> [  151.939440] flags: 0xbfffc0000010200(slab|head|node=0|zone=2|lastcpupid=0xffff|kasantag=0x0)
> [  151.940886] raw: 0bfffc0000010200 0000000000000000 dead000000000122 f5ff0000c0002300
> [  151.941634] raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
> [  151.942353] page dumped because: kasan: bad access detected
> [  151.942923]
> [  151.943214] Memory state around the buggy address:
> [  151.943896]  ffff0000c0074c00: f0 f0 f0 f0 f0 f0 f0 f0 f0 fe fe fe fe fe fe fe
> [  151.944857]  ffff0000c0074d00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> [  151.945892] >ffff0000c0074e00: f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 f7 fe fe fe fe fe
> [  151.946407]                                                     ^
> [  151.946939]  ffff0000c0074f00: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> [  151.947445]  ffff0000c0075000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [  151.947999] ==================================================================
> [  151.948524] Disabling lock debugging due to kernel taint
> [  156.434569] kmemleak: 181 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> ---
>  mm/kmemleak.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 228a2fbe0657..73d46d16d575 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -290,7 +290,7 @@ static void hex_dump_object(struct seq_file *seq,
>         warn_or_seq_printf(seq, "  hex dump (first %zu bytes):\n", len);
>         kasan_disable_current();
>         warn_or_seq_hex_dump(seq, DUMP_PREFIX_NONE, HEX_ROW_SIZE,
> -                            HEX_GROUP_SIZE, ptr, len, HEX_ASCII);
> +                            HEX_GROUP_SIZE, kasan_reset_tag((void *)ptr), len, HEX_ASCII);
>         kasan_enable_current();
>  }
>
> @@ -1171,7 +1171,7 @@ static bool update_checksum(struct kmemleak_object *object)
>
>         kasan_disable_current();
>         kcsan_disable_current();
> -       object->checksum = crc32(0, (void *)object->pointer, object->size);
> +       object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
>         kasan_enable_current();
>         kcsan_enable_current();
>
> @@ -1246,7 +1246,7 @@ static void scan_block(void *_start, void *_end,
>                         break;
>
>                 kasan_disable_current();
> -               pointer = *ptr;
> +               pointer = *(unsigned long *)kasan_reset_tag((void *)ptr);
>                 kasan_enable_current();
>
>                 untagged_ptr = (unsigned long)kasan_reset_tag((void *)pointer);
> --
> 2.18.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
