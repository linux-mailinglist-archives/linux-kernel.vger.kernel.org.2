Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278803809D6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhENMr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:47:56 -0400
Received: from m12-17.163.com ([220.181.12.17]:46118 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233538AbhENMrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wj8yF
        uvdz6wX3h1KFrBZzeGfyq10Pzv0aY3aYB8oaU4=; b=PR045XLDgCmLFeiECnSts
        1xizUIttOIka/cUesR3qyevM3s+zHcQo5rVDUER3TITC/w+OBvazG7/NOoim51py
        Fo1yrqn57ELYFymS0Z9WYi9JLxCh5j8dVB+ixt4R4bGWcmAYck4WpKbuKQQBv8uF
        r/K1L01UiczLkQ/YdRBxiw=
Received: from COOL-20201222LC.ccdomain.com (unknown [218.94.48.178])
        by smtp13 (Coremail) with SMTP id EcCowAB3f5_dcJ5gnMeM1A--.13288S2;
        Fri, 14 May 2021 20:45:18 +0800 (CST)
From:   dingsenjie@163.com
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ding Senjie <dingsenjie@yulong.com>
Subject: [PATCH v3] mtd: devices: Remove superfluous "break"
Date:   Fri, 14 May 2021 20:44:51 +0800
Message-Id: <20210514124451.20352-1-dingsenjie@163.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAB3f5_dcJ5gnMeM1A--.13288S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7f-PUUUUU
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5glqw25hqmxvi6rwjhhfrp/xtbBRRGSyFPALxMviwAAsF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ding Senjie <dingsenjie@yulong.com>

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


