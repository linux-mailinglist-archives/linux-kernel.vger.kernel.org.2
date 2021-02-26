Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E178325FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhBZJVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhBZJST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:18:19 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA12C061786
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:17:38 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id h18so5082437qto.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0x/I6VizqDyhm0WRlAzYBf6vGqHgQIhvNWl/lQMoOjU=;
        b=ufifuNchyUu2Nt42yOFNtvE/0fxr6qejoIo4Dev4JvqNYsjyp0xq7qZdQrLXSib3Li
         SlXaXsyXqwvxynIi718qmiG/z2vXsv+d0yTBbaVvGpvzSXg70ChdMtwM2sJR5AYucgsF
         QBFvSAWneW8HKhkJBK0wYqaLwHkm0pwr4RTSg7IUnDogznC/HmPLCYeM4g0lb2Jx3jI+
         pHoNnLMV0w3KiEjAQ0gj5pMP1TG8Hc0UqODqK2b4Oymszu7WiJWR/NvTvPnf7Dou+PSl
         M46fxIkgoMQjQbRTIDmyyQvXAnGgh891FKyfxRYZMoKfVV8EMNGllFaiX3SBpQcwF5dR
         qtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0x/I6VizqDyhm0WRlAzYBf6vGqHgQIhvNWl/lQMoOjU=;
        b=OkIG7eG8feH+t+KToHfGDK3egIQBpkd1X+ZiK4X+b8OJeImAzsOxQ+AvSEHefWnrdl
         qSMRMdfoh+NgdLy+PSJ/lnYFNlgmG64t0tKR7Ho0WgMZHPpb93buGJ9eXNt8ktUSjvs6
         LTTbprw9sKE452J/ceAZrO5jZwKBy1Qi4AZclOAM1dNU+6hB/dyK5tzCb+inOPdmOTNc
         lQLEgfKZ4yWkSVgNVO7n3Egfmer8HimAJP6Y0cVKwlWAjezozkuyy/+h372qd5xQ18U/
         gKVL/YCjUO0BSz0UCLEYjdHZJWxG7Hu3VHN47G1FBq8K2H0y3SQO1hzqtRHJVKbm3O6P
         kZHg==
X-Gm-Message-State: AOAM532+gKcghZ/7IJ29N6HcbCTmHdXZ9ogv6yolGGilx1qQm89K3yrG
        FtxdItHNEuL/CDb6GeOjEFmd7ugk1Hc=
X-Google-Smtp-Source: ABdhPJw/aX/0da6jr3fSWHl1QzaFZ7UomaCtvoWaPyk2ZmV0Zmb1C1s8a8/tVeafRVV6AkPSlq9+KbqfxQ4=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:69b6:2618:c96a:ceba])
 (user=yuzhao job=sendgmr) by 2002:ad4:50c7:: with SMTP id e7mr1843885qvq.58.1614331058054;
 Fri, 26 Feb 2021 01:17:38 -0800 (PST)
Date:   Fri, 26 Feb 2021 02:17:16 -0700
In-Reply-To: <20210226091718.2927291-1-yuzhao@google.com>
Message-Id: <20210226091718.2927291-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20210224084807.2179942-1-yuzhao@google.com> <20210226091718.2927291-1-yuzhao@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2 1/3] mm: bypass compound_head() for PF_NO_TAIL when enforce=1
From:   Yu Zhao <yuzhao@google.com>
To:     akpm@linux-foundation.org, alex.shi@linux.alibaba.com,
        vbabka@suse.cz, willy@infradead.org
Cc:     guro@fb.com, hannes@cmpxchg.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing page flags with PF_NO_TAIL (enforce=0), tail pages are
legit and they are converted by compound_head(). When modifying page
flags (enforce=1), tail pages are not legit and they either trigger
VM_BUG_ON_PGFLAGS() or are "corrected" by compound_head().

There is no evidence such "correction" is beneficial in terms of
preventing a buggy kernel from crashing. But there is clear evidence
it's detrimental to the size of vmlinux because compound_head() is
redundantly inlined for all modifications of small and head page flags
using PF_NO_TAIL.

This patch makes PF_NO_TAIL skip compound_head() when modifying page
flags. There won't be any behavior change unless a piece of buggy code
tries to modify tail page flags using PF_NO_TAIL. Such code won't be
"corrected", if VM_BUG_ON_PGFLAGS() isn't there to catch it. Again,
there is no evidence such "correction" is beneficial.

bloat-o-meter result:
  add/remove: 0/0 grow/shrink: 4/62 up/down: 309/-2851 (-2542)

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index db914477057b..1995208a3763 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -248,7 +248,7 @@ static inline void page_init_poison(struct page *page, size_t size)
 		PF_POISONED_CHECK(page); })
 #define PF_NO_TAIL(page, enforce) ({					\
 		VM_BUG_ON_PGFLAGS(enforce && PageTail(page), page);	\
-		PF_POISONED_CHECK(compound_head(page)); })
+		PF_POISONED_CHECK((enforce) ? (page) : compound_head(page)); })
 #define PF_NO_COMPOUND(page, enforce) ({				\
 		VM_BUG_ON_PGFLAGS(enforce && PageCompound(page), page);	\
 		PF_POISONED_CHECK(page); })
-- 
2.30.1.766.gb4fecdf3b7-goog

