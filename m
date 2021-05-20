Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251FB38AEB2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241519AbhETMoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241576AbhETMnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:43:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958B4C056488
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:02:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q5so17382864wrs.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMlp5Ni2aMFHyMfn1NEHDx/+WQIjP8upodgZGGEhVrs=;
        b=gJ5vwtlJY7kaNteg3cWUjwJv5QuZOeibKsxrj//n0jDmkoKtte74LApZcTlPr3qEqP
         Mzlsm32bjp2uf3LzaVXTu+oFZkLGE4pTbES/qflCNupCozcEmwvchzxKRUHqTfRKpNXs
         zEicCevttpN4sMsTEZ94vVRt504daIkzMKuLcw3vq1J0PIZIfEVUUHhct/UQaU/ZB9gx
         J5d4neL47KFQgbcS03O3OV+qSvgERINie9CzvOoS3MZgvX8kCZhOlq8BmHybvhU7Ozwz
         RqTuE8aFs3eZ8FW0ANRkzgtq4JeJkrDEZqY6jD+Talvm6SYqqFJfG/V/DGQCZbqQ2YnC
         QGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMlp5Ni2aMFHyMfn1NEHDx/+WQIjP8upodgZGGEhVrs=;
        b=gn6FZ4H5rhIa/GKdcwRck9Us+YUK0v7c19tF+aZBvmcydSz+l3QsCaot6Lzlnieex8
         FbyXIEGvooxOu1oP1ZOO/tAAQJ6r8tUyxv3sYFhQ8cSAUBHI1wdz5ZUpAU4KjGA9gCf5
         7HiJ4xN+GQLqPO/pVIvtqCB1CpoyoJQ9VSIY/kg2diP0w1un3STaR468r6tkU/eoHG5a
         Y5tWjSsR58yeSUKt74H5sLRI5Ues/DytRoodMHmJoavOsr+AXWwdnmoVxieCX0UvWAmi
         1NquKn3n77xGbtSi+KsHwvPKchwOOELE+9txxocEq/g00F0bOKTJAJ8pGiHAGrASvzzU
         qXoQ==
X-Gm-Message-State: AOAM532mIxMRbJGLawvnD4CbLslsL6enb03OmdZpj466h3o8Hrg+seCD
        n9/KV7EAeHV821b+ZOj0b6TWpg==
X-Google-Smtp-Source: ABdhPJxP35SmgHpjJBCWNK5+CE0sT2ZLGFbHSqTr5K3epue7/zsIbU6Tm4drzmp4lFX5MYElIP+/cg==
X-Received: by 2002:adf:e291:: with SMTP id v17mr3940756wri.149.1621512176218;
        Thu, 20 May 2021 05:02:56 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:02:55 -0700 (PDT)
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
Subject: [PATCH 04/38] drm/mediatek/mtk_disp_ovl: Strip and demote non-conformant header
Date:   Thu, 20 May 2021 13:02:14 +0100
Message-Id: <20210520120248.3464013-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
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

