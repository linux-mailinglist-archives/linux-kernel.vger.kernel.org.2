Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF173946F5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhE1SYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhE1SYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:24:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6710C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 11:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gNnTtNhYhsjLZyYSFhpISMIVt3cv2qaTo4HNXcWiEEk=; b=tSJVz2PFgt3iU+MzA4FHLI2H2K
        V8mLCpYUNOH9K3/3Kipce59E3aKijW984GYpCkjg96TS4wOm942DGDlcPIYfGMDK1tMNjYtvCN21j
        MSle5FrCI15iMnVMNVLcH88cOmSBWQXXh8qrCJ99e3Enyt6usVtPLjwbXCnouJAG/qXBJkf4HPZrt
        ZawOO+LctRF4IOkGX33pev+9o2bjMn9SfLUheplgs0b8LcH5jhLyXOTY0PkR/dNgpAxbJzWxqAWGJ
        dWxfjsc5wIlEWJ3XDD9Epj8ESdVpG747XVHe+6KAczst2+Yh+y7X1JJdL+tvlIiClrCQG8r8TzavZ
        oVtDGjRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lmh7a-006tAY-7K; Fri, 28 May 2021 18:22:12 +0000
Date:   Fri, 28 May 2021 19:22:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     hughd@google.com, jhubbard@nvidia.com,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: dump_page: print total mapcount for compound page
Message-ID: <YLE00rVi6O3DF3XA@casper.infradead.org>
References: <20210528175403.4506-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528175403.4506-1-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 10:54:03AM -0700, Yang Shi wrote:
> So I prepared this patch to show a possible approach to get some
> feedback.  The same thing could be decoded by the reader of page dump
> as well by using the same formula used by this patch.  However it sounds
> more convenient to have kernel do the math.

You haven't taken enough things into consideration ...

> +	bool is_slab = PageSlab(head);

We should probably have a separate dump_slab_page().  Almost nothing
in __dump_page() is really useful for slab pages (eg, mapping, index,
mapcount, compound_mapcount, compound_pincount, aops), and the flags
(such as are used) have different meanings.

> +		nr = compound_nr(head);
> +		if (is_slab)
> +			total_mapcount = 0;
> +		else if (PageHuge(head))
> +			total_mapcount = comp_mapcnt;
> +		else {
> +			if (mapping) {
> +				if (!PageAnon(head))
> +					nr = nr * (comp_mapcnt + 1) - comp_mapcnt;
> +			} else
> +				nr = 0;
> +			total_mapcount = refcount - pincount - nr;

I see what you're trying to do here, but there are so many other things
which take a refcount on a page.  The LRU, the page cache, private fs
data, random temporary "gets" (eg, buffered reads, buffered writes,
get_user_pages(), readahead, truncate, migration).  I think this is
likely to be so inaccurate as to be confusing.

I had to think hard about it though.  I like what you're trying to do,
I just don't think it works ;-(
