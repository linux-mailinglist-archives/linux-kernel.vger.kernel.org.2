Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8249042AB77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhJLSEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbhJLSEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:04:04 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571C9C061753
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:02:00 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q125so20166883qkd.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=II+k1bERRgejUzmo9A3RKta99347TW8VHEIFP/mwtwE=;
        b=QcbIN7EkYNq6duRE+TluPBPUoFAfrstVRWNKeU8/xHunVY2sJpjcRkudHjbdT+pyxS
         ZwzDNYTsoPYxsAZKWf79iepWQUvL9lR67DdpvvuoL9wTvqiBwXyskfCNRk6Z0+q7LAN3
         RyM1ovet4u4Jd8bv7NVZKmZxR+qHPGVX6D2UTrgu09vkY/wFfVkssEPY7HHBd5FCRWne
         EbRu9qvRCOHdtbB9Z+YefmyMxM7GZbsGjRXM3MmDmZnYg+XYYMx4gqAJJyIGRS1J/ZBL
         B5WSIa+SMX52bUfI36yPJji10ZAZxvpGpOuSGyI2i7BQ768SJ1mX8+aifvQRoBNcPHf0
         giGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=II+k1bERRgejUzmo9A3RKta99347TW8VHEIFP/mwtwE=;
        b=61VFb8v8zLW1oKkeDFvnk1jp2c4UfOxulpf6mr0VjaD5dbmZiaOz+Me8U//eAHONq+
         RrtSvuXuPRGnooR/mTpF6oHpBg7/KuyjvRX4FuD+IEw5IXEiZIFZVF80iM9wPCFUw2eI
         PiHIjTdqH1u7DMTQGuqphCen2oxrBjmk0UjtpnWO6fI15ZpJ4Zh0lNT+EDXJx8vq9U3A
         F0bvxVfXq0cH8S/aId6y/5w80lOJcNZrSEHTji2srSAN0RruPB9IFwzgIF+/iWP8QTn3
         JSwerdb4tLlwRNpWeSc6dmiOd1+/Wp9+bvcw+JMcLGCGFq6YWtqXi8S1bWo6pQ21Zz4C
         hg3A==
X-Gm-Message-State: AOAM533ixfTrOK4EXykofg65Z8EYpqUuUZ1peW1R8N4bTaepaDpcR7cO
        S0aScYGN9MNce31IJompeiSZTBgoAE43YQ==
X-Google-Smtp-Source: ABdhPJxtS3LWPGdPrw8j47cnxN2+xJsYFJyJ6FYuzADbfbBoVrm6CrU69C5MuqoTyUGlQPtBghN5Hw==
X-Received: by 2002:a37:4593:: with SMTP id s141mr20569385qka.368.1634061719532;
        Tue, 12 Oct 2021 11:01:59 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id b8sm1927583qtr.82.2021.10.12.11.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:01:59 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/11] PageSlab: eliminate unnecessary compound_head() calls in mm/slab_common
Date:   Tue, 12 Oct 2021 14:01:45 -0400
Message-Id: <20211012180148.1669685-9-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012180148.1669685-1-hannes@cmpxchg.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virt_to_head_page() implies it.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/slab.h        | 3 +--
 mm/slab_common.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 0446948c9c4e..4bcaa08320e6 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -410,8 +410,7 @@ static inline struct kmem_cache *virt_to_cache(const void *obj)
 	struct page *page;
 
 	page = virt_to_head_page(obj);
-	if (WARN_ONCE(!PageSlab(compound_head(page)),
-		      "%s: Object is not a Slab page!\n",
+	if (WARN_ONCE(!PageSlab(page), "%s: Object is not a Slab page!\n",
 		      __func__))
 		return NULL;
 	return page->slab_cache;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 5f7063797f0e..ec2bb0beed75 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -564,7 +564,7 @@ bool kmem_valid_obj(void *object)
 	if (object < (void *)PAGE_SIZE || !virt_addr_valid(object))
 		return false;
 	page = virt_to_head_page(object);
-	return PageSlab(compound_head(page));
+	return PageSlab(page);
 }
 EXPORT_SYMBOL_GPL(kmem_valid_obj);
 
@@ -594,7 +594,7 @@ void kmem_dump_obj(void *object)
 	if (WARN_ON_ONCE(!virt_addr_valid(object)))
 		return;
 	page = virt_to_head_page(object);
-	if (WARN_ON_ONCE(!PageSlab(compound_head(page)))) {
+	if (WARN_ON_ONCE(!PageSlab(page))) {
 		pr_cont(" non-slab memory.\n");
 		return;
 	}
-- 
2.32.0

