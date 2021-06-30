Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C38E3B7B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 03:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhF3CB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 22:01:57 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:9321 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhF3CB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 22:01:56 -0400
Received: from dggeme766-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GF4DJ6Rc0z73kS;
        Wed, 30 Jun 2021 09:55:12 +0800 (CST)
Received: from huawei.com (10.175.104.82) by dggeme766-chm.china.huawei.com
 (10.3.19.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 30
 Jun 2021 09:59:24 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <gabriel.fernandez@foss.st.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] clk: stm32mp1: fix missing spin_lock_init()
Date:   Wed, 30 Jun 2021 09:58:23 +0800
Message-ID: <20210630015824.2555840-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme766-chm.china.huawei.com (10.3.19.112)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver allocates the spinlock but not initialize it.
Use spin_lock_init() on it to initialize it correctly.

Fixes: c392df194a2d ("clk: stm32mp1: move RCC reset controller into RCC clock driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/clk/clk-stm32mp1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 6adc625e79c..256575bd29b 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -2263,6 +2263,7 @@ static int stm32_rcc_reset_init(struct device *dev, void __iomem *base,
 	if (!reset_data)
 		return -ENOMEM;
 
+	spin_lock_init(&reset_data->lock);
 	reset_data->membase = base;
 	reset_data->rcdev.owner = THIS_MODULE;
 	reset_data->rcdev.ops = &stm32_reset_ops;
-- 
2.17.1

