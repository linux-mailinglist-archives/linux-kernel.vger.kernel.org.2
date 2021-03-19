Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1F0341526
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhCSFyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbhCSFyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:54:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01DEC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:54:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c204so5120620pfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jyTPoXC+agDm6WJSaqjfD12BGhd0Fxr1GYMHe0K10zA=;
        b=kxXuWcZJwRjoAmyd5MBMk+3mlZzONtdXDbWaBQUKYaFy6tm4Kao0LVcVdWL6waVb2d
         UZq02baLfySUlSWCn69hYebwohAGySW/ztsDxc3x6C8a/pBGSb8UE3csE9C6ID3kIoaW
         AGoo4IJy/5na8z2ZSDc1FgyqTSeBUsdvqYeqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jyTPoXC+agDm6WJSaqjfD12BGhd0Fxr1GYMHe0K10zA=;
        b=bX6zVx0amQ0t7U9OGWE0WlsiRFeppSzFarmfexOxaUdfiQtqIhsrWy9JUpF//swD6Q
         HWvijp9ft+pklshWIe1ER6HKr2yOmRcCc46asXpCicIYwic0MaYnCZ1TkoR5nU8N7i7K
         BCG9gxkx+s6xIZQpH71Q82N8MA48nyiPz+5GVUDqiqgn1Ngyb3WQOJEteh6KsLqbZejz
         sF7MdLuIh8QGSZc3fd8ZK4I0SwyS0yFWzUKHT8qd4uR+WsNvWFPi99Ob+5UFrUEYO/el
         Vme+3bKmGeI9qpvdf+UUmxEAuwSZS54GSTwg534BG13IzmdUV2fee0Gkqo4UhFTSCaOL
         hG4g==
X-Gm-Message-State: AOAM533CdcQWeuRwxZjRARPSszeF6zwbTkivqjBt2007g/xkdWdnTT8H
        dk7H4jqHUDfm0n5r2C7YEj7RmQ==
X-Google-Smtp-Source: ABdhPJw9T2zzejTlLx3jjaqPgN9EwMOTRdXXODGEEtSe1op00FIxeX3UZGDXWLURWuLWgQ3wAeTgAw==
X-Received: by 2002:a63:4658:: with SMTP id v24mr9973502pgk.258.1616133240492;
        Thu, 18 Mar 2021 22:54:00 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:6577:f83d:5865:dfac])
        by smtp.gmail.com with ESMTPSA id o13sm4043704pgv.40.2021.03.18.22.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 22:54:00 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 4/6] media: v4l UAPI: document ROI auto-controls flags
Date:   Fri, 19 Mar 2021 14:53:40 +0900
Message-Id: <20210319055342.127308-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319055342.127308-1-senozhatsky@chromium.org>
References: <20210319055342.127308-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document ROI auto controls.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 .../media/v4l/v4l2-selection-flags.rst        | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/v4l2-selection-flags.rst b/Documentation/userspace-api/media/v4l/v4l2-selection-flags.rst
index 1cb1531c1e52..536d29a6c4a5 100644
--- a/Documentation/userspace-api/media/v4l/v4l2-selection-flags.rst
+++ b/Documentation/userspace-api/media/v4l/v4l2-selection-flags.rst
@@ -48,6 +48,46 @@ Selection flags
 	inside the subdevice to all further processing steps.
       - No
       - Yes
+    * - ``V4L2_SEL_FLAG_ROI_AUTO_EXPOSURE``
+      - (1 << 0)
+      - Auto Exposure.
+      - Yes
+      - No
+    * - ``V4L2_SEL_FLAG_ROI_AUTO_IRIS``
+      - (1 << 1)
+      - Auto Iris.
+      - Yes
+      - No
+    * - ``V4L2_SEL_FLAG_ROI_AUTO_WHITE_BALANCE``
+      - (1 << 2)
+      - Auto White Balance.
+      - Yes
+      - No
+    * - ``V4L2_SEL_FLAG_ROI_AUTO_FOCUS``
+      - (1 << 3)
+      - Auto Focus.
+      - Yes
+      - No
+    * - ``V4L2_SEL_FLAG_ROI_AUTO_FACE_DETECT``
+      - (1 << 4)
+      - Auto Face Detect.
+      - Yes
+      - No
+    * - ``V4L2_SEL_FLAG_ROI_AUTO_DETECT_AND_TRACK``
+      - (1 << 5)
+      - Auto Detect and Track.
+      - Yes
+      - No
+    * - ``V4L2_SEL_FLAG_ROI_AUTO_IMAGE_STABILIXATION``
+      - (1 << 6)
+      - Image Stabilization.
+      - Yes
+      - No
+    * - ``V4L2_SEL_FLAG_ROI_AUTO_HIGHER_QUALITY``
+      - (1 << 7)
+      - Higher Quality.
+      - Yes
+      - No
 
 .. raw:: latex
 
-- 
2.31.0.rc2.261.g7f71774620-goog

