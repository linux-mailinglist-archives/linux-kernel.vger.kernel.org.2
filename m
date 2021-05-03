Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9D53717F4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhECP1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhECP11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:27:27 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E68BC06138F
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 08:26:32 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 103-20020a9d0d700000b02902a5baf33f37so4927060oti.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:cc;
        bh=EI6bZyecXV+D4mAvyW1zNE2tx9yP9EY1VWyGEKOhGs4=;
        b=qeuOlliDGX/UXrFBQRGA+wZpGmrZ3HwhDOaBcLLbNorJFBQ4hQ9Q/6PhUtBuNeS8Aj
         au6pVFpGyoJApuOoR9hMvcsM3O/ekucc0pvsmba0X3h/ETYu8raP259toJ+B9EQmVv3U
         noQ0uvWbA3AQWM/Qk9dBt9TfYB86MQgd8kz3agg/3D5fZKr6N1NOHdVpSHKhVHkpQlbO
         GeOcTWWtTFUZMM+V3A3Em2sAhxFybQCvJI/ak4a4jeiX+fIB3AtFhVdTWrFtg63tw3xd
         QOgP2+GbpbYXfLlNvbH5jOyPPPAz8hsNULBRqJWfisA+Pml5+1NmzEMm7R5HvdDBlBGU
         Wc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:cc;
        bh=EI6bZyecXV+D4mAvyW1zNE2tx9yP9EY1VWyGEKOhGs4=;
        b=mYMudAMaygSyYKggxqtv/t6ocmWp5HShBkUyIjSGoJhvQFaeiVXCUcAD2kCdrUHA9D
         UX+x02RkxcbYkq8RcxYvO6N4tcaV2vN3Vi/1U4gdZk5r0WA7PoOibnIylsNcjKy1QVYx
         n0RtremKwmmjoBOcIt/UWsXSB1t33xydS99o3viRtGOvBU3XMrSOyqQNuV260C40xMv6
         PlArOCpK7G4A3a/2Kk3g8CFrXssH5Se8B/AxervP2SUXxogZt75mGbZ+qCZuyRqRiB9P
         YH8i9Dpqy/mM5+hvlDxoU3NAzz5lNfdjZiuAm4wI4RtHrLmHIILzbZKF5EF8gFE8kfue
         h1fw==
X-Gm-Message-State: AOAM530Jvwi2p1z4Ma4yG2VLVwBJZntVxPx54NwkXxdw83M//U4iit78
        U54Lo1xKv4Jy32qKRyDj5PIIifr/EYSZrhZzUg6KHQ==
MIME-Version: 1.0
X-Received: by 2002:a9d:2f24:: with SMTP id h33mt13304196otb.128.1620055591994;
 Mon, 03 May 2021 08:26:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 May 2021 08:26:31 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 3 May 2021 08:26:31 -0700
Message-ID: <CABnWg9scYTkZ242STBop4yXNKsEzgd1gsGoZQzvrurL5nYhUQw@mail.gmail.com>
Subject: [PATCH 3/4] dmaengine: mediatek: use GFP_NOWAIT instead of GFP_ATOMIC
 in prep_dma
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

As recommended by the doc in:
Documentation/drivers-api/dmaengine/provider.rst

Use GFP_NOWAIT to not deplete the emergency pool.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c
b/drivers/dma/mediatek/mtk-uart-apdma.c
index 249cabddb7ee..4711bec04b98 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -349,7 +349,7 @@ static struct dma_async_tx_descriptor
*mtk_uart_apdma_prep_slave_sg
 		return NULL;

 	/* Now allocate and setup the descriptor */
-	d = kzalloc(sizeof(*d), GFP_ATOMIC);
+	d = kzalloc(sizeof(*d), GFP_NOWAIT);
 	if (!d)
 		return NULL;

-- 
2.26.3
