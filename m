Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAC93AA84A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 02:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhFQAzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 20:55:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7459 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhFQAzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 20:55:42 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G53Pn4blrzZj4k;
        Thu, 17 Jun 2021 08:50:37 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 08:53:33 +0800
Received: from ubuntu1804.huawei.com (10.67.174.98) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 08:53:33 +0800
From:   Pu Lehui <pulehui@huawei.com>
To:     <keescook@chromium.org>, <anton@enomsg.org>, <ccross@android.com>,
        <tony.luck@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <pulehui@huawei.com>,
        <zhangjinhao2@huawei.com>
Subject: [PATCH -next] pstore/blk: Fix return value check in pstore_blk_init()
Date:   Thu, 17 Jun 2021 08:54:24 +0800
Message-ID: <20210617005424.182305-1-pulehui@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.98]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500019.china.huawei.com (7.185.36.180)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the return value check which testing the wrong variable
in pstore_blk_init().

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 fs/pstore/blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
index ccfb11ee4d50..d5e22e6209a6 100644
--- a/fs/pstore/blk.c
+++ b/fs/pstore/blk.c
@@ -287,7 +287,7 @@ static int __init pstore_blk_init(void)
 		struct pstore_device_info *best_effort_dev;
 
 		best_effort_dev = kzalloc(sizeof(*best_effort_dev), GFP_KERNEL);
-		if (!best_effort) {
+		if (!best_effort_dev) {
 			ret = -ENOMEM;
 			goto unlock;
 		}
-- 
2.17.1

