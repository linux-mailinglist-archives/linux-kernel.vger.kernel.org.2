Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E1736C4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbhD0LRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237848AbhD0LRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:17:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257F6C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:16:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 20so26735479pll.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRYcC6JRMw2HH5N7Fjj9wmX95hNIxpHhk8y6CWjmLf4=;
        b=VEoRlYzOjro25RCira7dZDbU9ivfml8G3QGRi5jr5OzbSxfkFjaMLB8rL7OEqRodtX
         X11RuP0ja5lnP5ZDa//HZEpZgbvEC2yJhuKKOe36lKgnYPShoEzemRfNUmM4vojdMOA/
         15qnFsRA9w5pBqg3DYcsNu+z9923AbSPiHMjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRYcC6JRMw2HH5N7Fjj9wmX95hNIxpHhk8y6CWjmLf4=;
        b=D13n8WhwwPHU8j3A8waOzrW9ihF2I+usuAryxlEGypKr5LPlHvOrt14oGEtoB3cZuT
         VXYr0+s2m5+wgwlRgHXkLw11EETF32mWl9hI3RvX/2tOXckxcRB/MoHQjYv56kQT8W6q
         AH66xl0mlCuofVSvwJ1rymB6BRn6qgfR78tzD5EMt80NPEL1hjnX4QkkMq4vVBcg30LV
         M2w8bmF8RXiXdE0wnyra41oipQututA6X3w53wterGCjxIlDT8QY4iMWNCpYp3KH8SOZ
         yXS1ol+YpxBz+Guq18Y7O1DheQVutnMV2qzEt6HrjYkRbPOsOs3LihiB5ggCTH5a/cY+
         2tgg==
X-Gm-Message-State: AOAM531xlR7IuqfFJsTyCbg/ShOQ+b9JSTiDepSkl/FWd5UKCgEvdcPE
        7aC+K+MdTGSBvWg6rZ83uWmu3w==
X-Google-Smtp-Source: ABdhPJwl4Wn0JO9a4KyCbxWyRN2pBdg2gooU24WpXrrZ9iR3prEelIYI1svQrYGlmDDCokocMtCmfg==
X-Received: by 2002:a17:902:7892:b029:ea:b8a9:6190 with SMTP id q18-20020a1709027892b02900eab8a96190mr23934992pll.80.1619522178794;
        Tue, 27 Apr 2021 04:16:18 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:b182:d363:32d0:53a2])
        by smtp.gmail.com with ESMTPSA id c21sm2347210pfc.165.2021.04.27.04.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 04:16:18 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v4 15/15] media: mtk-vcodec: venc: make sure buffer exists in list before removing
Date:   Tue, 27 Apr 2021 20:15:26 +0900
Message-Id: <20210427111526.1772293-16-acourbot@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210427111526.1772293-1-acourbot@chromium.org>
References: <20210427111526.1772293-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hsin-Yi Wang <hsinyi@chromium.org>

It is possible that empty_flush_buf is removed in mtk_venc_worker() and
then again in vb2ops_venc_stop_streaming(). However, there's no empty
list check in v4l2_m2m_buf_remove_by_buf(). Double remove causes a
kernel crash.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
[acourbot: fix commit log a bit]
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 .../media/platform/mtk-vcodec/mtk_vcodec_enc.c   | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 8058331dc553..4701dea251ca 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -945,9 +945,21 @@ static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 		}
 		/* STREAMOFF on the CAPTURE queue completes any ongoing flush */
 		if (ctx->is_flushing) {
+			struct v4l2_m2m_buffer *b, *n;
+
 			mtk_v4l2_debug(1, "STREAMOFF called while flushing");
-			v4l2_m2m_buf_remove_by_buf(&ctx->m2m_ctx->out_q_ctx,
-						   &ctx->empty_flush_buf.vb);
+			/*
+			 * STREAMOFF could be called before the flush buffer is
+			 * dequeued. Check whether empty flush buf is still in
+			 * queue before removing it.
+			 */
+			v4l2_m2m_for_each_src_buf_safe(ctx->m2m_ctx, b, n) {
+				if (b == &ctx->empty_flush_buf) {
+					v4l2_m2m_src_buf_remove_by_buf(
+							ctx->m2m_ctx, &b->vb);
+					break;
+				}
+			}
 			ctx->is_flushing = false;
 		}
 	} else {
-- 
2.31.1.498.g6c1eba8ee3d-goog

