Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6578343677
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 03:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhCVCCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 22:02:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14045 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhCVCBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 22:01:41 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F3d320HxyzNpvM;
        Mon, 22 Mar 2021 09:59:10 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Mar 2021 10:01:28 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <yumeng18@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] umem: remove useless 'u64' in 'cpu_to_le64'
Date:   Mon, 22 Mar 2021 09:59:00 +0800
Message-ID: <1616378340-8354-1-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'u64' cast is redundant in 'cpu_to_le64' and coding style fix.

Signed-off-by: Meng Yu <yumeng18@huawei.com>
---
 drivers/block/umem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 982732db..3b21b98 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -380,14 +380,14 @@ static int add_bio(struct cardinfo *card)
 
 	desc->data_dma_handle = dma_handle;
 
-	desc->pci_addr = cpu_to_le64((u64)desc->data_dma_handle);
+	desc->pci_addr = cpu_to_le64(desc->data_dma_handle);
 	desc->local_addr = cpu_to_le64(card->current_iter.bi_sector << 9);
 	desc->transfer_size = cpu_to_le32(vec.bv_len);
 	offset = (((char *)&desc->sem_control_bits) - ((char *)p->desc));
-	desc->sem_addr = cpu_to_le64((u64)(p->page_dma+offset));
+	desc->sem_addr = cpu_to_le64(p->page_dma + offset);
 	desc->zero1 = desc->zero2 = 0;
 	offset = (((char *)(desc+1)) - ((char *)p->desc));
-	desc->next_desc_addr = cpu_to_le64(p->page_dma+offset);
+	desc->next_desc_addr = cpu_to_le64(p->page_dma + offset);
 	desc->control_bits = cpu_to_le32(DMASCR_GO|DMASCR_ERR_INT_EN|
 					 DMASCR_PARITY_INT_EN|
 					 DMASCR_CHAIN_EN |
-- 
2.8.1

