Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8A136B344
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhDZMkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:40:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33862 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhDZMkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:40:08 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619440766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mcq1K2/TaL/TqRO/V2iGVJlNefNGUJB7nNGpdtpoe18=;
        b=hzM2eEmOavfvjWOO0A5z0GeDUfWaODsAGHdC45+dQpcNliyKflPx+WZeuyBiQqMXNpTp99
        tD4Skzj++XXVFzIpm3JB9L1sg1yj6lKRlVzXk56yXd+hY4KgT0/4f7UsxPkK3JkhM7TjhC
        i9hXWsTO7eWueXEmPuDWp2EKiwrjJMr6GemfNGvDGuQ8ZqVxHJco4VVOaiTWAo+2/xlP1z
        pLXn3K2jAK+vVCXEUMPuiEUOl8kczCWnYGCxrQSjN4q9a2vYbgFS2ZM8+3wHDrkawwhqAh
        i6ag2YpHL+UR0nmktg51DK5iSklZga5n29w9o//RBA90SC1z4k1zgKe7Cjzm7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619440766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mcq1K2/TaL/TqRO/V2iGVJlNefNGUJB7nNGpdtpoe18=;
        b=e82EtuceKGT+/GVtt3Ppw7wnq9KbyS4amC0ARRdjZqUspURndVwTtZJqEngII+VWNw4NyZ
        nqmchvXO4MGx0iDQ==
To:     Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [LKP] Re: [clocksource] 6c52b5f3cf: stress-ng.opcode.ops_per_sec -14.4% regression
In-Reply-To: <20210424122920.GB85095@shbuild999.sh.intel.com>
References: <20210420134331.GM975577@paulmck-ThinkPad-P17-Gen-1> <20210420140552.GA3158164@paulmck-ThinkPad-P17-Gen-1> <04f4752e-6c5a-8439-fe75-6363d212c7b2@intel.com> <20210421134224.GR975577@paulmck-ThinkPad-P17-Gen-1> <ed77d2a5-aeb0-b7f5-ce91-4cac12cfdd61@linux.intel.com> <20210422074126.GA85095@shbuild999.sh.intel.com> <20210422142454.GD975577@paulmck-ThinkPad-P17-Gen-1> <20210422165743.GA162649@paulmck-ThinkPad-P17-Gen-1> <20210423061115.GA62813@shbuild999.sh.intel.com> <20210423140254.GM975577@paulmck-ThinkPad-P17-Gen-1> <20210424122920.GB85095@shbuild999.sh.intel.com>
Date:   Mon, 26 Apr 2021 14:39:25 +0200
Message-ID: <87pmyhte2q.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24 2021 at 20:29, Feng Tang wrote:
> On Fri, Apr 23, 2021 at 07:02:54AM -0700, Paul E. McKenney wrote:
> And I'm eager to know if there is any real case of an unreliable tsc
> on the 'large numbers' of x86 system which complies with our cpu feature
> check. And if there is, my 2/2 definitely should be dropped.   

Nothing prevents BIOS tinkerers from trying to be 'smart'. My most
recent encounter (3 month ago) was on a laptop where TSC drifted off on
CPU0 very slowly, but was caught due to the TSC_ADJUST check in idle.

I'm still thinking about a solution to avoid that extra timer and the
watchdog for these systems, but haven't found anything which I don't
hate with a passion yet.

Thanks,

        tglx
