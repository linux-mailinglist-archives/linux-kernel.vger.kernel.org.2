Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B59403E8B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352561AbhIHRr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350279AbhIHRrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:47:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F0C0612A6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:45:59 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so1888131pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bYEb93v2edJxduQ1tKdJAFizc1jWHNKcldlmNIUxJJc=;
        b=Fc+eGN/TbPbgtYCV0XIKvvs4j8YfYuqog4Bo8ySp4UCX+N2thheP3GvjOknBdpETOR
         1n1Fokqrqg7amJioOSqOCphpC8VegHsVhd8bKiyIbjVt1Khk9o3JfLGVahl43LhHGy3G
         Dtp5Cz1Omu9YKMJe8hDKC5Ehp7R7JpwwYZEtzAHulkVyZ6URgTnYua3F/ktfOFrXm2aE
         CwNkE/+MEINnEtchw02Um6ms0WYA+WLzMP/P0etL8YyoUyhXj+s/m0Iy+7jrSR17ymep
         9TgT0Ws4OO87Sn/Zw8c65/9OuTYVXZon8AVspXtkjk+b7NlDokCKid9EL5GSOlbBJ1P8
         ltgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bYEb93v2edJxduQ1tKdJAFizc1jWHNKcldlmNIUxJJc=;
        b=U7xoLa3Z30KmfuiZokxGYWrIg7dZHYbyty496hbptkOQfdGF8bZxnMQZIlwYihmXeY
         sFKEDA2JtsBXTjv7MuvkM/qFtgAmLRV0Lu5MtzqU0hapK5o8M2AsOpzDx0hZZumgETKY
         Nfh9k0rkdqnw/1j9hK4X7weMh2Z9/5J+FrBFuTKVNwNvXIbLqkY1GLr24cRgwyOg+YYk
         UKAcg3Ad7qhwC1yGW9A13dnUlVGJfDgYEbA/VaJ845bENORenMebcFeR3jVaeCrON9Dn
         rmdsFVFNkBIAZaiHWroDBEmkiOJXxKzw4trPdI9iR2GBGLiWo1B/gWOKyW5s+ZI0d3FR
         +QkQ==
X-Gm-Message-State: AOAM533gaiwgame5OxBf2AXYtBERY02+az1FdwKNI5UfTWy2aTTKrdvK
        PuC93IOti+wAfWIOS5TDeD8HikGgcdvP/w==
X-Google-Smtp-Source: ABdhPJy4fkxyLd5n51UTYMDmSAtKZcR/1z+AtxWJY8nwKCMXlRZc/PCB2QyS1yrxUdmEFh/Lv5Touw==
X-Received: by 2002:a17:90b:1902:: with SMTP id mp2mr5443716pjb.4.1631123159339;
        Wed, 08 Sep 2021 10:45:59 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:45:59 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 15/21] riscv: Add vector extension XOR implementation
Date:   Thu,  9 Sep 2021 01:45:27 +0800
Message-Id: <33c485ee595aff1e19a0e43074da59779f58d105.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for vector optimized XOR it is tested in spike and
qemu.

Logs in spike:
[    0.008365] xor: measuring software checksum speed
[    0.048885]    8regs     :  1719.000 MB/sec
[    0.089080]    32regs    :  1717.000 MB/sec
[    0.129275]    rvv       :  7043.000 MB/sec
[    0.129525] xor: using function: rvv (7043.000 MB/sec)

Logs in qemu:
[    0.098943] xor: measuring software checksum speed
[    0.139391]    8regs     :  2911.000 MB/sec
[    0.181079]    32regs    :  2813.000 MB/sec
[    0.224260]    rvv       :    45.000 MB/sec
[    0.225586] xor: using function: 8regs (2911.000 MB/sec)

Co-developed-by: Han-Kuan Chen <hankuan.chen@sifive.com>
Signed-off-by: Han-Kuan Chen <hankuan.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/xor.h | 74 ++++++++++++++++++++++++++++++++
 arch/riscv/lib/Makefile      |  1 +
 arch/riscv/lib/xor.S         | 81 ++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 arch/riscv/include/asm/xor.h
 create mode 100644 arch/riscv/lib/xor.S

