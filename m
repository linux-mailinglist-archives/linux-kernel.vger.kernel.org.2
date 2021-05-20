Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F244138AEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbhETMnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbhETMnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:43:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F2C056484
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:02:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i17so17363836wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gorhgp6A/JFLcLopPzVqEwuJgKOF4GUxJ0EbzsMlIrw=;
        b=DXAd2Cbmarjx32hRY0bCPUAuvAnlgW3AWRT/xVZNr8kCPXSByJXcsb+WRz3G5GS+pQ
         thEIPZ5g5m6vLshkZQvxmcGaXjvcI4oZhUtocbfMXaVxxNNNPOZLvWzliVMnTrLFje5y
         G5dTLLV2xex/mlTG+UDIVIUV97SCmZ4aTLqOKkYlrDpPyTTtdtmjdUOF3D45cdnog6rR
         Hr2z+K1bhuRkuFpXBZNOKXPUGzEF1Met2wSoYe0w0r5nfkK2GWYjVBM/Xks/ynTXf8/m
         y4eBvtnrSb0ioUWBKUvEYWqIzeaB6yLlLI55MpZUZp31h8lYD0AD8x3UTdQZ8NsXdOdI
         F4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gorhgp6A/JFLcLopPzVqEwuJgKOF4GUxJ0EbzsMlIrw=;
        b=s7+K3j9KEePEZwi0rVrMI8zsUsCeW9TaG20CbTKRSeA07Xc/6zFMtH6kHmfcY3+8S3
         q3E0WNcLMkeO+TwPmgb8nUn9ECEVRb9BWyx0DpNNzyxFdsOT6hp3CW3yiyuww/0q1O+w
         wa4JswT4F3YwwCdD/kBUITywdsz3dgZm8tdq9xv7BcrP1gxgqxQrMEl8m/oSd6ojc3yR
         lnFPeX7fdj07vSqfo+JN4IKtYplc1ekFp+3eH1j5TQkSoKGdOzExwuFCPRp5dzxM2Uoa
         e7wHqWlqqZ/VOnyrJOW4UgUitzBqG2gcQGpoV8hTA0eZftzqZx8qM4i3XfRv+LVa0qOY
         4ErA==
X-Gm-Message-State: AOAM533E1B/tRjpnnoiDsceT4GmahE1hxTo7fTVrapOOQpZ24FbTHhZv
        ApUX9HIkx7XeWkeg0a+BWoEbyw==
X-Google-Smtp-Source: ABdhPJzh4BHbXGyx8cGFDsWQ6g9jPqTsOOVJGdjgVjcIBXa/i0FJFZTo8q2m6mCyS360dD9BWrucRA==
X-Received: by 2002:a5d:5382:: with SMTP id d2mr3785609wrv.367.1621512173034;
        Thu, 20 May 2021 05:02:53 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:02:52 -0700 (PDT)
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
Subject: [PATCH 01/38] drm/mediatek/mtk_disp_color: Strip incorrect doc and demote header
Date:   Thu, 20 May 2021 13:02:11 +0100
Message-Id: <20210520120248.3464013-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/mediatek/mtk_disp_color.c:45: warning: Function parameter or member 'clk' not described in 'mtk_disp_color'
 drivers/gpu/drm/mediatek/mtk_disp_color.c:45: warning: Function parameter or member 'regs' not described in 'mtk_disp_color'
 drivers/gpu/drm/mediatek/mtk_disp_color.c:45: warning: Function parameter or member 'cmdq_reg' not described in 'mtk_disp_color'

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
 drivers/gpu/drm/mediatek/mtk_disp_color.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/mediatek/mtk_disp_color.c
index 63f411ab393b7..6f4c80bbc0eb6 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
@@ -30,9 +30,8 @@ struct mtk_disp_color_data {
 	unsigned int color_offset;
 };
 
-/**
+/*
  * struct mtk_disp_color - DISP_COLOR driver structure
- * @ddp_comp: structure containing type enum and hardware resources
  * @crtc: associated crtc to report irq events to
  * @data: platform colour driver data
  */
-- 
2.31.1

