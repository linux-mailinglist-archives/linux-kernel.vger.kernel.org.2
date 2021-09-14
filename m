Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819C140A851
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhINHp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbhINHoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:44:14 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEFBC0613E7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:40:00 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j16so11368607pfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NFK8477UAn3zAKQ0vXm0lu+fwWsZH+uussXoYW7LsE4=;
        b=L2tXQ4abitca4ZpsuUEhDYaxwHxkohsNX4r8JUZZQMfvw7KBpwdpYy3hMa2VxOYtOY
         /tWe2XlXOVIPpAcphXR1WZg5UOXFqg3UHPRDwQcVJsodv5NthoXtQCHLnfzhBXgKMa2m
         QVEG+UgL5UHafDNVUK1v/2X5mkcpp/1us69k8wopwcZAfPE2E8CMtnfTuwa4uHps3Dfl
         F7l09aI91gOWOCcE1+tkPcfFpVoS+eH+k8cbXfk+zb0kBUhch6ofDcvZMyfDpmnoEH2b
         tx+8zfpUEScvl/2qvwweom0hZMUnnM8273fTlolF41JYbgc5UtvHFm6Qxxl4EC13OCig
         2bSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NFK8477UAn3zAKQ0vXm0lu+fwWsZH+uussXoYW7LsE4=;
        b=rY29aNf7cKTtqN4r7P3rvXj70xNKO3QRGVKmW4dLGMMUgvVEbSIh8rQgr/00ijwHbm
         cC8ZZqjfgnGBpqY9J9bQJYnrhkUsINqgiOjnkkVFAiYvDOu0T4jE4sob0Q15Se97S7HV
         XBRjCOnvWquNU9uRRp6qnjQtc29s/9Lhxa6NYeUTIfSNv8UgWv31Q9eRBGz6OiCGVxQa
         KO5tZ4x3awIRApvMyvJ6WEdw37D6zNRkGMEbwsWLmw2T2+km9JX0GCxInkySKTwokaE9
         rahC4BLbOGMUtAX15oZ86rG+C+ULInJH0pdmgliF9N2UVlb3Z32P4k+0/Xj0so8TRk+a
         Kx8g==
X-Gm-Message-State: AOAM531NXYtWdXUEM5Fuyp7ViGUSyEdYSuqE4EzoM4+zu1o2XE4OpzMz
        lsXvROW9bjvNHWrSKz6yoocEpg==
X-Google-Smtp-Source: ABdhPJxJWNVuFEOyhzUxVwAwBroFpnzb1jddWkZTC7DYPKbbNMEwIFS2gGCQs+6W/z4hcToI8QOqAw==
X-Received: by 2002:a62:b515:0:b0:438:42ab:2742 with SMTP id y21-20020a62b515000000b0043842ab2742mr3383918pfe.77.1631605199954;
        Tue, 14 Sep 2021 00:39:59 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.39.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:39:59 -0700 (PDT)
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
Subject: [PATCH v3 59/76] xfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:21 +0800
Message-Id: <20210914072938.6440-60-songmuchun@bytedance.com>
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
 fs/xfs/xfs_icache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index f2210d927481..0a4f32c0044c 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -77,7 +77,7 @@ xfs_inode_alloc(
 	 * XXX: If this didn't occur in transactions, we could drop GFP_NOFAIL
 	 * and return NULL here on ENOMEM.
 	 */
-	ip = kmem_cache_alloc(xfs_inode_zone, GFP_KERNEL | __GFP_NOFAIL);
+	ip = alloc_inode_sb(mp->m_super, xfs_inode_zone, GFP_KERNEL | __GFP_NOFAIL);
 
 	if (inode_init_always(mp->m_super, VFS_I(ip))) {
 		kmem_cache_free(xfs_inode_zone, ip);
-- 
2.11.0

