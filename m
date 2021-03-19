Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0A8341525
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhCSFyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbhCSFx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:53:58 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7F5C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:53:57 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e33so2960015pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7bBizUYYzN3HQgW0K4Fq8tSkGNuVzaIR04mHPd6N77g=;
        b=H1AC9ucGadxZAm4U2ob93CWFKIDNbUVeNj2XJzkJFYUuj1Z4ACD3uxFvOtxxI9iiQj
         /0LoXpe3/TyU3iML47ghcy6s+vP89mOr3g7B+00iT9U6cuqaZ1PQ4FeMix0pjMYcYlh+
         1kVY6wgcP5Z4p5ofNcb/yXKhRMALZwibVDrj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7bBizUYYzN3HQgW0K4Fq8tSkGNuVzaIR04mHPd6N77g=;
        b=XDU2RkJEHBvQmXkLDdrXhjpFkK5YRuZPjrTxXdrimYyEGgu5LxDk7JqO34bPfurHLd
         dKTaFSuBsUKRsPEEtfYz1wl7dWcQXe9ZGI7yVlWC3wXPHyFNmqHw8rEUwFxFiBxNlSY8
         mg6MJqzMCB34Kwy90xCpsvWevCSdIQbG3VlIIs2wDwyIDZzFT3O1lia9reL6w63uQlCP
         P1gsvU18ULbGdb0ATEXFWD4nsdiHLNpQlIeNrM/GGfkXW/4TaHVipGnkr7nWMA3vaEag
         55KREur9AIX88IKItf/5t0L0V+eEoRR9wJUg+7JKDxb95Ld6s0wcqNm4j4z7y5gKGyii
         6Bgg==
X-Gm-Message-State: AOAM531FRWIYhfi7FM+KvC8EpPLgAt0CICFXxEzet6IsV+5tkAYJ2hF1
        JE9pgfplj3uZCZR3w2tgrXgAzw==
X-Google-Smtp-Source: ABdhPJyBASKQu5ZuY+1mAh+SW7AT0fIGNRvC2lwEGtw9hTKkG9EH4viLR11DOW0JtTN/FD5erhMhjQ==
X-Received: by 2002:aa7:96cc:0:b029:202:6873:8ab4 with SMTP id h12-20020aa796cc0000b029020268738ab4mr7536566pfq.42.1616133237574;
        Thu, 18 Mar 2021 22:53:57 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:6577:f83d:5865:dfac])
        by smtp.gmail.com with ESMTPSA id o13sm4043704pgv.40.2021.03.18.22.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 22:53:57 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 3/6] media: v4l UAPI: add ROI auto-controls flags
Date:   Fri, 19 Mar 2021 14:53:39 +0900
Message-Id: <20210319055342.127308-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319055342.127308-1-senozhatsky@chromium.org>
References: <20210319055342.127308-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UVC 1.5 defines the following Region Of Interest auto controls:

D0: Auto Exposure
D1: Auto Iris
D2: Auto White Balance
D3: Auto Focus
D4: Auto Face Detect
D5: Auto Detect and Track
D6: Image Stabilization
D7: Higher Quality
D8 – D15: Reserved, set to zero

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/uapi/linux/v4l2-common.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/linux/v4l2-common.h b/include/uapi/linux/v4l2-common.h
index 3651ebb8cb23..34f1c262d6aa 100644
--- a/include/uapi/linux/v4l2-common.h
+++ b/include/uapi/linux/v4l2-common.h
@@ -92,6 +92,16 @@
 #define V4L2_SEL_FLAG_LE		(1 << 1)
 #define V4L2_SEL_FLAG_KEEP_CONFIG	(1 << 2)
 
+/* ROI auto-controls flags */
+#define V4L2_SEL_FLAG_ROI_AUTO_EXPOSURE		(1 << 0)
+#define V4L2_SEL_FLAG_ROI_AUTO_IRIS			(1 << 1)
+#define V4L2_SEL_FLAG_ROI_AUTO_WHITE_BALANCE		(1 << 2)
+#define V4L2_SEL_FLAG_ROI_AUTO_FOCUS			(1 << 3)
+#define V4L2_SEL_FLAG_ROI_AUTO_FACE_DETECT		(1 << 4)
+#define V4L2_SEL_FLAG_ROI_AUTO_DETECT_AND_TRACK	(1 << 5)
+#define V4L2_SEL_FLAG_ROI_AUTO_IMAGE_STABILIXATION	(1 << 6)
+#define V4L2_SEL_FLAG_ROI_AUTO_HIGHER_QUALITY		(1 << 7)
+
 struct v4l2_edid {
 	__u32 pad;
 	__u32 start_block;
-- 
2.31.0.rc2.261.g7f71774620-goog

