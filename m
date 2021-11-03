Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC49444034
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 11:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhKCK53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 06:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhKCK52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 06:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635936891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uU8Rx0IcPDhdqB9h0s7L6IkOHgVAre6VkZxiUCvneFI=;
        b=SBk3HSGpYioy5ku6asoNePZG5ri452RFdL+aTNdbL1viq5wS8+NPYmjoyQC4IWdSWbO2oV
        lIfOUv7RXMyBlAvmuokGxgPJRkC5K/tgeY0B6OvhVJjVwR14k2nF2apJf+SHorpnrEYnNh
        G60zIJRnAV8YcoSGg7YFBwtDeS6huGg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-5k6ejqYiMfiKYTb7lCd3LQ-1; Wed, 03 Nov 2021 06:54:47 -0400
X-MC-Unique: 5k6ejqYiMfiKYTb7lCd3LQ-1
Received: by mail-wm1-f70.google.com with SMTP id o22-20020a1c7516000000b0030d6f9c7f5fso884795wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 03:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uU8Rx0IcPDhdqB9h0s7L6IkOHgVAre6VkZxiUCvneFI=;
        b=KsGFiThL7BYMxm2K8W6gyscYwxPrUXjZejx6qtHimO4/Q+0EYpAaKtdUGfMrXXyQYE
         VVFwc9DKczMaazZI1qRJJBrM2q+iT++xTJBLGhThtM/YaVc7G/cOqqpN0iiDKi25QZVn
         vcqBtmY0kDHu/CqfRdeNDeQcgvEucFe4TKlLx16IWr/rN91kPDz/fn8tBSt3/YvG2R2+
         77gRz20AMg0V52l3+MLtNBZbAthFGUbo5laQn93AtBHMEei2sGf9HschVmIeO1sSxtp3
         cHRvY4OIRr2/ES/xrvcsTM8kgKl5pxzmeLtTcwjkJSTI3/cBcQ6Bd9PE7+ljQoMB4Ddm
         rDVQ==
X-Gm-Message-State: AOAM531wZt6d5rDPT48kodX2s8+B+PUGP6yqLUf1larWGxnt9TB+3/I2
        e+39tO917aHkLxl8SuXv3ooEJZ4CuFWUFcWrzrJz/oVD43qnQTu0zqfkX00Mtel1/E5bjuZHz1k
        dcu7GKP9nHeD5DNKXoNVK9v6cD1RT468Zs0DxRl+PiuF+DB8d5vGhuB12o5b/r0wbt59+aiZ9ZO
        w=
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr17398583wrr.365.1635936885037;
        Wed, 03 Nov 2021 03:54:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys6dTdl8aBoWRaKw6r8OP2yQQdtTr8T67uoaYqJm1Od9FoXdSHkGkXwC87WaP8SWNX9QpxFw==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr17398542wrr.365.1635936884719;
        Wed, 03 Nov 2021 03:54:44 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z15sm1641444wrr.65.2021.11.03.03.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 03:54:44 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 4/5] drm: Add a drm_drv_enabled() helper function
Date:   Wed,  3 Nov 2021 11:54:36 +0100
Message-Id: <20211103105436.1024242-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM drivers can use this to determine whether they can be enabled or not.

For now it's just a wrapper around drm_modeset_disabled() but having the
indirection level will allow to add other conditions besides "nomodeset".

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/drm_drv.c | 21 +++++++++++++++++++++
 include/drm/drm_drv.h     |  1 +
 2 files changed, 22 insertions(+)

diff --git drivers/gpu/drm/drm_drv.c drivers/gpu/drm/drm_drv.c
index 8214a0b1ab7f..70ef08941e06 100644
--- drivers/gpu/drm/drm_drv.c
+++ drivers/gpu/drm/drm_drv.c
@@ -975,6 +975,27 @@ int drm_dev_set_unique(struct drm_device *dev, const char *name)
 }
 EXPORT_SYMBOL(drm_dev_set_unique);
 
+/**
+ * drm_drv_enabled - Checks if a DRM driver can be enabled
+ * @driver: DRM driver to check
+ *
+ * Checks whether a DRM driver can be enabled or not. This may be the case
+ * if the "nomodeset" kernel command line parameter is used.
+ *
+ * Returns:
+ * True if the DRM driver is enabled and false otherwise.
+ */
+bool drm_drv_enabled(const struct drm_driver *driver)
+{
+	if (drm_modeset_disabled()) {
+		DRM_INFO("%s driver is disabled\n", driver->name);
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(drm_drv_enabled);
+
 /*
  * DRM Core
  * The DRM core module initializes all global DRM objects and makes them
diff --git include/drm/drm_drv.h include/drm/drm_drv.h
index 0cd95953cdf5..48f2b6eec012 100644
--- include/drm/drm_drv.h
+++ include/drm/drm_drv.h
@@ -598,5 +598,6 @@ static inline bool drm_drv_uses_atomic_modeset(struct drm_device *dev)
 
 int drm_dev_set_unique(struct drm_device *dev, const char *name);
 
+bool drm_drv_enabled(const struct drm_driver *driver);
 
 #endif
-- 
2.33.1

