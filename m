Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F94394B0F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 10:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhE2ISP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 04:18:15 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5140 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhE2ISL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 04:18:11 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FsZ811ZpXzYnYd;
        Sat, 29 May 2021 16:13:53 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 16:16:32 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 29 May
 2021 16:16:31 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-cifsd-devel@lists.sourceforge.net>,
        <linux-cifs@vger.kernel.org>
CC:     <namjae.jeon@samsung.com>, <sergey.senozhatsky@gmail.com>,
        <sfrench@samba.org>, <hyc.lee@gmail.com>
Subject: [PATCH -next 3/3] cifsd: check return value of ksmbd_vfs_getcasexattr() correctly
Date:   Sat, 29 May 2021 16:20:58 +0800
Message-ID: <20210529082058.3012233-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210529082058.3012233-1-yangyingliang@huawei.com>
References: <20210529082058.3012233-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ksmbd_vfs_getcasexattr() returns -ENOMEM, stream_buf is NULL,
it will cause null-ptr-deref when using it to copy memory. So we
need check the return value of ksmbd_vfs_getcasexattr() by comparing
with 0.

Fixes: f44158485826 ("cifsd: add file operations")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 fs/cifsd/vfs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/cifsd/vfs.c b/fs/cifsd/vfs.c
index 97d5584ec870..45ba30f1f2d2 100644
--- a/fs/cifsd/vfs.c
+++ b/fs/cifsd/vfs.c
@@ -274,7 +274,6 @@ static int ksmbd_vfs_stream_read(struct ksmbd_file *fp, char *buf, loff_t *pos,
 {
 	ssize_t v_len;
 	char *stream_buf = NULL;
-	int err;
 
 	ksmbd_debug(VFS, "read stream data pos : %llu, count : %zd\n",
 		    *pos, count);
@@ -283,10 +282,9 @@ static int ksmbd_vfs_stream_read(struct ksmbd_file *fp, char *buf, loff_t *pos,
 				       fp->stream.name,
 				       fp->stream.size,
 				       &stream_buf);
-	if (v_len == -ENOENT) {
+	if ((int)v_len < 0) {
 		ksmbd_err("not found stream in xattr : %zd\n", v_len);
-		err = -ENOENT;
-		return err;
+		return (int)v_len;
 	}
 
 	memcpy(buf, &stream_buf[*pos], count);
@@ -415,9 +413,9 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 				       fp->stream.name,
 				       fp->stream.size,
 				       &stream_buf);
-	if (v_len == -ENOENT) {
+	if ((int)v_len < 0) {
 		ksmbd_err("not found stream in xattr : %zd\n", v_len);
-		err = -ENOENT;
+		err = (int)v_len;
 		goto out;
 	}
 
-- 
2.25.1

