Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D823342302
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhCSRKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhCSRJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:09:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421C8C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:23 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id t18so10865804ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gn0hnJYZfg4Iz6ZCMPIjQveIDYMZQxxJBvj+S3RwuvQ=;
        b=AF85BynYuNVUnF9MJlnfAVGYHQOTUQBkJIDmLPsahcRBZHItdSfh9K0j1uW0KYf73C
         uffN38MXLMTFNyqvLS4Dyq9/ZvtV26AklHf86HN8rmHIkioGveiZN2qwLBKNocX8R4tw
         muvj0I3XF5rhFTRPZv9JjuBujnz2Fuv4pAiF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gn0hnJYZfg4Iz6ZCMPIjQveIDYMZQxxJBvj+S3RwuvQ=;
        b=JQ3uNnU9w7EWluCEaRucC50+fwMilexBxMz/g7aOi+RGsC8jXO+zbV9ZFYAqdc6jm7
         /XxfVMRc6TGd9Maji0ooCieC11bvHDp2o4iqtHGUl+DDxabqXPd9NS8Mv9vbSpLdwROS
         2W81ZCg4n9Q6ongqEZ4NsDJHyYFdZ52h1/exzFUJfzDduJP9p3cQyeUz/RGMmq31G1d9
         wBu63DYCzj2Nfrg++Um7IQ2UevVVL6Q02NCvpy0S/VO0NfDPQWOOiSdOVW2wIBweOXj8
         /pCCWg+kv6qvFKFbHii0F35GhxM8ECJnoaLhqzcmA7u0RMHgfLcCAXWpSPJMbb2EX56M
         829A==
X-Gm-Message-State: AOAM533RchTu4cul0cL8tFdLIswJvRLOJgo2+63pqZatp4BcOns781uE
        OVhi21nMDDu8uVvTCsSQty22kA==
X-Google-Smtp-Source: ABdhPJyHT9EGJP5se2NeRD0WbjuLarcYBJpBVmRtv0XHsb0BFe/jz3YBtR+I++nOYLmjktZc/Ik9wg==
X-Received: by 2002:a17:906:260a:: with SMTP id h10mr5631325ejc.392.1616173761995;
        Fri, 19 Mar 2021 10:09:21 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id be27sm4506050edb.47.2021.03.19.10.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:09:21 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 17/19] media: docs: Document the behaviour of uvcdriver
Date:   Fri, 19 Mar 2021 18:09:04 +0100
Message-Id: <20210319170906.278238-18-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319170906.278238-1-ribalda@chromium.org>
References: <20210319170906.278238-1-ribalda@chromium.org>
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

