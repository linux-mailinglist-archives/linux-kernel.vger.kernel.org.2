Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629E139BA8E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhFDOHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:07:06 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:39834 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhFDOHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:07:05 -0400
Received: by mail-wm1-f42.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso7987849wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QaJICWaLVjdKyiczP8R7DVAA/JKj3/g1GzNXgU/ERjo=;
        b=OtKIdFz91o6zSGDVTQZvGzg/E3WbsLPBQt+zn0ndJ5AES765uw0NRLSuW7BmM1XIIb
         KSmT00ThuHMEyNqcf0APky2O0X+Fz0wCuAj+ufEoElBLQgTbz+i02lN3/Zf1im09zpDW
         V7M1w+GKAjj8vX7fR+3Ffa8zGHIP9mnEFe/wg7tdUMuHD2MA56Co5BpmNTswwnhnzJZ3
         9c7ENbHX2CdAaMwDB25ftfd7WDxFryEsXCCExLyCZAO6YcPG/2o+q800T9B4mz1KOZRv
         aTr3DUL+N94+eGQZxLu/MEdvv+3cWnjJfA40LNQyMNgeg0oJvNtkbZAD86ICk+f88Itg
         u7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QaJICWaLVjdKyiczP8R7DVAA/JKj3/g1GzNXgU/ERjo=;
        b=GAt4A3o68HrqM3XHHT8IxDQLRMVlUZtwBV57N3G07SaoRez9YAW7jYNSXTzT2sngrn
         GYNRRwOVrgYU+Fpk6wKUpNelfXEU1WE/wT2w21JhPTbXPPZMQq+4lwycwLrz6f5HJKHN
         57fg19nepmiS7tanEJDSmtOmcFJYxLGnxpPqCQwAEWdIn0Fzr8pZeuFcXhRdUdOJRkn1
         BIZ3lZNuhuTbi5E6Wm46rILLbqzoDubE7Xy4GhlkrKkN9IeF/EOanMtgEQ5P5CMZw0ER
         azthRQkIdxEEmqpJ9+OUDjXpP1XpWhgbQ+PCsjJA5yA2dFhlA92Bb8rPhG++ko2C/zYX
         bq+A==
X-Gm-Message-State: AOAM533umSlRHpTl4ZZFrB/priy0xksbv2Sds+Kqaqc10AHPUbx3dxQf
        NI9MdLm675HSwqOipQzccU/g4A==
X-Google-Smtp-Source: ABdhPJxkeeHzpVP/eH19on7AKsxKyxYqA03gG6EEjmBqwHMSrKqjg6lHl/nEqHDgTjEVI8pTSN1dXw==
X-Received: by 2002:a7b:c30f:: with SMTP id k15mr3940993wmj.128.1622815445465;
        Fri, 04 Jun 2021 07:04:05 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id m11sm5422559wmq.33.2021.06.04.07.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 07:04:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sstabellini@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsa+renesas@sang-engineering.com, linux@roeck-us.net,
        treding@nvidia.com, arnd@arndb.de, xen-devel@lists.xenproject.org,
        patches@armlinux.org.uk
Subject: [PATCH 4/5] ARM64: Remove arm_pm_restart()
Date:   Fri,  4 Jun 2021 15:03:56 +0100
Message-Id: <20210604140357.2602028-5-lee.jones@linaro.org>
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
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm64/include/asm/system_misc.h | 2 --
 arch/arm64/kernel/process.c          | 7 +------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 673be2d1263c4..305a7157c6a6a 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -32,8 +32,6 @@ void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
 struct mm_struct;
 extern void __show_regs(struct pt_regs *);
 
-extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
-
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __ASM_SYSTEM_MISC_H */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index b4bb67f17a2ca..5591725cebccc 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -72,8 +72,6 @@ EXPORT_SYMBOL(__stack_chk_guard);
 void (*pm_power_off)(void);
 EXPORT_SYMBOL_GPL(pm_power_off);
 
-void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
-
 static void noinstr __cpu_do_idle(void)
 {
 	dsb(sy);
@@ -201,10 +199,7 @@ void machine_restart(char *cmd)
 		efi_reboot(reboot_mode, NULL);
 
 	/* Now call the architecture specific reboot code. */
-	if (arm_pm_restart)
-		arm_pm_restart(reboot_mode, cmd);
-	else
-		do_kernel_restart(cmd);
+	do_kernel_restart(cmd);
 
 	/*
 	 * Whoops - the architecture was unable to reboot.
-- 
2.31.1

