Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A26944D532
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 11:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhKKKo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 05:44:59 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15816 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhKKKo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 05:44:58 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HqdZ75xLzz90nF;
        Thu, 11 Nov 2021 18:41:51 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 11 Nov 2021 18:42:07 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 11 Nov
 2021 18:42:06 +0800
From:   Guo Xuenan <guoxuenan@huawei.com>
To:     <guoxuenan@huawei.com>
CC:     <akpm@linux-foundation.org>, <cy.fan@huawei.com>, <cyan@fb.com>,
        <fangwei1@huawei.com>, <hsiangkao@linux.alibaba.com>,
        <linux-kernel@vger.kernel.org>,
        <syzbot+63d688f1d899c588fb71@syzkaller.appspotmail.com>,
        <terrelln@fb.com>, <wangli74@huawei.com>
Subject: [PATCH v3] lz4: fix LZ4_decompress_safe_partial read out of bound
Date:   Thu, 11 Nov 2021 18:50:48 +0800
Message-ID: <20211111105048.2006070-1-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111085058.1940591-1-guoxuenan@huawei.com>
References: <20211111085058.1940591-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When partialDecoding, it is EOF if we've either, filled the output
buffer or can't proceed with reading an offset for following match.

In some extreme corner cases when compressed data is crusted corrupted,
UAF will occur. As reported by KASAN [1], LZ4_decompress_safe_partial
may lead to read out of bound problem during decoding. lz4 upstream has
fixed it [2] and this issue has been disscussed here [3] before.

current decompression routine was ported from lz4 v1.8.3, bumping lib/lz4
to v1.9.+ is certainly a huge work to be done later, so, we'd better fix
it first.

[1] https://lore.kernel.org/all/000000000000830d1205cf7f0477@google.com/
[2] https://github.com/lz4/lz4/commit/c5d6f8a8be3927c0bec91bcc58667a6cfad244ad#
[3] https://lore.kernel.org/all/CC666AE8-4CA4-4951-B6FB-A2EFDE3AC03B@fb.com/

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

