Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C8033724B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhCKMTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbhCKMTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:19:47 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B10AC061574;
        Thu, 11 Mar 2021 04:19:47 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o19so2438572edc.3;
        Thu, 11 Mar 2021 04:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AIJvF8THgvNIIJY7o0rd8q2CMHcgDSy7Mtu5dW42sFA=;
        b=A19s8+jcTYLYpRsTm88vI1YTqVcVLHEihep/7ZY6UKdqCHWbLvtkAlSJH+ioQtAGT3
         kMC0ktX5vY5B9g/NbCbtFtostd/bOd9CNm2niBhWsLdZVVchgJsCRjjQVIz/Ns7t9lOA
         1EwZCUL6g9JBywi5pfxET3aZRozHxgndsfPi5RPH1oENyXJNo8F3RNooDluSJdYbq/L/
         XnsIiFPDIBmP/Vd3CaZgpaBALxGBNcbU/xlvhG13bJaLC895HqtDVGgm3LkJoEKNZ1GP
         BMrMERCqSiEvoR0+gtEVhhPkT7KwU2Eg3Dr7YIS8NoLmZfu+u45bKCgKpOgXOHJo0BLz
         E19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AIJvF8THgvNIIJY7o0rd8q2CMHcgDSy7Mtu5dW42sFA=;
        b=A1yd58UDVMqSRMQvDCEzpMJE5e0Pau1Ac4tqqxNC8LRCiOLLju3xCVZyKIHg3Pa1Un
         KwSJqcFfPGWMk0PvpfY+xcz44j5uIcS2Bf6YxMwZ755+KIpGwOXpv0IlfRLD+Xfv9Qe4
         20PTs0o1TJJ86Xlsv5KBrAJHVMeQwxySSW1a2jTEmmyq7cKnCqAvRGhZs+Vq19tndduc
         GrTdwfi6rRfDHQ6y/ebvaqhSl6SrZPTR7fNlHm2l2P3E+oMIILrbnLfpBcSSwIReeX+q
         YuRWuWWs+Y43/jXg7c+x4SsjxfjJePREUHVVK5sYBbzum13ry0QsjUjMUL7Pzn8GvC8K
         OAmQ==
X-Gm-Message-State: AOAM5326BHR9l/CQYtMgKGeq2n218NhOZaYNK/fRqO3FLmZHPCqfMMy6
        lvvo1DaxlEWoBJj/n8zlCa8=
X-Google-Smtp-Source: ABdhPJwhxUYujpvYF+ZFXc/c5AA8Ze9yPl1neq05v/Fn2/yyq/4oZ00TbhKSx6vBEzMJaZG9V9Jg0g==
X-Received: by 2002:aa7:c9c8:: with SMTP id i8mr8096195edt.193.1615465185761;
        Thu, 11 Mar 2021 04:19:45 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id c7sm1273748edk.50.2021.03.11.04.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 04:19:45 -0800 (PST)
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
Subject: [PATCH v5 1/3] mtd: core: add nvmem-cells compatible to parse mtd as nvmem cells
Date:   Thu, 11 Mar 2021 06:12:47 +0100
Message-Id: <20210311051309.16789-1-ansuelsmth@gmail.com>
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

