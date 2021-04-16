Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1858362901
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241297AbhDPUCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:02:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235153AbhDPUCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:02:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56B8F613C0;
        Fri, 16 Apr 2021 20:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618603306;
        bh=2DVe7zkdwTTPsX0Pa4Bi3JH3Odqf7RwYDBSLtUShA1k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g335uJ+/qjaHCuf8PWt3w0mRkPZooDTVChxaVa5u0df0AvS77043SlCrFPsc2cn5x
         exQiXdUwAmH7wuoOGg9gH1SDe8Dx4LjZyENwwO99IPOnwIF62tR/G4Qi/jBp2Bp1nf
         rPvkJDhak1q6h60qnFFtiUM4QvzczposQOfYHDPpCI0rEgniDbQPDfFEs6fSKWXDzy
         tx/n9ZLsqz86ctB0TPiV5zoW97sqNc6bj+lBMLZvxewPm1QAF4xsrNrjDlRELtu4kj
         ugF38M3IWrq9teUNjzYE07wooOofbq1VEmONmM9EWpxRz/ssUBfc9vf0DMFSutXa3v
         eHSZWoi5OHNZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0E3645C0253; Fri, 16 Apr 2021 13:01:46 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:01:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lttng-dev <lttng-dev@lists.lttng.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: liburcu: LTO breaking rcu_dereference on arm64 and possibly
 other architectures ?
Message-ID: <20210416200146.GK4212@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
 <YHmqd3BHwVmaUZHX@hirez.programming.kicks-ass.net>
 <20210416160139.GF4212@paulmck-ThinkPad-P17-Gen-1>
 <2089952450.84139.1618598408015.JavaMail.zimbra@efficios.com>
 <20210416190244.GJ4212@paulmck-ThinkPad-P17-Gen-1>
 <2056094038.84390.1618601453585.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2056094038.84390.1618601453585.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 03:30:53PM -0400, Mathieu Desnoyers wrote:
> ----- On Apr 16, 2021, at 3:02 PM, paulmck paulmck@kernel.org wrote:
> [...]
> > 
> > If it can be done reasonably, I suggest also having some way for the
> > person building userspace RCU to say "I know what I am doing, so do
> > it with volatile rather than memory_order_consume."
> 
> Like so ?
> 
> #define CMM_ACCESS_ONCE(x) (*(__volatile__  __typeof__(x) *)&(x))
> #define CMM_LOAD_SHARED(p) CMM_ACCESS_ONCE(p)
> 
> /*
>  * By defining URCU_DEREFERENCE_USE_VOLATILE, the user requires use of
>  * volatile access to implement rcu_dereference rather than
>  * memory_order_consume load from the C11/C++11 standards.
>  *
>  * This may improve performance on weakly-ordered architectures where
>  * the compiler implements memory_order_consume as a
>  * memory_order_acquire, which is stricter than required by the
>  * standard.
>  *
>  * Note that using volatile accesses for rcu_dereference may cause
>  * LTO to generate incorrectly ordered code starting from C11/C++11.
>  */
> 
> #ifdef URCU_DEREFERENCE_USE_VOLATILE
> # define rcu_dereference(x)     CMM_LOAD_SHARED(x)
> #else
> # if defined (__cplusplus)
> #  if __cplusplus >= 201103L
> #   include <atomic>
> #   define rcu_dereference(x)   ((std::atomic<__typeof__(x)>)(x)).load(std::memory_order_consume)
> #  else
> #   define rcu_dereference(x)   CMM_LOAD_SHARED(x)
> #  endif
> # else
> #  if (defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L)
> #   include <stdatomic.h>
> #   define rcu_dereference(x)   atomic_load_explicit(&(x), memory_order_consume)
> #  else
> #   define rcu_dereference(x)   CMM_LOAD_SHARED(x)
> #  endif
> # endif
> #endif

Looks good to me!

							Thanx, Paul
