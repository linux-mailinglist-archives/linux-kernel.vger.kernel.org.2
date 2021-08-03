Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EFF3DF25B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 18:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhHCQTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 12:19:39 -0400
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:48950 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233209AbhHCQTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 12:19:34 -0400
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 0D9A9180D0F8A;
        Tue,  3 Aug 2021 16:19:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id D3CBFD1513;
        Tue,  3 Aug 2021 16:19:20 +0000 (UTC)
Message-ID: <fda1d99419154c334d5c138b922b706c2a56890e.camel@perches.com>
Subject: Re: [PATCH 4/4] memblock: stop poisoning raw allocations
From:   Joe Perches <joe@perches.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Tue, 03 Aug 2021 09:19:19 -0700
In-Reply-To: <YQj3MqOON6qySFFa@kernel.org>
References: <20210714123739.16493-1-rppt@kernel.org>
         <20210714123739.16493-5-rppt@kernel.org>
         <72be13936ca341897d2fd7c65fb4345a8467c571.camel@perches.com>
         <YQj3MqOON6qySFFa@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.12
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D3CBFD1513
X-Stat-Signature: 84epcinmt769rogx7yymnxyptsecwxpy
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19GELoWO/0ajGcE747sxcIzXeRzaLnzWoU=
X-HE-Tag: 1628007560-88494
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-08-03 at 10:58 +0300, Mike Rapoport wrote:
> On Sat, Jul 31, 2021 at 10:13:04AM -0700, Joe Perches wrote:
> > On Wed, 2021-07-14 at 15:37 +0300, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > Functions memblock_alloc_exact_nid_raw() and memblock_alloc_try_nid_raw()
> > > are intended for early memory allocation without overhead of zeroing the
> > > allocated memory. Since these functions were used to allocate the memory
> > > map, they have ended up with addition of a call to page_init_poison() that
> > > poisoned the allocated memory when CONFIG_PAGE_POISON was set.
> > > 
> > > Since the memory map is allocated using a dedicated memmep_alloc() function
> > > that takes care of the poisoning, remove page poisoning from the
> > > memblock_alloc_*_raw() functions.
> > []
> > > diff --git a/mm/memblock.c b/mm/memblock.c
> > []
> > > @@ -1490,18 +1490,12 @@ void * __init memblock_alloc_exact_nid_raw(
> > >  			phys_addr_t min_addr, phys_addr_t max_addr,
> > >  			int nid)
> > >  {
> > > -	void *ptr;
> > > -
> > >  	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
> > >  		     __func__, (u64)size, (u64)align, nid, &min_addr,
> > >  		     &max_addr, (void *)_RET_IP_);
> > 
> > unassociated trivia:
> > 
> > casting _RET_IP_ back to void * seems odd as the define is
> > include/linux/kernel.h:#define _RET_IP_         (unsigned long)__builtin_return_address(0)
> > 
> > It's probably easier to understand as just __builtin_return_address(0)
> 
> Maybe, but I'm not sure it's worth the churn.
>  

I think churn is overused as a blocking mechanism over readability.
I prefer readability.

$ git grep -P --name-only  '\(\s*void\s*\*\s*\)\s*_RET_IP_' | \
  xargs sed -r -i -e 's/\(\s*void\s*\*\s*\)\s*_RET_IP_/__builtin_return_address(0)/'
