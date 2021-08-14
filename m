Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCF03EC0AA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbhHNF0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbhHNF0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:26:13 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5942DC061757
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:25:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w14so18375945pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2uac+sn95cIQHLEW0GWlzK2VueAN9tRynbXsxCLuwFw=;
        b=Qcvlsd7b4p/JVpBcCXWk50h9oVvNbW1BNiYTDwmKZo/j9+6f2V0XG7LSfvbmZL2tUh
         vMiFTDr648lK4QAdhvqVw8yrexBekOVMse2tPD0MI8JUVsrQjMuOwhk2w1BIvmYii5VH
         P2JPYvoa6XMMkkJAax1Bj+OTICG8G9CkLm/ZDRmiA5c5U7LEdn6QCp9LzmiCLzYaQytw
         tQS4PYu6uEBTmaz9ws5xAeDZINwpgtvudCvfyFnmZfW3RGM8+DoizqmBsd157ja06pTt
         xOWJLJrOtGUeWMClVglBHu7GnS8dvvSTqASB4KJ7FAYkVp6gv8iodEHWAvETe+l4/gvH
         Wtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2uac+sn95cIQHLEW0GWlzK2VueAN9tRynbXsxCLuwFw=;
        b=IcRs5AJeoVQS5KRHPcWbidcXxaJsaeIj1Uz6hfxqvlWL0HsHNRyMoP0NQ0T9gb8dl6
         Ylr9Py4feY6UEOAFTn5ctGGBgvSS0j/ktPSDXTTmi/OvYFoeu4oiHnGj5sxhAr3h3e9S
         q7fS002WQB7gY90cWogg2wdXVn477yGVhLgVzt6W5N9KaVhl/8OVmRgKpeq0fn3VZKFG
         6CvxFacoJp4WUnwnKEZsBRrKCNbKVIn3hoNsFD/BZTijv8awoWmB7tIwMjp17l7mOq5N
         7pKzujz2YiqKc0kqXiPKwXaV6/PDWi3e7PNJQlGjAl/7ehmSOdK8I6ZmmD2k7YljY3lf
         K6yw==
X-Gm-Message-State: AOAM530h2qIFEyI2LqloyuhUxGmhbTCnCeVPJwsirjrJgel/osF/tqKE
        43p+HXamVQ1qNYcl1sMZQwUj8G+zEuspNULe
X-Google-Smtp-Source: ABdhPJw0LAgLcb5hqFA89s26U6zvCZxN50nfHyJyFspItLg3UVuEz9ozEtTUp5gfBtL6FX2mRvXcZA==
X-Received: by 2002:a17:90a:2bcb:: with SMTP id n11mr6017017pje.198.1628918744940;
        Fri, 13 Aug 2021 22:25:44 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s5sm4783133pgp.81.2021.08.13.22.25.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 22:25:44 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v1 02/12] mm: memcontrol: introduce compact_folio_lruvec_lock_irqsave
Date:   Sat, 14 Aug 2021 13:25:09 +0800
Message-Id: <20210814052519.86679-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210814052519.86679-1-songmuchun@bytedance.com>
References: <20210814052519.86679-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we reuse the objcg APIs to charge LRU pages, the folio_memcg()
can be changed when the LRU pages reparented. In this case, we need
to acquire the new lruvec lock.

    lruvec = folio_lruvec(folio);

    // The page is reparented.

    compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);

    // Acquired the wrong lruvec lock and need to retry.

But compact_lock_irqsave() only take lruvec lock as the parameter,
we cannot aware this change. If it can take the page as parameter
to acquire the lruvec lock. When the page memcg is changed, we can
use the folio_memcg() detect whether we need to reacquire the new
lruvec lock. So compact_lock_irqsave() is not suitable for us.
Similar to folio_lruvec_lock_irqsave(), introduce
compact_folio_lruvec_lock_irqsave() to acquire the lruvec lock in
the compaction routine.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 mm/compaction.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index fbc60f964c38..3131558a7c31 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -509,6 +509,29 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
 	return true;
 }
 
+static struct lruvec *
+compact_folio_lruvec_lock_irqsave(struct folio *folio, unsigned long *flags,
+				  struct compact_control *cc)
+{
+	struct lruvec *lruvec;
+
+	lruvec = folio_lruvec(folio);
+
+	/* Track if the lock is contended in async mode */
+	if (cc->mode == MIGRATE_ASYNC && !cc->contended) {
+		if (spin_trylock_irqsave(&lruvec->lru_lock, *flags))
+			goto out;
+
+		cc->contended = true;
+	}
+
+	spin_lock_irqsave(&lruvec->lru_lock, *flags);
+out:
+	lruvec_memcg_debug(lruvec, folio);
+
+	return lruvec;
+}
+
 /*
  * Compaction requires the taking of some coarse locks that are potentially
  * very heavily contended. The lock should be periodically unlocked to avoid
@@ -837,6 +860,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 	/* Time to isolate some pages for migration */
 	for (; low_pfn < end_pfn; low_pfn++) {
+		struct folio *folio;
 
 		if (skip_on_failure && low_pfn >= next_skip_pfn) {
 			/*
@@ -1022,18 +1046,17 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (!TestClearPageLRU(page))
 			goto isolate_fail_put;
 
-		lruvec = folio_lruvec(page_folio(page));
+		folio = page_folio(page);
+		lruvec = folio_lruvec(folio);
 
 		/* If we already hold the lock, we can skip some rechecking */
 		if (lruvec != locked) {
 			if (locked)
 				unlock_page_lruvec_irqrestore(locked, flags);
 
-			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
+			lruvec = compact_folio_lruvec_lock_irqsave(folio, &flags, cc);
 			locked = lruvec;
 
-			lruvec_memcg_debug(lruvec, page_folio(page));
-
 			/* Try get exclusive access under lock */
 			if (!skip_updated) {
 				skip_updated = true;
-- 
2.11.0

