Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E4E3622F6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245013AbhDPOlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244784AbhDPOip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF83C06134A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h10so32527326edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/J6GwXeDyu6BFCOqdnjyM+gc8J2+w9Z9RwZ5xPgtm+s=;
        b=Q3vDrMvdLvGZIwxQufcM4ObRDx1q/WwhSRnb8Nni/u1IMyeQoijNkIN4BYPVyYvvT6
         /d2kp/zGgNL4i6WogCZhbQAsxU65ZQf0NFwbktiqhs4jT5qsfNLrV1K2UPY+cYk5/V3M
         XVrZeEroUAorEs8+4tHS6ZR/z+7PEBUSIi98XEgp2F8Yyp7XZbEn0ZZRCffdMSZcmORh
         hRXm2eliqwK2RzS7LJBm7RRY3JSpby9cx17daB9HzLiMMQyrTt1SInsWK3wraCZJ4tC4
         dIFEHd8x7WDxe5ft26oGQAsVj4rST6nYZeFhajLg5Y1yOHHwGva8v98HGJHotVerp8mB
         2mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/J6GwXeDyu6BFCOqdnjyM+gc8J2+w9Z9RwZ5xPgtm+s=;
        b=MBzMFmBNjn0MTH2af44R3BriXwADfPcXXLV7yCtwsY2cDd6lALYOpbx7H6xphTiceu
         QM/2H7IXRT1hBxQE1RTQAjeaxrt/4SNCuD3i6f3auL4iIFb9JsDE+noWxbwWs/in2DTN
         TsF0oMQzMGBjWQDXAAR7AJyEvDreK1bG0W0id3JKyatlwlFyoZVUdwaZqaWw7UNjW4AW
         PFALFLfINxsyikpUSECJL9K5O7f2RsSnroxdRfzEILxTtVdE4j8eG7OfB+GQmsICjx3I
         IruS/dtZZtpulD+PZy/MFVwnHHMuwG1JNUYbdu5yA4s+Vi/um0h4r40pUSBKQPot19I5
         L5hg==
X-Gm-Message-State: AOAM5328CyJNIqhiELrFH9pmB2FL7N5RT9h7s8RmegIZrKNj+a1SmVDh
        ew78dPzsZ48tmwu83B9HRrRgHw==
X-Google-Smtp-Source: ABdhPJwD6mZ3l1v7npdR3R06Fu1vIMDRzVQSJrKew9+6JJdz0z3JBBQ7KHxq+ICMPQfnZUPlojP/Ag==
X-Received: by 2002:a50:9b12:: with SMTP id o18mr10609284edi.376.1618583892423;
        Fri, 16 Apr 2021 07:38:12 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:38:12 -0700 (PDT)
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
Subject: [PATCH 40/40] drm/mediatek/mtk_disp_ccorr: Demote less than half-populated struct header
Date:   Fri, 16 Apr 2021 15:37:25 +0100
Message-Id: <20210416143725.2769053-41-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:46: warning: Function parameter or member 'clk' not described in 'mtk_disp_ccorr'
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:46: warning: Function parameter or member 'regs' not described in 'mtk_disp_ccorr'
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:46: warning: Function parameter or member 'cmdq_reg' not described in 'mtk_disp_ccorr'
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:46: warning: Function parameter or member 'data' not described in 'mtk_disp_ccorr'

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
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
index 141cb36b9c07b..5276909a775fc 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
@@ -33,7 +33,7 @@ struct mtk_disp_ccorr_data {
 	u32 matrix_bits;
 };
 
-/**
+/*
  * struct mtk_disp_ccorr - DISP_CCORR driver structure
  * @ddp_comp - structure containing type enum and hardware resources
  * @crtc - associated crtc to report irq events to
-- 
2.27.0

