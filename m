Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F8437C982
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 18:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhELQTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 12:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbhELPgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:36:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8948BC08C5FD
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:16:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l14so24008673wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MfFeXs1ZnrbznR36F+Azd1TerVAYLHFbsoRX86sMJbQ=;
        b=JmGEKDtyLCxs8ih8SFYJQC1LLuoqLBv9WC0ywiw/HDuirOvpxjFwjKYt7c0GqBTZbU
         iyE/4ZGYd8U/Yrgo0HBMFgseBw4fOH2TWSkvIFmLP651zntea/3oHDKEDPTyi/XjbG22
         TiH9bZloPBt9frGjpE+MafNYSpeRLttE+nvlrcSq9If0NUnfcYMEWCrrV7I3EAM1vCzC
         wEcbCk1/xI9ziBJc89O78fk590MtnV4MVkhqelAQSwKAVEiNxdzkKmTCNIxqFh/9I7+b
         C+nc0tcqniTfHdRgUt1dOFg2nnyQd0dr149uv+INh/WBdPkWgzlQX5bhdXn5wQJ7HnQc
         WMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MfFeXs1ZnrbznR36F+Azd1TerVAYLHFbsoRX86sMJbQ=;
        b=lck40/H26IVU2XGoRnBpFWDh2sUTxNGazmCHb9lf/k0LrMaGL6OlLLqRFPy/TKV/dh
         INPhsD1er5IvuFnUiQ2uGGeeEZTM903Ukc8pnNGVtLe+EiU/dMlx3IopPS4H8OGQxn5K
         nNf89nHy2dxqPPYUepCzxQH5/JnYqFPGw83UDIEL3qkCHRVSBxQtf3yIQClw/HgS388P
         0IjNquToQ1sG6YEuuyAihIm87SYiPgWzkvEdG4t86uJwDe1x50Iww7VC5f+LWWSOvvq+
         H2o+d/W5syKkkdx04jdiyTCsZnFGtkhgP4ofC2VmhK1+twsPdXRWcXmB1zKn2mcBnuGb
         MhUg==
X-Gm-Message-State: AOAM5335Ie6weBq1doPOKwru65C55FArYoUGXDAzrRpN5x+nWfSrWNDK
        AMBsZvAwkZY0VvvvzuGkDf51AQ==
X-Google-Smtp-Source: ABdhPJy3ftP3rXXtEFvXj3wuD7w2m7S7OnMv+h0sS0P0toXNlX2FpVMw8NkgEyR8e0ycTyT3ed1U9g==
X-Received: by 2002:adf:fa46:: with SMTP id y6mr2986989wrr.83.1620832588280;
        Wed, 12 May 2021 08:16:28 -0700 (PDT)
Received: from mkorpershoek-XPS-13-9370.home (lfbn-tou-1-1465-169.w90-89.abo.wanadoo.fr. [90.89.34.169])
        by smtp.gmail.com with ESMTPSA id c15sm30095011wrr.3.2021.05.12.08.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:16:27 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 2/3] mfd: mt6397: keys: use named IRQs instead of index
Date:   Wed, 12 May 2021 17:16:13 +0200
Message-Id: <20210512151614.36996-3-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210512151614.36996-1-mkorpershoek@baylibre.com>
References: <20210512151614.36996-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some pmics of the mt6397 family (such as MT6358), have two IRQs per
physical key: one for press event, another for release event.

The mtk-pmic-keys driver assumes that each key only has one
IRQ. The key index and the RES_IRQ resource index have a 1/1 mapping.

This won't work for MT6358, as we have multiple resources (2) for one key.

To prepare mtk-pmic-keys to support MT6358, retrieve IRQs by name
instead of by index.

Note: The keys_resources are not part of the device-tree bindings so
this won't break any DT schemas.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/mfd/mt6397-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 7518d74c3b4c..8738b5524783 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -46,13 +46,13 @@ static const struct resource mt6397_rtc_resources[] = {
 };
 
 static const struct resource mt6323_keys_resources[] = {
-	DEFINE_RES_IRQ(MT6323_IRQ_STATUS_PWRKEY),
-	DEFINE_RES_IRQ(MT6323_IRQ_STATUS_FCHRKEY),
+	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_PWRKEY, "powerkey"),
+	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_FCHRKEY, "homekey"),
 };
 
 static const struct resource mt6397_keys_resources[] = {
-	DEFINE_RES_IRQ(MT6397_IRQ_PWRKEY),
-	DEFINE_RES_IRQ(MT6397_IRQ_HOMEKEY),
+	DEFINE_RES_IRQ_NAMED(MT6397_IRQ_PWRKEY, "powerkey"),
+	DEFINE_RES_IRQ_NAMED(MT6397_IRQ_HOMEKEY, "homekey"),
 };
 
 static const struct resource mt6323_pwrc_resources[] = {
-- 
2.27.0

