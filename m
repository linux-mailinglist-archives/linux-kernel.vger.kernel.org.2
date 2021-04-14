Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAF335F732
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348478AbhDNPFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:05:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:50719 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232331AbhDNPFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618412680;
        bh=UMTcQ81FFl2W8MKaAPKTb+sxZl1+Zkq1e2Cch32vweE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=hmrwuZQkSht2zSHiX52ngRMya7NEVfs34P9EyRa0TWlStcROk4bcc749m1prgiHzZ
         eaN/pz4rvQwYEX2YZY6+kkHxm65MGuClsDNMCu53Du52K5c97WPx/pM940Kao2C1ZM
         032/jEBI1R3RD/nvzsRGckDZhbMB5HktbJSBh7uM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.50]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwfai-1llmDK2ENW-00y5VZ; Wed, 14
 Apr 2021 17:04:40 +0200
Message-ID: <93866b6a806c268df14913e8d6c0ba185f4e11c7.camel@gmx.de>
Subject: [patch] kasan: make it RT aware
From:   Mike Galbraith <efault@gmx.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed, 14 Apr 2021 17:04:39 +0200
In-Reply-To: <a262b57875cf894020df9b3aa84030e2080ad187.camel@gmx.de>
References: <BY5PR11MB4193DBB0DE4AF424DE235892FF769@BY5PR11MB4193.namprd11.prod.outlook.com>
         <CACT4Y+bsOhKnv2ikR1fTb7KhReGfEeAyxCOyvCu7iS37Lm0vnw@mail.gmail.com>
         <182eea30ee9648b2a618709e9fc894e49cb464ad.camel@gmx.de>
         <CACT4Y+bVkBscD+Ggp6oQm3LbyiMVmwaaX20fQJLHobg6_z4VzQ@mail.gmail.com>
         <a262b57875cf894020df9b3aa84030e2080ad187.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v4AF15jsMquPNwP71BBtMvBL2S3DM0fJv36yORspF23isyW0veC
 zq23O93ELziAEOR4YXDVGBYhj4kr7uSJMeRcLxOHfWskuObzLQz+FxQUl3my2Zxxm31b5FT
 C0CAIgWJ4sxCKJGfCEeErix8YQDPgE6aWKzySblCXpARDmiKH9KHbm31PU5XlkV20UCC4zN
 bZnS0X9FHd6Jvo0VHsS6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9qJGXrM1lRw=:zMdnu4jfn5Rpaw7gNViAeD
 uyQhgNTpfq2r2Z+qKGeh4+4mrp2nUiNn3DevGtDKmWbvzM3xa3dC5vbwu1GYw5WGyW4PCHVYZ
 bbjqFXY/sec+zOqih6KBaeY0mVrL3LR8gVO7iP5XFO63/yu1ZKf786qkXcQVUsylhwcFaMq3H
 aJyCRXSvo2G3QIvbaRvkViL8IearBu/sIzFs90bTXPBut9V4Im3KW6xaDEkOXdjUnuLbzgAM8
 TXaRduIzYLgacUEdmqsh4zN2K6i3es3it/GQrQ+KU/x3wiR7uhwQA8sXbP6Q3a7ec/To3Qj43
 AttdaZe6j1frNMU5ekpXxn9t9coh1SrjVGd6Xpr7O3VoV1uGwtOvlAqJQM8XvJ+o9RFqHWZTS
 gvr93Qhpgp5tRJZv7cMuKBtQzV7MW33Cuev+AINj/Iz/9gcp0OC8BcOkKesv/8c3ICwUERJZ3
 XJJWbnwn+dIAPhrPxi7p7BG7DslziK25WmfV9GmC/zVdJ45e7nQVTAOpWSzuHuW9H9xfQtkbh
 VJ18+uXYcr4J3nc4MddjH05tclxTl3AmCeRt12CXXpYhS3LHTr+a/jLP+UGKYDdhXYeZ1eFTu
 lNdCrwG6lFUTtZiuOa5q34pWN5GdRBedZdgs9N90DhPckb2jPJRyKjAETHCmRVeT2sJ8urWqL
 XsVRM80vDeabTsyVhCXlET95PfxNWVWAD6fTikvzy6Pz4+RWaz8xvT8lfopceoQ9D/+yQ7yIn
 H5GPTbDzx5TJ/ZbSQmsjrZj2g3MBERgrNlPic00BgBREfkMtFpKGmTti3tKo19j5YEvsZ4+PX
 Rpy+XxT8SAEao8ZlgoUtTRc8J9o1X1vR67Z3elsUUimp3cfRU+QBxtzzStXIP0K8lAMAOAgIW
 RzxFnHERcAkF1YDQV23e4g/NyXZ4rC3QTdG0qhyPQ0m/JExkXlIdsCEzZzX79qQFOzRLEBjgq
 fZkkfWuT8gzrUdHA39RHwiphP1eDx56HHZEQL+5wwiGtLWUDZ5CCTKSRiytHetx1ffhdwBKOG
 Rndg6vy6kW6FnCdVxA+ig7pZNFGjMDqUAjdeq5MS7dBtWw/wLCo0V8rGmRa+Jh8Duor0DTI8G
 RC2hmNLWv1OOJpA4rSsAlLwroeb2fpcoFNhE4iYkV1gwQrF0WWmRZadKE7O1pvxKKigx31wVi
 PTxkDymu77c1p63sckwIS+VZAxGRF6n5umHbij9BsaG+84QII6AUnS5bHsGbfCJw4V0hY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-04-14 at 08:15 +0200, Mike Galbraith wrote:
