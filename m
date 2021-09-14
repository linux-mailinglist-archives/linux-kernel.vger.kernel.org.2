Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDA340A82A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhINHoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhINHn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:43:28 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587BFC0613AE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:39:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t20so8236215pju.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GnyAEe3d2TiVZpmYe6sQEf4ZzdDTOfGkYHI/ZKXydW4=;
        b=yMTl6iHpS7yMpDJa6emRP/798/2i8AWBdHk9JLeEuF/RDFOxwWc51GBkOw/SGLixkT
         ftk+WfR5/hwrDz08rAuXYurn10yNsk3i95MpALU212CvQyC+x2vPgb5QwJxZXg2ldJq8
         Vyk/8HWpe2w8DmjsFLc5IjcJ1UgupWU7vP04uSHeCDjW3cBEehIeobpMnPix5qJL51eM
         cT8hiT9MKTN7hZIE2OzpEL9m7MgnFLZacJu8z+zKRNCmLA1luGqOOkLzFwkKE8/FKVYp
         vXEa9Tf6Scze/4dFYS7E3Qyk/pIxetVMT6y2WGE7jcLt699+aV3Y4yq1MW60VnkLWI+3
         89VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GnyAEe3d2TiVZpmYe6sQEf4ZzdDTOfGkYHI/ZKXydW4=;
        b=APg1VvGrVWJLDsVRWBExoI35zEYm8YNOpOsrlgo1pYzfBDbBqX8xu7/ilyrXJzGtuD
         1fJVPfgb61Kk9c5UewnqS0GTGb0c6HLhnLGMUUB15yG47qmD4HLP/MEe9Vzexnget+A4
         jirrVysMZ0b7MpJSrmMy/XqreY5aNO2OsAeY7WClKyzsj2pD/5drlna1ErVzFGoE1UGX
         FMQTRN9iCOkILXIopeOnYW2ubpPiu7/lj2q5EKQhVv1p1nj4Y0j0PLtQDHxEfYPcQBw6
         +uxyVO5WvVWScX2Cxp2sBOLosxbXlw95BqKvuQs8d2kN0bBD7zGED0LroaqePbAfuSXi
         t4bw==
X-Gm-Message-State: AOAM530+uYfZEbs98ad0oD1PxOtzA+h+xGaWEOstJM7FhXB5x/zDB6i5
        fEhmEF3IczY8ETO2H97VvSmgiQ==
X-Google-Smtp-Source: ABdhPJzmRx2/jJtkjn7cdw4ltYah7hA6Trt9mfJsbQ974TSh8hhnpLfCH6CPvS2vjdnbP+u1WL2vTA==
X-Received: by 2002:a17:902:ce84:b0:138:9422:512e with SMTP id f4-20020a170902ce8400b001389422512emr14199423plg.12.1631605165944;
        Tue, 14 Sep 2021 00:39:25 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.39.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:39:25 -0700 (PDT)
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
Subject: [PATCH v3 54/76] sysv: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:16 +0800
Message-Id: <20210914072938.6440-55-songmuchun@bytedance.com>
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
 fs/sysv/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index be47263b8605..9e8d4a6fb2f3 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -306,7 +306,7 @@ static struct inode *sysv_alloc_inode(struct super_block *sb)
 {
 	struct sysv_inode_info *si;
 
-	si = kmem_cache_alloc(sysv_inode_cachep, GFP_KERNEL);
+	si = alloc_inode_sb(sb, sysv_inode_cachep, GFP_KERNEL);
 	if (!si)
 		return NULL;
 	return &si->vfs_inode;
-- 
2.11.0

