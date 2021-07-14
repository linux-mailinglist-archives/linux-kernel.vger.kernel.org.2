Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5588A3C7A90
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 02:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbhGNA12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 20:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbhGNA11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 20:27:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B394C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 17:24:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ga14so267382ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 17:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XLODtjqgFhjCJkT3B2KpWUS2vPeBIwFdLDhNSLLAewM=;
        b=cpOD4gHTaeb0bXRB7k2nlH9hiElsIxxhCqE8XHW3uzSBtaTqA7P6JBZ/Xw6Eepx/pR
         tfst6imzhpBY3o92nMlAUeFlxqTvxCF7oI8SiF1azsa2xc2l9WUotRu1NaROnoS6PY9D
         ufd7MeNZbzHGf0aOCEOOsag43k85LejMFcwcC9TzgnKcTmA8TDerw7v58CpBhp5Wyv4s
         xaSMPK1im5ypP5qKedVMap5VsmM4K/UkKuWNQIc64tTGKZ+0Eukv+nVoIGleI6cgoDxJ
         uMTWU/p6TuO66w3RSDhZN4EmDTBXj6uERBJn3lNKpxqG2SkRxmbwZxbXeK3AszI/dr2o
         7nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=XLODtjqgFhjCJkT3B2KpWUS2vPeBIwFdLDhNSLLAewM=;
        b=dvnoNr9aIjQ2ghrs9yjoz37xsVBytHYq/bDtD+lAhtZOEQWf63J9mf7JM94BPE/OBU
         kurNCiI9+cVlyAbUDVnmIXfeZxvEXtUcNAyqlaU9R8p2McArjqbg87EhsGiXzYagOCse
         ciLeBnqRWT6CUthMWFpR39RB2cebnDx2+SCyZ5xpRm5bRlA4n32p3Tn9vL/nNLeXJB3J
         8EZ0NP0U2hohZfoWPT5ISiS73oLvp+YsrSfHfmQTKye7aQFpZxwPabDWL+EsBpHBVuXN
         0gHDd6nk1Njknytl3vUGMF3ouQ4Zrvd2kvGTBfmu+kPJ9GbprOAo/9k2hsKRhNalEppD
         WudA==
X-Gm-Message-State: AOAM532sW4mv/vDaVK79UxUIDG9YojMWy/q+QnRU29e40+k5ol+9/heO
        YTEV8fzTikW7fcfehs7QWDA01PQ138TMnJUrBShlxky5iy+MNARI
X-Google-Smtp-Source: ABdhPJxkZq+UA+mLKfROIC91Ya/1umivDXc4p+3jO7kohn9HXfjif64BfWXXy6b2f2qtPkYbc+hA2fj4S9Jo3KwSmmg=
X-Received: by 2002:a17:906:998e:: with SMTP id af14mr8736115ejc.308.1626222275060;
 Tue, 13 Jul 2021 17:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAOH5QeChR8s6vENfRdGtUeeqKsSSbeFkY9TArmOyDcUvgAgU7Q@mail.gmail.com>
In-Reply-To: <CAOH5QeChR8s6vENfRdGtUeeqKsSSbeFkY9TArmOyDcUvgAgU7Q@mail.gmail.com>
From:   yong w <yongw.pur@gmail.com>
Date:   Wed, 14 Jul 2021 08:24:23 +0800
Message-ID: <CAOH5QeC0PhnZY6Cpe4zZ8o07XHA4-5B3xGEontkezrYu=Jt0VQ@mail.gmail.com>
Subject: Re: [BUG] ramfs system panic when using dd to create files
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, nico@fluxnic.net, wang.yong12@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, is there any solution, or how to avoid this problem when using ramfs=
?

