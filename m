Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0C730868D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhA2HhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhA2HgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:36:06 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B612CC061788
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:34:49 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g3so4791921plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ZWXOVsKIxcx+tGQm76xdUBCxirqlUu+mbOtPxuu9AE=;
        b=leoqf+1hTP4H2PyDaC2xZP2m2uUPHXR5pGWVrCK34boQBgu2ADdiKOqVdRJgQEo9TR
         9p5kv+xcuqa2WJcl5zK1Yna/BxYoBX7gGOnDfNGW5F/bl6VGwU01ceEpKkCgBgW9t8Ij
         cw0EJ04W3ir5FmuYOVsxM491joxVdzFf9M60s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZWXOVsKIxcx+tGQm76xdUBCxirqlUu+mbOtPxuu9AE=;
        b=ktXHMP82/w9U0YMPaPxFT07NTZfqgBPbHI/BvduWvuzSW9nU1vNZBjq++sDQW0Xywp
         +H+jOBUISPW9ccZ7eoYz6DrczYAk6JhR0fs+ng2yO3Zab7VyS8e0cPa+BOqpoZ7FgBlX
         klCRaO8OV4jPZn2IoeDm49b2m+9wmYj8fo4PJpoeP3FD0DKXNyA3sHvK9eocgOq9rV2D
         EE6v53pYmqe/E3KISQNJUe72OlmFQbJ1gJYK3Qjn8b+FKGHP9nFZTIlEHbzz4euTpTf3
         I09LAYqFAHu+thUrUIuzzeAWg/UWj7O895gkLNjeonw6JsY0yRKrZLX/8BXRX9IuEizv
         Bm6w==
X-Gm-Message-State: AOAM533ACy9zL15eJ3C9Q/dH9t1dzW4nbFR0/JGVfM3PGjm2QebHfpoy
        INHc5rviiLxxofey7vQytVtzLg==
X-Google-Smtp-Source: ABdhPJzFhYJSIIxoG5CMdSpK9JhxCqNvNkZfWnMW28x1fFvVi+kdtvyTLL/rylCjR4CSvx9Vq84J5A==
X-Received: by 2002:a17:90a:cb0f:: with SMTP id z15mr3446744pjt.88.1611905689225;
        Thu, 28 Jan 2021 23:34:49 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:51f1:c468:a70b:7c09])
        by smtp.gmail.com with ESMTPSA id p1sm7689980pfn.21.2021.01.28.23.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 23:34:48 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v4 3/8] drm/mediatek: add component RDMA4
Date:   Fri, 29 Jan 2021 15:34:31 +0800
Message-Id: <20210129073436.2429834-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210129073436.2429834-1-hsinyi@chromium.org>
References: <20210129073436.2429834-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This patch add component RDMA4

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 6c539783118dd..543cbfc9c5d85 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -496,6 +496,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_RDMA0]	= { MTK_DISP_RDMA,	0, &ddp_rdma },
 	[DDP_COMPONENT_RDMA1]	= { MTK_DISP_RDMA,	1, &ddp_rdma },
 	[DDP_COMPONENT_RDMA2]	= { MTK_DISP_RDMA,	2, &ddp_rdma },
+	[DDP_COMPONENT_RDMA4]   = { MTK_DISP_RDMA,      4, &ddp_rdma },
 	[DDP_COMPONENT_UFOE]	= { MTK_DISP_UFOE,	0, &ddp_ufoe },
 	[DDP_COMPONENT_WDMA0]	= { MTK_DISP_WDMA,	0, NULL },
 	[DDP_COMPONENT_WDMA1]	= { MTK_DISP_WDMA,	1, NULL },
-- 
2.30.0.365.g02bc693789-goog

