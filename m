Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E798A4467FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbhKERj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhKERj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:39:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20D8C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k10rHTgNy3CA4uDf3p2GKO7O+W924Sl48QPQrBA8jQ8=; b=mb6pw3Rlfmji8TZA8PKz8tQsFr
        qvzjM11nn0ipgbjX2j+4M5IhoS+X+9gM2ftGiKNURua//O725FK3Q9go3a6F8sguOThStfo6FzAVb
        XlXUfzYusW8wWlgdbrKe7C78GhSF+09tfWLwxHPcksQcHBoxfrgG6GJtu+ytj3cZUOz/WQ782kQub
        0uFNs+a1KaOWbAh/n9O9G5tafFJdnZntap0SXY+s0jKxYR17nVvnQww0OyMYPfDV7RRA/pJrSX4Jw
        CPz9h4zKp/0CpmYx+aoBscfDJuuZixo9fnxZ1tkn1JT1HJ8BOxdsC3ZCzXuPPV1aGM1muyYhBg73t
        WAkenlIg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj37a-006iJL-FG; Fri, 05 Nov 2021 17:35:40 +0000
Date:   Fri, 5 Nov 2021 17:35:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Prathu Baronia <prathubaronia2011@gmail.com>,
        linux-kernel@vger.kernel.org, chintan.pandya@oneplus.com,
        Prathu Baronia <prathu.baronia@oneplus.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 1/1] mm/highmem: Remove deprecated kmap_atomic
Message-ID: <YYVrWkLs8zrTs6r9@casper.infradead.org>
References: <20210204073255.20769-1-prathu.baronia@oneplus.com>
 <20210204073255.20769-2-prathu.baronia@oneplus.com>
 <20210211003307.GA3158182@iweiny-DESK2.sc.intel.com>
 <20210211155625.7f8dd5d53e19f88530ddf248@linux-foundation.org>
 <YYU2YSOGHJFIrzmm@casper.infradead.org>
 <20211105165616.GZ3538886@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105165616.GZ3538886@iweiny-DESK2.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 09:56:16AM -0700, Ira Weiny wrote:
> Also I wonder if memset_page could be used?  It would end up mapping the page
> 2x sometimes.

That was the point of this function existing, to avoid the
double-mapping.

> As an aside I think flush_dcache_page() needs to be in memset_page() for
> completeness but I'm a bit afraid of adding it with the current controversy...
> :-/

Looks like we now have agreement that it does need to be added, and I
agree with you; send a patch.

At some point, I'm probably going to need to foliate the mem*_page
helpers.  I've just added:

static inline void folio_zero_segments(struct folio *folio,
                size_t start1, size_t end1, size_t start2, size_t end2)
{
        zero_user_segments(&folio->page, start1, end1, start2, end2);
}

static inline void folio_zero_segment(struct folio *folio,
                size_t start, size_t end)
{
        zero_user_segments(&folio->page, start, end, 0, 0);
}

static inline void folio_zero_range(struct folio *folio,
                size_t start, size_t length)
{
        zero_user_segments(&folio->page, start, start + length, 0, 0);
}

but I imagine when we foliate btrfs, we'll need to expand the helpers.
I'll probably do something similar to zero_user_segments; have
out-of-line versions for HIGHMEM and inline versions for !HIGHMEM
(we can do the entire folio with HIGHMEM, but need to go page-by-page
on !HIGHMEM).
