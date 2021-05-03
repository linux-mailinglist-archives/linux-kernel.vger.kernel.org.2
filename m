Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7233A3717F5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhECP1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhECP12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:27:28 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C408C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 08:26:34 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id c36-20020a05683034a4b02902a5b84b1d12so5018989otu.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:cc;
        bh=KYXKPtE2VZh6dALBmahX3Lb0HQq8HVq0AUpkoo7GpCQ=;
        b=xmbEQhxke5pWHBfmJSrThVbWD6yNloeA2luzWWZqnzEUacHlBE9+p5BdJi3ay7KHeM
         EuMcX5IaisYJBmG+magxxmg5YuD04Gmwg7zkDBgqouHeuxxIcMUOnP8AYfGwVW3DMeNz
         RsXqNHfeYCEYU4hJolnlkGJ72xZ+yP8N1Kv5W96RED8BM5BQucoNaDhHjUMwLQZC24wl
         ZVBvPEqsjSvYY4Ic+mnHQs4tgU0zinx9OPGvC9YH2wQzKGCs+fkp7h5Mh2BpLTxXdXBu
         RYgOmbb+6IJE9/Eyo2w/veS83rXtUE5tF3PnuxfyHB+uJGQkLVMfY+DoCXkit+rXY+mH
         tPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:cc;
        bh=KYXKPtE2VZh6dALBmahX3Lb0HQq8HVq0AUpkoo7GpCQ=;
        b=o0FluwF2MikTF8wkYQVpUBB3IZE9IJkHE2Om7yJ9DoaSgofl45LEicOmataouYjUeI
         bFFbL299VvRXHzewjw96T7IXXk0WkN5e9xfL7NRrhKfyA29v19OgaJXnZypekvyFA0wh
         Han7dLC0CvZc2grf3vFNYJRxCOzH6ObacteTagxUDdqoMAt3oTTTDQ5hvi97WubKiW31
         kC/jFE/japCsCehHpuVxDqHBGrX+QVqZ2dcc0u4oeNd2ddp8eIB3If3BB7JTlAZlZRlU
         vePTZwWDAV201+l+i6UYgf3ZARo6oifrcHRnHxFb30NDkQFVhZ9ujSFlYXkwzwFzoXLK
         wTsQ==
X-Gm-Message-State: AOAM533DYafYbBEmJOu3qPVylsVhVYUHYmGDkMCAdTwf1s6qW7P9CvUp
        yagRJ6jUcA2+V++fmNs3axc0ILiJZCttGCPGKLbI1w==
MIME-Version: 1.0
X-Received: by 2002:a9d:4703:: with SMTP id a3mt12624907otf.136.1620055593857;
 Mon, 03 May 2021 08:26:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 May 2021 08:26:33 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 3 May 2021 08:26:33 -0700
Message-ID: <CABnWg9s9nbqm3bMv7oWgDw2zvaB3tcHttk9n9Jia4aZ_tdvK=g@mail.gmail.com>
Subject: [PATCH 4/4] dmaengine: mediatek: do not hold the spinlock for vchan_dma_desc_free_list
Cc:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is no need to hold the spinlock for dma_desc_free_list,
Move it oustide the spinlock section.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c
b/drivers/dma/mediatek/mtk-uart-apdma.c
index 4711bec04b98..ba43708f2a93 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -431,8 +431,8 @@ static int mtk_uart_apdma_terminate_all(struct
dma_chan *chan)

 	spin_lock_irqsave(&c->vc.lock, flags);
 	vchan_get_all_descriptors(&c->vc, &head);
-	vchan_dma_desc_free_list(&c->vc, &head);
 	spin_unlock_irqrestore(&c->vc.lock, flags);
+	vchan_dma_desc_free_list(&c->vc, &head);

 	return 0;
 }
-- 
2.26.3
