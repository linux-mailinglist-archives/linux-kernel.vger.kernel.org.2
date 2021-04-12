Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAE735C277
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbhDLJo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239306AbhDLJUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:20:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E26EC06138C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LbLEaQQn1m2iX7nE7PPEHGSV/YwnfR4XbHyT4vIPCOo=; b=Y7cOtXpfBCuSpO+OG8inZmByp2
        uC4BQykiuxpyWwj9PEbqBrYmAomUef+mOvq9II+Bgwq1Wx4i9lqPwFP5iR1rQXCrraYmh+eDlZ4CT
        1Zhb2CFA6iX27CPaSKYYah/i6G3/iYOyevF+6LmNHtO4UY+7nqUwnKMHbwY/G3cXZNddMvKSh/rFU
        fmJXSb7O6QXojSUBpWgdKineQsozxBH+82N4Q5tYFD/qBX8rSSSJWTnaKalsYRWilBjglVWMVfkcR
        ywqTSgpLtVW5l2+baf/9yWnxmsIXNookZXXlEISRyNz6wkQ0irLAYcD3XvMUXzyeLoGChfhrG4gw4
        XZdoU4Vg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVshP-0044xV-Eb; Mon, 12 Apr 2021 09:17:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1D49D300033;
        Mon, 12 Apr 2021 11:17:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D543020224206; Mon, 12 Apr 2021 11:17:36 +0200 (CEST)
Date:   Mon, 12 Apr 2021 11:17:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        keescook@chromium.org
Subject: Re: [PATCH 4/7] mm: Introduce verify_page_range()
Message-ID: <YHQQMPvsO5LtuI+/@hirez.programming.kicks-ass.net>
References: <20210412080012.357146277@infradead.org>
 <20210412080611.769864829@infradead.org>
 <20210412082805.GD4372@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412082805.GD4372@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:28:05AM +0200, Christoph Hellwig wrote:
> On Mon, Apr 12, 2021 at 10:00:16AM +0200, Peter Zijlstra wrote:
> > +extern int verify_page_range(struct mm_struct *mm,
> 
> No need for the extern here.

It's consistent with the rest of the functions there. Also, I personally
like that extern.

> > +int verify_page_range(struct mm_struct *mm,
> > +		      unsigned long addr, unsigned long size,
> > +		      int (*fn)(pte_t pte, unsigned long addr, void *data),
> > +		      void *data)
> 
> A kerneldoc comment would be nice for this function.
> 
> Otherwise this looks fine.

Something like so?

/**
 * verify_page_range() - Scan (and fill) a range of virtual memory and validate PTEs
 * @mm: mm identifying the virtual memory map
 * @addr: starting virtual address of the range
 * @size: size of the range
 * @fn: function that verifies the PTEs
 * @data: opaque data passed to @fn
 *
 * Scan a region of virtual memory, filling in page tables as necessary and
 * calling a provided function on each leaf, providing a copy of the
 * page-table-entry.
 *
 * Similar apply_to_page_range(), but does not provide direct access to the
 * page-tables.
 *
 * NOTE! this function does not work correctly vs large pages.
 *
 * Return: the first !0 return of the provided function, or 0 on completion.
 */
int verify_page_range(struct mm_struct *mm,
		      unsigned long addr, unsigned long size,
		      int (*fn)(pte_t pte, unsigned long addr, void *data),
		      void *data)
