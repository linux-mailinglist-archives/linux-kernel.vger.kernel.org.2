Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D724C38AEAD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242586AbhETMn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241464AbhETMnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:43:13 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BBDC056489
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:02:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h3-20020a05600c3503b0290176f13c7715so5059864wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71fOhHlO0apSNak4OgEIaxdLa+/aWkYj9kGsKGdRvTY=;
        b=yVNkE6LMgKRrm9L0PXzODtlbyrkJccI6tBlQKP5YfbFApvsFNWrsZlQrQUFfUwvQcH
         O89HKrq3dcoAIZ3K/9+IBkK5k8wTEwbsLnZbG4BGSXV8MjBRV36AU5mBa6tXbSB4TsOX
         Sink0gYtfRxJ5amdGUYoTJTqpdBFZ1A1RaJBuErq62rN+wWD6KPiOkK9SSTiBM3T6+yb
         pPUn+fvRnwU/0QN4Bg6/AcKQMBGBh797AmO2z6uXHyghSAG3BEA19YG1XX3sgCUH9rrV
         /lNhbYEunHaq4jQtRtzIwjb3olvNWsqGcTSWxf59i6Ef+ZnlVM1y73ZPKeWdGeMABZPV
         fTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71fOhHlO0apSNak4OgEIaxdLa+/aWkYj9kGsKGdRvTY=;
        b=gOepkazMFZTb61FSACBM3vmsAszOJswHAbv/xKpYitijovwGEUi0OVbZm3HoUuvjsy
         cAbTzwD9V7ZBxp//2eDbMDLN2Z/AvovyAKon9TGgoPff1BqrDnpzM+VjKULw7hxCov3f
         q6NmzQS6r3HlCpozTqkq7hVjAcoYOhzY8srg48xTKVYf33ySUzLlYXWahuLAYUzmk7LI
         lc/E8zGMuBt8Toe+1j0cfmVduerhj1KC5bK1ygqcicypWUwC5fIgRhjRueASvGRoYb+G
         0Q0XUEtU9DxV5FD32t5CKycvaMgWG8cgfJaK56XS9iXx/wQ8gaDh7jODoxUJ08LTNE4Z
         9eNA==
X-Gm-Message-State: AOAM530oFS+kbUxMSi8TMJ9cpTYvSOnkBF/2KoE65ltuvrunI9dN5nT5
        LJhtXC+DDPKqmTBiW0TpSwWqJw==
X-Google-Smtp-Source: ABdhPJzL+TBqXQbBCqdO0J1TpltSMujA87+5MzgL9bvbaSIHTDzj0jzbKDSNOe+5REQBbMAiOcQ72w==
X-Received: by 2002:a1c:7c03:: with SMTP id x3mr3760475wmc.168.1621512177173;
        Thu, 20 May 2021 05:02:57 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:02:56 -0700 (PDT)
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
Subject: [PATCH 05/38] drm/mediatek/mtk_disp_rdma: Strip and demote non-conformant kernel-doc header
Date:   Thu, 20 May 2021 13:02:15 +0100
Message-Id: <20210520120248.3464013-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
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

