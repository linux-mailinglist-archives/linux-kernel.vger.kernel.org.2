Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B39733F5F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhCQQpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhCQQpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:45:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01B0C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:45:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b16so3090430eds.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FSJfEMpG3gmvu/1zHkC5YrHmNIBqGbW9b1IfyrEOzZs=;
        b=Ppr6uEH3M4iQ4x7EubfspiKI+zLTbyizYo+Epvky40rVJrS4Szp/1hNl4CfDrg+jCq
         sAxLqZKllXqphItrwf8+QyMUDuFtD3ZYHxzGs53mDs+2FArS1ReQ+Jjg49v9ScDpbYJ5
         bcPdvAHtD6W8hkzEvOF08TBShmmIHAiqooENM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSJfEMpG3gmvu/1zHkC5YrHmNIBqGbW9b1IfyrEOzZs=;
        b=kcV2207NL+SaFyazwW6+3XRWBGctq+b5sOwh/kyWJmgMIzh/Fq56pbMZffFLh5Hrgb
         laSWxbZG1R5m+0rWvc8m36sdOFp1xZM5FkpP5lVIYINI+NUOggeM1q0K9v/hcG4U1KW0
         wi/zsOtqfVh5lGZbPTM7xdNrfdHTL0DbPw4BQjJxpHoEUev3SEiXLf3Jj7dqY1eaFsx3
         FaJov7B2A8qBSHEq4GJTJS+Yhg2j1lPn4+frCfvUMFsfdpazA0D0jkSQT30PSMLxe28z
         PZ0l8G6v9i4POGueghEbIzageDlL83PNYmfx+hnZrcxMtP5bzn3uF26kHQ/XGnyvVTFH
         a6fQ==
X-Gm-Message-State: AOAM531YIdtDZ0ffvq84+pYnx+z6Rj9XnrrvNqnABhXUXbmZO19+a9qQ
        rPabY8VepYf88VvnR3xFmzp2CQ==
X-Google-Smtp-Source: ABdhPJx8K40+dd/2Szp+kWXiObOZ/fNH8X8zj6Z3cgVhmkw2M7JuMlASxf5QLiSiMRUZ15adjgUdpA==
X-Received: by 2002:a05:6402:4241:: with SMTP id g1mr33792443edb.331.1615999518419;
        Wed, 17 Mar 2021 09:45:18 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hy25sm12088128ejc.119.2021.03.17.09.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 09:45:18 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v6 07/17] media: uvcvideo: Set capability in s_param
Date:   Wed, 17 Mar 2021 17:45:01 +0100
Message-Id: <20210317164511.39967-8-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210317164511.39967-1-ribalda@chromium.org>
References: <20210317164511.39967-1-ribalda@chromium.org>
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
index 47b0e3224205..397217171bbb 100644
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