> On Wed, 2021-04-14 at 07:26 +0200, Dmitry Vyukov wrote:
> > On Wed, Apr 14, 2021 at 6:00 AM Mike Galbraith <efault@gmx.de> wrote:
> >
> > > [    0.692437] BUG: sleeping function called from invalid context at=
 kernel/locking/rtmutex.c:943
> > > [    0.692439] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid=
: 1, name: swapper/0
> > > [    0.692442] Preemption disabled at:
> > > [    0.692443] [<ffffffff811a1510>] on_each_cpu_cond_mask+0x30/0xb0
> > > [    0.692451] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.12.0.g2af=
efec-tip-rt #5
> > > [    0.692454] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.=
20C 09/23/2013
> > > [    0.692456] Call Trace:
> > > [    0.692458]  ? on_each_cpu_cond_mask+0x30/0xb0
> > > [    0.692462]  dump_stack+0x8a/0xb5
> > > [    0.692467]  ___might_sleep.cold+0xfe/0x112
> > > [    0.692471]  rt_spin_lock+0x1c/0x60
> >
> > HI Mike,
> >
> > If freeing pages from smp_call_function is not OK, then perhaps we
> > need just to collect the objects to be freed to the task/CPU that
> > executes kasan_quarantine_remove_cache and it will free them (we know
> > it can free objects).
>
> Yeah, RT will have to shove freeing into preemptible context.

There's a very similar problem addressed in the RT patch set, so I used
the free samples on top of your *very* convenient hint that pesky
preallocation is optional, to seemingly make KASAN a happy RT camper.
Dunno if RT maintainers would prefer something like this over simply
disabling KASAN for RT configs, but what the heck, I'll show it.

kasan: make it RT aware

Skip preallocation when not possible for RT, and move cache removal
from IPI to synchronous work.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 lib/stackdepot.c      |   10 +++++-----
 mm/kasan/quarantine.c |   49 ++++++++++++++++++++++++++++++++++++++++++++=
+++++
 2 files changed, 54 insertions(+), 5 deletions(-)

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
=2D-- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -19,6 +19,9 @@
 #include <linux/srcu.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/cpu.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
 #include <linux/cpuhotplug.h>

 #include "../slab.h"
@@ -308,6 +311,48 @@ static void per_cpu_remove_cache(void *a
 	qlist_free_all(&to_free, cache);
 }

+#ifdef CONFIG_PREEMPT_RT
+struct remove_cache_work {
+	struct work_struct work;
+	struct kmem_cache *cache;
+};
+
+static DEFINE_MUTEX(remove_caches_lock);
+static DEFINE_PER_CPU(struct remove_cache_work, remove_cache_work);
+
+static void per_cpu_remove_cache_work(struct work_struct *w)
+{
+	struct remove_cache_work *rcw;
+
+	rcw =3D container_of(w, struct remove_cache_work, work);
+	per_cpu_remove_cache(rcw->cache);
+}
+
+static void per_cpu_remove_caches_sync(struct kmem_cache *cache)
+{
+	struct remove_cache_work *rcw;
+	unsigned int cpu;
+
+	cpus_read_lock();
+	mutex_lock(&remove_caches_lock);
+
+	for_each_online_cpu(cpu) {
+		rcw =3D &per_cpu(remove_cache_work, cpu);
+		INIT_WORK(&rcw->work, per_cpu_remove_cache_work);
+		rcw->cache =3D cache;
+		schedule_work_on(cpu, &rcw->work);
+	}
+
+	for_each_online_cpu(cpu) {
+		rcw =3D &per_cpu(remove_cache_work, cpu);
+		flush_work(&rcw->work);
+	}
+
+	mutex_unlock(&remove_caches_lock);
+	cpus_read_unlock();
+}
+#endif
+
 /* Free all quarantined objects belonging to cache. */
 void kasan_quarantine_remove_cache(struct kmem_cache *cache)
 {
@@ -321,7 +366,11 @@ void kasan_quarantine_remove_cache(struc
 	 * achieves the first goal, while synchronize_srcu() achieves the
 	 * second.
 	 */
+#ifndef CONFIG_PREEMPT_RT
 	on_each_cpu(per_cpu_remove_cache, cache, 1);
+#else
+	per_cpu_remove_caches_sync(cache);
+#endif

 	raw_spin_lock_irqsave(&quarantine_lock, flags);
 	for (i =3D 0; i < QUARANTINE_BATCHES; i++) {


