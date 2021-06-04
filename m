Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6BC39BA8C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhFDOGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:06:54 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:34693 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhFDOGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:06:53 -0400
Received: by mail-wr1-f54.google.com with SMTP id q5so9466160wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D6QyFvCrmM9/eKIfxG4Pm00YDFikRvR7iKb/WRsmrRM=;
        b=rnXl1mp749C3drgrMS8qg9OrEpVG5gyjtC/beupAd1e0u7I2C0SA+eLYqiAZo4zOf1
         q05qwrZm55jTi+ifKRg8eXWpkJEyVRxtH/IgUYGbEZ70EVHfHrPyla7TPIzoc3bF3HUY
         38N+YHqp0zTbzFzoCmx/yOn7e0FImL+E1RzKDH7btVNuv4yY5751UVI1bLnrNl7scCoW
         LFc1Ih93JSdQok29RWgqRhCojCLYOg62P4bYX/nGU9EOEWtNNXBLPDIFNWoTmUP22sU3
         JvGp1+ARt/xYZhTOdzb03Rb1/7Tbwwe1vK1CD+EZtoPQYOnPg1dx3h+YFx/bg1nj1AhS
         +DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D6QyFvCrmM9/eKIfxG4Pm00YDFikRvR7iKb/WRsmrRM=;
        b=YQaAnEONmk6uDUBTSvN6Uop66rebGQcMfM+aY3p7/ZV+mXTH9ebPhTM7+eImXifcZf
         CNq4HS9evy0MvA2Bg0dLzICw/WPZBMSJGLsuV3f2/UVvxBO+x/GLYhhT/LZ8xyjdX01K
         2+2WJbJbp7Q4HWhXnUprHwLsWEBR8EBptrvF0zVbi7oeXcP9f2mHYPQaKsyg0z7gFWxa
         te3mG8/OziJbQHceseNoxqBJ4cs+wBxdBYaAwY7KqwkmE2IYonBoagp6Xvs2TVB1/fIq
         jeaa7mmn1F0hqs/AelhxWN3/c7M1K2l+XfIKun2TAA6s97xNsezloPwMQvgQr8dZxzXM
         tO3w==
X-Gm-Message-State: AOAM531mq6M8WpTqyScrvVqkIzJXstqBYXYUwWkwgXKhpSHqMv4UVmGm
        roczKoQWZv4sQ5IAFZhwLxWnCw==
X-Google-Smtp-Source: ABdhPJy6Bn0tgDEaDDg7jaA3vOqPTriXmMlbNfufQjcNecRNKMp6REhDzJ4KHPqHqkOmLTOy8DweYw==
X-Received: by 2002:adf:f7c3:: with SMTP id a3mr3659762wrq.253.1622815446460;
        Fri, 04 Jun 2021 07:04:06 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id m11sm5422559wmq.33.2021.06.04.07.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 07:04:06 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sstabellini@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsa+renesas@sang-engineering.com, linux@roeck-us.net,
        treding@nvidia.com, arnd@arndb.de, xen-devel@lists.xenproject.org,
        patches@armlinux.org.uk
Subject: [PATCH 5/5] ARM: Remove arm_pm_restart()
Date:   Fri,  4 Jun 2021 15:03:57 +0100
Message-Id: <20210604140357.2602028-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604140357.2602028-1-lee.jones@linaro.org>
References: <20210604140357.2602028-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

All users of arm_pm_restart() have been converted to use the kernel
restart handler.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/include/asm/system_misc.h | 1 -
 arch/arm/kernel/reboot.c           | 6 +-----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
index 66f6a3ae68d27..98b37340376bc 100644
--- a/arch/arm/include/asm/system_misc.h
+++ b/arch/arm/include/asm/system_misc.h
@@ -13,7 +13,6 @@
 extern void cpu_init(void);
 
 void soft_restart(unsigned long);
-extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 extern void (*arm_pm_idle)(void);
 
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index 0ce388f154226..3044fcb8d0736 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -18,7 +18,6 @@ typedef void (*phys_reset_t)(unsigned long, bool);
 /*
  * Function pointers to optional machine specific functions
  */
-void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
 
@@ -138,10 +137,7 @@ void machine_restart(char *cmd)
 	local_irq_disable();
 	smp_send_stop();
 
-	if (arm_pm_restart)
-		arm_pm_restart(reboot_mode, cmd);
-	else
-		do_kernel_restart(cmd);
+	do_kernel_restart(cmd);
 
 	/* Give a grace period for failure to restart of 1s */
 	mdelay(1000);
-- 
2.31.1

