Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD70B443B18
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 02:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhKCBsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 21:48:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15348 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhKCBsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 21:48:13 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HkV2t4N15z90jv;
        Wed,  3 Nov 2021 09:45:26 +0800 (CST)
Received: from huawei.com (10.67.174.47) by dggeme755-chm.china.huawei.com
 (10.3.19.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Wed, 3
 Nov 2021 09:45:35 +0800
From:   He Ying <heying24@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] powerpc/sysdev/of_rtc: Fix possible memory leak in of_instantiate_rtc
Date:   Tue, 2 Nov 2021 21:47:17 -0400
Message-ID: <20211103014717.162886-1-heying24@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.47]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If of_address_to_resource() in of_instantiate_rtc() fails, previously
allocated memory res is not freed. Add missing kfree() for it.

Signed-off-by: He Ying <heying24@huawei.com>
---
 arch/powerpc/sysdev/of_rtc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/of_rtc.c b/arch/powerpc/sysdev/of_rtc.c
index 1f408d34a6a7..23b896996c2f 100644
--- a/arch/powerpc/sysdev/of_rtc.c
+++ b/arch/powerpc/sysdev/of_rtc.c
@@ -44,6 +44,7 @@ void __init of_instantiate_rtc(void)
 				printk(KERN_ERR "OF RTC: Error "
 				       "translating resources for %pOF\n",
 				       node);
+				kfree(res);
 				continue;
 			}
 
-- 
2.17.1

