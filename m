Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FFD40A7EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbhINHk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241260AbhINHkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:40:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA991C061797
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:36:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h3so11939625pgb.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AIgyRDPnSS/1J7ag3xqeLWjyouPh4gl6PlA+qRTekZA=;
        b=PyOW/6GoK2XsRe2NJ7cCpiZLTaeT6F6pQKixcs2KAyvR+5Z/mRQxtEi0pP+vOjwEPO
         PAncKSttmDhCH49J1Gr6mtp8yGewJZDUJBBcwfLuSQYbBNZ/TI1LD4s1CxA3lH6TGEpo
         pdEP6cmECZIzLXxI8HQNVd4iZ50JSx2LapChtha0k5RqUSw5X4zBGJpaCQoHKK8hzcTu
         /MmDJc+NdtSatcI7E33E3jT/Rl8ublvlEtJTCwdJchle8cnvY8065nce6hh4uTvCrnjL
         Rd2voYUwAWg7g4s7EtR87k+jnfmazVddeuWYTEAOr4ug//3HYNtFpgcdVGLcTwOMwpwg
         d6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AIgyRDPnSS/1J7ag3xqeLWjyouPh4gl6PlA+qRTekZA=;
        b=ZN+1vtaoT/Colos6KJXPrvsRlSWebGmMrNKpl3XryhCPJ1kjAoYL5P9COdzYHIJjp6
         FbxQresLGpMa2GALTrtplUkimjJiGeBWX8nq/hiMQmOlB6TF6fdIhm0h9PSZ5c3vEzWD
         GTQeqOGX0L2k/a6EM5VauGjAR2S9QxMxGnMU1eqHWlvBi7d6XPNpLQGmofy358SAcOqK
         A4QsxYW563o7S4NiEpyossjfjAj91NOzdcxjAzwgxK3bgX4Fx5McMpUerDs6nNhGuAkV
         UAVHuMx8yO4EJA8xz/TRPlQQk2DkHejHuPKYZMKbTHh721VGvqzicNfonudkvPYIxl4M
         Bj5A==
X-Gm-Message-State: AOAM532Q9htDFvhzMTMpJ8S4jbU3SxGQ4jzoQfBynNF+r4TIJa9AhZ0j
        LHBmCKCQ3E2YXKgOZNM+lWgskQ==
X-Google-Smtp-Source: ABdhPJzBqv8a97y97tqrOm4MQyzpy5XU/BTSSq6lA22I2sLvRfI63XF8fDmB9QhcEgokLAlwmntHuQ==
X-Received: by 2002:a63:3602:: with SMTP id d2mr14279308pga.390.1631605016459;
        Tue, 14 Sep 2021 00:36:56 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.36.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:36:56 -0700 (PDT)
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
Subject: [PATCH v3 33/76] hfsplus: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:55 +0800
Message-Id: <20210914072938.6440-34-songmuchun@bytedance.com>
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
 fs/hfsplus/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index b9e3db3f855f..8479add998b5 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -624,7 +624,7 @@ static struct inode *hfsplus_alloc_inode(struct super_block *sb)
 {
 	struct hfsplus_inode_info *i;
 
-	i = kmem_cache_alloc(hfsplus_inode_cachep, GFP_KERNEL);
+	i = alloc_inode_sb(sb, hfsplus_inode_cachep, GFP_KERNEL);
 	return i ? &i->vfs_inode : NULL;
 }
 
-- 
2.11.0

