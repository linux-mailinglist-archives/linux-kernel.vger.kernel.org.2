Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A861B40D065
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 01:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhIOXqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 19:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbhIOXqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:46:13 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FD9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 16:44:53 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id o124so4470691vsc.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 16:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r60VhIH5s+ezBF+JcTireA9OzqLc/wsDt/FsdgPojjM=;
        b=o9stltGolqBgU20T7fgKwvlGCY184hVJ71n82JKUayRJAPpD5c848Jo2PrY+1lfyK7
         ft7/aeNjg1xme6V7tSNFIGV69PR0GFjbJ817+vZ+6LeZ/3S/0QFqhnAtlulYr1N9NvCs
         4RQEvAS/wqqAQy7xSWnemGxpNlK/qXvt8NQ2PSkhewnvz5kAJCmZlN8guJacBIRjBfOf
         NQvdlgG665YGdlq9qs0xWrnyCQ96jNv7rjoGgI5ctMJp3HNNDz4ggaydWnU1dJFCX5ll
         lGOgaKp5MzrpQtYiKdyR2lUowZs+87QcngrBqbPoIdS33sqqI0schW/UrZSjrVNx61k+
         u+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r60VhIH5s+ezBF+JcTireA9OzqLc/wsDt/FsdgPojjM=;
        b=e1XBRCMBS/Yqwy/Y8vEk3lrNr/dbpTBPqIRPrNXivb9ztRjiPGMqnagnSq49ZMs/Ue
         GMCmKwuIM8TFp/7Wba3s3wYhP8z3jiDuBzLwMr3nkylLESmGDz8zFhdMUI20Vb5NSnw2
         AhukFDOxrR8j/jDirRQ3gzYTCxwfGU8RTgUrmzpExYKtKHD6aDrd2tBO8iK6+stV0MDN
         LV5cn/EFrvIjQgpWOqoLwyL9RaZTK+DEFH9pevabnqq2NVR8ASy30P1kRvl/kk/qDgSi
         RwlbLIH+wT6igrd2hJibhDNv4SzNChzIF+OSnVVo1pYBhy8vDwAZPXfOpFzjgk6exFG3
         YdFw==
X-Gm-Message-State: AOAM530uJODF5nAD/YOhl3PfLTPrWwmiCsGcIoNld8Nv9HaMfg9XBY5S
        7ytAommyyUV8tN9oCYYWVYRiXb+4IwjFgi5BOgecYw==
X-Google-Smtp-Source: ABdhPJwYvY3Yp+kTBojKHRnv/d0jn5wrvOgPfApwX6+pK3qOHzD0YqY+dJHCdK34fvvhWIs6zpjkPX6xuXJHKSckgkU=
X-Received: by 2002:a67:1903:: with SMTP id 3mr2436880vsz.45.1631749492614;
 Wed, 15 Sep 2021 16:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
 <87ee9pa6xw.fsf@disp2133> <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
In-Reply-To: <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 15 Sep 2021 17:44:40 -0600
Message-ID: <CAOUHufahZsYOddtioPEqf=wFtD_HQ4pTo3XJLaSkcm4T3T5MZA@mail.gmail.com>
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
To:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        ebiederm@xmission.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-mm\\@kvack.org" <linux-mm@kvack.org>,
        "legion\\@kernel.org" <legion@kernel.org>,
        "containers\\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 4:42 PM Jordan Glover
<Golden_Miller83@protonmail.ch> wrote:
>
> On Wednesday, September 15th, 2021 at 9:02 PM, <ebiederm@xmission.com> wr=
ote:
>
> > Jordan Glover Golden_Miller83@protonmail.ch writes:
> >
> > > Hi, recently I hit system freeze after I was closing few containerize=
d apps on my system. As for now it occurred only once on linux 5.14.3. I th=
ink it maybe be related to "Count rlimits in each user namespace" patchset =
merged during 5.14 window
> > >
> > > https://lore.kernel.org/all/257aa5fb1a7d81cf0f4c34f39ada2320c4284771.=
1619094428.git.legion@kernel.org/T/#u
> >
> > So that warning comes from:
> >
> > void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
> >
> > {
> >
> > struct ucounts *iter;
> >
> > for (iter =3D ucounts; iter; iter =3D iter->ns->ucounts) {
> >
> >       long dec =3D atomic_long_dec_if_positive(&iter->ucount[type]);
> >
> >       WARN_ON_ONCE(dec < 0);
> >     }
> >     put_ucounts(ucounts);
> >
> >
> > }
> >
> > Which certainly looks like a reference count bug. It could also be a
> >
> > memory stomp somewhere close.
> >
> > Do you have any idea what else was going on? This location is the
> >
> > symptom but not the actual cause.
> >
> > Eric
>
> I had about 2 containerized (flatpak/bubblewrap) apps (browser + music pl=
ayer) running . I quickly closed them with intent to shutdown the system bu=
t instead get the freeze and had to use magic sysrq to reboot. System logs =
end with what I posted and before there is nothing suspicious.
>
> Maybe it's some random fluke. I'll reply if I hit it again.

