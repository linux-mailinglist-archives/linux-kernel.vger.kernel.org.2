Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE8E36C4DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbhD0LRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbhD0LQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:16:51 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C931EC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:16:07 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a12so1304231pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6wyv4G/lQ/EHY+nAhCaUf35r1FQBf2AesHuDPMoclw8=;
        b=EbDbUiG+s/5bKjIABss2BCP8TiPWspaaME+mSIBSYp3DybGob+DWyGvrhulQRVeADI
         rAg5U8NNWmpFbJk532ChdfH6hzLsJZ6kGlsdiWvKCO4RPDDodrz7wm6lKyScbKYpERGd
         9YJG/n/VxxcJ9zfCW6bpu+qkojFg1iJ4FoI/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6wyv4G/lQ/EHY+nAhCaUf35r1FQBf2AesHuDPMoclw8=;
        b=UHlZdSj8AeOV6VvNFO1DwjU52EPqACS8RpG5hlzywHVqgY0OEwOeiUJPqkTASUwmgM
         TOt9fB+79M1QwUi+0COKsSPCT6skWkQJNVKaG5xdD+rtM2WFgORI/6OVRriuPiKiuwqi
         8DNfpRC7/mqlifDMfAJ0zHJai4VZg0rmJk78RMwfmCHrW2CFMa419nVy/H8TBcMGVhn0
         hexAJhjTAnetqj/mDBMa09TOIwjUBaveg1+AgZgyIE+zHuOuRRZEcx8wD6FETpwnfMTQ
         9kP3uUFW/8lei+EAQy86lNt4C8ijWv6vihQt+cKqgzaGucG2Ob6h0Bg9S7oqtmQph6ao
         3PTw==
X-Gm-Message-State: AOAM5328QN2vWHbEe2XQpBp4GUoKF3BoRjW8AKY5Kj2IOFdC1ojwsmyS
        qpCtbJf9sKYQLjmqZEbccYqMvA==
X-Google-Smtp-Source: ABdhPJxaFfZSnDofdrzYmCyzQRCADWHb3fdCONPpxa6HA2xpTld/7zf54fUs0nthxozgfrBcJR/Cqg==
X-Received: by 2002:a05:6a00:170c:b029:225:8851:5b3c with SMTP id h12-20020a056a00170cb029022588515b3cmr22453831pfc.0.1619522167429;
        Tue, 27 Apr 2021 04:16:07 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:b182:d363:32d0:53a2])
        by smtp.gmail.com with ESMTPSA id c21sm2347210pfc.165.2021.04.27.04.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 04:16:07 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Hirokazu Honda <hiroh@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v4 11/15] media: mtk-vcodec: vdec: Support H264 profile control
Date:   Tue, 27 Apr 2021 20:15:22 +0900
Message-Id: <20210427111526.1772293-12-acourbot@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210427111526.1772293-1-acourbot@chromium.org>
References: <20210427111526.1772293-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hirokazu Honda <hiroh@chromium.org>

Add H264 profiles supported by the MediaTek 8173 decoder.

Signed-off-by: Hirokazu Honda <hiroh@chromium.org>
[acourbot: fix commit log a bit]
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 .../platform/mtk-vcodec/mtk_vcodec_dec_stateful.c     | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c
index c5538fcfc9a5..d815125c81a4 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c
@@ -611,7 +611,16 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
 				V4L2_CID_MPEG_VIDEO_VP9_PROFILE,
 				V4L2_MPEG_VIDEO_VP9_PROFILE_0,
 				0, V4L2_MPEG_VIDEO_VP9_PROFILE_0);
-
+	/*
+	 * H264. Baseline / Extended decoding is not supported.
+	 */
+	v4l2_ctrl_new_std_menu(&ctx->ctrl_hdl,
+			&mtk_vcodec_dec_ctrl_ops,
+			V4L2_CID_MPEG_VIDEO_H264_PROFILE,
+			V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
+			BIT(V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE) |
+			BIT(V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED),
+			V4L2_MPEG_VIDEO_H264_PROFILE_MAIN);
 	if (ctx->ctrl_hdl.error) {
 		mtk_v4l2_err("Adding control failed %d",
 				ctx->ctrl_hdl.error);
-- 
2.31.1.498.g6c1eba8ee3d-goog

