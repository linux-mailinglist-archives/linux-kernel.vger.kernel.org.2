Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD76406F85
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhIJQSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhIJQSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:18:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D46EC0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xCrdFByTH04mtUhRdmn4K6cI/kYT4XVOi6Jfa+DXqp8=; b=jfGXBaE1qxDHRlrX8auBCpBWxc
        +yffMrOCY+ts8geSqeOMrYwDtGSLqkhrITbQJZfrwAndmy4Fi1p42/z34rc2XEszV5a9wpJzL0as4
        vuuyEGpcXusnolYmBXT7ETxpLznmqJFaCbjENPggUKJ8dfj9Wl7X0eV4yy22aUd0wY77B3G7e5Ovf
        cQ73IHOvGeb2VyZ6t9/XFXU4a0TYmkAANXzzVM2eZYTNxXbHakecYV50Yav/JiWdqfxYNoJQGXcMg
        FbZKZyERGe7arBVbhz1PtyHxMJhEDkWxrp7XEDIIylQA3GtkVgJCW/8KUBMy9FrRO6muhOVGFshnl
        cWTq5z4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOjCJ-002AgF-MV; Fri, 10 Sep 2021 16:16:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF24F98627A; Fri, 10 Sep 2021 18:16:14 +0200 (CEST)
Date:   Fri, 10 Sep 2021 18:16:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking: Remove rt_rwlock_is_contended()
Message-ID: <20210910161614.GJ4323@worktop.programming.kicks-ass.net>
References: <20210906143004.2259141-1-bigeasy@linutronix.de>
 <20210907100944.7qu3frjuuty3oi3d@linutronix.de>
 <20210907103458.l2iyvjps5bjwnzng@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907103458.l2iyvjps5bjwnzng@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 12:34:58PM +0200, Sebastian Andrzej Siewior wrote:
> rt_rwlock_is_contended() has not users. It makes no sense to use it as
> rwlock_is_contended() because it is a sleeping lock on RT and preemption
> is possible. It reports always != 0 if used by a writer and even if
> there is a waiter then the lock might not be handed over if the
> current owner has the highest priority.

I'm confused now... so first you have two patches that wire up
{spin,rwlock}_is_contended() and how you're arguing we shouldn't do
that?

AFAICT the _is_contended() can still use useful even with preemption,
the typicla use case is a long lock-holder deciding to drop the lock in
order to let someone else in. That still works with preemptible locks,
no?
