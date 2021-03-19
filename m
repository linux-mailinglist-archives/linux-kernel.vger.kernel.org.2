Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05668342304
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhCSRKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhCSRJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:09:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8394C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b7so10899754ejv.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ry4sUp7RLr2eYbkWRJyCjF01wLZEGEypv/sCp3NmiFo=;
        b=EJUAKM8/I8QSOEL/w5pyhJvhnsf3xxfa3jpMzXV1WRLIFAsAUl/+w78hU1GeDxrvyx
         +YbbC7Tp6C9xGHgWtbcQpy6IecpSNqBPa+d2qkBhbZ3nyZ8qD5mplZaLwqUqUgq9flJI
         99AAeI/vD0Wp3J4PQoF/YOJ30++HYioc7C7u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ry4sUp7RLr2eYbkWRJyCjF01wLZEGEypv/sCp3NmiFo=;
        b=a9VJuHD3gPjL2y35jpKSK2//YD0FL2lP1viOFOEZzH/X09AnYKJl6JgSCpkoThcCpz
         NA/HolxtnyGG1SPOEXWqP4wOTw+JC4ZAwp1mLmKTR0+wZp29T3KbFhaRCoO77tclUv4v
         6VtixbdWOb5x9FeULYn8SpuXTS8FNq2JiQW76FDJKiydLfi9kfzQv34Q8UtsmI7XgmZW
         S9jy2779Hhtx9ybK34bO2WoaXxjRhd6p+6uha2Wk9OLNv9HFglcTiMawqpyLiqxsMZQA
         mylq3HxYnc6/T98nSgvdZi0DP24quyY91UG7OtMGa+6Qwsi2xsvxclfahe5vty822aRb
         jPJA==
X-Gm-Message-State: AOAM533A6YkJfcR/sBky4ePZT3R4tHBySX0F55ajYYyenw+y5aJuycjs
        MW8ssR+PFXxvkFtowow7vEyyCsUpNbVFryFSiMg=
X-Google-Smtp-Source: ABdhPJwaQeIysz97UmqiDYALoDHmRJjaZToX+D7yVDoeyNOQUFrGWCnM8eTAxPbeh2rLqVSm0ADNOA==
X-Received: by 2002:a17:906:12db:: with SMTP id l27mr5464203ejb.500.1616173762762;
        Fri, 19 Mar 2021 10:09:22 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id be27sm4506050edb.47.2021.03.19.10.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:09:22 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 18/19] media: uvcvideo: Downgrade control error messages
Date:   Fri, 19 Mar 2021 18:09:05 +0100
Message-Id: <20210319170906.278238-19-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319170906.278238-1-ribalda@chromium.org>
References: <20210319170906.278238-1-ribalda@chromium.org>
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
2.31.0.rc2.261.g7f71774620-goog

