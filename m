Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2419C357694
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhDGVUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbhDGVUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:20:37 -0400
Received: from server.lespinasse.org (unknown [IPv6:2602:303:fcdc:ce10::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0408C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 14:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-11-ed;
 t=1617830427; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=ewiKB7dhg6JS2vHE/8Lo9U0JJBtdLJ6yYPYXNFQFb4A=;
 b=H40D092KZHmVh9Hemd53LzCXHnVeS+uy+u06ihsSjJ9/40JGIdP6Za5ASsNMKgleffYS/
 8j4S8USLBmpu+iCAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-11-rsa; t=1617830427; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=ewiKB7dhg6JS2vHE/8Lo9U0JJBtdLJ6yYPYXNFQFb4A=;
 b=Jbs2G8vVC9byVJ+KMdCDayEwy19AtRD9dbCQ3ocMpKDazQB3A1wfEYicpes/tPw6zkuOf
 pDeZ/Xq7urwiXSOkZWpGn1zhsS5Q7RDP+kvf+dHRUbUn6jUkw2b8hQnuWEFPFarKJJn3uea
 7k7sEGZjwc5uGjw3sh3OPQfE651xhd8TLPNlXwoInnwNsBf8y8igMzz8s6g1V91hEeWfav1
 /XdaXeM4oKvDyq5pdeBTjmJwSKb3tso1n3VgzBPuTY85AxRfJI+1ytHMaZQTl9OeeJxKAmc
 qKLwyphqMdmGZLDk1zVXIV+315D6zA597S2zqzpFF9lMKO13q2ZFRcBq/EJQ==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 5003916024D; Wed,  7 Apr 2021 14:20:27 -0700 (PDT)
Date:   Wed, 7 Apr 2021 14:20:27 -0700
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
Subject: Re: [RFC PATCH 24/37] mm: implement speculative handling in
 __do_fault()
Message-ID: <20210407212027.GE25738@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-25-michel@lespinasse.org>
 <YG3EYjVDrZ54QCLq@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG3EYjVDrZ54QCLq@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 04:40:34PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 06, 2021 at 06:44:49PM -0700, Michel Lespinasse wrote:
> > In the speculative case, call the vm_ops->fault() method from within
> > an rcu read locked section, and verify the mmap sequence lock at the
> > start of the section. A match guarantees that the original vma is still
> > valid at that time, and that the associated vma->vm_file stays valid
> > while the vm_ops->fault() method is running.
> > 
> > Note that this implies that speculative faults can not sleep within
> > the vm_ops->fault method. We will only attempt to fetch existing pages
> > from the page cache during speculative faults; any miss (or prefetch)
> > will be handled by falling back to non-speculative fault handling.
> > 
> > The speculative handling case also does not preallocate page tables,
> > as it is always called with a pre-existing page table.
> 
> So what's wrong with SRCU ? Laurent mumbled something about frequent
> SRCU kthread activity being a problem; is that still so and is that
> fundamentally unfixable?
> 
> Because to me it seems a much more natural solution to the whole thing.

The short answer is that I did not try SRCU. My thought process was,
page cache already uses an RCU read lock, I just need to expand its
scope a little.

Using SRCU might allow us to hit disk during speculative faults; OTOH
we may need to switch to a more robust validation mechanism than the
global counter to reap any benefits.
