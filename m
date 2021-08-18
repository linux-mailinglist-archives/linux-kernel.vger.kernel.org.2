Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417DA3F0BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbhHRTmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:42:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233886AbhHRTlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629315679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Av+9gVDsC8feOzeiSKKB3XcVER5b9PzyTvqPasKEZ1c=;
        b=KruGyY6gpRMQTlfCLC8V7jaUa2dG0NQijTRPyfsxcXr5PQvvqEqYTVyC8sH2y/ILPlwYaH
        P8sxmBEuE+AMgMUzb1EdNSKC8LFC5zz3QMHj98ir8fF5Flp6elrvHYGY4ZXLLLoIqjeOAT
        yW4UHmAjIiu0edz9V+vrru8brV0ONJQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-Tk3x34-kP8SgkmePYGoSgg-1; Wed, 18 Aug 2021 15:41:16 -0400
X-MC-Unique: Tk3x34-kP8SgkmePYGoSgg-1
Received: by mail-qv1-f72.google.com with SMTP id dl8-20020ad44e08000000b0035f1f1b9cefso2892308qvb.19
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Av+9gVDsC8feOzeiSKKB3XcVER5b9PzyTvqPasKEZ1c=;
        b=e0PS3igg/jSdWCSceX9mf8wQ8HfossXJDsZ1gym+BNWQYcDeIQIwOeZP9nqTDvrnvm
         hWeUszKfw08j0O38q0UUV+kPVYdQzfoComylocTvRmCxxkMHh1jwd32Fq6HnetlTnaCK
         E8rZ2xrXYcOEmDkgZ3bk1zaGZ0pzixYy9PkbOZAiikpS1xvsNUMERbzsPR6A2td1y8wq
         XEHtf9aG4pZLeChL9ZW+4WK8y/pS/GFe2y1F5Nw6RBHXmZXtG765v40XF453lLkfxvtU
         catpGUw8+V1Arh6KqNMiakw76fWxNq3IhxC5tba76KCSZiV6NTGhf5tSFMqICDfn+tP6
         uh4A==
X-Gm-Message-State: AOAM531gLf8PJQNlRFE0QoWlUbWvZqWxGB7bbwWiqQOYjCJRO3FF6hFi
        1y0C7e9u1iBqrx5IHIbabLXrmgDhhkoGBbecTCI1ReB9VtUnhl2EyPbPGs1rlg3dK8jADsPs5X/
        FDK7RDB0GLFTNhEwHS5MdZe1v
X-Received: by 2002:a05:6214:410e:: with SMTP id kc14mr10860633qvb.33.1629315676478;
        Wed, 18 Aug 2021 12:41:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDmwwleE4mo9gtz4ou48ZiVOQow5nBGgo7nnWHJ8fu8DeAGOQ3wUS3pNkWwB2skk/pSMmGBA==
X-Received: by 2002:a05:6214:410e:: with SMTP id kc14mr10860611qvb.33.1629315676223;
        Wed, 18 Aug 2021 12:41:16 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c11sm387398qtx.27.2021.08.18.12.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 12:41:15 -0700 (PDT)
From:   trix@redhat.com
To:     robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] media: camss: vfe: simplify vfe_get_wm_sizes()
Date:   Wed, 18 Aug 2021 12:41:05 -0700
Message-Id: <20210818194105.1400766-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this representative problem
camss-vfe-4-1.c:333: The result of the left shift is undefined because
  the left operand is negative
  reg |= (height - 1) << 4;
~~~~~~~~~ ^

The is a false positive.  height is set in vfe_get_wm_sizes() which
has a switch statement without a default.

Reviewing the switch, the cases contain redundant assignments.
So simplify to assignments.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../media/platform/qcom/camss/camss-vfe-4-1.c | 20 ++++++-------------
 .../media/platform/qcom/camss/camss-vfe-4-7.c | 10 +++-------
 .../media/platform/qcom/camss/camss-vfe-4-8.c |  9 +++------
 3 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
