Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EE935EBA0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 06:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhDNEBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 00:01:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:39359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhDNEB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 00:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618372858;
        bh=WmgVVi6TJYkYR8e8vrempzc7xknSHy68MhPdDyS6yOA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Q/Hp0C1UvXrS+2q92970m+06/KgOyuRPU7erDtjv6TKs+w55pccQNvPsvzD+vTksp
         X0k3EqjIGPQ8VuWIJbKWYevpA33y8vG5hCxKnk5kwWex/pvxyiashWKOMGKBrx6gLS
         b25c10DF3gV93m47pzWr/OfOnPgg5tRhAPBw65I0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.50]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRfv-1m8KQq3N9N-00bvGF; Wed, 14
 Apr 2021 06:00:57 +0200
Message-ID: <182eea30ee9648b2a618709e9fc894e49cb464ad.camel@gmx.de>
Subject: Re: Question on KASAN calltrace record in RT
From:   Mike Galbraith <efault@gmx.de>
To:     Dmitry Vyukov <dvyukov@google.com>,
        "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Date:   Wed, 14 Apr 2021 06:00:56 +0200
In-Reply-To: <CACT4Y+bsOhKnv2ikR1fTb7KhReGfEeAyxCOyvCu7iS37Lm0vnw@mail.gmail.com>
References: <BY5PR11MB4193DBB0DE4AF424DE235892FF769@BY5PR11MB4193.namprd11.prod.outlook.com>
         <CACT4Y+bsOhKnv2ikR1fTb7KhReGfEeAyxCOyvCu7iS37Lm0vnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HZRmHLqiIwZEn+kf1tYMKYZHXkLQlexzttJbBt2vGpxMNf2cV9w
 iJb3u1uASEfghJ6e339tkXUqyhvDVSQ8dufWaVP4AE6uMrPyPUP+x108q1Iw1i4bFspGjKz
 NvZHPyHNdTDJDAcjjxRZxDjhTDu9ISTR80+DuUNYBIg0N70al38XMcBuTOtW2kUo4HABRjn
 yt/OsqWJosOVRtmyQx/FQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YOPBC2QGQWI=:83qIjtWF+OafgoWy8NBph6
 OQE087dX+8yPNU9RG+Pj6vhR5GUVeCclUq+AhnkT6ugkhtTsSDrv1PPfo2i9ajHxDzdAtijUV
 EywNZl2QT3YqdZG5NhheKc4IU5UkqzQyTBvNiW62I77pQHqwMu4PzbIlsKrFmAw5F9RDbYC7f
 PJaMACJShqCjGK0FWR0lSbpWF87/GdIbp54gT6GQLlOhUgS+Z88PgLfHO+gRwhySY3qF7x4Wo
 NzCyhnmiemjj76Lb3HdBlzcAyb1ZsVc4WcqimmWDhCmt/He4AC319NLwmAj8tP9GhBrfJ0zmH
 kDxsHdCgEI8E6mLrE9gCYdQQWf3c6d7hy7x7r2+hwSe1w4d3Leo/+9pGMmgfBdx3SwGOjHHDV
 AnctVnpO2o1/w5r1QRCL72iYQHPeRkPRlY21FET1MESAx4BtuRJ7V1RKCJn7EJrUmec4M9wD0
 MAIK31UySj8GRrLjfKJl4rxVQX4odH2AkgXUibf81tzk89P7uwsbYsVzoX9H7YLnzxzBASCnI
 6tkduDycwoymhyj7dVJNpyx60dI3d8gC3Yzi8RZHj79ehfDYtnP5pQBucxCPkaK5zSpk6+zOI
 T8ak/c6LWLJ42vljZjHA3Hre4s6vJTkDCiGTsCEy0uqdvPGs0tHL/fCEcDc+pVr/lpHhubyvA
 LR69csTqTkJom3jlA7Oec5YXv5sG+Q488sC5UT/z2lkxl/XX53NbGF66ed5uxCUXur8JFnrfx
 ktLYfFAonuXJ7AA6iX8Qf+OG1xxu+3uKX4jwKFqzowXNyI6SLR+UN1sS0z6k4VAxsXB+C6R/9
 Cr3NNzgv2BxiP5u7YL4a8GBYu8E9mOh4rZ17iNchx3rYEpWratoJT7oRH7d35RDXJUm2OKCiw
 57OqdqPafCEriF1jmmgmJUvXRoGj+hVBYGwvT2cYL1kM7gCPeTbtPiGyHDo97/bDVz8Mn7ECY
 8+tevDTDyArguB+nJ/Ie+06Pup13P6Bx9vS8cHkgQXqb9ezU88ur/6s2KZopAbCMj/SEehruB
 y4G0aFdlM5G3eJmysnY63u3vk2n9axpq7JW9sMezUnyWC5xOe0dNfisiOkECxP9P7A+yOWDoV
 eu6fTfpgJOYs7WRqysoNCl5DDpvtEMu33vp/9P2vFF0cEKiAGyabCs/3cA08Gxeou1MU7gab/
 lk+6JB3VZLgg+iWox0D5x20DIE3waV8MuGSsJu/0+9DeFriHVxJITbaWP9hR1XNYzt3oQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-04-13 at 17:29 +0200, Dmitry Vyukov wrote:
