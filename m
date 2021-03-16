Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBCF33DBE9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbhCPSBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbhCPSAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:00:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0FBC061762
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:00:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j3so22646165edp.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGLUxRHfm3EIlGd4N+uEn8OSkXWMynAv8QMKM8OCTEg=;
        b=M+POaY5FwP9J4KG2/OWuUSHxopjUm0FEPSyT8boQDBOihvBQ8xLwG2tZK8Xc9vVv/N
         Sws6/WWU2Qe+ON2YXE4CCZcV+7FrNOe12TATdZAodv04JYVr3pwOP4oknC1ls8/459go
         2FIdTLrHvhBdFSTCqXhGGXDFQw0Uq7KftpjZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGLUxRHfm3EIlGd4N+uEn8OSkXWMynAv8QMKM8OCTEg=;
        b=TlG9hgROaAX9gaPvUyLCk1CvOVmh4WYeKybmG1XJLAJK1ZkW/VsuKw/8rwKAdi08XW
         J6i4itdGX9bHmOqe/KR6zTa3V8bc4/bjKNHt8lm2fSnyUm+A37nYG/RN4Ldr+BldHsB6
         p4eKk9mE7TFmj9Ia5gGp/TQPeuF2Rz+RtviUe21eEN11JmNuhEDV3c5iGXOGMxUTyqa3
         D9aFCdQ09UTdQzmORvGbp8HKQE47SRLQpl34bYUeIN1juMqazmuJjMB8rQlV/nLztWzx
         yKmVfE/FbbJKWXb0+6lybZHROtzpZiZpGdryWXIhCMdINcSuDbcpxqsG3lUmO6LJhsSg
         K5Dw==
X-Gm-Message-State: AOAM531ZZMW+l6RoRkEJG7R309vsfLwqc3HyYPt3Bs4TMOKdFw1sN6ro
        RmKwZeN2zl8Wi5ZyuuBVsqznFQ==
X-Google-Smtp-Source: ABdhPJwMBYKP9SAFnzXqjpgTK4x6R2PhictDeFnNy16UjaMh8I3u9qqK6BwkG18c2FhzjLjiYdqCrQ==
X-Received: by 2002:a05:6402:32a:: with SMTP id q10mr36976737edw.15.1615917609155;
        Tue, 16 Mar 2021 11:00:09 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id c19sm10953182edu.20.2021.03.16.11.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:00:08 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 02/13] media: uvcvideo: Set capability in s_param
Date:   Tue, 16 Mar 2021 18:59:52 +0100
Message-Id: <20210316180004.1605727-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210316180004.1605727-1-ribalda@chromium.org>
References: <20210316180004.1605727-1-ribalda@chromium.org>
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

