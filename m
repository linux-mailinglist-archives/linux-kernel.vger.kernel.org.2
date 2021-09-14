Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFA640A7B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbhINHhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240782AbhINHh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:37:27 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25CAC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:35:12 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s11so11918389pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xmWs76ejJuWUw+NjSJEHDOglMzK6H3Rus8uSh5Y2LOI=;
        b=JDksD2X5hYyqveT44345REs/WzN6DpsF4haKOhQxw+stDMw1hW9W15EKVpprv4NkjO
         bGMz0nu4jvtK0ts1snJJN6W6+XK/9N9FHCz6ox/vwNR2JhGWnzGn0P0LYYSElIxQBFPz
         51MvliAcWVYcS+9YzCLetuAbutjav05WDWsS3qx852Ph1em7cIZj71+SCJfHKulx+z1U
         hVO+SdaZo9H80GydN6uL2xOToXA0yj9bNcHXqEs3qQdN696bPkmizb/XpTdgsur4623a
         t2Vj6nvM/q9BQz4JtMNGsNdm0GNNA30aRJTIpdfUYghZjJjOFgMkGQ7n/p1iBqJoHzSW
         VWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xmWs76ejJuWUw+NjSJEHDOglMzK6H3Rus8uSh5Y2LOI=;
        b=QKG5JFtA9rGJ4I+hqxLjAPhj412h4Dj37vbNnzdvRBLa3sWzad3oUW0fVKY/qZQXUU
         mlFZQLzhqXvs1MzG9Xv96pJ8N4vyVUf+lwS3H20oNybp1yLAj6a66JeZH8zaiKauYLWe
         X5oqijqnZSdOr4/p8TJlJNDACblo3Xw5oOtlgUBdLcUdmvryoJzEEDl0l9KyFX7H9sqZ
         ck7QoXmvXh3JNTYY5dF83mQPFl9APnu42A/9pN7smB3HOIhNd/cAScNRNWW+Mf2LPxNT
         FJwwOr9zFSPDofFacCEUZ2VrhsFmJdJkuzm8LVJMUkC0yuXptOpljbQVEGCN4U87owbr
         cGNA==
X-Gm-Message-State: AOAM531qJdV5mO/9MfbxAyNPsiE3vhyBJne7MXzSjiui56x+w5lOAEAw
        W+ZI180QUeZ1+K6iwUYNMg7hDw==
X-Google-Smtp-Source: ABdhPJzTOnQngqhMuN6LTM4la+nLf6iQUU7SFedtJ54Vh2B0sOh1eoF37FRLMSQs2nF2EZ3GfRKUQQ==
X-Received: by 2002:a62:6103:0:b0:405:2c7a:9ee9 with SMTP id v3-20020a626103000000b004052c7a9ee9mr3457664pfb.71.1631604912429;
        Tue, 14 Sep 2021 00:35:12 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.35.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:35:12 -0700 (PDT)
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
Subject: [PATCH v3 19/76] ceph: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:41 +0800
Message-Id: <20210914072938.6440-20-songmuchun@bytedance.com>
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
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 2df1e1284451..96239d209bec 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -447,7 +447,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	struct ceph_inode_info *ci;
 	int i;
 
-	ci = kmem_cache_alloc(ceph_inode_cachep, GFP_NOFS);
+	ci = alloc_inode_sb(sb, ceph_inode_cachep, GFP_NOFS);
 	if (!ci)
 		return NULL;
 
-- 
2.11.0

