Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1303539BA8B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhFDOGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:06:51 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:42701 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhFDOGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:06:50 -0400
Received: by mail-wr1-f44.google.com with SMTP id c5so9410224wrq.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TEh1khdRrbKOISh67J2riVpfOYD6OGYoV3WdgW9rcJ0=;
        b=nbeaNWdBnTcP7bz1VBo8ORkE7GXcmZ9WULwc9d53BO3FJsVDxfvMLco7Jdi8xDopSW
         rFy3A0cnyioI9Du7UwC11so/a/emXg9SmX89XwsXCX5PaimX++OUSF1pmOmzDjPSJ563
         7KFOmY8D3Adm6+/EaZXeJifRRsQf4TM1fcsM4mdfUuAE8wpGiEtPHYeK25qBDNx3FX1l
         FVS9pptxb5ACR0S1LvelYbp3SQvbYCD1/z9hRSFTg44QPcwlGsK3ziy22bSbbPIeLBwq
         2RB1U4q1ThxkuhSrx8E1G/ve/dmSXoAlyAyj1BJwgzWp2AZfBYGVio/AYt62J9+48+g7
         WH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TEh1khdRrbKOISh67J2riVpfOYD6OGYoV3WdgW9rcJ0=;
        b=o22F0Yi+42tLK9FrtjLUpjqySBofG9CCguHaCotWVsIu9/zfvT4FKq6Jc8um6Mgnon
         Sa7pEmW3NIs9XGLW+qV8Ap3TXCspzza5Z0VVKS8KgoPfR6YT6FuczDEcqnivxgC85FKU
         DA7DBY2uZ6Y3WhqsrJUvOBM7MP7Yxkp+sXXdudcI+w5LzBz6j80gqUot9mk6rRLsWVwk
         Rq0o418mQZb0uF94C3KcA2sd0cwly1lsvO5ho/p8mkWbskwu23GYMplWFZ+WN1HJs8A1
         tGlx4fvb5HjC40Racj3BUXsrtom0lGSyHSXfIhKCLSL/9IEce6jT3z0ikjigv8szSXqi
         zzNw==
X-Gm-Message-State: AOAM530Xzz7No/a3f6Zzg0WhhUOGBGORtA93IFXhxhYFaxbLMlmqnJWF
        X5nv5aUk9aUKztDR/bDVis/Azg==
X-Google-Smtp-Source: ABdhPJw1kAi2sfOb54fRB7u21L2rZpgLmTnYQGXWunLdqkzDvlsLaxCRGrc38uw/MzOLdLP3jwPQtw==
X-Received: by 2002:a05:6000:18ac:: with SMTP id b12mr4005226wri.44.1622815443376;
        Fri, 04 Jun 2021 07:04:03 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id m11sm5422559wmq.33.2021.06.04.07.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 07:04:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sstabellini@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsa+renesas@sang-engineering.com, linux@roeck-us.net,
        treding@nvidia.com, arnd@arndb.de, xen-devel@lists.xenproject.org,
        patches@armlinux.org.uk
Subject: [PATCH 2/5] drivers: firmware: psci: Register with kernel restart handler
Date:   Fri,  4 Jun 2021 15:03:54 +0100
Message-Id: <20210604140357.2602028-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604140357.2602028-1-lee.jones@linaro.org>
References: <20210604140357.2602028-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Register with kernel restart handler instead of setting arm_pm_restart
directly. This enables support for replacing the PSCI restart handler
with a different handler if necessary for a specific board.

Select a priority of 129 to indicate a higher than default priority, but
keep it as low as possible since PSCI reset is known to fail on some
boards.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/firmware/psci/psci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 3c1c5daf6df2e..18a47c9d5b02b 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -296,7 +296,8 @@ static int get_set_conduit_method(struct device_node *np)
 	return 0;
 }
 
-static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
+static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
+			  void *data)
 {
 	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
 	    psci_system_reset2_supported) {
@@ -309,8 +310,15 @@ static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
 	} else {
 		invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
 	}
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block psci_sys_reset_nb = {
+	.notifier_call = psci_sys_reset,
+	.priority = 129,
+};
+
 static void psci_sys_poweroff(void)
 {
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
@@ -472,7 +480,7 @@ static void __init psci_0_2_set_functions(void)
 		.migrate_info_type = psci_migrate_info_type,
 	};
 
-	arm_pm_restart = psci_sys_reset;
+	register_restart_handler(&psci_sys_reset_nb);
 
 	pm_power_off = psci_sys_poweroff;
 }
-- 
2.31.1

