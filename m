Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B85C34A519
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhCZJ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhCZJ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:58:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3D8C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:58:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l4so7466048ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kC71O7mgFntuzJoDSI8vq4wass7q97TNbxvCpydYjHA=;
        b=lnIbbFaFA1NeWxJwk96P8UeCjY14eS1euXdCbkNiVhfhjgQcwfWujSlmA4xPfft9YZ
         Gl0eOxR+d0lRqngQMghci8XytRROb3DZ9NU5AUzdMq7c15xefM502DxPuJ6fqrYkTD0Z
         11TCLaFxNFjxWwysuGOQ2+EPgMPAK5iryvXGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kC71O7mgFntuzJoDSI8vq4wass7q97TNbxvCpydYjHA=;
        b=qE8OFEyiwecA8cYFen7/vetzrORXIPGnmMFSoQcQQXftO54CXgHpL35AxZVAFQb580
         iGlqkasaXhV2t+TTacy62nMfThDZgYr0LLSfUcgUV8dRSiaP5kiVY5N5Ni+HZsQNykdD
         H8ckxfXtfyQRHmWLDwgCfIRMMEaYCM2u42FxzPHJErGq2rBZ512ymS8KXfvjDtGNUnQH
         f9XPX4/N37zEZsTbdmi/qfyrU35378pMFuQ9bTMooFjl3vG2QniA/KFlAx1MWm4LOaNw
         v0dTgFCWoZP0OlTGnHZcHfqVhk30/wOVTg79lvImRLNSVsA5Tki0NIGvQ6cskKJ4fJTO
         gu+Q==
X-Gm-Message-State: AOAM533e1rkZTa0E8kU5ZII3GDfnasUqQOB7e74wHPCdL3eZKwa+BZCj
        TyNSX9ZjgDy5UFoDFYVxiuNq5w==
X-Google-Smtp-Source: ABdhPJycuvhnOM0hm++0vYD9gRyRidcx/FE2H1tfgUcXuuaXDHrFSGrOfpQegT1wmxAFxSZoau98Mg==
X-Received: by 2002:a17:907:1614:: with SMTP id hb20mr14324510ejc.77.1616752727627;
        Fri, 26 Mar 2021 02:58:47 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h13sm4036658edz.71.2021.03.26.02.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:58:47 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v9 04/22] media: v4l2-ioctl: S_CTRL output the right value
Date:   Fri, 26 Mar 2021 10:58:22 +0100
Message-Id: <20210326095840.364424-5-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210326095840.364424-1-ribalda@chromium.org>
References: <20210326095840.364424-1-ribalda@chromium.org>
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
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
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
2.31.0.291.g576ba9dcdaf-goog

