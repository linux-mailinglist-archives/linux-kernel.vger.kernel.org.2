Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFAD3260E8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhBZKGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhBZKEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:04:08 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9717DC0611C0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 02:02:32 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id l2so5941028pgb.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 02:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/m9GfFw0MzWCiAlloHYC1CIUxqu/1B3ra32N28sGndM=;
        b=aScOQ4MRcOlglRBfncxwkth7ehHiLsqgplM12LYDfpJitm67IvT1WHUFAhl319dqjJ
         xUcB5q/+OetxdpwVx2KyjHix5Yn3a8AnD9YgsyeH0iRnYpM1tCv8oQ7pNWuvIvfnvXzI
         XDWDiS8e7uLrGVW/nWGrDHzTXTfXPhNxlIC2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/m9GfFw0MzWCiAlloHYC1CIUxqu/1B3ra32N28sGndM=;
        b=PhcC/olJZ+PxyFjHC1tsXO82NGP3Scm1Sn+CyakgvFox2HTe9VXO+oE9EGNxgeNhTn
         yiSgWmp8ptRB6Z5pSkjP6+t05NustDwT1+2xvodvLzdUPSJWUPulZorRagBdDfevnEHi
         +DjJW0usvoCj8xkiLdAC3DhvXcjrt28R5+NwsjZMfieo+ERXx0XdljmljFFGX7C1Aisg
         0v5Pn7awvOdFhYoQeZE3n/AV4CYw3VPnNlI8QHCAKVZXWL3ANWqL4nPZrChHkixG8iGw
         6XZkyWdupK8FPhDq8bhRD/N0M96F+301of7At8sTVlurK2hc1yv8rO5SaH2KMyVNWn8g
         Ppbw==
X-Gm-Message-State: AOAM532fdlOrkN4qP7euPdAcwuFbLWVgEy9zGwdixTOH4+zSgi/7PlkJ
        U+8P+q4/x7fqMXopFnrcA5wtKQ==
X-Google-Smtp-Source: ABdhPJzu+huZfKSj3BcpG4Sp46b2XI6By+Nh+9mV7RSGM8YSvyvupXS84VwTbmrHlv2tulwVuE4fMA==
X-Received: by 2002:a63:f202:: with SMTP id v2mr2248344pgh.24.1614333752258;
        Fri, 26 Feb 2021 02:02:32 -0800 (PST)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:5c91:233c:dd5b:b1b0])
        by smtp.gmail.com with ESMTPSA id o23sm9201565pfp.89.2021.02.26.02.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 02:02:31 -0800 (PST)
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
Subject: [PATCH v3 11/15] media: mtk-vcodec: vdec: Support H264 profile control
Date:   Fri, 26 Feb 2021 19:01:44 +0900
Message-Id: <20210226100148.1663389-12-acourbot@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210226100148.1663389-1-acourbot@chromium.org>
References: <20210226100148.1663389-1-acourbot@chromium.org>
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
index f9db7ef19c28..3666c7e73bff 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c
@@ -591,7 +591,16 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_ctx *ctx)
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
2.30.1.766.gb4fecdf3b7-goog

