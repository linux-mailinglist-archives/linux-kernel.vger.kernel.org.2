Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAD732AE6B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360959AbhCBXIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 18:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574619AbhCBWnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:43:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C6CC061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 14:42:21 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id e10so21320041wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 14:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F18VD5O5Vmw7rHVUpp3r00XyGd8mL7zbOwbSF/kiUSQ=;
        b=pbdTFhYecfJuXRHGNDLsEgpVPh9CFIXOOUQ9v4CXNd862P0YB3FVMTf/F4GjSp73Yp
         ePFVlZ1JUlYQQ/yIyIGoAd5mgvA2dLL2eGJvCQw7cfB2vJXG3/3C6s9LWYjENV4HNo4S
         aZ9nE7eQOsqRTyO9Bd+u/CAD1uG9Mas75VJYG/ydAuuRFNhxU5XMCsy3+9T/CS5t5pGh
         ZPiHlz8b6EXOMkFaTou9Tp/JUVx3QTeuiTf7PQoQ3vOuikC7DYwItF3UC4IOHr7nLZme
         YEU5Zn3eeXF0Se/oumdzF/5gXWN+MyJ4FopOLECMUIVd6EUEVKxCrMafbTk/n13C2ahJ
         tkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F18VD5O5Vmw7rHVUpp3r00XyGd8mL7zbOwbSF/kiUSQ=;
        b=aQtCqVRlcc94nB0VU92OsRr0T+5dyUp0sumjWtHKBJrc2dekFThaHaIwyai2lYTv1Z
         cmc0GApd2hlihCWg9i/TUd5h5Y0voq1CPtzyC0RZg9r9tXJ6PXcTgYbFPEVdGMBlBAc+
         b2jlL/rohYiCjnv/PgLZRIso28I6Cc2EWQDMLBKt+4IfAnDGwr9hmPXRngzjUmS8xs9B
         SBIi3rge1wETZ4BBH/5TrsXa0TpCPj3c4AgbeYawFD/GbOqAN78ft4T3ZfbsL1B/TRVn
         7GSbKz+wFIpq/28LiXVxAsUzyGiDDuuDDHue5qkxTIMACXKPIm8p5xElVbLzsT9ggzcM
         RFvQ==
X-Gm-Message-State: AOAM530foM3Q3qsVYCHlSx5wUaTtKy/FNqYF3n1+SheLFtVMnmSI/FCR
        lNPa+/ZSkqsPGQs03H+0tMM/Vw==
X-Google-Smtp-Source: ABdhPJzeJFHYMS4XtzlZlrhCTXeJdPCwO/BbHvrx4nnS2n+CXYJ1ArJ9MgyxKPbG9IHqGfCzWMbspw==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr23598514wrx.78.1614724940098;
        Tue, 02 Mar 2021 14:42:20 -0800 (PST)
Received: from localhost.localdomain (hst-221-2.medicom.bg. [84.238.221.2])
        by smtp.gmail.com with ESMTPSA id m9sm15543686wro.52.2021.03.02.14.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 14:42:19 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] v4l2-ctrls: Fix h264 hierarchical coding type menu ctrl
Date:   Wed,  3 Mar 2021 00:42:06 +0200
Message-Id: <20210302224206.3680649-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a name of the menu and fill control type.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 016cf6204cbb..5d99e2294335 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -421,6 +421,11 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		"Annex B Start Code",
 		NULL,
 	};
+	static const char * const h264_hierarchical_coding_type[] = {
+		"Hier Coding B",
+		"Hier Coding P",
+		NULL,
+	};
 	static const char * const mpeg_mpeg2_level[] = {
 		"Low",
 		"Main",
@@ -697,6 +702,8 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		return h264_decode_mode;
 	case V4L2_CID_STATELESS_H264_START_CODE:
 		return h264_start_code;
+	case V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_TYPE:
+		return h264_hierarchical_coding_type;
 	case V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL:
 		return mpeg_mpeg2_level;
 	case V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE:
@@ -1326,6 +1333,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_IDC:
 	case V4L2_CID_MPEG_VIDEO_H264_SEI_FP_ARRANGEMENT_TYPE:
 	case V4L2_CID_MPEG_VIDEO_H264_FMO_MAP_TYPE:
+	case V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_TYPE:
 	case V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL:
 	case V4L2_CID_MPEG_VIDEO_MPEG2_PROFILE:
 	case V4L2_CID_MPEG_VIDEO_MPEG4_LEVEL:
-- 
2.25.1

