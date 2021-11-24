Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319DD45CF73
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 22:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244663AbhKXVwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 16:52:31 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:22548 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242955AbhKXVwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 16:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637790560; x=1669326560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r9ZlVifujOhrDIghfR0Npw5EK4qOUHW9f5Crtie7d/0=;
  b=RIUgMQzh9dJojaXgcrDp+1esrgktfbUaVcMaRzgqQX38/hbUXBQ1LyDN
   MXAGVGfzDmRCZPHTKDmNpp8/7yHpqnkGYN3AN6xzQOhB15HgZ+JtFXCI5
   QsYD18WxhadXIVjjNScPiVF3EtdUn7dOSVjw5in8p+KuVOKiNfgcHfawf
   Q=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Nov 2021 13:49:20 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 13:49:20 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 24 Nov 2021 13:49:19 -0800
Received: from fixkernel.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 24 Nov
 2021 13:49:18 -0800
Date:   Wed, 24 Nov 2021 16:49:16 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     Alexey Gladkov <legion@kernel.org>, Yu Zhao <yuzhao@google.com>,
        <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: BUG: KASAN: use-after-free in dec_rlimit_ucounts
Message-ID: <YZ6zXEZf9qHLFyIp@fixkernel.com>
References: <YZV7Z+yXbsx9p3JN@fixkernel.com>
 <875ysptfgi.fsf@email.froward.int.ebiederm.org>
 <YZa4YbcOyjtD3+pL@fixkernel.com>
 <87k0h5rxle.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87k0h5rxle.fsf@email.froward.int.ebiederm.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 02:57:17PM -0600, Eric W. Biederman wrote:
> Qian Cai <quic_qiancai@quicinc.com> writes:
> 
> > On Thu, Nov 18, 2021 at 01:46:05PM -0600, Eric W. Biederman wrote:
> >> Is it possible?  Yes it is possible.  That is one place where
> >> a use-after-free has shown up and I expect would show up in the
> >> future.
> >> 
> >> That said it is hard to believe there is still a user-after-free in the
> >> code.  We spent the last kernel development cycle pouring through and
> >> correcting everything we saw until we ultimately found one very subtle
> >> use-after-free.
> >> 
> >> If you have a reliable reproducer that you can share, we can look into
> >> this and see if we can track down where the reference count is going
> >> bad.
> >> 
> >> It tends to take instrumenting the entire life cycle every increment and
> >> every decrement and then pouring through the logs to track down a
> >> use-after-free.  Which is not something we can really do without a
> >> reproducer.
> >
> > The reproducer is just to run trinity by an unprivileged user on defconfig
> > with KASAN enabled (On linux-next, you can do "make defconfig debug.conf"
> > [1], but dont think other debugging options are relevent here.)
> >
> > $ trinity -C 31 -N 10000000
> >
> > It is always reproduced on an arm64 server here within 5-minute so far.
> > Some debugging progress so far. BTW, this could happen on user_shm_unlock()
> > path as well.
> 
> Does this only happen on a single architecture?  If so I wonder if
> perhaps some of the architectures atomic primitives are implemented
> improperly.

Hmm, I don't know if that or it is just this platfrom is lucky to trigger
the race condition quickly, but I can't reproduce it on x86 so far. I am
Cc'ing a few arm64 people to see if they have spot anything I might be
missing. The original bug report is here:

https://lore.kernel.org/lkml/YZV7Z+yXbsx9p3JN@fixkernel.com/

I did narrow it down the same traces were first introduced by those
commits:

d7c9e99aee48 Reimplement RLIMIT_MEMLOCK on top of ucounts
d64696905554 Reimplement RLIMIT_SIGPENDING on top of ucounts
6e52a9f0532f Reimplement RLIMIT_MSGQUEUE on top of ucounts
21d1c5e386bc Reimplement RLIMIT_NPROC on top of ucounts
b6c336528926 Use atomic_t for ucounts reference counting
905ae01c4ae2 Add a reference to ucounts for each cred
f9c82a4ea89c Increase size of ucounts to atomic_long_t

