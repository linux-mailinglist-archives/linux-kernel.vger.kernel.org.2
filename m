Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EB4394C13
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 13:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhE2Lub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 07:50:31 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:2355 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhE2Lu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 07:50:29 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fsfpj4Z22z1BFXH;
        Sat, 29 May 2021 19:44:13 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 19:48:51 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 29
 May 2021 19:48:50 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sfrench@samba.org>
CC:     <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] cifs: Remove unused inline function is_sysvol_or_netlogon()
Date:   Sat, 29 May 2021 19:48:48 +0800
Message-ID: <20210529114848.19608-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_sysvol_or_netlogon() is never used, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/cifs/dfs_cache.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index b1fa30fefe1f..03c81c39a507 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -319,17 +319,6 @@ static inline unsigned int cache_entry_hash(const void *data, int size)
 	return h & (CACHE_HTABLE_SIZE - 1);
 }
 
-/* Check whether second path component of @path is SYSVOL or NETLOGON */
-static inline bool is_sysvol_or_netlogon(const char *path)
-{
-	const char *s;
-	char sep = path[0];
-
-	s = strchr(path + 1, sep) + 1;
-	return !strncasecmp(s, "sysvol", strlen("sysvol")) ||
-		!strncasecmp(s, "netlogon", strlen("netlogon"));
-}
-
 /* Return target hint of a DFS cache entry */
 static inline char *get_tgt_name(const struct cache_entry *ce)
 {
-- 
2.17.1

