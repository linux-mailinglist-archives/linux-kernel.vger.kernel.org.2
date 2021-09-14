Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEBC40A7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbhINHk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241508AbhINHk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:40:26 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2054C0613B4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:37:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y8so5969237pfa.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WnGM/PRTC9jwFbDFCB/2m9CedfSUEGg6Hy8faW8vi6Q=;
        b=OhYR8FWISzxldmNkyTeWRV+8xTGvr4dqB4cS2QUDh23NDVHpiZ1n957iYAnpMHFAlQ
         WhZ5S1+/jgEl9pdC2hn4i0f2pPXPFZ9ev8JPEv7ywnd4llEFF8FkoxwFC33ctp5VUjiZ
         ar2gT7OmgM9vODLaK9lBpHihej376ah/Kg3kTvAJmyozWOLtMuQfzwg0UblBH9gJDUP4
         n2lwp/YkbrERfya3uHVQT0pkCjSeLkA/QUqOo1Om5Jw9zXXpSa+/eCo2TSvLlardxL9I
         9ywIJKnAR8KkhS/xpu2lx8Rf6WAGTCv+ODR46zfpjOSCVE+8T0kMqA3gkg/uGget54Pt
         9fRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WnGM/PRTC9jwFbDFCB/2m9CedfSUEGg6Hy8faW8vi6Q=;
        b=36uQfYbWJOdee/oQcdLv5ie5EvC3AptP7YWR7/MBhNqnflT+VUIVjHxWXhSgaSuqoG
         szk8vxjBiOCgsv5PyUq9Z5Lj96KKUaB0jZebeyH1kEW5P5jinDpkNjEVE5ddDuHMUb0/
         FMn5bgtePIC0eYXDjXS/KOsBtx+TyUQAOG50DxyR0NnzlD52rYV/CTwKxgbawV7Qcr00
         jC/8DMP/5CIXcEHMF7g6fqVsCz0tTL4rnQP+6K58CYXFLZtPmA7Y4HAP/wCkBhCRvKTN
         KRGoXL6reJ0UOMDPOeat6FRH9IBgzXwo+cs6lEO4VpUljf6y2xRQ9lRVrN+1f5ii3kZI
         flmQ==
X-Gm-Message-State: AOAM532hQR6kAjYLbMalRP710kcCfeJeApU9XUTS3oaIfh5igTIPCOTK
        BIzxWfOVzQ927B+XJcq+DbU08Q==
X-Google-Smtp-Source: ABdhPJznasl++Bo/8nsxFcSls7diNHfauicqmG5JsXp6/a9c5KW9mqNfxnfLFev5Q52O7vsAKyvHWw==
X-Received: by 2002:a63:150e:: with SMTP id v14mr14430074pgl.126.1631605039422;
        Tue, 14 Sep 2021 00:37:19 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.37.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:37:19 -0700 (PDT)
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
Subject: [PATCH v3 36/76] hugetlbfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:58 +0800
Message-Id: <20210914072938.6440-37-songmuchun@bytedance.com>
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
 fs/hugetlbfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index cdfb1ae78a3f..b1885a3723f7 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1109,7 +1109,7 @@ static struct inode *hugetlbfs_alloc_inode(struct super_block *sb)
 
 	if (unlikely(!hugetlbfs_dec_free_inodes(sbinfo)))
 		return NULL;
-	p = kmem_cache_alloc(hugetlbfs_inode_cachep, GFP_KERNEL);
+	p = alloc_inode_sb(sb, hugetlbfs_inode_cachep, GFP_KERNEL);
 	if (unlikely(!p)) {
 		hugetlbfs_inc_free_inodes(sbinfo);
 		return NULL;
-- 
2.11.0

