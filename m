Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177CF32A3B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382505AbhCBJ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:26:48 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:60077 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378888AbhCBJFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:05:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UQ4AnOs_1614675901;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UQ4AnOs_1614675901)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Mar 2021 17:05:01 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jaharkes@cs.cmu.edu
Cc:     coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] coda: switch to vmemdup_user()
Date:   Tue,  2 Mar 2021 17:04:59 +0800
Message-Id: <1614675899-88091-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace opencoded alloc and copy with vmemdup_user()

fixed the following coccicheck:
./fs/coda/psdev.c:125:10-18: WARNING opportunity for vmemdup_user

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/coda/psdev.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index 240669f..8d38e92 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -122,14 +122,9 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 				hdr.opcode, hdr.unique);
 		        nbytes = size;
 		}
-		dcbuf = kvmalloc(nbytes, GFP_KERNEL);
-		if (!dcbuf) {
-			retval = -ENOMEM;
-			goto out;
-		}
-		if (copy_from_user(dcbuf, buf, nbytes)) {
-			kvfree(dcbuf);
-			retval = -EFAULT;
+		dcbuf = vmemdup_user(buf, nbytes)
+		if (IS_ERR(dcbuf)) {
+			r = PTR_ERR(dcbuf);
 			goto out;
 		}
 
-- 
1.8.3.1