I have been able to steadily reproduce this for a while. But I haven't
had time to look into it. I'd appreciate any help.

[ 1324.741762] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1324.749200] BUG: KASAN: use-after-free in dec_ucount+0x50/0xd8
[ 1324.755198] Write of size 8 at addr ffffff808f2f0120 by task kworker/7:2=
/1817
[ 1324.762523]
[ 1324.764063] CPU: 7 PID: 1817 Comm: kworker/7:2 Not tainted 5.14.0-lockde=
p+ #7
[ 1324.771396] Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
[ 1324.778098] Workqueue: events free_user_ns
[ 1324.782320] Call trace:
[ 1324.784845]  dump_backtrace+0x0/0x42c
[ 1324.788614]  show_stack+0x24/0x30
[ 1324.792026]  dump_stack_lvl+0xd0/0x100
[ 1324.795884]  print_address_description+0x30/0x304
[ 1324.800725]  kasan_report+0x190/0x1d8
[ 1324.804494]  kasan_check_range+0x1ac/0x1bc
[ 1324.808708]  __kasan_check_write+0x44/0x54
[ 1324.812923]  dec_ucount+0x50/0xd8
[ 1324.816334]  free_user_ns+0x1b0/0x288
[ 1324.820102]  process_one_work+0x7b4/0x10ec
[ 1324.824318]  worker_thread+0x800/0xcf4
[ 1324.828176]  kthread+0x2a8/0x358
[ 1324.831500]  ret_from_fork+0x10/0x18
[ 1324.835182]
[ 1324.836720] Allocated by task 5167:
[ 1324.840312]  kasan_save_stack+0x38/0x68
[ 1324.844261]  __kasan_slab_alloc+0x6c/0x88
[ 1324.848387]  kmem_cache_alloc+0x234/0x47c
[ 1324.852505]  getname_flags+0xb4/0x3b8
[ 1324.856273]  __arm64_sys_unlink+0x4c/0x68
[ 1324.860400]  invoke_syscall+0xd4/0x2c8
[ 1324.864258]  el0_svc_common+0x124/0x200
[ 1324.868199]  do_el0_svc_compat+0x54/0x64
[ 1324.872235]  el0_svc_compat+0x24/0x34
[ 1324.876003]  el0t_32_sync_handler+0xc0/0xf0
[ 1324.880307]  el0t_32_sync+0x19c/0x1a0
[ 1324.884078]
[ 1324.885616] Freed by task 5167:
[ 1324.888848]  kasan_save_stack+0x38/0x68
[ 1324.892797]  kasan_set_track+0x28/0x3c
[ 1324.896653]  kasan_set_free_info+0x28/0x4c
[ 1324.900865]  ____kasan_slab_free+0x118/0x164
[ 1324.905259]  __kasan_slab_free+0x18/0x28
[ 1324.909296]  kmem_cache_free+0x1c0/0x4b8
[ 1324.913325]  putname+0xd0/0x140
[ 1324.916554]  do_unlinkat+0x518/0x57c
[ 1324.920233]  __arm64_sys_unlink+0x58/0x68
[ 1324.924359]  invoke_syscall+0xd4/0x2c8
[ 1324.928215]  el0_svc_common+0x124/0x200
[ 1324.932164]  do_el0_svc_compat+0x54/0x64
[ 1324.936195]  el0_svc_compat+0x24/0x34
[ 1324.939963]  el0t_32_sync_handler+0xc0/0xf0
[ 1324.944259]  el0t_32_sync+0x19c/0x1a0
[ 1324.948029]
[ 1324.949567] The buggy address belongs to the object at ffffff808f2f0040
[ 1324.949567]  which belongs to the cache names_cache of size 4096
[ 1324.962498] The buggy address is located 224 bytes inside of
[ 1324.962498]  4096-byte region [ffffff808f2f0040, ffffff808f2f1040)
[ 1324.974635] The buggy address belongs to the page:
[ 1324.979561] page:fffffffe023cbc00 refcount:1 mapcount:0
mapping:0000000000000000 index:0xffffff808f2f23c0 pfn:0x10f2f0
[ 1324.990536] head:fffffffe023cbc00 order:3 compound_mapcount:0
compound_pincount:0
[ 1324.998220] flags: 0x8000000000010200(slab|head|zone=3D2)
[ 1325.003596] raw: 8000000000010200 fffffffe02b59a08 fffffffe0247a208
ffffff808036ad80
[ 1325.011549] raw: ffffff808f2f23c0 0000000000070006 00000001ffffffff
0000000000000000
[ 1325.019494] page dumped because: kasan: bad access detected
[ 1325.025214]
[ 1325.026751] Memory state around the buggy address:
[ 1325.031680]  ffffff808f2f0000: fc fc fc fc fc fc fc fc fa fb fb fb
fb fb fb fb
[ 1325.039093]  ffffff808f2f0080: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 1325.046506] >ffffff808f2f0100: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 1325.053920]                                ^
[ 1325.058311]  ffffff808f2f0180: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 1325.065725]  ffffff808f2f0200: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 1325.073153] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[ 7358.532846] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 7358.540369] BUG: KASAN: use-after-free in dec_ucount+0x50/0xd8
[ 7358.546429] Write of size 8 at addr ffffff800af71120 by task
kworker/3:1/27623
[ 7358.553880]
[ 7358.555458] CPU: 3 PID: 27623 Comm: kworker/3:1 Not tainted
5.14.0-lockdep+ #13
[ 7358.563013] Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
[ 7358.569761] Workqueue: events free_user_ns
[ 7358.574039] Call trace:
[ 7358.576595]  dump_backtrace+0x0/0x42c
[ 7358.580402]  show_stack+0x24/0x30
[ 7358.583842]  dump_stack_lvl+0xd0/0x100
[ 7358.587732]  print_address_description+0x30/0x304
[ 7358.592608]  kasan_report+0x190/0x1d8
[ 7358.596405]  kasan_check_range+0x1ac/0x1bc
[ 7358.600643]  __kasan_check_write+0x44/0x54
[ 7358.604876]  dec_ucount+0x50/0xd8
[ 7358.608317]  free_user_ns+0x1b0/0x288
[ 7358.612106]  process_one_work+0x7b4/0x10ec
[ 7358.616354]  worker_thread+0x800/0xcf4
[ 7358.620234]  kthread+0x2a8/0x358
[ 7358.623585]  ret_from_fork+0x10/0x18
[ 7358.627297]
[ 7358.628861] Allocated by task 26538:
[ 7358.632556]  kasan_save_stack+0x38/0x68
[ 7358.636537]  __kasan_kmalloc+0x9c/0xb8
[ 7358.640424]  kmem_cache_alloc_trace+0x2a4/0x370
[ 7358.645104]  fscrypt_setup_filename+0x3bc/0x754
[ 7358.649793]  ext4_find_entry+0x80/0x240
[ 7358.653774]  __ext4_unlink+0x88/0x594
[ 7358.657563]  ext4_unlink+0x458/0x99c
[ 7358.661263]  vfs_unlink+0x22c/0x340
[ 7358.664877]  do_unlinkat+0x358/0x57c
[ 7358.668586]  __arm64_sys_unlinkat+0xa8/0xc4
[ 7358.672920]  invoke_syscall+0xd4/0x2c8
[ 7358.676808]  el0_svc_common+0x124/0x200
[ 7358.680781]  do_el0_svc_compat+0x54/0x64
[ 7358.684835]  el0_svc_compat+0x24/0x34
[ 7358.688640]  el0t_32_sync_handler+0xc0/0xf0
[ 7358.692973]  el0t_32_sync+0x19c/0x1a0
[ 7358.696772]
[ 7358.698331] Freed by task 26538:
[ 7358.701668]  kasan_save_stack+0x38/0x68
[ 7358.705646]  kasan_set_track+0x28/0x3c
[ 7358.709533]  kasan_set_free_info+0x28/0x4c
[ 7358.713772]  ____kasan_slab_free+0x118/0x164
[ 7358.718186]  __kasan_slab_free+0x18/0x28
[ 7358.722240]  kfree+0x2f8/0x500
[ 7358.725403]  ext4_find_entry+0x19c/0x240
[ 7358.729469]  __ext4_unlink+0x88/0x594
[ 7358.733265]  ext4_unlink+0x458/0x99c
[ 7358.736968]  vfs_unlink+0x22c/0x340
[ 7358.740587]  do_unlinkat+0x358/0x57c
[ 7358.744285]  __arm64_sys_unlinkat+0xa8/0xc4
[ 7358.748610]  invoke_syscall+0xd4/0x2c8
[ 7358.752495]  el0_svc_common+0x124/0x200
[ 7358.756464]  do_el0_svc_compat+0x54/0x64
[ 7358.760522]  el0_svc_compat+0x24/0x34
[ 7358.764320]  el0t_32_sync_handler+0xc0/0xf0
[ 7358.768653]  el0t_32_sync+0x19c/0x1a0
[ 7358.772453]
[ 7358.774015] Last potentially related work creation:
[ 7358.779053]  kasan_save_stack+0x38/0x68
[ 7358.783025]  kasan_record_aux_stack+0xdc/0x108
[ 7358.787619]  call_rcu+0x180/0xed4
[ 7358.791061]  __ip6_del_rt+0xfc/0x130
[ 7358.794771]  ip6_route_del+0xa74/0xb74
[ 7358.798653]  inet6_rtm_delroute+0x31c/0x3e4
[ 7358.802986]  rtnetlink_rcv_msg+0x3d0/0x928
[ 7358.807242]  netlink_rcv_skb+0x164/0x2ac
[ 7358.811311]  rtnetlink_rcv+0x24/0x30
[ 7358.815025]  netlink_unicast+0x328/0x518
[ 7358.819083]  netlink_sendmsg+0x5c0/0x934
[ 7358.823142]  sock_sendmsg+0xb8/0xdc
[ 7358.826764]  __sys_sendto+0x218/0x3e4
[ 7358.830557]  __arm64_sys_send+0xac/0xc8
[ 7358.834526]  invoke_syscall+0xd4/0x2c8
[ 7358.838413]  el0_svc_common+0x124/0x200
[ 7358.842382]  do_el0_svc_compat+0x54/0x64
[ 7358.846443]  el0_svc_compat+0x24/0x34
[ 7358.850245]  el0t_32_sync_handler+0xc0/0xf0
[ 7358.854578]  el0t_32_sync+0x19c/0x1a0
[ 7358.858382]
[ 7358.859941] Second to last potentially related work creation:
[ 7358.865862]  kasan_save_stack+0x38/0x68
[ 7358.869850]  kasan_record_aux_stack+0xdc/0x108
[ 7358.874452]  insert_work+0x60/0x22c
[ 7358.878072]  __queue_work+0xae8/0xe74
[ 7358.881866]  queue_work_on+0x100/0x148
[ 7358.885752]  drm_atomic_helper_commit+0x18c/0x1f4
[ 7358.890615]  drm_atomic_nonblocking_commit+0xc4/0xdc
[ 7358.895749]  drm_mode_atomic_ioctl+0x89c/0xaa0
[ 7358.900353]  drm_ioctl_kernel+0x15c/0x260
[ 7358.904505]  drm_ioctl+0x460/0x828
[ 7358.908029]  drm_compat_ioctl+0x1bc/0x230
[ 7358.912176]  __arm64_compat_sys_ioctl+0x1b0/0x1c4
[ 7358.917037]  invoke_syscall+0xd4/0x2c8
[ 7358.920919]  el0_svc_common+0x124/0x200
[ 7358.924887]  do_el0_svc_compat+0x54/0x64
[ 7358.928946]  el0_svc_compat+0x24/0x34
[ 7358.932735]  el0t_32_sync_handler+0xc0/0xf0
[ 7358.937065]  el0t_32_sync+0x19c/0x1a0
[ 7358.940853]
[ 7358.942408] The buggy address belongs to the object at ffffff800af71100
[ 7358.942408]  which belongs to the cache kmalloc-256 of size 256
[ 7358.955282] The buggy address is located 32 bytes inside of
[ 7358.955282]  256-byte region [ffffff800af71100, ffffff800af71200)
[ 7358.967268] The buggy address belongs to the page:
[ 7358.972209] page:fffffffe002bdc00 refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x8af70
[ 7358.981790] head:fffffffe002bdc00 order:3 compound_mapcount:0
compound_pincount:0
[ 7358.989493] flags: 0x10200(slab|head|zone=3D0)
[ 7358.993922] raw: 0000000000010200 fffffffe021e0c08 fffffffe02960008
ffffff808000c980
[ 7359.001898] raw: 0000000000000000 0000000000200020 00000001ffffffff
0000000000000000
[ 7359.009867] page dumped because: kasan: bad access detected
[ 7359.015607]
[ 7359.017162] Memory state around the buggy address:
[ 7359.022105]  ffffff800af71000: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[ 7359.029543]  ffffff800af71080: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[ 7359.036981] >ffffff800af71100: fa fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 7359.044414]                                ^
[ 7359.048818]  ffffff800af71180: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 7359.056256]  ffffff800af71200: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[ 7359.063695] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
