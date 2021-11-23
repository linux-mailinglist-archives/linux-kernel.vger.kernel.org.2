Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E70459A58
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 04:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhKWDKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 22:10:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:11915 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhKWDKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 22:10:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="232427195"
X-IronPort-AV: E=Sophos;i="5.87,256,1631602800"; 
   d="scan'208";a="232427195"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 19:07:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,256,1631602800"; 
   d="scan'208";a="497115698"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga007.jf.intel.com with ESMTP; 22 Nov 2021 19:06:59 -0800
Date:   Tue, 23 Nov 2021 11:06:59 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 3/4] clocksource: Dynamically increase
 watchdog_max_skew
Message-ID: <20211123030659.GA67648@shbuild999.sh.intel.com>
References: <20211118191439.1000012-1-longman@redhat.com>
 <20211118191439.1000012-4-longman@redhat.com>
 <20211122050224.GH34844@shbuild999.sh.intel.com>
 <e0a41ba0-59d6-d320-02b0-37534f9e66a5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0a41ba0-59d6-d320-02b0-37534f9e66a5@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

On Mon, Nov 22, 2021 at 01:27:25PM -0500, Waiman Long wrote:
> 
> On 11/22/21 00:02, Feng Tang wrote:
> > On Thu, Nov 18, 2021 at 02:14:38PM -0500, Waiman Long wrote:
> > > It is possible that a long-lasting intensive workload running on
> > > a system may cause the clock skew test to be skipped for extended
> > > period of time. One way to avoid this is to dynamically increase the
> > > watchdog_max_skew used in the clock skew test.
> > > 
> > > However, we also don't want watchdog_max_skew to be continuously increased
> > > without bound. So we limit the increase up to 10*WATCHDOG_MAX_SKEW. If
> > > that happens, there is something wrong the current watchdog and we are
> > > going to mark it as unstable and select a new watchdog, if possible.
> > For reselecting watchdog, in these cases, I think it's the extreme system
> > stress causing the MMIO read of hpet to be slow (plus some lock), fallback
> > to other watchdog whose read is MMIO or ioport may not help much. I tried
> > this patch, and when "acpi_pm" timer is used instead of "hpet", similar
> > thing can still happen.
> 
> Yes, I am aware of that. Switching to acpi_pm, did not reduce the
> consecutive read delay. However, the current limit for this watchdog
> fallback is when the delay exceed 5*WATCHDOG_MAX_SKEW. With a default of
> 100us, that mean 500us which is a really large delay that maybe there is
> something wrong with the hpet timer. Of course, the selection of this limit
> is kind of arbitrary. If you have concern about that, we can leave this
> patch out.

I'm not against the "watchdog_max_skew" concept, just wanted to stat
the hpet may be innocent in the case.

I don't have strong opinion about reselecting watchdog either. If the 
server is always running that intensive workload, the watchog could
be fallback to other clocksource, then eventually to NULL device,
which is not bad for that specific case.

Thanks,
Feng

> Cheers,
> Longman
