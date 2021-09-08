Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3063340342A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 08:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbhIHGSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 02:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347723AbhIHGR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 02:17:57 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB02C0617AD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 23:16:48 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id k24so1469988pgh.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 23:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Zq8fGof5d5XpqmYAb98Vp/W3flQC31yfyIUWvsR98c=;
        b=aDAu4A48OaIPTP8xEFp/xpRQhKH6QHQlnNrv3efDTAuMK956e2ZgjnBAJapHZt+pIM
         8MgyUAL47JWud6NyVOp5t/+TuiQ5SoNeRsRSL2rAEIKfM1L7n9aGl6LruJk5W5rN8CCO
         lGCCfbXyBzEdbhKQkikyRySFyqLl2P484Rv0RtC7lJogVDYS56S5pgoWtNNOWlItpipu
         q/ZcfzmjtOK7XeqvVchD8D3cdzm+JjF9EKmF3i9gaoQ4JY6q/zLCPmI1dNAuKnoXbsZA
         MNWxJe+riqHX6D3z4jehAEFZ4iMayvyeJINbLksuFuBN7yVdulFfPQ0rae8XjmVKNZTs
         e4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Zq8fGof5d5XpqmYAb98Vp/W3flQC31yfyIUWvsR98c=;
        b=H5vL2hxBs0VBnKQN78WNi8L/eey+RqYs6WvtfC8a/SaPN4SdUOecOy5iH1I6S4mEHo
         UmJj+NMAAsoe0mq+3PaudTCK7R2i6hSdY7xI8XsuUUOB1XA8KPARfrFnIDPzbn9dpL9o
         7hwQW+KKXbJt06WQ0I6fHLYFNNlSNRozO0pVAHT4YYL48obWu7yvcESd+HHrOlNdFTJU
         Nuze/71qEXzwsi8venf0KyO1BYLRIDMS19y8RNj2qD5dXo3bgCtPNVdS3gP4PKLUXldc
         ImXurSpRu89eBr3IB0MrTDCj5gCezH8CEHCDkuJl8+ibgTbTw746msPaDcsk6VlKnY6U
         +LBA==
X-Gm-Message-State: AOAM530/f6M5g4qSjQHzmMcHewUxav6rEDLQjoZxpRlW9+Yx15H8eOsn
        fpxXoGB9Fmc7Yv99hxv8DeofceG8VX2KlVqz
X-Google-Smtp-Source: ABdhPJzl+ip5khG2YokF65Zp4NGm+UqQwxxCrFDdLROE1DhaI6KBrmPLrPm97STLst878c0bpCeSKQ==
X-Received: by 2002:a63:dd56:: with SMTP id g22mr2146469pgj.38.1631081807993;
        Tue, 07 Sep 2021 23:16:47 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id n1sm971730pfv.209.2021.09.07.23.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 23:16:47 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Shunsuke Mie <mie@igel.co.jp>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        dhobsong@igel.co.jp, taki@igel.co.jp, etom@igel.co.jp
Subject: [RFC PATCH 2/3] RDMA/rxe: Extract a mapping process into a function
Date:   Wed,  8 Sep 2021 15:16:10 +0900
Message-Id: <20210908061611.69823-3-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908061611.69823-1-mie@igel.co.jp>
References: <20210908061611.69823-1-mie@igel.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functionization of the process to generate the memory map. The function
generates maps from scatterlists to a list of page aligned addresses.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 89 ++++++++++++++++++------------
 1 file changed, 54 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index be4bcb420fab..8b08705ed62a 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -103,15 +103,59 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
 	mr->type = RXE_MR_TYPE_DMA;
 }
 
+/* generate a rxe memory map data structure from ib_umem */
+static int rxe_mr_gen_map(struct rxe_mr *mr, struct ib_umem *umem)
+{
+	int err;
+	int num_buf;
+	struct rxe_map **map;
+	struct rxe_phys_buf *buf = NULL;
+	struct sg_page_iter sg_iter;
+	void *vaddr;
+
+	num_buf = 0;
+	map = mr->map;
+	if (mr->length > 0) {
+		buf = map[0]->buf;
+
+		for_each_sg_page(umem->sg_head.sgl, &sg_iter, umem->nmap, 0) {
+			if (num_buf >= RXE_BUF_PER_MAP) {
+				map++;
+				buf = map[0]->buf;
+				num_buf = 0;
+			}
+
+			vaddr = page_address(sg_page_iter_page(&sg_iter));
+			if (!vaddr) {
+				pr_warn("%s: Unable to get virtual address", __func__);
+				err = -ENOMEM;
+				goto err1;
+			}
+
+			buf->addr = (uintptr_t)vaddr;
+			buf->size = PAGE_SIZE;
+			num_buf++;
+			buf++;
+		}
+	}
+
+	mr->umem = umem;
+	mr->offset = ib_umem_offset(umem);
+	mr->state = RXE_MR_STATE_VALID;
+	mr->type = RXE_MR_TYPE_MR;
+
+	return 0;
+
+err1:
+	ib_umem_release(umem);
+	return err;
+}
+
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr)
 {
-	struct rxe_map		**map;
-	struct rxe_phys_buf	*buf = NULL;
 	struct ib_umem		*umem;
-	struct sg_page_iter	sg_iter;
-	int			num_buf;
-	void			*vaddr;
+	int num_buf;
 	int err;
 	int i;
 
@@ -138,43 +182,18 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	mr->page_shift = PAGE_SHIFT;
 	mr->page_mask = PAGE_SIZE - 1;
 
-	num_buf			= 0;
-	map = mr->map;
-	if (length > 0) {
-		buf = map[0]->buf;
-
-		for_each_sg_page(umem->sg_head.sgl, &sg_iter, umem->nmap, 0) {
-			if (num_buf >= RXE_BUF_PER_MAP) {
-				map++;
-				buf = map[0]->buf;
-				num_buf = 0;
-			}
-
-			vaddr = page_address(sg_page_iter_page(&sg_iter));
-			if (!vaddr) {
-				pr_warn("%s: Unable to get virtual address\n",
-						__func__);
-				err = -ENOMEM;
-				goto err_cleanup_map;
-			}
-
-			buf->addr = (uintptr_t)vaddr;
-			buf->size = PAGE_SIZE;
-			num_buf++;
-			buf++;
+	mr->length = length;
 
-		}
+	err = rxe_mr_gen_map(mr, umem);
+	if (err) {
+		pr_warn("%s: Failed to map pages", __func__);
+		goto err_cleanup_map;
 	}
 
 	mr->ibmr.pd = &pd->ibpd;
-	mr->umem = umem;
 	mr->access = access;
-	mr->length = length;
 	mr->iova = iova;
 	mr->va = start;
-	mr->offset = ib_umem_offset(umem);
-	mr->state = RXE_MR_STATE_VALID;
-	mr->type = RXE_MR_TYPE_MR;
 
 	return 0;
 
-- 
2.17.1

