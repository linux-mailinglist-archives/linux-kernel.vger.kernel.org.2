Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321B23C143C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhGHN1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhGHN1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:27:08 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4ABC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 06:24:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a18so15486980lfs.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 06:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=kQCJa29MlTy4i5W/9FB8VBo3+PRqhIamernJyLi9AA4=;
        b=f0iFTyf0FWv+D5jVo4tMCvY3/gn/3dhdPOsE/vtZHjDQOsfsWczheH1OPhsyAKxep2
         shjz0amllwMn+T2CrfA99oyTq2hSGLUaopYkCywtmNL+MonjqiuOfHDXIFg3YQkwov9D
         H47EYXovk5fCuecmdVxIVF+ol8wmtm5vvDbRTZKExJrR57cvpd7q09eudyZ+PdCc3//J
         DTO0sNqmly35F7VptLBU5nj2sstSxirIaoVbepfDGofkJwaSqk/hXySjuJc4F3doB3La
         tQlo12J62DtfJtTYwk0xS3V8JmEJO9P1e6sjh/4GKngNdYk8BroVIUHR8jC6/BSpKiSZ
         kVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=kQCJa29MlTy4i5W/9FB8VBo3+PRqhIamernJyLi9AA4=;
        b=RhNdfEjfq/KWwn1vDGhlz2EsRN/lcOSqavjycj9n+N+6wynlWiNRGHndODd0qDwi23
         bn+JMFPv371Qxh0xS57qQIDp9isg0yEBwit+O54dB3TuI19PaXza4+bF2gReBVKTIMEJ
         PNg8BMsJOW9SfhaSD4JDUzzB165BxK0zMP2Q1pIv1Z1xW8gn2jDKVMyp0ZDwTHR5cWEX
         TNjU49YcrwMNSmYmHXhguFjqAkqEvtvcpmYtFwv8B1cR195dGrvhv3Enqo8cz9JheMqy
         y6FEJ7DaeXL5I1/aM/CZTI2qjARze6k2Aum5DL2QwYOnU8PSQkOxOrn/yAI4b9cOx4Tq
         dFeA==
X-Gm-Message-State: AOAM530+MsHoBUV2bAMhag7RM+3Bs8cJHVdkL8FEepaxztQ+f7lgFnvs
        mNxBOHlvHITTMwtGsfGGv4M=
X-Google-Smtp-Source: ABdhPJzDyY7gWTuMH0FUkPOr4Mu7dj+t9UFzMWtJv35fhu6IOlrKrS4pJRWlQ+8R5CV09CuUrRtZvQ==
X-Received: by 2002:ac2:4206:: with SMTP id y6mr23504243lfh.206.1625750662109;
        Thu, 08 Jul 2021 06:24:22 -0700 (PDT)
Received: from localhost.localdomain ([94.103.225.155])
        by smtp.gmail.com with ESMTPSA id k13sm196949lfv.64.2021.07.08.06.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 06:24:21 -0700 (PDT)
Date:   Thu, 8 Jul 2021 16:24:17 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: BUG in alloc_workqueue (linux-next)
Message-ID: <20210708162417.777bff77@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, workqueue developers!


My local syzbot instace is hitting bugs in alloc_workqueue() in
linux-next (5.13.0-next-20210706) a lot. Reports:

1st report:

