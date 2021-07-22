Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822FD3D1DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 08:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhGVF0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 01:26:39 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12285 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhGVF0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:26:37 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GVhgX4YFVz7vf1;
        Thu, 22 Jul 2021 14:02:32 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 14:07:09 +0800
Received: from DESKTOP-2MIM39K.china.huawei.com (10.67.101.83) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 14:07:09 +0800
From:   Yuchen Wei <weiyuchen3@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <mark.rutland@arm.com>, <vincenzo.frascino@arm.com>,
        <keescook@chromium.org>, <pcc@google.com>, <weiyuchen3@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: audit: fix return value high 32bit truncation problem
Date:   Thu, 22 Jul 2021 14:07:07 +0800
Message-ID: <20210722060707.531-1-weiyuchen3@huawei.com>
X-Mailer: git-send-email 2.31.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.101.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: weiyuchen <weiyuchen3@huawei.com>

Add error code judgment in invoke_syscall() to prevent kernel
components such as audit and tracepoint from obtaining incorrect
return values. For example:

type=SYSCALL msg=audit(342.780:69): arch=40000028 syscall=235
success=yes exit=4294967235

The syscall return value is -61, but due to the following process in
invoke_syscall():

	if (is_compat_task())
		ret = lower_32_bits(ret);
	regs->regs[0] = ret;

The return value audit or tracepoint get from regs[0] is 4294967235,
which is an incorrect return value.

Signed-off-by: weiyuchen <weiyuchen3@huawei.com>
---
 arch/arm64/kernel/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 263d6c1a525f..f9f042d9a088 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -54,7 +54,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
 		ret = do_ni_syscall(regs, scno);
 	}
 
-	if (is_compat_task())
+	if (is_compat_task() && !IS_ERR_VALUE(ret))
 		ret = lower_32_bits(ret);
 
 	regs->regs[0] = ret;
-- 
2.12.3

