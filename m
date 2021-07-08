Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303A63BF91C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhGHLjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhGHLjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:39:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D148CC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 04:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PRDPTYzsNQqDQUDseTaYquv4wGloS3Xm1/6/BzUpudM=; b=oy8C1/SNPsCrtF8eOvPL5o5oVk
        HxFj0sM3H5C9i0Q52l/hm/0x5BabRw+tG0Krm6xDGc5MXqfpZTWPON2r3+PbxiedDWjKsfHhzPAgB
        Bnf/ceZ23jFbsQ2Hktgmjk4TwPTewe/o868npQoqKXDDfmmzend9j1UQkcSMaLSIm64A0XeEcoOo1
        iEFCg3CGeRNjGLBNaNQd7AA7KIiePZ+PXYPWY8hvOyC+v1gxWa1WrJu3Fg5dABcziM1WeyhNUUEnw
        a2xQFRHGhTHyTkSjjsdu5T5Zgkeriiqc7QVAQ9D508f/UjtKEU04CiBauhChmXNZVFkQ4R7+V9kKL
        CpgYTzOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1SJU-00DMTy-T0; Thu, 08 Jul 2021 11:35:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB2DF300233;
        Thu,  8 Jul 2021 13:35:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 709AA2018A705; Thu,  8 Jul 2021 13:35:26 +0200 (CEST)
Date:   Thu, 8 Jul 2021 13:35:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bristot@redhat.com, bsegall@google.com,
        mgorman@suse.de, Mark Simmons <msimmons@redhat.com>
Subject: Re: [PATCH] sched/rt: Fix double enqueue caused by rt_effective_prio
Message-ID: <YObi/nNu115qg5Rr@hirez.programming.kicks-ass.net>
References: <20210701091431.256457-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701091431.256457-1-juri.lelli@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 11:14:31AM +0200, Juri Lelli wrote:
> Looks like this survives the test case (and regression testing), but I'm
> still not fully convinced that the above statement "Concurrent priority
> inheritance handling is still safe and will eventually converge to a new
> state by following the inheritance chain(s)" is actually sound.

I think we good there. rt_mutex_adjust_prio_chain() updates ->prio in
step 7 and calls rt_mutex_setprio() in step 11.

So if we race against __sched_setschedule() and observe the old value,
step 11 will follow up and correct us.
