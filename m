Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4598E31D20E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 22:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhBPV1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 16:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhBPV1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 16:27:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2093C061786;
        Tue, 16 Feb 2021 13:27:08 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v7so15030594wrr.12;
        Tue, 16 Feb 2021 13:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GDofa5l7P6G0aPshCRUpeDnHopahisIJ3Z8CdpNi7O8=;
        b=EaxJ5CEL06ZrL7LAe9TlR5b7kiHOmU47EzQvPcKa8nlwaykJh4kgBLOjTIto8Tew0W
         pagLkvyl6VZhgjag9+87+Y8R6iT4r8gRzCuBW3o6Vzpft9KaiXAucNkkuZGy+JDZbLSu
         kUn99XJUjerF7D+DzNPnHRjbIizQXwettsJ+CAySvhup+TiQEQhj8AlXHL+ikuDN8ZAC
         JGLKxMpc0UlK1j8yVLDBnaa5CmPqHtDJBgnbQoqM54N2LyMtS5B8dW/4niQWyO6BDKW3
         1i/r6ShckSkNS+FC9WMI6ab3O0jK2tpVfpDfj6tG+L1eIrOovjWjo1LqBhzJmdgl3J0Y
         KSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GDofa5l7P6G0aPshCRUpeDnHopahisIJ3Z8CdpNi7O8=;
        b=p83p8E0Pm8N5gOaMnv3crZmcqU/+5ssbEEdP4RFIL7MQfgWevYDLw5u3R8QKHYoHrV
         JP5UVzpOICopVg1FvgVZqrb0ZrDg9gGl41Qh9GK6YRwL5BuVxjUr4sdEgY8dPO6viY8n
         +7KLfwyKs1Rrb0J1OZONSMvNOsmHLfUbgFmNBANOiJ3qG6rUPAs/u7EsjA7KHNclZjwy
         8nH9N9DbNus/3Df46jBjlsGZ8t3lTes8qeQ4UBOGNi55b1c4cX41N4bQBSrLgFi9cWag
         uksffI0DIOuggG0MqTcKjxv90yYTOLLIMilL1RgqIy6b8xhU3KV0erG0trf/KyU8vVPh
         imkA==
X-Gm-Message-State: AOAM531emvnQ3NyJf3dcwZVu0aa0VkwMcF2bYGg3f8YGfzlKSeS6O6OV
        qd3g6re0rLlAJjky0J/N6uQ=
X-Google-Smtp-Source: ABdhPJxGN5rFGltSfdK4JsTkjNuZGmY97moou1E5YYGCHexloAkgXNVPxE6lGC8yljZHXMBTwjXI8g==
X-Received: by 2002:adf:bbca:: with SMTP id z10mr25753146wrg.168.1613510827298;
        Tue, 16 Feb 2021 13:27:07 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-6-252-11.retail.telecomitalia.it. [87.6.252.11])
        by smtp.googlemail.com with ESMTPSA id s14sm7132182wmj.23.2021.02.16.13.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 13:27:07 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mtd: core: add nvmem-partitions compatible to parse mtd as nvmem cells
Date:   Tue, 16 Feb 2021 22:26:27 +0100
Message-Id: <20210216212638.28382-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216212638.28382-1-ansuelsmth@gmail.com>
References: <20210216212638.28382-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Partitions that contains the nvmem-partitions compatible will register
their direct subonodes as nvmem cells and the node will be treated as a
nvmem provider.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/mtd/mtdcore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 2d6423d89a17..29d257678a86 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -531,6 +531,7 @@ static int mtd_nvmem_reg_read(void *priv, unsigned int offset,
 
 static int mtd_nvmem_add(struct mtd_info *mtd)
 {
+	struct device_node *node = mtd_get_of_node(mtd);
 	struct nvmem_config config = {};
 
 	config.id = -1;
@@ -543,7 +544,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	config.stride = 1;
 	config.read_only = true;
 	config.root_only = true;
-	config.no_of_node = true;
+	config.no_of_node = !of_device_is_compatible(node, "nvmem-partitions");
 	config.priv = mtd;
 
 	mtd->nvmem = nvmem_register(&config);
-- 
2.30.0

