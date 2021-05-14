Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CB738038E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 08:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhENGOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 02:14:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3680 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhENGOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 02:14:38 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FhJ6r048tz16Pp4;
        Fri, 14 May 2021 14:10:43 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Fri, 14 May 2021
 14:13:17 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <albin.tonnerre@free-electrons.com>, <rmk@arm.linux.org.uk>,
        <hpa@zytor.com>, <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] lib/decompressors: remove set but not used variabled 'level'
Date:   Fri, 14 May 2021 14:20:50 +0800
Message-ID: <20210514062050.3532344-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

lib/decompress_unlzo.c:46:5: warning: variable ‘level’ set but
not used [-Wunused-but-set-variable]

It is never used and so can be removed.

Fixes: 7dd65feb6c60 ("lib: add support for LZO-compressed kernels")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/decompress_unlzo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/decompress_unlzo.c b/lib/decompress_unlzo.c
index 1f439a622076..6a21c0d2fc3d 100644
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
+		*parse++;
 	if (get_unaligned_be32(parse) & HEADER_HAS_FILTER)
 		parse += 8; /* flags + filter info */
 	else
-- 
2.25.4

