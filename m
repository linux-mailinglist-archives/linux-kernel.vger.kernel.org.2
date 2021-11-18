Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBFD455B93
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 13:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbhKRMgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 07:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344718AbhKRMgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 07:36:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52881C061766
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 04:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=35pW5d9C2lDavDzNiLwiDhFMaMD5Y4hZdtLMABTEiE0=; b=eauBMzEkPKZufthSqkLEWgyEpf
        46daHuqD3Q5ZNy3kW8Lvia0u3vQfNzodCCX4XUvC9z3lJ59q6TXKDSj5ewkT4TuKkTPSgva6k9Elm
        T4UXW2Y9nN2XwQ/UIbGDPWazmHdYbHKfQrdYIx5rfE3BebGIR8LB5o7MbWPn1aqrjByldTrv1gpwN
        cVioLpF2bRRBXiJa3Xhn1fpANDU3g8Nd4F8dGyZY+StMO6pFjIbBn6Utxtdyw2mBnclbSFlbVbaTt
        m9RkO7vFOhqfvAm0SzYe5/kdt9daOIBalbzWF7YF4tVkebhv5cmkjkYRkpK/Oeq+KrCvC+QbhjYUN
        /dwY2lrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mngb5-00GgoL-Q6; Thu, 18 Nov 2021 12:32:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 65330300093;
        Thu, 18 Nov 2021 13:32:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F8B82D3CA53D; Thu, 18 Nov 2021 13:32:59 +0100 (CET)
Date:   Thu, 18 Nov 2021 13:32:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        mpe@ellerman.id.au, maddy@linux.ibm.com
Subject: Re: [PATCH v2 03/13] perf/x86/amd: add AMD Fam19h Branch Sampling
 support
Message-ID: <YZZH+5odIawPQtgJ@hirez.programming.kicks-ass.net>
References: <20211111084415.663951-1-eranian@google.com>
 <20211111084415.663951-4-eranian@google.com>
 <YY6QBXs0sM16DdbV@hirez.programming.kicks-ass.net>
 <CABPqkBShSBaJH+PR6rMkRRzjZAKN5zPhcdnLWx=4a-yQWxcA2A@mail.gmail.com>
 <20211116082923.GX174703@worktop.programming.kicks-ass.net>
 <CABPqkBQ4BCswvNPpkO79dBamhudikz1cGCXFpwAp9xsTb3F8xQ@mail.gmail.com>
 <YZZE+bPCokVrTARM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZZE+bPCokVrTARM@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 01:20:09PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 16, 2021 at 11:23:39PM -0800, Stephane Eranian wrote:

> > Ok, I made the changes you suggested. It looks closer to the way LBR is handled.
> > However, this means that there is no path by which you can get to
> > amd_pmu_disable_event()
> > without having gone through amd_pmu_disable_all(). Is that always the
> > case? And same thing
> > on the enable side.
> 
> So that's true for ->add() and ->del(), those cannot be called without
> being wrapped in ->pmu_disable(), ->pmu_enable().
> 
> There is however the ->stop() and ->start() usage for throttling, which
> can stop an individual event (while leaving the event scheduled on the
> PMU). Now, I think the ->stop() gets called with the PMU enabled, but
> the ->start() is with it disabled again.

I just looked, and the throttling depends on the PMU's PMI handler
implementation, for Intel it will have the PMU disabled, for generic and
AMD it has it enabled (see x86_pmu_handle_irq -- also these are really
NMIs but lets not do a mass rename just now).

> The ramification would be that we'd stop the event, but leave BRS
> enabled for a throttled event. Which should be harmless, no?
