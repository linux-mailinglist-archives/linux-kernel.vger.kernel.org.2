Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E2A34E278
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhC3HmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:42:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15098 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhC3Hlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:41:50 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8hDG3QpBz19Jcq;
        Tue, 30 Mar 2021 15:39:42 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 15:41:37 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v2 4/5] crypto: hisilicon/sgl - fix the soft sg map to hardware sg
Date:   Tue, 30 Mar 2021 15:39:05 +0800
Message-ID: <1617089946-48078-5-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617089946-48078-1-git-send-email-yekai13@huawei.com>
References: <1617089946-48078-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer of the hardware sge needs to be initialized by
soft sgl.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sgl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index 4bece3d..c618aaf 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -173,6 +173,7 @@ static void sg_map_to_hw_sg(struct scatterlist *sgl,
 {
 	hw_sge->buf = sg_dma_address(sgl);
 	hw_sge->len = cpu_to_le32(sg_dma_len(sgl));
+	hw_sge->page_ctrl = sg_virt(sgl);
 }
 
 static void inc_hw_sgl_sge(struct hisi_acc_hw_sgl *hw_sgl)
-- 
2.8.1

