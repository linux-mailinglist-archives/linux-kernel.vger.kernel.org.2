Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395A13DE825
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhHCIRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234238AbhHCIRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:17:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 674CC60F48;
        Tue,  3 Aug 2021 08:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627978652;
        bh=PdhWPd9rigGSL3jfOcHcS2N75yHEquaDg28LhFIeogg=;
        h=From:To:Cc:Subject:Date:From;
        b=kXvpbg+Bnb7vnIFm10U1Dyz9lSDBD22mYkf26HpX8cuG/dDU0euJF8mPLmTuhNx5R
         IASFr5fJ7POG5mCnoRxuQYuWOabkGvO1RJwwcpz66EK1dLamQg9E2Pdu/KHTQfEDxk
         Kj0cHuiD5bWiyP9jen+mCBtU2DV37cm67gXPsSVPs0ISDsWPipgofMIWlV1dAb24ju
         ge3hEcVfsY1l/kvSGW8ry0SUH8LL2pD/r0kcxop4JPNO3pxIlp4SDBqJCq0LS2qRc9
         kMCQzqiLtLoNsjDKAHXHvu/ToPlkc5Ztlgf2JmRJqtymqVS5TOlhLQu9QoO6+4W9AO
         JnhghzhYi19QQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Krzysztof Halasa <khalasa@piap.pl>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khc@pm.waw.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: ixp4xx/qmgr: fix invalid __iomem access
Date:   Tue,  3 Aug 2021 10:17:22 +0200
Message-Id: <20210803081728.2085286-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Sparse reports a compile time warning when dereferencing an
__iomem pointer:

drivers/soc/ixp4xx/ixp4xx-qmgr.c:149:37: warning: dereference of noderef expression
drivers/soc/ixp4xx/ixp4xx-qmgr.c:153:40: warning: dereference of noderef expression
drivers/soc/ixp4xx/ixp4xx-qmgr.c:154:40: warning: dereference of noderef expression
drivers/soc/ixp4xx/ixp4xx-qmgr.c:174:38: warning: dereference of noderef expression
drivers/soc/ixp4xx/ixp4xx-qmgr.c:174:44: warning: dereference of noderef expression

Use __raw_readl() here for consistency with the rest of the file.
This should really get converted to some proper accessor, as the
__raw functions are not meant to be used in drivers, but the driver
has used these since the start, so for the moment, let's only fix
the warning.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: d4c9e9fc9751 ("IXP42x: Add QMgr support for IXP425 rev. A0 processors.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/ixp4xx/ixp4xx-qmgr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
index c6bf6ef257c0..9154c7029b05 100644
--- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -146,12 +146,12 @@ static irqreturn_t qmgr_irq1_a0(int irq, void *pdev)
 	/* ACK - it may clear any bits so don't rely on it */
 	__raw_writel(0xFFFFFFFF, &qmgr_regs->irqstat[0]);
 
-	en_bitmap = qmgr_regs->irqen[0];
+	en_bitmap = __raw_readl(&qmgr_regs->irqen[0]);
 	while (en_bitmap) {
 		i = __fls(en_bitmap); /* number of the last "low" queue */
 		en_bitmap &= ~BIT(i);
-		src = qmgr_regs->irqsrc[i >> 3];
-		stat = qmgr_regs->stat1[i >> 3];
+		src = __raw_readl(&qmgr_regs->irqsrc[i >> 3]);
+		stat = __raw_readl(&qmgr_regs->stat1[i >> 3]);
 		if (src & 4) /* the IRQ condition is inverted */
 			stat = ~stat;
 		if (stat & BIT(src & 3)) {
@@ -171,7 +171,8 @@ static irqreturn_t qmgr_irq2_a0(int irq, void *pdev)
 	/* ACK - it may clear any bits so don't rely on it */
 	__raw_writel(0xFFFFFFFF, &qmgr_regs->irqstat[1]);
 
-	req_bitmap = qmgr_regs->irqen[1] & qmgr_regs->statne_h;
+	req_bitmap = __raw_readl(&qmgr_regs->irqen[1]) &
+		     __raw_readl(&qmgr_regs->statne_h);
 	while (req_bitmap) {
 		i = __fls(req_bitmap); /* number of the last "high" queue */
 		req_bitmap &= ~BIT(i);
-- 
2.29.2

