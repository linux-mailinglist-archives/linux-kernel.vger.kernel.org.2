Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F55F38D846
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 04:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhEWC3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 22:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhEWC3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 22:29:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1432C061574;
        Sat, 22 May 2021 19:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=P6dTj6mWdxmlGaygBBC5NRc0NUr0pdfgGLiOJPkt8mM=; b=UFYXTWfHlfwiNHyKhOTlrEe+hq
        XgIdPHrTLUwhi3I1yGUJtcII6VWvxwF44cUCD8nGdjeKc4hvq5cKNwK/xqblasLq0pWVGjKb4FvTC
        o/gHjzJLEr6UBgk6fSKtUutaKGS6enHr9jU+R1JdSTnHA1qnRCkB0ziVUhhpurJQD2/c9IuuoWYUF
        2Q4ivKeBY/XbZX4aXQQ7qhcz+zKtrWZg4sCVyGnx1xJVfR+xu/AVob5TSgAEhJYSPTxOW6R+hsGVR
        TQU+mEA8txDJcm7tbMnm1r0eCTWITavWd6zqn9QRiGEOE5SQWGM36Tx37cZ20HuL359H4egVL7jGb
        g9DS9zwA==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkdqa-000HWL-06; Sun, 23 May 2021 02:28:08 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] OF: of_address: clean up OF stub functions
Date:   Sat, 22 May 2021 19:28:07 -0700
Message-Id: <20210523022807.5193-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust <linux/of_address.h> so that stubs are present when
CONFIG_OF is not set *or* OF is set but OF_ADDRESS is not set.

This eliminates 2 build errors on arch/s390/ when HAS_IOMEM
is not set (so OF_ADDRESS is not set).
I.e., it provides a stub for of_iomap() when one was previously
not provided as well as removing some duplicate stubs.

s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
irq-al-fic.c:(.init.text+0x7a): undefined reference to `of_iomap'
s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
timer-of.c:(.init.text+0xa4): undefined reference to `of_iomap'

Tested with many randconfig builds, but there could still be some
hidden problem here.

Fixes: 4acf4b9cd453 ("of: move of_address_to_resource and of_iomap declarations from sparc")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/linux/of_address.h |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- linux-next-20210521.orig/include/linux/of_address.h
+++ linux-next-20210521/include/linux/of_address.h
@@ -106,11 +106,7 @@ static inline bool of_dma_is_coherent(st
 }
 #endif /* CONFIG_OF_ADDRESS */
 
-#ifdef CONFIG_OF
-extern int of_address_to_resource(struct device_node *dev, int index,
-				  struct resource *r);
-void __iomem *of_iomap(struct device_node *node, int index);
-#else
+#if defined(CONFIG_OF) && !defined(CONFIG_OF_ADDRESS) || !defined(CONFIG_OF)
 static inline int of_address_to_resource(struct device_node *dev, int index,
 					 struct resource *r)
 {
