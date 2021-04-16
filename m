Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117CF361928
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbhDPFQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238609AbhDPFQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:16:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F337DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:16:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u11so9656619pjr.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y8TwextheIbDJq4JEPMsgtPW4imrEmOBZladzG6/EIY=;
        b=HoswKfBgJEUAeaMh1rPnmApf19VxOGH4LxCzAAWsLcCDsEJ8GosQcQPJblt+T7JZQN
         r71ipPvNggvX+8yVTjlCBkzMqiV9mO1+R0ztqecdTYYhVEYAdxJCRsulXBT29kTm5GMF
         yIIw/0cWyOm7IL4zWeV8RMSiZx4ntXvj6H4+sCRnDq7GheeYJUNEq2Fo+0HV63X4l9mk
         9Bd+o5MXhoiGnagKy7YFgSOjH4P5wsMdUUQiXFiVo997n7F1nZvBadfLSDtkCr+1xJgs
         aQJ4kVAQAaUaXgzq/bo9yvy+PMbauZJycOroQXYvrMj8bT8zseAK4eESsLH38n9wC1o/
         BXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8TwextheIbDJq4JEPMsgtPW4imrEmOBZladzG6/EIY=;
        b=hgHK8h/w1ASXo5T7SpDL2cyWOdj0cg0LRiF46SfNt3zZJYdP0soKE6IAdb511Hf3Hw
         bUBwHW+gF3nwIafaahq6OWF5NQNy+AJx4N1VzxlHiYPAqHRtjx9RBZg1Zx+w/Kqi0Tn9
         lGmxrR8G90wZKQm2OzSgl5d1pWpTmt2O4s/g/fIOl/TsJhTpHhpUzJi2KTMpeOeVlg2V
         xYklKFEyC+SbFQNXqXH3via3BYbniyrTjfsEVKI2g+4qL1wWJn6ThSBmyJM7qfBGXtta
         Mj64bwatiQWuD7NmgjRkG8Hlo2jA8UpgwxW8EqLQru4GHqd2vyGzz6mlmH0c6joC3Li5
         LDgA==
X-Gm-Message-State: AOAM531m4lJItLfe6phYL1/oxv+zT9y9EHkK2X5xYYwHtF9+xEcif0kI
        uWvRqfvLKa2j4tbwtv7vZ7J6xQ==
X-Google-Smtp-Source: ABdhPJw9GKAMCuwJ22HjA/xotV/FWoBOFr8YI7Kfw+R1/pWOK3g+g9MUgjT0ClJCL20xK6itrBQIPA==
X-Received: by 2002:a17:902:b602:b029:e6:cabb:10b9 with SMTP id b2-20020a170902b602b02900e6cabb10b9mr7627812pls.47.1618550173628;
        Thu, 15 Apr 2021 22:16:13 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id j7sm3518540pfd.129.2021.04.15.22.16.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 22:16:13 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 7/8] mm: memcontrol: move obj_cgroup_uncharge_pages() out of css_set_lock
Date:   Fri, 16 Apr 2021 13:14:06 +0800
Message-Id: <20210416051407.54878-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210416051407.54878-1-songmuchun@bytedance.com>
References: <20210416051407.54878-1-songmuchun@bytedance.com>
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

