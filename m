Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3D4377F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhEJJOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJJOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:14:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F781C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 02:13:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h4so15765156wrt.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 02:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q62kvUojd/CS4f0GUoH40Kz29XHeqv+w8LQsa6wuePg=;
        b=FgUplIORX/8wBTHf3e0s6ooIAqBFDLkFKqK7zHHbKgDqnFZNfnyCpj9+mOocPrKH8j
         fWbfWxSwm63SBDtcooZRjM7wvNLOYpgH7bVxZWlqPJy0hwWBz76MpNOl01BJbHRblo3+
         i1epJowT0572TcbGz0jqtasTT25bMG9LGPYZIEHPDy5xX98+NZWKCxZcfnVKAVM9pomW
         G13zllZyf5Ash0WK2eAnPsL7k/ZxTMlHIk1DZMTSrCuzjxg5iuaNRGWphY58MDMW5Hrl
         Buqu6U7Lam79dDOpbpI+Zxzr2QAOC/GIH0Q8gPodk7+PaoqIqG6SAfCqfF2HdOw2s0Jt
         P/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q62kvUojd/CS4f0GUoH40Kz29XHeqv+w8LQsa6wuePg=;
        b=HPw1CgsL9iQ8H8PKOyplbe7qlyiJ/eTUsRgDmYics4sm0WCOEjh6RJbJDGRJBXQz38
         uxZ79bm98ruJM67vUMjoGvI5drRfwKEpB3ULtVCm02k5QPf4XSk38H3erRyxiwEN44IE
         kWOJblcuIaQ4ShxwhAgegRBwcas6yb3k1tKSWyRFmQF5WrBc+lYhqPkKHBghzAp+uG+V
         I5NNyEAjkYEhBM49g3v5NuY6haACEAcKGZYHSH5H51fhubzYwY14NP4FkBUy/TgIviPY
         jqBB6U5Z9wSf1P7/fhx1x3nGdQr38ca6kXTKyS2H6amrLW6wb/xJaSFm9kWpudcLEsew
         ughA==
X-Gm-Message-State: AOAM531BBbHzqYZaEc06jhlQ44384nVSFkUDYGQj4TryVXL+FOcWl8QR
        8YTOYGpfoPTeynY0QAgXMA9eWq0xGrevoJ7w
X-Google-Smtp-Source: ABdhPJxjdy4AmriG/0qKHp1B+hfL6f6BrsaZ/Vutx9OAGQggwQ6O+811DoJ9hQueZVnBft3iV2I3Rw==
X-Received: by 2002:adf:f152:: with SMTP id y18mr29434949wro.77.1620637990242;
        Mon, 10 May 2021 02:13:10 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id s5sm19040575wmh.37.2021.05.10.02.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 02:13:09 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] mfd: wcd934x: add macro for adding new interrupts
Date:   Mon, 10 May 2021 10:12:38 +0100
Message-Id: <20210510091239.2442-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210510091239.2442-1-srinivas.kandagatla@linaro.org>
References: <20210510091239.2442-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only two interrupts supported is added in wcd934x interrupt controller,
however if we are adding more interrupts the file will become too much unreadable.

So add a macro to make adding new interrupts easy and also convert existing
slim and soundwire interrupts to use it.
This is in preparation to enable Multi Button Headset Control support on this
codec.

WCD934x supports Multi Button Headset control which enable headset detection
along with headset button detection.

This patch adds interrupts required for MBHC functionality.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mfd/wcd934x.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index c274d733b656..53d46fadcf5a 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -17,6 +17,21 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slimbus.h>
 
+#define WCD934X_REGMAP_IRQ_REG(_irq, _off, _mask)		\
+	[_irq] = {						\
+		.reg_offset = (_off),				\
+		.mask = (_mask),				\
+		.type = {					\
+			.type_reg_offset = (_off),		\
+			.types_supported = IRQ_TYPE_EDGE_BOTH,	\
+			.type_reg_mask  = (_mask),		\
+			.type_level_low_val = (_mask),		\
+			.type_level_high_val = (_mask),		\
+			.type_falling_val = 0,			\
+			.type_rising_val = 0,			\
+		},						\
+	}
+
 static const struct mfd_cell wcd934x_devices[] = {
 	{
 		.name = "wcd934x-codec",
@@ -30,32 +45,8 @@ static const struct mfd_cell wcd934x_devices[] = {
 };
 
 static const struct regmap_irq wcd934x_irqs[] = {
-	[WCD934X_IRQ_SLIMBUS] = {
-		.reg_offset = 0,
-		.mask = BIT(0),
-		.type = {
-			.type_reg_offset = 0,
-			.types_supported = IRQ_TYPE_EDGE_BOTH,
-			.type_reg_mask  = BIT(0),
-			.type_level_low_val = BIT(0),
-			.type_level_high_val = BIT(0),
-			.type_falling_val = 0,
-			.type_rising_val = 0,
-		},
-	},
-	[WCD934X_IRQ_SOUNDWIRE] = {
-		.reg_offset = 2,
-		.mask = BIT(4),
-		.type = {
-			.type_reg_offset = 2,
-			.types_supported = IRQ_TYPE_EDGE_BOTH,
-			.type_reg_mask  = BIT(4),
-			.type_level_low_val = BIT(4),
-			.type_level_high_val = BIT(4),
-			.type_falling_val = 0,
-			.type_rising_val = 0,
-		},
-	},
+	WCD934X_REGMAP_IRQ_REG(WCD934X_IRQ_SLIMBUS, 0, BIT(0)),
+	WCD934X_REGMAP_IRQ_REG(WCD934X_IRQ_SOUNDWIRE, 2, BIT(4)),
 };
 
 static const struct regmap_irq_chip wcd934x_regmap_irq_chip = {
-- 
2.21.0

