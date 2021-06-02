Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A06398596
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhFBJtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbhFBJtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:49:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B50C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 02:47:28 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l1so2916839ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 02:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zH7lA6Cr+wpWCWC/PirgaqY3xGbxUDhMzBZE+tSDOkw=;
        b=Jh7HJ2aYoQMVHQnt5M5ybt+e4WCjzsXrIgIaR84P0mOlzCnmx2Y5B5QnKwCo0Bcz47
         PkMt68nFtdXxt5vIB1asdssZS6As/1WPySXmwfMBelTuA29/S+CCmpHqup5f+h+f2He1
         MASceVPCxYm00I25AVr+HW6KqwrU8i/WpvF+xikveRXTMPvvFuoIu8ldH6uJi8uIbXfP
         ZFfGvj36/2FImqNLHGmdlIwuibc+uah9twkmO4VlsuXe33dH0nFihosX7w+3pkXe0PKX
         DkuBdG0UbvpThqWbKXMCeXsPX6R7qxu0Bf6dpPLUcMJ5YHAESYAbRsCIQHTY3HtHAFEN
         C3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zH7lA6Cr+wpWCWC/PirgaqY3xGbxUDhMzBZE+tSDOkw=;
        b=kx2mXa+zZVBy7v+Gu3ZvFqa+dWcs8Yag9TiuIJv4QyypyfJyxQi89BLAJVQKA9wOpP
         nCbmhqxHMRgBX8ikCz67y3RqtdAp7ig1zaPk2V/TSpKbCom1uSoOJZd+KXFLVZQ7Z3PN
         qrKPThKMaHjmraYKAV5lRRgAVRfzGeOj6fc4wSdnuuY1DcnNhi6X8xSef3fXtp1BKej5
         XrcADq4guy4Mmb1BQ0NC797KvVPqvVggjEvfKhXzXJqu5PmqUmynH/r8ozuN56PMYoOx
         VwcklXejdZo388Ev4YjOQSfpv9x+l6u5JzcNYeTK7ZJ3w43lt8nVOnSugAfoMLZ5bdJN
         Y5gw==
X-Gm-Message-State: AOAM533ph1y3vzvEPBQylSfGeeOF7nYPWhHriP0mlXkDrQDQut2tQCrk
        NHpfZrLbkKBtbK/pPRESsO8c9Q==
X-Google-Smtp-Source: ABdhPJz7KBjGtMR1gFzhggjgGMkmg8EafT0pb5nMcHxTSWfL8ZGshrdXaAnP1myyK5UDCEGQkyXObg==
X-Received: by 2002:a17:906:2b85:: with SMTP id m5mr34214365ejg.141.1622627247351;
        Wed, 02 Jun 2021 02:47:27 -0700 (PDT)
Received: from localhost.localdomain (hst-221-100.medicom.bg. [84.238.221.100])
        by smtp.gmail.com with ESMTPSA id q18sm945138edd.3.2021.06.02.02.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 02:47:27 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        nicolas.dufresne@collabora.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 1/2] media: v4l2-ctrls: Add intra-refresh period control
Date:   Wed,  2 Jun 2021 12:47:13 +0300
Message-Id: <20210602094714.607828-2-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602094714.607828-1-stanimir.varbanov@linaro.org>
References: <20210602094714.607828-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a control to set intra-refresh period.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../media/v4l/ext-ctrls-codec.rst              | 18 +++++++++++++++++-
 drivers/media/v4l2-core/v4l2-ctrls-defs.c      |  2 ++
 include/uapi/linux/v4l2-controls.h             |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 0b8061666c57..803fb655af1c 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -1174,7 +1174,23 @@ enum v4l2_mpeg_video_h264_entropy_mode -
     Cyclic intra macroblock refresh. This is the number of continuous
     macroblocks refreshed every frame. Each frame a successive set of
     macroblocks is refreshed until the cycle completes and starts from
-    the top of the frame. Applicable to H264, H263 and MPEG4 encoder.
+    the top of the frame.  Note that intra-refresh period is
+    mutually exclusive with V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD
+    control, aka the client must set this one or the other but not both.
+    Applicable to H264, H263 and MPEG4 encoder.
+
+``V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD (integer)``
+    Intra macroblock refresh period. This sets the period to refresh
+    the whole frame. In other words, this defines the number of frames
+    for which the whole frame will be intra-refreshed.  An example:
+    setting period to 1 means that the whole frame will be refreshed,
+    setting period to 2 means that the half of macroblocks will be
+    intra-refreshed on frameX and the other half of macroblocks
+    will be refreshed in frameX + 1 and so on. Setting period to zero
+    means no period is specified.  Note that intra-refresh period is
+    mutually exclusive with V4L2_CID_MPEG_VIDEO_CYCLIC_INTRA_REFRESH_MB
+    control, aka the client must set this one or the other but not both.
+    Applicable to H264 and HEVC encoders.
 
 ``V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE (boolean)``
     Frame level rate control enable. If this control is disabled then
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 7963c7b43450..3d73c28bafa7 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -833,6 +833,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_DECODER_SLICE_INTERFACE:	return "Decoder Slice Interface";
 	case V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER:	return "MPEG4 Loop Filter Enable";
 	case V4L2_CID_MPEG_VIDEO_CYCLIC_INTRA_REFRESH_MB:	return "Number of Intra Refresh MBs";
+	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD:		return "Intra Refresh Period";
 	case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:		return "Frame Level Rate Control Enable";
 	case V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE:			return "H264 MB Level Rate Control";
 	case V4L2_CID_MPEG_VIDEO_HEADER_MODE:			return "Sequence Header Mode";
@@ -1257,6 +1258,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_MPEG_VIDEO_MV_H_SEARCH_RANGE:
 	case V4L2_CID_MPEG_VIDEO_MV_V_SEARCH_RANGE:
 	case V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY:
+	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD:
 		*type = V4L2_CTRL_TYPE_INTEGER;
 		break;
 	case V4L2_CID_MPEG_VIDEO_LTR_COUNT:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index f96bea19c991..a34a18ec7f69 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -434,6 +434,7 @@ enum v4l2_mpeg_video_multi_slice_mode {
 #define V4L2_CID_MPEG_VIDEO_FRAME_LTR_INDEX		(V4L2_CID_CODEC_BASE+233)
 #define V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES		(V4L2_CID_CODEC_BASE+234)
 #define V4L2_CID_MPEG_VIDEO_DEC_CONCEAL_COLOR		(V4L2_CID_CODEC_BASE+235)
+#define V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD	(V4L2_CID_CODEC_BASE+236)
 
 /* CIDs for the MPEG-2 Part 2 (H.262) codec */
 #define V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL			(V4L2_CID_CODEC_BASE+270)
-- 
2.25.1

