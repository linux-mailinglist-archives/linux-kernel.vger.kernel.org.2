Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96B5357CE8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhDHHCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhDHHCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:02:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E558C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 00:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yigVIYNf+QxM3+FQnoth4sQU6ysRJxJ2nW9krzP8uKU=; b=Vs29Zq9ztaGpw8OiiKN2slj82M
        +JN+z4M9osXi5B0CyEgfUywtwbrWvGV8V3QAyF1L3J3N9X5c1vNPCttMvhwv92nWMHU3TiD03ZAnO
        vfLVzd7g5QV/j0wbR8/dqN+NNcEcimmXsz++tRazB4/tlgv+xlhUs41HrAGXqqaOjsOQboGEdbJMv
        OcqyPjvx2hipsOeZBDIfgsniGCEFbw8GHNRm+Un4zpJdudnUPpcfKg7rWH8M77TlBrYTJTlbBUdH4
        1Cj05Wuzs/IkfF/G1t57Oz02AIGpG9FAjBVFr3IZN4W3/hHT9Hb7PEIa+rgaXWHkoZm8LAu3ttPX1
        2eAD0efw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUOeU-00FjCz-6U; Thu, 08 Apr 2021 07:00:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBB1B3003E3;
        Thu,  8 Apr 2021 09:00:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D17522BC07BA7; Thu,  8 Apr 2021 09:00:26 +0200 (CEST)
Date:   Thu, 8 Apr 2021 09:00:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
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
Message-ID: <YG6qCtRcz2ESUiFy@hirez.programming.kicks-ass.net>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-25-michel@lespinasse.org>
 <YG3EYjVDrZ54QCLq@hirez.programming.kicks-ass.net>
 <20210407212027.GE25738@lespinasse.org>
 <20210407212712.GH2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407212712.GH2531743@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 10:27:12PM +0100, Matthew Wilcox wrote:
> Doing I/O without any lock held already works; it just uses the file
> refcount.  It would be better to use a vma refcount, as I already said.

The original workload that I developed SPF for (waaaay back when) was
prefaulting a single huge vma. Using a vma refcount was a total loss
because it resulted in the same cacheline contention that down_read()
was having.

As such, I'm always incredibly sad to see mention of vma refcounts.
They're fundamentally not solving the problem :/
