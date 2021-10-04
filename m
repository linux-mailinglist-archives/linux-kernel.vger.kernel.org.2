Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC354207E7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 11:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhJDJM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:12:29 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:47119 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229716AbhJDJM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:12:28 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 8E0BABEB37
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 10:10:38 +0100 (IST)
Received: (qmail 3870 invoked from network); 4 Oct 2021 09:10:38 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Oct 2021 09:10:38 -0000
Date:   Mon, 4 Oct 2021 10:10:37 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm: Optimise put_pages_list()
Message-ID: <20211004091037.GM3959@techsingularity.net>
References: <20210930163258.3114404-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210930163258.3114404-1-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 05:32:58PM +0100, Matthew Wilcox (Oracle) wrote:
> Instead of calling put_page() one page at a time, pop pages off
> the list if there are other refcounts and pass the remainder
> to free_unref_page_list().  This should be a speed improvement,
> but I have no measurements to support that.  It's also not very
> widely used today, so I can't say I've really tested it.  I'm only
> bothering with this patch because I'd like the IOMMU code to use it
> https://lore.kernel.org/lkml/20210930162043.3111119-1-willy@infradead.org/
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I see your motivation but you need to check that all users of
put_pages_list (current and future) handle destroy_compound_page properly
or handle it within put_pages_list. For example, the release_pages()
user of free_unref_page_list calls __put_compound_page directly before
freeing. put_pages_list as it stands will call dstroy_compound_page but
free_unref_page_list does not destroy compound pages in free_pages_prepare

-- 
Mel Gorman
SUSE Labs
