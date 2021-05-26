Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76C139111A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhEZG7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbhEZG7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:59:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2070EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aEkOpvu322TNLJ5NQfkEhT81icJn6y8HTArGFvcW2M8=; b=hkWKYtufVdcDm7J/UBSKWvBwLa
        f0bvXz0q0slbYIuSXV8aVZwTExraIOsseqhO8gu4fXTW/2zZ8QSmSoUpHiJH3K9mLoSXTNiPQk43O
        ZVZJinj2hqribQJaWeZXM6xcTumpm0S0KPou3tIme3dNMiLA8Gg/n7vxOle2Ta7GpUKP7BDEcImoR
        0uYax1vn+i2cT0MEkjY4YcPoZsN4SbJILAOBiIISMRL48PedoyYu7t0YJD/3wunWqWEv5kwhbZAYR
        xp1prNDoxUY1f/Q26B+8V8W0NXXyHaHA6GfWNKnDXXQtNRU4WtzGj9oml25O7XkMalC1Yq4Mp3Seq
        NCwisL6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llnTf-004G0U-H4; Wed, 26 May 2021 06:57:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DBF4B30022C;
        Wed, 26 May 2021 08:57:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B62B7202611A4; Wed, 26 May 2021 08:57:13 +0200 (CEST)
Date:   Wed, 26 May 2021 08:57:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] sched/topology: Fix a spelling mistake in error
 message
Message-ID: <YK3xSVbwub51ZnaD@hirez.programming.kicks-ass.net>
References: <20210526021856.9060-1-thunder.leizhen@huawei.com>
 <42d36255-c1a6-956a-b56b-0c09eee125ec@infradead.org>
 <5571d34f-1965-8d8e-3033-6352dd0dcaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5571d34f-1965-8d8e-3033-6352dd0dcaee@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 10:42:31AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/5/26 10:32, Randy Dunlap wrote:
> > On 5/25/21 7:18 PM, Zhen Lei wrote:
> >> The misspelled word 'borken' should be 'broken'.
> >>
> >> Fixes: 6ae72dff3759 ("sched: Robustify topology setup")
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  kernel/sched/topology.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> >> index 55a0a243e871..80295e224442 100644
> >> --- a/kernel/sched/topology.c
> >> +++ b/kernel/sched/topology.c
> >> @@ -1937,7 +1937,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
> >>  
> >>  		if (!cpumask_subset(sched_domain_span(child),
> >>  				    sched_domain_span(sd))) {
> >> -			pr_err("BUG: arch topology borken\n");
> >> +			pr_err("BUG: arch topology broken\n");
> > 
> > Would "borked" or "b0rken" be clearer?
> 
> These two words don't seem to exist at all. Linux is an open-source
> code for the world, so it's better to use a more common word.

Language is a living thing; also:

  https://www.urbandictionary.com/define.php?term=borked

I realize that as a non-native speaker idioms and colloquialisms are
difficult, but if we sanitize the language we'll end up with something
dreadfully dull and less expressive.

Also; this is a rather trivial play on words, to break the word broken,
it should apply to pretty much any (written) language. It should be an
evident pun to all except computer spell checkers (they so lack humour).

Also, I too am a non-native speaker, although I suspect I have it easier
for my native tongue is at least in the same language group as English.

