Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF993F0391
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhHRML6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:11:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237757AbhHRMKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629288597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5GDrPFRa2eKnOg4exCIwK3YrwGtnkSUqkhmYgDmqIcE=;
        b=dcjkKgRV28k3078bReWmDAQpMpFniVl7mB7O052YSpqbSa5TomgDO1+V6doJmHWHd0wR6M
        Jz92crAnOCk9Bq9/aRNPj2MbsHV6/LpQoJqkErZl0Vtyz3H0cVXOCgaXgf68PkFlmrpoTn
        d91yxLclNBj1m3WhVy6smKxFdK3VdTw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-Zx3MrSz-PBWyK2wD9lYr3g-1; Wed, 18 Aug 2021 08:09:56 -0400
X-MC-Unique: Zx3MrSz-PBWyK2wD9lYr3g-1
Received: by mail-wr1-f70.google.com with SMTP id h24-20020adfa4d8000000b00156d9931072so517828wrb.15
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 05:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5GDrPFRa2eKnOg4exCIwK3YrwGtnkSUqkhmYgDmqIcE=;
        b=cUArlQxBB8ko3CPv1POzgULlP4WOHc5C5/UtZNC0A535J/VA6NW4YnXRK6ryKtwnNl
         NHoZ+G330iFkOIg7oW1n0QtCdod1I83Bt8YPq5he5I/DBR7LW/is4QIBfkoh/U1+BH8e
         csXAn9rZMI7iTP1+YrISuV/K7TozRp9DCRbQ4lyYJYRgeFGKDdeGy9cv53PJfOqKGYJ7
         5S+A5CV0m16uLHaKIqw8nCzq+Aws8FJTK2s9yht4135I12ZR2MwMbk5qR6jCjzc48wE6
         aAVOo59nFIJXTbolwJsU/dz4UnGrkCmWSL4/FjsRS2mT6L1FhtE9izVKGjHkhNDTOUUP
         WolQ==
X-Gm-Message-State: AOAM531yORCvFh7BAo3ugTRLiU5ScUP7n/qQOgn7Tzo3jRB5/2SfL4fU
        85mGJYwUuBmk1levQ7GhBTBbBN9VIt5kxutoNoM74BM0pi6+Zi8TafKy2N7IAzQhHb3wtNC5L2R
        L1W4ZJ6jhNKdm4tTFXzU/c/Uqzd84aCGJb/wANYqGti2LZu4Vv+TSW9Wc/cJRme86qSLQlvhqJ2
        o=
X-Received: by 2002:a5d:4688:: with SMTP id u8mr10313341wrq.148.1629288593123;
        Wed, 18 Aug 2021 05:09:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTZMSPiUP9WNF76FTt/bZHXX75asXwyrBkzDdMBM/M++3nLeesGub4u+XGerxdc379+cM+jw==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr10313297wrq.148.1629288592804;
        Wed, 18 Aug 2021 05:09:52 -0700 (PDT)
Received: from minerva.redhat.com ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z15sm5495999wrp.30.2021.08.18.05.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 05:09:52 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: Remove unused code to load the non-existing fbcon.ko
Date:   Wed, 18 Aug 2021 14:09:48 +0200
Message-Id: <20210818120948.451896-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6104c37094e7 ("fbcon: Make fbcon a built-time depency for fbdev")
changed the FRAMEBUFFER_CONSOLE Kconfig symbol from tristate to bool.

But the drm_kms_helper_init() function still attempts to load the fbcon
module, even when this is always built-in since the mentioned change.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/drm_kms_helper_common.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_kms_helper_common.c b/drivers/gpu/drm/drm_kms_helper_common.c
index f933da1656eb..47e92400548d 100644
--- a/drivers/gpu/drm/drm_kms_helper_common.c
+++ b/drivers/gpu/drm/drm_kms_helper_common.c
@@ -64,17 +64,6 @@ MODULE_PARM_DESC(edid_firmware,
 
 static int __init drm_kms_helper_init(void)
 {
-	/*
-	 * The Kconfig DRM_KMS_HELPER selects FRAMEBUFFER_CONSOLE (if !EXPERT)
-	 * but the module doesn't depend on any fb console symbols.  At least
-	 * attempt to load fbcon to avoid leaving the system without a usable
-	 * console.
-	 */
-	if (IS_ENABLED(CONFIG_DRM_FBDEV_EMULATION) &&
-	    IS_MODULE(CONFIG_FRAMEBUFFER_CONSOLE) &&
-	    !IS_ENABLED(CONFIG_EXPERT))
-		request_module_nowait("fbcon");
-
 	return drm_dp_aux_dev_init();
 }
 
-- 
2.31.1

