Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0640F42AB78
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbhJLSEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhJLSEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:04:05 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EBDC061767
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:02:02 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id n12so197723qvk.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a7XABMOoymgkbcoo6ZtkRDMSDt06eIQo5rFsIuxFmeE=;
        b=m5wmVkJMh33Z9cOp79n7VVYuLnyUoX7yOoJUKNLNg4xJqPTZj4Ia1mLGb5Pf3vbkuM
         pcJuVSqiwxXq8xiJ7jvfyne8fnCj8hcS+7/9/9bHPWhYmHEayMlxPoGFfZiS62GKc7Bp
         OOJaJFO8wiOtXuh1Rya0oeNfC7gU3WJsxLCurYqX4grXeqdgpQ9lgMAwFAr8bsZH+Okb
         aLdPzVMPy+EpA5O1YbEyKYPt/x/gZeEzrUUpt8Oei07UKQg4U1f3hptZBPlNQicpqcXP
         L2T6ja/boBEdOcQaonHA2XU3k5LoU/VmQFuk+45B/qAY4Pr4ymC1gpMBvLutTiGZdgfU
         xrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a7XABMOoymgkbcoo6ZtkRDMSDt06eIQo5rFsIuxFmeE=;
        b=TBLhpAVY0pAwbHQgg1fjBUGsX7b9+NEVk7ZjVRZEmh5J0DXysqrIVAdQCoineD/Ndb
         PEvELW8QjgH76nf5ULV5Ww670BvHwm+7hR6WH26cmljA+IyOZUmqIvrFI8O94209quTz
         vs2SpDCvHkmet/sgUPc6cS6yuqU1Di9fDcmILr8L7+Mvi6hgKEBA1R+rEbhZq2uI6Db+
         bU1X2Saz1Y+6lSMJfzNWNoG2P7Jb3m4i8eTFK6dOnegQw2b/IagtsEOSp5sV8M6ooG6G
         jxZ1j0zYcjhjlA6w5AhBXNpk2X5q+NeQBYi68B6eIKkLbz3A4HEVXf03pF5+g02ZNnTW
         ItFg==
X-Gm-Message-State: AOAM5332Ekhmcbq3lZIALnTze6sFqX6efZG1aeSi7YKIUtG2eueHu9pb
        S/Q7xRwZSSgyt/1COawOVjCrCg==
X-Google-Smtp-Source: ABdhPJwl5SDEbPaff1ENR4HVvlY5tr2GgtyFZjAxERPqQ4NzNIGb7/CniB5M5sALLSfvwuMi6AoxSw==
X-Received: by 2002:ad4:54c8:: with SMTP id j8mr31830935qvx.45.1634061722202;
        Tue, 12 Oct 2021 11:02:02 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id b20sm7191158qtx.89.2021.10.12.11.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:02:02 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/11] PageSlab: eliminate unnecessary compound_head() calls in mm/memcontrol
Date:   Tue, 12 Oct 2021 14:01:48 -0400
Message-Id: <20211012180148.1669685-12-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012180148.1669685-1-hannes@cmpxchg.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page->memcg_data is generally not valid on tailpages, so the accessor
functions don't need to worry about encountering them outside of
bugs. The only place where the memory controller may encounter tail
pages is in mem_cgroup_from_obj(), but that uses virt_to_head_page()
first thing to resolve slab objects to slab pages.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 02394f802698..3096c9a0ee01 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -397,7 +397,7 @@ static inline struct mem_cgroup *__page_memcg(struct page *page)
 {
 	unsigned long memcg_data = page->memcg_data;
 
-	VM_BUG_ON_PAGE(PageSlab(compound_head(page)), page);
+	VM_BUG_ON_PAGE(PageSlab(page), page);
 	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
 	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
 
@@ -418,7 +418,7 @@ static inline struct obj_cgroup *__page_objcg(struct page *page)
 {
 	unsigned long memcg_data = page->memcg_data;
 
-	VM_BUG_ON_PAGE(PageSlab(compound_head(page)), page);
+	VM_BUG_ON_PAGE(PageSlab(page), page);
 	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
 	VM_BUG_ON_PAGE(!(memcg_data & MEMCG_DATA_KMEM), page);
 
@@ -466,7 +466,7 @@ static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
 {
 	unsigned long memcg_data = READ_ONCE(page->memcg_data);
 
-	VM_BUG_ON_PAGE(PageSlab(compound_head(page)), page);
+	VM_BUG_ON_PAGE(PageSlab(page), page);
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	if (memcg_data & MEMCG_DATA_KMEM) {
-- 
2.32.0

