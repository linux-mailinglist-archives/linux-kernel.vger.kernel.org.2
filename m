Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F150D40A849
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbhINHpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbhINHnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:43:42 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6D0C06124A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:39:32 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n18so7595084plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jq1ii8A4uQXumPf/NnNFLaE389Tt0HeSx3fXMRSpHEY=;
        b=mT4FkMAo0C9XvgGm7TTt1y2GGwp6xYsyTEyh37SSuVDZxf4eK7SKxsMqb30qkdoseX
         oKPLNqiO0xX7L7dj4fzYOpaFYrK0ux6Mob00Kaxx5nssQqOLDQQU9kq10h2rvO44/dKw
         dnxMA8j8877MzbRnf4MOF+sisgWX3j1StFcKANodUOY0BjcjxomePimI9sO0INBeGoja
         ysUOwHxnZdDmtmca/YNTEJ+JdJ9nCvxRBjng1nmfsvYJoGFqaFuV0RHWnnB5VC7PdV4c
         RXzO38ez4IIZvh0e72G8X4hH+GQMUD5mZ7lAB4rJNlofF+KHbzqmGHMljrx0pV0QbwYe
         jIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jq1ii8A4uQXumPf/NnNFLaE389Tt0HeSx3fXMRSpHEY=;
        b=zABOq2QOeqTHaivJNs9pMm1it9WCb02oZix9FE+j3AjoFYgt/vBXB1AI9rOhqY5vI2
         pSjbb9edPGsaWdnp0UjR6rlNgzpzCl+8/FnW9UOWGZbraKyb95sVS4e5sqe0etq1FfKT
         AvBurriYmWSDeCiI5JaZt9BlFG+dFGFJrvicsUekY8UbBuecRrkNBx18hdwCI5piWD/z
         9+74hce5IN/xnB2MKjYaKfjk3zddDVdqPoXesoD6DZAzzdzCsUfeg3Ui1556RwWJhtDi
         TiFtPZbenLIvEMjnLU/Bvgw2hoz7QUwHdVqYtMSYntQBKUZu2wfF9fHb2VTw7+t3DtWl
         bdbQ==
X-Gm-Message-State: AOAM532d1XJoa7pRu2s6E5zqSXlgArGKUCjafw6PFKLindxX/AaRfR1M
        CaDUl+UJRfbUCceF+2lRKz2Tbg==
X-Google-Smtp-Source: ABdhPJyKG+S3Gscm6xr8oqCH8qcvg04CqYQ0tSL54xAPfDg7x5NyQJSymcpp2OEzNTwQ6Ju0NLBrTA==
X-Received: by 2002:a17:902:c40e:b0:138:e2f9:6c97 with SMTP id k14-20020a170902c40e00b00138e2f96c97mr13786006plk.26.1631605172395;
        Tue, 14 Sep 2021 00:39:32 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.39.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:39:32 -0700 (PDT)
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
Subject: [PATCH v3 55/76] ubifs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:17 +0800
Message-Id: <20210914072938.6440-56-songmuchun@bytedance.com>
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
 fs/ubifs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index f0fb25727d96..73b51f8e6817 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -268,7 +268,7 @@ static struct inode *ubifs_alloc_inode(struct super_block *sb)
 {
 	struct ubifs_inode *ui;
 
-	ui = kmem_cache_alloc(ubifs_inode_slab, GFP_NOFS);
+	ui = alloc_inode_sb(sb, ubifs_inode_slab, GFP_NOFS);
 	if (!ui)
 		return NULL;
 
-- 
2.11.0

