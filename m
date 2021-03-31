Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C6434FCF0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhCaJd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:33:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15056 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbhCaJdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:33:11 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9Ldf5RyfzNrJT;
        Wed, 31 Mar 2021 17:30:30 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Wed, 31 Mar 2021
 17:33:01 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v2 1/5] crypto: hisilicon/sgl - add a comment for block size initialization
Date:   Wed, 31 Mar 2021 17:30:28 +0800
Message-ID: <1617183032-30983-2-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617183032-30983-1-git-send-email-yekai13@huawei.com>
References: <1617183032-30983-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems "32" and "31" is obfuscating, It might be better to add a
comment, which explain it.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sgl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index 3bff639..cf1629c 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -66,6 +66,11 @@ struct hisi_acc_sgl_pool *hisi_acc_create_sgl_pool(struct device *dev,
 
 	sgl_size = sizeof(struct acc_hw_sge) * sge_nr +
 		   sizeof(struct hisi_acc_hw_sgl);
+
+	/*
+	 * the pool may allocate a block of memory of size PAGE_SIZE * 2^(MAX_ORDER - 1),
+	 * block size may exceed 2^31 on ia64, so the max of block size is 2^31
+	 */
 	block_size = 1 << (PAGE_SHIFT + MAX_ORDER <= 32 ?
 			   PAGE_SHIFT + MAX_ORDER - 1 : 31);
 	sgl_num_per_block = block_size / sgl_size;
-- 
2.8.1

