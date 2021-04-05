Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EFA3546AC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 20:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbhDESPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 14:15:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33060 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbhDESPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 14:15:12 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lTTkf-0004nr-Fo
        for linux-kernel@vger.kernel.org; Mon, 05 Apr 2021 18:15:05 +0000
Received: by mail-wr1-f71.google.com with SMTP id s13so338860wrt.21
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 11:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7CUk/iAsFieG2zHKAIGqtut7zOrbBM0NXHpnT3k1Fp8=;
        b=YHomVEscX1sTvSt1kU4xAE2BSIQSAcMJxetqocCQlh1mnIbVo9Be2/JxbH30oOVWkx
         yLcCD2ftJipOAzcEseFi3aoLMpWyswwel7O5T24mQgyvD1y6ErO62b7ckKuWtfLh3i5p
         4+arY7FWIru7ZiYOOGj2aRLOsMMCHKfV7aIsbYN6ABNM1OhRYpVPWluWA7lFg30tz5PG
         ake3YkLf8IwA3PVeMi8AjgFBw0tH30QW1LCG1/vwGOueQNJt3QwCZlv0tQQhidPYZ06P
         f/fpeZaJAaFPQCw4xw4npJBkfrqH+aUzjPl/A0LIj3TwoiMya5czYe+N23BHsisEDj57
         WKYg==
X-Gm-Message-State: AOAM530KI6uc6apnadAjWX/H5mZ+1Q5qfXFxT60MLDh5aXwq19Zik46I
        fKOx/dVqAYrgUu95C4a/3kDFW1c0pJ1PHfStIWNh5bEeaG7KI9haeTU29yK/X4MRYhhwD1WhYj8
        GE7nUCBHGM4PmdmdbJdJ/8RTFpzksSs5Wn5K5XV6zug==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr29937620wrv.329.1617646505271;
        Mon, 05 Apr 2021 11:15:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcySNNIL5pxzASqJNBtYeVlH+A1mUzX3rBltnRY1vbBomaDpZYGOwBWGOL7Dx+fWCYM1AvYw==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr29937613wrv.329.1617646505165;
        Mon, 05 Apr 2021 11:15:05 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id 64sm336695wmz.7.2021.04.05.11.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 11:15:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] drm/panel: ld9040: reference spi_device_id table
Date:   Mon,  5 Apr 2021 20:15:02 +0200
Message-Id: <20210405181502.52291-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
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
2.25.1

