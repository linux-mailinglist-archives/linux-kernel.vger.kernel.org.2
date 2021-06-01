Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FFA3974C4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhFAOAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:00:42 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3494 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbhFAOAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:00:41 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FvYbd62nhzYs4B;
        Tue,  1 Jun 2021 21:56:13 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 21:58:52 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 1 Jun
 2021 21:58:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <colyli@suse.de>, <akpm@linux-foundation.org>,
        <grandmaster@al2klimov.de>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] lib: crc64: Fix kernel-doc warning
Date:   Tue, 1 Jun 2021 21:58:51 +0800
Message-ID: <20210601135851.15444-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 kernel build warning:

lib/crc64.c:40: warning:
 bad line:         or the previous crc64 value if computing incrementally.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 lib/crc64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/crc64.c b/lib/crc64.c
index 47cfa054827f..9f852a89ee2a 100644
--- a/lib/crc64.c
+++ b/lib/crc64.c
@@ -37,7 +37,7 @@ MODULE_LICENSE("GPL v2");
 /**
  * crc64_be - Calculate bitwise big-endian ECMA-182 CRC64
  * @crc: seed value for computation. 0 or (u64)~0 for a new CRC calculation,
-	or the previous crc64 value if computing incrementally.
+ *       or the previous crc64 value if computing incrementally.
  * @p: pointer to buffer over which CRC64 is run
  * @len: length of buffer @p
  */
-- 
2.17.1

