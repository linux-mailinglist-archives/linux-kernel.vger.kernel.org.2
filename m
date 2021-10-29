Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685FF440226
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 20:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhJ2Sir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 14:38:47 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:45900 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhJ2Siq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:38:46 -0400
Received: by mail-ot1-f45.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so14753710otq.12;
        Fri, 29 Oct 2021 11:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9uRR5TXqJPhhQ7gzJBqfQmySfPcuUynmfm/TwLsNXtU=;
        b=Kq7VgQCktxipI0uxF2guAQwzrzsTpI1TGoRpbrPGXvxYlW81Aimx91za3p/17aKj+E
         ZmVVU6cuuG9wnu08SkzFmmYLvGTkhKZvfKMtHgXmGB6I3V358sNiQirH0G197Z9lahSS
         20qQuOHFVGbJM9iTP1UIUCRm4/c7o6w9mo2U8iMgiLOw/Z1K8n1OkwSCzW541nEYXVzZ
         ZCqEj1JWNwpNhr5r7cJ1xBu8yRI9rsNeNMAz88jF5+L4AYuxGIsifwTN0SASysmTjN6O
         KMfjVO+wNH7x/LUeMpzWyq9Z0OvedZ3Wkwq0CWW/BUaMQlRqxEL0CNsoRM55E94FaPgI
         bqdQ==
X-Gm-Message-State: AOAM532Ud0fzMAakoqDqPCuZHLgRpUXW5Bu1g9SdDO0VCKDq+AcJrzzM
        DPC4BkCzd0427rtnFQ1tT6wfHyK2uw==
X-Google-Smtp-Source: ABdhPJzia4fp+apruMEoc3kYBHNbIa0IMI71HVAj1Ka62UQpykUrdtGjtARLA94Fyhm5tGB/yONIUQ==
X-Received: by 2002:a05:6830:270c:: with SMTP id j12mr7089086otu.142.1635532576709;
        Fri, 29 Oct 2021 11:36:16 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id p13sm351283oom.28.2021.10.29.11.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 11:36:16 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] of/fdt: Remove of_scan_flat_dt() usage for __fdt_scan_reserved_mem()
Date:   Fri, 29 Oct 2021 13:36:15 -0500
Message-Id: <20211029183615.2721777-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of the of_scan_flat_dt() function predates libfdt and is discouraged
as libfdt provides a nicer set of APIs. Rework __fdt_scan_reserved_mem()
to be called directly and use libfdt.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/fdt.c | 52 ++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4546572af24b..bdca35284ceb 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -562,39 +562,35 @@ static int __init __reserved_mem_check_root(unsigned long node)
 }
 
 /*
- * __fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
+ * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
  */
-static int __init __fdt_scan_reserved_mem(unsigned long node, const char *uname,
-					  int depth, void *data)
+static int __init fdt_scan_reserved_mem(void)
 {
-	static int found;
-	int err;
-
-	if (!found && depth == 1 && strcmp(uname, "reserved-memory") == 0) {
-		if (__reserved_mem_check_root(node) != 0) {
-			pr_err("Reserved memory: unsupported node format, ignoring\n");
-			/* break scan */
-			return 1;
-		}
-		found = 1;
-		/* scan next node */
-		return 0;
-	} else if (!found) {
-		/* scan next node */
-		return 0;
-	} else if (found && depth < 2) {
-		/* scanning of /reserved-memory has been finished */
-		return 1;
+	int node, child;
+	const void *fdt = initial_boot_params;
+
+	node = fdt_path_offset(fdt, "/reserved-memory");
+	if (node < 0)
+		return -ENODEV;
+
+	if (__reserved_mem_check_root(node) != 0) {
+		pr_err("Reserved memory: unsupported node format, ignoring\n");
+		return -EINVAL;
 	}
 
-	if (!of_fdt_device_is_available(initial_boot_params, node))
-		return 0;
+	fdt_for_each_subnode(child, fdt, node) {
+		const char *uname;
+		int err;
 
-	err = __reserved_mem_reserve_reg(node, uname);
-	if (err == -ENOENT && of_get_flat_dt_prop(node, "size", NULL))
-		fdt_reserved_mem_save_node(node, uname, 0, 0);
+		if (!of_fdt_device_is_available(fdt, child))
+			continue;
 
-	/* scan next node */
+		uname = fdt_get_name(fdt, child, NULL);
+
+		err = __reserved_mem_reserve_reg(child, uname);
+		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL))
+			fdt_reserved_mem_save_node(child, uname, 0, 0);
+	}
 	return 0;
 }
 
@@ -645,7 +641,7 @@ void __init early_init_fdt_scan_reserved_mem(void)
 		early_init_dt_reserve_memory_arch(base, size, false);
 	}
 
-	of_scan_flat_dt(__fdt_scan_reserved_mem, NULL);
+	fdt_scan_reserved_mem();
 	fdt_init_reserved_mem();
 	fdt_reserve_elfcorehdr();
 }
-- 
2.32.0

