Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47BA39118C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 09:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhEZHyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 03:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231827AbhEZHyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 03:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622015561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ISZz2zFr6MxS7eFGxZBM15RS5zU31KCHMybXhRPLW5g=;
        b=VUc1DT1TXj//ejCU3/fHdD8wb9j4P6Cys2Txs4iCxw5QSMeJkea2oFe0ly7QWUdXG5gwZ2
        9btxarlCVVcih58gKc1A6ro2BVtMHhIK5Lxk8gVPlCJbkAC8e6xUGnN3FfwsNWPHx7SUcF
        yYVlxxlufQpHIImA0m1Vx1OaNV9kllI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-kizSCE5bMkGYeIqjYjI3XA-1; Wed, 26 May 2021 03:52:37 -0400
X-MC-Unique: kizSCE5bMkGYeIqjYjI3XA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABCD480ED8E;
        Wed, 26 May 2021 07:52:35 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-99.ams2.redhat.com [10.36.113.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE5AE5C1D0;
        Wed, 26 May 2021 07:52:27 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v1] drivers/base/memory: fix trying offlining memory blocks with memory holes on aarch64
Date:   Wed, 26 May 2021 09:52:26 +0200
Message-Id: <20210526075226.5572-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

offline_pages() properly checks for memory holes and bails out. However,
we do a page_zone(pfn_to_page(start_pfn)) before calling offline_pages()
when offlining a memory block. We should not unconditionally call
page_zone(pfn_to_page(start_pfn)) on aarch64 in offlining code, otherwise
we can trigger a BUG when hitting a memory hole:

[  162.327720][ T1694] kernel BUG at include/linux/mm.h:1383!
[  162.333695][ T1694] Internal error: Oops - BUG: 0 [#1] SMP
[  162.339181][ T1694] Modules linked in: loop processor efivarfs ip_tables x_tables ext4 mbcache jbd2 dm_mod igb nvme i2c_algo_bit mlx5_core i2c_core nvme_core firmware_class
[  162.354604][ T1694] CPU: 13 PID: 1694 Comm: ranbug Not tainted 5.12.0-next-20210524+ #4
[  162.362601][ T1694] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
[  162.371116][ T1694] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[  162.377811][ T1694] pc : memory_subsys_offline+0x1f8/0x250
[  162.383295][ T1694] lr : memory_subsys_offline+0x1f8/0x250
[  162.388773][ T1694] sp : ffff80002458f8e0
[  162.392773][ T1694] x29: ffff80002458f8e0 x28: ffff800010914d30 x27: 0000000000000000
[  162.400602][ T1694] x26: 0000000000002000 x25: 1fffe00002550401 x24: ffff000012a82008
[  162.408431][ T1694] x23: fffffc0000000000 x22: 0000000000008000 x21: 0000000000000001
[  162.416259][ T1694] x20: ffffffffffffffff x19: ffff000012a82018 x18: ffff0008527b6a70
[  162.424086][ T1694] x17: 0000000000000000 x16: 0000000000000007 x15: 00000000000000c8
[  162.431914][ T1694] x14: 0000000000000000 x13: ffff800011c6eea4 x12: ffff60136ceb8574
[  162.439742][ T1694] x11: 1fffe0136ceb8573 x10: ffff60136ceb8573 x9 : dfff800000000000
[  162.447570][ T1694] x8 : ffff009b675c2b9b x7 : 0000000000000001 x6 : ffff009b675c2b98
[  162.455398][ T1694] x5 : 00009fec93147a8d x4 : ffff009b675c2b98 x3 : 1fffe0010a4f6c09
[  162.463226][ T1694] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000034
[  162.471054][ T1694] Call trace:
[  162.474186][ T1694]  memory_subsys_offline+0x1f8/0x250
[  162.479318][ T1694]  device_offline+0x154/0x1d8
[  162.483844][ T1694]  online_store+0xa4/0x118
[  162.488107][ T1694]  dev_attr_store+0x44/0x78
[  162.492457][ T1694]  sysfs_kf_write+0xe8/0x138
[  162.496896][ T1694]  kernfs_fop_write_iter+0x26c/0x3d0
[  162.502028][ T1694]  new_sync_write+0x2bc/0x4f8
[  162.506552][ T1694]  vfs_write+0x718/0xc88
[  162.510643][ T1694]  ksys_write+0xf8/0x1e0
[  162.514732][ T1694]  __arm64_sys_write+0x74/0xa8
[  162.519342][ T1694]  invoke_syscall.constprop.0+0x78/0x1e8
[  162.524824][ T1694]  do_el0_svc+0xe4/0x298
[  162.528914][ T1694]  el0_svc+0x20/0x30
[  162.532658][ T1694]  el0_sync_handler+0xb0/0xb8
[  162.537181][ T1694]  el0_sync+0x178/0x180
[  162.541187][ T1694] Code: f00033e1 91318021 91090021 97e38d8b (d4210000)
[  162.547968][ T1694] ---[ end trace 2a1964462a219f20 ]---
[  162.553273][ T1694] Kernel panic - not syncing: Oops - BUG: Fatal exception
[  162.560250][ T1694] SMP: stopping secondary CPUs
[  162.564871][ T1694] Kernel Offset: disabled
[  162.569045][ T1694] CPU features: 0x00000251,20000846
[  162.574089][ T1694] Memory Limit: none
[  162.577849][ T1694] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---

If nr_vmemmap_pages is set, we know that we are dealing with hotplugged
memory that doesn't have any holes. So call
page_zone(pfn_to_page(start_pfn)) only when really necessary -- when
nr_vmemmap_pages is set and we actually adjust the present pages.

Fixes: a08a2ae34613 ("mm,memory_hotplug: allocate memmap from the added memory range")
Reported-by: Qian Cai (QUIC) <quic_qiancai@quicinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index b31b3af5c490..d5ffaab3cb61 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -218,14 +218,14 @@ static int memory_block_offline(struct memory_block *mem)
 	struct zone *zone;
 	int ret;
 
-	zone = page_zone(pfn_to_page(start_pfn));
-
 	/*
 	 * Unaccount before offlining, such that unpopulated zone and kthreads
 	 * can properly be torn down in offline_pages().
 	 */
-	if (nr_vmemmap_pages)
+	if (nr_vmemmap_pages) {
+		zone = page_zone(pfn_to_page(start_pfn));
 		adjust_present_page_count(zone, -nr_vmemmap_pages);
+	}
 
 	ret = offline_pages(start_pfn + nr_vmemmap_pages,
 			    nr_pages - nr_vmemmap_pages);
-- 
2.31.1

