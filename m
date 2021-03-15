Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9973133C462
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhCORgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhCORgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:36:14 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C628C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:36:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id p8so67656531ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGLUxRHfm3EIlGd4N+uEn8OSkXWMynAv8QMKM8OCTEg=;
        b=XoBqXGw00b+nV7WXr92n0EdsVDmyBBbbt6UZfiZc91iF+dhWYj40r0p1dBj69bv2wm
         m5O65up56g+rtsLwAaCZFnW+jbtEerOILhXss9ALl6UexQFweLZymGoq/cUisipf6rO9
         k+q2jl7oz4EBEtGm8UsFQaHebvcWS6+Vzy3+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGLUxRHfm3EIlGd4N+uEn8OSkXWMynAv8QMKM8OCTEg=;
        b=AiW9jvRLdHrqpJyG0JqDx8UYl3x8SBY7PW7zee7H6iz33LuylfGA4nxMJpsG8P5Iyf
         8pEikzwDUg7svjLT3aaU7LkGffn5V4wL+F4AeJ0mnSAqw38MMRWu/7VN/gc1tWOsprlQ
         Bav/dj3Ol6XUldjcjvNnP3KTgGkkFmXWqGe6kMW09PD8UQNE1p5ccw/dUxqFTA9NNt/M
         PTzyvngtKFRAfwEOlwoTfEwM8tvFC06PWN/eyoAga2Y0sPrmqZ3xaI/RmbTX9CA8NoCf
         T/+AmOt98dLo7MfR1Cva4vIb/LQGyxbsPVp9KAqCLW/XcyF0Y4jBaRNIzRYZMDI7I+cH
         kEwA==
X-Gm-Message-State: AOAM5322/85U1geQ20hHALih92WGX41fDivVsMVa32KTFuQ8p37cKGLe
        d/shVvHAhEoGEUQcFcrknkUr7w==
X-Google-Smtp-Source: ABdhPJxhr0bL1B8rtOBmIEPWSJulYD8sUtEQc75FYbnJbNufb4DVLqF+V6zZEnppOctDz1QkwiR31A==
X-Received: by 2002:a17:906:2dda:: with SMTP id h26mr24655719eji.163.1615829772839;
        Mon, 15 Mar 2021 10:36:12 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id a3sm8109239ejv.40.2021.03.15.10.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:36:12 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 02/11] media: uvcvideo: Set capability in s_param
Date:   Mon, 15 Mar 2021 18:36:00 +0100
Message-Id: <20210315173609.1547857-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210315173609.1547857-1-ribalda@chromium.org>
References: <20210315173609.1547857-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes v4l2-compliance:

Format ioctls (Input 0):
                warn: v4l2-test-formats.cpp(1339): S_PARM is supported but doesn't report V4L2_CAP_TIMEPERFRAME
                fail: v4l2-test-formats.cpp(1241): node->has_frmintervals && !cap->capability

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 252136cc885c..157310c0ca87 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -472,10 +472,13 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
 	uvc_simplify_fraction(&timeperframe.numerator,
 		&timeperframe.denominator, 8, 333);
 
-	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
 		parm->parm.capture.timeperframe = timeperframe;
-	else
+		parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
+	} else {
 		parm->parm.output.timeperframe = timeperframe;
+		parm->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
+	}
 
 	return 0;
 }
-- 
2.31.0.rc2.261.g7f71774620-goog

