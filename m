Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9100532BCB3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383484AbhCCObk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842980AbhCCKXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF82C08ECB9;
        Wed,  3 Mar 2021 02:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=joX1wjP2CQMPMJzXxyY2kC5PGk/3iLoHVpVOa4ta6dI=; b=OIMW59WHZMU5hqAhrqRewu3zoW
        umMHO3nHJ3aRZKhoUpG0zleSF38/zF8a9Z/IP9fGoBW/RynTvn/Vd4vpJ+gkLsNgIHCdPeEjc1qI+
        IL56dJqp0Z4g3NsIHkNVUVl1H2idraDTAN/wDEH4/HDaRonvU6oMlugG6iuNhltzmzTVwg6YhAOuT
        pGCGAEgFuTYhKuhUGcbgyME0Gh0zzOZjAaOptZxpzFDZGm2kj7RRgVpB65lB0oV+Vr8ICe98HJjzQ
        +FyOyO2EJ3ODOY4pnUgHNe1WH3NUxQ+YGShbWBkQ7dkOvSUGJwYo59Q4f1gdXw13rlyMBST5PKwUu
        GMdT3prg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lHOKs-0027A0-68; Wed, 03 Mar 2021 10:02:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A5583017B7;
        Wed,  3 Mar 2021 11:02:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C80F20CC061A; Wed,  3 Mar 2021 11:02:29 +0100 (CET)
Date:   Wed, 3 Mar 2021 11:02:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Clement Courbet <courbet@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH] sched: Optimize __calc_delta.
Message-ID: <YD9etVMPW5A22jxo@hirez.programming.kicks-ass.net>
References: <20210226195239.3905966-1-joshdon@google.com>
 <YDliCOPy9s1RdLwd@hirez.programming.kicks-ass.net>
 <CABk29Nv7iJEcDg3rgSvfTkXEM69ZeLByJAsZYuA5qpdj645nZw@mail.gmail.com>
 <CABk29Ntt88BfqGz=Rjd5Mwyj+N0YLv0Z9QsZp8DgB-n+FV1Zgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Ntt88BfqGz=Rjd5Mwyj+N0YLv0Z9QsZp8DgB-n+FV1Zgw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 12:57:37PM -0800, Josh Don wrote:
> On gcc, the asm versions of `fls` are about the same speed as the
> builtin. On clang, the versions that use fls (fls,fls64) are more than
> twice as slow as the builtin. This is because the way the `fls` function
> is written, clang puts the value in memory:
> https://godbolt.org/z/EfMbYe. This can be fixed in a separate patch.

Is this because clang gets the asm constraints wrong? ISTR that
happening before, surely the right thing is to fix clang?
