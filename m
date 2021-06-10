Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E133A24AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhFJGpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:45:32 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]:36839 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhFJGp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:45:28 -0400
Received: by mail-qk1-f173.google.com with SMTP id i68so22726152qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=BF7gYv4bUzMzXTGdnVKsNQ49KcCRY8OjCfC9I0iFikc=;
        b=GK3lO1UZgj0viQsuAlknaSC++U0LASLzlwmP3Ygwbb0R9vdkntk33kVgOb7rxaj4mv
         yxELPE7Wjnfn5+KYoCameACweq3+yaeqsgFT02R4Enrx84iAhpVMmP9vYxfrkrQl+Kng
         uxPGPPZQY5yq4sqOdyU8EhRoY8yxvHKoWeg9g0uZxHFxVolQ6WQnJI/bjtzolnTrCdUM
         1wVj2lTu50F52DoY7yru/rfi+5TOyctn1dnsEZeLWvRdVpMJknSFUXsKHSmQ1lx/3Yv3
         ENPncba//NbOxmU6ZHEO65cr0hMI9dEqQrNvqtd6/uNamY9ozwlilcN9U39yjjxwV6AD
         PF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=BF7gYv4bUzMzXTGdnVKsNQ49KcCRY8OjCfC9I0iFikc=;
        b=mRXLp+W2jGhbomK0DLt1ZZ1Bmu9sP4zQvNXJ1fFzmR1B64KWRQ/aTYnfxmVQ7cL3sv
         CWWpQ4mTza8Z12ktwSN41TLttX9NwcbMCnK5S11bCytt3jPrAat+6RTRSABBouKZ79IA
         b1D46E1uLOFGxElQt85dr+CrAQ0TKLpZmSSxLyXk7+nes6olr6v06GinmwkM6BI3rfHg
         V8QNHFdq4CL/h2ctFGk0KizL7hgYpI5zGmUvi4NAhMgNuTQ4UZcXmlnvXe61LfRj82aV
         /D5nV9IZFN6lusS3+m4d7MgI5cLPuw43BoWI8XEah/UnLBTQz4VTOu6kl85sVfl+qizs
         BW0w==
X-Gm-Message-State: AOAM5303SaDqEhaBs0I0D1wtNbyn3EgeolMVHVmPyWsXKEiX/TnKLp3V
        q+TkO9XocJDfqeYgWpwZWfzadg==
X-Google-Smtp-Source: ABdhPJyXu+PktDehHYGHVmTT0YocIN/sxyUPwE+UTTh86S5eE20bKBx41KVp+5SfZNFFJyhSi8avtw==
X-Received: by 2002:a37:a107:: with SMTP id k7mr3267352qke.362.1623307335910;
        Wed, 09 Jun 2021 23:42:15 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m14sm1671302qti.12.2021.06.09.23.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 23:42:15 -0700 (PDT)
Date:   Wed, 9 Jun 2021 23:42:12 -0700 (PDT)
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
Subject: [PATCH 05/11] mm: page_vma_mapped_walk(): prettify PVMW_MIGRATION
 block
In-Reply-To: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
Message-ID: <378c8650-1488-2edf-9647-32a53cf2e21@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_vma_mapped_walk() cleanup: rearrange the !pmd_present() block to
follow the same "return not_found, return not_found, return true" pattern
as the block above it (note: returning not_found there is never premature,
since existence or prior existence of huge pmd guarantees good alignment).

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/page_vma_mapped.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 81000dd0b5da..b96fae568bc2 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -201,24 +201,22 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			if (pmd_page(pmde) != page)
 				return not_found(pvmw);
 			return true;
-		} else if (!pmd_present(pmde)) {
-			if (thp_migration_supported()) {
-				if (!(pvmw->flags & PVMW_MIGRATION))
-					return not_found(pvmw);
-				if (is_migration_entry(pmd_to_swp_entry(pmde))) {
-					swp_entry_t entry = pmd_to_swp_entry(pmde);
+		}
+		if (!pmd_present(pmde)) {
+			swp_entry_t entry;
 
-					if (migration_entry_to_page(entry) != page)
-						return not_found(pvmw);
-					return true;
-				}
-			}
-			return not_found(pvmw);
-		} else {
-			/* THP pmd was split under us: handle on pte level */
-			spin_unlock(pvmw->ptl);
-			pvmw->ptl = NULL;
+			if (!thp_migration_supported() ||
+			    !(pvmw->flags & PVMW_MIGRATION))
+				return not_found(pvmw);
+			entry = pmd_to_swp_entry(pmde);
+			if (!is_migration_entry(entry) ||
+			    migration_entry_to_page(entry) != page)
+				return not_found(pvmw);
+			return true;
 		}
+		/* THP pmd was split under us: handle on pte level */
+		spin_unlock(pvmw->ptl);
+		pvmw->ptl = NULL;
 	} else if (!pmd_present(pmde)) {
 		/*
 		 * If PVMW_SYNC, take and drop THP pmd lock so that we
-- 
2.26.2

