Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BD9398CD9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhFBOfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhFBOe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:34:57 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FBEC061756
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 07:33:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a20so2596707wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMlp5Ni2aMFHyMfn1NEHDx/+WQIjP8upodgZGGEhVrs=;
        b=K+TM+jok6dmGLiVfdJ5aHvkAyTXlaxEkUvu3eR15jQnSiQZDOVbl7Ad7UABtuK84F+
         SiGyWlm0Q/Roo4MaHxBw0hVagJn3kB7B36ned7f9VZ7qKdW9ew8tDax4JyeliwEfgol3
         LzTH/V9mmfZPWw8etltfOUAbOOTdt4Q0Ftc5FSS8fWAxZyn2LdeeVc0x7fAv7i5SeeiV
         RyQyKw94rLiFXSNIvLFJOHuBXAj1BVslRvQMMPFHt2y5OtRXJV3gKAa/0ebcSulVTrhy
         2+LLiMiabV/zAlV49XtTFoV3pIDQSZGzBFWLFN2PAdXSdV+a0OFPsprrfDXJgipgQSRi
         8lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMlp5Ni2aMFHyMfn1NEHDx/+WQIjP8upodgZGGEhVrs=;
        b=hM6Vyo/SbVQ7WskZgDw/oJX/68ug/qhYLfaPevTGTw8a9JA+sFoLAXE4ajugQlenpY
         F4qtpNKsf7D7X3EgxD3LnaQT5hC1+tU38Rs60dCykIz6BQ7y/nBKHA+njUVbZHRpTX/V
         m0iiK3hk2s+8rJltMwwY+f27bFQvqOl/mruexTvvVB2hAbVxmxu1n2N77Yd8fT50T1wv
         dBtDd07wumyHZ7CZtum+KqAvP/C9x7Q1+eaGvc0E9gTybxAfZaWyqCpc9DarYzpJ4D2O
         dedgT98dKYi/tyDsa5Wyw5TUlEnWd4BEMl/8VzJtkV4jtV2x+zk0h/E5yJ7YOZGe/HJA
         DIJw==
X-Gm-Message-State: AOAM533aZMNzYvare1xH2+geVWDB+RwBkH/g9nGmDA7LDeGLbL4ptupR
        FFa/lXUfUtzDWIfC1oNqeYrsJrNxxpEZig==
X-Google-Smtp-Source: ABdhPJyyjExdHvRbSDp8SXi+SPDREQCiQw3FO2lfDCB5q7ocoF+sb8JiXyCVcFPptQi4DQIZ2IRr1A==
X-Received: by 2002:a05:6000:1542:: with SMTP id 2mr3202490wry.4.1622644392816;
        Wed, 02 Jun 2021 07:33:12 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:12 -0700 (PDT)
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
Subject: [RESEND 03/26] drm/mediatek/mtk_disp_ovl: Strip and demote non-conformant header
Date:   Wed,  2 Jun 2021 15:32:37 +0100
Message-Id: <20210602143300.2330146-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/mediatek/mtk_disp_ovl.c:83: warning: Function parameter or member 'clk' not described in 'mtk_disp_ovl'
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c:83: warning: Function parameter or member 'regs' not described in 'mtk_disp_ovl'
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c:83: warning: Function parameter or member 'cmdq_reg' not described in 'mtk_disp_ovl'
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c:83: warning: Function parameter or member 'vblank_cb' not described in 'mtk_disp_ovl'
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c:83: warning: Function parameter or member 'vblank_cb_data' not described in 'mtk_disp_ovl'

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
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 961f87f8d4d15..fa9d79963cd34 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -66,9 +66,8 @@ struct mtk_disp_ovl_data {
 	bool smi_id_en;
 };
 
-/**
+/*
  * struct mtk_disp_ovl - DISP_OVL driver structure
- * @ddp_comp: structure containing type enum and hardware resources
  * @crtc: associated crtc to report vblank events to
  * @data: platform data
  */
-- 
2.31.1

