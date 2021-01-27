Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D2A3051E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhA0FTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbhA0E5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:57:55 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A71C061788
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:54:40 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l18so581804pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HSBHxC6BVq05Sqe74BC637dMAggq9obPvY1bN+IbxX8=;
        b=QLrYujKWg6brD9Dn4569hiEZyanZ/c1eZlO9Y8Xkr3ZSqZ1GIkkMBWnx2iweqHKFzN
         98LgtgS7J1HKyPBfvqi3D+M21Balppe5d6zFiEFpyw+/iVnP8zFYOM+lB8LdHlVKjcOr
         XiAKpeDyKeqCp9VkmeyO3GpLbsopCwWYpXvAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HSBHxC6BVq05Sqe74BC637dMAggq9obPvY1bN+IbxX8=;
        b=TwfHfmuRjLeEeLD2OEKUVPeCcHPJHiq983jqfRoBTlxHBxpB9CAs45hkLTO2zEUxk6
         oGBRGAFcpVTexPUqxlD13yR368c7y/IDxuTR21AyVOMZGTdhV3GPgz3IacGbNRIxtpco
         pObubxzBByBVbDDDSfPhMNPmaVfoDDD4vNiuQ05fWjJIJJAbs6JBrFH43TT6jHdfCXBF
         Yf2TOq0G9QvDsb4qy8gNutjUGWzJZOYS71b29ijOziUNAiyhmXdGgrU0G9c7YZSqZPwJ
         HIqQDQWcG9NDJc/RtfgY7jVUvFOIFPC9OGkO1Ij0WkBtfYBoT66gGe0Fok7Pdia1TMz1
         4v9Q==
X-Gm-Message-State: AOAM5317gJfFzuoihSbUjAnUoHYLJGnIyvNTSne23tgCIsBZO07CyeKh
        wznT7z2O1dTo5s/bUIaoO+7gVA==
X-Google-Smtp-Source: ABdhPJy/lxAmlDmjnchY5j6fyQaiGPSUiu+V7cni9mncc8A/hA+9bzzULC0varJkx+Ggb//BqKRJVQ==
X-Received: by 2002:a17:902:70c6:b029:df:d62a:8c69 with SMTP id l6-20020a17090270c6b02900dfd62a8c69mr9586813plt.20.1611723280370;
        Tue, 26 Jan 2021 20:54:40 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e0a5:d2fc:aaad:1e4a])
        by smtp.gmail.com with ESMTPSA id a141sm684484pfa.189.2021.01.26.20.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 20:54:39 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v10 3/9] drm/mediatek: add RDMA fifo size error handle
Date:   Wed, 27 Jan 2021 12:54:16 +0800
Message-Id: <20210127045422.2418917-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210127045422.2418917-1-hsinyi@chromium.org>
References: <20210127045422.2418917-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This patch add RDMA fifo size error handle
rdma fifo size will not always bigger than the calculated threshold
if that case happened, we need set fifo size as the threshold

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index b84004394970f..04b9542010b00 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -168,6 +168,10 @@ void mtk_rdma_config(struct device *dev, unsigned int width,
 	 * account for blanking, and with a pixel depth of 4 bytes:
 	 */
 	threshold = width * height * vrefresh * 4 * 7 / 1000000;
+
+	if (threshold > rdma_fifo_size)
+		threshold = rdma_fifo_size;
+
 	reg = RDMA_FIFO_UNDERFLOW_EN |
 	      RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) |
 	      RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
-- 
2.30.0.280.ga3ce27912f-goog

