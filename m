Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60933B1979
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 13:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFWMBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:01:05 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:42862 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230379AbhFWMBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:01:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UdQGmKd_1624449521;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0UdQGmKd_1624449521)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Jun 2021 19:58:44 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     david@redhat.com, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawater@antfin.com>
Subject: [RFC] virtio-mem: Add support of memory_hotplug.memmap_on_memory
Date:   Wed, 23 Jun 2021 19:58:39 +0800
Message-Id: <20210623115839.3524-1-teawater@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Zhu <teawater@antfin.com>

We did some virtio-mem resize tests in high memory pressure environment.
Memory increases slowly and sometimes fails in these tests.
This is a way to reproduce the issue.
Start a qemu with a small size of memory (132Mb) and resize the
virtio-mem to hotplug memory.
Then will get following error:
[    8.097461] virtio_mem virtio0: requested size: 0x10000000
[    8.098038] virtio_mem virtio0: plugging memory: 0x100000000 -
0x107ffffff
[    8.098829] virtio_mem virtio0: adding memory: 0x100000000 -
0x107ffffff
[    8.106298] kworker/0:1: vmemmap alloc failure: order:9,
mode:0x4cc0(GFP_KERNEL|__GFP_RETRY_MAYFAIL),
nodemask=(null),cpuset=/,mems_allowed=0
[    8.107609] CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 5.13.0-rc7+
[    8.108295] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[    8.109476] Workqueue: events_freezable virtio_mem_run_wq
[    8.110039] Call Trace:
[    8.110305]  dump_stack+0x76/0x94
[    8.110654]  warn_alloc.cold+0x7b/0xdf
[    8.111054]  ? __alloc_pages+0x2c2/0x310
[    8.111462]  vmemmap_alloc_block+0x86/0xdc
[    8.111891]  vmemmap_populate+0xfc/0x325
[    8.112309]  __populate_section_memmap+0x38/0x4e
[    8.112787]  sparse_add_section+0x167/0x244
[    8.113226]  __add_pages+0xa6/0x130
[    8.113592]  add_pages+0x12/0x60
[    8.113934]  add_memory_resource+0x114/0x2d0
[    8.114377]  add_memory_driver_managed+0x7c/0xc0
[    8.114852]  virtio_mem_add_memory+0x57/0xe0
[    8.115304]  virtio_mem_sbm_plug_and_add_mb+0x9a/0x130
[    8.115833]  virtio_mem_run_wq+0x9d5/0x1100
I think allocating 2 Mb contiguous memory will be slow and failed
in some cases, especially in high memory pressure environment.
This commit try to add support of memory_hotplug.memmap_on_memory to
handle this issue.

Just let SBM mode support it because memory_hotplug.memmap_on_memory
need a single memory block.

Add nr_vmemmap_pages and sbs_vmemmap to struct sbm.
If memory_hotplug.memmap_on_memory is open, pages number of a memory
block's internal metadata will be store in nr_vmemmap_pages.
sbs_vmemmap is the number of vmemmap subblocks per Linux memory block.
The pages in the vmemmap subblocks should bigger than nr_vmemmap_pages
because sb_size need to span at least MAX_ORDER_NR_PAGES and
pageblock_nr_pages pages (virtio_mem_init).
All the pages in vmemmap subblocks is not going to add to the buddy
even if the pages that are not used to store the internal metadata
(struct pages) because they should not work reliably with
alloc_contig_range().

When resize virtio-mem, sbs_vmemmap is going to count in
virtio_mem_sbm_plug_and_add_mb, virtio_mem_sbm_unplug_any_sb_offline
and virtio_mem_sbm_unplug_any_sb_online.
Because internal metadata also need the real pages in the host to store
it.  I think resize virtio-mem size same with the actual memory
footprint
on the host is better if we want setup a memory cgroup for QEMU.

I did not add special module_param for this function and did not move
code
inside CONFIG_MHP_MEMMAP_ON_MEMORY.
Do I need add them?

Thanks for help from David Hildenbrand about this RFC.

