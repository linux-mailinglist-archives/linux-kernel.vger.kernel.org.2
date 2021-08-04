Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F793E01B5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbhHDNLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhHDNLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:11:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA59EC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P4X735DYiIfygJN7+etEPu5hzo8NS8lKB4wnq177LMk=; b=TQs+i5fFfikvR+hLPNq/z7XyKq
        INKTZTlUvHnGuHRZduJYHWmZpZXaK9L2hQMInbbQcEVUAULfLU3KVlgCBC/e+4dSj9c2KgcSUPScB
        boWpVRktuT0N8Q5ZuPgy28rs2lEUbi3eTIyDO/U1GxkB9ywuKn8mCg4kqD4K+sbtvEvBQtu12gZc4
        qhrWWe5eNprqFTo+t1hQvcPQ9dD4rrmtQyj5oABDJR8UWSEYms0V9OrYDk60w3WheCbHEnubXyqSP
        q0BG+gU34QmY4fheCobDs3p61EUY0y5Q20KsuuqhWKpqIcJRghWzkvDGeITyqz5uJyGpBGStOmTWR
        ML6FDPjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBGgE-005kTn-PQ; Wed, 04 Aug 2021 13:11:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BAE09862B0; Wed,  4 Aug 2021 15:11:30 +0200 (CEST)
Date:   Wed, 4 Aug 2021 15:11:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Song Bao Hua <song.bao.hua@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Reduce SIS scanning
Message-ID: <20210804131129.GF8057@worktop.programming.kicks-ass.net>
References: <20210804115857.6253-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804115857.6253-1-mgorman@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 12:58:55PM +0100, Mel Gorman wrote:
> This is the first two patches from "Modify and/or delete SIS_PROP" and
> focues on improving the hit rate for recent_used_cpu and avoids rescanning
> the target CPU when it's known to be busy. These are relatively simply
> patches in comparison to the full series which could be a regression
> magnet and that series had at least one mistake in it.
> 
> In general, the usual suspects showed mostly small gains with a few
> exceptions.  Usual suspects were NAS, hackbench, schbench (Facebook
> latency-sensitive workload), perf pipe, kernel building, git test suite,
> dbench and redis.
> 
> From here, the next obvious candidates are either improving has_idle_cores
> or continuing to try remove/improve SIS_PROP.

Thanks!
