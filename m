Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57970457ADD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 04:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhKTDqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 22:46:08 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28160 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbhKTDqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 22:46:00 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HwzpW4t4Xz8vRh;
        Sat, 20 Nov 2021 11:41:07 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 20 Nov 2021 11:42:54 +0800
Received: from use12-sp2.huawei.com (10.67.189.20) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 20 Nov 2021 11:42:54 +0800
From:   Jubin Zhong <zhongjubin@huawei.com>
To:     <lasse.collin@tukaani.org>, <akpm@linux-foundation.org>
CC:     <wangfangpeng1@huawei.com>, <liaohua4@huawei.com>,
        <zhongjubin@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] kbuild: Enable armthumb BCJ filter for Thumb-2 kernel
Date:   Sat, 20 Nov 2021 11:42:51 +0800
Message-ID: <1637379771-39449-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.20]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xz_wrap.sh use $SRCARCH to detect the BCJ filter. However, assigning
arm BCJ filter to Thumb-2 kernel is not optimal. In my case, about 5%
decrease of image size is observed with armthumb BCJ filter:

Test results:
  hardware:      QEMU emulator version 3.1.0
  config:        vexpress_defconfig with THUMB2_KERNEL & KERNEL_XZ on
  arm BCJ:       4029808
  armthumb BCJ:  3827280

Choose armthumb BCJ filter for Thumb-2 kernel to make smaller images.

Signed-off-by: Jubin Zhong <zhongjubin@huawei.com>

----
v1:
https://lore.kernel.org/lkml/1637323647-19988-1-git-send-email-zhongjubin@huawei.com/
---
 lib/decompress_unxz.c | 6 +++++-
 scripts/xz_wrap.sh    | 6 ++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/decompress_unxz.c b/lib/decompress_unxz.c
index 9f4262e..9d9cb48 100644
--- a/lib/decompress_unxz.c
+++ b/lib/decompress_unxz.c
@@ -129,7 +129,11 @@
 #	define XZ_DEC_POWERPC
 #endif
 #ifdef CONFIG_ARM
-#	define XZ_DEC_ARM
+#	ifdef CONFIG_THUMB2_KERNEL
+#		define XZ_DEC_ARMTHUMB
+#	else
+#		define XZ_DEC_ARM
+#	endif
 #endif
 #ifdef CONFIG_IA64
 #	define XZ_DEC_IA64
diff --git a/scripts/xz_wrap.sh b/scripts/xz_wrap.sh
index 76e9cbc..3824fdf 100755
--- a/scripts/xz_wrap.sh
+++ b/scripts/xz_wrap.sh
@@ -9,6 +9,8 @@
 # You can do whatever you want with this file.
 #
 
+. include/config/auto.conf
+
 BCJ=
 LZMA2OPTS=
 
@@ -20,4 +22,8 @@ case $SRCARCH in
 	sparc)          BCJ=--sparc ;;
 esac
 
+if [ -n "${CONFIG_THUMB2_KERNEL}" ]; then
+	BCJ=--armthumb
+fi
+
 exec $XZ --check=crc32 $BCJ --lzma2=$LZMA2OPTS,dict=32MiB
-- 
1.8.5.6

