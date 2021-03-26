Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C2434A534
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhCZKAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhCZJ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:58:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4206EC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:58:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j3so5580196edp.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2y2043uffVR+Axz3IQVPi3Ysoys/BWtFNPbRtzf1kL0=;
        b=XgF63OA3iDsQinIPZBYEr8xo0HmgnBltM2VyBTZUJlrE7RvmQWTXVJ/bPDKAQgcbSr
         hMzMUxoBPWavwexaFLyLHvsj9kuOGk4t4tYOfFeBHZREj7an3p7wF3sDIXq0RZ72q5BK
         zWkAxBGo9khdo6tgVxlUUdVPNNA30QfR7Ynv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2y2043uffVR+Axz3IQVPi3Ysoys/BWtFNPbRtzf1kL0=;
        b=frNT+ElVf7MAVV56G2aEHst5aQA5uXYHrjbGMt18p55m7pMSZXsqSiSw67xPc7SK6g
         lEYaRZzPR09rk9pC1S1w7rDanc4il6xbIF7Swsfe+SLLBPROYe1Upue9faW4nCwQ1vMq
         7aiEw5/LzT1nMK4KjxWChfT6tVUdnZWxS60IbJPrZabNiHswrVQdfMerFg5AWJfWAGgM
         uxqeXKOAP7ytjk7ZDTeVoBUSzAkTM/TFwF+eujPXw28kCwIUEazoyCmkXiQLQ9vFkRQW
         1Az5AiurMoSJS7r5WODQYJyuqKEm0RpKVDtKweDDP4W+g3cZBJ0V4pxBKi97cMn81P+0
         KyFA==
X-Gm-Message-State: AOAM532o9n/6ape/ZOvlea329I0ZIDPRC0vhHNz0sT9QlN9XlgTCFwZK
        mfgGhKJigew080p0b/6igUia2g==
X-Google-Smtp-Source: ABdhPJxvjIQgrOmedo0HpCzfT7PVy74zFLNCDZ0n2a5fez8hs/en3vpCIMntNMC2y9Q/wN+2rK09uA==
X-Received: by 2002:a50:fd15:: with SMTP id i21mr13534405eds.384.1616752737079;
        Fri, 26 Mar 2021 02:58:57 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h13sm4036658edz.71.2021.03.26.02.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:58:56 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v9 18/22] media: uvcvideo: Downgrade control error messages
Date:   Fri, 26 Mar 2021 10:58:36 +0100
Message-Id: <20210326095840.364424-19-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210326095840.364424-1-ribalda@chromium.org>
References: <20210326095840.364424-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the error into a debug message, so they are still valid for
debugging but do not fill dmesg.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index ea2903dc3252..b63c073ec30e 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -76,7 +76,7 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	if (likely(ret == size))
 		return 0;
 
-	dev_err(&dev->udev->dev,
+	dev_dbg(&dev->udev->dev,
 		"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
 		uvc_query_name(query), cs, unit, ret, size);
 
-- 
2.31.0.291.g576ba9dcdaf-goog

