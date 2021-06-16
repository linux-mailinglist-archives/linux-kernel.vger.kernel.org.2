Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE33A3A93F0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhFPHcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:32:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:10093 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhFPHco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:32:44 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G4cGQ17fjzZdKN;
        Wed, 16 Jun 2021 15:27:42 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 15:30:37 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 15:30:37 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Johannes Thumshirn <morbidrsa@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 1/1] mcb: Use DEFINE_RES_MEM() helper macro and fix the end address
Date:   Wed, 16 Jun 2021 15:30:30 +0800
Message-ID: <20210616073030.834-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210616073030.834-1-thunder.leizhen@huawei.com>
References: <20210616073030.834-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_RES_MEM() to save a couple of lines of code, which makes the
code a bit shorter and easier to read. The start address does not need to
appear twice.

By the way, the value of '.end' should be "start + size - 1". So the
previous writing should have omitted subtracted 1.

Fixes: acf5e051ac44 ("MCB: add support for SC31 to mcb-lpc")
Fixes: 73edc8f7ccef ("mcb: Added support for LPC or non PCI based MCB carrier")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mcb/mcb-lpc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/mcb/mcb-lpc.c b/drivers/mcb/mcb-lpc.c
index 506676754538..53decd89876e 100644
--- a/drivers/mcb/mcb-lpc.c
+++ b/drivers/mcb/mcb-lpc.c
@@ -105,17 +105,8 @@ static int mcb_lpc_create_platform_device(const struct dmi_system_id *id)
 	return ret;
 }
 
-static struct resource sc24_fpga_resource = {
-	.start = 0xe000e000,
-	.end = 0xe000e000 + CHAM_HEADER_SIZE,
-	.flags = IORESOURCE_MEM,
-};
-
-static struct resource sc31_fpga_resource = {
-	.start = 0xf000e000,
-	.end = 0xf000e000 + CHAM_HEADER_SIZE,
-	.flags = IORESOURCE_MEM,
-};
+static struct resource sc24_fpga_resource = DEFINE_RES_MEM(0xe000e000, CHAM_HEADER_SIZE);
+static struct resource sc31_fpga_resource = DEFINE_RES_MEM(0xf000e000, CHAM_HEADER_SIZE);
 
 static struct platform_driver mcb_lpc_driver = {
 	.driver		= {
-- 
2.25.1


