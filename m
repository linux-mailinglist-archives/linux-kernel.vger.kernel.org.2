Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561D633C46C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhCORgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhCORgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:36:15 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A1FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:36:15 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e7so18313799edu.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5GhB9wAVAmGCMsv6tNmoEvGVMgcHMI+Nh//R6KNIA+Y=;
        b=Tq6QL1HTQl9oJWcOckVNIZuaezqCTDxvYarbY7vOXTZ5nE5fD/M7SFb1z2ckT4OCPN
         LYYQfR3+VlJMYZY36Xgc1WdmdDQ040L3ujLsz9te3Wria+nMoAjvwWAq13sed14vRiGl
         IzG/L94Hq3upktn5m5zL2Gq5LP9MEOJhNfgD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5GhB9wAVAmGCMsv6tNmoEvGVMgcHMI+Nh//R6KNIA+Y=;
        b=HyVfBNpMVxPtRl8aJco66bx0chciR1XdZ6U/j0DLEOCUxoATqZOnQnI/cDzHNvVDs3
         b1zMn5roVz606WTLhJSM4pbluzimbRdooYvgEYhS5w+7f4qVSXijeFcEYtNc6QcUuJjm
         r+qdSlg3+6qS0ia5Z6O+tLmR5ll2mdk7REOyfHh6VoaB78hvinPTdEROyywCy2t29MC0
         dzJ4pUXTFZSU7bj5sDkbo4OdnmdtKAb2RwSbjrO52UYrsAk62LUXN5/d1DuS9IArgG96
         j3rZ4aO02osBU6RyWd0FY/H/M4jweBeIgCwJ70bbPoATIu6EQaG7WsTie0m2sxP6sRT2
         6OZQ==
X-Gm-Message-State: AOAM530yHFJfZi4R4yxKA02gz+6yPeFFjSVF3FJvWix21JxCB6R5KBGS
        TRmFON/oaMxO+JUxCD8WyoXz1g==
X-Google-Smtp-Source: ABdhPJxQNPRTKe6fQ4YCJgY/7uX+zjhVlQd3Cp6635BWfk36o9ULIl7Y/VVtMAAb0nIm45tnhpcOGw==
X-Received: by 2002:aa7:d954:: with SMTP id l20mr31319101eds.1.1615829773954;
        Mon, 15 Mar 2021 10:36:13 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id a3sm8109239ejv.40.2021.03.15.10.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:36:13 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 04/11] media: uvcvideo: set error_idx to count on EACCESS
Date:   Mon, 15 Mar 2021 18:36:02 +0100
Message-Id: <20210315173609.1547857-5-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210315173609.1547857-1-ribalda@chromium.org>
References: <20210315173609.1547857-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error is found when validating the list of controls passed with
VIDIOC_G_EXT_CTRLS, then error_idx shall be set to ctrls->count to
indicate to userspace that no actual hardware was touched.

It would have been much nicer of course if error_idx could point to the
control index that failed the validation, but sadly that's not how the
API was designed.

Fixes v4l2-compliance:
Control ioctls (Input 0):
                fail: v4l2-test-controls.cpp(645): invalid error index write only control
        test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 157310c0ca87..36eb48622d48 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1073,7 +1073,8 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
 		ret = uvc_ctrl_get(chain, ctrl);
 		if (ret < 0) {
 			uvc_ctrl_rollback(handle);
-			ctrls->error_idx = i;
+			ctrls->error_idx = (ret == -EACCES) ?
+						ctrls->count : i;
 			return ret;
 		}
 	}
-- 
2.31.0.rc2.261.g7f71774620-goog