Signed-off-by: Hui Zhu <teawater@antfin.com>
---
 drivers/virtio/virtio_mem.c | 210 ++++++++++++++++++++++++++++++------
 1 file changed, 180 insertions(+), 30 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 10ec60d81e84..5716ea656cd8 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -189,6 +189,38 @@ struct virtio_mem {
 			 * in one 4 KiB page.
 			 */
 			unsigned long *sb_states;
+
+			/*
+			 * If nr_vmemmap_pages is not 0, current virtio-mem
+			 * device allocate its internal metadata (struct pages)
+			 * from the hotadded memory.
+			 * See memory_hotplug.memmap_on_memory to get
+			 * more detailed info.
+			 *
+			 * nr_vmemmap_pages is the vmemmap pages number of
+			 * current device.
+			 */
+			unsigned long nr_vmemmap_pages;
+
+			/*
+			 * The number of vmemmap subblocks per Linux memory
+			 * block.
+			 *
+			 * The first sb_id of the Linux memory block that
+			 * can add to the buddy.
+			 *
+			 * The pages in the vmemmap subblocks should bigger
+			 * than nr_vmemmap_pages because sb_size need to
+			 * span at least MAX_ORDER_NR_PAGES and
+			 * pageblock_nr_pages pages (virtio_mem_init).
+			 *
+			 * All the pages in vmemmap subblocks is not going to
+			 * add to the buddy even if the pages that are not
+			 * used to store the internal metadata (struct pages)
+			 * because they should not work reliably with
+			 * alloc_contig_range().
+			 */
+			uint32_t sbs_vmemmap;
 		} sbm;
 
 		struct {
@@ -545,10 +577,13 @@ static bool virtio_mem_sbm_test_sb_unplugged(struct virtio_mem *vm,
 static int virtio_mem_sbm_first_unplugged_sb(struct virtio_mem *vm,
 					    unsigned long mb_id)
 {
-	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, 0);
+	const int bit =
+		virtio_mem_sbm_sb_state_bit_nr(vm, mb_id,
+					       vm->sbm.sbs_vmemmap);
 
 	return find_next_zero_bit(vm->sbm.sb_states,
-				  bit + vm->sbm.sbs_per_mb, bit) - bit;
+				  bit + vm->sbm.sbs_per_mb, bit) - bit +
+	       vm->sbm.sbs_vmemmap;
 }
 
 /*
@@ -603,9 +638,10 @@ static bool virtio_mem_could_add_memory(struct virtio_mem *vm, uint64_t size)
  * Will not modify the state of memory blocks in virtio-mem.
  */
 static int virtio_mem_add_memory(struct virtio_mem *vm, uint64_t addr,
-				 uint64_t size)
+				 uint64_t size, bool memmap_on_memory)
 {
 	int rc;
+	mhp_t mhp_flags = MHP_MERGE_RESOURCE;
 
 	/*
 	 * When force-unloading the driver and we still have memory added to
@@ -622,8 +658,10 @@ static int virtio_mem_add_memory(struct virtio_mem *vm, uint64_t addr,
 		addr + size - 1);
 	/* Memory might get onlined immediately. */
 	atomic64_add(size, &vm->offline_size);
+	if (memmap_on_memory)
+		mhp_flags |= MHP_MEMMAP_ON_MEMORY;
 	rc = add_memory_driver_managed(vm->nid, addr, size, vm->resource_name,
-				       MHP_MERGE_RESOURCE);
+				       mhp_flags);
 	if (rc) {
 		atomic64_sub(size, &vm->offline_size);
 		dev_warn(&vm->vdev->dev, "adding memory failed: %d\n", rc);
@@ -643,7 +681,8 @@ static int virtio_mem_sbm_add_mb(struct virtio_mem *vm, unsigned long mb_id)
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
 	const uint64_t size = memory_block_size_bytes();
 
-	return virtio_mem_add_memory(vm, addr, size);
+	return virtio_mem_add_memory(vm, addr, size,
+				     vm->sbm.sbs_vmemmap > 0);
 }
 
 /*
@@ -654,7 +693,7 @@ static int virtio_mem_bbm_add_bb(struct virtio_mem *vm, unsigned long bb_id)
 	const uint64_t addr = virtio_mem_bb_id_to_phys(vm, bb_id);
 	const uint64_t size = vm->bbm.bb_size;
 
-	return virtio_mem_add_memory(vm, addr, size);
+	return virtio_mem_add_memory(vm, addr, size, false);
 }
 
 /*
@@ -871,7 +910,23 @@ static void virtio_mem_sbm_notify_going_offline(struct virtio_mem *vm,
 	unsigned long pfn;
 	int sb_id;
 
-	for (sb_id = 0; sb_id < vm->sbm.sbs_per_mb; sb_id++) {
+	if (vm->sbm.sbs_vmemmap) {
+		unsigned long other_pages
+				= vm->sbm.sbs_vmemmap * nr_pages -
+				  vm->sbm.nr_vmemmap_pages;
+
+		if (other_pages) {
+			unsigned long other_pfn
+				= PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id)) +
+				  vm->sbm.nr_vmemmap_pages;
+
+			virtio_mem_fake_offline_going_offline(other_pfn,
+							      other_pages);
+		}
+	}
+
+	for (sb_id = vm->sbm.sbs_vmemmap;
+	     sb_id < vm->sbm.sbs_per_mb; sb_id++) {
 		if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
 			continue;
 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
@@ -887,7 +942,23 @@ static void virtio_mem_sbm_notify_cancel_offline(struct virtio_mem *vm,
 	unsigned long pfn;
 	int sb_id;
 
-	for (sb_id = 0; sb_id < vm->sbm.sbs_per_mb; sb_id++) {
+	if (vm->sbm.sbs_vmemmap) {
+		unsigned long other_pages
+				= vm->sbm.sbs_vmemmap * nr_pages -
+				  vm->sbm.nr_vmemmap_pages;
+
+		if (other_pages) {
+			unsigned long other_pfn
+				= PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id)) +
+				  vm->sbm.nr_vmemmap_pages;
+
+			virtio_mem_fake_offline_cancel_offline(other_pfn,
+							       other_pages);
+		}
+	}
+
+	for (sb_id = vm->sbm.sbs_vmemmap;
+	     sb_id < vm->sbm.sbs_per_mb; sb_id++) {
 		if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
 			continue;
 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
@@ -933,8 +1004,8 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 	struct virtio_mem *vm = container_of(nb, struct virtio_mem,
 					     memory_notifier);
 	struct memory_notify *mhp = arg;
-	const unsigned long start = PFN_PHYS(mhp->start_pfn);
-	const unsigned long size = PFN_PHYS(mhp->nr_pages);
+	unsigned long start = PFN_PHYS(mhp->start_pfn);
+	unsigned long size = PFN_PHYS(mhp->nr_pages);
 	int rc = NOTIFY_OK;
 	unsigned long id;
 
@@ -942,6 +1013,13 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	if (vm->in_sbm) {
+		if (vm->sbm.nr_vmemmap_pages) {
+			unsigned long vmemmap_size = vm->sbm.nr_vmemmap_pages;
+
+			vmemmap_size <<= PAGE_SHIFT;
+			start -= vmemmap_size;
+			size += vmemmap_size;
+		}
 		id = virtio_mem_phys_to_mb_id(start);
 		/*
 		 * In SBM, we add memory in separate memory blocks - we expect
@@ -1227,7 +1305,10 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
 			 */
 			id = virtio_mem_phys_to_mb_id(addr);
 			sb_id = virtio_mem_phys_to_sb_id(vm, addr);
