Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8083074BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhA1L0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhA1LZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:25:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2F5C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rJfsZC10DtX/X6ISTdommQGwbP35fqo+dYyjfZM/n40=; b=PSh+1DRNdsV9NnyPn8WkHBPUbL
        E9fDvku6c7X8gr9oOUq3REKBUP1d0B/rrQp1tqccicXx9gAB7lquVWFoFuEL8dvmvWop0mSohIB0f
        qcaL31Ve37hcT4ncVnhsMvbKW9LkVS525rffDe3Sk/Rha86cVkUQTlJk3WZkz8d5f29cpFKxibiU4
        L7huGJl+XU8yuCHHzdqWKzub7ry6Tg0i+gAbtbaBqbTV98ywehrNHKv2z2Lr6E2vowIuyYQe49Iwz
        xVTwEcPxoiauwAT6AcMvqEpKBtxT12NcyhhTzLgm2h+NeudvgkSeELP8zpVr0eri8YV304wP9K8Ro
        l+1VoUWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l55Pg-008Ns9-QK; Thu, 28 Jan 2021 11:24:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B704E3059C6;
        Thu, 28 Jan 2021 12:24:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAC6A21A78F53; Thu, 28 Jan 2021 12:24:33 +0100 (CET)
Date:   Thu, 28 Jan 2021 12:24:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] qspinlock: Ensure writes are pushed out of core
 write buffer
Message-ID: <YBKe8SVOqLdu+vEf@hirez.programming.kicks-ass.net>
References: <20210127200109.16412-1-alexander.sverdlin@nokia.com>
 <20210127222158.GB848@willie-the-truck>
 <c932770e-8a19-ab32-7b4e-33fc36981b77@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c932770e-8a19-ab32-7b4e-33fc36981b77@nokia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 08:36:24AM +0100, Alexander Sverdlin wrote:

> >> diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
> >> index 5e10153..10e497a 100644
> >> --- a/kernel/locking/mcs_spinlock.h
> >> +++ b/kernel/locking/mcs_spinlock.h
> >> @@ -89,6 +89,11 @@ void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
> >>  		return;
> >>  	}
> >>  	WRITE_ONCE(prev->next, node);
> >> +	/*
> >> +	 * This is necessary to make sure that the corresponding "while" in the
> >> +	 * mcs_spin_unlock() doesn't loop forever
> >> +	 */
> >> +	smp_wmb();
> > If it loops forever, that's broken hardware design; store buffers need to
> > drain. I don't think we should add unconditional barriers to bodge this.
> 
> The comment is a bit exaggerating the situation, but it's undeterministic and you see the
> measurements above. Something is wrong in the qspinlocks code, please consider this patch
> "RFC", but something has to be done here.

The qspinlock code has been TLA+ modelled and has had extensive memory
ordering analysis. It has had lots of runtime on extremely large x86,
arm64, and Power machines. I'm fairly confident there is nothing wrong.

What I do think is more likely is that your platform is broken, it
wouldn't be the first MIPS that's got store-buffers completely wrong,
see commit:

  a30718868915 ("MIPS: Change definition of cpu_relax() for Loongson-3")

Working around micro arch store-buffer issues is not something the
generic code is for.
