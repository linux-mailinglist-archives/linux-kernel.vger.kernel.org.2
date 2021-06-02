Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B715398CFC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhFBOfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhFBOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:35:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2222EC061756
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 07:33:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f17so1450909wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71fOhHlO0apSNak4OgEIaxdLa+/aWkYj9kGsKGdRvTY=;
        b=xUhef00MAVJBy+PY/e3mmGBGxXvIB8iTo9q2dRXzdTl6KgRNOFx3Yh5yZm5G5EDaa4
         MqdznlwSY7+USlsU8c+sFceCBC4jbvyxI1T0bdvESoujA+UP7urnlvjIJSKSVIG9CZpp
         3y1jKPC6xkQRU3IbTX6PaBsEUEQoVuT5KWblMlVi/2luDXltDZnS8VexfxbJrdoQ5jvr
         MXkykFkPCdRogUZ1amrbUundmf8LFslbw3D9ChQKatF0ihn61jSwGhg0tiwejOxV3UCG
         OshO5G93Twyyo8dVe3UVrzg9/ZziR1X4PrgmJqOYNb61iGuhDts2f6VYWZjl2Oh8g5kM
         dFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71fOhHlO0apSNak4OgEIaxdLa+/aWkYj9kGsKGdRvTY=;
        b=fukDekf3Ni6U46K3qvd6etYD/wscpKV5Ka2Mezmax5Tkpd/YXOGHrrmUXmnpBrQCs3
         kmO2hS3skOSCsFBQ9gSp4IbU4E3bmXou3PWiC0SPA2zA/Q0JCntGjMdjm94y1PEpfrax
         4IJ7eDrr9put+UK9MB0JocfiB2BPvjSFg3SkvWcrftUTdek3Km+KFhJ9tK9h8bJq/FDd
         GdvKgNDaEOXMBB9eB9tXkxjoA/hQvL/ZaFsJEaWk7F892rCgIItmYptCnlMfo5Q8o+fM
         BiBZVM4B5zCiLa91rTVBAbkLZ1cSTWm0iaZcTs/Xhp+DlEyA02AIZ5pgb5+ZtNUYEikd
         BVpA==
X-Gm-Message-State: AOAM530yn/stjMAtsonMJdlgLoVwAc8jp0YUR0TACcEX2rqAB08YJVmh
        hmfSJeztlEbZLZ/3wFRC1LGrUg==
X-Google-Smtp-Source: ABdhPJzulksV7rbktUjzhrFg74d46BeymCpz5NyUxNhoO0P/xDn9e9UnTwrPNud6bo/oRxePX9B7aA==
X-Received: by 2002:a1c:bc09:: with SMTP id m9mr15311724wmf.143.1622644393843;
        Wed, 02 Jun 2021 07:33:13 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND 04/26] drm/mediatek/mtk_disp_rdma: Strip and demote non-conformant kernel-doc header
Date:   Wed,  2 Jun 2021 15:32:38 +0100
Message-Id: <20210602143300.2330146-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/mediatek/mtk_disp_rdma.c:72: warning: Function parameter or member 'clk' not described in 'mtk_disp_rdma'
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c:72: warning: Function parameter or member 'regs' not described in 'mtk_disp_rdma'
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c:72: warning: Function parameter or member 'cmdq_reg' not described in 'mtk_disp_rdma'
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c:72: warning: Function parameter or member 'vblank_cb' not described in 'mtk_disp_rdma'
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c:72: warning: Function parameter or member 'vblank_cb_data' not described in 'mtk_disp_rdma'
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c:72: warning: Function parameter or member 'fifo_size' not described in 'mtk_disp_rdma'

Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 728aaadfea8cf..705f28ceb4ddd 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -55,10 +55,8 @@ struct mtk_disp_rdma_data {
 	unsigned int fifo_size;
 };
 
-/**
+/*
  * struct mtk_disp_rdma - DISP_RDMA driver structure
- * @ddp_comp: structure containing type enum and hardware resources
- * @crtc: associated crtc to report irq events to
  * @data: local driver data
  */
 struct mtk_disp_rdma {
-- 
2.31.1