-			do_online = virtio_mem_sbm_test_sb_plugged(vm, id,
+			if (sb_id < vm->sbm.sbs_vmemmap)
+				do_online = false;
+			else
+				do_online = virtio_mem_sbm_test_sb_plugged(vm, id,
 								   sb_id, 1);
 		} else {
 			/*
@@ -1462,14 +1543,14 @@ static int virtio_mem_sbm_unplug_any_sb(struct virtio_mem *vm,
 	sb_id = vm->sbm.sbs_per_mb - 1;
 	while (*nb_sb) {
 		/* Find the next candidate subblock */
-		while (sb_id >= 0 &&
+		while (sb_id >= vm->sbm.sbs_vmemmap &&
 		       virtio_mem_sbm_test_sb_unplugged(vm, mb_id, sb_id, 1))
 			sb_id--;
-		if (sb_id < 0)
+		if (sb_id < vm->sbm.sbs_vmemmap)
 			break;
 		/* Try to unplug multiple subblocks at a time */
 		count = 1;
-		while (count < *nb_sb && sb_id > 0 &&
+		while (count < *nb_sb && sb_id > vm->sbm.sbs_vmemmap &&
 		       virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id - 1, 1)) {
 			count++;
 			sb_id--;
@@ -1494,7 +1575,7 @@ static int virtio_mem_sbm_unplug_any_sb(struct virtio_mem *vm,
  */
 static int virtio_mem_sbm_unplug_mb(struct virtio_mem *vm, unsigned long mb_id)
 {
-	uint64_t nb_sb = vm->sbm.sbs_per_mb;
+	uint64_t nb_sb = vm->sbm.sbs_per_mb - vm->sbm.sbs_vmemmap;
 
 	return virtio_mem_sbm_unplug_any_sb(vm, mb_id, &nb_sb);
 }
@@ -1534,12 +1615,15 @@ static int virtio_mem_sbm_prepare_next_mb(struct virtio_mem *vm,
 static int virtio_mem_sbm_plug_and_add_mb(struct virtio_mem *vm,
 					  unsigned long mb_id, uint64_t *nb_sb)
 {
-	const int count = min_t(int, *nb_sb, vm->sbm.sbs_per_mb);
+	int count = min_t(int, *nb_sb, vm->sbm.sbs_per_mb);
 	int rc;
 
 	if (WARN_ON_ONCE(!count))
 		return -EINVAL;
 
+	if (vm->sbm.sbs_vmemmap)
+		count = max_t(int, count, vm->sbm.sbs_vmemmap);
+
 	/*
 	 * Plug the requested number of subblocks before adding it to linux,
 	 * so that onlining will directly online all plugged subblocks.
@@ -1570,7 +1654,10 @@ static int virtio_mem_sbm_plug_and_add_mb(struct virtio_mem *vm,
 		return rc;
 	}
 
-	*nb_sb -= count;
+	if (*nb_sb >= count)
+		*nb_sb -= count;
+	else
+		*nb_sb = 0;
 	return 0;
 }
 
@@ -1617,7 +1704,10 @@ static int virtio_mem_sbm_plug_any_sb(struct virtio_mem *vm,
 		virtio_mem_fake_online(pfn, nr_pages);
 	}
 
-	if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
+	if (virtio_mem_sbm_test_sb_plugged(vm, mb_id,
+					   vm->sbm.sbs_vmemmap,
+					   vm->sbm.sbs_per_mb -
+					   vm->sbm.sbs_vmemmap)) {
 		if (online)
 			virtio_mem_sbm_set_mb_state(vm, mb_id,
 						    VIRTIO_MEM_SBM_MB_ONLINE);
@@ -1820,13 +1910,17 @@ static int virtio_mem_sbm_unplug_any_sb_offline(struct virtio_mem *vm,
 	rc = virtio_mem_sbm_unplug_any_sb(vm, mb_id, nb_sb);
 
 	/* some subblocks might have been unplugged even on failure */
-	if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->sbm.sbs_per_mb))
+	if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, vm->sbm.sbs_vmemmap,
+					    vm->sbm.sbs_per_mb -
+					    vm->sbm.sbs_vmemmap))
 		virtio_mem_sbm_set_mb_state(vm, mb_id,
 					    VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL);
 	if (rc)
 		return rc;
 
-	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
+	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, vm->sbm.sbs_vmemmap,
+					     vm->sbm.sbs_per_mb -
+					     vm->sbm.sbs_vmemmap)) {
 		/*
 		 * Remove the block from Linux - this should never fail.
 		 * Hinder the block from getting onlined by marking it
@@ -1840,6 +1934,23 @@ static int virtio_mem_sbm_unplug_any_sb_offline(struct virtio_mem *vm,
 		rc = virtio_mem_sbm_remove_mb(vm, mb_id);
 		BUG_ON(rc);
 		mutex_lock(&vm->hotplug_mutex);
+
+		/* Remove vmemmap pages. */
+		if (vm->sbm.sbs_vmemmap) {
+			rc = virtio_mem_sbm_unplug_sb(vm, mb_id, 0,
+						      vm->sbm.sbs_vmemmap);
+			/*
+			 * Just warn because this error will
+			 * not affect next plug.
+			 */
+			WARN_ON(rc);
+			if (!rc) {
+				if (*nb_sb >= vm->sbm.sbs_vmemmap)
+					*nb_sb -= vm->sbm.sbs_vmemmap;
+				else
+					*nb_sb = 0;
+			}
+		}
 	}
 	return 0;
 }
