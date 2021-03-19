Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC14C3422F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCSRJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhCSRJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:09:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3C9C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w3so10878950ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7BfbRkZgKvyDVm8Db9Jrgj8gcrrUGA9hBYKQf9MVsw=;
        b=CB+JuxfaRRRntr21/mb/QSSNUyrRuTUApU6xKFa+njYv6UX5Ozp6gvmjDZNtgxcyLw
         +Kx9ptUTc1zs5ZfcLj3QG29nEvh0UvugYPz2kPIZoQpgIocdJKnMsxHZkVq6EldvWeo7
         LNP2sBuRigENJ9i3y0GohzCCFlCGMoLVm1gwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7BfbRkZgKvyDVm8Db9Jrgj8gcrrUGA9hBYKQf9MVsw=;
        b=b/qtnzZc1gacz8UxJIUaK3iCw8QuH7w6+idFNJJTrSL/fg0KDRV+agcM8xXi6HUpAK
         WtewpYxpGpM2TTl6J3mI/nPi6Uebagfh+GDkEDUE0ZN9yYU8F0AfyyBlM3QafdcoVD5T
         B8Um1lnAqOIL46pfPCxf5zNZaWl55UQ8qsixUF1z+X9p0IY/KPmU2tApRBno/EIBHzEN
         0NzJqyH5c/snFdOWTgLRMSoqIEwt5zETfbLtxRteVM4imzPvmnBQNS3CR36DbkxXT/i6
         DxeesyOYK7JgtTdguF0GsdoX4HRvnkLk4I6OaZqrFuMGaeQgyp9lk8XrR32eiuIL6BY/
         XFKg==
X-Gm-Message-State: AOAM531bZV7lX23TKvPr4VBUm+OFzgCtMrNzAf8RXADE7ZveNJh4UPBf
        AIt7PpHSSPV9csfUdAN4VzkW/A==
X-Google-Smtp-Source: ABdhPJzUKZ9CXVC1OqMiAavDsVwTkhwm/glY0g9UfYlgVbeN5FzrGZ6uMUPaPOPDE6JgYJfMldaTTw==
X-Received: by 2002:a17:906:35cf:: with SMTP id p15mr5473617ejb.379.1616173754501;
        Fri, 19 Mar 2021 10:09:14 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id be27sm4506050edb.47.2021.03.19.10.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:09:13 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 07/19] media: uvcvideo: Return -EIO for control errors
Date:   Fri, 19 Mar 2021 18:08:54 +0100
Message-Id: <20210319170906.278238-8-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319170906.278238-1-ribalda@chromium.org>
References: <20210319170906.278238-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device is doing something unspected with the control. Either because
the protocol is not properly implemented or there has been a HW error.

Fixes v4l2-compliance:

Control ioctls (Input 0):
                fail: v4l2-test-controls.cpp(448): s_ctrl returned an error (22)
        test VIDIOC_G/S_CTRL: FAIL
                fail: v4l2-test-controls.cpp(698): s_ext_ctrls returned an error (22)
        test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index f2f565281e63..25fd8aa23529 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -112,6 +112,11 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	case 5: /* Invalid unit */
 	case 6: /* Invalid control */
 	case 7: /* Invalid Request */
+		/*
+		 * The firmware has not properly implemented
+		 * the control or there has been a HW error.
+		 */
+		return -EIO;
 	case 8: /* Invalid value within range */
 		return -EINVAL;
 	default: /* reserved or unknown */
-- 
2.31.0.rc2.261.g7f71774620-goog

