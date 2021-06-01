Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810CC394B0C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 10:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhE2ISM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 04:18:12 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2528 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhE2ISK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 04:18:10 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FsZ7y1Gs0zYr34;
        Sat, 29 May 2021 16:13:50 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 16:16:31 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 29 May
 2021 16:16:30 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-cifsd-devel@lists.sourceforge.net>,
        <linux-cifs@vger.kernel.org>
CC:     <namjae.jeon@samsung.com>, <sergey.senozhatsky@gmail.com>,
        <sfrench@samba.org>, <hyc.lee@gmail.com>
Subject: [PATCH -next 1/3] cifsd: fix memleak in ksmbd_vfs_stream_write()
Date:   Sat, 29 May 2021 16:20:56 +0800
Message-ID: <20210529082058.3012233-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
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

Before assigning wbuf to stream_buf, memory allocate in
ksmbd_vfs_getcasexattr() need be freed.

Fixes: f44158485826 ("cifsd: add file operations")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 fs/cifsd/vfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifsd/vfs.c b/fs/cifsd/vfs.c
index 291953eff5fa..9057b30278b9 100644
--- a/fs/cifsd/vfs.c
+++ b/fs/cifsd/vfs.c
@@ -429,6 +429,7 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 
 		if (v_len > 0)
 			memcpy(wbuf, stream_buf, v_len);
+		kfree(stream_buf);
 		stream_buf = wbuf;
 	}
 
-- 
2.25.1

