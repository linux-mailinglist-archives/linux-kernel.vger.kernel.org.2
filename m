Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C68B42AB6B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhJLSEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhJLSD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:03:56 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1686C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:01:54 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id az39so6532125qkb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lyh5VszI4R7zeybDzYqsIPSiDXABCH8mlDeTJtPXHYo=;
        b=uW83OlcYmd9OYcOM7gdtBuDzsXhWtXx1xhFC2d6WrbzMz8avtsJakLyys2WcAwd1id
         t+puB5jH0LxZZN+VR7IXNhLdGUeCFeEIot2al+WyrrFsMFcrwu/yKJzyNNyFE6+K/rKi
         2i8FnA1fOa4exo5V9P4Ilme1WXxoywz7C8xWoWiBw921RNFjH7kfo2PtgutGdCKrBRoY
         4pa505He3m0IqeodsA/Z8+ifYbmV6SxZwfNnQ7d3nuryD9A0w2z3+PWk4fe+8BG/B4sA
         ndwiMUfixeU3DYgvLWGursDymyc5jmBd7KUfoSEpqAOnFOYviOf1xQ3dPZsjVAHQT1JF
         zuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lyh5VszI4R7zeybDzYqsIPSiDXABCH8mlDeTJtPXHYo=;
        b=a9vpAhbmdyA2uKk/yZkZXb1AX7X6b3FdwNPfspRFMSFqH9fnMqwG1QbkWWzxH0c/z6
         xo51q4KSYzCQgYHMVEtYcf1Ri3GX0s8RXqeMGCMDcNj9xbojToJGSZxOMaIjV6jqBCfG
         3mRwtnWugqsAVidGhNFGUDTtwUZAk6vTrs8RhFoEEiiTQ25a6g+l8+ah6WTWmFCxesy9
         4ifE54rsXxPhr5EzNmLCKrXiiZdeiqV2/jLvF0upVHJHsoXEeeTv7TE1knVcW8zk4PDt
         QjLVaO8j3E99yZG1GSukjjWN0SQMaNQe3tsk6bXMhP/pK6XvjwYO5N8LrQosWd2TusWi
         BSNg==
X-Gm-Message-State: AOAM530WKvoCAwrbL5wClYMWg3lUuYfsK7lUGL+bYvoGfBHuEFM1QJYH
        14+8uUUWvNiCpDAr938gIhTiZQ==
X-Google-Smtp-Source: ABdhPJzrK8bQDC7NK5HHGHuo4A32b4Tvsk/5CgUECMVqu9ckf3I8IoJVXNxz+cQGMAGQgU4EnksWpA==
X-Received: by 2002:a37:2743:: with SMTP id n64mr8926545qkn.394.1634061713973;
        Tue, 12 Oct 2021 11:01:53 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id a4sm5526589qtm.12.2021.10.12.11.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:01:53 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/11] PageSlab: eliminate unnecessary compound_head() calls in fs/proc/page
Date:   Tue, 12 Oct 2021 14:01:39 -0400
Message-Id: <20211012180148.1669685-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012180148.1669685-1-hannes@cmpxchg.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache multiple lookups in a local variable.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/proc/page.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 2c249f84e1fd..37d95309e1c1 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -108,6 +108,7 @@ static inline u64 kpf_copy_bit(u64 kflags, int ubit, int kbit)
 
 u64 stable_page_flags(struct page *page)
 {
+	struct page *head;
 	u64 k;
 	u64 u;
 
@@ -118,6 +119,7 @@ u64 stable_page_flags(struct page *page)
 	if (!page)
 		return 1 << KPF_NOPAGE;
 
+	head = compound_head(page);
 	k = page->flags;
 	u = 0;
 
@@ -127,7 +129,7 @@ u64 stable_page_flags(struct page *page)
 	 * Note that page->_mapcount is overloaded in SLOB/SLUB/SLQB, so the
 	 * simple test in page_mapped() is not enough.
 	 */
-	if (!PageSlab(compound_head(page)) && page_mapped(page))
+	if (!PageSlab(head) && page_mapped(page))
 		u |= 1 << KPF_MMAP;
 	if (PageAnon(page))
 		u |= 1 << KPF_ANON;
@@ -151,8 +153,6 @@ u64 stable_page_flags(struct page *page)
 	 * to make sure a given page is a thp, not a non-huge compound page.
 	 */
 	else if (PageTransCompound(page)) {
-		struct page *head = compound_head(page);
-
 		/* XXX: misses isolated file THPs */
 		if (PageLRU(head) || PageAnon(head))
 			u |= 1 << KPF_THP;
@@ -185,7 +185,7 @@ u64 stable_page_flags(struct page *page)
 	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
 
 	u |= kpf_copy_bit(k, KPF_SLAB,		PG_slab);
-	if (PageTail(page) && PageSlab(compound_head(page)))
+	if (PageTail(page) && PageSlab(head))
 		u |= 1 << KPF_SLAB;
 
 	u |= kpf_copy_bit(k, KPF_ERROR,		PG_error);
-- 
2.32.0

