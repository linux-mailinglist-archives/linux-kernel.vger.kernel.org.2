Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EF83609EF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhDONEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDONEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:04:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92CDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bCH16pKatllAsQ3z12nJ9iJICTPCtqsM1hCpkmmKbtM=; b=X+okAXUPjDAYnzUbGWdZqOHR/t
        WaTOkCNqS7qTCcoQzRioeV5lDCumaEY24pFFxPLyt/nGKeIZmjbeMVP1WPS5nbHd3qieJQwMjM7jb
        8jxOeLufidbCPa2vTW4HLOJH79sI/7ZvYjUoSB9fcDoEYDYwXFp0nFCuen2JaHF/HoG0nHE5FaaW3
        a4f8s8MhVEWe57FYBk9ISIqzsizrnFZmtOyzmMdnp84RCLlgOhWnn9OJ8TgY4a4qthZ3WUhRqjbqr
        hiwvt1w7SxYyyT/hCS+AaJ79m28iKXkQjjlH+B5kQZXlAIH/jVg+BAp9ypSgqOCGcq0BIluvWRAlO
        bDEduw3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lX1e6-008ZrY-QW; Thu, 15 Apr 2021 13:03:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E85C530015A;
        Thu, 15 Apr 2021 15:02:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6F072CCC08DE; Thu, 15 Apr 2021 15:02:57 +0200 (CEST)
Date:   Thu, 15 Apr 2021 15:02:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, linux-kernel@vger.kernel.org, greg@kroah.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v2 7/9] sched,debug: Convert sysctl sched_domains to
 debugfs
Message-ID: <YHg5gWTJb1yRGtiu@hirez.programming.kicks-ass.net>
References: <20210412101421.609526370@infradead.org>
 <20210412102001.485107586@infradead.org>
 <87lf9mmdyk.mognet@arm.com>
 <YHgB/s4KCBQ1ifdm@hirez.programming.kicks-ass.net>
 <87czuvn2uk.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czuvn2uk.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 01:34:27PM +0100, Valentin Schneider wrote:
> On 15/04/21 11:06, Peter Zijlstra wrote:
> > @@ -2388,8 +2384,6 @@ void partition_sched_domains_locked(int
> >       doms_cur = doms_new;
> >       dattr_cur = dattr_new;
> >       ndoms_cur = ndoms_new;
> > -
> > -	register_sched_domain_sysctl();
> >  }
> >
> 
> This has to stay, otherwise we never update the files.

Duh, how about I rename that to update_sched_domain_debugfs() or
something.
