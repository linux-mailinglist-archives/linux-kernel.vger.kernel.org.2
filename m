Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED40334979
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhCJVIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCJVIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:08:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018DBC061574;
        Wed, 10 Mar 2021 13:08:18 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h10so30272879edl.6;
        Wed, 10 Mar 2021 13:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AIJvF8THgvNIIJY7o0rd8q2CMHcgDSy7Mtu5dW42sFA=;
        b=umQzLk1D4vOPawFEM+6Bx3PxwJApV0E7LygvKxasJpi52Qw3p2EYwicmAlbI0g+Vg3
         y58xizwMSWcaZPHR7g7knAAxcj/hIbCwrJsvi82O+QNAkQMvqftagYxKkVrPrkjmM3PI
         IY+GlG1Dqwhf5kK82lnIIy3iXbbi53PDB+y3jKGmbvlqcYyQcXMgUztJe4gJ1noJymx9
         NuA+6G8211wycYqP8xbhIAZqy4hdzzKPkKmkCoTfmxQy2UxBLPz274sSnfCbqcoPnkdR
         LOD03K8nILIjKsOiLplbth0D7h98pUMLeOM+DbJSzh7CfN2BWVkI/lZ6RJ8Zl+25e3c7
         zR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AIJvF8THgvNIIJY7o0rd8q2CMHcgDSy7Mtu5dW42sFA=;
        b=kfAFSX3L309Cm8cbhtj0/tyzF4GA23AFCzrqaELfQ/sF/51DrKI4sObrrcjpu67DJP
         8hf2pnxoetSNI7HSq87YxK1hKelofUhLSLqTBuwHwb1yd53yEF5UJpM16BLXVU3LDSTP
         bl1ikePitZXXVWh/xfT50ieh3rERI7RguIkr3KpKbdVHPoE3Vj4SA0cwICxaAAl7b73V
         LYGhRaLPcl9SaC6LqbrFIVcf9oemz/3LotXmJlPS2RIb+RgZYwfi3hAofc4igyRmhCHV
         kCn+wugDIwPCi97CWAypD2NoFzswc5KqgAs4qdlPA66IiUZtI5F+kHQcXHgXroM+VAPj
         0lwQ==
X-Gm-Message-State: AOAM530NDI5JMdL+7mlkjxuaxr4PjrXU4xlY4FAfpTEqV3OKsAydI6Al
        AMhNJdUojLtAVfDWFxu8zAPzxIMbjPE=
X-Google-Smtp-Source: ABdhPJzU2FKDHG79f7UQcw8tVg/BBne3N8m2R28TmD5twNF6xyfuOyV9hbeGnPjwNgUSx0tUPGrJzQ==
X-Received: by 2002:a05:6402:46:: with SMTP id f6mr5398960edu.252.1615410496484;
        Wed, 10 Mar 2021 13:08:16 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id f19sm252947edu.12.2021.03.10.13.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:08:16 -0800 (PST)
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
Subject: [PATCH v4 1/3] mtd: core: add nvmem-cells compatible to parse mtd as nvmem cells
Date:   Wed, 10 Mar 2021 22:08:01 +0100
Message-Id: <20210310210812.8880-1-ansuelsmth@gmail.com>
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