index 7b7c9a0aaab282..42047b11ba529e 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
@@ -290,22 +290,14 @@ static void vfe_wm_frame_based(struct vfe_device *vfe, u8 wm, u8 enable)
 static void vfe_get_wm_sizes(struct v4l2_pix_format_mplane *pix, u8 plane,
 			     u16 *width, u16 *height, u16 *bytesperline)
 {
-	switch (pix->pixelformat) {
-	case V4L2_PIX_FMT_NV12:
-	case V4L2_PIX_FMT_NV21:
-		*width = pix->width;
-		*height = pix->height;
-		*bytesperline = pix->plane_fmt[0].bytesperline;
+	*width = pix->width;
+	*height = pix->height;
+	*bytesperline = pix->plane_fmt[0].bytesperline;
+
+	if (pix->pixelformat == V4L2_PIX_FMT_NV12 ||
+	    pix->pixelformat == V4L2_PIX_FMT_NV21)
 		if (plane == 1)
 			*height /= 2;
-		break;
-	case V4L2_PIX_FMT_NV16:
-	case V4L2_PIX_FMT_NV61:
-		*width = pix->width;
-		*height = pix->height;
-		*bytesperline = pix->plane_fmt[0].bytesperline;
-		break;
-	}
 }
 
 static void vfe_wm_line_based(struct vfe_device *vfe, u32 wm,
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
index 2836b12ec98915..ab2d57bdf5e71c 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
@@ -370,30 +370,26 @@ static int vfe_word_per_line_by_bytes(u32 bytes_per_line)
 static void vfe_get_wm_sizes(struct v4l2_pix_format_mplane *pix, u8 plane,
 			     u16 *width, u16 *height, u16 *bytesperline)
 {
+	*width = pix->width;
+	*height = pix->height;
+
 	switch (pix->pixelformat) {
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV21:
-		*width = pix->width;
-		*height = pix->height;
 		*bytesperline = pix->plane_fmt[0].bytesperline;
 		if (plane == 1)
 			*height /= 2;
 		break;
 	case V4L2_PIX_FMT_NV16:
 	case V4L2_PIX_FMT_NV61:
-		*width = pix->width;
-		*height = pix->height;
 		*bytesperline = pix->plane_fmt[0].bytesperline;
 		break;
 	case V4L2_PIX_FMT_YUYV:
 	case V4L2_PIX_FMT_YVYU:
 	case V4L2_PIX_FMT_VYUY:
 	case V4L2_PIX_FMT_UYVY:
-		*width = pix->width;
-		*height = pix->height;
 		*bytesperline = pix->plane_fmt[plane].bytesperline;
 		break;
-
 	}
 }
 
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
index 19519234f727c1..7e6b62c930ac8a 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
@@ -343,27 +343,24 @@ static int vfe_word_per_line_by_bytes(u32 bytes_per_line)
 static void vfe_get_wm_sizes(struct v4l2_pix_format_mplane *pix, u8 plane,
 			     u16 *width, u16 *height, u16 *bytesperline)
 {
+	*width = pix->width;
+	*height = pix->height;
+
 	switch (pix->pixelformat) {
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV21:
-		*width = pix->width;
-		*height = pix->height;
 		*bytesperline = pix->plane_fmt[0].bytesperline;
 		if (plane == 1)
 			*height /= 2;
 		break;
 	case V4L2_PIX_FMT_NV16:
 	case V4L2_PIX_FMT_NV61:
-		*width = pix->width;
-		*height = pix->height;
 		*bytesperline = pix->plane_fmt[0].bytesperline;
 		break;
 	case V4L2_PIX_FMT_YUYV:
 	case V4L2_PIX_FMT_YVYU:
 	case V4L2_PIX_FMT_VYUY:
 	case V4L2_PIX_FMT_UYVY:
-		*width = pix->width;
-		*height = pix->height;
 		*bytesperline = pix->plane_fmt[plane].bytesperline;
 		break;
 	}
-- 
2.26.3

