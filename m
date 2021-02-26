Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35D032691B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhBZVEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhBZVD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:03:59 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ED6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HPJI91stzZA9wEpS+5JwU+qgZlLkubQ/U0goZvbUUrw=; b=lFTvyeVPHx0qbjZm/qudFzU6u+
        KrWywt+hU+EeU2ZBmwbTSoaBefucMMGAEsqTZdKY4pZZIS+cuSCMN/8SzeJULgtfQ52DU4vIFTjAQ
        04lMQL51eEe5rLBQGGYLs5n0mr5jNLRhmDyTKWuO9sKyrqMSoUuy9B803tDoi/7+E92X4ARS4k9Em
        HSjVs1YMBHY3NjpxoULjYvVozGZ3eU6P/Za33YQAKbeam2FfT6lSPUoEOHfkL8VAV8u3rsXovlnTy
        XXs/5BnuTlOR6uX90N0Iw0x1zq/nD9DIIDnWUxaVTSGj1OtFdXRiHw60luhLrx5gWaXBQz8+0eOS1
        bgbUpxcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lFkGQ-0007B7-SN; Fri, 26 Feb 2021 21:03:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FF7A300DB4;
        Fri, 26 Feb 2021 22:03:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 127BE2065B4A4; Fri, 26 Feb 2021 22:03:04 +0100 (CET)
Date:   Fri, 26 Feb 2021 22:03:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, Clement Courbet <courbet@google.com>,
        Oleg Rombakh <olegrom@google.com>
Subject: Re: [PATCH] sched: Optimize __calc_delta.
Message-ID: <YDliCOPy9s1RdLwd@hirez.programming.kicks-ass.net>
References: <20210226195239.3905966-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226195239.3905966-1-joshdon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 11:52:39AM -0800, Josh Don wrote:
> From: Clement Courbet <courbet@google.com>
> 
> A significant portion of __calc_delta time is spent in the loop
> shifting a u64 by 32 bits. Use a __builtin_clz instead of iterating.
> 
> This is ~7x faster on benchmarks.

Have you tried on hardware without such fancy instructions?
