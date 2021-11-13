Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD81444F380
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 15:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbhKMODG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 09:03:06 -0500
Received: from mx18.pku.edu.cn ([162.105.129.181]:12731 "EHLO pku.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231672AbhKMODE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 09:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=+Uv1cnCExL
        x+NRoiml5Lx7hRNX6/2bMWQ2RWbNb2WNY=; b=gGaMcbvQX/vFg1/jUBFIVb5FqX
        A0zLzrYWoLBz4FKYjARRZ30lfIlW6AqLHGSjJMwMRxIZVkZdo+FhtJLQZaAQYXdu
        gZ0PUpD8xx/bsVNOSZxkMRNDyUN0E9KLFjK5P1bPiu/c5PZW7O83F/lBIa39QGEs
        /vQpvl1pYM588upWw=
Received: from junqi-virtual-machine (unknown [10.2.70.49])
        by front02 (Coremail) with SMTP id 54FpogD3_U3gxI9hUPcDAw--.8445S2;
        Sat, 13 Nov 2021 22:00:01 +0800 (CST)
From:   Liu Junqi <liujunqi@pku.edu.cn>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liu Junqi <liujunqi@pku.edu.cn>
Subject: [PATCH v3] staging: mt7621-dma: reindent to avoid '(' at the end of line
Date:   Sat, 13 Nov 2021 21:59:52 +0800
Message-Id: <20211113135952.365607-1-liujunqi@pku.edu.cn>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 54FpogD3_U3gxI9hUPcDAw--.8445S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1fGw4DKr1rurWxGFyDJrb_yoW8GFy3pF
        Wrt34YkrWUtFy5Ww47Cw4fur1F93WfGryIgrWUA39agr1jv3WfZFyayay3Z3WkKa93GFyS
        yFyUta45Ga1UuFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF
        04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb0D73
        UUUUU==
X-CM-SenderInfo: arzqiiirtqlmo6sn3hxhgxhubq/1tbiAwECD1Py7tTfDgAdsY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A change to make the code more like typical coding style.

Signed-off-by: Liu Junqi <liujunqi@pku.edu.cn>
---
I'm a kernel newbie and it's my first time to send a patch following the "Write and Submit your first Linux kernel Patch" video on youtube.
The first version was rejected because of putting a '*' at the beginning of a line, and this version is exactly what Joe Perches advised in the reply to the original patch email.
Please let me know if I got anything wrong ^_^

 drivers/staging/mt7621-dma/hsdma-mt7621.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/mt7621-dma/hsdma-mt7621.c b/drivers/staging/mt7621-dma/hsdma-mt7621.c
index 1424d01d434b..f303579bd1a2 100644
--- a/drivers/staging/mt7621-dma/hsdma-mt7621.c
+++ b/drivers/staging/mt7621-dma/hsdma-mt7621.c
@@ -455,9 +455,9 @@ static void mtk_hsdma_issue_pending(struct dma_chan *c)
 	spin_unlock_bh(&chan->vchan.lock);
 }
 
-static struct dma_async_tx_descriptor *mtk_hsdma_prep_dma_memcpy(
-		struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
-		size_t len, unsigned long flags)
+static struct dma_async_tx_descriptor *
+mtk_hsdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
+			  size_t len, unsigned long flags)
 {
 	struct mtk_hsdma_chan *chan = to_mtk_hsdma_chan(c);
 	struct mtk_hsdma_desc *desc;
-- 
2.32.0

