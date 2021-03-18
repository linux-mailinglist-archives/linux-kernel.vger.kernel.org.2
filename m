Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC6D340827
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhCROvg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 Mar 2021 10:51:36 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3369 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbhCROvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:51:10 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4F1VJp4ggpz5Hdt;
        Thu, 18 Mar 2021 22:48:42 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 18 Mar 2021 22:51:06 +0800
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 22:51:07 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2106.013;
 Thu, 18 Mar 2021 22:51:07 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        "weiyongjun (A)" <weiyongjun1@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
Subject: [RESEND PATCH] Kconfig: Move CONFIG_DEBUG_KMEMLEAK_TEST to
 samples/Kconfig
Thread-Topic: [RESEND PATCH] Kconfig: Move CONFIG_DEBUG_KMEMLEAK_TEST to
 samples/Kconfig
Thread-Index: AQHXHAYg8d9cii4PGkmLX5bvg0mNFw==
Date:   Thu, 18 Mar 2021 14:51:07 +0000
Message-ID: <e3e03188672c48dfb187e6683ea63308@huawei.com>
References: <20201022021234.6638-1-chenjun102@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.53]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Jun <chenjun102@huawei.com>

commit 1abbef4f51724fb11f09adf0e75275f7cb422a8a
("mm,kmemleak-test.c: move kmemleak-test.c to samples dir")
make CONFIG_DEBUG_KMEMLEAK_TEST depend on CONFIG_SAMPLES implicitly.
And the dependency cannot be guaranteed by Kconfig.

move the definition of CONFIG_DEBUG_KMEMLEAK_TEST from lib/Kconfig.debug
to samples/Kconfig.

Signed-off-by: Chen Jun <chenjun102@huawei.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---

  lib/Kconfig.debug | 8 --------
  samples/Kconfig   | 8 ++++++++
  2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 66d44d3..debacdc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -678,14 +678,6 @@ config DEBUG_KMEMLEAK_MEM_POOL_SIZE
  	  fully initialised, this memory pool acts as an emergency one
  	  if slab allocations fail.

-config DEBUG_KMEMLEAK_TEST
-	tristate "Simple test for the kernel memory leak detector"
-	depends on DEBUG_KMEMLEAK && m
-	help
-	  This option enables a module that explicitly leaks memory.
-
-	  If unsure, say N.
-
  config DEBUG_KMEMLEAK_DEFAULT_OFF
  	bool "Default kmemleak to off"
  	depends on DEBUG_KMEMLEAK
diff --git a/samples/Kconfig b/samples/Kconfig
index 0ed6e4d..15978dd 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -216,4 +216,12 @@ config SAMPLE_WATCH_QUEUE
  	  Build example userspace program to use the new mount_notify(),
  	  sb_notify() syscalls and the KEYCTL_WATCH_KEY keyctl() function.

+config DEBUG_KMEMLEAK_TEST
+	tristate "Simple test for the kernel memory leak detector"
+	depends on DEBUG_KMEMLEAK && m
+	help
+	  This option enables a module that explicitly leaks memory.
+
+	  If unsure, say N.
+
  endif # SAMPLES
-- 
2.7.4

