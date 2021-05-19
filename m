Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A103890D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347667AbhESOcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347594AbhESOcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:32:00 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF63C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:30:40 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q15so9570608pgg.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H/JegrmtPw3esG/3ONCAiiuwrewSM2bmGc32IKl+Wak=;
        b=e/0683k5vnhao0MCIfGZACYaPEVYU2bl/WZxt7NjbMOfkAlfCxAViAbId0UB7Odl5V
         SsztA8+oVVyffcTEsp5QwfYpVYqZk+652QCCg/MwyMdZO/HdZY071TP+ofLANRFg7oFM
         pcjAJ9UprGKmqPVzdvMePFt3nDM7UKv2N3RiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H/JegrmtPw3esG/3ONCAiiuwrewSM2bmGc32IKl+Wak=;
        b=d6UHa5bMcM2EFtJ91Rne8zwGLSn9VTyNm3ScbljarQcM+R1l9b+4FpiuGRwxNDl1RT
         cxz+uePiwYeR7HOsYBssk/ga67byJ+uJU1ONb698hyoY0TH8s3EDSwN4XfWkefklrOJs
         FbO222I+4Mli8plIkHeGRjWhKvGb/LB2WGzIv35ozBjdrlAsWKJaAZHA7ELBt9Hkg1Fg
         7W2vlbKIEsJXmdhrx7JjhAIhoRigqN776b3fpPQw8NTS8rOFB0mMOKUPqC8Dt4xsvO7+
         ovGF7nf434SF73mrlYs2lAC38I9m/tpiYRjRH4yDbMzSbgsAprYRFHK0FDjt/zUk8usG
         R39A==
X-Gm-Message-State: AOAM530SNjUF2dPWG4r0eCOAi6swQYU3Ib+e2/QMOTYehSpJkKN+mnZA
        16CXOa6Vr5d1utpsI1AvwzKqmg==
X-Google-Smtp-Source: ABdhPJwj+dDw2M/xBSoFiLwfOMAGPnq2OgavxTLnltYVk7rgjWKTjHRU0Xtzoj+g2ZXxX7RNqOlCsw==
X-Received: by 2002:a63:38d:: with SMTP id 135mr11417309pgd.285.1621434640225;
        Wed, 19 May 2021 07:30:40 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:87ab:ff82:1544:697])
        by smtp.gmail.com with ESMTPSA id 3sm14337661pff.132.2021.05.19.07.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:30:39 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Hirokazu Honda <hiroh@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v5 01/14] media: mtk-vcodec: vdec: Support H264 profile control
Date:   Wed, 19 May 2021 23:29:58 +0900
Message-Id: <20210519143011.1175546-2-acourbot@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210519143011.1175546-1-acourbot@chromium.org>
References: <20210519143011.1175546-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hirokazu Honda <hiroh@chromium.org>

Add H264 profiles supported by the MediaTek 8173 decoder.

Signed-off-by: Hirokazu Honda <hiroh@chromium.org>
[acourbot: fix commit log a bit, move to mtk_vcodec_dec.c]
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
index 56d86e59421e..8df8bcfe5e9c 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
@@ -1421,6 +1421,16 @@ int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 				V4L2_CID_MPEG_VIDEO_VP9_PROFILE,
 				V4L2_MPEG_VIDEO_VP9_PROFILE_0,
 				0, V4L2_MPEG_VIDEO_VP9_PROFILE_0);
+	/*
+	 * H264. Baseline / Extended decoding is not supported.
+	 */
+	v4l2_ctrl_new_std_menu(&ctx->ctrl_hdl,
+			       &mtk_vcodec_dec_ctrl_ops,
+			       V4L2_CID_MPEG_VIDEO_H264_PROFILE,
+			       V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
+			       BIT(V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE) |
+			       BIT(V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED),
+			       V4L2_MPEG_VIDEO_H264_PROFILE_MAIN);
 
 	if (ctx->ctrl_hdl.error) {
 		mtk_v4l2_err("Adding control failed %d",
-- 
2.31.1.751.gd2f1c929bd-goog

