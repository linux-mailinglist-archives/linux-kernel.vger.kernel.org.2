Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3B130ED0D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhBDHMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:12:33 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:38434 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232327AbhBDHMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:12:30 -0500
Received: from localhost.localdomain (unknown [124.16.141.242])
        by APP-01 (Coremail) with SMTP id qwCowAD351gonhtgg8BBAQ--.50122S2;
        Thu, 04 Feb 2021 15:11:36 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     gcherian@marvell.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: cavium: remove casting dma_alloc_coherent
Date:   Thu,  4 Feb 2021 07:11:33 +0000
Message-Id: <20210204071133.83921-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowAD351gonhtgg8BBAQ--.50122S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw15CFyxGw1ktF48Jw17trb_yoWDWFb_ur
        18ZFZ3Xr1qg3yrArn5KrWa9rWvv39a9F97u3ZY9rW3ta47JwnFg347Xrn3Zr4UZa97uay3
        Z393tr42kr1UujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2AYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8CwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
        AIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bFg4hUUUUU=
X-Originating-IP: [124.16.141.242]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgcCA10Te9wtQQAAsF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove casting the values returned by dma_alloc_coherent.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/crypto/cavium/cpt/cptvf_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/cavium/cpt/cptvf_main.c b/drivers/crypto/cavium/cpt/cptvf_main.c
index f016448e43bb..112b12a32542 100644
--- a/drivers/crypto/cavium/cpt/cptvf_main.c
+++ b/drivers/crypto/cavium/cpt/cptvf_main.c
@@ -233,10 +233,10 @@ static int alloc_command_queues(struct cpt_vf *cptvf,
 
 			c_size = (rem_q_size > qcsize_bytes) ? qcsize_bytes :
 					rem_q_size;
-			curr->head = (u8 *)dma_alloc_coherent(&pdev->dev,
-							      c_size + CPT_NEXT_CHUNK_PTR_SIZE,
-							      &curr->dma_addr,
-							      GFP_KERNEL);
+			curr->head = dma_alloc_coherent(&pdev->dev,
+							c_size + CPT_NEXT_CHUNK_PTR_SIZE,
+							&curr->dma_addr,
+							GFP_KERNEL);
 			if (!curr->head) {
 				dev_err(&pdev->dev, "Command Q (%d) chunk (%d) allocation failed\n",
 					i, queue->nchunks);
-- 
2.17.1

