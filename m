Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2A43733BF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 04:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhEECgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 22:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhEECgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 22:36:52 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0507DC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 19:35:55 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so433605otp.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 19:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GfhGC55J2OjEdw/7PTNJyCxRfWG9ZUMJ95NKKd86u0g=;
        b=rphV2EqsYRzSsIbvC2C0a7SvtrMsP4QtRZb/7Z2MX+lzpD4qhDJG8MmDjPeCKoj4TN
         AzA2BqUsublllOKQUSl8RglZbLKarS+uxlmS4unHRnpcakfsArSSn9D/A7DdRFx/Mi//
         LFve5mr3n+fnftrtTvt4d1yhzDE5NOTkQnLDoMPsac9kOfx+wdoC4YT8bEeS9OkNjfJ7
         lL4ErUyPoSsBlS6HQpWtLYG84SsY6uYY5KklVeu4bLQC9EOuLaCcHsPTWaT3IpbNMyMd
         JOdhELwuAmq5Wg1okCzMpE6mpOYDSZ+El7N4dThHd/azfN1eIjcBK4auZ7pGrmS7/M43
         DPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=GfhGC55J2OjEdw/7PTNJyCxRfWG9ZUMJ95NKKd86u0g=;
        b=mZ6pTYF/7hDOqELka0uAOKUVXEGf8p3xr8m1FV1nb/FHD6598GGzQnTK3x+LIpOKxS
         tknTLG9YVm7MOBCT5lk3basKkOgCoGMBMjNNIFXeqcPEEUS3ztuQMNQU56VpR9tDLiEc
         Ejz/nq6rEDa/Tq41HhnM6wKu4i8jWWGqJGeZZ/vVuY5JYDGLbLrBxPyJXyfRUIwpdNAr
         KPArvQsEzdcMRU5iraZb23xMFE8dFN5I8OT6lSiiOvaRO68Trh2ywkIdIkgOWgS7LCOU
         +EaWhOGdA+ChPyd3EmKCMQgTxqryHcW6nAUqMmGH9YOC9N5UfEOUgRapFDeA25fxvAZD
         bF0w==
X-Gm-Message-State: AOAM531+T9SUc7W+zOUKNMFXbsRpaIJOSPUVgzJ7NVnPP0U2wiRCD+DX
        xLedlJU6IrSb3y//usGPSkc=
X-Google-Smtp-Source: ABdhPJzy++fj+9aHMX278OES8bsDJ7/tIWDToemKnYwirNCewCj3Wf2m0qVz92GuaTcN+1PPe52otQ==
X-Received: by 2002:a05:6830:18d3:: with SMTP id v19mr20003182ote.339.1620182155257;
        Tue, 04 May 2021 19:35:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l7sm1108108oov.5.2021.05.04.19.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 19:35:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Airlie <airlied@linux.ie>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] drm: Declare drm_send_event_helper static
Date:   Tue,  4 May 2021 19:35:52 -0700
Message-Id: <20210505023552.2622938-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0-day reports:

drivers/gpu/drm/drm_file.c:789:6: error:
	no previous prototype for 'drm_send_event_helper'

Since drm_send_event_helper() is only used locally,
declare it static to fix the problem.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/gpu/drm/drm_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 7efbccffc2ea..def5df9f19e3 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -786,8 +786,8 @@ EXPORT_SYMBOL(drm_event_cancel_free);
  * The timestamp variant of dma_fence_signal is used when the caller
  * sends a valid timestamp.
  */
-void drm_send_event_helper(struct drm_device *dev,
-			   struct drm_pending_event *e, ktime_t timestamp)
+static void drm_send_event_helper(struct drm_device *dev,
+				  struct drm_pending_event *e, ktime_t timestamp)
 {
 	assert_spin_locked(&dev->event_lock);
 
-- 
2.25.1

