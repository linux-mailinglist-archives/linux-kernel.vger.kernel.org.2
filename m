Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C040D401B00
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242013AbhIFMNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:13:12 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:48099 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241866AbhIFMNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:13:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UnRyn5B_1630930321;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UnRyn5B_1630930321)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Sep 2021 20:12:03 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, cfijalkovich@google.com,
        song@kernel.org, william.kucharski@oracle.com, hughd@google.com
Subject: [PATCH 2/2] mm, thp: bail out early in collapse_file for writeback page
Date:   Mon,  6 Sep 2021 20:12:00 +0800
Message-Id: <20210906121200.57905-3-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently collapse_file does not explicitly check PG_writeback, instead,
page_has_private and try_to_release_page are used to filter writeback
pages. This does not work for xfs with blocksize equal to or larger
than pagesize, because in such case xfs has no page->private.

This makes collapse_file bail out early for writeback page. Otherwise,
xfs end_page_writeback will panic as follows.

[ 6411.448211] page:fffffe00201bcc80 refcount:0 mapcount:0 mapping:ffff0003f88c86a8 index:0x0 pfn:0x84ef32
[ 6411.448304] aops:xfs_address_space_operations [xfs] ino:30000b7 dentry name:"libtest.so"
[ 6411.448312] flags: 0x57fffe0000008027(locked|referenced|uptodate|active|writeback)
[ 6411.448317] raw: 57fffe0000008027 ffff80001b48bc28 ffff80001b48bc28 ffff0003f88c86a8
[ 6411.448321] raw: 0000000000000000 0000000000000000 00000000ffffffff ffff0000c3e9a000
[ 6411.448324] page dumped because: VM_BUG_ON_PAGE(((unsigned int) page_ref_count(page) + 127u <= 127u))
[ 6411.448327] page->mem_cgroup:ffff0000c3e9a000
[ 6411.448340] ------------[ cut here ]------------
[ 6411.448343] kernel BUG at include/linux/mm.h:1212!
[ 6411.449288] Internal error: Oops - BUG: 0 [#1] SMP
[ 6411.449786] Modules linked in:
[ 6411.449790] BUG: Bad page state in process khugepaged  pfn:84ef32
[ 6411.450143]  xfs(E)
[ 6411.450459] page:fffffe00201bcc80 refcount:0 mapcount:0 mapping:0 index:0x0 pfn:0x84ef32
[ 6411.451361]  libcrc32c(E) rfkill(E) aes_ce_blk(E) crypto_simd(E) cryptd(E) aes_ce_cipher(E) crct10dif_ce(E) ghash_ce(E) sha1_ce(E) uio_pdrv_genirq(E) uio(E) vfat(E) nfsd(E) fat(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) sunrpc(E) sch_fq_codel(E) ip_tables(E) ext4(E) mbcache(E) jbd2(E) virtio_net(E) net_failover(E) virtio_blk(E) failover(E) sha2_ce(E) sha256_arm64(E) virtio_mmio(E) virtio_pci(E) virtio_ring(E) virtio(E)
[ 6411.451387] CPU: 25 PID: 0 Comm: swapper/25 Kdump: loaded Tainted: G        W   E
[ 6411.451389] pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=--)
[ 6411.451393] pc : end_page_writeback+0x1c0/0x214
[ 6411.451394] lr : end_page_writeback+0x1c0/0x214
[ 6411.451395] sp : ffff800011ce3cc0
[ 6411.451396] x29: ffff800011ce3cc0 x28: 0000000000000000
[ 6411.451398] x27: ffff000c04608040 x26: 0000000000000000
[ 6411.451399] x25: ffff000c04608040 x24: 0000000000001000
[ 6411.451401] x23: ffff0003f88c8530 x22: 0000000000001000
[ 6411.451403] x21: ffff0003f88c8530 x20: 0000000000000000
[ 6411.451404] x19: fffffe00201bcc80 x18: 0000000000000030
[ 6411.451406] x17: 0000000000000000 x16: 0000000000000000
[ 6411.451407] x15: ffff000c018f9760 x14: ffffffffffffffff
[ 6411.451409] x13: ffff8000119d72b0 x12: ffff8000119d6ee3
[ 6411.451410] x11: ffff8000117b69b8 x10: 00000000ffff8000
[ 6411.451412] x9 : ffff800010617534 x8 : 0000000000000000
[ 6411.451413] x7 : ffff8000114f69b8 x6 : 000000000000000f
[ 6411.451415] x5 : 0000000000000000 x4 : 0000000000000000
[ 6411.451416] x3 : 0000000000000400 x2 : 0000000000000000
[ 6411.451418] x1 : 0000000000000000 x0 : 0000000000000000
[ 6411.451420] Call trace:
[ 6411.451421]  end_page_writeback+0x1c0/0x214
[ 6411.451424]  iomap_finish_page_writeback+0x13c/0x204
[ 6411.451425]  iomap_finish_ioend+0xe8/0x19c
[ 6411.451426]  iomap_writepage_end_bio+0x38/0x50
[ 6411.451427]  bio_endio+0x168/0x1ec
[ 6411.451430]  blk_update_request+0x278/0x3f0
[ 6411.451432]  blk_mq_end_request+0x34/0x15c
[ 6411.451435]  virtblk_request_done+0x38/0x74 [virtio_blk]
[ 6411.451437]  blk_done_softirq+0xc4/0x110
[ 6411.451439]  __do_softirq+0x128/0x38c
[ 6411.451441]  __irq_exit_rcu+0x118/0x150
[ 6411.451442]  irq_exit+0x1c/0x30
[ 6411.451445]  __handle_domain_irq+0x8c/0xf0
[ 6411.451446]  gic_handle_irq+0x84/0x108
[ 6411.451447]  el1_irq+0xcc/0x180
[ 6411.451448]  arch_cpu_idle+0x18/0x40
[ 6411.451450]  default_idle_call+0x4c/0x1a0
[ 6411.451453]  cpuidle_idle_call+0x168/0x1e0
[ 6411.451454]  do_idle+0xb4/0x104
[ 6411.451455]  cpu_startup_entry+0x30/0x9c
[ 6411.451458]  secondary_start_kernel+0x104/0x180
[ 6411.451460] Code: d4210000 b0006161 910c8021 94013f4d (d4210000)
[ 6411.451462] ---[ end trace 4a88c6a074082f8c ]---
[ 6411.451464] Kernel panic - not syncing: Oops - BUG: Fatal exception in interrupt

Fixes: eb6ecbed0aa2 ("mm, thp: relax the VM_DENYWRITE constraint on file-backed THPs")
Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 mm/khugepaged.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 045cc57..529b117 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1798,7 +1798,8 @@ static void collapse_file(struct mm_struct *mm,
 			goto out_unlock;
 		}
 
-		if (!is_shmem && PageDirty(page)) {
+		if (!is_shmem && (PageDirty(page) ||
+				  PageWriteback(page))) {
 			/*
 			 * khugepaged only works on read-only fd, so this
 			 * page is dirty because it hasn't been flushed
-- 
1.8.3.1

