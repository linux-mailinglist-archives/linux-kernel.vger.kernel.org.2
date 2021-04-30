Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA8A36F714
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhD3I2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhD3I2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:28:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF92C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:27:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t18so12008262wry.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x12D1fSgMXo84/StrNDXFY95BOlA8w3dEtySPm5wCgQ=;
        b=q5RkY2TEzEE6oWZZbW+87d2glkkz6bArkK6G7aeyOTL/H6i5S97xaGLHvQ7feTUwKC
         1yaM5gV/avDemn8LUsrGG4ttN8Njingl5hDQcXiFweWa77q5BSlgh8DTBXxWlaQQXQ4k
         r1lSJznmcSEPRoyRX6erX7SDkpU6d2SLI6M8bWaGqGtY1ruPepci6ZZIwFNRYe5YKJa3
         yjAHDDUPwDNtlN2+gWew99O3ATqgPaq1drQVwYnfKrBxevD6IPejzjmuF6NGbn7gSLsS
         uOmK0IYiYEIpsf4jXL+Yqb+Qsa02G5V/KRmeYGuii/TEAavD6FHr3X7gsIieEtzPeQj7
         wX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x12D1fSgMXo84/StrNDXFY95BOlA8w3dEtySPm5wCgQ=;
        b=hQbOyuctWD3tLLc5UTS3P/gt3Q2fjtM1x34QmKB71HojNBSqx2FaQRptQ3ovXxMRqc
         ulxRgfIjS7v+GFJC2tK5MFJIgCR11crVnnp2Jf2Tq5MET9q9uiIWSquyCj4UphijcBK5
         mxLJAK4tb7AJByC4QgF6YkSWu0BgtRHiX0OjPEgHh45rOe9enjOYEjk0TY9wnleIlewY
         WHsorpC2IMoHtfoypajXKUMZBM9UC+FgKtqJXuOmEbfXP3zwLmzeJsRysvCGwDy1k8tp
         voucv/38ivdxT/ktQiUhIcxspvH0TN5sLuLePKa7geS/4mYRlxSFH37SQc7eGjC3iW0i
         soWQ==
X-Gm-Message-State: AOAM533A48QvxNOQRqPDtDmQT/ul6FiQyEhrPbYrAt/DcaQeAuNOCXCS
        M7yTiYwZuRXbaeQctCoxjw/ADD9IJR46n2Qk
X-Google-Smtp-Source: ABdhPJxGoyaka1SwUgXjXPuWPXVdSHHYtgAfq3tVpjG7MANHxCuZPbgUWnsHDmVM463gHiGYmCPtyg==
X-Received: by 2002:adf:efca:: with SMTP id i10mr1630979wrp.284.1619771268768;
        Fri, 30 Apr 2021 01:27:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:4a89:8c32:4adc:fc67])
        by smtp.gmail.com with ESMTPSA id e12sm1336677wrt.51.2021.04.30.01.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 01:27:47 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] drm/meson: fix shutdown crash when component not probed
Date:   Fri, 30 Apr 2021 10:27:44 +0200
Message-Id: <20210430082744.3638743-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When main component is not probed, by example when the dw-hdmi module is
not loaded yet or in probe defer, the following crash appears on shutdown:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000038
...
pc : meson_drv_shutdown+0x24/0x50
lr : platform_drv_shutdown+0x20/0x30
...
Call trace:
meson_drv_shutdown+0x24/0x50
platform_drv_shutdown+0x20/0x30
device_shutdown+0x158/0x360
kernel_restart_prepare+0x38/0x48
kernel_restart+0x18/0x68
__do_sys_reboot+0x224/0x250
__arm64_sys_reboot+0x24/0x30
...

Simply check if the priv struct has been allocated before using it.

Fixes: fa0c16caf3d7 ("drm: meson_drv add shutdown function")
Reported-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 453d8b4c5763..07fcd12dca16 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -485,11 +485,12 @@ static int meson_probe_remote(struct platform_device *pdev,
 static void meson_drv_shutdown(struct platform_device *pdev)
 {
 	struct meson_drm *priv = dev_get_drvdata(&pdev->dev);
-	struct drm_device *drm = priv->drm;
 
-	DRM_DEBUG_DRIVER("\n");
-	drm_kms_helper_poll_fini(drm);
-	drm_atomic_helper_shutdown(drm);
+	if (!priv)
+		return;
+
+	drm_kms_helper_poll_fini(priv->drm);
+	drm_atomic_helper_shutdown(priv->drm);
 }
 
 static int meson_drv_probe(struct platform_device *pdev)
-- 
2.25.1

