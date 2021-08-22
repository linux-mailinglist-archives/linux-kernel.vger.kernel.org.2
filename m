Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBBC3F3D18
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 04:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhHVCQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 22:16:54 -0400
Received: from mx20.baidu.com ([111.202.115.85]:58290 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229571AbhHVCQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 22:16:54 -0400
Received: from BC-Mail-HQEX01.internal.baidu.com (unknown [172.31.51.57])
        by Forcepoint Email with ESMTPS id EF249EA66DA391539996;
        Sun, 22 Aug 2021 10:16:10 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-HQEX01.internal.baidu.com (172.31.51.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sun, 22 Aug 2021 10:16:10 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.62.20) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sun, 22 Aug 2021 10:16:10 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <oberpar@linux.ibm.com>, <nathan@kernel.org>,
        <ndesaulniers@google.com>
CC:     <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>,
        "Cai Huoqing" <caihuoqing@baidu.com>
Subject: [PATCH] gcov: clang: Remove repeated verbose license text
Date:   Sun, 22 Aug 2021 10:15:42 +0800
Message-ID: <20210822021542.2-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.32.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.31.62.20]
X-ClientProxiedBy: BC-Mail-Ex17.internal.baidu.com (172.31.51.11) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove it because SPDX-License-Identifier is already used

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 kernel/gcov/clang.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
index cbb0bed958ab..b97a922b36b7 100644
--- a/kernel/gcov/clang.c
+++ b/kernel/gcov/clang.c
@@ -3,16 +3,6 @@
  * Copyright (C) 2019 Google, Inc.
  * modified from kernel/gcov/gcc_4_7.c
  *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- *
  * LLVM uses profiling data that's deliberately similar to GCC, but has a
  * very different way of exporting that data.  LLVM calls llvm_gcov_init() once
  * per module, and provides a couple of callbacks that we can use to ask for
-- 
2.25.1

