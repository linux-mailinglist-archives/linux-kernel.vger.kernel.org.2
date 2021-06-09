Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB5A3A0DDA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhFIHkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:40:12 -0400
Received: from m12-13.163.com ([220.181.12.13]:57935 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhFIHkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5w0iz
        X5VwBuefS4CW+9UqNDwu4o9puDc/xC+lscmSXc=; b=fO0+1yYoHFnxByB51/csR
        3L41OwYLp6VMDJ325nSVi7AuBw4ACgXRpKWKbPuExTZMNjGVqqg3NTs1coxi3rD2
        rc4PGrzlaGQwiLOpRKfW1zxikjT3dXE4gqSUAGx+rxdlFak97G0qNBmC/G0wb5eh
        loO5KnFRAvpm76H10eJacU=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowAD3__veb8BgzQKLFQ--.2842S2;
        Wed, 09 Jun 2021 15:38:07 +0800 (CST)
From:   Jian Xin <xinjian34324@163.com>
To:     dinguyen@kernel.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jian Xin <xinjian@yulong.com>
Subject: [PATCH] clk: socfpga: clk-pll: Remove unused variable 'rc'
Date:   Wed,  9 Jun 2021 15:37:42 +0800
Message-Id: <20210609073742.722911-1-xinjian34324@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAD3__veb8BgzQKLFQ--.2842S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrWDGF1fGF1DAw4xKrW3Jrb_yoWkKFX_uF
        yjg392gw1UGw1rAFWUC3W3Z34vkrs7urZ5XF1293y3Ja4fXryUAFy7ur1xt345Cr42yFW2
        gw1DGF4UZ397GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn_cTDUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: x0lqyxtdqtkjisu6il2tof0z/1tbiLACsCFspau9OeAAAsJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Xin <xinjian@yulong.com>

Fix the following build warning:
  drivers/clk/socfpga/clk-pll.c: In function ‘__socfpga_pll_init’:
  drivers/clk/socfpga/clk-pll.c:83:6: warning: variable ‘rc’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Jian Xin <xinjian@yulong.com>
---
 drivers/clk/socfpga/clk-pll.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
index dcb573d44034..127cc849c5ee 100644
--- a/drivers/clk/socfpga/clk-pll.c
+++ b/drivers/clk/socfpga/clk-pll.c
@@ -80,7 +80,6 @@ static __init struct clk_hw *__socfpga_pll_init(struct device_node *node,
 	const char *parent_name[SOCFPGA_MAX_PARENTS];
 	struct clk_init_data init;
 	struct device_node *clkmgr_np;
-	int rc;
 	int err;
 
 	of_property_read_u32(node, "reg", &reg);
@@ -114,7 +113,7 @@ static __init struct clk_hw *__socfpga_pll_init(struct device_node *node,
 		kfree(pll_clk);
 		return ERR_PTR(err);
 	}
-	rc = of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
+	of_clk_add_provider(node, of_clk_src_simple_get, hw_clk);
 	return hw_clk;
 }
 
-- 
2.25.1


