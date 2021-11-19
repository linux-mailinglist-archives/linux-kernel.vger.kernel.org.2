Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3DF456EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 13:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhKSMKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 07:10:38 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26332 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhKSMKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 07:10:37 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HwZzZ4pBgzbhvX;
        Fri, 19 Nov 2021 20:02:34 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 19 Nov 2021 20:07:31 +0800
Received: from use12-sp2.huawei.com (10.67.189.20) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 19 Nov 2021 20:07:31 +0800
From:   Jubin Zhong <zhongjubin@huawei.com>
To:     <lasse.collin@tukaani.org>, <akpm@linux-foundation.org>
CC:     <wangfangpeng1@huawei.com>, <liaohua4@huawei.com>,
        <zhongjubin@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] kbuild: Enable armthumb BCJ filter for Thumb-2 kernel
Date:   Fri, 19 Nov 2021 20:07:27 +0800
Message-ID: <1637323647-19988-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.20]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
---
 lib/decompress_unxz.c | 3 +++
 scripts/xz_wrap.sh    | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/lib/decompress_unxz.c b/lib/decompress_unxz.c
index 9f4262e..7d6b952 100644
--- a/lib/decompress_unxz.c
+++ b/lib/decompress_unxz.c
@@ -131,6 +131,9 @@
 #ifdef CONFIG_ARM
 #	define XZ_DEC_ARM
 #endif
+#ifdef CONFIG_THUMB2_KERNEL
+#	define XZ_DEC_ARMTHUMB
+#endif
 #ifdef CONFIG_IA64
 #	define XZ_DEC_IA64
 #endif
diff --git a/scripts/xz_wrap.sh b/scripts/xz_wrap.sh
index 76e9cbc..47409bb 100755
--- a/scripts/xz_wrap.sh
+++ b/scripts/xz_wrap.sh
@@ -8,6 +8,7 @@
 # This file has been put into the public domain.
 # You can do whatever you want with this file.
 #
+. include/config/auto.conf
 
 BCJ=
 LZMA2OPTS=
@@ -20,4 +21,8 @@ case $SRCARCH in
 	sparc)          BCJ=--sparc ;;
 esac
 
+if [ -n "${CONFIG_THUMB2_KERNEL}" ];then
+	BCJ=--armthumb
+fi
+
 exec $XZ --check=crc32 $BCJ --lzma2=$LZMA2OPTS,dict=32MiB
-- 
1.8.5.6

