Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D75C39B5D6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhFDJXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 05:23:37 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3060 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhFDJXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:23:36 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FxHG50cc6zWpSp;
        Fri,  4 Jun 2021 17:17:01 +0800 (CST)
Received: from huawei.com (10.67.174.47) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 4 Jun
 2021 17:21:46 +0800
From:   He Ying <heying24@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <nathan@kernel.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <heying24@huawei.com>
Subject: [PATCH] powerpc: Fix kernel-jump address for ppc64 wrapper boot
Date:   Fri, 4 Jun 2021 05:22:28 -0400
Message-ID: <20210604092228.199588-1-heying24@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.47]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From "64-bit PowerPC ELF Application Binary Interface Supplement 1.9",
we know that the value of a function pointer in a language like C is
the address of the function descriptor and the first doubleword
of the function descriptor contains the address of the entry point
of the function.

So, when we want to jump to an address (e.g. addr) to execute for
PPC-elf64abi, we should assign the address of addr *NOT* addr itself
to the function pointer or system will jump to the wrong address.

Link: https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi.html#FUNC-DES
Signed-off-by: He Ying <heying24@huawei.com>
---
 arch/powerpc/boot/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index cae31a6e8f02..50fd7f11b642 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -268,7 +268,16 @@ void start(void)
 	if (console_ops.close)
 		console_ops.close();
 
+#ifdef CONFIG_PPC64_BOOT_WRAPPER
+	/*
+	 * For PPC-elf64abi, the value of a function pointer is the address
+	 * of the function descriptor. And the first doubleword of a function
+	 * descriptor contains the address of the entry point of the function.
+	 */
+	kentry = (kernel_entry_t) &vmlinux.addr;
+#else
 	kentry = (kernel_entry_t) vmlinux.addr;
+#endif
 	if (ft_addr) {
 		if(platform_ops.kentry)
 			platform_ops.kentry(ft_addr, vmlinux.addr);
-- 
2.17.1

