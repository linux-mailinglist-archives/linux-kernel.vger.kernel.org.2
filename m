Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D3230DC9A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhBCOWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbhBCOWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:22:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747BDC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/IkMIg+/G16dUtGJvy8Lqc+8sFZ9w36477Rgfa2i+ho=; b=e+pB5MUE2BUYiuA4boO/c/oelt
        VvF3P82IKu86r7sO3wB6cTWdc9Ne6+aWacTGr50N4vQO2IAnf3pTi1qNPUG2uVbM00SHF5u5+VmdK
        GNTOgDzE0fhw77+ihUQC1DWMSoXZMwx3cixP6coisQOEiuXS7ji5l67Zo2H8T3NtJMemcYMDh1oAP
        SsV7BOMFlwa+8qEpNAcPMF11Lh/z/zwAfgGw2+cuFM8PK2b5Sraphhz8+wGFWND8OdCSiX/hOZXeB
        A9ylE6ryk3UunxNVm1rcLq3cUOpo2/qVeeu/OlCSAk5yJrTv566E4bg4gDUh9VPaD+uoE3jJ5UXmv
        dFmgxfvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7J2C-00H112-PX; Wed, 03 Feb 2021 14:21:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20169301179;
        Wed,  3 Feb 2021 15:21:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDEF9203D8391; Wed,  3 Feb 2021 15:21:31 +0100 (CET)
Date:   Wed, 3 Feb 2021 15:21:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>
Subject: Re: [PATCH 2/3] perf/x86/rapl: Fix energy counter detection
Message-ID: <YBqxa4YNT57xDjh7@hirez.programming.kicks-ass.net>
References: <20210115092208.20866-1-rui.zhang@intel.com>
 <20210115092208.20866-2-rui.zhang@intel.com>
 <YAH1DPNLltqN4zFR@hirez.programming.kicks-ass.net>
 <dfc2fc320c96408e86c2f23b21979a5b@intel.com>
 <YALgm2b0YNkO7Qtd@hirez.programming.kicks-ass.net>
 <b27f97d12329452bb95c1345a0bbdd3f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b27f97d12329452bb95c1345a0bbdd3f@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 02:44:04PM +0000, Zhang, Rui wrote:

> > But it doesn't fix anything.. there's not anything broken, except on that daft
> > SPR thing.
> 
> Well, yes.
> Before SPR, this is just a potential issue. But things on SPR suggests
> that this potential issue may become a real one.  So are you
> suggesting me to also include the SPR information as the justification
> of this patch?

Yes, and fix the subject. It doesn't fix anything, as there isn't
anything broken.

Just say that upcoming SPR will need this.
