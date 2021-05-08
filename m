Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4FA377117
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 11:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhEHJxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 05:53:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18016 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhEHJxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 05:53:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FcjFK1ZPWzQjgR;
        Sat,  8 May 2021 17:48:53 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Sat, 8 May 2021 17:52:03 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] powerpc/ps3: Remove a couple of unneeded semicolons
Date:   Sat, 8 May 2021 17:51:50 +0800
Message-ID: <20210508095150.2942-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The semicolon immediately following '}' is unneeded.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/powerpc/platforms/ps3/system-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index b431f41c6cb53ab..5c739267ddd2174 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -603,7 +603,7 @@ static dma_addr_t ps3_ioc0_map_page(struct device *_dev, struct page *page,
 	default:
 		/* not happned */
 		BUG();
-	};
+	}
 	result = ps3_dma_map(dev->d_region, (unsigned long)ptr, size,
 			     &bus_addr, iopte_flag);
 
@@ -762,7 +762,7 @@ int ps3_system_bus_device_register(struct ps3_system_bus_device *dev)
 		break;
 	default:
 		BUG();
-	};
+	}
 
 	dev->core.of_node = NULL;
 	set_dev_node(&dev->core, 0);
-- 
2.26.0.106.g9fadedd


