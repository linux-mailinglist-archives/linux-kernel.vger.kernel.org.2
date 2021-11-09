Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F018C44B52C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbhKIWOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 17:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbhKIWO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 17:14:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A359EC061764;
        Tue,  9 Nov 2021 14:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2dap8ibmURuYipx1vLLUctBMVi/xPDv6Pvkxjpj+KQk=; b=jDwM44R26h1wqDoYMo8Vx+RY2r
        z7ruLPduz90bNV8IoPbEPdlXjXNgCP7sbxxWTkPuATS8cgjehNyuNqNYk3YWMIy6ANFy2RgdeElBQ
        j/8NF5S3gvf0vJtqcbme23QFCmjsj1xxiTFPPZuKdXPoVmSIFt3JdBOTrUqcPd2XUNIUkP0gyQjtc
        pKoIJMvdyMH3qtocUBCPTdLib50rqhbN9HN4IoknBjq9YYZO+IZhOTPMXOG9uXUJtjYdjgKZFy/Ro
        f9F/W9EX22y8VmQIoIaunX6Pyvtu5p9HCsy3O7K/FAQirVPTBlCMBB9nYRF2LxeXwF8cL4wCt7fuw
        Z36CAVHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkZL0-001Nm4-Eh; Tue, 09 Nov 2021 22:11:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E43A9862D2; Tue,  9 Nov 2021 23:11:30 +0100 (CET)
Date:   Tue, 9 Nov 2021 23:11:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Bill Wendling <morbo@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz, llvm@lists.linux.dev,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
Message-ID: <20211109221130.GA174703@worktop.programming.kicks-ass.net>
References: <20211105171023.989862879@infradead.org>
 <20211105171821.654356149@infradead.org>
 <20211108164711.mr2cqdcvedin2lvx@treble>
 <YYlshkTmf5zdvf1Q@hirez.programming.kicks-ass.net>
 <CAKwvOdkFZ4PSN0GGmKMmoCrcp7_VVNjau_b0sNRm3MuqVi8yow@mail.gmail.com>
 <YYov8SVHk/ZpFsUn@hirez.programming.kicks-ass.net>
 <CAKwvOdn8yrRopXyfd299=SwZS9TAPfPj4apYgdCnzPb20knhbg@mail.gmail.com>
 <CAGG=3QVecQroYbJ05AGk2f0pe=QOtWuZHyQowzG0i7os8E9fdg@mail.gmail.com>
 <20211109212116.GW174703@worktop.programming.kicks-ass.net>
 <CAKwvOd=3wFr=juT7hXPowHBvOTVPTW7LuB6XwHzURGd=GXkK1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=3wFr=juT7hXPowHBvOTVPTW7LuB6XwHzURGd=GXkK1Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 01:25:47PM -0800, Nick Desaulniers wrote:
> On Tue, Nov 9, 2021 at 1:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Nov 09, 2021 at 12:59:12PM -0800, Bill Wendling wrote:
> > >
> > > Adding attributes to labels shouldn't be difficult, as you mention. In
> > > the case of cold/hot, it's adjusting some of the metadata that already
> > > exists on some basic blocks. It might be enough to allow the normal
> > > block placement algorithms to move the hot and cold blocks around for
> > > us. The question becomes how many attributes does GCC allow on labels?
> >
> > I'm aware of 3: unused, hot, cold. Also:
> >
> >   https://gcc.gnu.org/onlinedocs/gcc/Label-Attributes.html
> 
> Re: unused:
> Being able to selectively disable -Wunused-label via
> __attribute__((unused)); seems useful, too.

kernel/sched/fair.c:done: __maybe_unused;

Yes it is ;-)
