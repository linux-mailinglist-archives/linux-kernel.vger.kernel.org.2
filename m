Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56CC3165A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhBJLt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:49:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:32882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhBJLpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:45:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2512464E2A;
        Wed, 10 Feb 2021 11:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612957494;
        bh=7TkHMquWewApmsNtom3Sk5kqBfrt9Txj5xLN/pBrQbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DL62wACXYBcjnG+VbxBoQ4TYtFlxHK8gFj0AxepZjo6k1qqDqCpBL9Y6A0SgOCgXF
         PNIrogaCWaCeEUIZCmh62iBX0N/x4R8rrXqFBUvBf5QwDCi5aSNHxQJJ8KzteVPR4L
         jMMhqfzhPDf9dRrRi9DzsOrFnUn1i7Z3WmuFhNfUrO+N2mcRC5T3paGOCIWP3rajLt
         +i+fPsbpHP4P+jNSrpnof2o+WFq1tgN2Nc0ALIG+ZwHzxZCkD+Tckx/k09YvnerwJC
         GxPr7xqtz4iAyOV0qSZdbtR7qZutK2JXNmFv1tRdDs3oKeNdaVTnm9bF8saT3H+Sol
         o3Mk1/eEziGlA==
Date:   Wed, 10 Feb 2021 11:44:48 +0000
From:   Will Deacon <will@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>, kernel-team@android.com
Subject: Re: [PATCH v3 1/8] mm: Cleanup faultaround and finish_fault()
 codepaths
Message-ID: <20210210114448.GA28682@willie-the-truck>
References: <20210114175934.13070-1-will@kernel.org>
 <20210114175934.13070-2-will@kernel.org>
 <20210209202449.GA104837@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209202449.GA104837@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 12:24:49PM -0800, Guenter Roeck wrote:
> On Thu, Jan 14, 2021 at 05:59:27PM +0000, Will Deacon wrote:
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > 
> > alloc_set_pte() has two users with different requirements: in the
> > faultaround code, it called from an atomic context and PTE page table
> > has to be preallocated. finish_fault() can sleep and allocate page table
> > as needed.
> > 
> > PTL locking rules are also strange, hard to follow and overkill for
> > finish_fault().
> > 
> > Let's untangle the mess. alloc_set_pte() has gone now. All locking is
> > explicit.
> > 
> > The price is some code duplication to handle huge pages in faultaround
> > path, but it should be fine, having overall improvement in readability.
> > 
> > Link: https://lore.kernel.org/r/20201229132819.najtavneutnf7ajp@box
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > [will: s/from from/from/ in comment; spotted by willy]
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  fs/xfs/xfs_file.c       |   6 +-
> >  include/linux/mm.h      |  12 ++-
> >  include/linux/pgtable.h |  11 +++
> >  mm/filemap.c            | 177 ++++++++++++++++++++++++++---------
> >  mm/memory.c             | 199 ++++++++++++----------------------------
> >  5 files changed, 213 insertions(+), 192 deletions(-)
> > 
> 
> When building microblaze:mmu_defconfig:
> 
> mm/filemap.c: In function 'filemap_map_pages':
> mm/filemap.c:3153:3: error: implicit declaration of function 'update_mmu_cache'; did you mean 'update_mmu_tlb'?
> 
> Bisect log attached.

Looks like a missing include.

Will

--->8

From 076f93117c067d5b6caab4773c6d6da130859cc4 Mon Sep 17 00:00:00 2001
From: Will Deacon <will@kernel.org>
Date: Wed, 10 Feb 2021 11:15:11 +0000
Subject: [PATCH] mm: filemap: Fix microblaze build failure with
 'mmu_defconfig'

Commit f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault()
codepaths") added a call to 'update_mmu_cache()' in mm/filemap.c, which
breaks the build for microblaze:

  | mm/filemap.c: In function 'filemap_map_pages':
  | mm/filemap.c:3153:3: error: implicit declaration of function 'update_mmu_cache'; did you mean 'update_mmu_tlb'?

Include asm/tlbflush.h in mm/filemap.c to make sure that the function
(or indeed, macro) is available.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20210209202449.GA104837@roeck-us.net
Signed-off-by: Will Deacon <will@kernel.org>
---
 mm/filemap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index fb7a8d9b5603..2ca13227747b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -43,6 +43,7 @@
 #include <linux/ramfs.h>
 #include <linux/page_idle.h>
 #include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
-- 
2.30.0.478.g8a0d178c01-goog

