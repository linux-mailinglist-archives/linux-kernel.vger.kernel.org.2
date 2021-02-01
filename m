Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA2530A58A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhBAKjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbhBAKi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:38:58 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA70C061786
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:37:40 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t25so11808376pga.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AcC3toP6YBtCOgAxsdOHDHDQFB7sOehX2qicMsRRIyg=;
        b=NQWiLn9gqkxfhpJXhPNjH/PYK+Yr9dAPInm3WI34IERnw7bYbgIXtem1FdYDkW8wli
         64K+me37ilsz+RAdLo8ROqmhYolD78CcOhqqyCEuyDv3LO74AjJYWKhulVbPsQ+XOIu2
         0iOQ+0k+PpG79+HPSEUkeOPLejpZRw+LL1QOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AcC3toP6YBtCOgAxsdOHDHDQFB7sOehX2qicMsRRIyg=;
        b=RXCp3RNDyLx8Ha42SrToNN35CExB7meiVvwkEOibKgjtB6PEMirzobgt0fIBtCbAjY
         ymaAD7uDq2GcXJqJqyiQo9uN1A1pWS6rCWXlqwwmzSnKjR5tSjlHvF/vRKCaDhgnRmN5
         +0rTtlCf/zBRv6XuilDWqFgPn9EAdykteNlp0Ie0demReIJ6JMXHMNaiaVeO09gnGnQ1
         aIoQwZwmzrMKwQTv7RpPS/FOEV0VQU6oVpKwUK2lLeiNwwmEVKE/bkVGQg4+JVqjxFcd
         qySWNbNm0/XG5pbBtY9zLOSsCtPNdnOQ4kEZcUv/Op+k2V6IB2zQmOie0xlMg+1dfxhU
         O4CQ==
X-Gm-Message-State: AOAM530CX08p9Ap2jZNGnDzXxnJjJZpRRg8qI+kZ/nl5GS7cdTCeiELi
        lR3nojea5fgNs+4LWmBti2mg8Q==
X-Google-Smtp-Source: ABdhPJyUJ0L9tWtBFh4v728vZPdOlcLKa6aRR4/JhTB0dvIReHwHwY4rPdSJH0Uc5AnHITGs61Vddw==
X-Received: by 2002:a63:1c08:: with SMTP id c8mr16542759pgc.228.1612175860174;
        Mon, 01 Feb 2021 02:37:40 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0cd:1b84:6d56:68e1])
        by smtp.gmail.com with ESMTPSA id 76sm17610356pfz.174.2021.02.01.02.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 02:37:39 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v5 3/8] drm/mediatek: add component RDMA4
Date:   Mon,  1 Feb 2021 18:37:22 +0800
Message-Id: <20210201103727.376721-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210201103727.376721-1-hsinyi@chromium.org>
References: <20210201103727.376721-1-hsinyi@chromium.org>
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
index 7a6efc849694b..d884807809635 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -494,6 +494,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_RDMA0]		= { MTK_DISP_RDMA,	0, &ddp_rdma },
 	[DDP_COMPONENT_RDMA1]		= { MTK_DISP_RDMA,	1, &ddp_rdma },
 	[DDP_COMPONENT_RDMA2]		= { MTK_DISP_RDMA,	2, &ddp_rdma },
+	[DDP_COMPONENT_RDMA4]		= { MTK_DISP_RDMA,      4, &ddp_rdma },
 	[DDP_COMPONENT_UFOE]		= { MTK_DISP_UFOE,	0, &ddp_ufoe },
 	[DDP_COMPONENT_WDMA0]		= { MTK_DISP_WDMA,	0, NULL },
 	[DDP_COMPONENT_WDMA1]		= { MTK_DISP_WDMA,	1, NULL },
-- 
2.30.0.365.g02bc693789-goog

