Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF7D3F3D20
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 04:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhHVCXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 22:23:03 -0400
Received: from mx20.baidu.com ([111.202.115.85]:34822 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229571AbhHVCXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 22:23:03 -0400
Received: from BC-Mail-Ex05.internal.baidu.com (unknown [172.31.51.45])
        by Forcepoint Email with ESMTPS id 7613EDB7DEEE151A9891;
        Sun, 22 Aug 2021 10:22:21 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex05.internal.baidu.com (172.31.51.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sun, 22 Aug 2021 10:22:21 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.62.17) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sun, 22 Aug 2021 10:22:20 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <ason.wessel@windriver.com>, <daniel.thompson@linaro.org>,
        <dianders@chromium.org>
CC:     <kgdb-bugreport@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH] kernel: debug: Convert to SPDX identifier
Date:   Sun, 22 Aug 2021 10:22:06 +0800
Message-ID: <20210822022206.221-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.32.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.31.62.17]
X-ClientProxiedBy: BC-Mail-Ex17.internal.baidu.com (172.31.51.11) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use SPDX-License-Identifier instead of a verbose license text

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 kernel/debug/debug_core.c | 5 +----
 kernel/debug/gdbstub.c    | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index b4aa6bb6b2bd..da06a5553835 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Kernel Debug Core
  *
@@ -22,10 +23,6 @@
  *
  * Original KGDB stub: David Grothe <dave@gcom.com>,
  * Tigran Aivazian <tigran@sco.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "KGDB: " fmt
diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index b6f28fad4307..9d34d2364b5a 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Kernel Debug Core
  *
@@ -22,10 +23,6 @@
  *
  * Original KGDB stub: David Grothe <dave@gcom.com>,
  * Tigran Aivazian <tigran@sco.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
-- 
2.25.1

