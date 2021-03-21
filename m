Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417D93435AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 00:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhCUXTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 19:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhCUXTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 19:19:32 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEA9C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 16:19:32 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id i9so8868467qka.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 16:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIqf3h/ft4wOq4cykQH7kGKLCaIOsedzdoAuEFmsYSc=;
        b=evAP+wHMAHNt8Lo9OWoX35orj7Ko4+iSwzMld1X37th2p3vV8+BIKtJltOyVPGj0F3
         jwUESgM/bdOadptc/YOQ5yQ+nPhxdPkjaSl06zNKG74TB2npXbVcERsdhcEa6I1Bq/dm
         R8KbD97Ir1GcjaXVqmZn94In9E2Mn8r/S/kFfjWGWwAGpxBNeCjjX8VFiEnrxlIBaOti
         3PqWrpH7VYhMeFi57KAukZE2dWOSFp70tjnQc7RN7sq27fGAwEy4RcrqNXhGC3AEe5gD
         dL9btMNaVAm4yxolZZqY2E2AzDXuXD7cA87b0c7hEIWhCflEckMb2U9nbc2fxEUx46aA
         Ub+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=uIqf3h/ft4wOq4cykQH7kGKLCaIOsedzdoAuEFmsYSc=;
        b=T+Oplmm5MbTZ0PM0NlP6QBpr8GaGbu6Cdji7JANp/kFBl4jRETqFSfQ5k24JvtC7yb
         5yf8xrKtlnBk+muvL931Jqx47TsbIHtu7jeFE7axMQ8RHLdXDEG1cRKP1pSU/IH/ocSl
         612sW/o25xn6wQjJHN1VFgvfbkWGkfUbviWBEbUvTB5rZ8W3oW4WQ9thVBt0vJW/vGx6
         hPSD76fTYsroylj4E8hee96Strey64toiEpRA43ONCpI3VkuuZ+Ll/m/YCXP4fCySdDt
         HmwsTfAu0+tDgfAHm9fdalS0jbNRxWGNemyLnllLGW9HfIMjFcSdioFboNj3cqZfJN8g
         7aKw==
X-Gm-Message-State: AOAM530K8G26LPPR+gwLnqabeT4bsaxW4BwS7gwY+j6K+rhAAIjBkBRp
        TvnkuIWWiVc5cOrfxvDx7oo=
X-Google-Smtp-Source: ABdhPJyRhWgZhN0TXJdpdQLeAkr3LrwuKdDatxsr2+ac68ylTEp6DilSw/v+O8gsQ4pfUOTBJUGNpQ==
X-Received: by 2002:a37:a5c2:: with SMTP id o185mr8772671qke.428.1616368771261;
        Sun, 21 Mar 2021 16:19:31 -0700 (PDT)
Received: from kde-neon-desktop.orld.fl.wtsky.net ([208.64.158.251])
        by smtp.gmail.com with ESMTPSA id c5sm9812346qkg.105.2021.03.21.16.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 16:19:31 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, fazilyildiran@gmail.com
Subject: [PATCH] sound: soc: sh: fix Kconfig dependency on DMADEVICES
Date:   Sun, 21 Mar 2021 19:19:19 -0400
Message-Id: <20210321231919.262142-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SND_SIU_MIGOR is enabled, and DMADEVICES is disabled,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for SND_SOC_SH4_SIU
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (SUPERH [=y] || ARCH_RENESAS || COMPILE_TEST [=n]) && ARCH_SHMOBILE [=y] && HAVE_CLK [=y] && DMADEVICES [=n]
  Selected by [y]:
  - SND_SIU_MIGOR [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (SUPERH [=y] || ARCH_RENESAS || COMPILE_TEST [=n]) && SH_MIGOR [=y] && I2C [=y]

This is because SND_SIU_MIGOR selects SND_SOC_SH4_SIU
without selecting or depending on DMADEVICES,
despite SND_SOC_SH4_SIU depending on DMADEVICES.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 sound/soc/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 346c806ba390..503ee235e46d 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -60,7 +60,7 @@ config SND_SH7760_AC97
 
 config SND_SIU_MIGOR
 	tristate "SIU sound support on Migo-R"
-	depends on SH_MIGOR && I2C
+	depends on SH_MIGOR && I2C && DMADEVICES
 	select SND_SOC_SH4_SIU
 	select SND_SOC_WM8978
 	help
-- 
2.25.1

