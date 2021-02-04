Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C5930ED27
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhBDHSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:18:43 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:42028 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231791AbhBDHSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:18:39 -0500
Received: from localhost.localdomain (unknown [124.16.141.242])
        by APP-01 (Coremail) with SMTP id qwCowABnbpaVnxtgKuhBAQ--.48462S2;
        Thu, 04 Feb 2021 15:17:41 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: host: ehci: remove casting dma_alloc_coherent
Date:   Thu,  4 Feb 2021 07:17:38 +0000
Message-Id: <20210204071738.84222-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowABnbpaVnxtgKuhBAQ--.48462S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw15CFWUWFW7uFy3Cr17KFg_yoWxuwc_Cr
        W5JrsF93srKF1qkryDJFy3ZFZ7tws5XF48Z3WvgryfKa4qqr4rXF93Zr1kJ3W3Cws5JrZ0
        k3s8XrWSgw4xujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2AYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
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
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7pnQUUUUU=
X-Originating-IP: [124.16.141.242]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCggCA1z4jWK-QAAAs3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove casting the values returned by dma_alloc_coherent.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/usb/host/ehci-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.c
index 6361d81272bc..769329032257 100644
--- a/drivers/usb/host/ehci-mem.c
+++ b/drivers/usb/host/ehci-mem.c
@@ -185,7 +185,7 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
 	}
 
 	/* Hardware periodic table */
-	ehci->periodic = 
+	ehci->periodic =
 		dma_alloc_coherent(ehci_to_hcd(ehci)->self.sysdev,
 			ehci->periodic_size * sizeof(__le32),
 			&ehci->periodic_dma, flags);
-- 
2.17.1

