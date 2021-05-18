Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0713875D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348153AbhERJ4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:56:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3009 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348136AbhERJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:56:22 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fkrqp1SkczQpgd;
        Tue, 18 May 2021 17:51:34 +0800 (CST)
Received: from dggemx753-chm.china.huawei.com (10.0.44.37) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 17:55:03 +0800
Received: from szvp000207684.huawei.com (10.120.216.130) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 18 May 2021 17:55:02 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: compress: fix to disallow temp extension
Date:   Tue, 18 May 2021 17:54:58 +0800
Message-ID: <20210518095458.99728-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210518095458.99728-1-yuchao0@huawei.com>
References: <20210518095458.99728-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch restricts to configure compress extension as format of:

 [filename + '.' + extension]

rather than:

 [filename + '.' + extension + (optional: '.' + temp extension)]

in order to avoid to enable compression incorrectly:

1. compress_extension=so
2. touch file.soa
3. touch file.so.tmp

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/namei.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 8d78b96a8b3b..36e04148e8f8 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -158,7 +158,8 @@ bool f2fs_is_wildcard_char(const char *ext)
 	return *ext == '*' && strlen(ext) == 1;
 }
 
-static inline int is_extension_exist(const unsigned char *s, const char *sub)
+static inline int is_extension_exist(const unsigned char *s, const char *sub,
+						bool tmp_ext)
 {
 	size_t slen = strlen(s);
 	size_t sublen = strlen(sub);
@@ -171,6 +172,13 @@ static inline int is_extension_exist(const unsigned char *s, const char *sub)
 	if (slen < sublen + 2)
 		return 0;
 
+	if (!tmp_ext) {
+		/* file has no temp extension */
+		if (s[slen - sublen - 1] != '.')
+			return 0;
+		return !strncasecmp(s + slen - sublen, sub, sublen);
+	}
+
 	for (i = 1; i < slen - sublen; i++) {
 		if (s[i] != '.')
 			continue;
@@ -196,7 +204,7 @@ static inline void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *
 	hot_count = sbi->raw_super->hot_ext_count;
 
 	for (i = 0; i < cold_count + hot_count; i++) {
-		if (is_extension_exist(name, extlist[i]))
+		if (is_extension_exist(name, extlist[i], true))
 			break;
 	}
 
@@ -297,7 +305,7 @@ static void set_compress_inode(struct f2fs_sb_info *sbi, struct inode *inode,
 	hot_count = sbi->raw_super->hot_ext_count;
 
 	for (i = cold_count; i < cold_count + hot_count; i++) {
-		if (is_extension_exist(name, extlist[i])) {
+		if (is_extension_exist(name, extlist[i], false)) {
 			up_read(&sbi->sb_lock);
 			return;
 		}
@@ -310,7 +318,7 @@ static void set_compress_inode(struct f2fs_sb_info *sbi, struct inode *inode,
 	for (i = 0; i < ext_cnt; i++) {
 		if (f2fs_is_wildcard_char(ext[i]))
 			goto set_compress;
-		if (!is_extension_exist(name, ext[i]))
+		if (!is_extension_exist(name, ext[i], false))
 			continue;
 set_compress:
 		set_compress_context(inode);
-- 
2.29.2

