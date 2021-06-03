Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D6D399811
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 04:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFCCgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 22:36:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7078 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCCgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 22:36:04 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FwVJj4rB0zYqFf;
        Thu,  3 Jun 2021 10:31:33 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (7.185.36.59) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 10:34:18 +0800
Received: from huawei.com (10.175.112.125) by dggpeml500005.china.huawei.com
 (7.185.36.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 10:34:17 +0800
From:   Yongqiang Liu <liuyongqiang13@huawei.com>
To:     <f.fainelli@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] soc: bcm: brcmstb: Remove unused variable brcmstb_machine_match.
Date:   Thu, 3 Jun 2021 02:44:26 +0000
Message-ID: <20210603024426.1124761-1-liuyongqiang13@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b8f095b9076 ("soc: bcm: brcmstb: Remove soc_is_brcmstb()")
remove the function soc_is_brcmstb(), the global variable
brcmstb_machine_match is no longer useful. So remove it.

Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
---
 drivers/soc/bcm/brcmstb/common.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
index e87dfc6660f3..2a010881f4b6 100644
--- a/drivers/soc/bcm/brcmstb/common.c
+++ b/drivers/soc/bcm/brcmstb/common.c
@@ -14,11 +14,6 @@
 static u32 family_id;
 static u32 product_id;
 
-static const struct of_device_id brcmstb_machine_match[] = {
-	{ .compatible = "brcm,brcmstb", },
-	{ }
-};
-
 u32 brcmstb_get_family_id(void)
 {
 	return family_id;
-- 
2.19.1

