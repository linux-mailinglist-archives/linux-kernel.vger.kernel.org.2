Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DA238AEAA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242485AbhETMny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241572AbhETMnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:43:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86799C056485
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:02:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y14so15301703wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M9bRhyWuFVpQrG3EHXZKnG7o8XLPNhfRhn1oXXk6SrQ=;
        b=QaDnKQSjqkn4QePQ0kTBrTEKLV+PNzIkhCzxkhxaW35b4yBqqXr3JAf9xItUI0vKWe
         Js3oOcCnYQiz4GqAqe9hxOEemuXQTEDmd/znBNGSK59deuLoC7nthIUoc77gmSCawcJ8
         320dOYQ0xsXbI26zQTnXM/IQwZp1H5ab4Ry+t+x7/JIFfzx3oWi1H39yjMALjl2izvFO
         4LnRKWtHelBgXlRfdi7r8PnDSlhr8TIPOav+gTWfognB4aetD9mqEwjrz3m7b2vMRXCb
         RDe+COrlBT2sTQqzbMwIo/xev3HvQp7tpU4xct1F1FwqKvRwUFm81cxoIs0rIbIlc5gD
         ZNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M9bRhyWuFVpQrG3EHXZKnG7o8XLPNhfRhn1oXXk6SrQ=;
        b=d9VF63TBBE4Y4Y82X47Ye0IuqKiphjryPUaCxOGE93AP8Ev25aLvQbW7v017nmgyXf
         h0tRI+icNCa9ikjuMs9zByj7/LGYgqCGkCOX11xNF5e71Wdq/eGYUwcyo4parZg7LDb3
         1JUQP6ATCvnwSh+dUdhFfwR50xIl3q/KlHX0HbD5NZFKnCdY+kOmcITeEYf4+thJdl+J
         KG8UsKtH4JzfyXFOQNyoxt/mdB3EFlzkkVbt2nQylXiWV6N0VnIMWit2n87N2u8GgqVp
         q22LPFqGWYUssPyCsd8RTWwqNJuB4wy3CKyGjbxmJlgyZMeooaYf5iYkD3hYciHsaslq
         YNVQ==
X-Gm-Message-State: AOAM533LCJ2Pma1UkbGj9p+6Wdnyar+MkHu5PBurK+k37gQWA9H/gAmt
        KzpyLibL/6xS/ZnLp2byIgTKbA==
X-Google-Smtp-Source: ABdhPJzX6gO6eOjIxe2DAvFcz7ewe9ss6bBrbbFuU+mLxlW7zGh+iN0tC3I42VZoxeDplwiMFfSTxQ==
X-Received: by 2002:adf:9cc1:: with SMTP id h1mr3818529wre.135.1621512174148;
        Thu, 20 May 2021 05:02:54 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:02:53 -0700 (PDT)
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
Subject: [PATCH 02/38] drm/mediatek/mtk_disp_gamma: Strip and demote non-conformant kernel-doc header
Date:   Thu, 20 May 2021 13:02:12 +0100
Message-Id: <20210520120248.3464013-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/mediatek/mtk_disp_gamma.c:42: warning: Function parameter or member 'clk' not described in 'mtk_disp_gamma'
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c:42: warning: Function parameter or member 'regs' not described in 'mtk_disp_gamma'
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c:42: warning: Function parameter or member 'cmdq_reg' not described in 'mtk_disp_gamma'
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c:42: warning: Function parameter or member 'data' not described in 'mtk_disp_gamma'

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
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 3ebf91e0ab412..3a5815ab40795 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -29,10 +29,8 @@ struct mtk_disp_gamma_data {
 	bool has_dither;
 };
 
-/**
+/*
  * struct mtk_disp_gamma - DISP_GAMMA driver structure
- * @ddp_comp - structure containing type enum and hardware resources
- * @crtc - associated crtc to report irq events to
  */
 struct mtk_disp_gamma {
 	struct clk *clk;
-- 
2.31.1