---
 arch/arm/mm/init.c                    |  2 +-
 arch/powerpc/kernel/irq.c             |  2 +-
 arch/powerpc/kernel/setup_32.c        |  2 +-
 arch/x86/mm/kasan_init_64.c           |  2 +-
 drivers/block/drbd/drbd_actlog.c      |  2 +-
 drivers/char/random.c                 |  2 +-
 drivers/firmware/arm_scmi/driver.c    |  2 +-
 drivers/firmware/ti_sci.c             |  2 +-
 drivers/gpu/drm/i915/gt/intel_reset.c |  2 +-
 drivers/gpu/drm/i915/i915_utils.c     |  2 +-
 drivers/soc/ti/smartreflex.c          | 10 +++++-----
 mm/memblock.c                         | 20 ++++++++++----------
 mm/util.c                             |  2 +-
 13 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 6162a070a4104..a4aa1c94e65d5 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -156,7 +156,7 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
 	phys = memblock_phys_alloc(size, align);
 	if (!phys)
 		panic("Failed to steal %pa bytes at %pS\n",
-		      &size, (void *)_RET_IP_);
+		      &size, __builtin_return_address(0));
 
 	memblock_free(phys, size);
 	memblock_remove(phys, size);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 91e63eac4e8fa..ff171281a8e0b 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -777,7 +777,7 @@ DEFINE_INTERRUPT_HANDLER_ASYNC(do_IRQ)
 static void *__init alloc_vm_stack(void)
 {
 	return __vmalloc_node(THREAD_SIZE, THREAD_ALIGN, THREADINFO_GFP,
-			      NUMA_NO_NODE, (void *)_RET_IP_);
+			      NUMA_NO_NODE, __builtin_return_address(0));
 }
 
 static void __init vmap_irqstack_init(void)
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 7ec5c47fce0e3..aec19db5c319d 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -143,7 +143,7 @@ static void *__init alloc_stack(void)
 
 	if (!ptr)
 		panic("cannot allocate %d bytes for stack at %pS\n",
-		      THREAD_SIZE, (void *)_RET_IP_);
+		      THREAD_SIZE, __builtin_return_address(0));
 
 	return ptr;
 }
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 1a50434c8a4da..df887e14ed6cb 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -30,7 +30,7 @@ static __init void *early_alloc(size_t size, int nid, bool should_panic)
 
 	if (!ptr && should_panic)
 		panic("%pS: Failed to allocate page, nid=%d from=%lx\n",
-		      (void *)_RET_IP_, nid, __pa(MAX_DMA_ADDRESS));
+		      __builtin_return_address(0), nid, __pa(MAX_DMA_ADDRESS));
 
 	return ptr;
 }
diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 72cf7603d51fc..657e2260c4d1b 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -185,7 +185,7 @@ int drbd_md_sync_page_io(struct drbd_device *device, struct drbd_backing_dev *bd
 	dynamic_drbd_dbg(device, "meta_data io: %s [%d]:%s(,%llus,%s) %pS\n",
 	     current->comm, current->pid, __func__,
 	     (unsigned long long)sector, (op == REQ_OP_WRITE) ? "WRITE" : "READ",
-	     (void*)_RET_IP_ );
+	     __builtin_return_address(0) );
 
 	if (sector < drbd_md_first_sector(bdev) ||
 	    sector + 7 > drbd_md_last_sector(bdev))
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 605969ed0f965..04019eaf807bc 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1487,7 +1487,7 @@ static ssize_t extract_entropy(struct entropy_store *r, void *buf,
 }
 
 #define warn_unseeded_randomness(previous) \
