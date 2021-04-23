Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866833694EC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbhDWOla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:41:30 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:53014 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbhDWOl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:41:27 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d51 with ME
        id wEgp2400d21Fzsu03EgqWK; Fri, 23 Apr 2021 16:40:50 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Apr 2021 16:40:50 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
        gustavoars@kernel.org, robh@kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] powerpc: Save a few lines of code
Date:   Fri, 23 Apr 2021 16:40:48 +0200
Message-Id: <0ff6235a4e2d497e146ce401fa2df71449d290b6.1619188632.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <f2186955f310494f10990b5c402ada164d7834b8.1619188632.git.christophe.jaillet@wanadoo.fr>
References: <f2186955f310494f10990b5c402ada164d7834b8.1619188632.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'arch/powerpc/platforms/powermac/feature.c' triggers many checkpatch.pl
warnings.
The code looks old and not very active, so fixing them all does not make
so much sense and will hide some 'git blame' information.

So only apply a few fixes that save a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/powerpc/platforms/powermac/feature.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index e612222f7d2e..155e8586692e 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -83,8 +83,7 @@ struct macio_chip *macio_find(struct device_node *child, int type)
 }
 EXPORT_SYMBOL_GPL(macio_find);
 
-static const char *macio_names[] =
-{
+static const char *macio_names[] = {
 	"Unknown",
 	"Grand Central",
 	"OHare",
@@ -119,8 +118,7 @@ struct feature_table_entry {
 	feature_call	function;
 };
 
-struct pmac_mb_def
-{
+struct pmac_mb_def {
 	const char*			model_string;
 	const char*			model_name;
 	int				model_id;
@@ -301,11 +299,10 @@ static long ohare_sleep_state(struct device_node *node, long param, long value)
 
 	if ((pmac_mb.board_flags & PMAC_MB_CAN_SLEEP) == 0)
 		return -EPERM;
-	if (value == 1) {
+	if (value == 1)
 		MACIO_BIC(OHARE_FCR, OH_IOBUS_ENABLE);
-	} else if (value == 0) {
+	else if (value == 0)
 		MACIO_BIS(OHARE_FCR, OH_IOBUS_ENABLE);
-	}
 
 	return 0;
 }
@@ -2992,7 +2989,6 @@ void pmac_register_agp_pm(struct pci_dev *bridge,
 	if (bridge != pmac_agp_bridge)
 		return;
 	pmac_agp_suspend = pmac_agp_resume = NULL;
-	return;
 }
 EXPORT_SYMBOL(pmac_register_agp_pm);
 
-- 
2.27.0

