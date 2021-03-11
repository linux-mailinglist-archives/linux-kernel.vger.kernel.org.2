Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF84337258
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhCKMU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbhCKMUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:20:44 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BA6C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:20:44 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jt13so45869570ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EYGFrEW02KUhIrzCGk6j2y1DSBi0VEvJiIGApiPKgfI=;
        b=TyoGQkrwpHdv/lBARJpZfrijdU2O8+MCDuhgh5lx3pNzaKF8z3/1RIh3bbpQ8dvFV9
         CWFbmvHewQd1NNb5IGRk/JBn2/4bTHHXKYYoMMyI2l++6uoCg+nmo60W6y8RFOzzvN1V
         WvuotfLz4U5ryDk7SNlIumi6A2y+ZCrSRcU3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EYGFrEW02KUhIrzCGk6j2y1DSBi0VEvJiIGApiPKgfI=;
        b=lBlIXIZMhXVJ87jUgBQWLDwPN607WoefTr6lZljRweiiU0huhdA94Z/qvDdqDqyOhJ
         mvBSp6c4Bk+NhWN8WV+gPa34qK8jGxsst5uUuDbSOku/I4ZxowmInWHXi63iM04C6F2z
         PB0injS0Nx/SqcxxhWfVG626OLGixzvPtjd/JLEkZIgFFVvbJZJjE9NlS3O7xmRaLvYt
         PS8VsaAhLZc8k6kGViZzTDj+wrhWIwiP3q/f76Fwq7ft2uSqAXK7BO6doBmKu4iV1Mht
         clRtYX1PFKYRVXi3B3eL+Y/ZjPmZqKa0zQr9h3UoaxeBozh6NPD2OFBszuaMrbfYQ54W
         7NiA==
X-Gm-Message-State: AOAM532OP4pBx3r8OYESVn2P7wTDGlz2srNIZTl78y1AN9VcugSwwGVI
        SReD7vZ30DWAQLXdlZ9JZibe4Q==
X-Google-Smtp-Source: ABdhPJy7bhbwfcyIHHrbJaVpNHOyI4lk2ai/ZsUE5g7/tTa7JvpDxHhjLUm/S3pqzbNR/qp+NFRv1Q==
X-Received: by 2002:a17:907:2093:: with SMTP id pv19mr2851780ejb.134.1615465243068;
        Thu, 11 Mar 2021 04:20:43 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id u13sm1264126ejy.31.2021.03.11.04.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 04:20:42 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, senozhatsky@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 01/10] media: uvcvideo: Return -EINVAL for REQUEST API
Date:   Thu, 11 Mar 2021 13:20:30 +0100
Message-Id: <20210311122040.1264410-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210311122040.1264410-1-ribalda@chromium.org>
References: <20210311122040.1264410-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not support it.

Fixes v4l2-compliance:

Buffer ioctls (Input 0):
                fail: v4l2-test-buffers.cpp(1925): ret != EINVAL && ret != EBADR && ret != ENOTTY
        test Requests: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 252136cc885c..5e3ec4a376e4 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1046,6 +1046,9 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
 	unsigned int i;
 	int ret;
 
+	if (ctrls->which == V4L2_CTRL_WHICH_REQUEST_VAL)
+		return -EINVAL;
+
 	if (ctrls->which == V4L2_CTRL_WHICH_DEF_VAL) {
 		for (i = 0; i < ctrls->count; ++ctrl, ++i) {
 			struct v4l2_queryctrl qc = { .id = ctrl->id };
-- 
2.31.0.rc2.261.g7f71774620-goog

