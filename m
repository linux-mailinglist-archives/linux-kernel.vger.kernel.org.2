Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E791444F3B6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 15:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhKMO3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 09:29:06 -0500
Received: from mx19.pku.edu.cn ([162.105.129.182]:15854 "EHLO pku.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231912AbhKMO3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 09:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=K6R+cqStDd
        RPGBWSCxB868XLGtafpeKe6Or8elC074U=; b=sWwaP+FTohUDFR5Bh2MWjsJouK
        ALoyqZjHW9m9hqNmHnNLZ5pJr1XFCziVviR3AWiB3Ce69KBgScWXeYXFMrtJ29OB
        bqZY83IwElSeJCg00ihALKvY+9wV5lu5Fj2/vx0/mBXqBJAbU0N6U383uLDK5tvY
        eK3hfrFKQqGyoBUIA=
Received: from junqi-virtual-machine (unknown [10.2.70.49])
        by front02 (Coremail) with SMTP id 54FpogBnbU33yo9h5y0EAw--.10134S2;
        Sat, 13 Nov 2021 22:25:59 +0800 (CST)
From:   Liu Junqi <liujunqi@pku.edu.cn>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liu Junqi <liujunqi@pku.edu.cn>
Subject: [PATCH v4] staging: mt7621-dma: reindent to avoid '(' at the end of line
Date:   Sat, 13 Nov 2021 22:24:56 +0800
Message-Id: <20211113142455.370952-1-liujunqi@pku.edu.cn>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 54FpogBnbU33yo9h5y0EAw--.10134S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrykuw48AF1fCFy7Zw17trb_yoWkurb_ur
        Wqqr93WFyDZr1rtr1xtFWfJ34SyFWkXF1kWw17KFZ5Zr1DAFy5ZFn7CFy2yr1v9ayxZFZr
        ZF1jvFy0krnxXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4kFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAI
        w28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5sjjDU
        UUU
X-CM-SenderInfo: arzqiiirtqlmo6sn3hxhgxhubq/1tbiAwECD1Py7tTfDgAgsl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A change to make the code more like typical coding style.

Signed-off-by: Liu Junqi <liujunqi@pku.edu.cn>
---
V3 -> V4: Rewrote the text below the --- line
V2 -> V3: Added describing text below the --- line
V1 -> V2: Reindented the code

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

