Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64708423FEC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbhJFOVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:21:39 -0400
Received: from unicom146.biz-email.net ([210.51.26.146]:61279 "EHLO
        unicom146.biz-email.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhJFOVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:21:35 -0400
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((LNX1044)) with ASMTP (SSL) id AQA00129;
        Wed, 06 Oct 2021 22:19:29 +0800
Received: from 10.0.2.15 (172.16.100.3) by jtjnmail201602.home.langchao.com
 (10.100.2.2) with Microsoft SMTP Server id 15.1.2308.14; Wed, 6 Oct 2021
 22:19:30 +0800
From:   Kai Song <songkai01@inspur.com>
To:     <thor.thayer@linux.intel.com>, <lee.jones@linaro.org>
CC:     <zou_wei@huawei.com>, <linux-kernel@vger.kernel.org>,
        Kai Song <songkai01@inspur.com>
Subject: [PATCH] mfd: altera-sysmgr: Fix a mistake caused by resource_size function
Date:   Wed, 6 Oct 2021 22:19:26 +0800
Message-ID: <20211006141926.6120-1-songkai01@inspur.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.100.3]
tUid:   20211006221929aad1ada3d20b01638545f7e6920542f1
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: d12edf9661a4 ("mfd: altera-sysmgr: Use resource_size function on resource object")

The resource_size defines that:
	res->end - res->start + 1;
The origin original code is:
	sysmgr_config.max_register = res->end - res->start - 3;

So, the correct fix is that:
	sysmgr_config.max_register = resource_size(res) - 4;

Signed-off-by: Kai Song <songkai01@inspur.com>
---
 drivers/mfd/altera-sysmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 20cb294c7512..5d3715a28b28 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -153,7 +153,7 @@ static int sysmgr_probe(struct platform_device *pdev)
 		if (!base)
 			return -ENOMEM;
 
-		sysmgr_config.max_register = resource_size(res) - 3;
+		sysmgr_config.max_register = resource_size(res) - 4;
 		regmap = devm_regmap_init_mmio(dev, base, &sysmgr_config);
 	}
 
-- 
2.27.0

