Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175E23FBA04
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbhH3QTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237773AbhH3QTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:19:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B5EC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OyHQehmuanM4OzdDq4FC98poxLZdCC+ppDA2dlDQPmU=; b=Qlk9uaAEQcoBsCdrDO8xYqIIDy
        QTZA6cFLVPrVGD3bqBbE3e81GJ/Y/M/rZlAGS27AR4Az3amvei8bmrGyY/NCsbFSygcNUD+tBOHEm
        CXRDW1E9U9uhALvsELQZPTrb2iyW2VEwnZrM1L8WpM36fSLromLVPj7dNgqBhsf7LYXsaCb3GV0ou
        cXTJ2k4LBTAhjVmZ1GImMSg1KkUqCTq/yFBXzdXCZL14epaE1pT5OudkHnJfK/tz/QwPxSIxEDJjg
        Ss8bUPevZxg+mLoWgI4yHWthS3Xqjg7SkyH/Z1MzUh+bjZf0sez5grJvoFKnA7hQZ9RjbPColMLM4
        NQt64ImQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKjyl-000JiA-Mt; Mon, 30 Aug 2021 16:17:52 +0000
Date:   Mon, 30 Aug 2021 17:17:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mikko Rantalainen <mikko.rantalainen@peda.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Why is Shmem included in Cached in /proc/meminfo?
Message-ID: <YS0Eq+tNe4Pr7O0X@casper.infradead.org>
References: <5a42eb2b-fd7b-6296-f5d6-619661ad1418@peda.net>
 <0d11f620-0562-e150-259d-85de8d10cd7a@infradead.org>
 <YSzuLbHr7fHshafX@casper.infradead.org>
 <14465cfe-281a-0f67-dc17-ead34ec48365@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14465cfe-281a-0f67-dc17-ead34ec48365@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 06:05:58PM +0200, Vlastimil Babka wrote:
> On 8/30/21 16:41, Matthew Wilcox wrote:
> > On Mon, Aug 30, 2021 at 07:34:38AM -0700, Randy Dunlap wrote:
> >> [add linux-mm mailing list]
> >> 
> >> On 8/30/21 12:44 AM, Mikko Rantalainen wrote:
> >> > It's not immediately obvious from fs/proc/meminfo.c function
> >> > meminfo_proc_show() but the output of Cached: field seems to always
> >> > include all of Shmem: field, too.
> >> > 
> >> > Is this intentional? Usually cache is something that can be discarded if
> >> > needed but shared memory (e.g. used to contain files in tmpfs) cannot be
> >> > discarded without a data-loss. As such, I'd argue that it shouldn't be
> >> > included in the Cached: output.
> > 
> > That's a reasonable position to take.
> > 
> > Another point of view is that everything in tmpfs is part of the page
> > cache and can be written out to swap, so keeping it as part of Cached
> > is not misleading.
> 
> Yeah, but with that view, anonymous memory can be also written out to swap. But
> it's non-intuitive that something called "Cached" will contain something that
> (if not dirty) can't be just dropped.

That's equally true for normal filesystems & shmem though.  Consider shmem
written to swap, then brought back in by a read.  Now it can be dropped
without being swapped out.  Or even a file on shmem ftruncated to a
large size, then only read.  The pages will be clean and full of zeroes.
They can be dropped under memory pressure without being written out.

> I've had to point this Shmem oddity out a
> number of times to someone, so I would say that it would be much better if it
> was not part of Cached.
> However, if we change it now, we might create even larger confusion. People
> looking at the output for the first time (and IIRC also the 'free' command uses
> it) on a new kernel wouldn't be misled anymore. But people working with both old
> and new kernels will now have to take in account that it changed at some
> point... not good.

Another good point.
