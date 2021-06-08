Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D922639EC19
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 04:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhFHCd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 22:33:27 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3090 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhFHCdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 22:33:22 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzYyk4vlCzWthl
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 10:26:38 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 10:31:29 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 10:31:28 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] argv_split: fix doc warnings in argv_split.c
Date:   Tue, 8 Jun 2021 10:40:39 +0800
Message-ID: <20210608024039.2748699-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for `argv_free` to fix the W=1 warnings:

lib/argv_split.c:36: warning: Function parameter or
 member 'argv' not described in 'argv_free'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 lib/argv_split.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/argv_split.c b/lib/argv_split.c
index 1a19a0a93dc1..451ecea43b2c 100644
--- a/lib/argv_split.c
+++ b/lib/argv_split.c
@@ -28,7 +28,7 @@ static int count_argc(const char *str)
 
 /**
  * argv_free - free an argv
- * @argv - the argument vector to be freed
+ * @argv: the argument vector to be freed
  *
  * Frees an argv and the strings it points to.
  */
-- 
2.31.1

