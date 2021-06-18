Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEA53ACAFB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhFRMcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbhFRMbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:31:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8236CC0613A2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:29:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id nb6so15543211ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PFyrIhhgQyBQ0g2/AM+7raFFZmALPzPZ2MIK0o6IEmo=;
        b=mlK1cZj0c+KeXg2ZBoAUZapIkPVSnEZcYYzDo0wUWMpenGHxd6Y8+J8IczrCcUZ2Jq
         KeMZix3Owkmj1n1ok3NdT7QdNkDP5V+EPg/EAe3KGnVim5xPah727P4CwMnO8jX7SBOL
         pKH/uj6bTKTXLVCbo5JtYxUo6s//yKqMqfMqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PFyrIhhgQyBQ0g2/AM+7raFFZmALPzPZ2MIK0o6IEmo=;
        b=sgcDRYmjLlk0cZgLltGtfLsfA08TUGxHBE79GzARPMROUEGAJlOHOT3H11R/PJj86o
         7djdEKjidi8GBnosJinVl63C323tyrMvvlA9unVq+fuqrfD18oKgaPpTDjVDs046aa9u
         3AJjW4FvM6TCLuzEDHBT0pARNolYkv1bimtzvBmGfuiRYV6mjp0ufaTbDUkHijLapFg3
         RDtTrBERnUXLMgXNBKHdjt3fA+zBYHegoaDGoPa6V1YSBKApp8O26T2EkFnxQ4vZm6qk
         kQnWWSk0wZsMc+xnXxR+uD/lPv7N8xbJTGkbUMby4EWpcZA2XrPbkxF5/YRjry1IoIHW
         4YAQ==
X-Gm-Message-State: AOAM531esR6xZNz9WqMDsLJdTjbEoEAUuYsjIl1Y00acpLN6R7KzzK1W
        LS+yQfXxjpE7mYhXCb8SGMB81w==
X-Google-Smtp-Source: ABdhPJyzRtbd4q8EILwWx8EBs1/4Obp7haY0YV+eCtIL/LYBZFMOQ19DgTVQHAuFmtq3Qh0Kli8btw==
X-Received: by 2002:a17:906:ca17:: with SMTP id jt23mr10964504ejb.334.1624019377106;
        Fri, 18 Jun 2021 05:29:37 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id o26sm4336403edt.62.2021.06.18.05.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 05:29:36 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: [PATCH v10 18/21] uvcvideo: improve error handling in uvc_query_ctrl()
Date:   Fri, 18 Jun 2021 14:29:20 +0200
Message-Id: <20210618122923.385938-19-ribalda@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210618122923.385938-1-ribalda@chromium.org>
References: <20210618122923.385938-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

- If __uvc_query_ctrl() failed with a non-EPIPE error, then
  report that with dev_err. If an error code is obtained, then
  report that with dev_dbg.

- For error 2 (Wrong state) return -EACCES instead of -EILSEQ.
  EACCES is a much more appropriate error code. EILSEQ will return
  "Invalid or incomplete multibyte or wide character." in strerror(),
  which is a *very* confusing message.

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/usb/uvc/uvc_video.c | 38 ++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index daba5fe352ea..00488f15cdbf 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -79,15 +79,11 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	if (likely(ret == size))
 		return 0;
 
-	dev_err(&dev->udev->dev,
-		"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
-		uvc_query_name(query), cs, unit, ret, size);
-
-	if (ret != -EPIPE)
-		return ret;
+	if (ret < 0 && ret != -EPIPE)
+		goto err;
 
+	/* reuse data[0] to request the error code. */
 	tmp = *(u8 *)data;
-
 	ret = __uvc_query_ctrl(dev, UVC_GET_CUR, 0, intfnum,
 			       UVC_VC_REQUEST_ERROR_CODE_CONTROL, data, 1,
 			       UVC_CTRL_CONTROL_TIMEOUT);
@@ -95,19 +91,21 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	error = *(u8 *)data;
 	*(u8 *)data = tmp;
 
-	if (ret != 1)
-		return ret < 0 ? ret : -EPIPE;
+	if (ret != 1) {
+		ret = ret < 0 ? ret : -EPIPE;
+		goto err;
+	}
 
-	uvc_dbg(dev, CONTROL, "Control error %u\n", error);
+	if (error >=1 && error <=8)
+		uvc_dbg(dev, CONTROL,
+			"Failed to query (%s) UVC control %u on unit %u: got error %u.\n",
+			uvc_query_name(query), cs, unit, error);
 
 	switch (error) {
-	case 0:
-		/* Cannot happen - we received a STALL */
-		return -EPIPE;
 	case 1: /* Not ready */
 		return -EBUSY;
 	case 2: /* Wrong state */
-		return -EILSEQ;
+		return -EACCES;
 	case 3: /* Power */
 		return -EREMOTE;
 	case 4: /* Out of range */
@@ -123,10 +121,18 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	case 8: /* Invalid value within range */
 		return -EINVAL;
 	default: /* reserved or unknown */
-		break;
+		dev_err(&dev->udev->dev,
+			"Failed to query (%s) UVC control %u on unit %u: got error %u.\n",
+			uvc_query_name(query), cs, unit, error);
+		return -EPIPE;
 	}
 
-	return -EPIPE;
+err:
+	dev_err(&dev->udev->dev,
+		"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
+		uvc_query_name(query), cs, unit, ret, size);
+
+	return ret;
 }
 
 static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
-- 
2.32.0.288.g62a8d224e6-goog

