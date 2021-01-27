Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609B0305070
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhA0EJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbhA0DhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:37:18 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8331EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 19:36:37 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id m21so294912qtp.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 19:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=qECvV0vEOBtkzXawSawHLbAty2xo5aEM+k93CM/ziPA=;
        b=NAOSQ9r8E6p/8OGQfOlbgD56yMIEC60Qbs/s+/17Ahfy22VHxTXEfCD2sC781QI2Gp
         lbUvRJfzA5tM5xn03JeqR3rrsisrXdiA1MsYPSywI2J6NqpS4FEzdyBC8oB/BgZx/iEW
         vvZGVwyWXTUKdN6j1fSgIR69qjq0GlKLfvSuDBL8s/hHUpkBLbh6QBE9sQ2DTfYlpM9/
         oulQwjSGlogkQP039Kzt3SLPPlZ8bOOMN+IpgaIo5I5iueEUjmM+QkVgTFJ/ZSwp6+d+
         MurFADrIsNpVUtdCsMubXi1wGCZBn5iBowPQoV5DEyFUhn+rHDh6+Lzw/1UDHn6ua3Kc
         Csrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=qECvV0vEOBtkzXawSawHLbAty2xo5aEM+k93CM/ziPA=;
        b=NBF7zcefdK3YMwCAMH11eJCioBCeYS9uswlUb8DufYQukwDcqAsanVV58mtf+gTPNW
         Kk1L2szb9LVgylMTPtX8XIG5FU/KGjR5LZyrwyMrSnMK11vS8LziojWiRlf05rdhXtOe
         BwBBG4QGzpWjn/AdUK/k+Xhiubciq5pMVIusSMy3yURi9UvFynHH84CkC/eWVnR3tPgv
         48k5F9Gkv199pTpRrD0tcOwDvz3eCfI+nam64/VIJntODKIl55TYAzsWkxJi+uDmHNaT
         4ECeOHXELpKIFdzpd5wb3RDlGvYeGMfccIa8LxpmEjJBJG8PQjh4Nrqq5p0NVujstS/e
         nVEw==
X-Gm-Message-State: AOAM532KuGJS6xMz6Hp+dAPmttT4UhTJd26E1W2FBimYBqzBaHtkcljG
        CUXuvFzYa4h4kmX2wbXQDOa7u7ssQjhYuw==
X-Google-Smtp-Source: ABdhPJwcnZEfgIWpJyjaIvY9ypSi2EtVessUlqUKFq1j7QfqAaXyU1EhZkf9M3JcEsWUFHFSD7lb0m8T+4zqpg==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:7000:2f04:a262:7158])
 (user=davidgow job=sendgmr) by 2002:a0c:b929:: with SMTP id
 u41mr8874953qvf.30.1611718596681; Tue, 26 Jan 2021 19:36:36 -0800 (PST)
Date:   Tue, 26 Jan 2021 19:36:04 -0800
Message-Id: <20210127033603.1519127-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH] soc: litex: Properly depend on HAS_IOMEM
From:   David Gow <davidgow@google.com>
To:     Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Stafford Horne <shorne@gmail.com>,
        Mateusz Holenko <mholenko@antmicro.com>
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LiteX SOC controller driver makes use of IOMEM functions like
devm_platform_ioremap_resource(), which are only available if
CONFIG_HAS_IOMEM is defined.

This causes the driver not to be enable under make ARCH=um allyesconfig,
even though it won't build.

By adding a dependency on HAS_IOMEM, the driver will not be enabled on
architectures which don't support it.

Fixes: 22447a99c97e ("drivers/soc/litex: add LiteX SoC Controller driver")
Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/soc/litex/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
index 7c6b009b6f6c..7a7c38282e11 100644
--- a/drivers/soc/litex/Kconfig
+++ b/drivers/soc/litex/Kconfig
@@ -8,6 +8,7 @@ config LITEX
 config LITEX_SOC_CONTROLLER
 	tristate "Enable LiteX SoC Controller driver"
 	depends on OF || COMPILE_TEST
+	depends on HAS_IOMEM
 	select LITEX
 	help
 	  This option enables the SoC Controller Driver which verifies
-- 
2.30.0.280.ga3ce27912f-goog

