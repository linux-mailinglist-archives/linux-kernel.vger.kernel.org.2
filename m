Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A49B3E36D4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 20:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhHGSqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 14:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhHGSqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 14:46:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82D0E6105A;
        Sat,  7 Aug 2021 18:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1628361946;
        bh=63Jc6H88mizk3nUpvFQNU59wRQKIju43S/xVoUsb28w=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=ZWbhHPbYrBKKHHFzhGRwXYCeGqFdPaIIKIrm9PmOPVIqDUA/RVrG8O/yz83O6F3KD
         QRrxUlQBmg/CXG6xr3202Tv/cNOVgHOIIfdCOCvD+4dXrEXHGhp+8Pk1jO0kra1SVh
         I2gTaRiKRkukwEy0BUnEDBYVxjkmEj8f3oplpCvU=
Date:   Sat, 7 Aug 2021 11:45:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>, <imbrenda@linux.ibm.com>,
        <kirill.shutemov@linux.intel.com>, <jack@suse.cz>,
        <jhubbard@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] mm: gup: fix potential pgmap refcnt leak in
 __gup_device_huge()
Message-Id: <20210807114545.eaee318909a9215c4e056aa3@linux-foundation.org>
In-Reply-To: <20210807114112.6e45b31c65dd62169fee8718@linux-foundation.org>
References: <20210807093620.21347-1-linmiaohe@huawei.com>
        <20210807093620.21347-5-linmiaohe@huawei.com>
        <20210807114112.6e45b31c65dd62169fee8718@linux-foundation.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Aug 2021 11:41:12 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> We can simplify further, and remove the troublesome multiple return points?
> 

oops.

--- a/mm/gup.c~mm-gup-fix-potential-pgmap-refcnt-leak-in-__gup_device_huge-fix-fix
+++ a/mm/gup.c
@@ -2240,6 +2240,7 @@ static int __gup_device_huge(unsigned lo
 {
 	int nr_start = *nr;
 	struct dev_pagemap *pgmap = NULL;
+	int ret = 1;
 
 	do {
 		struct page *page = pfn_to_page(pfn);
@@ -2247,12 +2248,14 @@ static int __gup_device_huge(unsigned lo
 		pgmap = get_dev_pagemap(pfn, pgmap);
 		if (unlikely(!pgmap)) {
 			undo_dev_pagemap(nr, nr_start, flags, pages);
+			ret = 0;
 			break;
 		}
 		SetPageReferenced(page);
 		pages[*nr] = page;
 		if (unlikely(!try_grab_page(page, flags))) {
 			undo_dev_pagemap(nr, nr_start, flags, pages);
+			ret = 0;
 			break;
 		}
 		(*nr)++;
@@ -2260,7 +2263,7 @@ static int __gup_device_huge(unsigned lo
 	} while (addr += PAGE_SIZE, addr != end);
 
 	put_dev_pagemap(pgmap);
-	return 1;
+	return ret;
 }
 
 static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,

Not sure if it's worth bothering, really...
