Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F59392A24
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbhE0I5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:57:18 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2369 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbhE0I5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:57:17 -0400
Received: from dggeml758-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FrM502qRrz65qM;
        Thu, 27 May 2021 16:52:04 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggeml758-chm.china.huawei.com (10.1.199.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 16:55:42 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 27 May
 2021 16:55:41 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <jaharkes@cs.cmu.edu>, <coda@cs.cmu.edu>,
        <codalist@coda.cs.cmu.edu>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] coda: Remove set but not used variable 'err'
Date:   Thu, 27 May 2021 17:05:10 +0800
Message-ID: <20210527090510.3874315-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

fs/coda/file.c: In function 'coda_release':
fs/coda/file.c:241:6: warning:
 variable ‘err’ set but not used [-Wunused-but-set-variable]

It never used since introduction.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/coda/file.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/coda/file.c b/fs/coda/file.c
index ef5ca22bfb3e..98eb543d4acc 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -238,12 +238,11 @@ int coda_release(struct inode *coda_inode, struct file *coda_file)
 	struct coda_file_info *cfi;
 	struct coda_inode_info *cii;
 	struct inode *host_inode;
-	int err;
 
 	cfi = coda_ftoc(coda_file);
 
-	err = venus_close(coda_inode->i_sb, coda_i2f(coda_inode),
-			  coda_flags, coda_file->f_cred->fsuid);
+	venus_close(coda_inode->i_sb, coda_i2f(coda_inode),
+		    coda_flags, coda_file->f_cred->fsuid);
 
 	host_inode = file_inode(cfi->cfi_container);
 	cii = ITOC(coda_inode);
-- 
2.25.4

