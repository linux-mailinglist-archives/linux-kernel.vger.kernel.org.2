Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F32B39C9DA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 18:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFEQbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 12:31:31 -0400
Received: from m15114.mail.126.com ([220.181.15.114]:43131 "EHLO
        m15114.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhFEQba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 12:31:30 -0400
X-Greylist: delayed 1851 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Jun 2021 12:31:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=3dW3YORctanWJ+fF+P
        NqDTdyHt2AZo8sNgXLrG+WF8M=; b=OPvjNZrFl5rXsz1UAUznVdYwjuZmZWLHy7
        scdtolOzsLgwWQ2yXtPmMJSxSaGJ2gomEDUe69vILA6FhAzU1UB5JZOFOsfwpGk4
        drzjuDHamaWo3pvryfwwAdT2N7A1X6bZODGcf4ytcLjjzSAzPD/8Fk/DelnIsBC/
        L8Z0Z2l9g=
Received: from 192.168.137.133 (unknown [112.10.85.142])
        by smtp7 (Coremail) with SMTP id DsmowAA3e0HznrtgigGURQ--.14107S3;
        Sat, 05 Jun 2021 23:57:41 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     dan.j.williams@intel.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH] async_tx: use dmaengine_submit() API
Date:   Sat,  5 Jun 2021 11:57:19 -0400
Message-Id: <1622908639-8774-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsmowAA3e0HznrtgigGURQ--.14107S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF18ZFy7tw4fur45XF4rAFb_yoWDZFcEgw
        4S9rn7urWDAryfGF4UCa4xGrs8K3y2yFn09a18trW2qa4DJw1rWr4ft3sxX343WF1SvrW5
        uF1DCryIkr17WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8nSdDUUUUU==
X-Originating-IP: [112.10.85.142]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbiohWopFx5fPDKqgAAsy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the introduced API to submit DMA desc.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 crypto/async_tx/async_tx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/crypto/async_tx/async_tx.c b/crypto/async_tx/async_tx.c
index 9256934..c95d90f 100644
--- a/crypto/async_tx/async_tx.c
+++ b/crypto/async_tx/async_tx.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/async_tx.h>
+#include <linux/dmaengine.h>
 
 #ifdef CONFIG_DMA_ENGINE
 static int __init async_tx_init(void)
@@ -110,7 +111,7 @@ struct dma_chan *
 
 		if (intr_tx) {
 			txd_clear_parent(intr_tx);
-			intr_tx->tx_submit(intr_tx);
+			dmaengine_submit(intr_tx);
 			async_tx_ack(intr_tx);
 		}
 		device->device_issue_pending(chan);
@@ -118,7 +119,7 @@ struct dma_chan *
 		if (dma_wait_for_async_tx(depend_tx) != DMA_COMPLETE)
 			panic("%s: DMA error waiting for depend_tx\n",
 			      __func__);
-		tx->tx_submit(tx);
+		dmaengine_submit(tx);
 	}
 }
 
-- 
1.8.3.1

