Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A688B3665F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbhDUHCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbhDUHCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:02:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF2DC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:01:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c3so9026023pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1jWf6wXeanSmSmMSSE18ypMxbLFXQjpA7EbmbEqV6bE=;
        b=dVVlZQXlx3+m0WoIyaZrnBkar5iQ2BTeO2QU9KlEaGI0Qge6QcQMzejtiIqpmyMwRh
         3WfkrdULdhv6PEThGkAlseRO4wyok6fVOBmanqh8Zu3+rUL93mbO6A3KhEGp6OgfzEah
         KTl5Tfk6Bgq9E59hm48zC0fsEq6pGuyOB7YamBaUecQwzzcXavnNIbj5vOJhaJlzLh5E
         GgYWJUqYOEjMjX+M2uhTrOI80nzkeCq0MeiiMgFYMs1fqZSiYdB5r7HwyE4Bi4UMtf+d
         jTwCt8up9LwPp8/GKrn2/zNBMrAYiz3BFsy7M+13BEtWIg70tLGMvT8UhZo8DGSQoDIp
         TmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jWf6wXeanSmSmMSSE18ypMxbLFXQjpA7EbmbEqV6bE=;
        b=sMoy5Z34ADy5pekuwidheNbAiaY/qMnxFlRb8BNuy2MxdZnxE3z32R2Jxeiss+ibxi
         NVbjhemazyjBP/w0I51vS3uRmQzDPrCj9m9/peu2ZM0cIDQ+x+rVw4U+E/uo2eYXis+t
         KN/AWfr6SQJ/AGM+cncenVS1etH6snWLmZ8TnoOPkzwZAOyuBw1tOOkPoVDwUicqsWbI
         LFsJaccLNyMgUOAJuyzGfmUXfrYpHF+01Xa3xljxNPCWx5Db/x925SwyO3KfSTphKVs5
         8IzNqJpKIsP+k0snuKjDkAyF6ftHZ0/NyBtTaK5U0qxKyIVZ3EzrZMiTDwVG0oUpcRi/
         f6EA==
X-Gm-Message-State: AOAM530oT1UgXmlGEGa90OIDl+SoawnYHRNhd5idSWFvHw9TCacX/0DH
        Vv643IHh5al42owciG86Ib0fMg==
X-Google-Smtp-Source: ABdhPJw/KrItEU5wN2AaFalddNyOW9vyvrxg+qHxDKpZ8/ioFz1Qh7llc9OSt8xrWaXexp9LJ6c8TQ==
X-Received: by 2002:a17:90b:19d1:: with SMTP id nm17mr9296088pjb.218.1618988487152;
        Wed, 21 Apr 2021 00:01:27 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id c4sm929842pfb.94.2021.04.21.00.01.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Apr 2021 00:01:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v3 02/12] mm: memcontrol: introduce compact_lock_page_lruvec_irqsave
Date:   Wed, 21 Apr 2021 15:00:49 +0800
Message-Id: <20210421070059.69361-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210421070059.69361-1-songmuchun@bytedance.com>
References: <20210421070059.69361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we reuse the objcg APIs to charge LRU pages, the page_memcg()
can be changed when the LRU pages reparented. In this case, we need
to acquire the new lruvec lock.

    lruvec = mem_cgroup_page_lruvec(page);

    // The page is reparented.

    compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);

    // Acquired the wrong lruvec lock and need to retry.

But compact_lock_irqsave() only take lruvec lock as the parameter,
we cannot aware this change. If it can take the page as parameter
to acquire the lruvec lock. When the page memcg is changed, we can
use the page_memcg() detect whether we need to reacquire the new
lruvec lock. So compact_lock_irqsave() is not suitable for us.
Similar to lock_page_lruvec_irqsave(), introduce
compact_lock_page_lruvec_irqsave() to acquire the lruvec lock in
the compaction routine.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/compaction.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 1c500e697c88..082293587cc6 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -511,6 +511,29 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
 	return true;
 }
 
+static struct lruvec *
+compact_lock_page_lruvec_irqsave(struct page *page, unsigned long *flags,
+				 struct compact_control *cc)
+{
+	struct lruvec *lruvec;
+
+	lruvec = mem_cgroup_page_lruvec(page);
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
+	lruvec_memcg_debug(lruvec, page);
+
+	return lruvec;
+}
+
 /*
  * Compaction requires the taking of some coarse locks that are potentially
  * very heavily contended. The lock should be periodically unlocked to avoid
@@ -1001,11 +1024,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			if (locked)
 				unlock_page_lruvec_irqrestore(locked, flags);
 
-			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
+			lruvec = compact_lock_page_lruvec_irqsave(page, &flags, cc);
 			locked = lruvec;
 
-			lruvec_memcg_debug(lruvec, page);
-
 			/* Try get exclusive access under lock */
 			if (!skip_updated) {
 				skip_updated = true;
-- 
2.11.0

