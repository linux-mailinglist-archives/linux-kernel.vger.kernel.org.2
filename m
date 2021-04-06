Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69F9355470
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbhDFNBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344273AbhDFNBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:01:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D445C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 06:00:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b9so6252645wrs.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIKSLownrjQaREY8PD9eYBLDuzcENgKujWdWeJIFVlw=;
        b=AU1X0OiCkYhERIFxHiJwuCt40wv/HYCYNN7pLjCHB+Lqc0KExrVzzuLuulgXYUXuOz
         3uVmzWVzfZYkv2jRgOfpieqK6QFaTtnr9jQl8jTj422uyzW9zebDtKqBjt8buQcLgPz3
         9GRsB1OW1scuRn9b8BibJV/tDyty87BrlMMv82keQfx9s4APm8R8zFdP36oGHBONgaHO
         5UW3yehkF/jMS3Btgw7npIRNr2y+qIqC9bVkDG/EjfvVocZOTn+HWpgPtdmEVV359Cn2
         2dO5UR2ed0w2RWVoBtbd+oyrpJEvK9bwqLzucinx+pKpkLnoBlTQlrbzoXfnP59Pfgst
         H+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIKSLownrjQaREY8PD9eYBLDuzcENgKujWdWeJIFVlw=;
        b=fG1nYZ9C2SlXN85PztlgCSB6OBZsa1jBhhZQ0A4Z1xdNISegPayYqLNxSUPDOYfVM2
         /UyDX1QtN8rZDq7w8EK/2ekak7XzUAmgL+EoPIOzS6dv4xVho+OVp5GSnWVD2ysow+Sa
         9oYXjuQ1o4vLqaT2sap9pdYkQJljgv+oc0CNvVeu31m8+CYhR6O/L2AyoqpL/PGds3V9
         mCTxsTNfk1aCC3gHASb0/sUzFL+CiwQQEof3L0BzRWB4KrwZM5Qll5bQG9bOUul5dWK2
         dL+Oj7oBA+vQbYfeni2zfTKB0viuwbLt7m9PfcV2Oro9eITil2BmC8nd7EpgbIF31d3d
         EfZA==
X-Gm-Message-State: AOAM532sHhWaNLvWKPsKz092dEni7KElpJLYaojf17MReKw3q3nXX3M6
        txP6l+LIqo1gE3Tn14u9qiI=
X-Google-Smtp-Source: ABdhPJwguebrN19uECuH9lP0ZAZDsaYAqNV9MGD4f/y72fCLpnbV25vmZZEi2NtTU/TqpNwSxIJkQw==
X-Received: by 2002:a5d:564a:: with SMTP id j10mr34317550wrw.120.1617714054421;
        Tue, 06 Apr 2021 06:00:54 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id p5sm2251371wme.23.2021.04.06.06.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 06:00:53 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>
Subject: [PATCH v2 2/2] arm: zynq: don't disable CONFIG_ARM_GLOBAL_TIMER due to CONFIG_CPU_FREQ anymore
Date:   Tue,  6 Apr 2021 15:00:45 +0200
Message-Id: <20210406130045.15491-3-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210406130045.15491-1-andrea.merello@gmail.com>
References: <20210406130045.15491-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now ARM global timer driver could work even if it's source clock rate
changes, so we don't need to disable that driver when cpu frequency scaling
is in use.

This cause Zynq arch to get support for timer delay and get_cycles().

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Sören Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/mach-zynq/Kconfig  | 2 +-
 drivers/clocksource/Kconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index 43fb941dcd07..a56748d671c4 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -6,7 +6,7 @@ config ARCH_ZYNQ
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
-	select ARM_GLOBAL_TIMER if !CPU_FREQ
+	select ARM_GLOBAL_TIMER
 	select CADENCE_TTC_TIMER
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 19fc5f8883e0..9fa28237715a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -360,6 +360,7 @@ config ARM_GLOBAL_TIMER
 
 config ARM_GT_INITIAL_PRESCALER_VAL
 	int "ARM global timer initial prescaler value"
+	default 2 if ARCH_ZYNQ
 	default 1
 	depends on ARM_GLOBAL_TIMER
 	help
-- 
2.17.1

