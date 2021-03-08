Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2F633188F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhCHU2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhCHU2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:28:16 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F34C06174A;
        Mon,  8 Mar 2021 12:28:16 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id mj10so22980245ejb.5;
        Mon, 08 Mar 2021 12:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NvadRTyAu2bEatgntz1xTlD/+6CQIU+QXTtOxiL9MKw=;
        b=R3qxIbr3UgiLtn1YDTg5ZL8C8NoVeG7eQEpYzYraQxiKyZe2CHRiTFdOtgslbKG14I
         Rc7r70128QSamfdv/gH3JQD3ywkUVtx/0oVjqrIc9yWNGsWnpz5Ro7bxeyKu3IOUhdGC
         Cz5cqDqK+f+rgF7Fj70uwi6pfNNX9Ha56x6BC21Nh306ahrPzn0X/M1iRwMaTOghIdNU
         4dznjLtyuOBDVeQP0Dwy0PDnhrvMwANGp1jYWxviTIsfe1NB8HXxYdIPo3JCWFn0BNMZ
         pB85XeWez9+7apPn9IzxJoR0FcJpMWZG4OxoJ08QeftPfz7DXyqrzMRcUAcRq5S+k0Ye
         6drQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NvadRTyAu2bEatgntz1xTlD/+6CQIU+QXTtOxiL9MKw=;
        b=cw79Yb36nOIZwDa2ms0swKOmB6VUV/JtM8k1Lyq4m9pTv11M8VAGjZ3w/nRSL9Jpt9
         nT8/aOP01HJZyc58bCV7ecyaKEnnfgW6exUgEWOf9YL+PGiZ5SXq5FcroYGOAR+d8kZs
         d1fC1hq0hxQ2HcX+N5stvQsWDtPPyjfksbLuqjuXlhAeWTw4uBJFRVTUWWg8SjbC7Vn0
         G7VrEpSG1Gm0OHL2bpLZSw9k35PmpZCkwCrIGAc6j1pYUNqFiIKFgEYrz9gCB0YnNV8q
         BEtTpnzNdPuXFgvGo/ro64grHeBMcqu7cy1/XOT1qbmUuxLRdG6LIR+xYS4AdgZQRP9Q
         swmQ==
X-Gm-Message-State: AOAM532EHkiCIIsln5waFxntSX+Tbn3Oz8xAaJsj+j+XR0n8iKbXK6rS
        01ZeoYIEZT2qgcuyN5fglIg=
X-Google-Smtp-Source: ABdhPJxpY0jUBKzaAkFqi8ozlLFtpXzb8704Bf70GDoclXb/s+d9vZUg1OIVmD1Q282elH1zahm1RQ==
X-Received: by 2002:a17:906:2db2:: with SMTP id g18mr17131388eji.73.1615235294986;
        Mon, 08 Mar 2021 12:28:14 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-95-247-48-130.retail.telecomitalia.it. [95.247.48.130])
        by smtp.googlemail.com with ESMTPSA id c18sm7624483edu.20.2021.03.08.12.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:28:14 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mtd: core: add nvmem-cells compatible to parse mtd as nvmem cells
Date:   Mon,  8 Mar 2021 02:18:44 +0100
Message-Id: <20210308011853.19360-1-ansuelsmth@gmail.com>
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
Depends on [PATCH] mtd: parsers: ofpart: limit parsing of deprecated DT syntax
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

