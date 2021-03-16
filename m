Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7CB33DBF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbhCPSCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239567AbhCPSAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:00:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCE0C0613DB
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:00:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id si25so17983547ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7BfbRkZgKvyDVm8Db9Jrgj8gcrrUGA9hBYKQf9MVsw=;
        b=DDdLQ0qiQQJrh4R7JW98QNS9G5l5df4GkMebBeBn304JxaSW5NwybqFHJi/5mYeRA0
         n3mKYiuDRoF7k6KMB599ojS3VwTrxen5Go5ZJ02bCwr7AbYQxAqMTBA1XIqld9OLSU3O
         Lteh68kv/hBMAdhWzTiuENA7PGl0IXx8IZIIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7BfbRkZgKvyDVm8Db9Jrgj8gcrrUGA9hBYKQf9MVsw=;
        b=NbO1oSkuDh2GnYXNI0qEENJzjrQMYFtM6pCJrQrZtUGULrK0H4wG3v3e5Ako12BHXx
         25fkEa5T1FP5jlKuSBXNEhWodgR+UG/c2FYGGPTRNTpvx6+GS0JHlWvcaD6BC9SWm+AN
         dcGr0DbsxMywAMrMJZ6GS0Kxq8pF+CO99E4d2jgbcYhdKmf3FssDgKDGwRAO6habcZK1
         v3nDyTs1+YDtNtO8fa6IXy7EYvZHP5w2oIoXMcJWJDp0QiTrPpEcMwWkQG8CyrGcUIiV
         2MF7D0vNctc0AYUVy1VB4SgP8P2Yxk1ZmtD5Po8E/PFuN0OzN5zOrLqvIwDZW8Ow9yXK
         cbDQ==
X-Gm-Message-State: AOAM532Mz5JDPLaly0kkC0sDa/aFE7uCk9JJo+bFiY/RW3aX1X4jTYHB
        jXJcT8Yv+5kF3n5X81NfYPu8Gg==
X-Google-Smtp-Source: ABdhPJy2G3XfTjMvH6C8tuz1514SKmTbwO9bYA6HTYPrt2qVJ/mdPvSrS2i+zxzgxynZhjnfC3nRHA==
X-Received: by 2002:a17:906:74c4:: with SMTP id z4mr10494069ejl.512.1615917609632;
        Tue, 16 Mar 2021 11:00:09 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id c19sm10953182edu.20.2021.03.16.11.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:00:09 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 03/13] media: uvcvideo: Return -EIO for control errors
Date:   Tue, 16 Mar 2021 18:59:53 +0100
Message-Id: <20210316180004.1605727-4-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210316180004.1605727-1-ribalda@chromium.org>
References: <20210316180004.1605727-1-ribalda@chromium.org>
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

