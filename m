Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EF3340F37
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhCRUaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbhCRU3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:29:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A24AC061761
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:29:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r12so6022460ejr.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gn0hnJYZfg4Iz6ZCMPIjQveIDYMZQxxJBvj+S3RwuvQ=;
        b=VqiiBSmnRsjGafnGAAhSOYMPz2iJuV3VYPF5aFJN0HmPgtVACvNWJPqjRLtMc+X2ZF
         y3k3Ab0CtSr4tDpW2fH7ogKoaya0nlkWO5Jgf0iF4PLAQUxNzM2CLDevDe24L4+CTQWq
         U8DWoA5BXjPaO5jdxA2xEmn3Bz8lsxs/TOHZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gn0hnJYZfg4Iz6ZCMPIjQveIDYMZQxxJBvj+S3RwuvQ=;
        b=RO6K51VTuUN83ykG+nuRGBSSXyvakWteo9A5CAVqXCZV45BdN+RK3dK0c1dlN7t6hy
         Hjm6+J2SDjv/+BCH+x14VV6GsDP60Qn0sR45gpTwWjgxZQUKP6tn6JzGCupvIxPzNGSq
         7LtK+XZl0YN9YyhuXbq7YkU3do9gsbNBVKMQh9yvFKOlAoMccEo98M/CaGlXxS742z2B
         whtOORhzIhs2zSTcyzJhyX2pw7+BFwGiPkSBNt6o8PMSmUdzxpqqM5unK4lDDBVp+qPg
         p7q4IyAIjqp1FaT+2RglMf73WGcXuG8PLf5w8UZn+Ay753EmENL+r6+b3pwNXb7XbGP7
         KgwQ==
X-Gm-Message-State: AOAM533UW9AC2chza3o45bkCRl5CdpDH/oFgPM/HuvblyzrufcpoJ0s7
        RPzoIPztr6IRQm4bv9oAIPwiDA==
X-Google-Smtp-Source: ABdhPJxd1EaSUr2pamtqwAxgYm8DLelKh8qwnwb+M8SZrbyM5TM7kERfcZ71Ufw+0ZXciGu/5SAA+w==
X-Received: by 2002:a17:906:ad4:: with SMTP id z20mr399682ejf.496.1616099378764;
        Thu, 18 Mar 2021 13:29:38 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id a22sm2533767ejr.89.2021.03.18.13.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:29:38 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v7 14/17] media: docs: Document the behaviour of uvcdriver
Date:   Thu, 18 Mar 2021 21:29:25 +0100
Message-Id: <20210318202928.166955-15-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210318202928.166955-1-ribalda@chromium.org>
References: <20210318202928.166955-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uvc driver relies on the camera firmware to keep the control states
and therefore is not capable of changing an inactive control.

Allow returning -EACESS in those cases.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/userspace-api/media/v4l/vidioc-g-ctrl.rst      | 5 +++++
 Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-ctrl.rst b/Documentation/userspace-api/media/v4l/vidioc-g-ctrl.rst
index 4f1bed53fad5..8c0a203385c2 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-ctrl.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-ctrl.rst
@@ -95,3 +95,8 @@ EBUSY
 
 EACCES
     Attempt to set a read-only control or to get a write-only control.
+
+    Or if there is an attempt to set an inactive control and the driver is
+    not capable of keeping the new value until the control is active again.
+    This is the case for drivers that do not use the standard control
+    framework and rely purely on the hardware to keep the controls' state.
diff --git a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
index b9c62affbb5a..bb7de7a25241 100644
--- a/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
+++ b/Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst
@@ -438,3 +438,8 @@ EACCES
 
     Or the ``which`` field was set to ``V4L2_CTRL_WHICH_REQUEST_VAL`` but the
     device does not support requests.
+
+    Or if there is an attempt to set an inactive control and the driver is
+    not capable of keeping the new value until the control is active again.
+    This is the case for drivers that do not use the standard control
+    framework and rely purely on the hardware to keep the controls' state.
-- 
2.31.0.rc2.261.g7f71774620-goog

