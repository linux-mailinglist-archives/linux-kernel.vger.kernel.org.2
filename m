Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78FC33F5EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhCQQpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbhCQQpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:45:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C984C061762
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:45:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dx17so3702138ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7BfbRkZgKvyDVm8Db9Jrgj8gcrrUGA9hBYKQf9MVsw=;
        b=AX65wNOoec086wfSe4poCGNVBOMmtrxUvp4lnsBJtWvPfIBdxMs8nmdWM8TZFMTJ+Y
         xEFco9JGe4jam6eQIdqCKyorT/8kOjyjvD0lyes7Jo23y10W6jF4N70bxCKNLY1WE0Mr
         j7taWweCbRqpmBUzjY7kIa8kMLZL90d8APBCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7BfbRkZgKvyDVm8Db9Jrgj8gcrrUGA9hBYKQf9MVsw=;
        b=e2/Nr4ajSvle118COlA3BqN/hwdWsNJ71IynNPM4puyYuQjReTez9sVFyyM24iRNEL
         UaJ1eVKsvSWvdYUoEXK9pxSdQwM0xM/ORLYDy+Br628IJ04UnVtyc1eL88pZH5aDuB3R
         7L4mVpYS0dhX3p9JBXCbUAzhdQDR11zsoayIUUK/JMJEkfCgYkx5Z15X+AUfpAcDrax3
         dRuBlXqlcXefMRayEfopyYhUsc25Nd2sLVXQ+6/DoVnt2t4OerRWDEBR35Tsc6pSbv6K
         6lv9DHeUf0YVAvbFwPuxZhz7R3uP+SM7lDa/KKYfduK47GsgiSCKCWULCW5EkRln24vs
         k5Fg==
X-Gm-Message-State: AOAM531UnKJPpIcILw3Zj1dT6Q+Rb4iukeBI3KINe1cnMA0bnNpBZZK1
        Q1Ng2RfcYWZiobXpPLTzjvsbKQ==
X-Google-Smtp-Source: ABdhPJxesE2LHKVrupx9CIvpViyNOdb0zgvX8mHwILjtMovcaKqgx3KxlomYYP4sLsLddb/F1CFe9Q==
X-Received: by 2002:a17:906:75a:: with SMTP id z26mr36257622ejb.22.1615999518922;
        Wed, 17 Mar 2021 09:45:18 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hy25sm12088128ejc.119.2021.03.17.09.45.18
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
Subject: [PATCH v6 08/17] media: uvcvideo: Return -EIO for control errors
Date:   Wed, 17 Mar 2021 17:45:02 +0100
Message-Id: <20210317164511.39967-9-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210317164511.39967-1-ribalda@chromium.org>
References: <20210317164511.39967-1-ribalda@chromium.org>
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

