Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB1936603D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 21:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhDTTca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 15:32:30 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:27197 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbhDTTc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 15:32:28 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d34 with ME
        id v7Xu2400321Fzsu037XufV; Tue, 20 Apr 2021 21:31:55 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 20 Apr 2021 21:31:55 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        ckeepax@opensource.cirrus.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] regulator: Avoid a double 'of_node_get' in 'regulator_of_get_init_node()'
Date:   Tue, 20 Apr 2021 21:31:51 +0200
Message-Id: <a79f0068812b89ff412d572a1171f22109c24132.1618947049.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'for_each_available_child_of_node()' already performs an 'of_node_get()'
on child, so there is no need to perform another one before returning.
Otherwise, a double 'get' is performed and a resource may never be
released.

Fixes: 925c85e21ed8 ("regulator: Factor out location of init data OF node")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Untested, speculative patch
---
 drivers/regulator/of_regulator.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 564f928eb1db..49f6c05fee34 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -422,7 +422,11 @@ device_node *regulator_of_get_init_node(struct device *dev,
 
 		if (!strcmp(desc->of_match, name)) {
 			of_node_put(search);
-			return of_node_get(child);
+			/*
+			 * 'of_node_get(child)' is already performed by the
+			 * for_each loop.
+			 */
+			return child;
 		}
 	}
 
-- 
2.27.0

