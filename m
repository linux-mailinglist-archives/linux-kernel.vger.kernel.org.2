Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9571C31D7FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhBQLLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhBQLH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:07:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C3BC061786
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:07:17 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r21so16886896wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gB4/TxEWTY3nu4o41IxwOjPhWGPTj1512uvoivaNJ8M=;
        b=r5RbM/zCP3sSrFvaWvZBWDnjIJHatlFIwYLVnzrEFILcnamhYKFGsYWw8yaxIT6i2w
         MTsaj9VQMxpf3usK6RMQ4nCZPj7iKUjaCM9yfDT0cSg0kFmv0MvuXunMPHN72RNqpwH7
         C8XuCrPP8RFVsCz+i9gKcwAdXqn2bAS0fBatPHCIfS7ifuuMPRoVF2/zELu4VCQzYIRz
         0/FfNTMFjrYic/pCQGrj1J/Tc5PW4frwox7tsZmrZ7MV0NF90lqCzfZyi6BfE/nA4Y/b
         dw9ik5kFpjBwN4uxP8bKwCLe/nquHsYsv1eRdeBwyIpwpQRMViCFBdyQIEiNxBhPIWrv
         10/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gB4/TxEWTY3nu4o41IxwOjPhWGPTj1512uvoivaNJ8M=;
        b=kga5P2X1epTMhUlc0er1OUGDUwEkn+vBJc4OxESWl3x6vH7C8ScfYfNif92wO62kMV
         PbDzwD/+8ocdtHBuzMmW4kjg29QKgrindbMU5QA2av3FHoufS638zKLudqejKhJPxXDM
         R5dB1LfK0bvoL7X+pjUY5FmI8/P13B1d9nDR/AsjcwQoY7qApvFx0edLIyRz4GEe+kHK
         GGdG17tzS74SXs/kWv9gBzZBTYhR5MjSpyalIHcIGZ9UfbkRctY0Vz+dbgVcjl5O4fSo
         BvxDL18jC4qFQMHLUA6E4tMSNTP2iCjReKyzX+NkBHmFdMFTEBNgZuh/rrZItuNrQaLs
         O5zw==
X-Gm-Message-State: AOAM533tcCOgloMUv5Jpwv/HfZaow7UbNUFnyrj8pcp/iQE2hlYllLo7
        VpYepX4mESbE1tCVWk4/1q8=
X-Google-Smtp-Source: ABdhPJw2Vuked6HhTFSq6EZVKhhzWn26rtNOhP+mvfOsfFXikaFfVFdnVlSBLZBZI7rfeDzXoN4e2Q==
X-Received: by 2002:adf:f7c5:: with SMTP id a5mr29125950wrq.243.1613560035701;
        Wed, 17 Feb 2021 03:07:15 -0800 (PST)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id y1sm3594073wrr.41.2021.02.17.03.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 03:07:15 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>
Subject: [PATCH 2/2] arm: zynq: don't disable CONFIG_ARM_GLOBAL_TIMER due to CONFIG_CPU_FREQ anymore
Date:   Wed, 17 Feb 2021 12:07:09 +0100
Message-Id: <20210217110709.17250-3-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210217110709.17250-1-andrea.merello@gmail.com>
References: <20210217110709.17250-1-andrea.merello@gmail.com>
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
index 0f1c625275a0..421cd763bdb2 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -387,6 +387,7 @@ config ARM_GLOBAL_TIMER
 
 config ARM_GT_INITIAL_PRESCALER_VAL
 	int "ARM global timer initial prescaler value"
+	default 2 if ARCH_ZYNQ
 	default 1
 	depends on ARM_GLOBAL_TIMER
 	help
-- 
2.17.1

