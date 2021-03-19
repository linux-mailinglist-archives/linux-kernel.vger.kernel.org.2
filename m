Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781073422E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCSRJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhCSRJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:09:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EEDC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id l18so3424744edc.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=96ZVVsI7mmV0nt1s7KCaw3tkEc80+53xafrWhnUjtVQ=;
        b=Z9doXzuIiBbNBO8RqTWEs5V3LjQI9z2+BiDjEv7qTAQ0GXyOAgHcFeMx09EYCUZI2h
         T2aFsyRvNpAjddosGgaH1ou4YZCtczgVSEd8sBUqfHZsJG+oDjOWDJo7jmZOQDJGoRV0
         EGX3rw8KVo7JkWRw9+QCa7U7PaboFU3gLZ/3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=96ZVVsI7mmV0nt1s7KCaw3tkEc80+53xafrWhnUjtVQ=;
        b=mrjDrOqKqvGgzpVf7wybEmwY7eO1nvwaQgOEEHxACjxbQasLHuq5jJK1i7mfcLEABN
         WMgfms9OqBNbijBopz0oHK4tE4xDYH50Be/ywqSxrySG4c5cVIwwMJ7tC1Jj13vL5plg
         14wc69f4cwXm360IbMPb5r9MT9kuyYGn3hEBruAsV3PyCaNq2ZCJWMLy1/mpKID7aOyG
         T2k71BcTOkvb7Zy+qItfjTBdbZ5dZIDfuB/We5kVkq+6i1PKo3I+Y3yB5W6Jyn7sQgj1
         DGbsSkiJkICjVbvmLF8Ov4gFUwhfpU4OYPRMI7Hl2896pXdI2XJO80r0SLXK7og6druG
         2w2Q==
X-Gm-Message-State: AOAM530FzKqm0UN+j6HVx4vgBggfWkEYIBRc0tekzPifEcxA/uOV0HII
        LhxCsM1Z5XvJZj6Z/RLvUrFhsA==
X-Google-Smtp-Source: ABdhPJzvvbR8fKsxzgOGmrSXuSZkwip+jYiYDlT1msC+cn/rWgWLm7xa9w+XULjRkaUzhfcfJdrJiQ==
X-Received: by 2002:a05:6402:13ce:: with SMTP id a14mr10809525edx.365.1616173751980;
        Fri, 19 Mar 2021 10:09:11 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id be27sm4506050edb.47.2021.03.19.10.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:09:11 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 04/19] media: v4l2-ioctl: S_CTRL output the right value
Date:   Fri, 19 Mar 2021 18:08:51 +0100
Message-Id: <20210319170906.278238-5-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319170906.278238-1-ribalda@chromium.org>
References: <20210319170906.278238-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the driver does not implement s_ctrl, but it does implement
s_ext_ctrls, we convert the call.

When that happens we have also to convert back the response from
s_ext_ctrls.

Fixes v4l2_compliance:
Control ioctls (Input 0):
		fail: v4l2-test-controls.cpp(411): returned control value out of range
		fail: v4l2-test-controls.cpp(507): invalid control 00980900
	test VIDIOC_G/S_CTRL: FAIL

Fixes: 35ea11ff8471 ("V4L/DVB (8430): videodev: move some functions from v4l2-dev.h to v4l2-common.h or v4l2-ioctl.h")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 7b5ebdd329e8..b8f73a48872b 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2266,6 +2266,7 @@ static int v4l_s_ctrl(const struct v4l2_ioctl_ops *ops,
 		test_bit(V4L2_FL_USES_V4L2_FH, &vfd->flags) ? fh : NULL;
 	struct v4l2_ext_controls ctrls;
 	struct v4l2_ext_control ctrl;
+	int ret;
 
 	if (vfh && vfh->ctrl_handler)
 		return v4l2_s_ctrl(vfh, vfh->ctrl_handler, p);
@@ -2281,9 +2282,11 @@ static int v4l_s_ctrl(const struct v4l2_ioctl_ops *ops,
 	ctrls.controls = &ctrl;
 	ctrl.id = p->id;
 	ctrl.value = p->value;
-	if (check_ext_ctrls(&ctrls, VIDIOC_S_CTRL))
-		return ops->vidioc_s_ext_ctrls(file, fh, &ctrls);
-	return -EINVAL;
+	if (!check_ext_ctrls(&ctrls, VIDIOC_S_CTRL))
+		return -EINVAL;
+	ret = ops->vidioc_s_ext_ctrls(file, fh, &ctrls);
+	p->value = ctrl.value;
+	return ret;
 }
 
 static int v4l_g_ext_ctrls(const struct v4l2_ioctl_ops *ops,
-- 
2.31.0.rc2.261.g7f71774620-goog

