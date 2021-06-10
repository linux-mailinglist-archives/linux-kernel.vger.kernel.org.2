Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06543A24B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhFJGub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJGu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:50:29 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEA4C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 23:48:33 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id v6so11236728qta.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=XjbJY3bhcvz+MAqs2y5uU2ExaAj/cTy23+6+m0vOS/c=;
        b=I2WARsLE20TkLuIVtRJfaR8NkDW8Mh5SgTQetC6Ey2uz8oIN+hK8GOKLV//ylUEunK
         UYegTMLZhwgLPDXrCDGfFt3fJ7kfM3u3u0mdeqh/W+ap9iybINc16XhxcA0IMt+pSPwm
         xAV56qp/7PhWmC+inxJFChXmiH6CQWjftP6luik04P2FnKSrMCrer6qIhA+VDMa+ZKJp
         HOAORdh7B5Aw12YZSxAP0b1XFbjWG0fGB37ywSBa5Ct9uB1C3gy3866G3HG1nxRyGIsh
         ukbE+hvq6jmARKs34+kHlujPcAsY2C5dTNGMgbsQe0ZrPK0+gqF/sqB6f2uhiS36Aw+v
         jAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=XjbJY3bhcvz+MAqs2y5uU2ExaAj/cTy23+6+m0vOS/c=;
        b=tC6TnebT6sndSjwzgdYdNvKLgm28irlAam3LuAYcuszoORMAO/pgaRskmQucoTc7rE
         1dmOGUCCs94HU9FQkIYp8fY6BSwDRbIc3BRuq4hO7MQMdrZjAr3ZzWknCnZD55y4we9S
         WcfNbO7VNQISyGJcWQ8kJIySHpnz3R32q3zgdcpfZ3GbPAl/xUK262iIM9a700/ftspA
         0/gm1bEzKZV5o3zAre9Gk3IFtA+4GkwqRkQ6AzU4buGOa2SE/qkczDcswGC0R1k5Scm8
         5HE8H+iZwU6lSMzwg6XgvgN5s9sRhadSjWwDToXFAN2BnjHRpBrE1F3hIb47AiaDLC0p
         /Zmg==
X-Gm-Message-State: AOAM5319rNajzB0k4q1BeKH6nWqNeDcjK7JuoycLzXFl+M8csCNOLweb
        do5tnSbxNNS5aSRC0c5N7HcJOg==
X-Google-Smtp-Source: ABdhPJyrJW/zsSc4BAg8bOs1VCqXKeTl38AuBEzX0YuNIvPHH3vnd5WTuOWVltVf8BYzC10bBAVy5g==
X-Received: by 2002:ac8:4f42:: with SMTP id i2mr96547qtw.350.1623307709464;
        Wed, 09 Jun 2021 23:48:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g15sm1723464qkl.53.2021.06.09.23.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 23:48:29 -0700 (PDT)
Date:   Wed, 9 Jun 2021 23:48:27 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] mm: page_vma_mapped_walk(): use goto instead of while
 (1)
In-Reply-To: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
Message-ID: <a52b234a-851-3616-2525-f42736e8934@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_vma_mapped_walk() cleanup: add a label this_pte, matching next_pte,
and use "goto this_pte", in place of the "while (1)" loop at the end.

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/page_vma_mapped.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 0840079ef7d2..006f4814abbc 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -144,6 +144,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 {
 	struct mm_struct *mm = pvmw->vma->vm_mm;
 	struct page *page = pvmw->page;
+	unsigned long end;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
@@ -234,10 +235,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		}
 		if (!map_pte(pvmw))
 			goto next_pte;
-	}
-	while (1) {
-		unsigned long end;
-
+this_pte:
 		if (check_pte(pvmw))
 			return true;
 next_pte:
@@ -266,6 +264,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			pvmw->ptl = pte_lockptr(mm, pvmw->pmd);
 			spin_lock(pvmw->ptl);
 		}
+		goto this_pte;
 	}
 }
 
-- 
2.26.2

