Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C816030A583
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhBAKih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhBAKiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:38:15 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D39C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:37:35 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id s15so9731125plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CrTdRFcnWQzuRTgnluBbuBsSEw406Rl06q57E8Rqlko=;
        b=WpMFU6q6a/odWPME6nItLViwl7Dk4d/YMVq+6O3MTBuys+RR+6xKK03+6xWYZNQafu
         RCjRWP/ZuL1ErIm/I3aJFJ7UJdIxuBHrlni6lXyJgfGmYkZ6IL9N4OHN7FsIbhgvD/w4
         HWvvHyAZkaZC4yYPDYo/sf8u4/vJZasNpbUp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CrTdRFcnWQzuRTgnluBbuBsSEw406Rl06q57E8Rqlko=;
        b=KKT6cylnAxmFZpizkXkN50ZW2Jl3XOYmxUUk6tnHZ+kVN4PPzDV+NjVBxEh0SxNqn9
         4gpBF6YWIUnPNMnWql+rXo5MyE83VMAxiksPYlT70gaPyBXck+PnJvSdO3Vy7lHPZyAR
         QFpdBEhcl66gp2MflTNrbTXXjVhhoeeLTr8gPGHmOBnc86E933QzwWilVwsWAqzRxyoe
         na3SpFMmZD+s+EQ6X0saQNKM6hG4aSfQ9W1OLugRK6I9ReA/1+FervBg01djpaDe5MSM
         P+MC751NPrPRFbf1cySE9xkLb5eCmDvmChO9/s4AInRpRbYexLY/I/e2Jjz+Ybub/uIz
         zcuQ==
X-Gm-Message-State: AOAM5337mUhK7IdTIwHJO4yYi/9MnSY5DN/hXYTyYC8bZvSCLAC2M3a1
        EUhAxqFVBnBxwin3jnqQbZllhA==
X-Google-Smtp-Source: ABdhPJy/H/X+tkbdFrbG/4/lVmtjqOFlXPhdSQz3Lua3UzweTfJfL6z3kMdFS1JR99nvh6s9hj/6yg==
X-Received: by 2002:a17:90a:f0c4:: with SMTP id fa4mr15709655pjb.132.1612175855167;
        Mon, 01 Feb 2021 02:37:35 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0cd:1b84:6d56:68e1])
        by smtp.gmail.com with ESMTPSA id 76sm17610356pfz.174.2021.02.01.02.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 02:37:34 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v5 1/8] drm/mediatek: add component OVL_2L2
Date:   Mon,  1 Feb 2021 18:37:20 +0800
Message-Id: <20210201103727.376721-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210201103727.376721-1-hsinyi@chromium.org>
References: <20210201103727.376721-1-hsinyi@chromium.org>
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