@@ -1894,19 +2005,24 @@ static int virtio_mem_sbm_unplug_any_sb_online(struct virtio_mem *vm,
 	int rc, sb_id;
 
 	/* If possible, try to unplug the complete block in one shot. */
-	if (*nb_sb >= vm->sbm.sbs_per_mb &&
-	    virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
-		rc = virtio_mem_sbm_unplug_sb_online(vm, mb_id, 0,
-						     vm->sbm.sbs_per_mb);
+	if (*nb_sb >= (vm->sbm.sbs_per_mb - vm->sbm.sbs_vmemmap) &&
+	    virtio_mem_sbm_test_sb_plugged(vm, mb_id, vm->sbm.sbs_vmemmap,
+					   vm->sbm.sbs_per_mb -
+					   vm->sbm.sbs_vmemmap)) {
+		rc = virtio_mem_sbm_unplug_sb_online(vm, mb_id,
+						     vm->sbm.sbs_vmemmap,
+						     vm->sbm.sbs_per_mb -
+						     vm->sbm.sbs_vmemmap);
 		if (!rc) {
-			*nb_sb -= vm->sbm.sbs_per_mb;
+			*nb_sb -= (vm->sbm.sbs_per_mb - vm->sbm.sbs_vmemmap);
 			goto unplugged;
 		} else if (rc != -EBUSY)
 			return rc;
 	}
 
 	/* Fallback to single subblocks. */
-	for (sb_id = vm->sbm.sbs_per_mb - 1; sb_id >= 0 && *nb_sb; sb_id--) {
+	for (sb_id = vm->sbm.sbs_per_mb - 1;
+	     sb_id >= vm->sbm.sbs_vmemmap && *nb_sb; sb_id--) {
 		/* Find the next candidate subblock */
 		while (sb_id >= 0 &&
 		       !virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
@@ -1928,13 +2044,31 @@ static int virtio_mem_sbm_unplug_any_sb_online(struct virtio_mem *vm,
 	 * remove it. This will usually not fail, as no memory is in use
 	 * anymore - however some other notifiers might NACK the request.
 	 */
-	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
+	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, vm->sbm.sbs_vmemmap,
+				vm->sbm.sbs_per_mb - vm->sbm.sbs_vmemmap)) {
 		mutex_unlock(&vm->hotplug_mutex);
 		rc = virtio_mem_sbm_offline_and_remove_mb(vm, mb_id);
 		mutex_lock(&vm->hotplug_mutex);
-		if (!rc)
+		if (!rc) {
 			virtio_mem_sbm_set_mb_state(vm, mb_id,
 						    VIRTIO_MEM_SBM_MB_UNUSED);
+			/* Remove vmemmap pages. */
+			if (vm->sbm.sbs_vmemmap) {
+				rc = virtio_mem_sbm_unplug_sb(vm, mb_id, 0,
+							vm->sbm.sbs_vmemmap);
+				/*
+				 * Just warn because this error will
+				 * not affect next plug.
+				 */
+				WARN_ON(rc);
+				if (!rc) {
+					if (*nb_sb >= vm->sbm.sbs_vmemmap)
+						*nb_sb -= vm->sbm.sbs_vmemmap;
+					else
+						*nb_sb = 0;
+				}
+			}
+		}
 	}
 
 	return 0;
@@ -2444,6 +2578,15 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		       memory_block_size_bytes() - 1;
 		vm->sbm.first_mb_id = virtio_mem_phys_to_mb_id(addr);
 		vm->sbm.next_mb_id = vm->sbm.first_mb_id;
+		if (mhp_supports_memmap_on_memory(memory_block_size_bytes())) {
+			vm->sbm.nr_vmemmap_pages
+				= PFN_DOWN(PFN_DOWN(memory_block_size_bytes()) *
+					   sizeof(struct page));
+			vm->sbm.sbs_vmemmap
+				= ALIGN(PFN_PHYS(vm->sbm.nr_vmemmap_pages),
+					vm->sbm.sb_size) /
+				  vm->sbm.sb_size;
+		}
 	} else {
 		/* BBM: At least one Linux memory block. */
 		vm->bbm.bb_size = max_t(uint64_t, vm->device_block_size,
@@ -2481,10 +2624,17 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		 (unsigned long long)vm->device_block_size);
 	dev_info(&vm->vdev->dev, "memory block size: 0x%lx",
 		 memory_block_size_bytes());
-	if (vm->in_sbm)
+	if (vm->in_sbm) {
 		dev_info(&vm->vdev->dev, "subblock size: 0x%llx",
 			 (unsigned long long)vm->sbm.sb_size);
-	else
+		if (vm->sbm.sbs_vmemmap) {
+			dev_info(&vm->vdev->dev, "nr vmemmap pages: %lu",
+				 vm->sbm.nr_vmemmap_pages);
+			dev_info(&vm->vdev->dev,
+		"The number of vmemmap subblocks per Linux memory block: %u",
+				 vm->sbm.sbs_vmemmap);
+		}
+	} else
 		dev_info(&vm->vdev->dev, "big block size: 0x%llx",
 			 (unsigned long long)vm->bbm.bb_size);
 	if (vm->nid != NUMA_NO_NODE && IS_ENABLED(CONFIG_NUMA))
-- 
2.17.1

