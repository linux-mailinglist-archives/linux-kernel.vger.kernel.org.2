Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848A53598A3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhDIJHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:07:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16872 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhDIJHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:07:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGsf457yhzlWy6;
        Fri,  9 Apr 2021 17:05:00 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:06:38 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yekai13@huawei.com>
Subject: [PATCH v3 2/5] crypto: hisilicon/sgl - delete unneeded variable initialization
Date:   Fri, 9 Apr 2021 17:04:01 +0800
Message-ID: <1617959044-11023-3-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617959044-11023-1-git-send-email-yekai13@huawei.com>
References: <1617959044-11023-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete unneeded variable initialization

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sgl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index cf1629c..b8a811f 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -56,7 +56,7 @@ struct hisi_acc_sgl_pool {
 struct hisi_acc_sgl_pool *hisi_acc_create_sgl_pool(struct device *dev,
 						   u32 count, u32 sge_nr)
 {
-	u32 sgl_size, block_size, sgl_num_per_block, block_num, remain_sgl = 0;
+	u32 sgl_size, block_size, sgl_num_per_block, block_num, remain_sgl;
 	struct hisi_acc_sgl_pool *pool;
 	struct mem_block *block;
 	u32 i, j;
-- 
2.8.1

