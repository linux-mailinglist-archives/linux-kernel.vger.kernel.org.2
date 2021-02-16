Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A5831D14C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 20:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhBPT50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 14:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhBPT5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 14:57:21 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9795AC0613D6;
        Tue, 16 Feb 2021 11:56:40 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r17so7208885edy.10;
        Tue, 16 Feb 2021 11:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mw6ldDIPHpBoRiawt77fVDG0nsr8XAXcGyvERLsKDMI=;
        b=WNV44HZOqaFZg53RT5bumXB0KIrzTa2Ev0n48Gmus92+TJdTVGCELuURUgNnK9O2vR
         QMaFPp7wxhHiQHg+5LpwhwultmDctvh9kluFmwKchw/bkYkiIfuPigkCkfmFLL/ATxe0
         K8PkhahyiBJwdpTuJqEvD+bLLGEI+bzeTkmGh24Zotd222GcExLUYgxd9zRTl+UBelej
         clMLDJLBGi2YworI/1V5ECosVo5/2CoHumuYV4KMbSru2Zfs3KciFFLw1U8P6qIb+700
         HAvAzN3y2tM1uuD7qK+/mTZ6bf9IToQpWr+sirILq8fqTy8yGt6GNdSe8QNChaGlExCx
         32vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mw6ldDIPHpBoRiawt77fVDG0nsr8XAXcGyvERLsKDMI=;
        b=fy7MGjnTdVeSU0Roy6HbAYnkcxnl9GZM++k1ruFAV7had0ak83MnwJkp/XqfVa60z7
         Y6uW8AmmRYSLDwamyL3tymJ8rX2t6kQDJIDU/+ZxPRxO4QFscygLDBwp55XJNhx3BPDK
         Mapgs9CkhkdM+5cB1/nbEdeaAwPBNxFyJnGvR7yrwZYgUgMoE3hMclMrnYyQUJKgrenb
         p3xrQke41XgIu/NSzlfz/cxXMaHZzY8aj1XvcHkd6UcHpqfKJf57UgZPpWL5cngLGDr/
         P1u06TVZj/bsJt1i9/W2W7SPyI1jrGMuqGcdxYg7AnyPClZ9HtQpI2gC1qrWgyWCKyd7
         0CMg==
X-Gm-Message-State: AOAM530lWQIEh9PHTYni8CSgjcdkJfKn/stlfyBxMBRuEq7/SIzHi/Tr
        5gpOLQ9JtCBzYObwz0FExBQ=
X-Google-Smtp-Source: ABdhPJyIx+qTiJArsI17Ha4K46SPsv9hT71NBkwO40EDIk2uD2lO4V5LCEvO156XrnhIQSawajuD8Q==
X-Received: by 2002:a05:6402:d:: with SMTP id d13mr22982687edu.274.1613505399220;
        Tue, 16 Feb 2021 11:56:39 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-6-252-11.retail.telecomitalia.it. [87.6.252.11])
        by smtp.googlemail.com with ESMTPSA id rh22sm963332ejb.105.2021.02.16.11.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 11:56:38 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mtd: core: add nvmem-partitions compatible to parse mtd as nvmem cells
Date:   Tue, 16 Feb 2021 20:56:10 +0100
Message-Id: <20210216195618.27959-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216195618.27959-1-ansuelsmth@gmail.com>
References: <20210216195618.27959-1-ansuelsmth@gmail.com>
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
 drivers/mtd/mtdcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 2d6423d89a17..2a40b00ec3d0 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -543,7 +543,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	config.stride = 1;
 	config.read_only = true;
 	config.root_only = true;
-	config.no_of_node = true;
+	config.no_of_node = !of_device_is_compatible(node, "nvmem-partitions");
 	config.priv = mtd;
 
 	mtd->nvmem = nvmem_register(&config);
-- 
2.30.0

