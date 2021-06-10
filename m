Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CEF3A24B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFJGrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:47:10 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]:37597 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJGrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:47:09 -0400
Received: by mail-qv1-f46.google.com with SMTP id x6so9267347qvx.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=akymlcTjak2aiLxju3nvGrvixCmoGtWlsFfmG/UDbtE=;
        b=MkEt15JmyYSAQ+RVuy42Ljti0kzjYxMG1NcV1cwy50nRl6vRoncOkzghyDe4se7H+c
         GK3oAdp+cr0pMytWAFXnCaZIP4PXXPmxt/GGtorivsAlQ9wr1WPTY9pb3okv4y0hwjWF
         f0ig6Dbf2GWBXHvC60iY2h+R1mWvaMi7U/s/zfiDez2w0O2cFGJPFrLauq2XgwlaEa1Z
         JmvhibYkqss7F/ZFx9im9UzrewbbehaLv92KMQFhWZ9noj0+mgW2LhK3ahjypVq7E/v6
         Drh9gSNvhsUL9EHI8CUMP13xFZiYfJNRf6yVODI6iBHsjEKBeRao0mE/LGsEJqoPyc9U
         9UYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=akymlcTjak2aiLxju3nvGrvixCmoGtWlsFfmG/UDbtE=;
        b=hbuNz1sCNC6B2GPraPvODQGn+tO7c15cDW0ZMvR0tk11zJU5svvRbHI4jvx7Oaa1n8
         LJMsTFUWRROfoqb2gd1dXndXSGA9KrMI2rdBRRAXeXTJsVtVTdCcSHPZk7GUMbJOOTFq
         bANli3uUxbAbO6bJAZDjp6lzvvxKp9/23mkDKUdDIFBTMcCMJow9rsqBsl5LYbp26nCP
         jPaIWPdYn4MPy1pQ0e15W8VrXmx88xO/8rE9VJduQnyYvIUneF1Ocd+tYtfLplOvFOZh
         5hTY06wToDAMVgycbfnX/EarxcfmiaYMkFO0TvWjlFpLxlSOn0LE0Kyve9AqDLcIqf8d
         Ji/Q==
X-Gm-Message-State: AOAM532UQhmToqa00LLn1fE7eXAiwwkVYJKLjeLl+7k+1NsGMCc9YC+n
        1UNFaLRv9SRZh2GgpaASmwHUHw==
X-Google-Smtp-Source: ABdhPJw+h+5g4qsaqPq9hBVqb+DYjhTLlr01z83/WwZH9CfNzJzW4AMFaeYoGQbJMjmA43tYbaijbg==
X-Received: by 2002:a05:6214:260b:: with SMTP id gu11mr3840211qvb.12.1623307453261;
        Wed, 09 Jun 2021 23:44:13 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p8sm1598335qkm.119.2021.06.09.23.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 23:44:12 -0700 (PDT)
Date:   Wed, 9 Jun 2021 23:44:10 -0700 (PDT)
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
Subject: [PATCH 06/11] mm: page_vma_mapped_walk(): crossing page table
 boundary
In-Reply-To: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
Message-ID: <799b3f9c-2a9e-dfef-5d89-26e9f76fd97@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_vma_mapped_walk() cleanup: adjust the test for crossing page table
boundary - I believe pvmw->address is always page-aligned, but nothing
else here assumed that; and remember to reset pvmw->pte to NULL after
unmapping the page table, though I never saw any bug from that.

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/page_vma_mapped.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index b96fae568bc2..0fe6e558d336 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -247,16 +247,16 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			if (pvmw->address >= end)
 				return not_found(pvmw);
 			/* Did we cross page table boundary? */
-			if (pvmw->address % PMD_SIZE == 0) {
-				pte_unmap(pvmw->pte);
+			if ((pvmw->address & (PMD_SIZE - PAGE_SIZE)) == 0) {
 				if (pvmw->ptl) {
 					spin_unlock(pvmw->ptl);
 					pvmw->ptl = NULL;
 				}
+				pte_unmap(pvmw->pte);
+				pvmw->pte = NULL;
 				goto restart;
-			} else {
-				pvmw->pte++;
 			}
+			pvmw->pte++;
 		} while (pte_none(*pvmw->pte));
 
 		if (!pvmw->ptl) {
-- 
2.26.2