> On Tue, Apr 6, 2021 at 10:26 AM Zhang, Qiang <Qiang.Zhang@windriver.com>=
 wrote:
> >
> > Hello everyone
> >
> > In RT system,   after  Andrew test,   found the following calltrace ,
> > in KASAN, we record callstack through stack_depot_save(), in this func=
tion, may be call alloc_pages,  but in RT, the spin_lock replace with
> > rt_mutex in alloc_pages(), if before call this function, the irq is di=
sabled,
> > will trigger following calltrace.
> >
> > maybe  add array[KASAN_STACK_DEPTH] in struct kasan_track to record ca=
llstack  in RT system.
> >
> > Is there a better solution =EF=BC=9F
>
> Hi Qiang,
>
> Adding 2 full stacks per heap object can increase memory usage too much.
> The stackdepot has a preallocation mechanism, I would start with
> adding interrupts check here:
> https://elixir.bootlin.com/linux/v5.12-rc7/source/lib/stackdepot.c#L294
> and just not do preallocation in interrupt context. This will solve
> the problem, right?

Hm, this thing might actually be (sorta?) working, modulo one startup
gripe.  The CRASH_DUMP inspired gripe I get with !RT appeared (and shut
up when told I don't care given kdump has worked just fine for ages:),
but no more might_sleep() gripeage.


CONFIG_KASAN_SHADOW_OFFSET=3D0xdffffc0000000000
CONFIG_HAVE_ARCH_KASAN=3Dy
CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy
CONFIG_CC_HAS_KASAN_GENERIC=3Dy
CONFIG_KASAN=3Dy
CONFIG_KASAN_GENERIC=3Dy
CONFIG_KASAN_OUTLINE=3Dy
# CONFIG_KASAN_INLINE is not set
CONFIG_KASAN_STACK=3D1
CONFIG_KASAN_VMALLOC=3Dy
# CONFIG_KASAN_MODULE_TEST is not set

=2D--
 lib/stackdepot.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

=2D-- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -71,7 +71,7 @@ static void *stack_slabs[STACK_ALLOC_MAX
 static int depot_index;
 static int next_slab_inited;
 static size_t depot_offset;
-static DEFINE_SPINLOCK(depot_lock);
+static DEFINE_RAW_SPINLOCK(depot_lock);

 static bool init_stack_slab(void **prealloc)
 {
@@ -265,7 +265,7 @@ depot_stack_handle_t stack_depot_save(un
 	struct page *page =3D NULL;
 	void *prealloc =3D NULL;
 	unsigned long flags;
-	u32 hash;
+	u32 hash, may_prealloc =3D !IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible=
();

 	if (unlikely(nr_entries =3D=3D 0) || stack_depot_disable)
 		goto fast_exit;
@@ -291,7 +291,7 @@ depot_stack_handle_t stack_depot_save(un
 	 * The smp_load_acquire() here pairs with smp_store_release() to
 	 * |next_slab_inited| in depot_alloc_stack() and init_stack_slab().
 	 */
-	if (unlikely(!smp_load_acquire(&next_slab_inited))) {
+	if (unlikely(!smp_load_acquire(&next_slab_inited) && may_prealloc)) {
 		/*
 		 * Zero out zone modifiers, as we don't have specific zone
 		 * requirements. Keep the flags related to allocation in atomic
@@ -305,7 +305,7 @@ depot_stack_handle_t stack_depot_save(un
 			prealloc =3D page_address(page);
 	}

-	spin_lock_irqsave(&depot_lock, flags);
+	raw_spin_lock_irqsave(&depot_lock, flags);

 	found =3D find_stack(*bucket, entries, nr_entries, hash);
 	if (!found) {
@@ -329,7 +329,7 @@ depot_stack_handle_t stack_depot_save(un
 		WARN_ON(!init_stack_slab(&prealloc));
 	}

-	spin_unlock_irqrestore(&depot_lock, flags);
+	raw_spin_unlock_irqrestore(&depot_lock, flags);
 exit:
 	if (prealloc) {
 		/* Nobody used this memory, ok to free it. */

[    0.692437] BUG: sleeping function called from invalid context at kerne=
l/locking/rtmutex.c:943
[    0.692439] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, n=
ame: swapper/0
[    0.692442] Preemption disabled at:
[    0.692443] [<ffffffff811a1510>] on_each_cpu_cond_mask+0x30/0xb0
[    0.692451] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.12.0.g2afefec-t=
ip-rt #5
[    0.692454] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[    0.692456] Call Trace:
[    0.692458]  ? on_each_cpu_cond_mask+0x30/0xb0
[    0.692462]  dump_stack+0x8a/0xb5
[    0.692467]  ___might_sleep.cold+0xfe/0x112
[    0.692471]  rt_spin_lock+0x1c/0x60
[    0.692475]  free_unref_page+0x117/0x3c0
[    0.692481]  qlist_free_all+0x60/0xd0
[    0.692485]  per_cpu_remove_cache+0x5b/0x70
[    0.692488]  smp_call_function_many_cond+0x185/0x3d0
[    0.692492]  ? qlist_move_cache+0xe0/0xe0
[    0.692495]  ? qlist_move_cache+0xe0/0xe0
[    0.692497]  on_each_cpu_cond_mask+0x44/0xb0
[    0.692501]  kasan_quarantine_remove_cache+0x52/0xf0
[    0.692505]  ? acpi_bus_init+0x183/0x183
[    0.692510]  kmem_cache_shrink+0xe/0x20
[    0.692513]  acpi_os_purge_cache+0xa/0x10
[    0.692517]  acpi_purge_cached_objects+0x1d/0x68
[    0.692522]  acpi_initialize_objects+0x11/0x39
[    0.692524]  ? acpi_ev_install_xrupt_handlers+0x6f/0x7c
[    0.692529]  acpi_bus_init+0x50/0x183
[    0.692532]  acpi_init+0xce/0x182
[    0.692536]  ? acpi_bus_init+0x183/0x183
[    0.692539]  ? intel_idle_init+0x36d/0x36d
[    0.692543]  ? acpi_bus_init+0x183/0x183
[    0.692546]  do_one_initcall+0x71/0x300
[    0.692550]  ? trace_event_raw_event_initcall_finish+0x120/0x120
[    0.692553]  ? parameq+0x90/0x90
[    0.692556]  ? __wake_up_common+0x1e0/0x200
[    0.692560]  ? kasan_unpoison+0x21/0x50
[    0.692562]  ? __kasan_slab_alloc+0x24/0x70
[    0.692567]  do_initcalls+0xff/0x129
[    0.692571]  kernel_init_freeable+0x19c/0x1ce
[    0.692574]  ? rest_init+0xc6/0xc6
[    0.692577]  kernel_init+0xd/0x11a
[    0.692580]  ret_from_fork+0x1f/0x30

[   15.428008] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   15.428011] BUG: KASAN: vmalloc-out-of-bounds in crash_setup_memmap_ent=
ries+0x17e/0x3a0
[   15.428018] Write of size 8 at addr ffffc90000426008 by task kexec/1187
[   15.428022] CPU: 2 PID: 1187 Comm: kexec Tainted: G        W   E     5.=
12.0.g2afefec-tip-rt #5
[   15.428025] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[   15.428027] Call Trace:
[   15.428029]  ? crash_setup_memmap_entries+0x17e/0x3a0
[   15.428032]  dump_stack+0x8a/0xb5
[   15.428037]  print_address_description.constprop.0+0x16/0xa0
[   15.428044]  kasan_report+0xc4/0x100
[   15.428047]  ? crash_setup_memmap_entries+0x17e/0x3a0
[   15.428050]  crash_setup_memmap_entries+0x17e/0x3a0
[   15.428053]  ? strcmp+0x2e/0x50
[   15.428057]  ? native_machine_crash_shutdown+0x240/0x240
[   15.428059]  ? kexec_purgatory_find_symbol.isra.0+0x145/0x1a0
[   15.428066]  setup_boot_parameters+0x181/0x5c0
[   15.428069]  bzImage64_load+0x6b5/0x740
[   15.428072]  ? bzImage64_probe+0x140/0x140
[   15.428075]  ? iov_iter_kvec+0x5f/0x70
[   15.428080]  ? rw_verify_area+0x80/0x80
[   15.428087]  ? __might_sleep+0x31/0xd0
[   15.428091]  ? __might_sleep+0x31/0xd0
[   15.428094]  ? ___might_sleep+0xc9/0xe0
[   15.428096]  ? bzImage64_probe+0x140/0x140
[   15.428099]  arch_kexec_kernel_image_load+0x102/0x130
[   15.428102]  kimage_file_alloc_init+0xda/0x290
[   15.428107]  __do_sys_kexec_file_load+0x21f/0x390
[   15.428110]  ? __x64_sys_open+0x100/0x100
[   15.428113]  ? kexec_calculate_store_digests+0x390/0x390
[   15.428117]  ? rcu_nocb_flush_deferred_wakeup+0x36/0x50
[   15.428122]  do_syscall_64+0x3d/0x80
[   15.428127]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   15.428132] RIP: 0033:0x7f46ad026759
[   15.428135] Code: 00 48 81 c4 80 00 00 00 89 f0 c3 66 0f 1f 44 00 00 48=
 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0f d7 2b 00 f7 d8 64 89 01 48
[   15.428137] RSP: 002b:00007ffcf6f96788 EFLAGS: 00000206 ORIG_RAX: 00000=
00000000140
[   15.428141] RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00007f46ad=
026759
[   15.428143] RDX: 0000000000000182 RSI: 0000000000000005 RDI: 0000000000=
000003
[   15.428145] RBP: 00007ffcf6f96a28 R08: 0000000000000002 R09: 0000000000=
000000
[   15.428146] R10: 0000000000b0d5e0 R11: 0000000000000206 R12: 0000000000=
000004
[   15.428148] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000ff=
ffffff
[   15.428152] Memory state around the buggy address:
[   15.428164]  ffffc90000425f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f=
8 f8 f8
[   15.428166]  ffffc90000425f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f=
8 f8 f8
[   15.428168] >ffffc90000426000: 00 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f=
8 f8 f8
[   15.428169]                       ^
[   15.428171]  ffffc90000426080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f=
8 f8 f8
[   15.428172]  ffffc90000426100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f=
8 f8 f8
[   15.428173] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   15.428174] Disabling lock debugging due to kernel taint

kasan: stop grumbling about CRASH_DUMP

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 arch/x86/kernel/Makefile |    1 +
 kernel/Makefile          |    1 +
 2 files changed, 2 insertions(+)

=2D-- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_X86_TSC)		+=3D trace_clock.o
 obj-$(CONFIG_CRASH_CORE)	+=3D crash_core_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+=3D machine_kexec_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+=3D relocate_kernel_$(BITS).o crash.o
+KASAN_SANITIZE_crash.o		:=3D n
 obj-$(CONFIG_KEXEC_FILE)	+=3D kexec-bzimage64.o
 obj-$(CONFIG_CRASH_DUMP)	+=3D crash_dump_$(BITS).o
 obj-y				+=3D kprobes/
=2D-- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_CRASH_CORE) +=3D crash_core.o
 obj-$(CONFIG_KEXEC_CORE) +=3D kexec_core.o
 obj-$(CONFIG_KEXEC) +=3D kexec.o
 obj-$(CONFIG_KEXEC_FILE) +=3D kexec_file.o
+KASAN_SANITIZE_kexec_file.o :=3D n
 obj-$(CONFIG_KEXEC_ELF) +=3D kexec_elf.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) +=3D backtracetest.o
 obj-$(CONFIG_COMPAT) +=3D compat.o

