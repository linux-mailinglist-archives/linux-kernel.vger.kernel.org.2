Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1022C36C479
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 12:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbhD0Kz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 06:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhD0Kzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 06:55:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC95C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 03:55:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g14so9718852edy.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zivnrpMt9grXcc00hfPDRekMzfRQWCib77IYIuxpMgs=;
        b=tzfpJC7qfP9xk2oGPQn9+ykcs0cb85xMTdHgEtnpM15L3kcRl8q6lNv/UZfe7dFoDU
         6roq0fwm3dECIAL6HHYIuDYVYuDSXwDDyxPlCZNs0MO0HDdt/iOhOVC4uvAVDsMZ1/6P
         Jxq4rjxWr1qXcqrd7IqOZEfiOKQ7CFlMfIfzGwcDnnywaby3+v0+YImqUDvShgJCw9PF
         DVKsEzVacXSThdRAe+WsfHKFEADgb4qGsUsRndVQtZrBE1IUVziAOwHX3utz6MCXrYvw
         FQysBN8AfTeqpgo3qRqVJOsbin2spCxfpv9uLak+Av5KHV7nIydoUOgiVgvM6YchJCnV
         CjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zivnrpMt9grXcc00hfPDRekMzfRQWCib77IYIuxpMgs=;
        b=J81QQYZj2QNNSxdVyjvB9rp3p+0MyG0BpxKbuQXBf/frZkmmYuVBM+U5nf110Jd14n
         yp1pDD/nDdwwir4/WchZnfoIXVmfroVnpOWCWeD1bvw/dKSg6Z5NktmKFUB/aDY/XVMg
         9Z6KlKoc7zCfZRcKmv32hpmd9mg3wOHW7F1roRV3jITZjAxmCKOvfYNrCDZTbk1tcTRs
         zLXlcnfAk8lsGQl4N0FucFfl7TmbIFYeOqkNAGEtInhxrQbEC6TqDbyYrdHUM/zWF0p5
         V1MXSEHO0Y8C30szdjg0yZye6yex/A0PR2MTpLjndIFEwA2baTz80yDH5eGLdumk00+V
         05sQ==
X-Gm-Message-State: AOAM533Tj+aUFQ9BYHib2xC8k+XfZNn1JuEGVEFNEuAid/lV2zmgVIuc
        aUAQRPIoAYTh9oVXxr/kDoiByGsCMUa5Odym
X-Google-Smtp-Source: ABdhPJx3kMr3dAHbCwzox5wO3bNvndLpGpMhS4LLziiQDl3h/TOuku5SQ+mbcBu9VPcfvrvPZd6PLA==
X-Received: by 2002:a05:6402:2211:: with SMTP id cq17mr3524225edb.28.1619520907873;
        Tue, 27 Apr 2021 03:55:07 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id m9sm962625ejj.53.2021.04.27.03.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:55:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com, dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3] drm/drm_file.c: Define drm_send_event_helper() as 'static'
Date:   Tue, 27 Apr 2021 12:55:03 +0200
Message-Id: <20210427105503.10765-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_send_event_helper() has not prototype, it has internal linkage and
therefore it should be defined with storage class 'static'.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v2: Removed all the other lines in function comment.
Changes from v1: As suggested by Daniel Vetter, removed unnecessary
kernel-doc comments.

 drivers/gpu/drm/drm_file.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 7efbccffc2ea..d4f0bac6f8f8 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -774,19 +774,7 @@ void drm_event_cancel_free(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_event_cancel_free);
 
-/**
- * drm_send_event_helper - send DRM event to file descriptor
- * @dev: DRM device
- * @e: DRM event to deliver
- * @timestamp: timestamp to set for the fence event in kernel's CLOCK_MONOTONIC
- * time domain
- *
- * This helper function sends the event @e, initialized with
- * drm_event_reserve_init(), to its associated userspace DRM file.
- * The timestamp variant of dma_fence_signal is used when the caller
- * sends a valid timestamp.
- */
-void drm_send_event_helper(struct drm_device *dev,
+static void drm_send_event_helper(struct drm_device *dev,
 			   struct drm_pending_event *e, ktime_t timestamp)
 {
 	assert_spin_locked(&dev->event_lock);
-- 
2.31.1

