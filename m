Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A79345FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhCWNlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhCWNk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:40:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BFAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 06:40:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id e14so8948973ejz.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Dh8Wzu8kVq+/wNWGF7WLux54WatKazjsRYvC0lfLjg=;
        b=UcOizWiBt0Aa8UBzGS9dnt74F83HWzTX3vxSrX/wIRebamGz4BrbMxPq8k3UyleY41
         JEtukybV3OF1bUgVFnmF2akQQ1jSTsmdsmhPWPzk6QqOvKp8IEM0UhvI37dSTts2MqNr
         qSb2waumwU9GdELkguv9sY9t+RTiLqj22T6ENj4mtGuv8rVXcGW2kqDGTWk5PlykpLwH
         iW+JL8SL50XkGRffY7DuIyWXICb0hjUxhBYMplOocuzOdUuGhgqmQLrXbs4sJXA4oROX
         wPt7QSjZ8FbhJyYkyfb07dfHDYgsMXRR8rl8n7PByEK94yUjCEAdr0aeDo8tpdzL8NP/
         areg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Dh8Wzu8kVq+/wNWGF7WLux54WatKazjsRYvC0lfLjg=;
        b=gEcP0XMmbtn/vibt9RMZm1R5Xp1rI9fie5FQvbWwlms+4zYllMrhblTw4IP+auzKJO
         yVgf9mmBbP/U8/P0cCRgcD0JUPD96bPwjil0I0Btdthpt34NvX9EteiUvZTx0ipfR+1i
         ZtX0dLuEUK13jNG1dKDRR+7B9KnGmGXwAc7+lYIC3lDJnXnGKAfnKRWW0qvkb1n0fQ0N
         P+rm2VXhn+Bv4dOjTcZLJGHoWAf48AnjkDceuhLiSzlHsFOv3d53HP/d+sd+8NBU91Kq
         KNp/kXn5dwYEPAJeCfZ7y4NSihUkTSWLq61Q84fY2vlzC/Ki45CVXqe4DdpjwDJMMl79
         Wbpg==
X-Gm-Message-State: AOAM532S7PEsdCM0fyUgX52ZRR0GBPxJUr8wJCSeAVtC0FrIoQIu7dii
        MdMybSSyQcEfxyFHWq2X1V+AFQ==
X-Google-Smtp-Source: ABdhPJy6p0Vbd1inSfpBUgLqOKNQ+ykW1tRe9Q6rsCbO6GJdqLCqP+MoM+5zZ6oYvpe8NYcl2Lybew==
X-Received: by 2002:a17:906:eda3:: with SMTP id sa3mr4965869ejb.147.1616506856297;
        Tue, 23 Mar 2021 06:40:56 -0700 (PDT)
Received: from localhost.localdomain (hst-221-13.medicom.bg. [84.238.221.13])
        by smtp.gmail.com with ESMTPSA id r10sm11207317eju.66.2021.03.23.06.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:40:56 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, ezequiel@collabora.com,
        nicolas.dufresne@collabora.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v6 2/5] docs: Document colorimetry class
Date:   Tue, 23 Mar 2021 15:40:37 +0200
Message-Id: <20210323134040.943757-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323134040.943757-1-stanimir.varbanov@linaro.org>
References: <20210323134040.943757-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a document for ext control colorimetry class.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 .../userspace-api/media/v4l/common.rst        |  1 +
 .../media/v4l/ext-ctrls-colorimetry.rst       | 22 +++++++++++++++++++
 .../media/v4l/vidioc-g-ext-ctrls.rst          |  4 ++++
 3 files changed, 27 insertions(+)
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-colorimetry.rst

diff --git a/Documentation/userspace-api/media/v4l/common.rst b/Documentation/userspace-api/media/v4l/common.rst
index 8c263c5a85d8..ea0435182e44 100644
--- a/Documentation/userspace-api/media/v4l/common.rst
+++ b/Documentation/userspace-api/media/v4l/common.rst
@@ -51,6 +51,7 @@ applicable to all devices.
     ext-ctrls-fm-tx
     ext-ctrls-fm-rx
     ext-ctrls-detect
+    ext-ctrls-colorimetry
     fourcc
     format
     planar-apis
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-colorimetry.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-colorimetry.rst
new file mode 100644
index 000000000000..862f78b41b32
--- /dev/null
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-colorimetry.rst
@@ -0,0 +1,22 @@
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
+
+.. _colorimetry-controls:
+
+*****************************
+Colorimetry Control Reference
+*****************************
+
+The Colorimetry class includes controls for High Dynamic Range
+imaging for representing colors in digital images and video. The
+controls should be used for video and image encoding and decoding
+as well as in HDMI receivers and transmitters.
+
+Colorimetry Control IDs
+-----------------------
+
+.. _colorimetry-control-id:
+
+``V4L2_CID_COLORIMETRY_CLASS (class)``
+    The Colorimetry class descriptor. Calling
+    :ref:`VIDIOC_QUERYCTRL` for this control will
+    return a description of this control class.
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
index 01773f01c4a7..15291be55299 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
@@ -404,6 +404,10 @@ still cause this situation.
       - 0xa40000
       - The class containing stateless codec controls. These controls are
 	described in :ref:`codec-stateless-controls`.
+    * - ``V4L2_CTRL_CLASS_COLORIMETRY``
+      - 0xa50000
+      - The class containing colorimetry controls. These controls are
+	described in :ref:`colorimetry-controls`.
 
 Return Value
 ============
-- 
2.25.1

