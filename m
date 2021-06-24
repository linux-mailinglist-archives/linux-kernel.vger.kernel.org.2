Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6A23B2F37
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhFXMmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:42:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5070 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhFXMmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:42:51 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G9fjf3SYTzXkPM;
        Thu, 24 Jun 2021 20:35:18 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 24
 Jun 2021 20:40:30 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <ngupta@vflare.org>
CC:     <senozhatsky@chromium.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH 1/3] mm/zsmalloc.c: remove confusing code in obj_free()
Date:   Thu, 24 Jun 2021 20:39:28 +0800
Message-ID: <20210624123930.1769093-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210624123930.1769093-1-linmiaohe@huawei.com>
References: <20210624123930.1769093-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OBJ_ALLOCATED_TAG is only set for handle to indicate allocated object. It's
irrelevant with obj. So remove this misleading code to improve readability.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/zsmalloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 0b0addd34ea6..1476289b619f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1471,7 +1471,6 @@ static void obj_free(struct size_class *class, unsigned long obj)
 	unsigned int f_objidx;
 	void *vaddr;
 
-	obj &= ~OBJ_ALLOCATED_TAG;
 	obj_to_location(obj, &f_page, &f_objidx);
 	f_offset = (class->size * f_objidx) & ~PAGE_MASK;
 	zspage = get_zspage(f_page);
-- 
2.23.0

