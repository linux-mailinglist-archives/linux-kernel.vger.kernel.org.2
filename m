Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD488391758
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhEZMbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:31:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56468 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbhEZMbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:31:39 -0400
Received: from mail-vs1-f69.google.com ([209.85.217.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llsfn-0007we-QV
        for linux-kernel@vger.kernel.org; Wed, 26 May 2021 12:30:07 +0000
Received: by mail-vs1-f69.google.com with SMTP id m15-20020a05610206cfb0290248aedd0e0dso169242vsg.16
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tyXiD7bZ+aLeJtSpo9+C62NB/ifafXwXEggYhSU02ts=;
        b=Bh1l1qkigpHoE8mG95SgDpErh2DkrePtTG5Dk1K/C8uojztIRmg2KXTEUaXkAklzLx
         duombJsOIhEFVLe+XGmmeFOsKkwItk1CMpdMESSPTEHq/Z6UqVki5Pj/AEdk5Qbn+e4T
         Qi29WGSCGS4xSqkAKup9f76y9avJ4D3ltvt9FhGKOk6vE5qUNR0rqn49Uxf162IxPtbL
         5KMgdw/r9LqlnXMhrrGd8Wxk3KF223rGhZRMcq0pvvmPH4CtiJww5Xkxt4by962oh13t
         RHaVc5hAlITWlz8u0m3vMgOoJ0+cvKu9ZwJxRwyOkg7TFmDOicx92lmdnbLcmPRyJZob
         MF4Q==
X-Gm-Message-State: AOAM530+56qVrm6QpejfDGYuXT6ywnSEd3BGuptjRtakced/gvJIvko5
        0QCf6ShPmtJDDiqvSreytpfLNBanW3TBatTI3txdbsn8u1GXKjU1i7cJu/S8Ep5JpeRGPhULjzI
        u23RbMyQLkkUgRl93y6gQ+gRjWmwPv8MS8CtUv5xT8w==
X-Received: by 2002:a05:6102:dc9:: with SMTP id e9mr27735413vst.23.1622032206381;
        Wed, 26 May 2021 05:30:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5a0h3XvrPTErg+z7PTz43kO0UM0jYM8LbfZF8Q6vQxRY1N4vWH2M2NXdkOSWaVH00NMgMlA==
X-Received: by 2002:a05:6102:dc9:: with SMTP id e9mr27735393vst.23.1622032206152;
        Wed, 26 May 2021 05:30:06 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id z8sm435074ual.1.2021.05.26.05.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 05:30:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [RESEND PATCH] drm/panel: ld9040: reference spi_device_id table
Date:   Wed, 26 May 2021 08:30:02 -0400
Message-Id: <20210526123002.12913-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference the spi_device_id table to silence W=1 warning:

  drivers/gpu/drm/panel/panel-samsung-ld9040.c:377:35:
    warning: ‘ld9040_ids’ defined but not used [-Wunused-const-variable=]

This also would be needed for matching the driver if booted without
CONFIG_OF (although it's not necessarily real case).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/gpu/drm/panel/panel-samsung-ld9040.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-samsung-ld9040.c b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
index f484147fc3a6..c4b388850a13 100644
--- a/drivers/gpu/drm/panel/panel-samsung-ld9040.c
+++ b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
@@ -383,6 +383,7 @@ MODULE_DEVICE_TABLE(spi, ld9040_ids);
 static struct spi_driver ld9040_driver = {
 	.probe = ld9040_probe,
 	.remove = ld9040_remove,
+	.id_table = ld9040_ids,
 	.driver = {
 		.name = "panel-samsung-ld9040",
 		.of_match_table = ld9040_of_match,
-- 
2.27.0

