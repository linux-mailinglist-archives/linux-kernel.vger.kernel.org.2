Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C688037FE14
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhEMT20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhEMT2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:28:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2308C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 12:27:07 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u133so3683621wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 12:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hz2oyLCaodXd740ljA7xd9Idy1mmKCo0jqV0VyN8IUY=;
        b=sZXPaAsyf4ffDKyjs8O74Zge/X6jI76n+7YbKvJU+8109bI8MJgtyqcVubGJ1uWW3E
         yDI9/5+ruZ4+gDkA88wjjw7c7yGdcOc5GeYdkAgSZE/HDGkj6E54ITAKOUGug7YWoeGE
         2hPNROBUj4fBoXzzlqCyO0VisN7iG4jbaHqw0FyrMUMX2IRNx9ztDhzXBMP+JLfD8ZlD
         +J/1MFdbJ1AZEiyMFKQhzoXwkDk/uzYp0cQv1BIz/zE3RbspfofQ8QqrzLHd5CH5i6Jb
         5X1We59Js9IgROMufEwo3ZfD24fE47qy+g0tKH0ENk02rjwb0aKMBHniaUD5g41LYQC1
         zIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hz2oyLCaodXd740ljA7xd9Idy1mmKCo0jqV0VyN8IUY=;
        b=D1MBDYy7uLtfq+2l1V9akIng6UVrWXlDLFYpRRM9vEslEFLkPDn8lEFaQUHHWfZXDj
         g3htiMwqwe7zJRTsBJLdQ8t2HFmKqgdHBt4oNuKmydOiHrsIY6MAm4TLYmf7AHLPfUi6
         mZG3LZsEXEtmxHxxi1hNjchinhcNdORUAutipx0/CgNbOj/ThkQndJVboCy5WmuQFwH7
         71ZprQUSZTFgXLNjmjio9jQ21LciDgTeDyZ6U9+Asd8naExS4KnIIlVLyfwegrtavb+M
         WIB0yfw4tTikPpm7zqNW6Cevxkwnbit3kUoPY9+0seU2PiACe19LQYjQL0Tp/5AFOvMY
         TO9g==
X-Gm-Message-State: AOAM5339ZPt8jlOMDQPsKecMiXfXG6CODfbNBlV32HPG+4R4lE5nFOfs
        yJ8hNo7Q2fFsag6q2AeN681uWg==
X-Google-Smtp-Source: ABdhPJyzpUQgQL+VR9Dht+XY5fDnyA8jmiEPMMbUTAkreqWtyug65TxodZHPUV0tmb60GFcF2HSkQg==
X-Received: by 2002:a1c:b342:: with SMTP id c63mr46096700wmf.162.1620934026480;
        Thu, 13 May 2021 12:27:06 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-d842-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:d842:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id h9sm3053621wmb.35.2021.05.13.12.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 12:27:06 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dmaengine: mediatek: use GFP_NOWAIT instead of GFP_ATOMIC in prep_dma
Date:   Thu, 13 May 2021 21:26:42 +0200
Message-Id: <20210513192642.29446-4-granquet@baylibre.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210513192642.29446-1-granquet@baylibre.com>
References: <20210513192642.29446-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As recommended by the doc in:
Documentation/drivers-api/dmaengine/provider.rst

Use GFP_NOWAIT to not deplete the emergency pool.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index a09ab2dd3b46..375e7e647df6 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -349,7 +349,7 @@ static struct dma_async_tx_descriptor *mtk_uart_apdma_prep_slave_sg
 		return NULL;
 
 	/* Now allocate and setup the descriptor */
-	d = kzalloc(sizeof(*d), GFP_ATOMIC);
+	d = kzalloc(sizeof(*d), GFP_NOWAIT);
 	if (!d)
 		return NULL;
 
-- 
2.26.3

