Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A52387265
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 08:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346801AbhERGp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 02:45:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3578 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240404AbhERGpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 02:45:25 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FkmcF0jxJzmVMm;
        Tue, 18 May 2021 14:41:17 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 14:44:01 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 14:44:01 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] Decompressors: remove unused variable 'level' in parse_header()
Date:   Tue, 18 May 2021 14:43:54 +0800
Message-ID: <20210518064354.7537-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC reports the following warning with W=1:

lib/decompress_unlzo.c:46:5: warning:
 variable 'level' set but not used [-Wunused-but-set-variable]
   46 |  u8 level = 0;
      |     ^~~~~

This variable is not used, remove it to fix the warning.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/decompress_unlzo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/decompress_unlzo.c b/lib/decompress_unlzo.c
index 1f439a622076..64c1358500ce 100644
--- a/lib/decompress_unlzo.c
+++ b/lib/decompress_unlzo.c
@@ -43,7 +43,6 @@ STATIC inline long INIT parse_header(u8 *input, long *skip, long in_len)
 	int l;
 	u8 *parse = input;
 	u8 *end = input + in_len;
-	u8 level = 0;
 	u16 version;
 
 	/*
@@ -65,7 +64,7 @@ STATIC inline long INIT parse_header(u8 *input, long *skip, long in_len)
 	version = get_unaligned_be16(parse);
 	parse += 7;
 	if (version >= 0x0940)
-		level = *parse++;
+		parse++;
 	if (get_unaligned_be32(parse) & HEADER_HAS_FILTER)
 		parse += 8; /* flags + filter info */
 	else
-- 
2.25.1


