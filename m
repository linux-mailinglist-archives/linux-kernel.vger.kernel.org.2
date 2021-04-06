Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969673550C5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 12:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbhDFKYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 06:24:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16348 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbhDFKYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:24:05 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FF3V20yjVz94HW;
        Tue,  6 Apr 2021 18:21:46 +0800 (CST)
Received: from huawei.com (10.67.174.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Tue, 6 Apr 2021
 18:23:48 +0800
From:   Zhang Jianhua <zhangjianhua18@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <zhangjianhua18@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <johnny.chenyi@huawei.com>,
        <heying24@huawei.com>
Subject: [PATCH -next] arm: patch: FUNCTION_GRAPH_TRACER depends on CPU_ENDIAN_BE8 or !CPU_ENDIAN_BE32
Date:   Tue, 6 Apr 2021 18:23:51 +0800
Message-ID: <20210406102351.64028-1-zhangjianhua18@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_FUNCTION_GRAPH_TRACER=y, the following errors will be seen
while compiling patch.c

arch/arm/kernel/patch.c: In function ‘__patch_text_real’:
arch/arm/kernel/patch.c:94:11: error: implicit declaration of function
‘__opcode_to_mem_thumb32’; did you mean ‘__opcode_to_mem_thumb16’?
[-Werror=implicit-function-declaration]
    insn = __opcode_to_mem_thumb32(insn);
           ^~~~~~~~~~~~~~~~~~~~~~~
           __opcode_to_mem_thumb16

Signed-off-by: Zhang Jianhua <zhangjianhua18@huawei.com>
---
 kernel/trace/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 7fa82778c3e6..fbf5fd80f105 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -177,6 +177,7 @@ config FUNCTION_GRAPH_TRACER
 	depends on HAVE_FUNCTION_GRAPH_TRACER
 	depends on FUNCTION_TRACER
 	depends on !X86_32 || !CC_OPTIMIZE_FOR_SIZE
+	depends on CPU_ENDIAN_BE8 || !CPU_ENDIAN_BE32
 	default y
 	help
 	  Enable the kernel to trace a function at both its return
-- 
2.17.1

