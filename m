Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCDF44620D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 11:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhKEKTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 06:19:06 -0400
Received: from foss.arm.com ([217.140.110.172]:57914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233041AbhKEKTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 06:19:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 373861FB;
        Fri,  5 Nov 2021 03:16:26 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5FC43F7B4;
        Fri,  5 Nov 2021 03:16:24 -0700 (PDT)
Date:   Fri, 5 Nov 2021 10:16:16 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: Re: [RFC][PATCH 07/22] x86,extable: Extend extable functionality
Message-ID: <YYUEcLLZng7iEvMg@FVFF77S0Q05N>
References: <20211104164729.226550532@infradead.org>
 <20211104165524.925401847@infradead.org>
 <20211104214935.xl54xlr3snwmtyna@treble>
 <20211105075400.GG174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105075400.GG174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 08:54:00AM +0100, Peter Zijlstra wrote:
> On Thu, Nov 04, 2021 at 02:49:35PM -0700, Josh Poimboeuf wrote:
> > On Thu, Nov 04, 2021 at 05:47:36PM +0100, Peter Zijlstra wrote:
> > >  int ex_get_fixup_type(unsigned long ip)
> > >  {
> > >  	const struct exception_table_entry *e = search_exception_tables(ip);
> > >  
> > > -	return e ? e->type : EX_TYPE_NONE;
> > > +	return e ? FIELD_GET(EX_TYPE_MASK, e->type) : EX_TYPE_NONE;
> > 
> > Maybe the 'type' field should be renamed, to better represent its new
> > use, and to try to discourage direct access.  Not that I have any good
> > ideas.  Some not-so-good ideas: "handler", "flags", "_type".
> 
> How about the non-descript: "data" ?

FWIW, I was going to have a single `data` or `info` field on arm64, and I only
went with separate 16-bit `type` and `data` fields becuase it was *marginally*
simpler. If we needed more data bits in future I'd probably collapse `type`
into the `data` field. So you'd be in good company. ;)

On arm64 I'd named the masks EX_DATA_* to make the hierarchy clear, so maybe
you'd want to s/EX_TYPE_MASK/EX_DATA_TYPE/ for similar reasons.

Thanks,
Mark.
