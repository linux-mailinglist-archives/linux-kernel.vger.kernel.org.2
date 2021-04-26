Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BEF36AB5D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 06:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhDZEIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 00:08:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:42951 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhDZEIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 00:08:19 -0400
IronPort-SDR: FVURFWsILss3bDaCFGzMwCsrY5Hl7qbhZPy0qXk3Q9I8g5pYGzcu08Ux+UNbUNZg1sFKXklu7b
 GIe4Q3F4CIZg==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="194159729"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="194159729"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 21:07:37 -0700
IronPort-SDR: dqyzByXavGFwoGvnU4/sBrLM6HqaZ1b7JjQnstiAUTMz5nM3KbDRaGp8dLrMxJ1GjDKrQ5GnRW
 YVdTllLWTrHA==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="429191228"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 21:07:37 -0700
Date:   Sun, 25 Apr 2021 21:07:36 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, feng.tang@intel.com,
        zhengjun.xing@intel.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v10 clocksource 1/7] clocksource: Provide module
 parameters to inject delays in watchdog
Message-ID: <20210426040736.GS1401198@tassilo.jf.intel.com>
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
 <20210425224709.1312655-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425224709.1312655-1-paulmck@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> occur between the reads of the two clocks.  Yes, interrupts are disabled
> across those two reads, but there are no shortage of things that can
> delay interrupts-disabled regions of code ranging from SMI handlers to
> vCPU preemption.  It would be good to have some indication as to why

I assume vCPU preemption here refers to preempt RT? I didn't think
a standard kernel could preempt when interrupt are disabled.

>  
> +	clocksource.inject_delay_period= [KNL]
> +			Number of calls to clocksource_watchdog() before
> +			delays are injected between reads from the
> +			two clocksources.  Values of zero disable this
> +			delay injection.  These delays can cause clocks
> +			to be marked unstable, so use of this parameter
> +			should therefore be avoided on production systems.
> +			Defaults to zero (disabled).
> +
> +	clocksource.inject_delay_repeat= [KNL]
> +			Number of repeated clocksource_watchdog() delay
> +			injections per period.	If inject_delay_period
> +			is five and inject_delay_repeat is three, there
> +			will be five delay-free reads followed by three
> +			delayed reads.

I'm not sure command line options are the right way to do this.
How about integrating it with the fault injection framework in debugfs.

This way syzkaller etc. can play with it, which long term would
give much better test coverage.

This wouldn't allow boot time coverage, but presumably that's not
too important here.

-Andi

