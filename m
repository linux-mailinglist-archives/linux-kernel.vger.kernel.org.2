Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE0E33229F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhCIKJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhCIKJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:09:11 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59837C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 02:09:11 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id fu20so635892pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 02:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qTJbj+bHGwrcKPZVFV0B4s52LD4dHzSLrz0c48QpEbw=;
        b=RQ7Divm2aZh0WH7Jb+9JI+tZWXNMnj7ERXR0m2p0ZrH5HGUbl95JJHc5qrbLDMX88A
         U1c1JYkCCQkCAcHgQG3HP3EqJnZhZKEatO2LtpGTlRepR0TdBd2cpbyXDJ6KHne88CZq
         yA7lzE50UMOg0cmwYEjiYQywg/3kAb5JSTGNQv+qrpF4o/VL+nZ+gJzkYNO3A9o8jcdW
         3it+YVkUr/vMIAD9xZx3/LSTlT7CcKfxWnD4L9TAQP2F5JHBIBA8trYPiaAiWpBdtrvh
         a06q0VnUXD1JkJ2Q1Cx65wokztExnw8cmvMWi/iPc0OGAWNgSzFhFYIHyxUBalvhHrJu
         4W4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTJbj+bHGwrcKPZVFV0B4s52LD4dHzSLrz0c48QpEbw=;
        b=CeFtXwiPNfjtYYRgbHMYteIMp2L/W1VsujxD5ejDFo6wGY5NJ898I2NLPsWIGmIMtS
         WL0FRgJaPX0J++ti7cpTqqHs2Gs13yqBLRefNtaJjjnthSN8Gnw6hoF1ZzolE+Bo5tID
         NU3yCY1eDkYCjPpM2eb5lavT+N7qncprLNlzoc+Q0FGU/b3aAPaDwiKTub0ey9PMHjLJ
         0mIlf6bJr7OAc70YSN3fxL3fvut6JhR29QLL6sObrF8wnTUiv/tKTMpvsLvhNvm7RVGw
         v5UJO/MXWIivnHAS5+kD/60K/i5TkfVBYK/mBX4Zm9gaa2J3e+YrWmpbhLPH9gqUy2Q+
         7PdA==
X-Gm-Message-State: AOAM533uElZ8Tn91p5IO1jAZi0RAweGh39hxNqZv31CfNGTddL8QtXw9
        dEy8olA9wdck2TEZVkOY5lEJlw==
X-Google-Smtp-Source: ABdhPJyWchdqh/CYZ41KxFNRdvzk6t/duAn74ceMdAR046SE1ztNLZF+5rYZjR2B0CD2D+CIelI8cg==
X-Received: by 2002:a17:902:9691:b029:e3:dd4b:f6bb with SMTP id n17-20020a1709029691b02900e3dd4bf6bbmr3130697plp.77.1615284550974;
        Tue, 09 Mar 2021 02:09:10 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id a70sm9258424pfa.202.2021.03.09.02.09.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 02:09:10 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 4/4] mm: memcontrol: move PageMemcgKmem to the scope of CONFIG_MEMCG_KMEM
Date:   Tue,  9 Mar 2021 18:07:17 +0800
Message-Id: <20210309100717.253-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210309100717.253-1-songmuchun@bytedance.com>
References: <20210309100717.253-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page only can be marked as kmem when CONFIG_MEMCG_KMEM is enabled.
So move PageMemcgKmem() to the scope of the CONFIG_MEMCG_KMEM.

As a bonus, on !CONFIG_MEMCG_KMEM build some code can be compiled out.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 07c449af9c0f..d3ca8c8e7fc3 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -469,6 +469,7 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
 	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 
+#ifdef CONFIG_MEMCG_KMEM
 /*
  * PageMemcgKmem - check if the page has MemcgKmem flag set
  * @page: a pointer to the page struct
@@ -483,7 +484,6 @@ static inline bool PageMemcgKmem(struct page *page)
 	return page->memcg_data & MEMCG_DATA_KMEM;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
 /*
  * page_objcgs - get the object cgroups vector associated with a page
  * @page: a pointer to the page struct
@@ -544,6 +544,11 @@ static inline struct obj_cgroup *page_objcg(struct page *page)
 	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 #else
+static inline bool PageMemcgKmem(struct page *page)
+{
+	return false;
+}
+
 static inline struct obj_cgroup **page_objcgs(struct page *page)
 {
 	return NULL;
-- 
2.11.0

