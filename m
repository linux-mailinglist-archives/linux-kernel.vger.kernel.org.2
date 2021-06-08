Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA2439EF47
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhFHHNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:13:42 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8075 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhFHHNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:13:32 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzhDK5b1JzYrlk;
        Tue,  8 Jun 2021 15:08:49 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:11:38 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:11:38 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 5/5] lib: remove trailing spaces and tabs
Date:   Tue, 8 Jun 2021 15:11:17 +0800
Message-ID: <20210608071117.12634-6-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210608071117.12634-1-thunder.leizhen@huawei.com>
References: <20210608071117.12634-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Run the following command to find and remove the trailing spaces and tabs:

find lib/ -type f | xargs sed -r -i 's/[ \t]+$//'

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/Kconfig      | 2 +-
 lib/libcrc32c.c  | 2 +-
 lib/textsearch.c | 4 ++--
 lib/ts_kmp.c     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index ac3b30697b2b..b0807d988491 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -357,7 +357,7 @@ config GENERIC_ALLOCATOR
 #
 config REED_SOLOMON
 	tristate
-	
+
 config REED_SOLOMON_ENC8
 	bool
 
diff --git a/lib/libcrc32c.c b/lib/libcrc32c.c
index 5ca0d815a95d..824415b757c2 100644
--- a/lib/libcrc32c.c
+++ b/lib/libcrc32c.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/* 
+/*
  * CRC32C
  *@Article{castagnoli-crc,
  * author =       { Guy Castagnoli and Stefan Braeuer and Martin Herrman},
diff --git a/lib/textsearch.c b/lib/textsearch.c
index f68dea8806be..d8dae46b75a5 100644
--- a/lib/textsearch.c
+++ b/lib/textsearch.c
@@ -266,7 +266,7 @@ struct ts_config *textsearch_prepare(const char *algo, const void *pattern,
 	int err = -ENOENT;
 	struct ts_config *conf;
 	struct ts_ops *ops;
-	
+
 	if (len == 0)
 		return ERR_PTR(-EINVAL);
 
@@ -298,7 +298,7 @@ struct ts_config *textsearch_prepare(const char *algo, const void *pattern,
 errout:
 	if (ops)
 		module_put(ops->owner);
-		
+
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL(textsearch_prepare);
diff --git a/lib/ts_kmp.c b/lib/ts_kmp.c
index c77a3d537f24..c57511d5fc7a 100644
--- a/lib/ts_kmp.c
+++ b/lib/ts_kmp.c
@@ -5,7 +5,7 @@
  * Authors:	Thomas Graf <tgraf@suug.ch>
  *
  * ==========================================================================
- * 
+ *
  *   Implements a linear-time string-matching algorithm due to Knuth,
  *   Morris, and Pratt [1]. Their algorithm avoids the explicit
  *   computation of the transition function DELTA altogether. Its
-- 
2.25.1


