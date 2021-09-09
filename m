Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACE84059F6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 17:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbhIIPCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 11:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbhIIPCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 11:02:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7198C061764
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 08:00:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g21so3082057edw.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nyRNd3VAua6ltU/T1+T7w24h2BGtw7h9hpcdASMSl58=;
        b=YcYQr1gQwSbzGcHWCUaAILJtH/tDjpoaEA0KpLgw/Mo9sklFUPX/qlAIUVGZSTjmTg
         VugoNYAsyzAwKU+8JXV4ALFAI3/Oo49mwzpi7Tmy7yUM/u/8uZCbwBZBO/TWECgY7bar
         XFipPiBVEHq0TBzM0M/1tZe28Cusl0wqLhVh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nyRNd3VAua6ltU/T1+T7w24h2BGtw7h9hpcdASMSl58=;
        b=bBdffsehf4s53Y1D5XgynVHif2z3TvoZGx0SbQPPP8JtKhOWkysX3q90VfMUIDqQg0
         WyOPTGOcHI1wTdVroMcksXxlYdCMJsYwXKzdetYt24oRkrpSVxhVKTydKFaPVvpTaWWd
         il7YXiIVv3baRt7Y5iTx93VobVT1HzZAilEEa6HFGevst5VTbbgA/n9+GMtxNfqaDsad
         O4wnqblz0QPwgEs9Mw/4urNatAdhGyoE3yr9vv8jzbK9cgfapK5VTYF1bh8Tto9Ossb1
         k0DfWSdWDvE3K5GqfpKagJTO+ELgxTnrFXYP+wR5uW8DcXFpLU5GKjmz7U/s8YMH1zjm
         7HdA==
X-Gm-Message-State: AOAM530sSW91NnGRIGF/Fj3rM1RT7TqOQbtHkUHjeqYdSE+UDrFpn7cd
        kFH9G+MH6E93EFvbha/B6D7Q/w==
X-Google-Smtp-Source: ABdhPJzBWbTmbMGQ/8bdekcwBUK9YxcHI9yToRdEb0KUqutjH/4WiBY8OQN6P+DdcfSOa/rJm19KNw==
X-Received: by 2002:a05:6402:358e:: with SMTP id y14mr3664246edc.296.1631199650910;
        Thu, 09 Sep 2021 08:00:50 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h8sm1139644ejj.22.2021.09.09.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 08:00:50 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: [PATCH 2/4] media: uvcvideo: improve error logging in uvc_query_ctrl()
Date:   Thu,  9 Sep 2021 17:00:44 +0200
Message-Id: <20210909150046.57615-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
In-Reply-To: <20210909150046.57615-1-ribalda@chromium.org>
References: <20210909150046.57615-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

If __uvc_query_ctrl() failed with a non-EPIPE error, then
report that with dev_err. If an error code is obtained, then
report that with dev_dbg.

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/usb/uvc/uvc_video.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 9f37eaf28ce7..dfea967309f2 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -79,13 +79,14 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	if (likely(ret == size))
 		return 0;
 
-	dev_err(&dev->udev->dev,
-		"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
-		uvc_query_name(query), cs, unit, ret, size);
-
-	if (ret != -EPIPE)
+	if (ret != -EPIPE) {
+		dev_err(&dev->udev->dev,
+			"Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
+			uvc_query_name(query), cs, unit, ret, size);
 		return ret;
+	}
 
+	/* reuse data[0] to request the error code. */
 	tmp = *(u8 *)data;
 
 	ret = __uvc_query_ctrl(dev, UVC_GET_CUR, 0, intfnum,
-- 
2.33.0.153.gba50c8fa24-goog

