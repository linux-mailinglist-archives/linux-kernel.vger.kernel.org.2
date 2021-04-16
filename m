Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1376D3623BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbhDPPT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343697AbhDPPSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:18:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9D8C06138D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mXM8BsDx8XODqEBa4z4najuCzVesa91/gBhAVhpaPQI=; b=rE9YauTT6DHy8BZS7KKsV+2eb/
        SZC8NFGaEhlXvZpX6HKp3bIhseCGXDp4OoqksD0+2ISeqlgFk4acnjWaaODF/7fLpTCVx7Yg+Y5Mm
        psU2yO85L8xrzg8FELUC45shQHio5KmuF8dPYpu2NDXgif21slDhAhA5P0tGgMC6pkISEAEkNRgr8
        7Rfvj73xa53qQ6IojIXEr7j5mVSobxD0FjjPIkMyrU6c/buLMGwbEKM9TLlU4lYHOdJ2qLJKVHRv6
        oW4zQ+OtFJFTJNWVpL7nr3D6DOBX1PsOdQoqRd/g/YBGVvbEZee2f1xqsbs+pMKYfmG3zMWbts7tv
        BubRmqFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXQDY-002aG6-8o; Fri, 16 Apr 2021 15:17:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60CD4300222;
        Fri, 16 Apr 2021 17:17:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E87B24C0E746; Fri, 16 Apr 2021 17:17:11 +0200 (CEST)
Date:   Fri, 16 Apr 2021 17:17:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck <paulmck@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: liburcu: LTO breaking rcu_dereference on arm64 and possibly
 other architectures ?
Message-ID: <YHmqd3BHwVmaUZHX@hirez.programming.kicks-ass.net>
References: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:52:16AM -0400, Mathieu Desnoyers wrote:
> Hi Paul, Will, Peter,
> 
> I noticed in this discussion https://lkml.org/lkml/2021/4/16/118 that LTO
> is able to break rcu_dereference. This seems to be taken care of by
> arch/arm64/include/asm/rwonce.h on arm64 in the Linux kernel tree.
> 
> In the liburcu user-space library, we have this comment near rcu_dereference() in
> include/urcu/static/pointer.h:
> 
>  * The compiler memory barrier in CMM_LOAD_SHARED() ensures that value-speculative
>  * optimizations (e.g. VSS: Value Speculation Scheduling) does not perform the
>  * data read before the pointer read by speculating the value of the pointer.
>  * Correct ordering is ensured because the pointer is read as a volatile access.
>  * This acts as a global side-effect operation, which forbids reordering of
>  * dependent memory operations. Note that such concern about dependency-breaking
>  * optimizations will eventually be taken care of by the "memory_order_consume"
>  * addition to forthcoming C++ standard.
> 
> (note: CMM_LOAD_SHARED() is the equivalent of READ_ONCE(), but was introduced in
> liburcu as a public API before READ_ONCE() existed in the Linux kernel)
> 
> Peter tells me the "memory_order_consume" is not something which can be used today.
> Any information on its status at C/C++ standard levels and implementation-wise ?
> 
> Pragmatically speaking, what should we change in liburcu to ensure we don't generate
> broken code when LTO is enabled ? I suspect there are a few options here:
> 
> 1) Fail to build if LTO is enabled,
> 2) Generate slower code for rcu_dereference, either on all architectures or only
>    on weakly-ordered architectures,
> 3) Generate different code depending on whether LTO is enabled or not. AFAIU this would only
>    work if every compile unit is aware that it will end up being optimized with LTO. Not sure
>    how this could be done in the context of user-space.
> 4) [ Insert better idea here. ]
> 
> Thoughts ?

Using memory_order_acquire is safe; and is basically what Will did for
ARM64.

The problematic tranformations are possible even without LTO, although
less likely due to less visibility, but everybody agrees they're
possible and allowed.

OTOH we do not have a positive sighting of it actually happening (I
think), we're all just being cautious and not willing to debug the
resulting wreckage if it does indeed happen.

