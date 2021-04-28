Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC76936D239
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhD1Gd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:33:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17048 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1Gd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:33:28 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FVTHx63sGzPtpn;
        Wed, 28 Apr 2021 14:29:33 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 28 Apr 2021 14:32:33 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH 1/1] lib: devres: Add error information printing for __devm_ioremap_resource()
Date:   Wed, 28 Apr 2021 14:32:03 +0800
Message-ID: <20210428063203.691-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that all error handling branches print error information. In this
way, when this function fails, the upper-layer functions can directly
return an error code without missing debugging information. Otherwise,
the error message will be printed redundantly or missing.

Fixes: 35bd8c07db2c ("devres: keep both device name and resource name in pretty name")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/devres.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/devres.c b/lib/devres.c
index 4679dbb1bf5f8a8..bdb06898a977701 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -157,8 +157,10 @@ __devm_ioremap_resource(struct device *dev, const struct resource *res,
 					     dev_name(dev), res->name);
 	else
 		pretty_name = devm_kstrdup(dev, dev_name(dev), GFP_KERNEL);
-	if (!pretty_name)
+	if (!pretty_name) {
+		dev_err(dev, "can't generate pretty name for resource %pR\n", res);
 		return IOMEM_ERR_PTR(-ENOMEM);
+	}
 
 	if (!devm_request_mem_region(dev, res->start, size, pretty_name)) {
 		dev_err(dev, "can't request region for resource %pR\n", res);
-- 
2.26.0.106.g9fadedd


