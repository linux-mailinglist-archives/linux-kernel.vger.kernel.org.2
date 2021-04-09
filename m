Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FEA359991
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhDIJnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:43:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15997 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhDIJng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:43:36 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGtRp1X6QzvS3Y;
        Fri,  9 Apr 2021 17:41:10 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 17:43:16 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <yebin10@huawei.com>, Christine Caulfield <ccaulfie@redhat.com>,
        "David Teigland" <teigland@redhat.com>
CC:     <cluster-devel@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] dlm: use DEFINE_MUTEX() for mutex lock
Date:   Fri, 9 Apr 2021 17:51:41 +0800
Message-ID: <20210409095141.2293982-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/dlm/debug_fs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index d5bd990bcab8..327a69598de5 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -20,7 +20,7 @@
 
 #define DLM_DEBUG_BUF_LEN 4096
 static char debug_buf[DLM_DEBUG_BUF_LEN];
-static struct mutex debug_buf_lock;
+static DEFINE_MUTEX(debug_buf_lock);
 
 static struct dentry *dlm_root;
 
@@ -795,7 +795,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 
 void __init dlm_register_debugfs(void)
 {
-	mutex_init(&debug_buf_lock);
 	dlm_root = debugfs_create_dir("dlm", NULL);
 }
 

