Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FC438F37D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 21:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhEXTKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 15:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbhEXTKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 15:10:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDC5C061574;
        Mon, 24 May 2021 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/VQWjIwAzHQh3Hpp53y0A3SY+AUfYTrfEWM/VxGYUe0=; b=Bz49qLh/S2GWj6SErpe+gPEMPB
        30rSJ01ZvV/reybb3yg46bz8hO8mSVIXzKsFe3yrNyWBqmms+vkYvch7fqHRlVs3FEA9awb47cQi+
        ZJzfklkvYNoCEKhN6fsCiY5vVwbPoeb5PatsxyLn+H1bdZIEe9VHiqoSUtUUg6ZA2PlXYiGDaqJMs
        gXQgWXDpOO16N1Bi8qeQsNMcHea1ksiuiOaLPfxc6yUKzbdHXgefAyCI1ujVBpgjmhD5h327rCxtq
        meCroFQvcGHd/2+wpP3rr0DgcK3QXeAuijeK3hSutOJ1rH8HmcvFUsimL7DdGxyaiA7CWQlTTY/5i
        awse3h7A==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llFx1-001boq-QW; Mon, 24 May 2021 19:09:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] OF: of_address: clean up OF stub & extern functions
Date:   Mon, 24 May 2021 12:09:19 -0700
Message-Id: <20210524190919.2616-1-rdunlap@infradead.org>
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
not provided as well as removing some duplicate externs.

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
Reported-by: kernel test robot <lkp@intel.com>
---
v2: handle SPARC as a special case since it provides its own versions of
    of_address_to_resource() and of_iomap();
    fix build errors reported by lkp/ktr and address comments from Laurent;
    do more randconfig build testing;

 include/linux/of_address.h |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- linux-next-20210524.orig/include/linux/of_address.h
+++ linux-next-20210524/include/linux/of_address.h
@@ -106,11 +106,12 @@ static inline bool of_dma_is_coherent(st
 }
 #endif /* CONFIG_OF_ADDRESS */
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_SPARC /* SPARC has its own versions of these */
 extern int of_address_to_resource(struct device_node *dev, int index,
 				  struct resource *r);
-void __iomem *of_iomap(struct device_node *node, int index);
-#else
+extern void __iomem *of_iomap(struct device_node *device, int index);
+#else /* !CONFIG_SPARC */
+#if (defined(CONFIG_OF) && !defined(CONFIG_OF_ADDRESS)) || !defined(CONFIG_OF)
 static inline int of_address_to_resource(struct device_node *dev, int index,
 					 struct resource *r)
 {
@@ -121,7 +122,9 @@ static inline void __iomem *of_iomap(str
 {
 	return NULL;
 }
-#endif
+#endif /* (defined(CONFIG_OF) && !defined(CONFIG_OF_ADDRESS)) || !defined(CONFIG_OF) */
+#endif /* CONFIG_SPARC */
+
 #define of_range_parser_init of_pci_range_parser_init
 
 #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_PCI)
