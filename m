Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2895135A9CF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbhDJBFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:05:09 -0400
Received: from m15112.mail.126.com ([220.181.15.112]:51962 "EHLO
        m15112.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbhDJBFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:05:08 -0400
X-Greylist: delayed 1868 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Apr 2021 21:05:07 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=YjzmIwerweOGbfblgC
        /Ly+OrKlNwezN7iggMM3swgJM=; b=MJHaL0orm8TvdDuB7Ke+swd6jhy8BrifMI
        +AmmCaqyYsUXYS/mlvoGVJkb5MVHH8OlYONPAzTbVhf15OK1JCiodjpjbSWlC8pq
        Es3/zLe6WynvMoDcLRKBGHs0EpyF02SeZdbgyiAoQipLo2pQbY/zcpPjNl9+LSR6
        7yGPEDbrc=
Received: from localhost.localdomain (unknown [106.17.213.220])
        by smtp2 (Coremail) with SMTP id DMmowAA3nwNa8nBgdqQBAQ--.18230S2;
        Sat, 10 Apr 2021 08:33:32 +0800 (CST)
From:   wangyingjie55@126.com
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com,
        linux-nvdimm@lists.01.org
Cc:     wangyingjie55@126.com, linux-kernel@vger.kernel.org
Subject: [PATCH v1] libnvdimm, dax: Fix a missing check in nd_dax_probe()
Date:   Fri,  9 Apr 2021 17:33:23 -0700
Message-Id: <1618014803-17231-1-git-send-email-wangyingjie55@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMmowAA3nwNa8nBgdqQBAQ--.18230S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW3XF15XF15Gw4rtry5urg_yoWfArXEkr
        17Zr929Fy0kwnayr4aqr1fWryvyrs29r18ur4jgw13Ar4Y9r13GFykur9xtrsagr48urnr
        ur1DXFnxZF15GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjeyI5UUUUU==
X-Originating-IP: [106.17.213.220]
X-CM-SenderInfo: 5zdqw5xlqjyxrhvvqiyswou0bp/1tbiJRxwp13WGyhjMQAAsE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yingjie Wang <wangyingjie55@126.com>

In nd_dax_probe(), nd_dax_alloc() may fail and return NULL.
Check for NULL before attempting to
use nd_dax to avoid a NULL pointer dereference.

Fixes: c5ed9268643c ("libnvdimm, dax: autodetect support")
Signed-off-by: Yingjie Wang <wangyingjie55@126.com>
---
 drivers/nvdimm/dax_devs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
index 99965077bac4..b1426ac03f01 100644
--- a/drivers/nvdimm/dax_devs.c
+++ b/drivers/nvdimm/dax_devs.c
@@ -106,6 +106,8 @@ int nd_dax_probe(struct device *dev, struct nd_namespace_common *ndns)
 
 	nvdimm_bus_lock(&ndns->dev);
 	nd_dax = nd_dax_alloc(nd_region);
+	if (!nd_dax)
+		return -ENOMEM;
 	nd_pfn = &nd_dax->nd_pfn;
 	dax_dev = nd_pfn_devinit(nd_pfn, ndns);
 	nvdimm_bus_unlock(&ndns->dev);
-- 
2.7.4

