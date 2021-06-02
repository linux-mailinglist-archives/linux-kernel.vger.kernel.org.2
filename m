Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B4A398D09
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhFBOgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:36:01 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:54926 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbhFBOfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:35:55 -0400
Received: by mail-wm1-f42.google.com with SMTP id o127so1444766wmo.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M9bRhyWuFVpQrG3EHXZKnG7o8XLPNhfRhn1oXXk6SrQ=;
        b=FYmSxXOaVJ7u/hRBRjCRyMs468oivh2TsgX2RGPglQBkpugM6lgQWldOX0rIaOfXSP
         YVzbQwXiDA9smCQzDmzafGN3P1RprMVSNRl3BnqKNAfSQmT6ulR1Hv9/6EfLwMxmyo7z
         P6PyagKgW4BuWiOnsMTU6Y0JhWJJEX+DY/1Vv5eHGNSpouz68kzJzZutQ3ZV1CjhkM0H
         kzzsCCmphlHG62++alAVxt85h/Fj77OwkErFTBbHEy8olwx4eM1/k+Y4mKMUCge+8YMs
         14iIaeDvwMBwEKhfGiiU3WYlRVTOwA3gMFv4Xuf4/f9BthCK8u4+iw1ZJjxGde5/Bfuj
         qe3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M9bRhyWuFVpQrG3EHXZKnG7o8XLPNhfRhn1oXXk6SrQ=;
        b=ANYjOXSbHaXooZ8wZ80uGxrG0+yP1hK1+c0LDAnmo2qQPp+OlaZxF/eZVgOvZap4Cw
         Zrdidt9UyHWKGopE1SPetEENKAOXulXOvRyJXYtlEfC4hW2ZovzoWi8VDpXW9SZVZ3V1
         H6znyRUGaMmoBZ6tVU+a3dupLKX/4pEZrqq9f6XvVT1avzOkm9ubasgi5uqHHU0cAyp0
         hM8jirM4Ne1gBrMs89T0MKhBdLmKQkBacHRLC0DLACz4+Z12d61jpCGSl2uc3t/kF1Y4
         Cf0E6hfnc07a8SfabuSd6VTdEOMqL7Cw8kfb0g346LXvnYa+xw7fj22pYbppJ5qr7pfC
         Vpew==
X-Gm-Message-State: AOAM531va3mq20M53kKwpU8NAKuYtHK2q3ILPlYVW8N9PZfYa0oWd6VL
        3/jSmU3ROxr/++0qWJqIS2a/9w==
X-Google-Smtp-Source: ABdhPJzsdddao34LRabPBk4flX5Gv0pUOZLrhtePOoQ2SzMzu4f5Lqu++Joq8p3Yl+P1MsCSIKI/tQ==
X-Received: by 2002:a05:600c:350a:: with SMTP id h10mr33825781wmq.119.1622644391896;
        Wed, 02 Jun 2021 07:33:11 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:11 -0700 (PDT)
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
Subject: [RESEND 02/26] drm/mediatek/mtk_disp_gamma: Strip and demote non-conformant kernel-doc header
Date:   Wed,  2 Jun 2021 15:32:36 +0100
Message-Id: <20210602143300.2330146-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
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

