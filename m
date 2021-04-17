Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F407D362DBB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 06:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhDQEjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 00:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbhDQEjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 00:39:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0948CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:38:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cu16so13062360pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y8TwextheIbDJq4JEPMsgtPW4imrEmOBZladzG6/EIY=;
        b=USYqdzUiBYMhAwyN2kR/fOuJc5bdKJjvIFBfGlRsQbiFuKbvl018KHNrEDB6ZR5hD3
         g7Eb7MjfHwqdbzwjZzHqSgKn3iN0np5fP1fvqLDkt7kuvnVfjS6qEcxVT/HC1z5wCMcq
         UJSsW2z0vk7Tym2fshCANCoQ+ILRU0a3KCB6lPp0zjw7kGEhJYSd+EmJli0rrX4PU+fa
         ey3C9Zhh6qFULYaL8zYEVqNSOXyONHWxPDFrKjweK2ag8PUoyXsGL6thcX6S15QUgS7a
         EMoKzQxZakqREJcohPUtHCRxupw0a/ijaFh7rGwamu9yLBVnXWqZQRBwZQz+mH0vms9N
         pnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8TwextheIbDJq4JEPMsgtPW4imrEmOBZladzG6/EIY=;
        b=dGBXpwOueeIYIkoQajOHaPdwBXuvl7cKJ3SrqtQUt5Xx9103Xnm0anj3zfkFAnFQI2
         5k/p/WtNTIe2x0vRPySDbBUh5Z1imYrQ/gWmKqFXl7LsGnk+8WX8D/qwTK9K98CRzqZK
         WZjPm7K20gpJT7S3mYqhF3pd2jC7AI9ne3WWDjZqXU8G8GG2PO01T48PRmJGL2JFWuw9
         wGNuU5HuhJ5qz3PpctuD6r8yxnn9FzT3dRYLkerEDYiq9GdyBuktWA+F+pNd4sPzs1ae
         dRMAKLXchocFHne7BlYgO+M9+dnxqmfiYQ5B9AQfNo87L2gEQF7FxkaFYu5XZJ12K/qv
         5mvQ==
X-Gm-Message-State: AOAM532ZbgZe127K+V6ho9GXFGNsqaBQzdw+JyQ36ID7g8OLnYKIl8VJ
        7TYueQzTfILLKinWz4HkuA3QGQ==
X-Google-Smtp-Source: ABdhPJzQts5UlUhjYfu2k84c2/GRxhOv1r45Guo8b4WWs2RaMDXIQiw0p76Vd5VjErfo2giWbBJ1YQ==
X-Received: by 2002:a17:902:b601:b029:eb:1207:86ec with SMTP id b1-20020a170902b601b02900eb120786ecmr12472948pls.3.1618634316645;
        Fri, 16 Apr 2021 21:38:36 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id w21sm7064775pjy.21.2021.04.16.21.38.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 21:38:36 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 7/8] mm: memcontrol: move obj_cgroup_uncharge_pages() out of css_set_lock
Date:   Sat, 17 Apr 2021 12:35:37 +0800
Message-Id: <20210417043538.9793-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210417043538.9793-1-songmuchun@bytedance.com>
References: <20210417043538.9793-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The css_set_lock is used to guard the list of inherited objcgs. So there
is no need to uncharge kernel memory under css_set_lock. Just move it
out of the lock.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c4eebe2a2914..e0c398fe7443 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -289,9 +289,10 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
 	nr_pages = nr_bytes >> PAGE_SHIFT;
 
-	spin_lock_irqsave(&css_set_lock, flags);
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
+
+	spin_lock_irqsave(&css_set_lock, flags);
 	list_del(&objcg->list);
 	spin_unlock_irqrestore(&css_set_lock, flags);
 
-- 
2.11.0

