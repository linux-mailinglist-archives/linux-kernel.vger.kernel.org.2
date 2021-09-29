Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3D241C494
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343609AbhI2MSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:18:46 -0400
Received: from smtp181.sjtu.edu.cn ([202.120.2.181]:44758 "EHLO
        smtp181.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343797AbhI2MSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:18:15 -0400
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp181.sjtu.edu.cn (Postfix) with ESMTPS id 1BD701008CBC1;
        Wed, 29 Sep 2021 20:16:32 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id 03F25200B5751;
        Wed, 29 Sep 2021 20:16:32 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cjxdomTFHRWG; Wed, 29 Sep 2021 20:16:31 +0800 (CST)
Received: from guozhi-ipads.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: qtxuning1999@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id 17801200B574E;
        Wed, 29 Sep 2021 20:16:25 +0800 (CST)
From:   Guo Zhi <qtxuning1999@sjtu.edu.cn>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Guo Zhi <qtxuning1999@sjtu.edu.cn>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/ata: Fix kernel pointer leak
Date:   Wed, 29 Sep 2021 20:16:17 +0800
Message-Id: <20210929121618.1157415-1-qtxuning1999@sjtu.edu.cn>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should be printed with %p or %px rather than cast to
'unsigned long' and pinted with %lx
Change %lx to %p to print the secured pointer.

Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
---
 drivers/ata/pata_atp867x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
index 2bc5fc81efe3..c32b95f48e50 100644
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -447,11 +447,11 @@ static int atp867x_ata_pci_sff_init_host(struct ata_host *host)
 #ifdef	ATP867X_DEBUG
 		atp867x_check_ports(ap, i);
 #endif
-		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx",
-			(unsigned long)ioaddr->cmd_addr,
-			(unsigned long)ioaddr->ctl_addr);
-		ata_port_desc(ap, "bmdma 0x%lx",
-			(unsigned long)ioaddr->bmdma_addr);
+		ata_port_desc(ap, "cmd 0x%p ctl 0x%p",
+			ioaddr->cmd_addr,
+			ioaddr->ctl_addr);
+		ata_port_desc(ap, "bmdma 0x%p",
+			ioaddr->bmdma_addr);
 
 		mask |= 1 << i;
 	}
-- 
2.33.0