Also, I added a debugging patch here:

--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -847,8 +847,14 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)

 void user_shm_unlock(size_t size, struct ucounts *ucounts)
 {
+       int i;
+
        spin_lock(&shmlock_user_lock);
+       printk("KK user_shm_unlock ucounts = %d\n", atomic_read(&ucounts->count));
+       for (i = 0; i < UCOUNT_COUNTS; i++)
+               printk("KK type = %d, count = %ld\n", i, atomic_long_read(&ucounts->ucount[i]));
        dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, (size + PAGE_SIZE - 1) >> PAGE_SHIFT);
+       printk("size = %zu, count = %ld\n", size, atomic_long_read(&ucounts->ucount[UCOUNT_RLIMIT_MEMLOCK]));
        spin_unlock(&shmlock_user_lock);
        put_ucounts(ucounts)

Then, I noticed that ucounts->count is off-by-one. Since the later
put_ucounts() would free the "ucounts", I am wondering if it is actually
correct that "ucounts->count == 1" when entering user_shm_unlock(),
uncounts->ns has already gone. Thus, dec_rlimit_ucounts() should not
blindly traverse ucounts->ns ?

[  214.541754] KK user_shm_unlock ucounts = 1
[  214.545871] KK type = 0, count = 0
[  214.549288] KK type = 1, count = 0
[  214.552697] KK type = 2, count = 0
[  214.556104] KK type = 3, count = 0
[  214.559511] KK type = 4, count = 0
[  214.562920] KK type = 5, count = 0
[  214.566314] KK type = 6, count = 0
[  214.569718] KK type = 7, count = 0
[  214.573132] KK type = 8, count = 0
[  214.576537] KK type = 9, count = 0
[  214.579945] KK type = 10, count = 0
[  214.583441] KK type = 11, count = 0
[  214.586940] KK type = 12, count = 0
[  214.590420] KK type = 13, count = 1
[  214.593917] ==================================================================
[  214.601130] BUG: KASAN: use-after-free in dec_rlimit_ucounts+0xe8/0xf0
[  214.607657] Read of size 8 at addr ffff000905ee12f0 by task trinity-c2/9708
[  214.614611] 
[  214.616093] CPU: 13 PID: 9708 Comm: trinity-c2 Not tainted 5.12.0-00007-gd7c9e99aee48-dirty #221
[  214.624870] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
[  214.632689] Call trace:
[  214.635124]  dump_backtrace+0x0/0x350
[  214.638781]  show_stack+0x18/0x28
[  214.642088]  dump_stack+0x120/0x18c
[  214.645570]  print_address_description.constprop.0+0x6c/0x30c
[  214.651309]  kasan_report+0x1d8/0x1f0
[  214.654964]  __asan_report_load8_noabort+0x34/0x60
[  214.659747]  dec_rlimit_ucounts+0xe8/0xf0
[  214.663748]  user_shm_unlock+0xdc/0x338
[  214.667577]  shmem_lock+0x154/0x250
[  214.671057]  shmctl_do_lock+0x310/0x5d8
[  214.674886]  ksys_shmctl.constprop.0+0x200/0x588
[  214.679496]  __arm64_sys_shmctl+0x6c/0xa0
[  214.683497]  el0_svc_common.constprop.0+0xe4/0x300
[  214.688281]  do_el0_svc+0x48/0xd0
[  214.691587]  el0_svc+0x24/0x38
[  214.694633]  el0_sync_handler+0xb0/0xb8
[  214.698460]  el0_sync+0x174/0x180
[  214.701766] 
[  214.703247] Allocated by task 9392:
[  214.706726]  kasan_save_stack+0x28/0x58
[  214.710555]  __kasan_slab_alloc+0x88/0xa8
[  214.714555]  kmem_cache_alloc+0x190/0x5b0
[  214.718555]  create_user_ns+0x158/0xa60
[  214.722384]  unshare_userns+0x44/0xe0
[  214.726038]  ksys_unshare+0x23c/0x580
[  214.729693]  __arm64_sys_unshare+0x30/0x50
[  214.733781]  el0_svc_common.constprop.0+0xe4/0x300
[  214.738564]  do_el0_svc+0x48/0xd0
[  214.741871]  e
                 [  214.752048] asan_set_track+0x28/0x40
