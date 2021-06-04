Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DD239BA89
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhFDOGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:06:50 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:34683 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhFDOGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:06:49 -0400
Received: by mail-wr1-f54.google.com with SMTP id q5so9465959wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9vD7NkGDkc+IVLjUtVKL1KzFVVpDAskIEMoj4foPPh0=;
        b=akY05cjVG2u0Mf/Ur1k9G+ijD85MCVBcTS5cQxoMRHReBqD1UUr5+rTusPSJUjBFcQ
         xJ5eN+t/caaW7VWfSKfSEp9tAOxtYnT7wP4gt0PBctHI71FMDBhIJElbtcRHq0RZXIqj
         NxjnAOMorjqeNIdAFe72j34/dxhsIEZWYFc8liIEyolGby0H9wUp9V8daZmdeVX1FZ0B
         5SeriQykexYzYAk2IbdrrdTOG9zKvdQJXFBJgXPKvzkZZrm/S0Ymv4tV6g+9IRQBLFvQ
         UPN+cQH55smlaQ153ZgRX0rZF83RKMv1yYNN5C6hN2iKku845JUpznvi7dzmQSIaEGCJ
         OzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9vD7NkGDkc+IVLjUtVKL1KzFVVpDAskIEMoj4foPPh0=;
        b=E8UiA/j1cur7f5tgf94f/uwSaWcYXHeps7k5PN/Oxkoiw4rgTG5Fl+aFVxwLryhxTq
         /0HriTFc+0u7q2AutxIpgxgZiWH5kQrvVLkwApkTeOGZZInAi8GJm3YuY8yHuJraLl9u
         EdNsuHN987UJsU0eJNWRjFPVPk+YIUPcMeTt93uCLIIHkK0XIrV6/Nj3bGe2VQNkPF97
         QaTk76bWpR6pVTNgdCVRH4YlI7FzAVEuwjgC20sXSNX/jxl3oTFytpDI5DkcZeciDKMI
         HC8zKn8WOF/LY+jfNWL8yCsDl9qLWv/mk6ji94wP4Cfvhi6HRmm1n2vebznXY28PIrSD
         HcoQ==
X-Gm-Message-State: AOAM531WdwpT0ex+v7AwjoOI6Ani6QuqNOP0hBlWkJjKGROrhnZmbAZp
        OU8/mc5g+wJCYKI1FheQ0kB7rQ==
X-Google-Smtp-Source: ABdhPJyoc18GiAJJdLah52gbebIhTBv5cg91BFwDaX7X49x4F2VQ9HNUtagdypEOLgxeAr0vit0AsA==
X-Received: by 2002:a05:6000:6:: with SMTP id h6mr4149822wrx.24.1622815442389;
        Fri, 04 Jun 2021 07:04:02 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id m11sm5422559wmq.33.2021.06.04.07.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 07:04:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sstabellini@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsa+renesas@sang-engineering.com, linux@roeck-us.net,
        treding@nvidia.com, arnd@arndb.de, xen-devel@lists.xenproject.org,
        patches@armlinux.org.uk,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: [PATCH 1/5] ARM: xen: Register with kernel restart handler
Date:   Fri,  4 Jun 2021 15:03:53 +0100
Message-Id: <20210604140357.2602028-2-lee.jones@linaro.org>
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
directly.

Select a high priority of 192 to ensure that default restart handlers
are replaced if Xen is running.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/xen/enlighten.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 8ad576ecd0f1d..7f1c106b746f8 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -29,6 +29,7 @@
 #include <linux/cpu.h>
 #include <linux/console.h>
 #include <linux/pvclock_gtod.h>
+#include <linux/reboot.h>
 #include <linux/time64.h>
 #include <linux/timekeeping.h>
 #include <linux/timekeeper_internal.h>
@@ -181,11 +182,18 @@ void xen_reboot(int reason)
 	BUG_ON(rc);
 }
 
-static void xen_restart(enum reboot_mode reboot_mode, const char *cmd)
+static int xen_restart(struct notifier_block *nb, unsigned long action,
+		       void *data)
 {
 	xen_reboot(SHUTDOWN_reboot);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block xen_restart_nb = {
+	.notifier_call = xen_restart,
+	.priority = 192,
+};
 
 static void xen_power_off(void)
 {
@@ -404,7 +412,7 @@ static int __init xen_pm_init(void)
 		return -ENODEV;
 
 	pm_power_off = xen_power_off;
-	arm_pm_restart = xen_restart;
+	register_restart_handler(&xen_restart_nb);
 	if (!xen_initial_domain()) {
 		struct timespec64 ts;
 		xen_read_wallclock(&ts);
-- 
2.31.1

