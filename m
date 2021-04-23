Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C2C3695B0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhDWPKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:10:15 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:20479 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhDWPKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:10:09 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d51 with ME
        id wF9W2400q21Fzsu03F9X4c; Fri, 23 Apr 2021 17:09:32 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Apr 2021 17:09:32 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, rppt@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] openrisc: Fix a memory leak
Date:   Fri, 23 Apr 2021 17:09:28 +0200
Message-Id: <c078439e31fd60e1617be8c17cc1ec57639e0586.1619190470.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'setup_find_cpu_node()' take a reference on the node it returns.
This reference must be decremented when not needed anymore, or there will
be a leak.

Add the missing 'of_node_put(cpu)'.

Note that 'setup_cpuinfo()' that also calls this function already has a
correct 'of_node_put(cpu)' at its end.

Fixes: 9d02a4283e9c ("OpenRISC: Boot code")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/openrisc/kernel/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 2416a9f91533..c6f9e7b9f7cb 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -278,6 +278,8 @@ void calibrate_delay(void)
 	pr_cont("%lu.%02lu BogoMIPS (lpj=%lu)\n",
 		loops_per_jiffy / (500000 / HZ),
 		(loops_per_jiffy / (5000 / HZ)) % 100, loops_per_jiffy);
+
+	of_node_put(cpu);
 }
 
 void __init setup_arch(char **cmdline_p)
-- 
2.27.0

