Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABB4337260
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhCKMVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbhCKMUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:20:46 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD8BC061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:20:45 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bm21so45793056ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5NeM7Soa1KpDS0TograRre+Oj0MkKDYHA02GekTX+K8=;
        b=OtwZAJvoTG9SwWEwdqkr7b2wVuiQlAaV2T+6d6Wfy5YRuG2HsVfTnYTzFDyZFPAUQX
         a8VAZqgFH2DGuEifrLURo4a0HzwY4fvLLErBhqPuljh0zxE1XM/n1XUZKtxxAgecMdu+
         tim/MixlxQ6NZv2ufjCz1qUOWrU0uRChF+vm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5NeM7Soa1KpDS0TograRre+Oj0MkKDYHA02GekTX+K8=;
        b=oJfsaYB+QwrIqGmnQwdSaQsEqTGbJzPbZefUe5+hNtCUVQ9h4KMvZ9x1ofRtKF7elo
         kHuZiH6ESCl2yUE+DaX1qnDvTZuEQRsxBE08nQsq31XxasuzoeXmp682OGUdPho8s0+8
         eVQ/2F9rTUPBu1tQ602dL5F1IME1rqZMw+4SNCCTC2EVpil3fvSSACy/Q6dY8VZGWU1K
         QWSPE4a2O7e3vJI/3eYgU7eSg7DybO/kGNLFaGZb/IPkG2PYtj4jnonYjYHlXIF3ui9c
         enpgWaKX2dnK0dAv43Yf7nuPDRahhiqU0dUFCtRIrL0WTLcP1kvQroHIM0ey7fZaOcyi
         /0aw==
X-Gm-Message-State: AOAM533A4JlT4Leql2B/78dznHjPPa8dglu5L/FewVFc+HtkJiwC1FIT
        tvEeO/QXok2nZGxb1nsCo0P0lwesJE0bB/4G
X-Google-Smtp-Source: ABdhPJxMkGsld8bPDh1woow4boX8GSdu5EUrHojZV+uXD6RqFOwBbS027oD6S6w+tTZQ0EmR6pgMww==
X-Received: by 2002:a17:906:565a:: with SMTP id v26mr2870780ejr.516.1615465244394;
        Thu, 11 Mar 2021 04:20:44 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id u13sm1264126ejy.31.2021.03.11.04.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 04:20:44 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, senozhatsky@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 02/10] media: uvcvideo: Set capability in s_param
Date:   Thu, 11 Mar 2021 13:20:32 +0100
Message-Id: <20210311122040.1264410-4-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210311122040.1264410-1-ribalda@chromium.org>
References: <20210311122040.1264410-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes v4l2-compliance:

Format ioctls (Input 0):
                warn: v4l2-test-formats.cpp(1339): S_PARM is supported but doesn't report V4L2_CAP_TIMEPERFRAME
                fail: v4l2-test-formats.cpp(1241): node->has_frmintervals && !cap->capability

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 5e3ec4a376e4..625c216c46b5 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -472,10 +472,13 @@ static int uvc_v4l2_set_streamparm(struct uvc_streaming *stream,
 	uvc_simplify_fraction(&timeperframe.numerator,
 		&timeperframe.denominator, 8, 333);
 
-	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+	if (parm->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
 		parm->parm.capture.timeperframe = timeperframe;
-	else
+		parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
+	} else {
 		parm->parm.output.timeperframe = timeperframe;
+		parm->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
+	}
 
 	return 0;
 }
-- 
2.31.0.rc2.261.g7f71774620-goog

