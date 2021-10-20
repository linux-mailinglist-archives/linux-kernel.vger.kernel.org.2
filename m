Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FF24353C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 21:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhJTT0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 15:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhJTT0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:26:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302AFC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 12:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Oam10DOeqAbSgaFDppg0BvCorWB97AakQOXWDOC+C2Q=; b=EwTbRj+O3r/ClTGuubeCiXSKz4
        sWyNCPZpKk6oszL0YOx6SOw0Q9JHgtpcez2r1yEKoX7DmBbD2Oig68T4DizxK9/MVnfxqYinoJlKI
        lCZ+tdjEl/B0gQNm7CPXflg+3TvwcDCbdKIY7Jw62myT/qHFPqRs0Bh8MXrtRKEg174/3cd+tu1qH
        kSwqPmZe4ZjkvGIWYh0bneczNoAe7boj9vXLMBFRz6MlD4fyWOAGBEemRv7+tp7vvUai890njsXUV
        KLFddPBjYFjByFxU1AKmsBvq6GIxg9xaEXYcCo91oARN2g5JXut3pLVyIxCshwprc4cVmsTcJzGWz
        6V3XaGtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdHAT-00CnhS-Fy; Wed, 20 Oct 2021 19:22:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36EC7986DD9; Wed, 20 Oct 2021 21:22:29 +0200 (CEST)
Date:   Wed, 20 Oct 2021 21:22:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH v2 08/14] x86/retpoline: Create a retpoline thunk array
Message-ID: <20211020192229.GP174703@worktop.programming.kicks-ass.net>
References: <20211020104442.021802560@infradead.org>
 <20211020105842.981215247@infradead.org>
 <20211020155750.3u74bkcp66leeyed@treble>
 <f33b9c4e-08c1-f88d-4873-82050a944010@citrix.com>
 <20211020170956.g67xcsvvdkuqg3qa@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020170956.g67xcsvvdkuqg3qa@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 10:09:56AM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 20, 2021 at 05:46:39PM +0100, Andrew Cooper wrote:
> > On 20/10/2021 16:57, Josh Poimboeuf wrote:
> > > On Wed, Oct 20, 2021 at 12:44:50PM +0200, Peter Zijlstra wrote:
> > >> Stick all the retpolines in a single symbol and have the individual
> > >> thunks as inner labels, this should guarantee thunk order and layout.
> > > How so?
> > >
> > > Just wondering what the purpose of the array is.  It doesn't seem to be
> > > referenced anywhere.
> > 
> > The array property is what makes:
> > 
> > > +	reg = (target - &__x86_indirect_thunk_rax) /
> > > +	      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);
> > 
> > safe in the next path.
> 
> The thunks were already 32-byte aligned.  I don't see how slapping a few
> unused symbols around them does anything.

Previously there were 16 (or rather 15 without rsp) separate symbols and
a toolchain might reasonably expect it could displace them however it
liked, with disregard for the relative position.

However, now they're part of a larger symbol. Any change to their
relative position would disrupt this larger _array symbol and thus not
be sound.

This is I think the same reasoning used for data symbols. On their own
there is no guarantee about their relative position wrt to one aonther,
but we're still able to do arrays because an array as a whole is a
single larger symbol.
