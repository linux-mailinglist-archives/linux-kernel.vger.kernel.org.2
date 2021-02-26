Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B604325FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhBZJUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhBZJSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:18:20 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E5BC061788
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:17:40 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v6so9467771ybk.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=k0AsilW2lYipSpVRHZF9m6q/kGFfsp0ZK/tsphAGUXA=;
        b=UHEC7ePpDsJxvd5Z+OdWIwRzJX+EcAcdBJEBOYglWMs7rB+gp9uZxDQaNXeYa+ofaJ
         SiEpldqigfsRGuA4QBVnhtIfqzHB7PsKkXWCayrA0xA2MQHGNejP4oKuhd6tH0GSmKAb
         98+hYxQYCRGa7ezb8EDKcXVFiGCnrPzid2kg4uTLKqeY2y4RIsgBh2mgjCzo8pWDL84l
         dbw0PXJYZIZbc+KwexI+I7CaM3cH5eWaTIOG95eknluTAh5bOxasbNCVkWjhKuEWZMOA
         BahRgoFguRSEXrdZAODV6x981mT424sbq7WH6yf0yHp4KYmnAw5myb0dELfiut5iPDa8
         m6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k0AsilW2lYipSpVRHZF9m6q/kGFfsp0ZK/tsphAGUXA=;
        b=Og1bj6mVegM90/yM53CKCUj+DfEcWfL5k6eBsvqIOafqd3LzyoqAwPHrRWqLXYBT/G
         tfZqQvCi38as0YmNOTdQXhJa4f961yky8ZEiQy0haDZvWlVNc8O/tP+Tz4SImPJldVDx
         PcJW5f+E0l6bkzvtVppSs3lb5BvFHfZnrTwe+vNNmkYH1wRjaSyxyecgpnGIqqNZ3arn
         bRy6oy8T6SSqgG+aksdSiU/oqji1IKwYXR4z77CZ6jQED4/dgVZvAC/iYCwnCxKI5DaA
         M4k/oNESCSS5ngTIzNUqoq/cUUXBi8cbvvsu4r1W0/fubs6HDnh3sxrQqKOMf4RiExZR
         C1Bg==
X-Gm-Message-State: AOAM533w6D6DcysvowGlwVgZmM4Se6b9ky0IVj0N1kAMZQixHrIm3Zol
        7NcmC+TPBk+Mp/OUfy2TTQGPy/zP4E0=
X-Google-Smtp-Source: ABdhPJwIpDGfxBRdjyRoue8vq2zd8/aPXQONGuLd0v8LLbixUC5GkHVl4LonYYZAHNYpAdHhTddLH3b5xfA=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:69b6:2618:c96a:ceba])
 (user=yuzhao job=sendgmr) by 2002:a5b:2cb:: with SMTP id h11mr3280115ybp.428.1614331059498;
 Fri, 26 Feb 2021 01:17:39 -0800 (PST)
Date:   Fri, 26 Feb 2021 02:17:17 -0700
In-Reply-To: <20210226091718.2927291-1-yuzhao@google.com>
Message-Id: <20210226091718.2927291-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20210224084807.2179942-1-yuzhao@google.com> <20210226091718.2927291-1-yuzhao@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2 2/3] mm: use PF_NO_TAIL for PG_lru
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

Trying to set or clear PG_lru on tail pages has been considered buggy.
Enforce this rule by changing the policy for PG_lru from PF_HEAD to
PF_NO_TAIL. This means setting or clearing PG_lru on tail pages won't
be "corrected" by compound_page(). Such "correction" isn't helpful --
even if a piece of buggy code has gotten away with
compound_page(tail)->flags, it will run into trouble with lru list
addition and deletion because they use tail->lru rather than
compound_page(tail)->lru.

bloat-o-meter result:
  add/remove: 0/0 grow/shrink: 0/11 up/down: 0/-535 (-535)

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/page-flags.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1995208a3763..c9626e54df8d 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -333,8 +333,8 @@ PAGEFLAG(Referenced, referenced, PF_HEAD)
 	__SETPAGEFLAG(Referenced, referenced, PF_HEAD)
 PAGEFLAG(Dirty, dirty, PF_HEAD) TESTSCFLAG(Dirty, dirty, PF_HEAD)
 	__CLEARPAGEFLAG(Dirty, dirty, PF_HEAD)
-PAGEFLAG(LRU, lru, PF_HEAD) __CLEARPAGEFLAG(LRU, lru, PF_HEAD)
-	TESTCLEARFLAG(LRU, lru, PF_HEAD)
+PAGEFLAG(LRU, lru, PF_NO_TAIL) __CLEARPAGEFLAG(LRU, lru, PF_NO_TAIL)
+	TESTCLEARFLAG(LRU, lru, PF_NO_TAIL)
 PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
 	TESTCLEARFLAG(Active, active, PF_HEAD)
 PAGEFLAG(Workingset, workingset, PF_HEAD)
-- 
2.30.1.766.gb4fecdf3b7-goog

