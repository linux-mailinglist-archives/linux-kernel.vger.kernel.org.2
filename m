Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E31338D76
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhCLMtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhCLMsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:48:36 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2842BC061762
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:48:36 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id mj10so53112596ejb.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7BfbRkZgKvyDVm8Db9Jrgj8gcrrUGA9hBYKQf9MVsw=;
        b=DFliqoujZJMTkRKSYdc7GrhZdrNtEfbcm97XKFH0vaeVYZkwLCtPZwqNNNJaaGNcDY
         4mw/1KHQNrdbtkHYgE2FiCyLmdi1AsJ5KnQyvkUlKKo18V3DpERGwU6nIgZfQ/tYr9Af
         C0SfuEWz3+CojgMmyhfmIRbLjdNZhKeTjUM30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7BfbRkZgKvyDVm8Db9Jrgj8gcrrUGA9hBYKQf9MVsw=;
        b=X+lIBT2EvyKLrmx1yy7MWbieW+mKYRbHWkfyA2nRXXDBL9mhxUwmNDMG+tGOQ9eoeS
         4nhaSSPYTb9Ph84VsuZ4cyHud7mASAI3h4AxoVUnNFORX4zTiqoa8S3ODLkxon4KsmZ9
         6Ai4o0XyPQvDl2Tln2lItmkSRcdp6x7esrJC14wJicv5LNfNrqCx2SMFkr8Kgm7fQKB2
         WP9ebQ12Ax7uLBXKGP0dJzhIt0JAzlOa91KdKRBxRUQW1xbHGx4lMbXPH/ICLk5+ggfP
         lTfo7n38l+a6LlI3o87kGziNdW8Xn4v3tbiShY8boJV1VwhGLK96wbUVqfTAu5GVGYnY
         b3aQ==
X-Gm-Message-State: AOAM533jLVeZOW4lTfZH75ikm62W65husA2B+n739RknTISzeSLBhEYM
        BiUT6lxCyb+MCYpPcZtIwVKAbjDLGozFO04oWQc=
X-Google-Smtp-Source: ABdhPJzy42ahUrK0Xul32IgVmYQ0d/VfxB0VZY0WoTUh2LreSm+CPohuIwgmLKwgNg3nxWMCm8gvEw==
X-Received: by 2002:a17:906:cecc:: with SMTP id si12mr8309722ejb.461.1615553314937;
        Fri, 12 Mar 2021 04:48:34 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id t6sm2924402edq.48.2021.03.12.04.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 04:48:34 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, senozhatsky@chromium.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v3 3/8] media: uvcvideo: Return -EIO for control errors
Date:   Fri, 12 Mar 2021 13:48:25 +0100
Message-Id: <20210312124830.1344255-4-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210312124830.1344255-1-ribalda@chromium.org>
References: <20210312124830.1344255-1-ribalda@chromium.org>
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

