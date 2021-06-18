Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE68A3AC643
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 10:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhFRIiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhFRIiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:38:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA14C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 01:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S/IRAbCRQfCl9L4QO1dDDFQ88Il9eqaq4QycQk5S0ss=; b=VwAjv5wBo63+YwdKB9+bI4qNO1
        DJ1YJtoOtd4Q1f/9NGEF1PxIWViV6nWoaONw1/5FlGLeN73aLDdWDkIOrL0/GD/GfA+1Dklc6ltWj
        Zg4F9FgqEdtV4rQWmUdOZWfZWqHy88hrKxDj0J4QKQwbQ3ra7zgItdDofYGIoHJpXHns6JpmRMCYG
        zpLwxQ0x3knI96f1E8qVYWGQOmZeomN96tz3yshtrQQwgi6Yy8tuijvymk+DSJxAv35YfBBMl0xrM
        qFwBRnBGYxfTXxf/06dcxjXG3q74plfPCzx//nxL9S6gn2KqbEFc0/g8Su8CjA9HmuBREOFBjkPLh
        FIcfIDfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lu9x4-00A4JB-N4; Fri, 18 Jun 2021 08:34:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D4AD0300268;
        Fri, 18 Jun 2021 10:34:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0DD5200F8627; Fri, 18 Jun 2021 10:34:09 +0200 (CEST)
Date:   Fri, 18 Jun 2021 10:34:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Josh Don <joshdon@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Qais Yousef <qais.yousef@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, rostedt@goodmis.org
Subject: Re: [RFC] schedutil: Fix iowait boost issues for slow I/O devices
Message-ID: <YMxagWy/Ioj3aere@hirez.programming.kicks-ass.net>
References: <20210618040639.3113489-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618040639.3113489-1-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Aside from everything else:

On Fri, Jun 18, 2021 at 12:06:39AM -0400, Joel Fernandes (Google) wrote:

> +unsigned int sysctl_iowait_reset_ticks = 20;
> +unsigned int sysctl_iowait_apply_ticks = 10;

Never expose HZ to userspace. we even have USER_HZ (no new usage please)
that fixed existing problems with that.

If you expose a knob, make it in sane time units and convert internally
to whatever you need. That said; less is more with knobs.
