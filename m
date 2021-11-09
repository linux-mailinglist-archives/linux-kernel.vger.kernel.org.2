Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E8D44B017
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 16:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbhKIPON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 10:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhKIPN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 10:13:58 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6323CC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 07:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=jnHKpEZ2Xu28NQThFUXRYmIPCDni5z/NZIr/efA6+nw=; b=p/nmzY50Su/dpNlKwLu21GjINz
        7Vg+NQppmuRQhBfCLX7MkqiOrHHuyo+RMc1PJbA9JJvfcSGA3vYxTXKIUDEpwGFtlLsyW3027B3we
        YKn50VWCZmLj3irnqJHmw4RPtcYtxTnHnp9tLq1H404CJqVSbqTXcB5iETQi66QFPg/djT9RXARfk
        9/vXEzy5SrHO9vkbyBkNxgFOaogxlmIrMA1WswlwkkR0oYZx5iIDF2ZZ4tgBPZtgKJG29aHPe/EPk
        0rUQClGsQlIWXGHirfNM4iCihJQsl1Ro8oRhoHEpJ4ltauQHbQcP2/1FvxZT87FA6d01x1crVW9np
        I2y3BHnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkSlt-00F5Mq-0L; Tue, 09 Nov 2021 15:10:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A3DBB3000A3;
        Tue,  9 Nov 2021 16:10:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DD472082F4A7; Tue,  9 Nov 2021 16:10:47 +0100 (CET)
Date:   Tue, 9 Nov 2021 16:10:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, jgross@suse.com
Subject: Re: [PATCH] x86/smp: Factor out parts of native_smp_prepare_cpus()
Message-ID: <YYqPd1c9HIQH9k/9@hirez.programming.kicks-ass.net>
References: <1635896196-18961-1-git-send-email-boris.ostrovsky@oracle.com>
 <YYk+D17oIOGKWNtN@hirez.programming.kicks-ass.net>
 <48fb48fa-c65d-8e38-dabb-cf9be21365ca@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48fb48fa-c65d-8e38-dabb-cf9be21365ca@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 12:20:26PM -0500, Boris Ostrovsky wrote:
> 
> On 11/8/21 10:11 AM, Peter Zijlstra wrote:
> > On Tue, Nov 02, 2021 at 07:36:36PM -0400, Boris Ostrovsky wrote:
> > > Commit 66558b730f25 ("sched: Add cluster scheduler level for x86")
> > > introduced cpu_l2c_shared_map mask which is expected to be initialized
> > > by smp_op.smp_prepare_cpus(). That commit only updated
> > > native_smp_prepare_cpus() version but not xen_pv_smp_prepare_cpus().
> > > As result Xen PV guests crash in set_cpu_sibling_map().
> > > 
> > > While the new mask can be allocated in xen_pv_smp_prepare_cpus() one can
> > > see that both versions of smp_prepare_cpus ops share a number of common
> > > operations that can be factored out. So do that instead.
> > > 
> > > Fixes: 66558b730f25 ("sched: Add cluster scheduler level for x86")
> > > Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Thanks! I'll go stick that somewhere /urgent (I've had another report on
> > that here:
> > 
> >    https://lkml.kernel.org/r/20211105074139.GE174703@worktop.programming.kicks-ass.net
> > )
> 
> 
> Thank you. (I don't see this message btw)

Urgh, that thread never went to lkml :/

> > But looking at those functions; there seems to be more spurious
> > differences. For example, the whole sched_topology thing.
> 
> 
> I did look at that and thought this should be benign given that Xen PV
> is not really topology-aware. I didn't see anything that would be a
> cause for concern but perhaps you can point me to things I missed.

And me not being Xen aware... What does Xen-PV guests see of the CPUID
topology fields? Does it fully sanitize the CPUID data, or is it a clean
pass-through from whatever CPU the vCPU happens to run on at the time?


> > Should we re-architect this whole smp_prepare_cpus() thing instead? Have
> > a common function and a guest function? HyperV for instance seems to
> > call native_smp_prepare_cpus() and then does something extra (as does
> > xen_hvm).
> 
> 
> Something like
> 
> 
> void smp_prepare_cpus()
> 
> {
> 
>     // Code that this patch moved to smp_prepare_cpus_common();
> 
> 
>    smp_ops.smp_prepare_cpus();  // Including baremetal
> 
> }
> 
> 
> ?
> 
> 
> XenHVM and hyperV will need to call native smp_op too. Not sure this
> will be prettier than what it is now?

Hurmph, yeah. I was thinking it would allow pre and post common code,
but yeah, doesn't seem to make sense for now.
