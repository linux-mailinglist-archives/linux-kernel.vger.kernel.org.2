Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE40C3A249D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFJGnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:43:07 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:38801 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJGnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:43:06 -0400
Received: by mail-qk1-f169.google.com with SMTP id c138so13427906qkg.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=kXGE7AZWMRkQI2D2fv4mdt0RT7InHtOBXYXrcKUASZQ=;
        b=pTtcgnuHkfB+ZWeRrnJcb4kua/2i5mFlvyyK1oUUKP3IwMOaFUBnHVR9givA9IegE8
         PsdB/++dX/+OMuBz4wPTjhABOSluN+50HARmKc3x+/6ml6z6v37WHyEnwfWIRWiVfBd8
         0W7z2Quygw8xMioTE864MUQdheJ1VMEWk+iiEBOKwF5S1yr+NTTVWzs6+Xr0wzUyvGji
         OB8b5UecOci6aX3c/2UupL8jk6+KmwDXJUnIXtGnmUv0CNuMawdEbWTKR3+6WCFlYAiq
         u1zMHesyCTki6CpLiOnqP5+qDgsiBH3IFHJi/8Y1iPixSIKZ4cNbkatGORXJEW0okFlD
         M4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=kXGE7AZWMRkQI2D2fv4mdt0RT7InHtOBXYXrcKUASZQ=;
        b=LrSyqMh2f4w15LQiWp/sQVz20LC/J+gqMYRXRcKosterRYtCQLNaYOqy6toS8UluAT
         U5Sk6ni1omcvs3lChxJLW7wUSq2Oj+mNr/EuqeDZCn/O9ykDyDMx9MqS64qPYy4v182R
         fdiSUTbXhXm2Ebx9hhujyZGeb25rBGVwFswnjUCuGAfK27RvJ3x+UpHoYKnesI7hHYKK
         7H49+i2SSxP3XCz0fJ9GiHXZZcN+ekWikxT/xvygZTYNL/wrd2VhW5qtpn8qXPHwLSCL
         /jtqZw0gerIQmgsMmoCcg+7Bw5WDIfZeXHkmDKCL9MmPWov/08kMIg8CojKnhtEOWEBi
         yqBQ==
X-Gm-Message-State: AOAM532155YCAqbhSBwEn7wVUGmQPF7MzDCbEW2qt5OrvctDQ0Y134LL
        PuGtPDEnPgAFcPh6v8jp8X2p8w==
X-Google-Smtp-Source: ABdhPJxlHE0YxyFCF53h4uqHehxwG7bqDEAol3I+xWrbbx4f0ummmIi1JMXE/u++r1xFunWK7pFJ7Q==
X-Received: by 2002:a05:620a:147a:: with SMTP id j26mr3322349qkl.138.1623307210706;
        Wed, 09 Jun 2021 23:40:10 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a68sm1632172qkd.51.2021.06.09.23.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 23:40:10 -0700 (PDT)
Date:   Wed, 9 Jun 2021 23:40:08 -0700 (PDT)
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
Subject: [PATCH 04/11] mm: page_vma_mapped_walk(): use pmde for *pvmw->pmd
In-Reply-To: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
Message-ID: <53fbc9d-891e-46b2-cb4b-468c3b19238e@google.com>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_vma_mapped_walk() cleanup: re-evaluate pmde after taking lock, then
use it in subsequent tests, instead of repeatedly dereferencing pointer.

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/page_vma_mapped.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 973c3c4e72cc..81000dd0b5da 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -194,18 +194,19 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 
 	if (pmd_trans_huge(pmde) || is_pmd_migration_entry(pmde)) {
 		pvmw->ptl = pmd_lock(mm, pvmw->pmd);
-		if (likely(pmd_trans_huge(*pvmw->pmd))) {
+		pmde = *pvmw->pmd;
+		if (likely(pmd_trans_huge(pmde))) {
 			if (pvmw->flags & PVMW_MIGRATION)
 				return not_found(pvmw);
-			if (pmd_page(*pvmw->pmd) != page)
+			if (pmd_page(pmde) != page)
 				return not_found(pvmw);
 			return true;
-		} else if (!pmd_present(*pvmw->pmd)) {
+		} else if (!pmd_present(pmde)) {
 			if (thp_migration_supported()) {
 				if (!(pvmw->flags & PVMW_MIGRATION))
 					return not_found(pvmw);
-				if (is_migration_entry(pmd_to_swp_entry(*pvmw->pmd))) {
-					swp_entry_t entry = pmd_to_swp_entry(*pvmw->pmd);
+				if (is_migration_entry(pmd_to_swp_entry(pmde))) {
+					swp_entry_t entry = pmd_to_swp_entry(pmde);
 
 					if (migration_entry_to_page(entry) != page)
 						return not_found(pvmw);
-- 
2.26.2

