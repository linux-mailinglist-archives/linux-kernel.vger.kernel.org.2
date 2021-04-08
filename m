Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1B2358A14
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhDHQtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhDHQtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:49:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB68C061760;
        Thu,  8 Apr 2021 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fEz0qL5rgd1VzfLvTxSwEHMutEn6GIS7JQ+Kp9M1gJI=; b=bVkLffvLTZgMgl+d5wzDgWDKrR
        O76Mtw0cqfFyPmETXybZGjHNWl/ovIvE8ZSum8LgbTrRXxxigYYMB4lKFULUY8nNWyMrIR7S3yACy
        NQlbmpL1t2BEInc4NeQcB3MiWHy1umdmTpZiu8kDWVAgqomOw2nV1AQKmuqES6qJjbeESOl82QsbI
        WWvyCB08gebpFdI2m2BJncq/fWpcdNH4ECoP8RNgdPPOznALlcSox6G6kihbuCwh6E1mo2wJ7xg5d
        GAavrpzBUbEL/9RWesYeCzjYeWl9MUsJ5dTkoK/k/NmbAoXDuA+GTxyVs26WvN4091q8NwjKLeGq2
        7Wwzw/iw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUXnx-00GXdE-2u; Thu, 08 Apr 2021 16:47:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 600723001D8;
        Thu,  8 Apr 2021 18:46:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32EA32B71A271; Thu,  8 Apr 2021 12:56:01 +0200 (CEST)
Date:   Thu, 8 Apr 2021 12:56:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 0/11 v2] Use local_lock for pcp protection and reduce
 stat overhead
Message-ID: <YG7hQeOthUbPBU86@hirez.programming.kicks-ass.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407202423.16022-1-mgorman@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 09:24:12PM +0100, Mel Gorman wrote:
> Why local_lock? PREEMPT_RT considers the following sequence to be unsafe
> as documented in Documentation/locking/locktypes.rst
> 
>    local_irq_disable();
>    raw_spin_lock(&lock);

Almost, the above is actually OK on RT. The problematic one is:

	local_irq_disable();
	spin_lock(&lock);

That doesn't work on RT since spin_lock() turns into a PI-mutex which
then obviously explodes if it tries to block with IRQs disabled.

And it so happens, that's exactly the one at hand.
