Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377A13660AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbhDTUN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:13:27 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:23941 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbhDTUN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:13:26 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d34 with ME
        id v8Cr2400g21Fzsu038Cs7N; Tue, 20 Apr 2021 22:12:53 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 20 Apr 2021 22:12:53 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     srinivas.kandagatla@linaro.org, bgolaszewski@baylibre.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] nvmem: core: add a missing of_node_put
Date:   Tue, 20 Apr 2021 22:12:50 +0200
Message-Id: <2ebc18d9da622afe8681c18349b501a516253041.1618949512.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'for_each_child_of_node' performs an of_node_get on each iteration, so a
return from the middle of the loop requires an of_node_put.

Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/nvmem/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bca671ff4e54..4375e52ba6c2 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -686,12 +686,15 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
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
 		cell->np = of_node_get(child);
@@ -717,6 +720,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 			kfree_const(cell->name);
 			of_node_put(cell->np);
 			kfree(cell);
+			of_node_put(child);
 			return -EINVAL;
 		}
 
-- 
2.27.0

