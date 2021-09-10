Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B388407047
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 19:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhIJRMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 13:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhIJRMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 13:12:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E633C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lf23q0AYyrs/yMXsFyBnjTw80YIc0UjNn2q13VP7R+I=; b=qdYkEz3T+vQnUMEv/4M20BGr47
        5nBp/506ptsEc1InmS9Md4XMUehf5DMOMtZnpKVYFE1HLPRzaLvEQ2/A/ysXf9unLLqb9MnaRTPhk
        IsYVcHntYNZ7o748677GQPyEKyP8kJzHESrrxkwu9CAebxHEFXZQPHJJtfHABTpNY0/zNQX8vGGcz
        d2ziS67FKiCyQLLsvJUWRD42uzna+w2/xxCCQLXGSOQ0bx/N5/I87pXBIyEhm+8rYxh0xt1TZkV6s
        9Fj8qqt7THc1W/UeBG/mRtq6+ryNF7oD76lHPITF31hQ8zDPH++mBy/Id3KwkZ/hwO3pk328PemyQ
        pdV0OjZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOk1z-00BCLX-IQ; Fri, 10 Sep 2021 17:09:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66ACE98627A; Fri, 10 Sep 2021 19:09:37 +0200 (CEST)
Date:   Fri, 10 Sep 2021 19:09:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <llong@redhat.com>
Cc:     Will Deacon <will@kernel.org>, tglx@linutronix.de,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 1/4] sched/wakeup: Strengthen
 current_save_and_set_rtlock_wait_state()
Message-ID: <20210910170937.GM4323@worktop.programming.kicks-ass.net>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.767330253@infradead.org>
 <20210909134524.GB9722@willie-the-truck>
 <YToZ4h/nfsrD3JfY@hirez.programming.kicks-ass.net>
 <20210910125658.GA1454@willie-the-truck>
 <YTta0Kkz4OeFzUvJ@hirez.programming.kicks-ass.net>
 <YTtlOQfAl/cT5Na9@hirez.programming.kicks-ass.net>
 <3242b07a-79be-f355-cf4a-3799913b5d2d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3242b07a-79be-f355-cf4a-3799913b5d2d@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 12:07:40PM -0400, Waiman Long wrote:
> >   #define set_special_state(state_value)					\
> >   	do {								\
> > -		unsigned long flags; /* may shadow */			\
> > +		unsigned long __flags; /* may shadow */			\
> 
> Do you still need the "may shadow" comment?

Strictly speaking yes, there _could_ be a local variable called __flags,
however unlikely.

At some point someone was going around and doing dodgy patches based on
compiler warnings about variables being shadowed, this it to preempt
anybody trying to 'fix' this (again).
