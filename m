Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977CB44BFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhKJLMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhKJLMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:12:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB2FC061766;
        Wed, 10 Nov 2021 03:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mdgITkPzF3BfO5swYkj+ahlZhGOLnl+VYeMvWBp1Ch4=; b=EappGx8ZWfi3BFVE5kdMMssiRI
        RAPxCdQEQpxd3HLCOpE1gxzkECX37cIvJggFAp9Yoz4EINko63XKWYdbyhyoazkXQICH615rleJ3n
        qfJ8pNOKk630tpnY89QPK5wgx8KXfPxuR+dXqQ2tF1ttKN6HvGNiTDTm0eCIqwhVAnv5q006Luufe
        BGutNG5xEx3HYbFgRY78TEMZ9xHzbpEQ8bKGCjzc+OVpXCeUNGYd2oPb0yvtq7FaMMq3UcqjPY5FS
        Xkr+dz5ARAZK3ZBHgf5ehFgjUPc5K0O4hwy2ttPWcOx2Mw5Zp30iWMINbuiU6vBSKCTKpDBiagrru
        LdNbIFPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mklUH-001oJL-GX; Wed, 10 Nov 2021 11:09:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CE2B33000A3;
        Wed, 10 Nov 2021 12:09:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAF012C799836; Wed, 10 Nov 2021 12:09:53 +0100 (CET)
Date:   Wed, 10 Nov 2021 12:09:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>
Subject: Re: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
Message-ID: <YYuogZ+2Dnjyj1ge@hirez.programming.kicks-ass.net>
References: <20211105171023.989862879@infradead.org>
 <20211105171821.654356149@infradead.org>
 <20211108164711.mr2cqdcvedin2lvx@treble>
 <YYlshkTmf5zdvf1Q@hirez.programming.kicks-ass.net>
 <CAKwvOdkFZ4PSN0GGmKMmoCrcp7_VVNjau_b0sNRm3MuqVi8yow@mail.gmail.com>
 <YYov8SVHk/ZpFsUn@hirez.programming.kicks-ass.net>
 <CAKwvOdn8yrRopXyfd299=SwZS9TAPfPj4apYgdCnzPb20knhbg@mail.gmail.com>
 <20211109210736.GV174703@worktop.programming.kicks-ass.net>
 <f6dbe42651e84278b44e44ed7d0ed74f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6dbe42651e84278b44e44ed7d0ed74f@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 10:46:42AM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 09 November 2021 21:08
> ...
> > 
> > GCC does the same, but I wanted to have the exception stuff be in
> > .text.cold, but alas it doesn't do that. I left the attribute because of
> > it's descriptive value.
> > 
> > >  Unless the cold attribute is helping move
> > > ("shrink-wrap"?) the basic block to a whole other section
> > > (.text.cold.)?
> > 
> > I was hoping it would do that, but it doesn't on gcc-11.
> 
> Wouldn't moving part of a function to .text.cold (or .text.unlikely)
> generate the same problems with the stack backtrace code as the
> .text.fixup section you are removing had??

GCC can already split a function into func and func.cold today (or
worse: func, func.isra.N, func.cold, func.isra.N.cold etc..).

I'm assuming reliable unwind and livepatch know how to deal with this.