-	_warn_unseeded_randomness(__func__, (void *) _RET_IP_, (previous))
+	_warn_unseeded_randomness(__func__, __builtin_return_address(0), (previous))
 
 static void _warn_unseeded_randomness(const char *func_name, void *caller,
 				      void **previous)
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 9b2e8d42a9922..34df6472c5672 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -468,7 +468,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
 		if (!wait_for_completion_timeout(&xfer->done, timeout)) {
 			dev_err(dev, "timed out in resp(caller: %pS)\n",
-				(void *)_RET_IP_);
+				__builtin_return_address(0));
 			ret = -ETIMEDOUT;
 		}
 	}
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 235c7e7869aa7..7a74fec632250 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -417,7 +417,7 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
 	timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
 	if (!wait_for_completion_timeout(&xfer->done, timeout)) {
 		dev_err(dev, "Mbox timedout in resp(caller: %pS)\n",
-			(void *)_RET_IP_);
+			__builtin_return_address(0));
 		ret = -ETIMEDOUT;
 	}
 	/*
diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
index 72251638d4eab..ff16dc55278c5 100644
--- a/drivers/gpu/drm/i915/gt/intel_reset.c
+++ b/drivers/gpu/drm/i915/gt/intel_reset.c
@@ -925,7 +925,7 @@ void intel_gt_set_wedged(struct intel_gt *gt)
 		struct intel_engine_cs *engine;
 		enum intel_engine_id id;
 
-		drm_printf(&p, "called from %pS\n", (void *)_RET_IP_);
+		drm_printf(&p, "called from %pS\n", __builtin_return_address(0));
 		for_each_engine(engine, gt, id) {
 			if (intel_engine_is_idle(engine))
 				continue;
diff --git a/drivers/gpu/drm/i915/i915_utils.c b/drivers/gpu/drm/i915/i915_utils.c
index f9e780dee9dec..7a2d7a9a3f9c1 100644
--- a/drivers/gpu/drm/i915/i915_utils.c
+++ b/drivers/gpu/drm/i915/i915_utils.c
@@ -52,7 +52,7 @@ __i915_printk(struct drm_i915_private *dev_priv, const char *level,
 void add_taint_for_CI(struct drm_i915_private *i915, unsigned int taint)
 {
 	__i915_printk(i915, KERN_NOTICE, "CI tainted:%#x by %pS\n",
-		      taint, (void *)_RET_IP_);
+		      taint, __builtin_return_address(0));
 
 	/* Failures that occur during fault injection testing are expected */
 	if (!i915_error_injected())
diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
index 06cbee5fd2542..8448a6ea32aeb 100644
--- a/drivers/soc/ti/smartreflex.c
+++ b/drivers/soc/ti/smartreflex.c
@@ -357,7 +357,7 @@ int sr_configure_errgen(struct omap_sr *sr)
 
 	if (!sr) {
 		pr_warn("%s: NULL omap_sr from %pS\n",
-			__func__, (void *)_RET_IP_);
+			__func__, __builtin_return_address(0));
 		return -EINVAL;
 	}
 
@@ -424,7 +424,7 @@ int sr_disable_errgen(struct omap_sr *sr)
 
 	if (!sr) {
 		pr_warn("%s: NULL omap_sr from %pS\n",
-			__func__, (void *)_RET_IP_);
+			__func__, __builtin_return_address(0));
 		return -EINVAL;
 	}
 
@@ -479,7 +479,7 @@ int sr_configure_minmax(struct omap_sr *sr)
 
 	if (!sr) {
 		pr_warn("%s: NULL omap_sr from %pS\n",
-			__func__, (void *)_RET_IP_);
+			__func__, __builtin_return_address(0));
 		return -EINVAL;
 	}
 
@@ -564,7 +564,7 @@ int sr_enable(struct omap_sr *sr, unsigned long volt)
 
 	if (!sr) {
 		pr_warn("%s: NULL omap_sr from %pS\n",
-			__func__, (void *)_RET_IP_);
+			__func__, __builtin_return_address(0));
 		return -EINVAL;
 	}
 
@@ -616,7 +616,7 @@ void sr_disable(struct omap_sr *sr)
 {
 	if (!sr) {
 		pr_warn("%s: NULL omap_sr from %pS\n",
-			__func__, (void *)_RET_IP_);
+			__func__, __builtin_return_address(0));
 		return;
 	}
 
diff --git a/mm/memblock.c b/mm/memblock.c
index a69449bffc8d2..fe620b358b560 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -684,7 +684,7 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
 	phys_addr_t end = base + size - 1;
 
 	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
-		     &base, &end, (void *)_RET_IP_);
+		     &base, &end, __builtin_return_address(0));
 
 	return memblock_add_range(&memblock.memory, base, size, MAX_NUMNODES, 0);
 }
@@ -785,7 +785,7 @@ int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size)
 	phys_addr_t end = base + size - 1;
 
 	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
-		     &base, &end, (void *)_RET_IP_);
+		     &base, &end, __builtin_return_address(0));
 
 	return memblock_remove_range(&memblock.memory, base, size);
 }
