Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9F23A3E12
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhFKIgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhFKIgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:36:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17848C0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:33:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q5so5122129wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RvmVslt0E/0jq5g8D5H7ZwTlO7qODZfqfuqR3GxaT68=;
        b=PmInd5pKLsDRmNyajfivXyStSBrigXq30S+tDB7m0vg5PBswjPVVFzNA/Lpi9MNox6
         L/CM66qvm21cU/2LdDNWLivvDBH6Y93cC/bRQDX6wxAH3IT9JuTo59W9BEuL8Dn4oyKH
         LrczPH+aFwyMwN0/N9OESS0pEWaHh9NTD+E/GLY2u0ya+T9gPodRyIFPjZQ7LNjsc9wb
         bdPoOwqQUat9eInRBYYHIHYoZ8dWzYZogMQl3bytxhVtAduVadJ26k8ImzxdZSroTpkV
         /rdRTes/F212JdY0yxrathXoyq/13SftWEYtuosZjL1EmvbHBvruVS1D617GJdvd7oGm
         OCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RvmVslt0E/0jq5g8D5H7ZwTlO7qODZfqfuqR3GxaT68=;
        b=Ky8F/7PCNFnariU7a1Bcmjy6PIkfbgTYATqIKE0VE6Sxqd3lJS+XLQc1wSXZKGmXlC
         gp2PMen799X5AjFVcg3lWLuCVXY0825WmYeZe1fvz++Z6isyHWfNvussv2l0Ey1iI49A
         EEftoxgLgeISwXh1FQY6wBjuuiZLR8XRJbXI72jimqcgzPGwKSpuU88H1AIFy+5OYWdE
         g3mYYzBA13jND4Qhv2BkoEch5j+QYM31RrT9etRXMBYiN4Hg9L/3Zek9TkV0pxWO0tGO
         HQkxJ1YRSTQMzKSH8e8LK8tgV7j+6kbH9k4Oq4UzFSW8WZ4yfWa2K+2tO4TUeWfMolGP
         NvFA==
X-Gm-Message-State: AOAM532yo6WpZHunGadiHmRO7r6/5B2ua6sWTlRr9i/cv3gJTxihTJoU
        KVaF89Kb3XGWwqw0Xb+8ciQky6ibEsr5Kw==
X-Google-Smtp-Source: ABdhPJxfoxJeORL0H6ua9Zb0AiBKmFuzLIE6G0SCaG8fgAnlqE3PxnWjTlQ9LQ9f7jKunLCjZMuixg==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr2760665wrs.298.1623400437740;
        Fri, 11 Jun 2021 01:33:57 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n42sm11547428wms.29.2021.06.11.01.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 01:33:57 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/9] nvmem: core: add a missing of_node_put
Date:   Fri, 11 Jun 2021 09:33:44 +0100
Message-Id: <20210611083348.20170-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

'for_each_child_of_node' performs an of_node_get on each iteration, so a
return from the middle of the loop requires an of_node_put.

Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bca671ff4e54..f9c9c9859919 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -686,15 +686,17 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 			continue;
 		if (len < 2 * sizeof(u32)) {
 			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
+			of_node_put(child);
 			return -EINVAL;
 		}
 
 		cell = kzalloc(sizeof(*cell), GFP_KERNEL);
-		if (!cell)
+		if (!cell) {
+			of_node_put(child);
 			return -ENOMEM;
+		}
 
 		cell->nvmem = nvmem;
-		cell->np = of_node_get(child);
 		cell->offset = be32_to_cpup(addr++);
 		cell->bytes = be32_to_cpup(addr);
 		cell->name = kasprintf(GFP_KERNEL, "%pOFn", child);
@@ -715,11 +717,12 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 				cell->name, nvmem->stride);
 			/* Cells already added will be freed later. */
 			kfree_const(cell->name);
-			of_node_put(cell->np);
 			kfree(cell);
+			of_node_put(child);
 			return -EINVAL;
 		}
 
+		cell->np = of_node_get(child);
 		nvmem_cell_add(cell);
 	}
 
-- 
2.21.0

