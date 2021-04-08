Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5901E358A10
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhDHQsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhDHQr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:47:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64357C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 09:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m77l0LMkgbw2ALxLnDVFN2K5i3Pq//YHsmmOYp1h6hQ=; b=lxvrE1T76sLMMEvVcTFsRP4eaq
        wVLNx/cj89yv0GS5Fd6R6Hl0ymRof58782SkkCScq1ZAAkCHJ5f8VhAf71E5mV5se1ldMJCNdHYqY
        RxyeGlFNwVi7Zyi2Sj+hh8nhZqFFzquv6d3WcPqLFEhMqIhvTaFEbDfz4NrIRi2F/lUqpHC7SdpVO
        sCGLm3J8AQx1oMuCyp/H885UN550zQvnQ0dw0MlQjVwY3k+MFXScWiU7M8hYcXYUbYgRmCe8PBwpa
        U7WgpcL5BR0e0aYDqsY8jjHlf51qQbvZ88oLt/Aofp2C/lgmN/VPgl/pmRUlh9GBOwVYs+Kg/g1zJ
        Pxn0pBFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUXna-00GXc2-Rx; Thu, 08 Apr 2021 16:46:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6C8B30015B;
        Thu,  8 Apr 2021 18:46:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66A8D2C56484D; Thu,  8 Apr 2021 12:18:02 +0200 (CEST)
Date:   Thu, 8 Apr 2021 12:18:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH] Add split_lock
Message-ID: <YG7YWiaEZ1VKqFmb@hirez.programming.kicks-ass.net>
References: <20210408052338.3722069-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408052338.3722069-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 06:23:38AM +0100, Matthew Wilcox (Oracle) wrote:
> bit_spinlocks are horrible on RT because there's absolutely nowhere
> to put the mutex to sleep on.  They also do not participate in lockdep
> because there's nowhere to put the map.
> 
> Most (all?) bit spinlocks are actually a split lock; logically they
> could be treated as a single spinlock, but for performance, we want to
> split the lock over many objects.  Introduce the split_lock as somewhere
> to store the lockdep map and as somewhere that the RT kernel can put
> a mutex.  It may also let us store a ticket lock for better performance
> on non-RT kernels in the future, but I have left the current cpu_relax()
> implementation intact for now.

I think I like it, but I'm not sure it'll work for RT as is. It's a bit
like qrwlock in that it only uses the internal (split) lock for
contention, but that doesn't work for PI.

I've not recently looked at RT, but I think they simply used to bloat a
number of the data structures with a real lock. Sebastian and Thomas
will know better.
