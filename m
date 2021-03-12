Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D264E338D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhCLMov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhCLMoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:44:30 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FACC061574;
        Fri, 12 Mar 2021 04:44:30 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b18so4728403wrn.6;
        Fri, 12 Mar 2021 04:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VI13v7WXCHyV5J1x9UibDqjD7a10mhiWIB5IsHD7pqI=;
        b=o5XPui/gukKRgc7PwBjmedNbk1silTZsSMBrZFwN59+1UnRqSRTHgMrsho3JGLL21s
         1LXij9Esxn7wFm+eYTFhyiQzfwMxisfmrVzm7yr9JrBBVuRni6wuKmkOJ7XcXjCPck99
         YHpI/i2s0vP5B0FVBlI4umrK9GTH5NW5uOQz2XngcxGQSHfob5nye5O/M7dZAhRk0r3W
         hf4rDf7trLqUmXy5acCE/3zMaOIbGvzR863EMS2BKJ1DiBGc66CC47HxCaNhGBOtukgw
         +t1cPmmjvY05uvE/MKWY6E7l/n1qjrSdkY+KHZaGJz0LLMoJ8PJQay5bqGgWCrvJ/kai
         Dn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VI13v7WXCHyV5J1x9UibDqjD7a10mhiWIB5IsHD7pqI=;
        b=pXW5yU//uC1TCIq6UedRrtkBOTtFNUESUrOvRWNxFZwkzNK248R0HEDEb80FWLGBwQ
         dsR5JHZChlTbqjAUYN/HNDvG9Hdc9ZW/Elk+nZHMt4eGMF4LsdRljnXho88/F9pdvWr6
         OL+P5TEO73v1NqErQfbAi8YPXjlqUXSVREQ2nHm4PyIbReidilGvTi8RBtMJ2vOLYX/3
         oC9nVp12OAVlZ4KPkxZ9pQRVzRQZtw0gu8dJMI5KGfybgY+taRbumvI0rcrxQMRrVWsk
         cVtnWgk37cW3Nw8gGNTy4SLjUD4oxF3SY63BTSv30oY9FTPXEPmzCca4msUUTEqnzOf+
         D1Dw==
X-Gm-Message-State: AOAM533urRQCSttacOmkROArlJMDOTRCqQh8HPDCyEHBKKPMwnOsq+xu
        fv9q3zhCW2DR77o/8jlICZOSZUnliXs=
X-Google-Smtp-Source: ABdhPJxM6NNpxowCaT6kxszVSN/rPkxCB9XCQ9dzbhnd8x3OlG4E0ebpRadAVgbmMVBfJ6FPU6/siQ==
X-Received: by 2002:adf:fa08:: with SMTP id m8mr13984426wrr.12.1615553068908;
        Fri, 12 Mar 2021 04:44:28 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id 36sm8213414wrh.94.2021.03.12.04.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 04:44:28 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/3] mtd: core: add nvmem-cells compatible to parse mtd as nvmem cells
Date:   Fri, 12 Mar 2021 07:28:19 +0100
Message-Id: <20210312062830.20548-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Partitions that contains the nvmem-cells compatible will register
their direct subonodes as nvmem cells and the node will be treated as a
nvmem provider.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Rafał Miłecki <rafal@milecki.pl>
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

