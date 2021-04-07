Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBC6356BF7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352113AbhDGMTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352110AbhDGMTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:19:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B99C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gW2Wv4xwd3afh9O6vNP0XMXUfDc3cDwRtgmW8EMAyHg=; b=nvVJk45YsWCtyrpTDcrPzna20z
        TUkNHFkJ8bX+nk6JqOBsSgwDaJDcMGAH8B2wohIrEdbvbI69Hc2EUhS14NmWLTVgCTCrnQwQ0ffUL
        laIn5YpwNpW6kP83RqXAdQQ6kZbbMbC4shWce4u2WvtFOZXm4WevvY/TnZMhQIizKagPR430Jn5nn
        Q2JN4nFj5f+dDKr96GM5UBSAVJfbNu1CbJyRgWqGvHVgyEPXRx8QsfoEWhHHJYorHP3/vVj9rHoXF
        egVKHW6pN5oYdFA9kPWlFxdd8RXobz69WgxMq8xCi/ORw2Oh50+hvw+M3WH3XH1Be8DzEi690+AIz
        IJxO0rHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lU78d-00ERcq-Q3; Wed, 07 Apr 2021 12:18:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7841F300119;
        Wed,  7 Apr 2021 14:18:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3EE86244029A1; Wed,  7 Apr 2021 14:18:26 +0200 (CEST)
Date:   Wed, 7 Apr 2021 14:18:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH 7/9] sched,debug: Convert sysctl sched_domains to debugfs
Message-ID: <YG2jEg9Ybhk15tP5@hirez.programming.kicks-ass.net>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.264012208@infradead.org>
 <87czv6nzhz.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czv6nzhz.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 11:46:32AM +0100, Valentin Schneider wrote:

> > -		__cpumask_clear_cpu(i, sd_sysctl_cpus);
> 
> That seems to be the only place we cleared a CPU in that cpumask, and I
> don't see its replacement

Yeah, oops :-) Lemme go fix that. Thanks!
