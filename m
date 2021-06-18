Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928553ACAE8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhFRMcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbhFRMbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:31:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A672C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:29:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id nd37so15688215ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MHDtZOoCZ6aN61H0APnuAAPGItqgIkFXffpm9NqcF0M=;
        b=LnVe8WQOFNtguQlmVexXyfE8uVPoOCyy+Mw1pokKW0TS4m4Fw6rjmnHUSSxtQcZByC
         SmZGhny0mTI6jPKmRwo3mXiInouiNknJlDUWugpxB7SUVj4xSsAljRXsWwlGi3lI9pcZ
         N/v5G55cVfEo7YP0ZbA3bRqtkhmeds5IgrlQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MHDtZOoCZ6aN61H0APnuAAPGItqgIkFXffpm9NqcF0M=;
        b=IrGnju0Z67uxmHoJ3oqdi6rT6zSyjspAc7nKYrSiWYMBmoEH3MllmV/DKRXkPol789
         cdw1HIWd27LqXbkUgj0ff3fopTpGjtHPOg+d40/Bf/4WxagCtPJ+4O4/91WZCaEH2uZU
         0SFviY3lv8jL9BYWkBAxFJxvYuD/xJXFFT7MOMZoS2JivVcz12kDGgoWNcVWtZMYbhcm
         uJeyrJq1IjUaQeHAJcxOSX5qrMMYCGKRrM9L+24wZN4k7xkOOmDNnDenM2YYIpwPd+UD
         DsrrFMw66gjdA8mwlEuFmT16IqyP+1iDio5F0zJBAeTqCLqvZ2TaK52Aq+rxiC+IGmUq
         yHHw==
X-Gm-Message-State: AOAM533JIDM4KQtbeKOCWWjlTOB/mUN3yQqeQgrT+EcfptiaboRj4FZ2
        q3Sh69hM3hDZx8j4aE1XwVOO2Q==
X-Google-Smtp-Source: ABdhPJy0UNxYfXh09bJqYu4K0TODevCKb5zGix9mGeqNrp/r86gdEMViC31+8FeylBLEuHU6FMPjXg==
X-Received: by 2002:a17:906:d1ce:: with SMTP id bs14mr11037099ejb.183.1624019369760;
        Fri, 18 Jun 2021 05:29:29 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id o26sm4336403edt.62.2021.06.18.05.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 05:29:29 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v10 06/21] media: uvcvideo: Set capability in s_param
Date:   Fri, 18 Jun 2021 14:29:08 +0200
Message-Id: <20210618122923.385938-7-ribalda@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210618122923.385938-1-ribalda@chromium.org>
References: <20210618122923.385938-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes v4l2-compliance:

Format ioctls (Input 0):
                warn: v4l2-test-formats.cpp(1339): S_PARM is supported but doesn't report V4L2_CAP_TIMEPERFRAME
                fail: v4l2-test-formats.cpp(1241): node->has_frmintervals && !cap->capability

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index ac98869d5a05..1eeeb00280e4 100644
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
2.32.0.288.g62a8d224e6-goog

