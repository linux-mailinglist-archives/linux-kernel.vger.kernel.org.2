Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B9E3075D1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhA1MSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:18:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231203AbhA1MSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:18:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D2E764DD8;
        Thu, 28 Jan 2021 12:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611836276;
        bh=s3EDpFbWiBJJNv/SQ1O2cBql1JF4jSDUEnFB8Ix7H8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WLcTS9m9Y4XnYOukvPEVykEl5T5OZ/F0uxcgUsLaFIgWvneuTKFb8WCgesD7WzJr/
         Ddw8oKWb6EMZe2vW4WTj+l79npwdcCJ9iz8tdMJSVYTy15NacjbTq5shgskOAOSet7
         D86IsqB1ZpvQtvTUqol0OzicMl6guiajSBKpCQ14uqj0Chn5OHIwza0kcHd/qJ9L05
         OTzKJl71MwsI0py0W2qxb7mn1YCmXJ9Je9J3bQpq3NwZhL33toqQ7HcQkEwwKPOgeR
         /oKanX1yKVsak/NQpF5OzBTi4DKBZMCbMa8cLcWnZX4wTr4mwc/woZz6Yv0a8X0oHS
         Q1IvXorBe4jcw==
Date:   Thu, 28 Jan 2021 13:17:53 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        ardb@kernel.org, jpoimboe@redhat.com
Subject: Re: [RFC PATCH 4/8] preempt: Introduce CONFIG_PREEMPT_DYNAMIC
Message-ID: <20210128121753.GA122776@lothringen>
References: <20210118141223.123667-1-frederic@kernel.org>
 <20210118141223.123667-5-frederic@kernel.org>
 <20210122165343.GE16371@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122165343.GE16371@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 05:53:43PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 18, 2021 at 03:12:19PM +0100, Frederic Weisbecker wrote:
> > +config HAVE_PREEMPT_DYNAMIC
> > +	bool
> > +	depends on HAVE_STATIC_CALL_INLINE
> 
> I think we can relax this to HAVE_STATIC_CALL, using trampolines
> shouldn't be too bad, and that would put it in reach of arm64.

Why not, but then I need to make CONFIG_PREEMPT_DYNAMIC optional
in order not to make the overhead mandatory for everyone.

> 
> > +	depends on GENERIC_ENTRY
> > +	help
> > +	   Select this if the architecture support boot time preempt setting
> > +	   on top of static calls. It is strongly advised to support inline
> > +	   static call to avoid any overhead.
