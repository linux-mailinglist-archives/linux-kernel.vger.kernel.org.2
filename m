Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872533A18C1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhFIPOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhFIPOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:14:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C4BC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o/kyvcpjlRGPMvTdqJ9HOqZDedGFgnLgJbX4oTJFC6k=; b=h4emPA3L4SuwKiirWL/7+FXzXB
        62eps+bhf+TaI4+huqW8njMdjuGTH7Y31q8Y70aKMy4t2hbX7yXwC1j3gSGm7EBpvaOev8F/Y0B4K
        0SYbZXjORPabDCfUoryAYjfIJngqi1yM0ZoWzl401B6BV76hJNQZLYYx3CwMY2nqHDECg7SWFNgOK
        ghTgnLtIBcNzgIb7enLtHyfVzE4v6POxdOs5jlM8JNEaTUbat9PmvtpWuvDfBKEVWHqDApZcPWsYX
        xdMFqnXJFho43VwM2+SO7mtlutJAQUMPt3Ao+uFHS9Uc+1G/0phvDAnBQ/s5jc1sPtqaYGH+PT0o0
        cymu4wfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lqzrb-000d8l-8i; Wed, 09 Jun 2021 15:11:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E4CA9867D0; Wed,  9 Jun 2021 17:11:26 +0200 (CEST)
Date:   Wed, 9 Jun 2021 17:11:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>,
        =?utf-8?Q?=C5=81ukasz?= Bartosik <lb@semihalf.com>,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        =?utf-8?B?UmFkb3PFgmF3?= Biernacki <rad@semihalf.com>,
        upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210609151126.GD68237@worktop.programming.kicks-ass.net>
References: <CAKwvOdkuJBwZRigeqdZGevPF9WHyrC5pBAsz6_tWdXAc-wO+1A@mail.gmail.com>
 <e351ac97-4038-61b5-b373-63698a787fc1@kernel.org>
 <YL+nb235rIfEdye0@hirez.programming.kicks-ass.net>
 <de1a21c0-f20a-cde5-016e-4b8ca92eafa9@kernel.org>
 <YL+0MO/1Ra1tnzhT@hirez.programming.kicks-ass.net>
 <5dd58dce-c3a7-39e5-8959-b858de95b72c@kernel.org>
 <CAFJ_xbp5YzYNQWEJLDySyC_bWUsirq=P03k8HHW=B4sH0V_uUg@mail.gmail.com>
 <YMBrqDI0Oxj9+Cr/@hirez.programming.kicks-ass.net>
 <CAFJ_xbodWTQQaJ-3yJ4ZQOiTFFXo6M+cn_F0p157o=80BwrQAw@mail.gmail.com>
 <20210609150804.GF68208@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609150804.GF68208@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 05:08:05PM +0200, Peter Zijlstra wrote:
> I wonder if the compiler will also generate conditional tail calls, and
> what that does with static_call... now I have to check all that.

OK.. static call patching infra will give us a nice WARN before it dies.
