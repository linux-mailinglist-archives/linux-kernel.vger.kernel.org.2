Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DD444FEB4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 07:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhKOGja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 01:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhKOGi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 01:38:58 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDBEC061746;
        Sun, 14 Nov 2021 22:36:01 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id n23so13665837pgh.8;
        Sun, 14 Nov 2021 22:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LGML58GFy0MHgu4LbS5NH+OKV7G6tLA4Z3al0L54dBk=;
        b=WPn7/dWIkdk+iDNmqtQ0YHx39pk3IqG0x8zI7f5jY0ZHeOUQR8l1tjgcC7DDCgEanS
         aLLawTozgBMFSIgcDaROGoLxVEXvKIOoWpT/TJmEBaqL2nV6Rv+5Jg0sp07nPGo3KWGs
         WU1xH0Te5nCh8zo6SBViSdn9njAP21xBjwWn5VyYDFqpL1EcxWmJgnzvEC82+FQAqcQT
         7hPtIOGuqHCPVOA7ONeCx688fwPLEDHSLIRnIqMy2hFxw0BbZZhIAP5PYvg6IA1aB5+5
         vFQzgz272ku/Dqq0M1Hs/Jfk0+6mvbP9NNyNTXPSZj9e8szZGc8tzirWVn7L6HfTdpxl
         hJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LGML58GFy0MHgu4LbS5NH+OKV7G6tLA4Z3al0L54dBk=;
        b=3uQmYXuHTrJ352gHK52IMd5a+86wErAb9NOwOTymzSWKlWLMABJEcjN4kFv0KsdkyK
         KZUpuCL44ugvZ29fCNzYbLXXiPco2V7cu3JYfFEPaF3tMVliP/gSvKijUtMR5FMGiWuC
         Q9ILFFf3BaSG3kcSQ1Ej7qA/dwZIFiREfy/2OehV6Q6dinVm4CDVqiH3mlS52Fr+X+rN
         NqeD/Qc2AVWhjiU/Wvj3DVTWhwgaTaWdaVBZmlggZ5RNe5YGT5W2AlJsXHNymmadckcb
         x4/KMqfjy40PfaUJUJ0S2ryH7Id/8E9ZzFEekZVU23d7ofQtSgXSCx10jQ1y0eieXDaZ
         sC9A==
X-Gm-Message-State: AOAM531INzwT9YkNIjMVMaxg1XP9EkRrsyelxf7XUQHu2VAERjcXa3tt
        ORJ2GeMZUc2w6bA30bXoJ1Y=
X-Google-Smtp-Source: ABdhPJwHbZnnqt/GZY/Ni85pi7ENBo63KkYKsPk/891+SkoqzL6GNJYZO0+zoFT8or0g89GRpzk2jg==
X-Received: by 2002:a63:91c8:: with SMTP id l191mr22784546pge.404.1636958161247;
        Sun, 14 Nov 2021 22:36:01 -0800 (PST)
Received: from localhost.localdomain ([103.99.179.247])
        by smtp.gmail.com with ESMTPSA id f4sm13411720pfg.34.2021.11.14.22.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 22:36:01 -0800 (PST)
From:   Calvin Zhang <calvinzhang.cool@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Calvin Zhang <calvinzhang.cool@gmail.com>
Subject: [PATCH] of: make MAX_RESERVED_REGIONS configurable
Date:   Mon, 15 Nov 2021 14:35:21 +0800
Message-Id: <20211115063521.3457302-1-calvinzhang.cool@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX_RESERVED_REGIONS has changed several times. Max reserved regions
count grow bigger as more SOC subsystems require reserved regions.

Add a Kconfig for it so that when properly configured, the static
reserved_mem array consumes less memory on systems with few reserved
regions.

Signed-off-by: Calvin Zhang <calvinzhang.cool@gmail.com>
---
 drivers/of/Kconfig           | 10 ++++++++++
 drivers/of/of_reserved_mem.c |  3 +--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 80b5fd44ab1c..591b2c4d9dd0 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -73,6 +73,16 @@ config OF_IRQ
 config OF_RESERVED_MEM
 	def_bool OF_EARLY_FLATTREE
 
+config OF_MAX_RESERVED_REGIONS
+    int "Maximum count of reserved regions"
+    depends on OF_RESERVED_MEM
+    default 64
+    help
+        Reserved regions in /reserved-memory node includes static
+        reservations with fixed location and dynamic ones for device
+        cma regions. This parameter sets the maximum number of reserved
+        regions in the system.
+
 config OF_RESOLVE
 	bool
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 9c0fb962c22b..d90ae4c03011 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -25,8 +25,7 @@
 
 #include "of_private.h"
 
-#define MAX_RESERVED_REGIONS	64
-static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
+static struct reserved_mem reserved_mem[CONFIG_OF_MAX_RESERVED_REGIONS];
 static int reserved_mem_count;
 
 static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
-- 
2.30.2

