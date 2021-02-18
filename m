Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B40831EB72
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 16:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhBRPWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 10:22:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13362 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbhBRNAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 08:00:07 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DhF9k0NxTz7lVX;
        Thu, 18 Feb 2021 20:57:46 +0800 (CST)
Received: from localhost.localdomain (10.90.52.227) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Thu, 18 Feb 2021 20:59:09 +0800
From:   qiuguorui1 <qiuguorui1@huawei.com>
To:     <takahiro.akashi@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <l.stelmach@samsung.com>, <lkml@SDF.ORG>,
        <akpm@linux-foundation.org>, <bgwin@google.com>, <rppt@kernel.org>,
        <gustavoars@kernel.org>, <tao.li@vivo.com>, <james.morse@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zengweilin@huawei.com>,
        <liuwenliang@huawei.com>, <qiuguorui1@huawei.com>
Subject: [PATCH] arm64: kexec_file: fix memory leakage in create_dtb() when fdt_open_into() fails
Date:   Thu, 18 Feb 2021 20:59:00 +0800
Message-ID: <20210218125900.6810-1-qiuguorui1@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.52.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in function create_dtb(), if fdt_open_into() fails, we need to vfree
buf before return.

Fixes: 52b2a8af74360 ("arm64: kexec_file: load initrd and device-tree")
Cc: stable@vger.kernel.org # v5.0
Signed-off-by: qiuguorui1 <qiuguorui1@huawei.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 03210f644790..0cde47a63beb 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -182,8 +182,10 @@ static int create_dtb(struct kimage *image,
 
 		/* duplicate a device tree blob */
 		ret = fdt_open_into(initial_boot_params, buf, buf_size);
-		if (ret)
+		if (ret) {
+			vfree(buf);
 			return -EINVAL;
+		}
 
 		ret = setup_dtb(image, initrd_load_addr, initrd_len,
 				cmdline, buf);
-- 
2.12.3

