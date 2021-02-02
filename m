Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3D630B950
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhBBINj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhBBINZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:13:25 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A8AC0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 00:12:45 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id n10so14380289pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 00:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CrTdRFcnWQzuRTgnluBbuBsSEw406Rl06q57E8Rqlko=;
        b=cXgC+/ID7uN0KeiEPRB8ZyCAqF/n44TWLPfMud8lHdekuNyRfsiUfhrv8rqsQONdqL
         j53Zj4C6D1B3jspMgWZw3MrYY0ar31fWmOjdBrCFcQIsBJT1/PjFjZ79tsFNMH8G9Rnc
         xJfNxJUQ13Oj+7H4l3/YlPd6dvClk/Abu3gOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CrTdRFcnWQzuRTgnluBbuBsSEw406Rl06q57E8Rqlko=;
        b=ah5TkducEhouxwLM9NWe35zY50HFjGROHyPvxpq/5PTtWwPeXJlXYeYVFEOzPEtEJo
         AVdVe2r/xjInkRfoVJOzIOcWdhiBg58DsWU312htBoCrCzoH5lIWq7qPbC6+l8sKfc9A
         GRG8ZBPZhwKb1Rbaugh5fRPdsLHIW/QpYCTaWkmABiP2Gk9o2jf2kkWSn+Az1YQyOek0
         lC/n/JvQHTTb2D4VU1XKoh3UZVKVUr6i59DWg9ub0esmELwQwdypJ1QmtegbXC/Zo0TR
         DxIcWXeqdwcUWNxR+hkWjFp3zA4/k6Ce0lJwowNE796VL6Y/A1DNL/9T+k2eX6eHuNt1
         uYmw==
X-Gm-Message-State: AOAM530vMgyvI76R5knpibhh8Z9nWYJoAfcbmCjC9PsXAh8l1tvmDlkN
        pBcnvIeCLyotrHgcCay1XWNv4w==
X-Google-Smtp-Source: ABdhPJzwA6TM5xlw4fGkgp1hD5x1e44JtTKG1EamjsOqepbXH/0fOeChNqzkXLXr2SIlSCiPFNYE0g==
X-Received: by 2002:a63:ec09:: with SMTP id j9mr11561675pgh.179.1612253565186;
        Tue, 02 Feb 2021 00:12:45 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:743e:7944:50c8:ff72])
        by smtp.gmail.com with ESMTPSA id c8sm21343325pfo.148.2021.02.02.00.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 00:12:44 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v6 1/8] drm/mediatek: add component OVL_2L2
Date:   Tue,  2 Feb 2021 16:12:30 +0800
Message-Id: <20210202081237.774442-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210202081237.774442-1-hsinyi@chromium.org>
References: <20210202081237.774442-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This patch add component OVL_2L2

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 0444b429daf00..b6c4e73031ca6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -477,6 +477,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_OVL1]	= { MTK_DISP_OVL,	1, &ddp_ovl },
 	[DDP_COMPONENT_OVL_2L0]	= { MTK_DISP_OVL_2L,	0, &ddp_ovl },
 	[DDP_COMPONENT_OVL_2L1]	= { MTK_DISP_OVL_2L,	1, &ddp_ovl },
+	[DDP_COMPONENT_OVL_2L2] = { MTK_DISP_OVL_2L,    2, &ddp_ovl },
 	[DDP_COMPONENT_PWM0]	= { MTK_DISP_PWM,	0, NULL },
 	[DDP_COMPONENT_PWM1]	= { MTK_DISP_PWM,	1, NULL },
 	[DDP_COMPONENT_PWM2]	= { MTK_DISP_PWM,	2, NULL },
-- 
2.30.0.365.g02bc693789-goog