[  214.764227]  kasan_set_free_info+0x28/0x50
[  214.768314]  __kasan_slab_free+0xd0/0x130
[  214.772316]  kmem_cache_free+0xb4/0x390
[  214.776146]  free_user_ns+0x108/0x2a8
[  214.779802]  process_one_work+0x684/0xfd0
[  214.783804]  worker_thread+0x314/0xc78
[  214.787543]  kthread+0x3a4/0x460
[  214.790763]  ret_from_fork+0x10/0x30
[  214.794330] 
[  214.795811] Last potentially related work creation:
[  214.800678]  kasan_save_stack+0x28/0x58
[  214.804505]  kasan_record_aux_stack+0xc0/0xd8
[  214.808853]  insert_work+0x50/0x2f0
[  214.812334]  __queue_work+0x314/0xac8
[  214.815988]  queue_work_on+0x94/0xc8
[  214.819555]  __put_user_ns+0x3c/0x60
[  214.823122]  put_cred_rcu+0x208/0x2f8
[  214.826775]  rcu_core+0x734/0xf68
[  214.830083]  rcu_core_si+0x10/0x20
[  214.833477]  __do_softirq+0x28c/0x774
[  214.837130] 
[  214.838610] The buggy address belongs to the object at ffff000905ee1110
[  214.838610]  which belongs to the cache user_namespace of size 600
[  214.851378] The buggy address is located 480 bytes inside of
[  214.851378]  600-byte region [ffff000905ee1110, ffff000905ee1368)
[  214.863105] The buggy address belongs to the page:
[  214.867886] page:000000000a048a0d refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x985ee0
[  214.877271] head:000000000a048a0d order:3 compound_mapcount:0 compound_pincount:0
[  214.884744] flags: 0xbfffc0000010200(slab|head)
[  214.889270] raw: 0bfffc0000010200 dead000000000100 dead000000000122 ffff0008002a3180
[  214.897003] raw: 0000000000000000 00000000802d002d 00000001ffffffff 0000000000000000
[  214.904734] page dumped because: kasan: bad access detected
[  214.910296] 
[  214.911776] Memory state around the buggy address:
[  214.916557]  ffff000905ee1180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  214.923769]  ffff000905ee1200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  214.930981] >ffff000905ee1280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  214.938191]                                                              ^
[  214.945056]  ffff000905ee1300: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
[  214.952267]  ffff000905ee1380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  214.959477] ==================================================================
[  214.967070] Disabling lock debugging due to kernel taint
[  214.972398] size = 4096, count = 0

> 
> Unfortunately I don't have any arm64 machines where I can easily test
> this.
> 
> The call path you posted from user_shm_unlock is another path where
> a use-after-free has show up in the past.
> 
> My blind guess would be that I made an implementation mistake in
> inc_rlimit_get_ucounts or dec_rlimit_put_ucounts but I can't see it
> right now.
> 
> Eric
> 
> >  Call trace:
> >   dec_rlimit_ucounts
> >   user_shm_unlock
> >   (inlined by) user_shm_unlock at mm/mlock.c:854
> >   shmem_lock
> >   shmctl_do_lock
> >   ksys_shmctl.constprop.0
> >   __arm64_sys_shmctl
> >   invoke_syscall
> >   el0_svc_common.constprop.0
> >   do_el0_svc
> >   el0_svc
> >   el0t_64_sync_handler
> >   el0t_64_sync
> >
> > I noticed in dec_rlimit_ucounts(), dec == 0 and type ==
> > UCOUNT_RLIMIT_MEMLOCK. 
> >
> > [1] https://lore.kernel.org/lkml/20211115134754.7334-1-quic_qiancai@quicinc.com/
