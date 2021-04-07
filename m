Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02352357653
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhDGUvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:51:02 -0400
Received: from server.lespinasse.org ([63.205.204.226]:55091 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbhDGUuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:50:54 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617828644; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=RuYCQ0DgIxUBi/wCmv1Y+yc2Ga4zVqxwcVcBP32mtAw=;
 b=Z7nAG5nMbI4MzkxVTEc2HHAJjn62lZp1Zw9XfJ9QePdfvwBY8+wMqzifzyp5Zwn3JhIVP
 LDMmT3hwpeoveGbAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617828644; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=RuYCQ0DgIxUBi/wCmv1Y+yc2Ga4zVqxwcVcBP32mtAw=;
 b=Wos9VqgdC2RFNH+S94wLjY1ICgF+Prad0ZeP1wvOmUyAOmS94nFg+oDwQHbF0c5T2S2x2
 dJm7+FwWWH4Kuu5m9enACfQhhMc5maEUv4auILwgZ9hkvIdIr60gcr4g33z/Zj9JOaCE08e
 pk5B3/CzsTq5fTCG37AU9kYScyCap//+AE3HWIKhkrvmqt4dkxFePSx+OWYdkuFUdPA89cY
 3DQZSFgOwuZQd3qep2WDwLX3hy2rFz81XNUFq/p/ji2vM9+0TFUGxo4Nxt5NbxbpNFWO5Wl
 LpylYnO6YmKpm24zu6AeQKLbfLOY538yYCTGgRyzJCHTL0vw7GQUyFQE4dcA==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 682BC160244; Wed,  7 Apr 2021 13:50:44 -0700 (PDT)
Date:   Wed, 7 Apr 2021 13:50:44 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
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
Subject: Re: [RFC PATCH 09/37] mm: add per-mm mmap sequence counter for
 speculative page fault handling.
Message-ID: <20210407205044.GD25738@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-10-michel@lespinasse.org>
 <YG3GBhvVt2cQkZVz@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG3GBhvVt2cQkZVz@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 04:47:34PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 06, 2021 at 06:44:34PM -0700, Michel Lespinasse wrote:
> > The counter's write side is hooked into the existing mmap locking API:
> > mmap_write_lock() increments the counter to the next (odd) value, and
> > mmap_write_unlock() increments it again to the next (even) value.
> > 
> > The counter's speculative read side is supposed to be used as follows:
> > 
> > seq = mmap_seq_read_start(mm);
> > if (seq & 1)
> > 	goto fail;
> > .... speculative handling here ....
> > if (!mmap_seq_read_check(mm, seq)
> > 	goto fail;
> > 
> > This API guarantees that, if none of the "fail" tests abort
> > speculative execution, the speculative code section did not run
> > concurrently with any mmap writer.
> 
> So this is obviously safe, but it's also super excessive. Any change,
> anywhere, will invalidate and abort a SPF.
> 
> Since you make a complete copy of the vma, you could memcmp it in its
> entirety instead of this.

Yeah, there is a deliberate choice here to start with the simplest
possible approach, but this could lead to more SPF aborts than
strictly necessary.

It's not clear to me that just comparing original vs current vma
attributes would always be sufficient - I think in some cases, we may
also need to worry about attributes being changed back and forth
concurrently with the fault. However, the comparison you suggest would
be safe at least in the case where the original pte was pte_none.

At some point, I did try implementing the optimization you suggest -
if the global counter has changed, re-fetch the current vma and
compare it against the old - but this was basically no help for the
(Android) workloads I looked at. There were just too few aborts that
were caused by the global counter in the first place. Note that my
patchset only handles anon and page cache faults speculatively, so
generally there wasn't very much time for the counter to change.

But yes, this may not hold across all workloads, and maybe we'd want
to do something smarter once/if a problem workload is identified.
