Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA44363D27
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbhDSIJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhDSIJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:09:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E829C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DaNq6zWtjWZorbR3r409ar08WrQWjCzN9DdV4P4P3o8=; b=B20+9x+XqvxqyvmCiWtxsA7tUZ
        MFx7ZbVN43JoHVG44ljMcfNInQUhP0ZstyxbfY+qKVcIZ8Xip50DD9dKcqWQBK2wPk8wwjV72FK85
        dw+p83bMULfwJo5GinL+B/TWD2AF7ZUD6HBUicyc3okyVSpU6LTkbQp0dGwrlWu5qFo9QE0zBvBZ3
        CNu+NRpr3O1X7dlGj4zrSi2OcovTgBM92JBSHK5QHwpz8p22mvM3yzvbBs12vyUpxlLQbKR9WZ6Fo
        hgWNR23elZZG9pj/7j/q7745yxlggBRsvoOG3Z+YlkpOSJSfXRiqpEFrQZX9Wo5zM5KB3I1Tos25p
        GpXx6d1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYOxK-009PHS-An; Mon, 19 Apr 2021 08:08:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ECD60300212;
        Mon, 19 Apr 2021 10:08:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7B1828591522; Mon, 19 Apr 2021 10:08:29 +0200 (CEST)
Date:   Mon, 19 Apr 2021 10:08:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2 resubmit] sched: Warn on long periods of pending
 need_resched
Message-ID: <YH06ffrj87kYT08S@hirez.programming.kicks-ass.net>
References: <20210416212936.390566-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416212936.390566-1-joshdon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 02:29:36PM -0700, Josh Don wrote:
> From: Paul Turner <pjt@google.com>
> 
> CPU scheduler marks need_resched flag to signal a schedule() on a
> particular CPU. But, schedule() may not happen immediately in cases
> where the current task is executing in the kernel mode (no
> preemption state) for extended periods of time.
> 
> This patch adds a warn_on if need_resched is pending for more than the
> time specified in sysctl resched_latency_warn_ms. If it goes off, it is
> likely that there is a missing cond_resched() somewhere. Monitoring is
> done via the tick and the accuracy is hence limited to jiffy scale. This
> also means that we won't trigger the warning if the tick is disabled.
> 
> This feature (LATENCY_WARN) is default disabled.
> 
> Signed-off-by: Paul Turner <pjt@google.com>
> Signed-off-by: Josh Don <joshdon@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20210323035706.572953-1-joshdon@google.com

Thanks!
