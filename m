Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0062939887F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFBLpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:45:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7074 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFBLpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:45:40 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fw6YM3wLLzYpXb;
        Wed,  2 Jun 2021 19:41:11 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:43:56 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 19:43:55 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Lee Jones <lee.jones@linaro.org>,
        patches <patches@opensource.cirrus.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 2/9] mfd: ucb1x00-assabet: use DEVICE_ATTR_RO macro
Date:   Wed, 2 Jun 2021 19:43:32 +0800
Message-ID: <20210602114339.11223-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210602114339.11223-1-thunder.leizhen@huawei.com>
References: <20210602114339.11223-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO macro helper instead of plain DEVICE_ATTR, which makes
the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/mfd/ucb1x00-assabet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ucb1x00-assabet.c b/drivers/mfd/ucb1x00-assabet.c
index ecc9e9fc331d6a3..6a389737c6153bc 100644
--- a/drivers/mfd/ucb1x00-assabet.c
+++ b/drivers/mfd/ucb1x00-assabet.c
@@ -28,7 +28,7 @@ static ssize_t name##_show(struct device *dev, struct device_attribute *attr, \
 	ucb1x00_adc_disable(ucb);				\
 	return sprintf(buf, "%d\n", val);			\
 }								\
-static DEVICE_ATTR(name,0444,name##_show,NULL)
+static DEVICE_ATTR_RO(name)
 
 UCB1X00_ATTR(vbatt, UCB_ADC_INP_AD1);
 UCB1X00_ATTR(vcharger, UCB_ADC_INP_AD0);
-- 
2.26.0.106.g9fadedd


