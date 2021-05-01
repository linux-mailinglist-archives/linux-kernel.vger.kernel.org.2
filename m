Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AB5370662
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 10:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhEAIVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 04:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhEAIVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 04:21:10 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8168C06138C
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 01:20:20 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t21so220061plo.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 01:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kUuJOx/AeUiCPZH/3dKnOjX2Mw03lZQ+/w7qSbaYDnE=;
        b=jgjF5nZS67LyXAmTIvUg1x2FotO+EmeSEhgPqJelFWtgBadFr+OOszqztQb5AKG1TJ
         RR7sF8BfbF3y5iUJ4ZNW2pSwpV8YnA0z0vHMm/jTIAUGW0it4sTjsersGeKgRvqGxWZG
         9ClMtXgePLXsSouR0HTeRfSUXHUrkqAAlsSK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kUuJOx/AeUiCPZH/3dKnOjX2Mw03lZQ+/w7qSbaYDnE=;
        b=Zuzmmq2AYknSZwaab5Lj4OpGDZB9TTjOgAsx3nZVgSUScilFqc6cLEMyg3nS7fZuke
         X5fnrmfq/loGhYB70L3VhtysESj0e9+FGvz8xb9Q2D7gPzLsNs6aA5HiK0ScoHO32Nyg
         a0eFFrqrv3WN1xwyo7bcWBYSj8UaDyBLBaWq5I4/FFKq7bC97QAACHQ6YgaEJElBAWty
         vnwkZSyTD18WT6GgN7aCyTGBSs/dO6brYPOWzETWu8OteZyOIL3TYjaS+XsGQeRtNKZR
         kaVdhZXOLAIEQbdWmKHgTC4UMNtB6lvNrGHpMGyDZWLIqyuxjhBcHWKHhUwg06DUidQO
         V42g==
X-Gm-Message-State: AOAM533y2kB6Xe46z5uRwylOwJbr+Hb4/+rXTrzCTqmns5J8oWxI+8k9
        fN3BGEK/NFFm8MjL+qdCJOOKWg==
X-Google-Smtp-Source: ABdhPJzGz4RS0xDBo4lWip3mqE/woDu99ydFoDvoPCsQrG5fIaxbZASrdp1oPJ9RxsFOyppuMiZaFw==
X-Received: by 2002:a17:90b:3591:: with SMTP id mm17mr9346961pjb.184.1619857220478;
        Sat, 01 May 2021 01:20:20 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:8be7:e987:d00a:1442])
        by smtp.gmail.com with ESMTPSA id b7sm3763003pjq.36.2021.05.01.01.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 01:20:20 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 4/5] media: v4l UAPI: document ROI auto_controls
Date:   Sat,  1 May 2021 17:20:00 +0900
Message-Id: <20210501082001.100533-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
In-Reply-To: <20210501082001.100533-1-senozhatsky@chromium.org>
References: <20210501082001.100533-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UVC 1.5 defines the following Region of Interest auto_controls

|D0: Auto Exposure
|D1: Auto Iris
|D2: Auto White Balance
|D3: Auto Focus
|D4: Auto Face Detect
|D5: Auto Detect and Track
|D6: Image Stabilization
|D7: Higher Quality
|D8 – D15: Reserved, set to zero

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 .../media/v4l/ext-ctrls-camera.rst            | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
index 4c5061aa9cd4..f59cb4d06697 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-camera.rst
@@ -217,7 +217,30 @@ enum v4l2_auto_focus_range -
     * - ``V4L2_AUTO_FOCUS_RANGE_INFINITY``
       - The lens is set to focus on an object at infinite distance.
 
+``V4L2_CID_REGION_OF_INTEREST_AUTO (bitmask)``
+    This determines which, if any, on board features should track to the
+    Region of Interest.
 
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_CID_REGION_OF_INTEREST_AUTO_EXPOSURE``
+      - Auto Exposure.
+    * - ``V4L2_CID_REGION_OF_INTEREST_AUTO_IRIS``
+      - Auto Iris.
+    * - ``V4L2_CID_REGION_OF_INTEREST_AUTO_WHITE_BALANCE``
+      - Auto White Balance.
+    * - ``V4L2_CID_REGION_OF_INTEREST_AUTO_FOCUS``
+      - Auto Focus.
+    * - ``V4L2_CID_REGION_OF_INTEREST_AUTO_FACE_DETECT``
+      - Auto Face Detect.
+    * - ``V4L2_CID_REGION_OF_INTEREST_AUTO_DETECT_AND_TRACK``
+      - Auto Detect and Track.
+    * - ``V4L2_CID_REGION_OF_INTEREST_AUTO_IMAGE_STABILIZATION``
+      - Image Stabilization.
+    * - ``V4L2_CID_REGION_OF_INTEREST_AUTO_HIGHER_QUALITY``
+      - Higher Quality.
 
 ``V4L2_CID_ZOOM_ABSOLUTE (integer)``
     Specify the objective lens focal length as an absolute value. The
-- 
2.31.1.527.g47e6f16901-goog

