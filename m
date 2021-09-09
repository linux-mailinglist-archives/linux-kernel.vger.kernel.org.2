Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DD9405899
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345871AbhIIOGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349786AbhIIOFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:05:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522EDC0355D2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 05:04:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u16so2204309wrn.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DG4WjrG2U9ZoFQp1xyULSzVJPSO5ucdyPL6p6IGWPRU=;
        b=Qxkkl2KhpwbDAZx0Gnsz6RpUvfEkmEfXmkp4w40xr7h+Vfh89qo3DZO54vTDwTHqFm
         yeWUdkf1PhGZd7BupJm5KgR1MvJl8deL9OEQe9ayjypXZ8vZZd47GVmOgelNEL48MZw3
         dZe54ZrZTUIa/K0OuekSNufMrZLpMj4hlZ9v/Fjs6+wIepQGbDuZKk+KIuLTShMiQl34
         BB3VDmnwFCts3CQ3vo1vOS+Ct5cVCHDrrGPFAe2VtrKcOfMgN39cYdCEBLUIjCBcRej3
         zbMQx+LrsoJJQpzb4fxeIm2xmuK8ltl2poFQlTQuB998U5XhZMaegVrGs349pciq0tgb
         n2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DG4WjrG2U9ZoFQp1xyULSzVJPSO5ucdyPL6p6IGWPRU=;
        b=sBk1cQLRh/1V2VthH2tfq3scchTZsKLpI9u01nYvmXzCXrYyFU3dkb57bYomwZ2NEz
         QuGpxUCAnCQOWiXMmPfvVDY5JK/35o9zEjRYmWQ2li7B6Y19QMSQ5oLKeHxWnDOGx0L6
         +WbYD6v4jTRPSbrsefact7NTEuqeYuqeZMYyRqcyCqJaqKJ2FtgKl+yoJeQTnSoRIqQw
         CN6yWgGeATOm7CJBj1Bn79uMVMg/NyIStyor8y5n8+n7aoYa5Gn/unT6UUViTUoje/Rz
         q0MQe2MxGyE7F6Thp9FDJ2cudux51B4uiy3HYoC0TUnogqjI9/MFhxwYBeP9DbVlCuw6
         U/gw==
X-Gm-Message-State: AOAM531RM6uVIdgXoA6a9z/eSQtq3Ipx0Sj7crTyEedRJ51WQH4OpcaL
        tvH9nKGlBVsZv0oQEtW//JAFVw==
X-Google-Smtp-Source: ABdhPJxq/6DPg25zdkas2ldaGJ/J1WTQ2g1Uy5Rguwp1JyKMhBCCkqRVDSX7l7HV/kt6rlEkJ4FySQ==
X-Received: by 2002:adf:8b43:: with SMTP id v3mr3257793wra.248.1631189069909;
        Thu, 09 Sep 2021 05:04:29 -0700 (PDT)
Received: from localhost.localdomain ([95.148.6.201])
        by smtp.gmail.com with ESMTPSA id n66sm1437498wmn.2.2021.09.09.05.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:04:29 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Elliot Berman <eberman@codeaurora.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 3/3] power: reset: Enable tristate on restart power-off driver
Date:   Thu,  9 Sep 2021 13:04:21 +0100
Message-Id: <20210909120421.1313908-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
In-Reply-To: <20210909120421.1313908-1-lee.jones@linaro.org>
References: <20210909120421.1313908-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elliot Berman <eberman@codeaurora.org>

Since reboot_mode is an exported symbol, restart power-off driver can be
compiled as module.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 4d1192062508d..e155b2e2a75c4 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -192,7 +192,7 @@ config POWER_RESET_REGULATOR
 	  power regulator defined in the devicetree.
 
 config POWER_RESET_RESTART
-	bool "Restart power-off driver"
+	tristate "Restart power-off driver"
 	help
 	  Some boards don't actually have the ability to power off.
 	  Instead they restart, and u-boot holds the SoC until the
-- 
2.33.0.153.gba50c8fa24-goog

