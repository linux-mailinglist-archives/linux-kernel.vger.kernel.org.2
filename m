Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089FC337A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCKRDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhCKRDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:03:42 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2076C061574;
        Thu, 11 Mar 2021 09:03:41 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h13so3861059eds.5;
        Thu, 11 Mar 2021 09:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AIJvF8THgvNIIJY7o0rd8q2CMHcgDSy7Mtu5dW42sFA=;
        b=oHvYAKs8vlQsGGeTCxnbGmFJRdubhK9l9eDvFETPrXX9cQ7MlU5fEAM0qMn1C7xchN
         YohhK3VVAFGYyqcR46GscrLSOwBqOC8DGU5uTlA+Vpc61R9ZoDyWxwVXvAqzNq2+eoNb
         VMsGujlugvf1G0oOs6vCypmtB9xIQqYp6W3J+kjg2Sayn6B9fqAMdNasJiN5TuCCSjM/
         JB3nztXsccELBZkyeuy3Z3uH8hBl/ALzgqBPPilDUFOd5dmSxnP17KKDRcMG9jw5cMBF
         jb8CogOCyTD0cSSO1m+s/g4DzFYtm3m4su1yk3a6ZqdMIKH5pzI3Hfxle3x9ihR0Tajz
         enfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AIJvF8THgvNIIJY7o0rd8q2CMHcgDSy7Mtu5dW42sFA=;
        b=Cbl2wNLYqq5hD9rHML52rANCM5y/bsd0ycj1wCm6kNjkK8vhaC1mdKmeLC8q47WwI+
         G+NLICPEdXweu8r4Trn00KZBYjPBwX5pna8DMbqCJMrUyLGqUSio5X5viurq6blzpAsi
         E4mA6NgZPMyzi4XFHz9pn1YNlenxbSnD9ayHbyfG7l9tMwZ6GAnBUGBPjRE/f+Mq/QZM
         xYeVmm4ENYPczWLgP5r5kUeW0ZC1nOaty9tIKHY/dtvZTPbo/sWI115ikRHfZWu3CUaJ
         BiALiLfVJr7XTwc+4lXFxKrm3o4AwPsTt6mjKN7RONkmJmrjwBEiPfCnh51gt+064J+7
         JG0g==
X-Gm-Message-State: AOAM530dsRWjBVGZK9mBNgZ5Zbb+dGThD8WQT7qofPdMbg4PTeKSdXuF
        Gz7Ld+P3DjOJIW9fqrDiiyo=
X-Google-Smtp-Source: ABdhPJwETXnVswKC4ZC4+FSyf5TAqqX9vnXmWFxa0O9LzcMWBXQwYxWCRSqufx1WJgXXxc52XIj3Aw==
X-Received: by 2002:a05:6402:1004:: with SMTP id c4mr9610447edu.364.1615482220575;
        Thu, 11 Mar 2021 09:03:40 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id b4sm1627205edh.40.2021.03.11.09.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:03:40 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] mtd: core: add nvmem-cells compatible to parse mtd as nvmem cells
Date:   Thu, 11 Mar 2021 10:56:58 +0100
Message-Id: <20210311095715.17048-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Partitions that contains the nvmem-cells compatible will register
their direct subonodes as nvmem cells and the node will be treated as a
nvmem provider.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/mtd/mtdcore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 2d6423d89a17..ac1b4f176a17 100644
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
+	config.no_of_node = !of_device_is_compatible(node, "nvmem-cells");
 	config.priv = mtd;
 
 	mtd->nvmem = nvmem_register(&config);
-- 
2.30.0

