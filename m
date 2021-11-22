Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCF14588AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 05:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhKVE7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 23:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhKVE7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 23:59:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D47C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 20:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2aCQpVDlbYWsNB09YHVxAuw9fyHTyZh0tb1unY+8gTY=; b=IKxhl0e7JezN6sCtME5ISB8xjq
        Lpu74sETuf4Ogz2z5L/1c+Pd+wudeSTFDVQ8+LJNHx7K4N8QudQWunKWpzQIgvwBydtPD55RCpTnn
        v/D0s5IbNx1x+uzOk2gyspiINa6l7vKVMe1i/22enAeLdIZXmURiCM09zFIObo4v8FczPftK/S1Jw
        9oBqhqLE2Kp70p7Unl6BhBqR8YWT7KsMmuG76IQKr3rNOK6NnPBeeW9rU2hkW6xJoY2oOlRSmW4q4
        aLqRyYMC6vkxmcvbg9/7YusTGBslg06mvdnaDQcubvWJ86LwvNIFY4eYpXoaFXsW1sSLz5fyzH+vd
        pdHSaDdw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mp1NR-00CZRG-My; Mon, 22 Nov 2021 04:56:25 +0000
Date:   Mon, 22 Nov 2021 04:56:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
Message-ID: <YZsi+RFed3hX9T8w@casper.infradead.org>
References: <20211120201230.920082-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120201230.920082-1-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 12:12:30PM -0800, Shakeel Butt wrote:
> Many applications do sophisticated management of their heap memory for
> better performance but with low cost. We have a bunch of such
> applications running on our production and examples include caching and
> data storage services. These applications keep their hot data on the
> THPs for better performance and release the cold data through
> MADV_DONTNEED to keep the memory cost low.
> 
> The kernel defers the split and release of THPs until there is memory
> pressure. This causes complicates the memory management of these
> sophisticated applications which then needs to look into low level
> kernel handling of THPs to better gauge their headroom for expansion. In
> addition these applications are very latency sensitive and would prefer
> to not face memory reclaim due to non-deterministic nature of reclaim.
> 
> This patch let such applications not worry about the low level handling
> of THPs in the kernel and splits the THPs synchronously on
> MADV_DONTNEED.

I've been wondering about whether this is really the right strategy
(and this goes wider than just this one, new case)

We chose to use a 2MB page here, based on whatever heuristics are
currently in play.  Now userspace is telling us we were wrong and should
have used smaller pages.  2MB pages are precious, and we currently
have one.  Surely it is better to migrate the still-valid contents of
this 2MB page to smaller pages, and then free the 2MB page as a single
unit than it is to fragment this 2MB page into smaller chunks, and keep
using some of it, virtually guaranteeing this particular 2MB page can't
be reassembled without significant work?
