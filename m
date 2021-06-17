Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5858F3AAF62
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhFQJQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhFQJQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:16:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8484C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7jAeVf7uw57mNPZls65uRWl6PqalkSrQAoEl/FmahJE=; b=pWPWDEgL4BQnJvYIYppPMUvpsd
        zJxX+iiGfKLz+q7Aj95iKzsWn1CEnnjLZISXkCEtpZz0/7bMJU8ofRdj9q3g4qPbOXVJJ5hFod1OF
        HWAktJz3khNNBFW7UpnYze0TwC4EK28l6kaayFV4W51SYnTyQ9u9JhMx6ELvJR9xvSVfe0UkPN+Qx
        Lau9jz3fDDgj1zPnOtXs2YjqaaIO/uzJRplrCwmkRspne6h3FXy42Upe6yeJhawGEVVnF2eOjO/4l
        yWuASdgHgwG3RStcwz4yK4oYJJmjPIFriPJ0gO88QMFHYtMtJDUcaNjl5TA1d9VTLPPzfAy1sl2Zg
        5O+wb0LA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lto61-008xGF-DS; Thu, 17 Jun 2021 09:13:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D68C93001DB;
        Thu, 17 Jun 2021 11:13:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B86B4203C0549; Thu, 17 Jun 2021 11:13:56 +0200 (CEST)
Date:   Thu, 17 Jun 2021 11:13:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [RFC][PATCH] sched: Use lightweight hazard pointers to grab lazy
 mms
Message-ID: <YMsSVH36QGrf7oKH@hirez.programming.kicks-ass.net>
References: <cover.1623813516.git.luto@kernel.org>
 <f184d013a255a523116b692db4996c5db2569e86.1623813516.git.luto@kernel.org>
 <1623816595.myt8wbkcar.astroid@bobo.none>
 <YMmpxP+ANG5nIUcm@hirez.programming.kicks-ass.net>
 <617cb897-58b1-8266-ecec-ef210832e927@kernel.org>
 <1623893358.bbty474jyy.astroid@bobo.none>
 <58b949fb-663e-4675-8592-25933a3e361c@www.fastmail.com>
 <c3c7a1cf-1c87-42cc-b2d6-cc2df55e5b57@www.fastmail.com>
 <YMsQ82bzly2KAUsu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMsQ82bzly2KAUsu@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:08:03AM +0200, Peter Zijlstra wrote:
> +static void mmdrop_lazy(struct rq *rq)
> +{
> +	struct mm_struct *old_mm;
> +
> +	if (likely(!READ_ONCE(rq->drop_mm)))
> +		return;
> +
> +	/*
> +	 * Slow path.  This only happens when we recently stopped using
> +	 * an mm that is exiting.
> +	 */
> +	old_mm = xchg(&rq->drop_mm, NULL);
> +	if (old_mm)
> +		mmdrop(old_mm);
> +}

AFAICT if we observe a !NULL value on the load, the xchg() *MUST* also
see !NULL (although it might see a different !NULL value). So do we want
to write it something like so instead?

static void mmdrop_lazy(struct rq *rq)
{
	struct mm_struct *old_mm;

	if (likely(!READ_ONCE(rq->drop_mm)))
		return;

	/*
	 * Slow path.  This only happens when we recently stopped using
	 * an mm that is exiting.
	 */
	old_mm = xchg(&rq->drop_mm, NULL);
	if (WARN_ON_ONCE(!old_mm))
		return;

	mmdrop(old_mm);
}
