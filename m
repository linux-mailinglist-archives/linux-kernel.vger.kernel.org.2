Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F93356EEF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbhDGOlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbhDGOlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:41:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D2FC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6m40cToXPgyDu2b8MrQF6FFVIzoneD5MfUmSB8MTpFk=; b=l4CK2vad/9tSVNg4Y026tKsp1h
        eKVbpKb2o4+nZtrWqKSyNlHAFM/ZZZe6gUIADR8knHWkRPZorFxw3UCeLkxwlBdDhHKJkRa4kre/b
        JT9/qaI0RULGD7x4LotLUBZOUCYcaCGmTVZwU89TH/EirXrp+esodhGKcFqntBFr4LaN6pLGsoyJr
        vA1HOZvMU81+uGAEV8l/kU3u544XDUpK5I0fCy1pSmDI2RGVg6MN/pS/ZRSD1Add4+8RCHxuCC6fb
        itNPqTwquEso7QSHHNhCaAzoPBCkWTg3L+GmTfRZY+w5Ucb6iCZrY5ohDkjdc8v7B/NNCDAltcdw4
        cwnqWjcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lU9MB-005BV7-Vc; Wed, 07 Apr 2021 14:40:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1D025300056;
        Wed,  7 Apr 2021 16:40:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED28323D3AF82; Wed,  7 Apr 2021 16:40:34 +0200 (CEST)
Date:   Wed, 7 Apr 2021 16:40:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 24/37] mm: implement speculative handling in
 __do_fault()
Message-ID: <YG3EYjVDrZ54QCLq@hirez.programming.kicks-ass.net>
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

So what's wrong with SRCU ? Laurent mumbled something about frequent
SRCU kthread activity being a problem; is that still so and is that
fundamentally unfixable?

Because to me it seems a much more natural solution to the whole thing.
