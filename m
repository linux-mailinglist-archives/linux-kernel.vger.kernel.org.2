Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCCC31CA75
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 13:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhBPMP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 07:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbhBPMP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 07:15:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDAAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hrTmDfSPMpatshclGd2xBnLqdxQBtnSPp7g673vv2d0=; b=FZqLBpKG5hXEsauwNISyP9SEoi
        3Nw1vcHyrqyhOJXyxZPlkWkd8vs9fU4GiBx9WwF2HtSLHmHXBC00zSxFOTbK19+msFyaPgbffhKlI
        1O+XxHBqSl1e0HvbfnQJ39WMMqP7hKQTVyATcjWxt9E5SA97fFSS7iAx/uRROnk5yPXLmT6gv5xZ0
        t4BrUF9/sLKYsC7Q0jZKSy5llW1mYa8sc+sby+yhfWt6SgP+uOYRN1lLaruqX2LILKrJrtTmuPB7u
        NgUfvQSr+5NBs/vr579vs9+SThXDGxCanC1PVht5a2ALgy7N3cRSRObQfZQkBw5BnchpW3K1tBs5v
        GsdhafLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lBzEz-00Gq7F-2A; Tue, 16 Feb 2021 12:14:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BAEF0304E03;
        Tue, 16 Feb 2021 13:14:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A481E2B9C6CD6; Tue, 16 Feb 2021 13:14:04 +0100 (CET)
Date:   Tue, 16 Feb 2021 13:14:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v5 7/8] cpumask: Mark functions as pure
Message-ID: <YCu3DIHMg/o51TNo@hirez.programming.kicks-ass.net>
References: <20210209221653.614098-1-namit@vmware.com>
 <20210209221653.614098-8-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209221653.614098-8-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 02:16:52PM -0800, Nadav Amit wrote:

> @@ -235,7 +235,7 @@ static inline unsigned int cpumask_last(const struct cpumask *srcp)
>  	return find_last_bit(cpumask_bits(srcp), nr_cpumask_bits);
>  }
>  
> -unsigned int cpumask_next(int n, const struct cpumask *srcp);
> +unsigned int __pure cpumask_next(int n, const struct cpumask *srcp);
>  
>  /**
>   * cpumask_next_zero - get the next unset cpu in a cpumask

I've changed it to:

__pure unsigned int cpumask_next(...);

to be consistent with these:

> @@ -252,8 +252,8 @@ static inline unsigned int cpumask_next_zero(int n, const struct cpumask *srcp)
>  	return find_next_zero_bit(cpumask_bits(srcp), nr_cpumask_bits, n+1);
>  }
>  
> -int cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
> -int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
> +__pure int cpumask_next_and(int n, const struct cpumask *, const struct cpumask *);
> +__pure int cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
>  unsigned int cpumask_local_spread(unsigned int i, int node);
>  int cpumask_any_and_distribute(const struct cpumask *src1p,
>  			       const struct cpumask *src2p);


