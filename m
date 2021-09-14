Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE5040A7B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbhINHiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241093AbhINHh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:37:28 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADD6C061793
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:35:20 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k24so11920429pgh.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EeEIfsET3veEFyKZGMdqrIC7SmUJrf9uv2HTbxew7HM=;
        b=SV6JN5iimQBXUfCre6VlL7Lj4UTOZ7hKT3qLd58hiOph3ZbO9ARv9uURoQiK3OcGgB
         yOc8X2dDszH+dDEB5L+utQ8J22OjjM+CxD43vuPjMUSjhRUYCs/UVHUDRMLX0TKxkXTV
         wRffWVFQMVrkCpgaY2u6OSSNmvVc1VzQ1yr7ETOJ7dnQRYYK1ptqu+icFkFqkKSSazWN
         9oMcAcxrlXngjdZNFb/NncCXBi1ofb+fhVOFqxYxbzEBkoFsxX+Q0Cka16YxapTti6g6
         iC0MQdrk9x7ZbQNKn1GL6k1TfYNbvGn9YGclVnI5ZSqRnX+SMjwZv7WqqRVZsyoDNEdK
         I9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EeEIfsET3veEFyKZGMdqrIC7SmUJrf9uv2HTbxew7HM=;
        b=QjV0nlI1ZaRlS7ICbg+FmNvvHbGbqlZ3CSUQVXb6t7gsavV2ZY/B9LG9X+lycto5Ot
         7Q0n0LmZ+Ck+TEEbSf0H6+26rdn3/qwT9+b5whaKWx1pRK646coo5sH6KE7OnktfPrvm
         iUEDyVBBIWtZEXieI7axKnF5qLC5D1LxTnskmrsY7xK51tTXKsOjC5/81BX/62sHy3GM
         uvM54G7a71/AeCKxy2X/vpZFttQQAoI7In/OTZmhoBVkNkxxTYoxDqAKP/WMdShMY51k
         yyUaTfjJ6wzLkDXzZqt9Tg0oGBcv3+IEE8cMiApGJZwHRJY9Ny2TLh0G/fKmO9puQFBR
         M5KQ==
X-Gm-Message-State: AOAM533wU1G3wBGZZ0IhOM/DE4FzyCFaDnem90ucgjqKninN+84+QP3B
        hTn43gPvm+GXNvFaG+4RAvCoDQ==
X-Google-Smtp-Source: ABdhPJzJ3stl+34/hU2kXHce6y3rv3WtN0uv6gcgVBj8T8YLnolCz18rqWf5mghFAUOHHszaMxmR9A==
X-Received: by 2002:a05:6a00:a23:b0:43d:e856:a3d4 with SMTP id p35-20020a056a000a2300b0043de856a3d4mr3381701pfh.17.1631604919762;
        Tue, 14 Sep 2021 00:35:19 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.35.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:35:19 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 20/76] cifs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:42 +0800
Message-Id: <20210914072938.6440-21-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inode allocation is supposed to use alloc_inode_sb(), so convert
kmem_cache_alloc() to alloc_inode_sb().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/cifs/cifsfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 8c20bfa187ac..7c239ba551b9 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -355,7 +355,7 @@ static struct inode *
 cifs_alloc_inode(struct super_block *sb)
 {
 	struct cifsInodeInfo *cifs_inode;
-	cifs_inode = kmem_cache_alloc(cifs_inode_cachep, GFP_KERNEL);
+	cifs_inode = alloc_inode_sb(sb, cifs_inode_cachep, GFP_KERNEL);
 	if (!cifs_inode)
 		return NULL;
 	cifs_inode->cifsAttrs = 0x20;	/* default */
-- 
2.11.0

