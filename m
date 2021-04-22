Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0688C3685E9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbhDVRaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbhDVRaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:30:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6985FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1DyE3USgzq4ZI15aHBo2m2fFbLZpZ606BX/3TbcfNRo=; b=Hki+pKGLtfeEUySz5nHMSq8B8A
        SAuU8Ck4wEsYQF5dnCBDHbA3S34qyPKgPq/uYE0NJqAbbZ0Dfltr2UMPJKa4K3LzKStw27kTQJYZH
        V6JMjrZtBLpP/9TLhUT52K4PnGWk1R7DuIOmr1TOxQbzpztqgIVWkpbQEfbnpgxXJa++1rXEHVpcr
        UhrW3qPY8RAvw1WjFIbsaRVHFr50ZRFxq87bS5ZbNtZ/i1Fj8kE51KHbD56yYRJaoUxbuQcifGNC1
        fv4zVg1YVSIQC5ctQpUdiMb04rw9F7gx4SJlXs+g/3I6rM56xNGX7ZJY6shJBcL1WgI1JNHYQivBH
        YcALgr7A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZd8s-00HBLD-S6; Thu, 22 Apr 2021 17:29:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4306A3001E2;
        Thu, 22 Apr 2021 19:29:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 312D42D04872B; Thu, 22 Apr 2021 19:29:29 +0200 (CEST)
Date:   Thu, 22 Apr 2021 19:29:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Don Hiatt <dhiatt@digitalocean.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 00/19] sched: Core Scheduling
Message-ID: <YIGyeVBS0qnes/RP@hirez.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <CAOY2WoyMyqjGSWf1JD7tmsBHwKgjpxL7FB3sYjFSge8fBMZv6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOY2WoyMyqjGSWf1JD7tmsBHwKgjpxL7FB3sYjFSge8fBMZv6g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:43:59AM -0700, Don Hiatt wrote:
> On Thu, Apr 22, 2021 at 5:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Hai,
> >
> > This is an agressive fold of all the core-scheduling work so far. I've stripped
> > a whole bunch of tags along the way (hopefully not too many, please yell if you
> > feel I made a mistake), including tested-by. Please retest.
> >
> > Changes since the last partial post is dropping all the cgroup stuff and
> > PR_SCHED_CORE_CLEAR as well as that exec() behaviour in order to later resolve
> > the cgroup issue.
> >
> Hi Peter,
> 
> Is there a reason that PR_SCHED_CORE_CLEAR got removed? It's handy to
> be able to clear cookies.

I agree, but if we're forced to do cgroup with cookie inherit, when
CLEAR allows a trivial escape.

Until that whole cgroup thing is sorted, it is easiest to not have
CLEAR, lest we have to change/augment CLEAR semantics in unfortunate
ways, which is always harder once an API is out there.

Also, see the entire previous discussion here:

  https://lore.kernel.org/lkml/20210401131012.395311786@infradead.org/
