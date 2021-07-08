Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750B93BF674
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 09:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhGHHwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 03:52:17 -0400
Received: from 185-125-188-181.canonical.com ([185.125.188.181]:55464 "EHLO
        smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230414AbhGHHwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 03:52:16 -0400
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2021 03:52:16 EDT
Received: from localhost (1.general.khfeng.us.vpn [10.172.68.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0457540234;
        Thu,  8 Jul 2021 07:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1625730164;
        bh=WJypL4AX3mzbnNNbSisSfMPGJ3GrOIMBbT8rfAhh8Ig=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=u8732X29z5Yg1ekKgGupdZiiMBRqim/4LbfZ2IF59R3V9pVOqyVoZDknFo0/PNjX1
         qEdepj1GnOlMg9ZeqxYSXgqNNpDFi9ARSDTF1EupqczwW+zzsLejNT9do7oCVrmo7t
         Av4PcQIJyWsVCOI5JyJCUZtKBZ87RXguO4+cvo/R/I+WbuajhoM1Vn5TGy5L+FvtmB
         3fTm0AeefIY6fH+NGUVHRlPOMCwni/XsT2EPdOXF41gfZ5QmtGUWuWJHcqHFPRq3ki
         fQllST5hoJBTGm3iVEu1srFTBpJC+EdtOc38UFQWmt/10tYelNQCjxpb0GkXpQV0Fb
         sN/2PI/l9I5xg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org (open list:AMD IOMMU (AMD-VI)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iommu/amd: Enable swiotlb if any device supports iommu v2 and uses identity mapping
Date:   Thu,  8 Jul 2021 15:42:32 +0800
Message-Id: <20210708074232.924844-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are seeing kernel panic on rtw88 probe routine because swiotlb isn't
set:
[  252.036773] rtw_8821ce 0000:06:00.0: enabling device (0000 -> 0003)
[  252.037084] Kernel panic - not syncing: Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer
[  252.037146] CPU: 7 PID: 1174 Comm: modprobe Not tainted 5.13.0+ #39
[  252.037175] Hardware name: HP HP ProDesk 405 G6 Small Form Factor PC/8835, BIOS S05 Ver. 02.04.00 06/03/2021
[  252.037218] Call Trace:
[  252.037231]  dump_stack_lvl+0x4a/0x5f
[  252.037251]  dump_stack+0x10/0x12
[  252.037267]  panic+0x101/0x2e3
[  252.037284]  swiotlb_tbl_map_single.cold+0xc/0x73
[  252.037305]  ? __mod_lruvec_page_state+0x95/0xb0
[  252.037329]  ? kmalloc_large_node+0x8c/0xb0
[  252.037348]  ? __netdev_alloc_skb+0x44/0x160
[  252.037370]  swiotlb_map+0x61/0x240
[  252.037387]  ? __alloc_skb+0xed/0x1e0
[  252.037404]  dma_map_page_attrs+0x12c/0x1f0
[  252.037422]  ? __netdev_alloc_skb+0x44/0x160
[  252.037443]  rtw_pci_probe+0x30f/0x872 [rtw88_pci]
[  252.037467]  local_pci_probe+0x48/0x80
[  252.037487]  pci_device_probe+0x105/0x1c0
[  252.037506]  really_probe+0x1fe/0x3f0
[  252.037524]  __driver_probe_device+0x109/0x180
[  252.037545]  driver_probe_device+0x23/0x90
[  252.037564]  __driver_attach+0xac/0x1b0
[  252.037582]  ? __device_attach_driver+0xe0/0xe0
[  252.037602]  bus_for_each_dev+0x7e/0xc0
[  252.037620]  driver_attach+0x1e/0x20
[  252.037637]  bus_add_driver+0x135/0x1f0
[  252.037654]  driver_register+0x95/0xf0
[  252.037672]  ? 0xffffffffc0fa0000
[  252.037687]  __pci_register_driver+0x68/0x70
[  252.037707]  rtw_8821ce_driver_init+0x23/0x1000 [rtw88_8821ce]
[  252.037734]  do_one_initcall+0x48/0x1d0
[  252.037752]  ? __cond_resched+0x1a/0x50
[  252.037771]  ? kmem_cache_alloc_trace+0x29d/0x3c0
[  252.037792]  do_init_module+0x62/0x280
[  252.037810]  load_module+0x2577/0x27c0
[  252.037862]  __do_sys_finit_module+0xbf/0x120
[  252.037877]  __x64_sys_finit_module+0x1a/0x20
[  252.037893]  do_syscall_64+0x3b/0xc0
[  252.037907]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  252.037925] RIP: 0033:0x7ff5a2f9408d
[  252.037938] Code: 27 0d 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ab dd 0c 00 f7 d8 64 89 01 48
[  252.037993] RSP: 002b:00007fffaa89dce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  252.038017] RAX: ffffffffffffffda RBX: 000055fd4f881080 RCX: 00007ff5a2f9408d
[  252.038039] RDX: 0000000000000000 RSI: 000055fd4f63ec02 RDI: 0000000000000009
[  252.038063] RBP: 0000000000040000 R08: 0000000000000000 R09: 000055fd4f8885b0
[  252.038085] R10: 0000000000000009 R11: 0000000000000246 R12: 000055fd4f63ec02
[  252.038107] R13: 000055fd4f881120 R14: 0000000000000000 R15: 000055fd4f88e350
[  252.038293] Kernel Offset: 0x30600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Because the Realtek WiFi (PCI 06:00.0) is in the same IOMMU group as AMD
graphics (PCI 01:00.0),
[    1.326166] pci 0000:01:00.0: Adding to iommu group 0
...
[    1.326268] pci 0000:06:00.0: Adding to iommu group 0

And the AMD graphics supports iommu v2, so the group uses intentity
mapping based on the query from amd_iommu_def_domain_type().

However, the Realtek WiFi doesn't support 64bit DMA, so we need to
enable swiotlb, which was disabled by amd_iommu_init_dma_ops(), to make
remapping work.

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/iommu/amd/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 811a49a95d04..7c5111ed5c97 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -344,6 +344,9 @@ static int iommu_init_device(struct device *dev)
 
 		iommu = amd_iommu_rlookup_table[dev_data->devid];
 		dev_data->iommu_v2 = iommu->is_iommu_v2;
+
+		if (dev_data->iommu_v2)
+			swiotlb = 1;
 	}
 
 	dev_iommu_priv_set(dev, dev_data);
-- 
2.31.1

