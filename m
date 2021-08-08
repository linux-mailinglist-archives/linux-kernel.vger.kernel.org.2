Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F903E3AAD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 15:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhHHNzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 09:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHHNzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 09:55:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130D9C061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 06:54:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso2467975pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B4jJTmlBzRU0ND63u5HHl3oJLU0L0pdpsLtQJ3hM5kc=;
        b=T2/Bo6n2/GBuMQzYIqOLtfm69DsWGu/581saZcNmgC7Pn1ysgEgazrNaPJaMOpzheV
         WNyf/jvokCkw2U7vQa/ry7GYX3/R64pA2Wj/6tkylf4t6ERG3QZtIfu35GgEzqo26jO9
         bQidAbZ2CWFO4XWZRpSMN3GoHkIbf0Dl15jncCfzeQmryvbSaFJVvRfhxmR3zwD7y0t9
         16a7mqYU5GBJ459pvaZ1LlrWBEURwYBgIMCZlgu/smvPEziqIRbdlP4n0PXc/wt5iF9H
         tDEsEHpVLLfPmuiwCMZ52nBMxAnSV82NQAcuuluUKWwOExs92qAJGHDWzzr9JnaMeVfm
         LN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B4jJTmlBzRU0ND63u5HHl3oJLU0L0pdpsLtQJ3hM5kc=;
        b=IzRjPXYXt2xeOTJ9Vj7avYMx7NsFeuLxUZTN3PSz9dxerzShfY6l6T3IqcCZYbRzDt
         1uYACNHlWxDB/q5wE7rwU17KI0zoJRLaz+/ID4BlLcZsMyYGeH7+2WM4p8/zCZYYWLbz
         /QJgCmmZLqD3HZjxktg6z+UXWqMVsumWDsNwLZYAadxGyKgUnjlzxThdP4YSQlrU5Tro
         dUus5rI6Vbr/fDcstrMlk/MyZ0XAYNxI+AGfzGrwislp1fcCd0tzpMXmtG98ZOjmx8Oi
         CpeJBtHYzxC60EJ82TMjfZN7yldeH63PAh6efwE3Tg7qfvyYWDqg2LXwMto4JoqiRyYT
         Axqg==
X-Gm-Message-State: AOAM531jIJYTwNNegrpl5Xoedlb7hVBTxqai6O7Heoc2U6HjXraA1KZ0
        4uJ1YWgQVTFFTBjtKSne7DTcWUrsuKkqMA==
X-Google-Smtp-Source: ABdhPJxqH79LAB77AR8WWELiOieSKx0Y40V6NvBxMfmYH1f1QA5Mxf2fQ3jbWa6iJuK5QIKSD9r4Og==
X-Received: by 2002:a05:6a00:216f:b029:3c8:4705:f9fd with SMTP id r15-20020a056a00216fb02903c84705f9fdmr11253671pff.76.1628430886102;
        Sun, 08 Aug 2021 06:54:46 -0700 (PDT)
Received: from localhost (g195.61-45-49.ppp.wakwak.ne.jp. [61.45.49.195])
        by smtp.gmail.com with ESMTPSA id o127sm17346047pfb.48.2021.08.08.06.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 06:54:45 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2] openrisc: Fix compiler warnings in setup
Date:   Sun,  8 Aug 2021 22:54:36 +0900
Message-Id: <20210808135437.3640549-1-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was pointed out with the recent name change of or32_early_setup to
or1k_early_setup.  Investigating the file I found a few other warnings
so cleaning them up here.

    arch/openrisc/kernel/setup.c:220:13: warning: no previous prototype for 'or1k_early_setup' [-Wmissing-prototypes]
      220 | void __init or1k_early_setup(void *fdt)
	  |             ^~~~~~~~~~~~~~~~

Fix this the missing or1k_early_setup prototype warning by adding an
asm/setup.h file to define the prototype.

    arch/openrisc/kernel/setup.c:246:13: warning: no previous prototype for 'detect_unit_config' [-Wmissing-prototypes]
      246 | void __init detect_unit_config(unsigned long upr, unsigned long mask,
	  |             ^~~~~~~~~~~~~~~~~~

The function detect_unit_config is not used, just remove it.

    arch/openrisc/kernel/setup.c:221: warning: Function parameter or member 'fdt' not described in 'or1k_early_setup'

Add @fdt docs to the function comment to suppress this warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---

Changes since v1:
 - Add #include <linux/init.h> to fix compile failure.  Pointed out by robot and
   randy.

 arch/openrisc/include/asm/setup.h | 15 +++++++++++++++
 arch/openrisc/kernel/setup.c      | 16 +---------------
 2 files changed, 16 insertions(+), 15 deletions(-)
 create mode 100644 arch/openrisc/include/asm/setup.h

diff --git a/arch/openrisc/include/asm/setup.h b/arch/openrisc/include/asm/setup.h
new file mode 100644
index 000000000000..9acbc5deda69
--- /dev/null
+++ b/arch/openrisc/include/asm/setup.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021 Stafford Horne
+ */
+#ifndef _ASM_OR1K_SETUP_H
+#define _ASM_OR1K_SETUP_H
+
+#include <linux/init.h>
+#include <asm-generic/setup.h>
+
+#ifndef __ASSEMBLY__
+void __init or1k_early_setup(void *fdt);
+#endif
+
+#endif /* _ASM_OR1K_SETUP_H */
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 7eddcac0ef2f..0cd04d936a7a 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -210,6 +210,7 @@ void __init setup_cpuinfo(void)
 
 /**
  * or1k_early_setup
+ * @fdt: pointer to the start of the device tree in memory or NULL
  *
  * Handles the pointer to the device tree that this kernel is to use
  * for establishing the available platform devices.
@@ -243,21 +244,6 @@ static inline unsigned long extract_value(unsigned long reg, unsigned long mask)
 	return mask & reg;
 }
 
-void __init detect_unit_config(unsigned long upr, unsigned long mask,
-			       char *text, void (*func) (void))
-{
-	if (text != NULL)
-		printk("%s", text);
-
-	if (upr & mask) {
-		if (func != NULL)
-			func();
-		else
-			printk("present\n");
-	} else
-		printk("not present\n");
-}
-
 /*
  * calibrate_delay
  *
-- 
2.31.1

