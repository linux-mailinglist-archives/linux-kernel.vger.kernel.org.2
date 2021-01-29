Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6906E308680
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhA2Hfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhA2HfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:35:24 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB031C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:34:44 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id f63so5677242pfa.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=btgeE7WFp2D5CajIBGg9VSazWzop69EBezIQPArUvCU=;
        b=TZR4kB1G2bNsAE+qgZ8eiVZhoITJ+kJe13lmCYltsK/S+Dl7QIbP0uBsH5bgPI1nlK
         oI6rLHMK4aoIka4pEUX/UaZdqrsDe3GfEj+RLGGD8VCrLhKe/Z2T/mTfIe/z7uJQCymc
         dbHh9mVrEHFEmklKptMB80KUEcUe4A8JcKnH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=btgeE7WFp2D5CajIBGg9VSazWzop69EBezIQPArUvCU=;
        b=iHmwUVBq47z/3pED1c82dt+HJVKGvUskNV7WQ9iiJtNJgxzri/EqjiCmzB4RzttAzI
         zKZy8+jnXo+O5eCbRgM14Jn6+0fo+sC2FDZaSNhoPkHqHii5QEOb3/UPc3b1NZsuH7YG
         rc/8F6aCncu/5NiEas8/BIJ0x5D2JC2o2otVDaXisXu+9Iwv1WV2/yhpy/fvnF9OC9+e
         MAo/KIEAeH0HKZCa04rLtqqzD0yHDCvUcs8IG5nupAhtemq2d2rx6r9D2nH0koZFg1Mo
         seApyYZWqVAuFXRiGB667F303gscdlsQgmJRVmcsd6JenUaLcrzNIJHeDe6VXIOq4uxr
         JMVQ==
X-Gm-Message-State: AOAM5310xchqxReWzkCTQbG6OZ1RKiGsxJIpO3QwFMqiK4fgdnej/UvU
        9P7+R/PFmVsVqFtN5tFNuj6oug==
X-Google-Smtp-Source: ABdhPJwGzKQhp5dhDV4z37t3vWRcdeRiZPfmH1ZQVoT8Y7zVZiDpWmQcW2Y/z2SYPG1flbKPmDszkw==
X-Received: by 2002:aa7:93a2:0:b029:1bf:23a3:a945 with SMTP id x2-20020aa793a20000b02901bf23a3a945mr3154824pff.70.1611905684192;
        Thu, 28 Jan 2021 23:34:44 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:51f1:c468:a70b:7c09])
        by smtp.gmail.com with ESMTPSA id p1sm7689980pfn.21.2021.01.28.23.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 23:34:43 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v4 1/8] drm/mediatek: add component OVL_2L2
Date:   Fri, 29 Jan 2021 15:34:29 +0800
Message-Id: <20210129073436.2429834-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210129073436.2429834-1-hsinyi@chromium.org>
References: <20210129073436.2429834-1-hsinyi@chromium.org>
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
index 5b7fcedb9f9a8..ccfaada998cf5 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -479,6 +479,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_OVL1]	= { MTK_DISP_OVL,	1, &ddp_ovl },
 	[DDP_COMPONENT_OVL_2L0]	= { MTK_DISP_OVL_2L,	0, &ddp_ovl },
 	[DDP_COMPONENT_OVL_2L1]	= { MTK_DISP_OVL_2L,	1, &ddp_ovl },
+	[DDP_COMPONENT_OVL_2L2] = { MTK_DISP_OVL_2L,    2, &ddp_ovl },
 	[DDP_COMPONENT_PWM0]	= { MTK_DISP_PWM,	0, NULL },
 	[DDP_COMPONENT_PWM1]	= { MTK_DISP_PWM,	1, NULL },
 	[DDP_COMPONENT_PWM2]	= { MTK_DISP_PWM,	2, NULL },
-- 
2.30.0.365.g02bc693789-goog