WARNING: CPU: 0 PID: 13217 at kernel/locking/lockdep.c:6305 lockdep_unregister_key+0x19a/0x250 kernel/locking/lockdep.c:6305
Modules linked in:
CPU: 0 PID: 13217 Comm: syz-executor.0 Not tainted 5.13.0-next-20210706 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
RIP: 0010:lockdep_unregister_key+0x19a/0x250 kernel/locking/lockdep.c:6305
Code: 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 8f 00 00 00 4d 89 7d 08 48 b8 22 01 00 00 00 00 ad de 48 89 43 08 eb 02 <0f> 0b 4c 89 f7 ba 01 00 00 00 48 89 ee e8 44 fd ff ff 4c 89 f7 e8
RSP: 0018:ffffc9000271f8e8 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffffffff1c5f04d
RDX: 1ffffffff2115d55 RSI: 0000000000000004 RDI: ffffffff908aeaa8
RBP: ffff888024031128 R08: 0000000000000001 R09: 0000000000000003
R10: fffff520004e3f13 R11: 0000000000000001 R12: 0000000000000246
R13: dffffc0000000000 R14: ffffffff907278a8 R15: ffff888024031000
FS:  00007f95750a7640(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6649cde1a0 CR3: 000000002829a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 wq_unregister_lockdep kernel/workqueue.c:3468 [inline]
 alloc_workqueue+0xb36/0xee0 kernel/workqueue.c:4337
 loop_configure+0x4d8/0x1550 drivers/block/loop.c:1199


2nd report:

ODEBUG: free active (active state 1) object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 12747 at lib/debugobjects.c:505 debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Modules linked in:
CPU: 1 PID: 12747 Comm: syz-executor.1 Tainted: G        W         5.13.0-next-20210706 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 20 64 e6 89 4c 89 ee 48 c7 c7 a0 57 e6 89 e8 c3 98 08 05 <0f> 0b 83 05 35 cb 55 0a 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc90008ad7778 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff815d2c35 RDI: fffff5200115aee1
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815cca8e R11: 0000000000000000 R12: ffffffff898d9b40
R13: ffffffff89e65e20 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f58a7de7640(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f359789b423 CR3: 0000000058bae000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __debug_check_no_obj_freed lib/debugobjects.c:987 [inline]
 debug_check_no_obj_freed+0x2fe/0x420 lib/debugobjects.c:1018
 slab_free_hook mm/slub.c:1625 [inline]
 slab_free_freelist_hook+0x17d/0x280 mm/slub.c:1675
 slab_free mm/slub.c:3235 [inline]
 kfree+0xeb/0x670 mm/slub.c:4295
 alloc_workqueue+0xbbe/0xee0 kernel/workqueue.c:4341
 loop_configure+0x4d8/0x1550 drivers/block/loop.c:1199


3rd report:

BUG: KASAN: use-after-free in __call_rcu kernel/rcu/tree.c:3026 [inline]
BUG: KASAN: use-after-free in call_rcu+0x619/0x750 kernel/rcu/tree.c:3109
Write of size 8 at addr ffff8880435b7180 by task kworker/1:6/9255

CPU: 1 PID: 9255 Comm: kworker/1:6 Tainted: G        W         5.13.0-next-20210706 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
Workqueue: events pwq_unbound_release_workfn
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:436
 __call_rcu kernel/rcu/tree.c:3026 [inline]
 call_rcu+0x619/0x750 kernel/rcu/tree.c:3109
 pwq_unbound_release_workfn+0x236/0x2d0 kernel/workqueue.c:3701         [2]
 process_one_work+0x98a/0x1600 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Allocated by task 17986:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0x9b/0xd0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:596 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 alloc_workqueue+0x16d/0xee0 kernel/workqueue.c:4279
 loop_configure+0x4d8/0x1550 drivers/block/loop.c:1199

Freed by task 17986:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xfb/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:229 [inline]
 slab_free_hook mm/slub.c:1650 [inline]
 slab_free_freelist_hook+0xee/0x280 mm/slub.c:1675
 slab_free mm/slub.c:3235 [inline]
 kfree+0xeb/0x670 mm/slub.c:4295
 alloc_workqueue+0xbbe/0xee0 kernel/workqueue.c:4341                     [1]
 loop_configure+0x4d8/0x1550 drivers/block/loop.c:1199


I've spent some time trying to came up with a fix, but I gave
up :( But! I have an idea about what's happening, maybe it will help
somehow...


So, all 3 reports have same stack trace: alloc_workqueue() in
loop_configure(). I skimmed through syzbot's log and found, that syzbot injected 
failure into alloc_unbound_pwq() in all 3 cases:

FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 1 PID: 17986 Comm: syz-executor.0 Tainted: G        W         5.13.0-next-20210706 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
Call Trace:
   dump_stack_lvl (lib/dump_stack.c:106 (discriminator 4)) 
   should_fail.cold (lib/fault-inject.c:52 lib/fault-inject.c:146) 
   should_failslab (mm/slab_common.c:1327) 
   kmem_cache_alloc_node (mm/slab.h:487 mm/slub.c:2902 mm/slub.c:3017) 
   ? alloc_unbound_pwq (kernel/workqueue.c:3813) 
   alloc_unbound_pwq (kernel/workqueue.c:3813) 
   apply_wqattrs_prepare (kernel/workqueue.c:3963) 
   apply_workqueue_attrs_locked (kernel/workqueue.c:4041) 
   alloc_workqueue (kernel/workqueue.c:4078 kernel/workqueue.c:4201 kernel/workqueue.c:4309) 


So, if alloc_unbound_pwq() fails, apply_wqattrs_prepare() will jump to
this code:

out_free:
	free_workqueue_attrs(tmp_attrs);
	free_workqueue_attrs(new_attrs);
	apply_wqattrs_cleanup(ctx);     <----|
	return NULL;			     |
					     |
put_pwq_unlocked() -> put_pwq() -> schedule_work(&pwq->unbound_release_work);


and apply_wqattrs_cleanup() will schedule pwq_unbound_release_workfn()
[2], but alloc_workqueue() will free workqueue_struct in case of
alloc_unbound_pwq() error [1]. In that case we will get UAF in pwq_unbound_release_workfn()
like in 3rd report.


Does written above make some sence? :)



With regards,
Pavel Skripkin
