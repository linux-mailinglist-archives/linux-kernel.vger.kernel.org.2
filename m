Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5847B39C9ED
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 18:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFEQzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 12:55:41 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:29848 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhFEQzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 12:55:39 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d06 with ME
        id DUto2500721Fzsu03Uto4N; Sat, 05 Jun 2021 18:53:50 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 05 Jun 2021 18:53:50 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        mihai.carabas@oracle.com, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, yuehaibing@huawei.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] misc/pvpanic: Remove some dead-code
Date:   Sat,  5 Jun 2021 18:53:47 +0200
Message-Id: <8e425618f4042a8ab8366be4d34026972e77bd40.1622911768.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'pvpanic_remove()' is referenced only by a 'devm_add_action_or_reset()'
call in 'devm_pvpanic_probe()'. So, we know that its parameter is non-NULL.

Axe the unneeded check to save a few lines of code.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/pvpanic/pvpanic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 82770a088d62..02b807c788c9 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -66,9 +66,6 @@ static void pvpanic_remove(void *param)
 	struct pvpanic_instance *pi_cur, *pi_next;
 	struct pvpanic_instance *pi = param;
 
-	if (!pi)
-		return;
-
 	spin_lock(&pvpanic_lock);
 	list_for_each_entry_safe(pi_cur, pi_next, &pvpanic_list, list) {
 		if (pi_cur == pi) {
-- 
2.30.2

