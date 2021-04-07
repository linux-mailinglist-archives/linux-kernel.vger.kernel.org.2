Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C0D35616B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 04:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348110AbhDGCgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 22:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbhDGCgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 22:36:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431E2C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 19:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v2HTiDurUhaFtku9x3Aod8jwLxk/iaIfkceEVuQR2iU=; b=u3XibzCpDyGFKLZZNeLqPUf+Yj
        K2MaxDOG6QRHihh3SvSIpyISf/sC7iSz/PFCCgXiggJUG+/8yYEC1IU9v7T40IHII6ul12Yo7Lauh
        LlmUiLOhspkllYcGx1KeBHdUyPdx06f3HCXeGKih+W43Az8YyReJyjl7ekMOuy5nPeYev0/Y/WN6c
        oOgil/cRFKflduositqm7FIOZeZwFIN2yg6q19hKQ92Wxs+MGdS1UqgRQ5vO/xbh/TBXhpaha943d
        X7hZfkCg+DT1TtxvsnFj+lmzoQjh6FSYDqumoFCluvyDFInZqxFst1yykAxT7WKK6D94Uo0mOi6tr
        R65Cs/TA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lTy2R-00Dm0l-9W; Wed, 07 Apr 2021 02:35:31 +0000
Date:   Wed, 7 Apr 2021 03:35:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 24/37] mm: implement speculative handling in
 __do_fault()
Message-ID: <20210407023527.GX2531743@casper.infradead.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-25-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407014502.24091-25-michel@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 06:44:49PM -0700, Michel Lespinasse wrote:
> In the speculative case, call the vm_ops->fault() method from within
> an rcu read locked section, and verify the mmap sequence lock at the
> start of the section. A match guarantees that the original vma is still
> valid at that time, and that the associated vma->vm_file stays valid
> while the vm_ops->fault() method is running.
> 
> Note that this implies that speculative faults can not sleep within
> the vm_ops->fault method. We will only attempt to fetch existing pages
> from the page cache during speculative faults; any miss (or prefetch)
> will be handled by falling back to non-speculative fault handling.
> 
> The speculative handling case also does not preallocate page tables,
> as it is always called with a pre-existing page table.

I still don't understand why you want to do this.  The speculative
fault that doesn't do I/O is already here, and it's called ->map_pages
(which I see you also do later).  So what's the point of this patch?
