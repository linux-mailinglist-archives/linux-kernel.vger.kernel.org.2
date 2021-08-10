Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA7F3E5438
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhHJHZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhHJHYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:24:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC0DC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:24:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a8so31788548pjk.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 00:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cYnOcpl3RqojwjJFnnVg8/yScojJWlu8lq+uPSDpFCs=;
        b=kpE7jy+RHLjjTgDUj5ZCNtZFEzhNDgahQds/OSrJZWyhOmabvFIlJIVOzfdPJF/B9P
         r6tO+Ajm1Sj8684aXZxS0vH0hhOpRHjk5Xf7KsRpgPjW5jaLFNx6oNDqmFq8K/VWsmOP
         0Kt28fsAFLXJjxUJbRPXkpMiIKS1wYVYaSeBVyKqTU04etoiMnpk83r7C1PiBGlMWyRj
         3ike4BGfczGrizs9Pf8wtfrgPL0i2ijRLi3bSOhszEcGit2bgxcKDSBei3uyDPyIYDvw
         4XxmBpztEQYAzOmovDM2o0s/GqYDIlsSAPJTmrxmDgq14tE8mMZjgs/zcnl/UljW9ji2
         suEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cYnOcpl3RqojwjJFnnVg8/yScojJWlu8lq+uPSDpFCs=;
        b=l3/71xiH93M+UjtnvewDEe25gSYaRcuCakXCc8W8OnbmYU7yfB/qeVu1PI9kA+G8ZB
         NHlF2IEefvypEzKJPowNv7EEkaIVUPVNj6E7zYwUmjOmNK0Q3wJEvPgRFMZu8JPweogm
         EelAT7uUHpsShhxCRGBLlkgfFvuoYfN8BgVLydwnKmEItO0L1y0w3IhAUxcMuX5NKnrx
         mKLWkJij15oxPAIl/lwI6imdaIW3IWrz7U6XW9gsJnwWe0BrSc/ROyBd7+HSjXj4+Uyq
         OE49tr87CCv3C7TNbmtU8ovmxPdg8osAFMz0m11nvc909w80/sCvF0+MUjW7ZiK60POz
         WrAg==
X-Gm-Message-State: AOAM533UvYrmPj20PLzYvNgtnNkVD2bDXSzu/21NnRbb6Y9rOjmxVmw+
        Vge9CAqJ9GYWm5w8t86Jx8g=
X-Google-Smtp-Source: ABdhPJw4PyPIV7cQtAVaumkgLBq8X4eRVCkdZumHP2PheLVmuVa8cZoFBLhJwAZGov6XX9cJdk6VwQ==
X-Received: by 2002:a63:3e05:: with SMTP id l5mr330017pga.403.1628580272230;
        Tue, 10 Aug 2021 00:24:32 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id f4sm27326222pgi.68.2021.08.10.00.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:24:31 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] erofs: remove the mapping parameter from erofs_try_to_free_cached_page()
Date:   Tue, 10 Aug 2021 15:24:16 +0800
Message-Id: <20210810072416.1392-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

The mapping is not used at all, remove it and update related code.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/internal.h | 3 +--
 fs/erofs/super.c    | 2 +-
 fs/erofs/zdata.c    | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f92e3e3..e21b147 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -442,8 +442,7 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
 void z_erofs_exit_zip_subsystem(void);
 int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 				       struct erofs_workgroup *egrp);
-int erofs_try_to_free_cached_page(struct address_space *mapping,
-				  struct page *page);
+int erofs_try_to_free_cached_page(struct page *page);
 int z_erofs_load_lz4_config(struct super_block *sb,
 			    struct erofs_super_block *dsb,
 			    struct z_erofs_lz4_cfgs *lz4, int len);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index bbf3bbd..72fff34 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -430,7 +430,7 @@ static int erofs_managed_cache_releasepage(struct page *page, gfp_t gfp_mask)
 	DBG_BUGON(mapping->a_ops != &managed_cache_aops);
 
 	if (PagePrivate(page))
-		ret = erofs_try_to_free_cached_page(mapping, page);
+		ret = erofs_try_to_free_cached_page(page);
 
 	return ret;
 }
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a809730..c8e1594 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -337,8 +337,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 	return 0;
 }
 
-int erofs_try_to_free_cached_page(struct address_space *mapping,
-				  struct page *page)
+int erofs_try_to_free_cached_page(struct page *page)
 {
 	struct z_erofs_pcluster *const pcl = (void *)page_private(page);
 	int ret = 0;	/* 0 - busy */
-- 
1.9.1

