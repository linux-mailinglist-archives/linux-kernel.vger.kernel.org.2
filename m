Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294E039277A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 08:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbhE0G1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 02:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbhE0G1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 02:27:09 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3D7C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 23:25:36 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id kr9so2141598pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 23:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y++panFifneasGq960GJtHjLst8uLUglPFxOcyVBRks=;
        b=jgeKoWpk2GjyMfypyzxlbbnac3TWTwOgzJt96jJqAvQI95liqLVhJNfUx8EOTKfhGF
         4JR0WlMdklz4TbN/7KMayxK4+sRAHemy4e3o6vpu33f0sRKCaHXUkHVByGhkconcpC5P
         LVZbgz7ILWTP2+tCT7TKnGNrFHgNmlEnja61hYro+SvTwKieHVACeLNmwwsV0asUCd0M
         HSoxbz9PvDa2LP22/s6Zhv7I3z8MYyKLC/z1+kvna2RnFttogyHW5fjMhYEC3T41dxS1
         gsv1Z2Um5suWkCM0QPtsCPBSJ6VDZasnKWJg78xlOePEKtoJTMvVLbpln17g+eDbIZY6
         lgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y++panFifneasGq960GJtHjLst8uLUglPFxOcyVBRks=;
        b=caalL0vX5qYaOIgOGuSB1ib+3PZSnix1yrgxljSuP5rFXUPQuaI71VSDXsu6QjskIO
         3Ub8nOusWxYOuu5/1ZwRIneDEo9Jm6HUuaseL2b5rv9whC9HOYH+jAneTCpRUC+DDxQh
         uAHwc9X/C3QRHxknCXo+/liiM48B/8BBQGgjD6jsFhJwGutFbPaaQrkYdxrkMbWncXfD
         LPWF5dlTgdUp1rirOTf0vtYhoOZx3aYJhALII8P1QiXXw2hyiAQ9a4pRqYn1EvAd/GBL
         ZjL9Hhn17JqZFcdj7rBvgrG+fMoDZK1HmBcWy34B3x/AsQURr55s5FfD56GC8mrmm2OX
         KR6g==
X-Gm-Message-State: AOAM531CY3XWtqlE3gY4tibkE3nuHs536BU2nJ0SbU6c8JwQ9ZH+tfOQ
        ntWk+75I5dckaVoj+rfyLxmE2A==
X-Google-Smtp-Source: ABdhPJxcGuF5DQLh4LjJiXw5aeyBoGXy1Hjz00Eh2PAxD5BdIel1s/tP58hZR4Q7aTL9uSZUuaTZsQ==
X-Received: by 2002:a17:90a:df0c:: with SMTP id gp12mr366298pjb.80.1622096736011;
        Wed, 26 May 2021 23:25:36 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.25.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:25:35 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 11/21] mm: dcache: use kmem_cache_alloc_lru() to allocate dentry
Date:   Thu, 27 May 2021 14:21:38 +0800
Message-Id: <20210527062148.9361-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like inode cache, the dentry will also be added to its memcg list_lru.
So replace kmem_cache_alloc() with kmem_cache_alloc_lru() to allocate
dentry.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/dcache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index cf871a81f4fd..36d4806d7284 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1741,7 +1741,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	char *dname;
 	int err;
 
-	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL);
+	dentry = kmem_cache_alloc_lru(dentry_cache, &sb->s_dentry_lru,
+				      GFP_KERNEL);
 	if (!dentry)
 		return NULL;
 
-- 
2.11.0

