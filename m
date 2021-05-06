Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1598D3751B4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhEFJma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbhEFJm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:42:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64E3C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 02:41:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l13so4860302wru.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Fx6koaa90dYpE3ZRxt64nTsgkrkT9Jbk1TcCB5fNN0=;
        b=wC3Ic9YCYaHpZrOqunPpyYOqVY53CB3utNaWddVKzbePn1psarS5wOSL9rDqiGA5PZ
         tLwVV2cgdSVbz1Q596AT0odEQdLgAGLBiFiLDApR7AJtpmkFBWzBCNsPpnxBNdvBGSPf
         evOvz+zv1cD+YqHRYbJc31pvemA99u2nCNualt2jG3fjN/fZtnAim/DbSoiRJMyPXYoO
         9afg+s5W5miOwxKAyXiQ5tS3HyRprBGvW+nBAAnMUIcQ4ZldLIHKK0OLMHHNc0zji+WA
         cYOSa8pVOjGrAeqE0Dzkc1Y5dRefprQyt9dhvCnMSkwSPUPUY/HjWdAUYDnP+pT3hP+p
         vsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Fx6koaa90dYpE3ZRxt64nTsgkrkT9Jbk1TcCB5fNN0=;
        b=euHn2W8afbnOq4cJ/Xq+8VfP8jw7vPjieBdGIKKsXDHDHY1nEJzMB3o+x3tQZIcyWU
         OZeaNOHlMuBsV/p3b+3KSlh8kOS3AebReYddPqmFkUcQTo0pEe2AeQHPJzYRGDhtc1P2
         3AKNPiTzYNlmFcZyJweuLxAOnQyyfGEMrRaxaS/bG1Pc7kiDTlGM7gUCzNJRd1AceMoJ
         7DguVkJ98c314cFkBouycCZIbes9UlP46c45bYGvau3iN5hwl9oIfwnTxeYWi0b8VloO
         +dzaO04KzttF0m096KkbCa9Mt0giRrfwUPpDloi2Tsq/4z12vzfIviLZ0gJiQ/0bsYeH
         nKSA==
X-Gm-Message-State: AOAM5311ZcvYdqBMiApvs7A2psDlKuWKLMrOZ04R+xRrzagiYSFFAQUw
        DzrKT8bYTWEl4gk3SI19pdxyfg==
X-Google-Smtp-Source: ABdhPJwuueqdh6i+rN0lH8eSnaptLU3QU7FT191ZcG1FDtrzmHFTBRmmGWCFldj3ivZo5PFhl3nMzw==
X-Received: by 2002:a05:6000:1cc:: with SMTP id t12mr4007908wrx.156.1620294088524;
        Thu, 06 May 2021 02:41:28 -0700 (PDT)
Received: from groot.home ([2a01:cb19:826e:8e00:2492:c5b6:6c3f:6de4])
        by smtp.gmail.com with ESMTPSA id y14sm3360421wrs.64.2021.05.06.02.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 02:41:28 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 3/3] mfd: mt6397: add PMIC keys for MT6358
Date:   Thu,  6 May 2021 11:41:15 +0200
Message-Id: <20210506094116.638527-4-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210506094116.638527-1-mkorpershoek@baylibre.com>
References: <20210506094116.638527-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings and interrupts for pmic keys
which serves as child device of MFD.

MT6358 has two interrupts per key: one for press, another one for
release (_R)

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/mfd/mt6397-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 5818e0c328c9..f882c76b4f88 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -45,6 +45,13 @@ static const struct resource mt6397_rtc_resources[] = {
 	DEFINE_RES_IRQ(MT6397_IRQ_RTC),
 };
 
+static const struct resource mt6358_keys_resources[] = {
+	DEFINE_RES_IRQ_NAMED(MT6358_IRQ_PWRKEY, "powerkey"),
+	DEFINE_RES_IRQ_NAMED(MT6358_IRQ_HOMEKEY, "homekey"),
+	DEFINE_RES_IRQ_NAMED(MT6358_IRQ_PWRKEY_R, "powerkey_r"),
+	DEFINE_RES_IRQ_NAMED(MT6358_IRQ_HOMEKEY_R, "homekey_r"),
+};
+
 static const struct resource mt6323_keys_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_PWRKEY, "powerkey"),
 	DEFINE_RES_IRQ_NAMED(MT6323_IRQ_STATUS_FCHRKEY, "homekey"),
@@ -96,6 +103,11 @@ static const struct mfd_cell mt6358_devs[] = {
 	}, {
 		.name = "mt6358-sound",
 		.of_compatible = "mediatek,mt6358-sound"
+	}, {
+		.name = "mt6358-keys",
+		.num_resources = ARRAY_SIZE(mt6358_keys_resources),
+		.resources = mt6358_keys_resources,
+		.of_compatible = "mediatek,mt6358-keys"
 	},
 };
 
-- 
2.27.0

