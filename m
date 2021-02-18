Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAABB31EB55
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 16:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhBRPNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 10:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhBRM5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:57:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78587C061788
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 04:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=2US+nsacEnNbgxajBHN8gHhIlm17B6eFkEy6wCvISps=; b=C6H5kURGZ35GnV2sfJMKdRIBBr
        s0806pvqWvxYmulhqLpSCIzCaYys9tg/cselQLoCYAk53i4DB4U4Xi3g9AtbBICOI13m+996lKgZV
        Onx01Qc56w/MPnO5tzzUKM+mMxGYCpipWlKH3lpmgvrUbNZRkTECMSgmjquWgriJ+XZ4JZCEDc7tP
        jmjTbdBOtYN4dq3xgvB67VGb7z6LAt370h25rwCtF48cO3eVBxIdVmKh1RadiuARfq5qJ407DGOJU
        KC4Kzp36w77sxHjYoasmWzHQPwdHSPbK9sLfirxLDIJyhbTKkdcTRDpnLi6T4lPpmh+X3Jjjn69Ax
        yaDJtCcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lCipj-001g4k-QU; Thu, 18 Feb 2021 12:55:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B3E83003E5;
        Thu, 18 Feb 2021 13:55:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BA81201F184F; Thu, 18 Feb 2021 13:55:00 +0100 (CET)
Date:   Thu, 18 Feb 2021 13:55:00 +0100
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
Message-ID: <YC5jpNts1QDtXyMH@hirez.programming.kicks-ass.net>
References: <20210209221653.614098-1-namit@vmware.com>
 <20210209221653.614098-2-namit@vmware.com>
 <YCvztEk6sqiCxXZV@hirez.programming.kicks-ass.net>
 <457D8FBC-8F64-48E9-B9E2-1A316DB0C2B6@vmware.com>
 <YCwWLSRVB1RG/NHm@hirez.programming.kicks-ass.net>
 <9093B9DA-D29D-422F-8315-750CFDBF2690@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9093B9DA-D29D-422F-8315-750CFDBF2690@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 01:02:41AM +0000, Nadav Amit wrote:
> > On Feb 16, 2021, at 10:59 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Tue, Feb 16, 2021 at 06:53:09PM +0000, Nadav Amit wrote:
> >>> On Feb 16, 2021, at 8:32 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> >>> I'm not sure I can explain it yet. It did get me looking at
> >>> on_each_cpu() and it appears that wants to be converted too, something
> >>> like the below perhaps.
> >> 
> >> Looks like a good cleanup, but I cannot say I understand the problem and how
> >> it would solve it. Err...
> > 
> > Yeah, me neither. Bit of a mystery so far.
> 
> This stall seems to be real. Intuitively I presumed preemption was
> mistakenly enabled, but it does not seem so.
> 
> Any chance you can build the kernel with “CONFIG_CSD_LOCK_WAIT_DEBUG=Y” and
> rerun it? Perhaps that output will tell us more.

Sadly not my system. It's a KernelCI box.