@@ -803,7 +803,7 @@ int __init_memblock memblock_free(phys_addr_t base, phys_addr_t size)
 	phys_addr_t end = base + size - 1;
 
 	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
-		     &base, &end, (void *)_RET_IP_);
+		     &base, &end, __builtin_return_address(0));
 
 	kmemleak_free_part_phys(base, size);
 	return memblock_remove_range(&memblock.reserved, base, size);
@@ -814,7 +814,7 @@ int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
 	phys_addr_t end = base + size - 1;
 
 	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
-		     &base, &end, (void *)_RET_IP_);
+		     &base, &end, __builtin_return_address(0));
 
 	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, 0);
 }
@@ -825,7 +825,7 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
 	phys_addr_t end = base + size - 1;
 
 	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
-		     &base, &end, (void *)_RET_IP_);
+		     &base, &end, __builtin_return_address(0));
 
 	return memblock_add_range(&physmem, base, size, MAX_NUMNODES, 0);
 }
@@ -1392,7 +1392,7 @@ phys_addr_t __init memblock_phys_alloc_range(phys_addr_t size,
 {
 	memblock_dbg("%s: %llu bytes align=0x%llx from=%pa max_addr=%pa %pS\n",
 		     __func__, (u64)size, (u64)align, &start, &end,
-		     (void *)_RET_IP_);
+		     __builtin_return_address(0));
 	return memblock_alloc_range_nid(size, align, start, end, NUMA_NO_NODE,
 					false);
 }
@@ -1493,7 +1493,7 @@ void * __init memblock_alloc_exact_nid_raw(
 {
 	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
 		     __func__, (u64)size, (u64)align, nid, &min_addr,
-		     &max_addr, (void *)_RET_IP_);
+		     &max_addr, __builtin_return_address(0));
 
 	return memblock_alloc_internal(size, align, min_addr, max_addr, nid,
 				       true);
@@ -1525,7 +1525,7 @@ void * __init memblock_alloc_try_nid_raw(
 {
 	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
 		     __func__, (u64)size, (u64)align, nid, &min_addr,
-		     &max_addr, (void *)_RET_IP_);
+		     &max_addr, __builtin_return_address(0));
 
 	return memblock_alloc_internal(size, align, min_addr, max_addr, nid,
 				       false);
@@ -1557,7 +1557,7 @@ void * __init memblock_alloc_try_nid(
 
 	memblock_dbg("%s: %llu bytes align=0x%llx nid=%d from=%pa max_addr=%pa %pS\n",
 		     __func__, (u64)size, (u64)align, nid, &min_addr,
-		     &max_addr, (void *)_RET_IP_);
+		     &max_addr, __builtin_return_address(0));
 	ptr = memblock_alloc_internal(size, align,
 					   min_addr, max_addr, nid, false);
 	if (ptr)
@@ -1581,7 +1581,7 @@ void __init __memblock_free_late(phys_addr_t base, phys_addr_t size)
 
 	end = base + size - 1;
 	memblock_dbg("%s: [%pa-%pa] %pS\n",
-		     __func__, &base, &end, (void *)_RET_IP_);
+		     __func__, &base, &end, __builtin_return_address(0));
 	kmemleak_free_part_phys(base, size);
 	cursor = PFN_UP(base);
 	end = PFN_DOWN(base + size);
diff --git a/mm/util.c b/mm/util.c
index 821c81717498e..385b232848e47 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -492,7 +492,7 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
 	}
 
 	pr_debug("%s: [%d] caller %ps %c%lu %lu/%lu%s\n", __func__, task->pid,
-		 (void *)_RET_IP_, (inc) ? '+' : '-', pages << PAGE_SHIFT,
+		 __builtin_return_address(0), (inc) ? '+' : '-', pages << PAGE_SHIFT,
 		 locked_vm << PAGE_SHIFT, task_rlimit(task, RLIMIT_MEMLOCK),
 		 ret ? " - exceeded" : "");
 

