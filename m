Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67684312F4D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhBHKnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhBHKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:34:25 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234EBC061786
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 02:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=xDQrJfPpzq6OCLUikNQvBLFdBb366qW2vGqM3YLeABw=; b=tabAUv/VgjwIRD97ABYPW2f3IP
        6CN8F7V/rctbyOLPeRO/y+0Jzqx7nmKyBLgls5hk/exbySGeo7DWbsOlFh6pL/GbK98BvuzSb7clw
        VzpHZQGKTQJEpr9TTExZOnMSCRJvb8RWLzLZaoIZ4fWmP5SC5wgmPBrxWTNZb9Yoa/48Y7YZTGGl5
        BxwI91Bxymd7SzMHomkoIMqd7bI7YWjrh2C33HEiUlr0Jg77fRSRqfWnRu6tVx5dy9MZ7lvtxnmj8
        j0aJcAD0vjfLa5JMKXTEEKx1N9DAqiMrce1f2RK0ipzxKjP9Cm2bbNewT5jAgsrC2gbrSLeJ8ISzI
        cbYuaZNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l93rI-0007i5-K1; Mon, 08 Feb 2021 10:33:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 788ED3010D2;
        Mon,  8 Feb 2021 11:33:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 651792BF248D3; Mon,  8 Feb 2021 11:33:30 +0100 (CET)
Date:   Mon, 8 Feb 2021 11:33:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/urgent for v5.11-rc7
Message-ID: <YCETejMWLKW9Se6p@hirez.programming.kicks-ass.net>
References: <661b9809-2c6a-5fc8-163b-a159b84c9ab8@intel.com>
 <2BFAADF3-EBAA-46D6-B1F6-7A41CB85DA1C@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2BFAADF3-EBAA-46D6-B1F6-7A41CB85DA1C@amacapital.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 10:31:32AM -0800, Andy Lutomirski wrote:
> 
> > On Feb 7, 2021, at 10:19 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> > 
> > ﻿On 2/7/21 9:58 AM, Borislav Petkov wrote:
> >>> On Sun, Feb 07, 2021 at 09:49:18AM -0800, Linus Torvalds wrote:
> >>> On Sun, Feb 7, 2021 at 2:40 AM Borislav Petkov <bp@suse.de> wrote:
> >>>> - Disable CET instrumentation in the kernel so that gcc doesn't add
> >>>> ENDBR64 to kernel code and thus confuse tracing.
> >>> So this is clearly the right thing to do for now, but I wonder if
> >>> people have a plan for actually enabling CET and endbr at cpl0 at some
> >>> point?
> >> It probably is an item on some Intel manager's to-enable list. So far,
> >> the CET enablement concentrates only on userspace but dhansen might know
> >> more about future plans. CCed.
> > 
> > It's definitely on our radar to look at after CET userspace.
> > 
> > The only question for me is whether it will be worth doing with the
> > exiting kernel entry/exit architecture.
> 
> I assume you mean: is anyone sufficiently inspired to try to handle
> NMI correctly?  I have a whole pile of nacks saved up for incorrect
> implementations, although I will try to wrap them in polite
> explanations of precisely what is wrong :)

Yeah, the IST stack recursion possibilities are 'fun'. But IIRC CET-SS
has far more problems than just NMI. It will also run into all the ROP
tricks we pull for return tracing, CALL emulation and other lovely
things.


