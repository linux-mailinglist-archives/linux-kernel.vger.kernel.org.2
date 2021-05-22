Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A611638D4BD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 11:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhEVJY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 05:24:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4583 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhEVJYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 05:24:52 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FnHyG0pZxzsSvh;
        Sat, 22 May 2021 17:20:38 +0800 (CST)
Received: from dggeme703-chm.china.huawei.com (10.1.199.99) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 17:23:26 +0800
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 22
 May 2021 17:23:25 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <sjenning@redhat.com>,
        <ddstreet@ieee.org>, <vitaly.wool@konsulko.com>
CC:     <bigeasy@linutronix.de>, <nathan@kernel.org>,
        <colin.king@canonical.com>, <tiantao6@hisilicon.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 1/3] mm/zswap.c: remove unused function zswap_debugfs_exit()
Date:   Sat, 22 May 2021 17:22:40 +0800
Message-ID: <20210522092242.3233191-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210522092242.3233191-1-linmiaohe@huawei.com>
References: <20210522092242.3233191-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zswap_debugfs_exit() is unused, remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/zswap.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 20763267a219..e93459319fdb 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1427,18 +1427,11 @@ static int __init zswap_debugfs_init(void)
 
 	return 0;
 }
-
-static void __exit zswap_debugfs_exit(void)
-{
-	debugfs_remove_recursive(zswap_debugfs_root);
-}
 #else
 static int __init zswap_debugfs_init(void)
 {
 	return 0;
 }
-
-static void __exit zswap_debugfs_exit(void) { }
 #endif
 
 /*********************************
-- 
2.23.0