yong w <yongw.pur@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=887=E6=97=A5=E5=
=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:58=E5=86=99=E9=81=93=EF=BC=9A
>
> When I  use dd to create files multiple times under the ramfs file
> system=EF=BC=8CPanic appears, indicating that there is no process to kill=
.
> I learn that ramfs will automatically grow space due to data writing,
> causing all the system memory to run out,  but i think it shouldn't
> cause the system to panic.
> Is there any solution, or how to avoid this problem when using ramfs?
>
> I use the qemu tool to reproduce this problem, The steps are as follows:
> 1. Use qemu to start the kernel using the ramfs file system
> qemu-system-x86_64  -smp 2 -m 1024M -kernel bzImage -initrd
> initramfs.cpio.gz -append "rdinit=3D/linuxrc console=3DttyS0  loglevel=3D=
8
> rootfstype=3Dramfs" -nographic
> 2.Check the file system type, as shown below
> / # stat -f .
>   File: "."
>     ID: 0        Namelen: 255     Type: romfs
> Block size: 4096
> Blocks: Total: 0          Free: 0          Available: 0
> Inodes: Total: 0          Free: 0
> 3.Use dd multiple times to create large files, and the results
> obtained are as follows:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> / #  dd if=3D/dev/zero of=3D/bigfile  bs=3D1M count=3D1024
> [ 1647.230012] dd invoked oom-killer: gfp_mask=3D0x100cc2(GFP_HIGHUSER),
> order=3D0, oom_score_adj=3D0
> [ 1647.232632] CPU: 0 PID: 99 Comm: dd Not tainted 5.13.0-rc4-next-202106=
04+ #3
> [ 1647.233060] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> [ 1647.233060] Call Trace:
> [ 1647.233060]  dump_stack_lvl+0x58/0x71
> [ 1647.233060]  dump_header+0x4f/0x300
> [ 1647.233060]  oom_kill_process+0x2de/0x3a0
> [ 1647.233060]  ? find_lock_task_mm+0x3b/0x70
> [ 1647.233060]  out_of_memory+0xe9/0x6d0
> [ 1647.233060]  __alloc_pages_slowpath.constprop.134+0xa84/0xcb0
> [ 1647.233060]  __alloc_pages+0x2b9/0x2f0
> [ 1647.233060]  pagecache_get_page+0x164/0x3a0
> [ 1647.233060]  grab_cache_page_write_begin+0x17/0x30
> [ 1647.233060]  simple_write_begin+0x1e/0x1e0
> [ 1647.233060]  generic_perform_write+0xba/0x1c0
> [ 1647.233060]  __generic_file_write_iter+0x16b/0x1c0
> [ 1647.233060]  ? sysvec_apic_timer_interrupt+0x5b/0x80
> [ 1647.233060]  generic_file_write_iter+0x43/0xb0
> [ 1647.233060]  new_sync_write+0x10a/0x1a0
> [ 1647.233060]  vfs_write+0x153/0x230
> [ 1647.233060]  ksys_write+0x57/0xd0
> [ 1647.233060]  do_syscall_64+0x3a/0x90
> [ 1647.233060]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 1647.233060] RIP: 0033:0x556cc0
> [ 1647.233060] Code: 01 f0 ff ff 0f 83 60 df 01 00 c3 66 2e 0f 1f 84
> 00 00 00 00 00 0f 1f 44 00 00 83 3d c9 e5 32 00 00 75 14 b8 01 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 34 df 01 00 c3 48 83 ec 08 e8 0a 82
> 00 00
> [ 1647.233060] RSP: 002b:00007ffd22b93bf8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [ 1647.233060] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 000000000=
0556cc0
> [ 1647.233060] RDX: 0000000000100000 RSI: 00007f87a86a3010 RDI: 000000000=
0000001
> [ 1647.233060] RBP: 00007f87a86a3010 R08: 0000000000000000 R09: 000000000=
0000000
> [ 1647.233060] R10: 0000000000000008 R11: 0000000000000246 R12: 000000000=
0100000
> [ 1647.233060] R13: 0000000000000001 R14: 00007f87a86a3010 R15: 00007f87a=
86a3010
> [ 1647.244474] Mem-Info:
> [ 1647.244663] active_anon:3 inactive_anon:298 isolated_anon:0
> [ 1647.244663]  active_file:0 inactive_file:0 isolated_file:0
> [ 1647.244663]  unevictable:239648 dirty:0 writeback:0
> [ 1647.244663]  slab_reclaimable:2755 slab_unreclaimable:1689
> [ 1647.244663]  mapped:433 shmem:0 pagetables:27 bounce:0
> [ 1647.244663]  free:2908 free_pcp:241 free_cma:0
> [ 1647.247244] Node 0 active_anon:12kB inactive_anon:1192kB
> active_file:0kB inactive_file:0kB unevictable:958592kB
> isolated(anon):0kB isolated(file):0kB mapped:1732kB dirty:0kB
> writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:768kB
> pagetables:108kB all_unreclaimable? no
> [ 1647.248762] Node 0 DMA free:3860kB min:60kB low:72kB high:84kB
> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> active_file:0kB inactive_file:0kB unevictable:11992kB writepending:0kB
> present:15992kB managed:15908kB mlocked:0kB bounce:0kB free_pcp:12kB
> local_pcp:4kB free_cma:0kB
> [ 1647.250808] lowmem_reserve[]: 0 950 950 950
> [ 1647.251262] Node 0 DMA32 free:7772kB min:8008kB low:8984kB
> high:9960kB reserved_highatomic:0KB active_anon:12kB
> inactive_anon:1192kB active_file:0kB inactive_file:0kB
> unevictable:946620kB writepending:0kB present:1032064kB
> managed:978680kB mlocked:0kB bounce:0kB free_pcp:952kB local_pcp:600kB
> free_cma:0kB
> [ 1647.253540] lowmem_reserve[]: 0 0 0 0
> [ 1647.254260] Node 0 DMA: 1*4kB (U) 0*8kB 1*16kB (U) 2*32kB (UE)
> 1*64kB (E) 1*128kB (E) 2*256kB (UE) 2*512kB (UE) 2*1024kB (UE)
> 0*2048kB 0*4096kB =3D 3860kB
> [ 1647.255533] Node 0 DMA32: 65*4kB (UME) 61*8kB (UME) 40*16kB (UME)
> 33*32kB (UME) 18*64kB (UME) 10*128kB (ME) 7*256kB (UM) 1*512kB (E)
> 1*1024kB (U) 0*2048kB 0*4096kB =3D 8204kB
> [ 1647.267374] Node 0 hugepages_total=3D0 hugepages_free=3D0
> hugepages_surp=3D0 hugepages_size=3D2048kB
> [ 1647.271471] 239652 total pagecache pages
> [ 1647.273281] 0 pages in swap cache
> [ 1647.273709] Swap cache stats: add 0, delete 0, find 0/0
> [ 1647.273991] Free swap  =3D 0kB
> [ 1647.276895] Total swap =3D 0kB
> [ 1647.277779] 262014 pages RAM
> [ 1647.277982] 0 pages HighMem/MovableOnly
> [ 1647.278187] 13367 pages reserved
> [ 1647.281882] Tasks state (memory values in pages):
> [ 1647.281882] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
> swapents oom_score_adj name
> [ 1647.285417] [     83]     0    83      720      455    36864
> 0             0 sh
> [ 1647.285703] [     99]     0    99      977      594    45056
> 0             0 dd
> [ 1647.287121] oom-kill:constraint=3DCONSTRAINT_NONE,nodemask=3D(null),cp=
uset=3D/,mems_allowed=3D0,task=3Ddd,pid=3D99,uid=3D0
> [ 1647.289756] Out of memory: Killed process 99 (dd) total-vm:3908kB,
> anon-rss:964kB, file-rss:1412kB, shmem-rss:0kB, UID:0 pgtables:44kB
> oom_score_adj:0
> [ 1647.303507] dd (99) used greatest stack depth: 12872 bytes left
> Killed
> / #  dd if=3D/dev/zero of=3D/bigfile  bs=3D1M count=3D1024
> [ 1655.481958] dd invoked oom-killer: gfp_mask=3D0x100cc2(GFP_HIGHUSER),
> order=3D0, oom_score_adj=3D0
> [ 1655.486633] CPU: 1 PID: 100 Comm: dd Not tainted 5.13.0-rc4-next-20210=
604+ #3
> [ 1655.487568] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> [ 1655.487568] Call Trace:
> [ 1655.487568]  dump_stack_lvl+0x58/0x71
> [ 1655.487568]  dump_header+0x4f/0x300
> [ 1655.487568]  ? do_try_to_free_pages+0x214/0x310
> [ 1655.487568]  ? get_page_from_freelist+0x1d1/0xc40
> [ 1655.487568]  oom_kill_process+0x2de/0x3a0
> [ 1655.487568]  ? find_lock_task_mm+0x3b/0x70
> [ 1655.487568]  out_of_memory+0xe9/0x6d0
> [ 1655.487568]  __alloc_pages_slowpath.constprop.134+0xa84/0xcb0
> [ 1655.487568]  __alloc_pages+0x2b9/0x2f0
> [ 1655.487568]  pagecache_get_page+0x164/0x3a0
> [ 1655.487568]  grab_cache_page_write_begin+0x17/0x30
> [ 1655.487568]  simple_write_begin+0x1e/0x1e0
> [ 1655.487568]  generic_perform_write+0xba/0x1c0
> [ 1655.487568]  __generic_file_write_iter+0x16b/0x1c0
> [ 1655.487568]  ? sysvec_apic_timer_interrupt+0x5b/0x80
> [ 1655.487568]  generic_file_write_iter+0x43/0xb0
> [ 1655.487568]  new_sync_write+0x10a/0x1a0
> [ 1655.487568]  vfs_write+0x153/0x230
> [ 1655.487568]  ksys_write+0x57/0xd0
> [ 1655.487568]  do_syscall_64+0x3a/0x90
> [ 1655.487568]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 1655.487568] RIP: 0033:0x556cc0
> [ 1655.487568] Code: 01 f0 ff ff 0f 83 60 df 01 00 c3 66 2e 0f 1f 84
> 00 00 00 00 00 0f 1f 44 00 00 83 3d c9 e5 32 00 00 75 14 b8 01 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 34 df 01 00 c3 48 83 ec 08 e8 0a 82
> 00 00
> [ 1655.487568] RSP: 002b:00007fffafec7878 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [ 1655.487568] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 000000000=
0556cc0
> [ 1655.487568] RDX: 0000000000100000 RSI: 00007f66bc740010 RDI: 000000000=
0000001
> [ 1655.487568] RBP: 00007f66bc740010 R08: 0000000000000000 R09: 000000000=
0000000
> [ 1655.487568] R10: 0000000000000008 R11: 0000000000000246 R12: 000000000=
0100000
> [ 1655.487568] R13: 0000000000000001 R14: 00007f66bc740010 R15: 00007f66b=
c740010
> [ 1655.519386] Mem-Info:
> [ 1655.519585] active_anon:3 inactive_anon:297 isolated_anon:0
> [ 1655.519585]  active_file:0 inactive_file:0 isolated_file:0
> [ 1655.519585]  unevictable:240802 dirty:0 writeback:0
> [ 1655.519585]  slab_reclaimable:2580 slab_unreclaimable:1655
> [ 1655.519585]  mapped:433 shmem:0 pagetables:28 bounce:0
> [ 1655.519585]  free:2033 free_pcp:414 free_cma:0
> [ 1655.522018] Node 0 active_anon:12kB inactive_anon:1188kB
> active_file:0kB inactive_file:0kB unevictable:963208kB
> isolated(anon):0kB isolated(file):0kB mapped:1732kB dirty:0kB
> writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:768kB
> pagetables:112kB all_unreclaimable? yes
> [ 1655.522748] Node 0 DMA free:3860kB min:60kB low:72kB high:84kB
> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> active_file:0kB inactive_file:0kB unevictable:11968kB writepending:0kB
> present:15992kB managed:15908kB mlocked:0kB bounce:0kB free_pcp:16kB
> local_pcp:12kB free_cma:0kB
> [ 1655.523733] lowmem_reserve[]: 0 950 950 950
> [ 1655.524090] Node 0 DMA32 free:4272kB min:5960kB low:6936kB
> high:7912kB reserved_highatomic:0KB active_anon:12kB
> inactive_anon:1188kB active_file:0kB inactive_file:0kB
> unevictable:951008kB writepending:0kB present:1032064kB
> managed:978680kB mlocked:0kB bounce:0kB free_pcp:1640kB
> local_pcp:952kB free_cma:0kB
> [ 1655.525042] lowmem_reserve[]: 0 0 0 0
> [ 1655.525200] Node 0 DMA: 1*4kB (U) 0*8kB 1*16kB (U) 0*32kB 2*64kB
> (UE) 1*128kB (E) 2*256kB (UE) 2*512kB (UE) 2*1024kB (UE) 0*2048kB
> 0*4096kB =3D 3860kB
> [ 1655.525702] Node 0 DMA32: 17*4kB (E) 2*8kB (UM) 2*16kB (UM) 2*32kB
> (UM) 8*64kB (UME) 6*128kB (ME) 10*256kB (UME) 0*512kB 0*1024kB
> 0*2048kB 0*4096kB =3D 4020kB
> [ 1655.526607] Node 0 hugepages_total=3D0 hugepages_free=3D0
> hugepages_surp=3D0 hugepages_size=3D2048kB
> [ 1655.527078] 240804 total pagecache pages
> [ 1655.527219] 0 pages in swap cache
> [ 1655.527326] Swap cache stats: add 0, delete 0, find 0/0
> [ 1655.527472] Free swap  =3D 0kB
> [ 1655.527563] Total swap =3D 0kB
> [ 1655.527657] 262014 pages RAM
> [ 1655.527741] 0 pages HighMem/MovableOnly
> [ 1655.528052] 13367 pages reserved
> [ 1655.528168] Tasks state (memory values in pages):
> [ 1655.528313] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
> swapents oom_score_adj name
> [ 1655.528564] [     83]     0    83      720      455    36864
> 0             0 sh
> [ 1655.529287] [    100]     0   100      977      594    53248
> 0             0 dd
> [ 1655.529565] oom-kill:constraint=3DCONSTRAINT_NONE,nodemask=3D(null),cp=
uset=3D/,mems_allowed=3D0,task=3Ddd,pid=3D100,uid=3D0
> [ 1655.530157] Out of memory: Killed process 100 (dd) total-vm:3908kB,
> anon-rss:964kB, file-rss:1412kB, shmem-rss:0kB, UID:0 pgtables:52kB
> oom_score_adj:0
> [ 1655.532126] oom_reaper: reaped process 100 (dd), now anon-rss:0kB,
> file-rss:0kB, shmem-rss:0kB
> Killed
> / #  dd if=3D/dev/zero of=3D/bigfile  bs=3D1M count=3D1024
> [ 1656.785189] sh invoked oom-killer:
> gfp_mask=3D0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO),
> order=3D0, oom_score_adj=3D0
> [ 1656.786309] CPU: 0 PID: 83 Comm: sh Not tainted 5.13.0-rc4-next-202106=
04+ #3
> [ 1656.786655] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> [ 1656.787037] Call Trace:
> [ 1656.787177]  dump_stack_lvl+0x58/0x71
> [ 1656.787226]  dump_header+0x4f/0x300
> [ 1656.787226]  ? do_try_to_free_pages+0x214/0x310
> [ 1656.787226]  ? get_page_from_freelist+0x1d1/0xc40
> [ 1656.787226]  oom_kill_process+0x2de/0x3a0
> [ 1656.787226]  ? find_lock_task_mm+0x3b/0x70
> [ 1656.787226]  out_of_memory+0xe9/0x6d0
> [ 1656.787226]  __alloc_pages_slowpath.constprop.134+0xa84/0xcb0
> [ 1656.787226]  __alloc_pages+0x2b9/0x2f0
> [ 1656.787226]  __alloc_pages_bulk+0x462/0x680
> [ 1656.787226]  ? __cond_resched+0x11/0x40
> [ 1656.787226]  ? __kmalloc_node+0x10d/0x270
> [ 1656.787226]  ? __vmalloc_node_range+0x211/0x300
> [ 1656.787226]  __vmalloc_node_range+0x122/0x300
> [ 1656.787226]  ? __cond_resched+0x11/0x40
> [ 1656.787226]  copy_process+0x780/0x1950
> [ 1656.787226]  ? kernel_clone+0x96/0x3e0
> [ 1656.787226]  ? __cond_resched+0x11/0x40
> [ 1656.787226]  ? down_read+0x9/0xa0
> [ 1656.787226]  ? _copy_to_user+0x1c/0x30
> [ 1656.787226]  kernel_clone+0x96/0x3e0
> [ 1656.787226]  ? tty_ioctl+0x148/0x890
> [ 1656.787226]  __do_sys_clone+0x5e/0x80
> [ 1656.787226]  do_syscall_64+0x3a/0x90
> [ 1656.787226]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 1656.787226] RIP: 0033:0x534a4a
> [ 1656.787226] Code: f7 d8 64 89 04 25 d4 02 00 00 64 4c 8b 0c 25 10
> 00 00 00 31 d2 4d 8d 91 d0 02 00 00 31 f6 bf 11 00 20 01 b8 38 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 f5 00 00 00 85 c0 41 89 c5 0f 85 fc
> 00 00
> [ 1656.787226] RSP: 002b:00007ffe6e976910 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000038
> [ 1656.787226] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000=
0534a4a
> [ 1656.787226] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
1200011
> [ 1656.787226] RBP: 00007ffe6e976930 R08: 0000000000000000 R09: 000000000=
128f880
> [ 1656.787226] R10: 000000000128fb50 R11: 0000000000000246 R12: 000000000=
0000053
> [ 1656.787226] R13: 0000000001290c98 R14: 0000000000000000 R15: 000000000=
0000000
> [ 1656.794113] Mem-Info:
> [ 1656.794222] active_anon:2 inactive_anon:29 isolated_anon:0
> [ 1656.794222]  active_file:0 inactive_file:0 isolated_file:0
> [ 1656.794222]  unevictable:240817 dirty:0 writeback:0
> [ 1656.794222]  slab_reclaimable:2588 slab_unreclaimable:1655
> [ 1656.794222]  mapped:433 shmem:0 pagetables:18 bounce:0
> [ 1656.794222]  free:1970 free_pcp:699 free_cma:0
> [ 1656.795238] Node 0 active_anon:8kB inactive_anon:116kB
> active_file:0kB inactive_file:0kB unevictable:963268kB
> isolated(anon):0kB isolated(file):0kB mapped:1732kB dirty:0kB
> writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:752kB
> pagetables:72kB all_unreclaimable? yes
> [ 1656.796010] Node 0 DMA free:3860kB min:60kB low:72kB high:84kB
> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> active_file:0kB inactive_file:0kB unevictable:11968kB writepending:0kB
> present:15992kB managed:15908kB mlocked:0kB bounce:0kB free_pcp:16kB
> local_pcp:4kB free_cma:0kB
> [ 1656.797721] lowmem_reserve[]: 0 950 950 950
> [ 1656.797967] Node 0 DMA32 free:4020kB min:5960kB low:6936kB
> high:7912kB reserved_highatomic:0KB active_anon:8kB
> inactive_anon:116kB active_file:0kB inactive_file:0kB
> unevictable:951300kB writepending:0kB present:1032064kB
> managed:978680kB mlocked:0kB bounce:0kB free_pcp:2780kB
> local_pcp:688kB free_cma:0kB
> [ 1656.798578] lowmem_reserve[]: 0 0 0 0
> [ 1656.798775] Node 0 DMA: 1*4kB (U) 0*8kB 1*16kB (U) 0*32kB 2*64kB
> (UE) 1*128kB (E) 2*256kB (UE) 2*512kB (UE) 2*1024kB (UE) 0*2048kB
> 0*4096kB =3D 3860kB
> [ 1656.801548] Node 0 DMA32: 17*4kB (E) 2*8kB (UM) 2*16kB (UM) 2*32kB
> (UM) 8*64kB (UME) 6*128kB (ME) 10*256kB (UME) 0*512kB 0*1024kB
> 0*2048kB 0*4096kB =3D 4020kB
> [ 1656.802683] Node 0 hugepages_total=3D0 hugepages_free=3D0
> hugepages_surp=3D0 hugepages_size=3D2048kB
> [ 1656.803319] 240817 total pagecache pages
> [ 1656.803534] 0 pages in swap cache
> [ 1656.803717] Swap cache stats: add 0, delete 0, find 0/0
> [ 1656.804122] Free swap  =3D 0kB
> [ 1656.804286] Total swap =3D 0kB
> [ 1656.804426] 262014 pages RAM
> [ 1656.804565] 0 pages HighMem/MovableOnly
> [ 1656.804748] 13367 pages reserved
> [ 1656.805060] Tasks state (memory values in pages):
> [ 1656.805374] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
> swapents oom_score_adj name
> [ 1656.806160] [     83]     0    83      720      455    36864
> 0             0 sh
> [ 1656.806677] oom-kill:constraint=3DCONSTRAINT_NONE,nodemask=3D(null),cp=
uset=3D/,mems_allowed=3D0,task=3Dsh,pid=3D83,uid=3D0
> [ 1656.807762] Out of memory: Killed process 83 (sh) total-vm:2880kB,
> anon-rss:88kB, file-rss:1732kB, shmem-rss:0kB, UID:0 pgtables:36kB
> oom_score_adj:0
> [ 1656.824587] linuxrc invoked oom-killer:
> gfp_mask=3D0x400dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), order=3D1,
> oom_score_adj=3D0
> [ 1656.825261] CPU: 1 PID: 1 Comm: linuxrc Not tainted
> 5.13.0-rc4-next-20210604+ #3
> [ 1656.825508] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> [ 1656.825784] Call Trace:
> [ 1656.826015]  dump_stack_lvl+0x58/0x71
> [ 1656.826086]  dump_header+0x4f/0x300
> [ 1656.826086]  out_of_memory+0x67c/0x6d0
> [ 1656.826086]  __alloc_pages_slowpath.constprop.134+0xa84/0xcb0
> [ 1656.826086]  __alloc_pages+0x2b9/0x2f0
> [ 1656.826086]  __get_free_pages+0x8/0x30
> [ 1656.826086]  pgd_alloc+0x2a/0x1c0
> [ 1656.826086]  ? kmem_cache_alloc+0x31/0x1c0
> [ 1656.826086]  mm_init.isra.61+0x172/0x240
> [ 1656.826086]  dup_mm.isra.63+0x54/0x540
> [ 1656.826086]  copy_process+0x18b6/0x1950
> [ 1656.826086]  kernel_clone+0x96/0x3e0
> [ 1656.826086]  __do_sys_clone+0x5e/0x80
> [ 1656.826086]  do_syscall_64+0x3a/0x90
> [ 1656.826086]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 1656.826086] RIP: 0033:0x534a4a
> [ 1656.826086] Code: f7 d8 64 89 04 25 d4 02 00 00 64 4c 8b 0c 25 10
> 00 00 00 31 d2 4d 8d 91 d0 02 00 00 31 f6 bf 11 00 20 01 b8 38 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 f5 00 00 00 85 c0 41 89 c5 0f 85 fc
> 00 00
> [ 1656.826086] RSP: 002b:00007ffea9111680 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000038
> [ 1656.826086] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000=
0534a4a
> [ 1656.826086] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
1200011
> [ 1656.826086] RBP: 00007ffea91116a0 R08: 0000000000000000 R09: 000000000=
0e71880
> [ 1656.826086] R10: 0000000000e71b50 R11: 0000000000000246 R12: 000000000=
0000001
> [ 1656.826086] R13: 00007ffea91119c8 R14: 0000000000000000 R15: 000000000=
0000095
> [ 1656.831099] Mem-Info:
> [ 1656.831211] active_anon:2 inactive_anon:29 isolated_anon:0
> [ 1656.831211]  active_file:0 inactive_file:0 isolated_file:0
> [ 1656.831211]  unevictable:240817 dirty:0 writeback:0
> [ 1656.831211]  slab_reclaimable:2588 slab_unreclaimable:1655
> [ 1656.831211]  mapped:382 shmem:0 pagetables:18 bounce:0
> [ 1656.831211]  free:1970 free_pcp:728 free_cma:0
> [ 1656.832252] Node 0 active_anon:8kB inactive_anon:116kB
> active_file:0kB inactive_file:0kB unevictable:963268kB
> isolated(anon):0kB isolated(file):0kB mapped:1528kB dirty:0kB
> writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:752kB
> pagetables:72kB all_unreclaimable? yes
> [ 1656.833095] Node 0 DMA free:3860kB min:60kB low:72kB high:84kB
> reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB
> active_file:0kB inactive_file:0kB unevictable:11968kB writepending:0kB
> present:15992kB managed:15908kB mlocked:0kB bounce:0kB free_pcp:16kB
> local_pcp:12kB free_cma:0kB
> [ 1656.834023] lowmem_reserve[]: 0 950 950 950
> [ 1656.834191] Node 0 DMA32 free:4020kB min:5960kB low:6936kB
> high:7912kB reserved_highatomic:0KB active_anon:8kB
> inactive_anon:116kB active_file:0kB inactive_file:0kB
> unevictable:951300kB writepending:0kB present:1032064kB
> managed:978680kB mlocked:0kB bounce:0kB free_pcp:2896kB
> local_pcp:2100kB free_cma:0kB
> [ 1656.835186] lowmem_reserve[]: 0 0 0 0
> [ 1656.835344] Node 0 DMA: 1*4kB (U) 0*8kB 1*16kB (U) 0*32kB 2*64kB
> (UE) 1*128kB (E) 2*256kB (UE) 2*512kB (UE) 2*1024kB (UE) 0*2048kB
> 0*4096kB =3D 3860kB
> [ 1656.835831] Node 0 DMA32: 17*4kB (E) 2*8kB (UM) 2*16kB (UM) 2*32kB
> (UM) 8*64kB (UME) 6*128kB (ME) 10*256kB (UME) 0*512kB 0*1024kB
> 0*2048kB 0*4096kB =3D 4020kB
> [ 1656.836493] Node 0 hugepages_total=3D0 hugepages_free=3D0
> hugepages_surp=3D0 hugepages_size=3D2048kB
> [ 1656.836734] 240817 total pagecache pages
> [ 1656.837020] 0 pages in swap cache
> [ 1656.837119] Swap cache stats: add 0, delete 0, find 0/0
> [ 1656.837268] Free swap  =3D 0kB
> [ 1656.837359] Total swap =3D 0kB
> [ 1656.837452] 262014 pages RAM
> [ 1656.837533] 0 pages HighMem/MovableOnly
> [ 1656.837648] 13367 pages reserved
> [ 1656.837747] Tasks state (memory values in pages):
> [ 1656.838049] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
> swapents oom_score_adj name
> [ 1656.838340] Out of memory and no killable processes...
> [ 1656.838682] Kernel panic - not syncing: System is deadlocked on memory
> [ 1656.838990] CPU: 1 PID: 1 Comm: linuxrc Not tainted
> 5.13.0-rc4-next-20210604+ #3
> [ 1656.838990] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> [ 1656.838990] Call Trace:
> [ 1656.838990]  dump_stack_lvl+0x58/0x71
> [ 1656.838990]  panic+0xf3/0x2b4
> [ 1656.838990]  out_of_memory+0x6c1/0x6d0
> [ 1656.838990]  __alloc_pages_slowpath.constprop.134+0xa84/0xcb0
> [ 1656.838990]  __alloc_pages+0x2b9/0x2f0
> [ 1656.838990]  __get_free_pages+0x8/0x30
> [ 1656.838990]  pgd_alloc+0x2a/0x1c0
> [ 1656.838990]  ? kmem_cache_alloc+0x31/0x1c0
> [ 1656.838990]  mm_init.isra.61+0x172/0x240
> [ 1656.838990]  dup_mm.isra.63+0x54/0x540
> [ 1656.838990]  copy_process+0x18b6/0x1950
> [ 1656.838990]  kernel_clone+0x96/0x3e0
> [ 1656.838990]  __do_sys_clone+0x5e/0x80
> [ 1656.838990]  do_syscall_64+0x3a/0x90
> [ 1656.838990]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 1656.838990] RIP: 0033:0x534a4a
> [ 1656.838990] Code: f7 d8 64 89 04 25 d4 02 00 00 64 4c 8b 0c 25 10
> 00 00 00 31 d2 4d 8d 91 d0 02 00 00 31 f6 bf 11 00 20 01 b8 38 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 f5 00 00 00 85 c0 41 89 c5 0f 85 fc
> 00 00
> [ 1656.838990] RSP: 002b:00007ffea9111680 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000038
> [ 1656.838990] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000=
0534a4a
> [ 1656.838990] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
1200011
> [ 1656.838990] RBP: 00007ffea91116a0 R08: 0000000000000000 R09: 000000000=
0e71880
> [ 1656.838990] R10: 0000000000e71b50 R11: 0000000000000246 R12: 000000000=
0000001
> [ 1656.838990] R13: 00007ffea91119c8 R14: 0000000000000000 R15: 000000000=
0000095
> [ 1656.838990] Kernel Offset: 0x31600000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [ 1656.838990] ---[ end Kernel panic - not syncing: System is
> deadlocked on memory ]---
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
