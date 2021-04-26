Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2ED36BA84
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 22:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241878AbhDZUCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 16:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241784AbhDZUBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 16:01:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50E7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 13:00:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h8so27078487edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AM0fccZ1AwBF12uWrMCL9HsNLQWbMQpNVOxxiq8KOiw=;
        b=DDipI45QBFz2H8oTFqxGl+X7pU2DH5fwDU12H6PwnXQVPlR/C2RZIUwuyYASOrxXVg
         G78QBdS4bBFvEkfgLHLPWJ55jc11FWQcEzHm8U7b2bzD/8mgn2zsJRgWYW/iuBr+QIed
         aF6kP/EWIqEFwaytN93meLcqZjU2GBh/1ll03sprHBd6VH0WZ8Qe4NWV7+/TI3RQJ7HG
         Va8h3/bLAfS3WZbJ0ACn9nGXrxtDZSheU6tZfDIeME6gALwDpzflWa3tCIg5CJuYlCi0
         t24nxzIMAKOoICy8PP073QB/4nMR85/mnRvHsjiOGtTc0dgaZBRSc1NgHkMvIEeLy7rl
         9X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AM0fccZ1AwBF12uWrMCL9HsNLQWbMQpNVOxxiq8KOiw=;
        b=iB5Bm4ZdTQXAXq3IN0eoD5Fm99TVGkwFbvyqIWW5KiUSUFBanhtlkReq7p2P6xR5iY
         DRCICMvxu2gm5FmUKQbMn9vlA9Bgu1Gur2Q3AQv7d0QH8m7H9WQdjFyUImC0nYpvW0ZF
         GGRGZAb6gzWcT8gOxrmXbU1CxqlxnnYgNwQbMEq7I33sOi9FVLw8wA+Wxro1kxuK7TFF
         B7sJqyn9lBSU2KL014rIIjWwh9aPpcjDDU37CzdKgCabPSdVl6BJ4t/jcaK4BMsWhWKP
         q7zrzpFBiB3f3SNBkLvDqG4MyPwaf8mrUM9rqa2jaiL/osMbxO0DE32vPcisk7IncZPd
         EsNQ==
X-Gm-Message-State: AOAM532rqNMB8Owf+WxXMD5Fcq6IeUyLjOQ3dhQKiisfYH0Xf95JbKg0
        fhJkAz8ESGcoHTL4IJyAO9g=
X-Google-Smtp-Source: ABdhPJwq9ywcI7jiZMwF35d5rctluJLoPNYS85cSjoBq6DhVzqMHeSFbWtK8+m4/N8QNKeU8jB9qoA==
X-Received: by 2002:a50:fd07:: with SMTP id i7mr418582eds.92.1619467255643;
        Mon, 26 Apr 2021 13:00:55 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id me3sm3386590ejb.49.2021.04.26.13.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 13:00:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] drm/drm_file.c: Define drm_send_event_helper() as 'static'
Date:   Mon, 26 Apr 2021 22:00:51 +0200
Message-Id: <20210426200051.11530-1-fmdefrancesco@gmail.com>
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

Changes from v1: As suggested by Daniel Vetter, removed unnecessary
kernel-doc comments.

 drivers/gpu/drm/drm_file.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 7efbccffc2ea..a32e0d4f3604 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -774,19 +774,15 @@ void drm_event_cancel_free(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_event_cancel_free);
 
-/**
+/*
  * drm_send_event_helper - send DRM event to file descriptor
- * @dev: DRM device
- * @e: DRM event to deliver
- * @timestamp: timestamp to set for the fence event in kernel's CLOCK_MONOTONIC
- * time domain
  *
- * This helper function sends the event @e, initialized with
+ * This helper function sends the event e, initialized with
  * drm_event_reserve_init(), to its associated userspace DRM file.
  * The timestamp variant of dma_fence_signal is used when the caller
  * sends a valid timestamp.
  */
-void drm_send_event_helper(struct drm_device *dev,
+static void drm_send_event_helper(struct drm_device *dev,
 			   struct drm_pending_event *e, ktime_t timestamp)
 {
 	assert_spin_locked(&dev->event_lock);
-- 
2.31.1

