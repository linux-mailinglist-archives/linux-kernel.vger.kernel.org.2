Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD6C3DEBDC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbhHCLeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:34:20 -0400
Received: from smtpbg126.qq.com ([106.55.201.22]:18484 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235585AbhHCLeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:34:07 -0400
X-QQ-mid: bizesmtp31t1627990388t2abq2ne
Received: from localhost.localdomain (unknown [125.69.40.136])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 03 Aug 2021 19:33:06 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: Z5h1lUobohN49qzZbbMeBpA+48lSsb2ie4jDewwC0Q6haqCO/fLnfwdbC9xzI
        JEmROSAQGCWXXHPSE04hn1piq0qxYpJzfnLewb4U6sLoWpsqtGt7xK17JPKEPZZhQsmzABY
        s6Ug0sXiZcimD/QRJ2feu5vEyGcrz6OtGjCbZqzrgWt/pXwQF7ZxsbnPKHTOYuR5V9eL9Xn
        9PkGoOHO8HSEsAn2wEubqSUgTFZgVenjOqsc/fEz7UK3SoT15bxGAn6b6M8TMB6z7Eofbuz
        jQ8+/lSgmc/3GuiIN8pjGCgpRcGasr2z5C2yviYANQsVjHiGdxuux4SzgjSriBMc88iw==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     miquel.raynal@bootlin.com
Cc:     liang.yang@amlogic.com, vigneshr@ti.com, narmstrong@baylibre.com,
        khilman@baylibre.com, richard@nod.at, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] mtd: rawnand: remove never changed ret variable
Date:   Tue,  3 Aug 2021 19:33:00 +0800
Message-Id: <20210803113300.24230-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ret variable used for returning value in the function
`meson_nfc_rw_cmd_prepare_and_execute` is never change after initialising.
Therefore, we can remove it safely and return 0 at the end of the function.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 817bddccb775..ac3be92872d0 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -580,7 +580,7 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
 	u32 *addrs = nfc->cmdfifo.rw.addrs;
 	u32 cs = nfc->param.chip_select;
 	u32 cmd0, cmd_num, row_start;
-	int ret = 0, i;
+	int i;
 
 	cmd_num = sizeof(struct nand_rw_cmd) / sizeof(int);
 
@@ -620,7 +620,7 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
 		meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int meson_nfc_write_page_sub(struct nand_chip *nand,
-- 
2.32.0

