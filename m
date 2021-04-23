Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394683694EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbhDWOlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:41:18 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:25152 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhDWOlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:41:18 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d51 with ME
        id wEgd2400J21Fzsu03EgdTu; Fri, 23 Apr 2021 16:40:40 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Apr 2021 16:40:40 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
        gustavoars@kernel.org, robh@kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] powerpc: Fix a memory leak in error handling paths
Date:   Fri, 23 Apr 2021 16:40:35 +0200
Message-Id: <f2186955f310494f10990b5c402ada164d7834b8.1619188632.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we exit the for_each_of_cpu_node loop early, the reference on the
current node must be decremented, otherwise there is a leak.

Fixes: a94fe366340a ("powerpc: use for_each_of_cpu_node iterator")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Strangely, the commit above added the needed of_node_put in one place but
missed 2 other places!
This is strange, so maybe I misunderstand something. Review carefully
---
 arch/powerpc/platforms/powermac/feature.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 5c77b9a24c0e..e612222f7d2e 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -1060,6 +1060,7 @@ core99_reset_cpu(struct device_node *node, long param, long value)
 			continue;
 		if (param == *num) {
 			reset_io = *rst;
+			of_node_put(np);
 			break;
 		}
 	}
@@ -1506,6 +1507,7 @@ static long g5_reset_cpu(struct device_node *node, long param, long value)
 			continue;
 		if (param == *num) {
 			reset_io = *rst;
+			of_node_put(np);
 			break;
 		}
 	}
-- 
2.27.0

