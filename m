Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1633B2715
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 08:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhFXGGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 02:06:10 -0400
Received: from m12-16.163.com ([220.181.12.16]:57615 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230257AbhFXGGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 02:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hmqpo
        rXhZUOVVVEf/ac1YPbTWg/x3HX0KGoPZSyn+fI=; b=BMYUamZ0sV7zSAvreJrE5
        tnWBbLM8GzSl01Gd3ztUBu9gBlR0ju1fM7MQMMBB4/NWaIS1CBtfWPtZ5dN+U1ZS
        5jTXPNNE+a5NdxGavoXVq/6OgXcZxSysTEsVuD/7p8bn47nQCcfcqDLC/X88ctKu
        iCegbeU4p3T2nn0faOFTBo=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp12 (Coremail) with SMTP id EMCowAA3U08qINRg8uHZyw--.39766S2;
        Thu, 24 Jun 2021 14:03:22 +0800 (CST)
From:   13145886936@163.com
To:     geoff@infradead.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] powerpc: ps3: remove unneeded semicolon
Date:   Wed, 23 Jun 2021 23:03:16 -0700
Message-Id: <20210624060316.25734-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAA3U08qINRg8uHZyw--.39766S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF1UtF4ftryrXF45Gw4DArb_yoWfuwc_Aw
        4Iv3Z7uFW8Jr12k3Z7CFn7Wr17J3sIgrWYgrsFq3W3t345J3yF9395JFWUGw4UXF92yrZx
        AFn8J3sxAa4SyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU55Ma5UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/xtbBdgq7g1UMRXtdgwAAs9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Remove unneeded semocolons.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 arch/powerpc/platforms/ps3/system-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 1a5665875165..f57f37fe038c 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -604,7 +604,7 @@ static dma_addr_t ps3_ioc0_map_page(struct device *_dev, struct page *page,
 	default:
 		/* not happned */
 		BUG();
-	};
+	}
 	result = ps3_dma_map(dev->d_region, (unsigned long)ptr, size,
 			     &bus_addr, iopte_flag);
 
@@ -763,7 +763,7 @@ int ps3_system_bus_device_register(struct ps3_system_bus_device *dev)
 		break;
 	default:
 		BUG();
-	};
+	}
 
 	dev->core.of_node = NULL;
 	set_dev_node(&dev->core, 0);
-- 
2.25.1


