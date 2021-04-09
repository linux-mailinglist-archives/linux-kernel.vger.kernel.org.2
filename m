Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E46359198
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 03:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhDIBoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 21:44:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15632 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbhDIBoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:44:19 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGgp44MKQznZ1x;
        Fri,  9 Apr 2021 09:41:16 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 09:43:57 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Markus F . X . J . Oberhumer" <markus@oberhumer.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] lib/lzo: remove unused local variable 'level'
Date:   Fri, 9 Apr 2021 09:43:39 +0800
Message-ID: <20210409014339.3145-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning:

lib/decompress_unlzo.c: In function ‘parse_header’:
lib/decompress_unlzo.c:46:5: warning: variable ‘level’ set but not used [-Wunused-but-set-variable]

Fixes: 7dd65feb6c60 ("lib: add support for LZO-compressed kernels")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/decompress_unlzo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/decompress_unlzo.c b/lib/decompress_unlzo.c
index 1f439a622076c10..64c1358500ce4e9 100644
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
2.26.0.106.g9fadedd


