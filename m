Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC81C3B2730
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 08:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhFXGMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 02:12:55 -0400
Received: from m12-14.163.com ([220.181.12.14]:41283 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230257AbhFXGMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 02:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=w0RGP
        Dx8u1KxAzw38S0sE4Ewiae0n6tCu9YvWBr7xbI=; b=eqXhr1ikZTHuTMBERjx0P
        vQeulZdk+IJ/CMD4MuU2vJxso63oohfQWurIPsr7o9TDHLtCT/pt8YtCeu7csD1s
        QHcsMixSYPR451MlT0LGoZcTaNHGwDJKGQVhAb3BfL9hlysXSbRcPIytPnV0kHJN
        5/vfBvZO8eaIYulKWMtnSg=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp10 (Coremail) with SMTP id DsCowAAHCBTUIdRgfjQZQg--.40119S2;
        Thu, 24 Jun 2021 14:10:29 +0800 (CST)
From:   13145886936@163.com
To:     jesper.nilsson@axis.com, lars.persson@axis.com
Cc:     linux-arm-kernel@axis.com, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] arm: artpec: remove unneeded semicolon
Date:   Wed, 23 Jun 2021 23:10:27 -0700
Message-Id: <20210624061027.25976-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAAHCBTUIdRgfjQZQg--.40119S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF18AFy5Aw48Xw4kXr45trb_yoW3JFb_u3
        yfK397GrZ5AF40v3W5G393XF12y3yrWF1qgFyDJF1rJw1rur1Ik3s0kF4S9r17Xry2krW3
        Ja92yry5K3W3tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5eHq3UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/xtbBzhW7g1QHNAH4qQAAsU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Remove unneeded semicolon.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 arch/arm/mach-artpec/board-artpec6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-artpec/board-artpec6.c b/arch/arm/mach-artpec/board-artpec6.c
index d3cf3e8603e8..c27e7bbcd7bc 100644
--- a/arch/arm/mach-artpec/board-artpec6.c
+++ b/arch/arm/mach-artpec/board-artpec6.c
@@ -39,7 +39,7 @@ static void __init artpec6_init_machine(void)
 		 */
 		regmap_write(regmap, ARTPEC6_DMACFG_REGNUM,
 			     ARTPEC6_DMACFG_UARTS_BURST);
-	};
+	}
 }
 
 static void artpec6_l2c310_write_sec(unsigned long val, unsigned reg)
-- 
2.25.1

