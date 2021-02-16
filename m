Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCE631D096
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 20:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhBPTBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 14:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhBPTAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 14:00:54 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DD8C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 11:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=si3nwQgk4WhPPdjDOtwTA5HyTVJePHR0iIQ1Hc/iHJY=; b=oNxajjxR473tJoLDOhnWwJokbj
        vrpfUVAfcvgiuerKHidUOcPxCI2UuViQRESA2ZLN2qTO0krpjdP+dSwFC6CMfv+H2S9wqgd1jXhBl
        RDCpKa5VVkq83HC7phiF3DIaCOjsi4iKLY+TrWOqENoWIXvtaBMaqwzKcoqr2oJuBKEOfmvyJrEfG
        rVx85UMbASJfL+BvBMjlavN9YgVGoHQfCQ+/IGF9LGk4S7LuovhenhdH0m1ErcdujM4GBo7VY3u9T
        arnfYSar1vYskfYNBHPh2JyxShC++tiDJ8swjy5djoI/aVycHqXZnirFTMIrLJ7shLsPYLDtw1I2B
        vTiT6q4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lC5Zq-0003hh-Ox; Tue, 16 Feb 2021 19:00:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0FB103011E6;
        Tue, 16 Feb 2021 19:59:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EEED12BC732E8; Tue, 16 Feb 2021 19:59:57 +0100 (CET)
Date:   Tue, 16 Feb 2021 19:59:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 1/8] smp: Run functions concurrently in
 smp_call_function_many_cond()
Message-ID: <YCwWLSRVB1RG/NHm@hirez.programming.kicks-ass.net>
References: <20210209221653.614098-1-namit@vmware.com>
 <20210209221653.614098-2-namit@vmware.com>
 <YCvztEk6sqiCxXZV@hirez.programming.kicks-ass.net>
 <457D8FBC-8F64-48E9-B9E2-1A316DB0C2B6@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457D8FBC-8F64-48E9-B9E2-1A316DB0C2B6@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 06:53:09PM +0000, Nadav Amit wrote:
> > On Feb 16, 2021, at 8:32 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> > I'm not sure I can explain it yet. It did get me looking at
> > on_each_cpu() and it appears that wants to be converted too, something
> > like the below perhaps.
> 
> Looks like a good cleanup, but I cannot say I understand the problem and how
> it would solve it. Err...

Yeah, me neither. Bit of a mystery so far.