diff --git a/arch/riscv/include/asm/xor.h b/arch/riscv/include/asm/xor.h
new file mode 100644
index 000000000000..60ee0224913d
--- /dev/null
+++ b/arch/riscv/include/asm/xor.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 SiFive
+ */
+
+#include <linux/hardirq.h>
+#include <asm-generic/xor.h>
+#ifdef CONFIG_VECTOR
+#include <asm/vector.h>
+
+extern void xor_regs_2_(unsigned long bytes, unsigned long *p1,
+			unsigned long *p2);
+extern void xor_regs_3_(unsigned long bytes, unsigned long *p1,
+			unsigned long *p2, unsigned long *p3);
+extern void xor_regs_4_(unsigned long bytes, unsigned long *p1,
+			unsigned long *p2, unsigned long *p3,
+			unsigned long *p4);
+extern void xor_regs_5_(unsigned long bytes, unsigned long *p1,
+			unsigned long *p2, unsigned long *p3, unsigned long *p4,
+			unsigned long *p5);
+
+static void xor_rvv_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
+{
+	kernel_rvv_begin();
+	xor_regs_2_(bytes, p1, p2);
+	kernel_rvv_end();
+}
+
+static void
+xor_rvv_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+	  unsigned long *p3)
+{
+	kernel_rvv_begin();
+	xor_regs_3_(bytes, p1, p2, p3);
+	kernel_rvv_end();
+}
+
+static void
+xor_rvv_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+	  unsigned long *p3, unsigned long *p4)
+{
+	kernel_rvv_begin();
+	xor_regs_4_(bytes, p1, p2, p3, p4);
+	kernel_rvv_end();
+}
+
+static void
+xor_rvv_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
+	  unsigned long *p3, unsigned long *p4, unsigned long *p5)
+{
+	kernel_rvv_begin();
+	xor_regs_5_(bytes, p1, p2, p3, p4, p5);
+	kernel_rvv_end();
+}
+
+static struct xor_block_template xor_block_rvv = {
+	.name = "rvv",
+	.do_2 = xor_rvv_2,
+	.do_3 = xor_rvv_3,
+	.do_4 = xor_rvv_4,
+	.do_5 = xor_rvv_5
+};
+
+extern bool has_vector;
+#undef XOR_TRY_TEMPLATES
+#define XOR_TRY_TEMPLATES           \
+	do {        \
+		xor_speed(&xor_block_8regs);    \
+		xor_speed(&xor_block_32regs);    \
+		if (has_vector) { \
+			xor_speed(&xor_block_rvv);\
+		} \
+	} while (0)
+#endif
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 25d5c9664e57..acd87ac86d24 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -7,3 +7,4 @@ lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
+lib-$(CONFIG_VECTOR)	+= xor.o
diff --git a/arch/riscv/lib/xor.S b/arch/riscv/lib/xor.S
new file mode 100644
index 000000000000..de2e234c39ed
--- /dev/null
+++ b/arch/riscv/lib/xor.S
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 SiFive
+ */
+#include <linux/linkage.h>
+#include <asm-generic/export.h>
+#include <asm/asm.h>
+
+ENTRY(xor_regs_2_)
+	vsetvli a3, a0, e8, m8
+	vle8.v v0, (a1)
+	vle8.v v8, (a2)
+	sub a0, a0, a3
+	vxor.vv v16, v0, v8
+	add a2, a2, a3
+	vse8.v v16, (a1)
+	add a1, a1, a3
+	bnez a0, xor_regs_2_
+	ret
+END(xor_regs_2_)
+EXPORT_SYMBOL(xor_regs_2_)
+
+ENTRY(xor_regs_3_)
+	vsetvli a4, a0, e8, m8
+	vle8.v v0, (a1)
+	vle8.v v8, (a2)
+	sub a0, a0, a4
+	vxor.vv v0, v0, v8
+	vle8.v v16, (a3)
+	add a2, a2, a4
+	vxor.vv v16, v0, v16
+	add a3, a3, a4
+	vse8.v v16, (a1)
+	add a1, a1, a4
+	bnez a0, xor_regs_3_
+	ret
+END(xor_regs_3_)
+EXPORT_SYMBOL(xor_regs_3_)
+
+ENTRY(xor_regs_4_)
+	vsetvli a5, a0, e8, m8
+	vle8.v v0, (a1)
+	vle8.v v8, (a2)
+	sub a0, a0, a5
+	vxor.vv v0, v0, v8
+	vle8.v v16, (a3)
+	add a2, a2, a5
+	vxor.vv v0, v0, v16
+	vle8.v v24, (a4)
+	add a3, a3, a5
+	vxor.vv v16, v0, v24
+	add a4, a4, a5
+	vse8.v v16, (a1)
+	add a1, a1, a5
+	bnez a0, xor_regs_4_
+	ret
+END(xor_regs_4_)
+EXPORT_SYMBOL(xor_regs_4_)
+
+ENTRY(xor_regs_5_)
+	vsetvli a6, a0, e8, m8
+	vle8.v v0, (a1)
+	vle8.v v8, (a2)
+	sub a0, a0, a6
+	vxor.vv v0, v0, v8
+	vle8.v v16, (a3)
+	add a2, a2, a6
+	vxor.vv v0, v0, v16
+	vle8.v v24, (a4)
+	add a3, a3, a6
+	vxor.vv v0, v0, v24
+	vle8.v v8, (a5)
+	add a4, a4, a6
+	vxor.vv v16, v0, v8
+	add a5, a5, a6
+	vse8.v v16, (a1)
+	add a1, a1, a6
+	bnez a0, xor_regs_5_
+	ret
+END(xor_regs_5_)
+EXPORT_SYMBOL(xor_regs_5_)
-- 
2.31.1

