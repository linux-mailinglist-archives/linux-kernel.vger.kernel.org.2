Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BDA377D76
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 09:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhEJHwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 03:52:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2548 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhEJHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 03:52:24 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FdtTh0Tt2zkYQY;
        Mon, 10 May 2021 15:48:40 +0800 (CST)
Received: from huawei.com (10.67.174.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Mon, 10 May 2021
 15:51:09 +0800
From:   Zhang Jianhua <chris.zjh@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <gustavoars@kernel.org>, <ojeda@kernel.org>,
        <ndesaulniers@google.com>, <chris.zjh@huawei.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ppc: boot: Fix a typo in the file decompress.c
Date:   Mon, 10 May 2021 15:51:34 +0800
Message-ID: <20210510075134.252978-1-chris.zjh@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/input buffer/output buffer/
s/length of the input buffer/length of the input buffer/

--------

Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
---
 arch/powerpc/boot/decompress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/decompress.c b/arch/powerpc/boot/decompress.c
index 6098b879ac97..977eb15a6d17 100644
--- a/arch/powerpc/boot/decompress.c
+++ b/arch/powerpc/boot/decompress.c
@@ -99,8 +99,8 @@ static void print_err(char *s)
  * partial_decompress - decompresses part or all of a compressed buffer
  * @inbuf:       input buffer
  * @input_size:  length of the input buffer
- * @outbuf:      input buffer
- * @output_size: length of the input buffer
+ * @outbuf:      output buffer
+ * @output_size: length of the output buffer
  * @skip         number of output bytes to ignore
  *
  * This function takes compressed data from inbuf, decompresses and write it to
-- 
2.17.1

