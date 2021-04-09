Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A6D35994E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhDIJfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:35:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16504 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhDIJfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:35:32 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGtFn5szrzPpGn;
        Fri,  9 Apr 2021 17:32:29 +0800 (CST)
Received: from huawei.com (10.67.174.166) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:35:13 +0800
From:   Zucheng Zheng <zhengzucheng@huawei.com>
To:     <benh@kernel.crashing.org>, <mpe@ellerman.id.au>,
        <paulus@samba.org>, <oohall@gmail.com>,
        <akpm@linux-foundation.org>, <rppt@kernel.org>,
        <christophe.leroy@csgroup.eu>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] powerpc/pmac: remove not use symbol
Date:   Fri, 9 Apr 2021 17:35:19 +0800
Message-ID: <20210409093519.118000-1-zhengzucheng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.166]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sccdbg symbol is not used, so remove it

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zucheng Zheng <zhengzucheng@huawei.com>
---
 arch/powerpc/platforms/powermac/setup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index db5107c80485..df9ea37d5708 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -83,10 +83,6 @@ extern struct machdep_calls pmac_md;
 
 #define DEFAULT_ROOT_DEVICE Root_SDA1	/* sda1 - slightly silly choice */
 
-#ifdef CONFIG_PPC64
-int sccdbg;
-#endif
-
 sys_ctrler_t sys_ctrler = SYS_CTRLER_UNKNOWN;
 EXPORT_SYMBOL(sys_ctrler);
 
-- 
2.17.1

