Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7128C366CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbhDUNg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbhDUNgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:36:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEF4C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xxEnPzR5oJElDqWXx3+pjXnUKu5Yv9jkUblOk59HG+k=; b=pcfKosK1MmDzVOKy/QH6E4euu6
        oeHU+H1XE1LZqeUzNV+A49GPN2tYIQ6gOU0/5tJGx5viM9J03BBNbYyvnvm2Pd4op0RYdPi9+Eiz6
        OAqHUVoMfZ3Q7/1wTqMnRc+ZfpkHX9fsxMZA3vzZ67CLFwUEQtKXKvmnyYmnBcxhMHNIfcWqpSSDR
        n8dO8KQctHjx0x/CI5f2xvo5g1aVmEiZnYImM9mTOvFXnRT0RXy1H88MWda43sAahtngBUCjAvivF
        rbwqUZlr/QQi3o/HoHBSSoZRjjtvi6MiYPYqpQRrx5lHOPgKwjGW2qZfKzkZ/90hvilqB0OO92G4v
        Cpq6l28g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZD0X-00GaKt-4c; Wed, 21 Apr 2021 13:35:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA84130013E;
        Wed, 21 Apr 2021 15:35:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A25DE28582676; Wed, 21 Apr 2021 15:35:07 +0200 (CEST)
Date:   Wed, 21 Apr 2021 15:35:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Tejun Heo <tj@kernel.org>, Hao Luo <haoluo@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH 0/9] sched: Core scheduling interfaces
Message-ID: <YIAqC5su75GGu+Qx@hirez.programming.kicks-ass.net>
References: <20210401131012.395311786@infradead.org>
 <YGpOF6f0YcMkWy1u@mtj.duckdns.org>
 <CAEXW_YSS0ex8xK7t2R7c1jiE4eNbwxdwP2uyGPDK78YAaYQr5A@mail.gmail.com>
 <YGxtLOxCb4LO8kN0@slm.duckdns.org>
 <YHuMy0o7gRd+kIVN@google.com>
 <YH1GyFA96tioW4kZ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH1GyFA96tioW4kZ@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 11:00:57AM +0200, Peter Zijlstra wrote:
> On Sat, Apr 17, 2021 at 09:35:07PM -0400, Joel Fernandes wrote:

> > Peter, any thoughts on this?
> 
> Adding CGROUP_SHARE is not sufficient to close the hole against CLEAR.
> So we either then have to 'tweak' the meaning of CLEAR or replace it
> entirely, neither seem attractive.
> 
> 
> I'd love to make some progress on all this.

Can I comment out CLEAR so we can sort that out later? I suppose people
can still do temp cookies simply by using a temp task.
