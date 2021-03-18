Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20E9340F1F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhCRU3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbhCRU3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:29:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464D8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:29:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j3so8258049edp.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7BfbRkZgKvyDVm8Db9Jrgj8gcrrUGA9hBYKQf9MVsw=;
        b=c01hLReSIVeW3bW2pF0twdV7uKbkO9yIoSZykeotv9IbArd6qTSby2bTYfOBc7iw7d
         lc/z1fr7wX738SAntgN3VJNziPeDMuHNM7NAFFBwhboXu0oX0JUVPy7hvTSjt9UBHfW7
         HDwcwiPXunhLox+f9xWH2gNYGj8EOShADx3EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7BfbRkZgKvyDVm8Db9Jrgj8gcrrUGA9hBYKQf9MVsw=;
        b=gWFjECjd1Ng+Sa6Y5VaH0IR1EH+vVRfZ485hHcf9CRjmOsWSpn7RZyBLu23teBzqYy
         vWJ7Z71OibSz9Es1mpgmBSK2Y7yB1+Re9Mne81Rr+dV4y9o53aBAkoHEfKaDfyYwJqGq
         EIFeXXpB9B6nEQvqj6uTifbg0SwqZinpAoWNElGN303v9t9UBZH9xU4SgGFrSXLV9nRJ
         WgbSF+xkfDfqhV4/fuhM/9iDowFFESQTyl7TprSmnTRCxgg+34HXwIxA7XT5x4yoOtHz
         BEbX3HofjQoTPfF8u3psdwDnfXvJf9G7H3eTjCej2qgxsstP0PaWvu6L9sA9kwW5qSkE
         VmdA==
X-Gm-Message-State: AOAM530RqlYZvdQfcgMWZEOiFVTJDH1+yeINh1R4B7XHE9h3riTJqX5i
        EMhvHo3dr6mOFN6OAkbzqvODRg==
X-Google-Smtp-Source: ABdhPJzKx14rWBhWrORQ0Lhu6+qmghidXJd+62nZWtnwEE6MSpVZxen1M7LCSO1xtpQ1vR1xSKE9BA==
X-Received: by 2002:a05:6402:408:: with SMTP id q8mr5732911edv.201.1616099373045;
        Thu, 18 Mar 2021 13:29:33 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id a22sm2533767ejr.89.2021.03.18.13.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:29:32 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v7 05/17] media: uvcvideo: Return -EIO for control errors
Date:   Thu, 18 Mar 2021 21:29:16 +0100
Message-Id: <20210318202928.166955-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210318202928.166955-1-ribalda@chromium.org>
References: <20210318202928.166955-1-ribalda@chromium.org>
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

