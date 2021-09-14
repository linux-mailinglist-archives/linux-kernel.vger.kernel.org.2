Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BBD40A827
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhINHnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhINHnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:43:16 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F61C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:39:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso2062059pjq.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHRI7i94nkkwALVkJUru65wTIGyTMAu5yxZLJ0urhMs=;
        b=WLFvf0yPGpxYDITgQsoRZISgK1oizMjzYNnbCPzbiVPdq7IswUpVIxTsw4DygWSs9y
         uw8VmNGrWvIgI1Z7O3sQslX3re3c0eiPxnRwtt+F2g3PKev2n5MSnVJTBE6y6AVbRPhv
         HzPzwHvAFcd4LTE2VwMAwljMc6uRFXkEiPsKrbPs3qly5ey42l/L1BPTOMSoA9ZEM91E
         MNCZL1crssjdApZjU/gh2xl53+6G92GXfk9+7Hs7m2k2minNnGwgqa2qNEYOjSirX6c+
         csOZuB+w+r8rsjzG9WceNzCiTuYhYzZNTfrqjf5pdPzN4S39bm8v8pt5NGC+UsJ407lT
         qmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHRI7i94nkkwALVkJUru65wTIGyTMAu5yxZLJ0urhMs=;
        b=mBP9qsRycgyl7fa7ZK/NPYcLXj7t0LMVgFhLMfpdInyI/+cBq2QhS6nzEWwqMLc+Ie
         8Dmx0u66c0Rz83ihhg0CUWYnwvv1+w3n6Sk2J6fyPo6ziIeKDiPS5zmCye8UQDaXSZzE
         fbUrGA2Q9jK0pE1R0mNLcYpvyYplng5fH8RD2vEniMo1YYNTPBjDEMr0znG9+GoBMvYv
         ZbwZAN0PDvy/gRZ/R05AE86k6vmZq0w+kJTtLg9knhO5Eq6zznEfPw85vgzuxLQo6Oen
         6MmYU7pn8sjo2GX2TYcDSeNkkHw59HmFdNo30iAmOYKwaKfxhCG4zAyC7jWnYdzX37Nc
         TZoQ==
X-Gm-Message-State: AOAM5306vRyHyYewA7GZcm4e+wVmB31nbr5Q3r+dfTIp9h7/pyojJkm5
        CeWzQZ3pQlEcr1KtOkvluDMZ3w==
X-Google-Smtp-Source: ABdhPJy/HLUtiT+SQqdbf+XTfxJE1/QsuKyIRhd9fdS50+avblVckJ4d5s8cFJbFgkEZEIkF661tLw==
X-Received: by 2002:a17:90a:d516:: with SMTP id t22mr566682pju.208.1631605159109;
        Tue, 14 Sep 2021 00:39:19 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.39.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:39:18 -0700 (PDT)
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
Subject: [PATCH v3 53/76] squashfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:15 +0800
Message-Id: <20210914072938.6440-54-songmuchun@bytedance.com>
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
 fs/squashfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 60d6951915f4..e51625e93b00 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -550,7 +550,7 @@ static void __exit exit_squashfs_fs(void)
 static struct inode *squashfs_alloc_inode(struct super_block *sb)
 {
 	struct squashfs_inode_info *ei =
-		kmem_cache_alloc(squashfs_inode_cachep, GFP_KERNEL);
+		alloc_inode_sb(sb, squashfs_inode_cachep, GFP_KERNEL);
 
 	return ei ? &ei->vfs_inode : NULL;
 }
-- 
2.11.0

