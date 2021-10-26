Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E0D43B849
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbhJZRk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbhJZRkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:40:51 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDFDC061243
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:38:27 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id x123so16005059qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YFzPbDbRL/x6ma5Ca6cfrOJFG3iWMh8fKsCfxaMAfk8=;
        b=YS8eDNpGNOgrhmCcfg9iAfefq9xkwMoUI89lf12WEOadcE9GDaOq+SrKS9at0LRDOq
         QvV0zAPSnq6Jhf+lzstiFxhlVkIwVx4nK7on89VHZHwKlMEIXw1zoSlurpwB9TvtKBTP
         JSu0GGc+AphS9BEpoZN/RJX+iu1jkmCQW74rf3K0Sg29I/WviQ0Q9/H9RigjK1eYZPsK
         rvQLAwaMnsYn6LyrWGHH+63AE9ls3BqAr0OcH3+O5Oc+JjwiD7aBNfJdskPJ+of9GbLn
         XPJjW6DABqlkPdAY4lnOphSbXTpcajPuRlVFi9DfIlW/62zNKjXbx+xO+cVxKhYlrd9U
         M/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFzPbDbRL/x6ma5Ca6cfrOJFG3iWMh8fKsCfxaMAfk8=;
        b=iTNRWnmzrHmwBC/BUZZRlBGcgHCl4EyYJ1D1/VTBF4pKGYZwAhG1W+oBXz3B9kAtWt
         JjyOz1YdVX8Ufw7qdVD4tHkad8aPXzPGIHEHR4ksd/d2j64jLOL4bjabZ02LttrE59AQ
         261LudNR2X/W4PYlNA90uZLdeeI0c8X9LFbHrzoD445DX2EpFNcC1THaO6VqCY5I4DUt
         m80x6lvhdDuzOus6eZg53OF53ZmYm2j6bx0s9hiXKiF2h8RKulRYitWXSN9iQatD2wBN
         7TFEVPpguReI+WUCk4flM7O7TL449oRe2mlOxm4CQjAAnv1hstzErxjXz6AJGPPeEeiL
         Pk5w==
X-Gm-Message-State: AOAM531XzAJ224W+DpjfMtHxQs10i4uBd1JvwyLPUlHuMBfAhp4pcVi7
        HRXwK7EPk0dqFk4RT2F17umSyg==
X-Google-Smtp-Source: ABdhPJzJ5B+p6Rwtjwrqe/0j7MwD86qEOkIZcZ9ny2M9nsl7064QiqLbNAf1+bTV9ovTuHVldv6+BA==
X-Received: by 2002:a05:620a:29d2:: with SMTP id s18mr3823816qkp.418.1635269906887;
        Tue, 26 Oct 2021 10:38:26 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id bj37sm11001939qkb.49.2021.10.26.10.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 10:38:26 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        anshuman.khandual@arm.com, willy@infradead.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com
Subject: [RFC 2/8] mm/hugetlb: remove useless set_page_count()
Date:   Tue, 26 Oct 2021 17:38:16 +0000
Message-Id: <20211026173822.502506-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
In-Reply-To: <20211026173822.502506-1-pasha.tatashin@soleen.com>
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prep_compound_gigantic_page() calls set_page_count(0, p), but it is not
needed because page_ref_freeze(p, 1) already sets refcount to 0.

Using, set_page_count() is dangerous, because it unconditionally resets
refcount from the current value to unrestrained value, and therefore
should be minimized.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 95dc7b83381f..7e3996c8b696 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1707,7 +1707,7 @@ static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
 			pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
 			goto out_error;
 		}
-		set_page_count(p, 0);
+		VM_BUG_ON_PAGE(page_count(p), p);
 		set_compound_head(p, page);
 	}
 	atomic_set(compound_mapcount_ptr(page), -1);
-- 
2.33.0.1079.g6e70778dc9-goog

