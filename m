Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FE339BA85
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhFDOGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFDOGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:06:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB609C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 07:04:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f2so9408718wri.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FXe7mUhRyV1V08UlHOUDRQa+cyJRl+BaTvqQGIK3jgo=;
        b=IaVfsBBg8NR4RGlKN4FA+nCoNqfGwLzQsRsbwt5aa1iwj3NRfw/OtO7jrJTDUGqpMN
         3nVAPuI71sUVJi45TyzxzM5TIPNalhlh3sfTDK715KHFO3Muc2MgflEbEV3Nafl6PD7R
         K+qgau2e3Q9PNbALT3x8rkGgs5+NTyXFUruUWqKYs8PKPFaUyYNz/HKev7bERNhBVieg
         WcZSeH3QkQgKxYNE6LmqUGyhqLYU6HKNSC5G/xK4cRvpuwTtkLy3tg7sD1fN+9iPma7r
         Ej4+LoVtLLElLl53YMXrWShGIRI39H4O94ZsmBzuWC7o70KQiESC9UArUgHuWBqvv5Pt
         e7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXe7mUhRyV1V08UlHOUDRQa+cyJRl+BaTvqQGIK3jgo=;
        b=ayaBlFU7OwmoCW63+6zBx70ynELD0D7fBqRMH3J2kb2+eIstKjPNbaMs/L3jIlIQbZ
         cB8fhqREghU7TJk6evhhs0/mKzFLDoENPnKI/AVYRZweJyPfu+FAErP3oweH1+9KLfwF
         BZXei36uKVGG4ro/YWDn/gsjCCAwAhN2uoSyj/FUqeAbFoM/izfysdLT2RyD7irfJiH8
         EQzHRGMrC4aX1LkH1SMUZqaeiMslSIIO/VUhPhtAAuEr3eBweYFwfqL2Pk/Rc/E35KiZ
         v0UALcqx51TPty5PrIzbo1PSlUClyNm0TdG6jBn/K3WdXY8W2OP2vfrCgc+a7BZEro87
         ne1w==
X-Gm-Message-State: AOAM532kRhALwPkuHykYbAn1Q4TBYmJuESg9l/uPnYn43iRqcX0eCRkL
        TYCd2XaPYd2SQrRkvk5jvD4FPYcA1HWNgA==
X-Google-Smtp-Source: ABdhPJxEWeGElTopDkHbCuLC8qXXv/5amcTjzy0KQBVFAIdSm17ZnCj3j7C4vGyObQxH79cOOQtMIA==
X-Received: by 2002:a5d:4610:: with SMTP id t16mr3942011wrq.324.1622815444460;
        Fri, 04 Jun 2021 07:04:04 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id m11sm5422559wmq.33.2021.06.04.07.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 07:04:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sstabellini@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsa+renesas@sang-engineering.com, linux@roeck-us.net,
        treding@nvidia.com, arnd@arndb.de, xen-devel@lists.xenproject.org,
        patches@armlinux.org.uk
Subject: [PATCH 3/5] ARM: Register with kernel restart handler
Date:   Fri,  4 Jun 2021 15:03:55 +0100
Message-Id: <20210604140357.2602028-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604140357.2602028-1-lee.jones@linaro.org>
References: <20210604140357.2602028-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

By making use of the kernel restart handler, board specific restart
handlers can be prioritized amongst available mechanisms for a particular
board or system.

Select the default priority of 128 to indicate that the restart callback
in the machine description is the default restart mechanism.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/kernel/setup.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 1a5edf562e85e..08c5676477d70 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1081,6 +1081,20 @@ void __init hyp_mode_check(void)
 #endif
 }
 
+static void (*__arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
+
+static int arm_restart(struct notifier_block *nb, unsigned long action,
+		       void *data)
+{
+	__arm_pm_restart(action, data);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block arm_restart_nb = {
+	.notifier_call = arm_restart,
+	.priority = 128,
+};
+
 void __init setup_arch(char **cmdline_p)
 {
 	const struct machine_desc *mdesc = NULL;
@@ -1149,8 +1163,10 @@ void __init setup_arch(char **cmdline_p)
 	kasan_init();
 	request_standard_resources(mdesc);
 
-	if (mdesc->restart)
-		arm_pm_restart = mdesc->restart;
+	if (mdesc->restart) {
+		__arm_pm_restart = mdesc->restart;
+		register_restart_handler(&arm_restart_nb);
+	}
 
 	unflatten_device_tree();
 
-- 
2.31.1

