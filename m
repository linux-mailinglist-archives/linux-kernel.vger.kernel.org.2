Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946AD40A7B1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241437AbhINHhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241255AbhINHh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:37:26 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1D5C0613A8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:35:05 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f65so11329420pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 00:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NEq7kq9SMuUgC1IARLEvXImMtR13fBngVunARmKnk64=;
        b=jdEgYeufa0xbSpy6pjyVs9HuLGulGqxzZuIYgEqVO2w4wlElT/nX2QSJGpfUXrmti3
         ZB6EAatU3qFhGYvzY1BqWJIhxP7gTNlcabnbgUTn6I/EUwBBE6AjKZ/yeiZaSeVYJWQW
         PmXXJibSqLnbKfyKCxabpe3LV/Ya76OwPAy/zNF9K10LwjeBZr2jX+hRflJ+hSxXWVap
         DXrHNLKRe3vSam6AK1REtimYudoSqEYzpT5uA9+luOEN+y5aQFtwE7bw2GEKZn5MEAbg
         bA63vq1JfLcpxDtbwKD5httYxYPc6iH7S6Jkec/s2K2MA7AJNtDpBBmVvRqdaeyNZK8A
         ta0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NEq7kq9SMuUgC1IARLEvXImMtR13fBngVunARmKnk64=;
        b=62B7UdzzaQeiiR2ixnYBnhy5zaLynNFLYRZrWOdVx26AwvrjAp3f8ekN3g7ZNeWIh2
         gGEfrvQkc+brIHyydINu7JN5BMa++B2MA+89d0k8A+a1Kdl+7BMw/InxhWDmL2Y7opX2
         Dm9+fycNM1tz4A+8D16Ih4IAcTxqe81x8h0XKEXUnykAdjSOmtO0HwYYVBtUwVYuuebZ
         dZR5Jdysp8Aq3Z5OtbB2JDeq1EcqGd2mgozxIkJeRiNhm0UchmwgrpU3ZRQJuHrF/WXX
         5mlNWl65RAj5zRjJzI8S6tbo8Zutw0ij3Ytb4//tUd+Cs+U5R9KIXG6iScl7Ox655CAV
         h49A==
X-Gm-Message-State: AOAM533lVZvG5AnQw0Dtb6ZkuKPivbrUq/1Sos2omOMTnHiYfytjAcui
        nx8l6HmLEH/Et3+vlw8b3UEOhg==
X-Google-Smtp-Source: ABdhPJxOJCHtnx+WYbnA/IFmqdKOE7ty3oRk48gVLvlyEJf6F0MqheJB8RWJqz+q7QxmFlxo83mpug==
X-Received: by 2002:a63:7454:: with SMTP id e20mr14236260pgn.136.1631604905477;
        Tue, 14 Sep 2021 00:35:05 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.34.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:35:05 -0700 (PDT)
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
Subject: [PATCH v3 18/76] btrfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:40 +0800
Message-Id: <20210914072938.6440-19-songmuchun@bytedance.com>
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
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 487533c35ddb..f98fbe2ff212 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9072,7 +9072,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	struct btrfs_inode *ei;
 	struct inode *inode;
 
-	ei = kmem_cache_alloc(btrfs_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, btrfs_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 
-- 
2.11.0

