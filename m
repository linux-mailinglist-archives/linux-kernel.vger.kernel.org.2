Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D06F34A51D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhCZJ7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhCZJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:58:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D72CC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:58:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ce10so7500382ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eGEbDdnxvr1xLVANMZdtzFwCYrSlkB/OUQV9O+h/O7Y=;
        b=WoGkUMRB+hZG5srLy5V1gTYT/x61xXlx/NBXfD/s9wOaoxjeD2Pe0PAuAqdL0gM5Rt
         rNja5S0G0sNG/8laO/dBbneKzk5vMMld6oocd+sT3sc0LVa8w7dQkio3bUL8B50vjewJ
         7RcEVUg50rTqKnokvW2InkdJ8ze2zpv1lzgT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGEbDdnxvr1xLVANMZdtzFwCYrSlkB/OUQV9O+h/O7Y=;
        b=QhBZVjXlWNKykbRbzjNZ39vLLmW61psaYgHQC7JhYTom5B54tw7bAgYcW12eFGybIT
         rURyUaKkSOy7520mMXl5UKCHoMS4DwiNAON/gPX86I5DjT1nvDnm7pvXyOiu0o4yiPBo
         Hn27umvPIueSecEHZ7drZOgmw7T3dhG2KnDCvsozoZTG6b8ylCK1GVa2rt2tjHsx7aMT
         z5NQLKz6VOclUZ8eyzZS2OootsUVqGdPfBIjMFsTTs94UZvYbcSQNeLxcpD7TMmhBL59
         ZCZoiH7901Mi2N7f0e2Tnch4IZLuHAemoOXfzIW00bIagi/iaPNHBaoaSLWpI7kG+wy1
         jTiw==
X-Gm-Message-State: AOAM532DkoROLlQQ6RIUYQ1mmVI9tJQ7iaEElg3z1mM5SotkekmxW7tK
        h790aLMQl+BfxA5cHt233Hxjlg==
X-Google-Smtp-Source: ABdhPJzrYuEt7Xf+jITuCY5D2PraUBAdDMsrNkQ/v19ECHnYWGoQgGJPu1Fw7t1rzLRatuaoKRQCVQ==
X-Received: by 2002:a17:906:3751:: with SMTP id e17mr14457691ejc.553.1616752729365;
        Fri, 26 Mar 2021 02:58:49 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h13sm4036658edz.71.2021.03.26.02.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:58:49 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v9 07/22] media: uvcvideo: Return -EIO for control errors
Date:   Fri, 26 Mar 2021 10:58:25 +0100
Message-Id: <20210326095840.364424-8-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210326095840.364424-1-ribalda@chromium.org>
References: <20210326095840.364424-1-ribalda@chromium.org>
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
2.31.0.291.g576ba9dcdaf-goog

