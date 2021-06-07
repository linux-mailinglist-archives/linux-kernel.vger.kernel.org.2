Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB3239E6D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhFGSta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhFGSt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:49:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A00C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=E5W7BBL5OZLc434qu0qEVLUyiQ0rMZ4BUsHzE04chsk=; b=MFrbR7Do6dylpH+9Bj5xt1YyPa
        KGW0a+JJ3x4yx/qFmDroZCmE2MCLb7LIXZVV4CzHK9/yZsCuD1GS+skmgJ3L8W7kwSshsp01tj1jj
        cQGor8ifkVStU2xM0zsXpJbq4ZhQFzTa5QIMuB6Glowonh56fHWLc8qQHZAsvRa9ayVDQoVeFRb7G
        HaPEPfipaEslvOecolT53a+yvaL95YH3A4Rt9a70oUuZ3aFyERnctC+CfZQkpQdFyak6mWMUIlgbg
        KLI8cHGSX9U/qKXRzp0mQRyg2yQ5Cbu+KGAC0rklTSzvzxWo8xmmtxDVqCL77ohQN5R5yVi2nfotu
        syiYUMZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqKHS-004UmG-Fe; Mon, 07 Jun 2021 18:47:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE2E2300258;
        Mon,  7 Jun 2021 20:47:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89F673037F2BB; Mon,  7 Jun 2021 20:47:28 +0200 (CEST)
Date:   Mon, 7 Jun 2021 20:47:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, lma@semihalf.com,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>, lb@semihalf.com,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        =?utf-8?B?UmFkb3PFgmF3?= Biernacki <rad@semihalf.com>,
        upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <YL5pwJSJGOGpKols@hirez.programming.kicks-ass.net>
References: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
 <20210604205018.2238778-1-ndesaulniers@google.com>
 <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
 <20210604235046.w3hazgcpsg4oefex@google.com>
 <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
 <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com>
 <YL5jQ6wMo9WeQDYJ@hirez.programming.kicks-ass.net>
 <CAFP8O3KEqSsknL7YwvAhXLu=R6GHR4=SB_Fix0=rR8KiwBKSnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3KEqSsknL7YwvAhXLu=R6GHR4=SB_Fix0=rR8KiwBKSnA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 11:27:27AM -0700, Fāng-ruì Sòng wrote:
> On Mon, Jun 7, 2021 at 11:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sat, Jun 05, 2021 at 06:58:39PM -0700, Fāng-ruì Sòng wrote:
> >
> > > You may use https://github.com/llvm/llvm-project/blob/main/llvm/tools/llvm-objcopy/ELF/Object.cpp#L843
> > > as a reference.
> >
> > BTW, Error::success(), is that a successfull error, or an erroneous
> > success? :-))
> 
> A success (no error). Error::success() is a factory member function.
> Its purpose is to create an "unchecked" Error instance and require the
> caller to explicitly check for the error state.

I got that (see the smily face), but it reads really weird when you're
not used to it.
