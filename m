Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B418733CC72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhCPEMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:12:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:13935 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhCPEMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:12:09 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F00FR34DBzkZnD;
        Tue, 16 Mar 2021 12:10:35 +0800 (CST)
Received: from huawei.com (10.67.174.47) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Tue, 16 Mar 2021
 12:12:00 +0800
From:   He Ying <heying24@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <dja@axtens.net>,
        <akpm@linux-foundation.org>, <aneesh.kumar@linux.ibm.com>,
        <rppt@kernel.org>, <ardb@kernel.org>, <clg@kaod.org>,
        <christophe.leroy@csgroup.eu>
CC:     <johnny.chenyi@huawei.com>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] powerpc: arch/powerpc/kernel/setup_64.c - cleanup warnings
Date:   Tue, 16 Mar 2021 00:11:48 -0400
Message-ID: <20210316041148.29694-1-heying24@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.47]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

warning: symbol 'rfi_flush' was not declared.
warning: symbol 'entry_flush' was not declared.
warning: symbol 'uaccess_flush' was not declared.
We found warnings above in arch/powerpc/kernel/setup_64.c by using
sparse tool.

Define 'entry_flush' and 'uaccess_flush' as static because they are not
referenced outside the file. Include asm/security_features.h in which
'rfi_flush' is declared.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: He Ying <heying24@huawei.com>
---
 arch/powerpc/kernel/setup_64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 560ed8b975e7..f92d72a7e7ce 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -68,6 +68,7 @@
 #include <asm/early_ioremap.h>
 #include <asm/pgalloc.h>
 #include <asm/asm-prototypes.h>
+#include <asm/security_features.h>
 
 #include "setup.h"
 
@@ -949,8 +950,8 @@ static bool no_rfi_flush;
 static bool no_entry_flush;
 static bool no_uaccess_flush;
 bool rfi_flush;
-bool entry_flush;
-bool uaccess_flush;
+static bool entry_flush;
+static bool uaccess_flush;
 DEFINE_STATIC_KEY_FALSE(uaccess_flush_key);
 EXPORT_SYMBOL(uaccess_flush_key);
 
-- 
2.17.1

