Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B3A44D237
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 08:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhKKHOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 02:14:04 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:27197 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhKKHOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 02:14:03 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HqXsD0PShz8vLh;
        Thu, 11 Nov 2021 15:09:36 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 11 Nov 2021 15:11:13 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 11 Nov
 2021 15:11:12 +0800
From:   Guo Xuenan <guoxuenan@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <hsiangkao@redhat.com>,
        <terrelln@fb.com>, <cyan@fb.com>, <cy.fan@huawei.com>,
        <fangwei1@huawei.com>, <wangli74@huawei.com>,
        <guoxuenan@huawei.com>,
        <syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com>,
        <hsiangkao@linux.alibaba.com>
Subject: [PATCH] lz4: fix LZ4_decompress_safe_partial read out of bound
Date:   Thu, 11 Nov 2021 15:17:59 +0800
Message-ID: <20211111071759.1825086-1-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When partialDecoding, it is EOF if we've either, filled the output
buffer or can't proceed with reading an offset for following match.

As reported by KASAN[1], LZ4_decompress_safe_partial may lead
to erofs decoding read out of bound. Fortunately, lz4 upstream has
fixed it [2]. current decompression routine was ported from lz4 v1.8.3,
so, we can fix it, before bumping lib/lz4 to v1.9.+.

[1] https://syzkaller.appspot.com/bug?extid=63d688f1d899c588fb71
[2] https://github.com/lz4/lz4/commit/c5d6f8a8be3927c0bec91bcc58667a6cfad244ad#

Reported-by: syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com
Cc: hsiangkao@linux.alibaba.com
Cc: terrelln@fb.com
Cc: cyan@fb.com
Cc: cy.fan@huawei.com
Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
---
 lib/lz4/lz4_decompress.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
index 926f4823d5ea..fd1728d94bab 100644
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -271,8 +271,12 @@ static FORCE_INLINE int LZ4_decompress_generic(
 			ip += length;
 			op += length;
 
-			/* Necessarily EOF, due to parsing restrictions */
-			if (!partialDecoding || (cpy == oend))
+			/* Necessarily EOF when !partialDecoding.
+			 * When partialDecoding, it is EOF if we've either
+			 * filled the output buffer or
+			 * can't proceed with reading an offset for following match.
+			 */
+			if (!partialDecoding || (cpy == oend) || (ip >= (iend - 2)))
 				break;
 		} else {
 			/* may overwrite up to WILDCOPYLENGTH beyond cpy */
-- 
2.31.1

