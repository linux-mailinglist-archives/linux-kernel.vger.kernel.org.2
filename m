Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6ADB398CF4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhFBOfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhFBOfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:35:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59659C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 07:33:12 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h3so1448287wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gorhgp6A/JFLcLopPzVqEwuJgKOF4GUxJ0EbzsMlIrw=;
        b=rgK5J1pf61mbr4gAJvzrqYg1NFOZAHw11rg/bnOxAWpDOqPQgssVwLXQOHcmWyRWNq
         KUrzFMA+dglu4oU0dzeEzXy07ZCvW94AfH5X5/e9RKxRR1XAH6GP/3krthyYA/J4mmjf
         vHwHDK4gm+XhyqE8mqH4kPw0vuKDs+PsjtWIw3NKpdyomU0wemzWKm7AXlvyA7BuZ4QF
         JYUaq1szJCA4P1XOElhAbD7Xu7IqatvY9Avryr1PqsXDceTGwFE8m+gmpithlNs9iipG
         BuB9solh30GDVOgKfnIPgf3WXRbuzKxO8x9+3kpN7RlC4ipOSTIKGgJe6gEcD6ex0af2
         DN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gorhgp6A/JFLcLopPzVqEwuJgKOF4GUxJ0EbzsMlIrw=;
        b=YbYz8RTFVW5rvOuywgM36VdfzMW6e6K7GrVl/N3r5uWkRtMfXdNaqUC0Ay5PRuCTa8
         bVx8+5xdmzQoU5sUAVml+ozXGV+l9JuzLy54cWWyF4kujPh+Ca5X9E4rrfA4bs2SdUGh
         JP17/TglpTbQ7YgajxvheeQYCCKzeXesjUlzVu8wcnhbmjW78IC1WGe2GjNlMx2ey9Qw
         Rv0dJUDH4oDSygRBbqYOP1JXMHsz+Dgl6T9kqm7APmQru893A5uvhFCS6bNqbADUD2jP
         BYf77tBNXbkLMWNjb7Fs/O3XbtCX7ZfvW1tKG6NrUSgpCWotzttNKDLvEL8Pam2IU6cH
         fByA==
X-Gm-Message-State: AOAM533EaRuznP1pJ6eYCbLj9FS7GGoVoGS7eKOy+ngWwjIp3CbA1oug
        rQE29G1p/J4TBzvWi1kMyQZc/Q==
X-Google-Smtp-Source: ABdhPJxTfX71DJ4tXTep1p96l5vvEGkQLsO5X8QuRsRF+axwSkdMuH163P9OGjrkgu1nDwfjXeuCjg==
X-Received: by 2002:a1c:acc5:: with SMTP id v188mr31827293wme.60.1622644391022;
        Wed, 02 Jun 2021 07:33:11 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:10 -0700 (PDT)
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
Subject: [RESEND 01/26] drm/mediatek/mtk_disp_color: Strip incorrect doc and demote header
Date:   Wed,  2 Jun 2021 15:32:35 +0100
Message-Id: <20210602143300.2330146-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
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

