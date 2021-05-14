Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2FF3804DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhENIJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:09:16 -0400
Received: from m12-18.163.com ([220.181.12.18]:42508 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229654AbhENIJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zYCG5
        CpxuiTgMWEA6okG6eEiJi2EYg+gmO5+2lhKN0k=; b=fj/tOitB876jZaNX0NeO4
        I//mD66/7EikFIYwSAc9FVkMB6uqFxlxiqcDIrZA98VdR5Z0Sc9hJrTsuteVOZkg
        GAc0zHKYyRQeunFbswJKpvLQWRlb/YRbnJuaMMk74B9RhCLEGOWygPBdsu/pGXbq
        8Z8Qj6ff0bxuEDd94zk5p0=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowACHhcW+L55glSp1jQ--.18625S2;
        Fri, 14 May 2021 16:07:29 +0800 (CST)
From:   dingsenjie@163.com
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        dingsenjie <dingsenjie@yulong.com>
Subject: [PATCH v2] mtd: devices: Remove superfluous "break"
Date:   Fri, 14 May 2021 16:06:43 +0800
Message-Id: <20210514080643.21760-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowACHhcW+L55glSp1jQ--.18625S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU78nYUUUUU
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/xtbBRQGSyFPALw2s9AAAs3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dingsenjie <dingsenjie@yulong.com>

Remove superfluous "break", as there is a "return" before it.

Signed-off-by: Ding Senjie <dingsenjie@yulong.com>
---
 drivers/mtd/devices/ms02-nv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/devices/ms02-nv.c b/drivers/mtd/devices/ms02-nv.c
index fb4a6aa..08f76ff 100644
--- a/drivers/mtd/devices/ms02-nv.c
+++ b/drivers/mtd/devices/ms02-nv.c
@@ -286,7 +286,6 @@ static int __init ms02nv_init(void)
 		break;
 	default:
 		return -ENODEV;
-		break;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(ms02nv_addrs); i++)
-- 
1.9.1


