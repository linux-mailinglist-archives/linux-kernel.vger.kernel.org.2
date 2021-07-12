Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5319E3C5A54
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbhGLJuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346071AbhGLJtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 05:49:52 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F39CC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 02:47:03 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 62so17691366pgf.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 02:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ka9MgwmW5QsHbE3oC7CaA6AD1jb4S5a4fPDgxsbWrLU=;
        b=WHVTpBseJgLMnGqaa+1RqcoNPqyIUkmougt9lWoVSXdb1vDOPYvj9eqascjIEXhUfU
         qC8HnRP3UKSYTTDn1FHNirspfOX/GrqUkMSGuMwPyC7KDJ2ek5pBGzf+qFGiT3Idzqba
         i7rp4XxeTPaLwnY1OxOE89C796t1Nwq7aSat8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ka9MgwmW5QsHbE3oC7CaA6AD1jb4S5a4fPDgxsbWrLU=;
        b=k6PFOoKNMDoLoGDztN2HAfmrzNp2gadUmYWlW8PcXXwI/tF8w5Ht3XJ1H6xR4RvAvp
         xd36Atm3GzjwQ1brn+xwyJPK0OgvLd5xGE1XK+iboImmGo/BqQsyp0GgFr2J6AtT0N1v
         8SG7hqdh9y33551Tp5orqiSqKvRK7zLQZ1Abt97PqjjPAGttsRh9MC90JQPKiD0t54Xn
         ns9nX7bomwwvqQ6SrgVCwev79FD14T9sry8ej2Hdf+uPTUjFnrKr/2GuOjVDrtNXV8OK
         Jn/3+5s3lxIsmyqRo12cEuwpcllLJ4D8dA17gEFqNROz3HQwyiASAruC13fnDJDo7o63
         6/Dg==
X-Gm-Message-State: AOAM533ppOMVDehsyaUv5jghWHI/ihiKPDNtn6ctwLrGDdeh004NXaJW
        unOwQyZ07GfoYXPVj6zSmvaIDA==
X-Google-Smtp-Source: ABdhPJzu+zuvDdKs4oR5z4/fiaSC07w3RNE3ZQ7jClgmYHqoH/5VyU8uRrV+hg7Lxiz2yMeqaJj2+g==
X-Received: by 2002:a05:6a00:98b:b029:32a:d9a5:2540 with SMTP id u11-20020a056a00098bb029032ad9a52540mr8333872pfg.66.1626083222436;
        Mon, 12 Jul 2021 02:47:02 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:6e22:4686:299f:5f2a])
        by smtp.gmail.com with ESMTPSA id 10sm14631650pjc.41.2021.07.12.02.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 02:47:02 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mediatek: mtk-dpi: Set out_fmt from config if not the last bridge
Date:   Mon, 12 Jul 2021 17:46:57 +0800
Message-Id: <20210712094657.1159299-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

atomic_get_output_bus_fmts() is only called when the bridge is the last
element in the bridge chain.

If mtk-dpi is not the last bridge, the format of output_bus_cfg is
MEDIA_BUS_FMT_FIXED, and mtk_dpi_dual_edge() will fail to write correct
value to regs.

Fixes: ec8747c52434 ("drm/mediatek: dpi: Add bus format negotiation")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index bced555648b01..25c565f9179cc 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -610,6 +610,10 @@ static int mtk_dpi_bridge_atomic_check(struct drm_bridge *bridge,
 
 	out_bus_format = bridge_state->output_bus_cfg.format;
 
+	if (out_bus_format == MEDIA_BUS_FMT_FIXED)
+		if (dpi->conf->num_output_fmts)
+			out_bus_format = dpi->conf->output_fmts[0];
+
 	dev_dbg(dpi->dev, "input format 0x%04x, output format 0x%04x\n",
 		bridge_state->input_bus_cfg.format,
 		bridge_state->output_bus_cfg.format);
-- 
2.32.0.93.g670b81a890-goog

