Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF74A34A51A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCZJ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhCZJ6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:58:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9B0C0613B2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:58:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k10so7562656ejg.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sX5ZXTl0P4YI78yELHKr5RIa2rVGe5IIa/a1u86MeK0=;
        b=C3zKwikreEbobcJYlkhl7EXTmjnXv1qJWapLCBcnIHftJ2cE26y/rzRjcRmngE0UqV
         KyUE3U9sPcFUJaEP1uF5jlN8yxB6s0Bco1IXelCQWzQSKerBBRMpKEnUfHhjti2x+uds
         yezZVcaYn7nuhgL0I9dtEr683/7cSzBRhKC9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sX5ZXTl0P4YI78yELHKr5RIa2rVGe5IIa/a1u86MeK0=;
        b=C4ODy1K7fBpS2ZajlbWnI63rskC1pPkvnkhQmT4EuJZ1HOVPOtzMiof9ld4cRI/+k2
         uWSM6SNJVaeDg+G9HAlz/Otr/Vh4O0fNRLHsDj0Wd6KFr0oPKsGt1KJ785P1TbOZF57r
         4PYsY5V6Vd5q6YtxFkwLBLTSNmDaNw9LFu7QA4ppjigzlsbiBe2UgEgqs1evsUv3gp80
         m7jqJrUiHomg5oBU1BfujDDrjuzyIB9rx2cNQXJJW5uAxYxDJsHHbTeHrigrsP+CqFN2
         BDBaK7tznCk60Utfxf7HIA/pXMTT/aNE38/sPG6bYEfo2u5IaPqU9Jkqqh5Em1LEnkXT
         tcew==
X-Gm-Message-State: AOAM531peWrrYS1j0D8Rr0Eq9N3NO/tqQ3whj/sC9wfXvZiNK2+D8OYv
        29xcHx24FrUvS1WJCCCW7MgBoA==
X-Google-Smtp-Source: ABdhPJzj0O+x72GDUq3FXP8ctBY0umAoElnc4EKZYhq8F7ujUO6ISNviA4E2wE6PdFxsC1ENnHWBGA==
X-Received: by 2002:a17:906:37db:: with SMTP id o27mr14720627ejc.60.1616752728689;
        Fri, 26 Mar 2021 02:58:48 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h13sm4036658edz.71.2021.03.26.02.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:58:48 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v9 06/22] media: uvcvideo: Set capability in s_param
Date:   Fri, 26 Mar 2021 10:58:24 +0100
Message-Id: <20210326095840.364424-7-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210326095840.364424-1-ribalda@chromium.org>
References: <20210326095840.364424-1-ribalda@chromium.org>
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
index ac98869d5a05..1eeeb00280e4 100644
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
2.31.0.291.g576ba9dcdaf-goog

