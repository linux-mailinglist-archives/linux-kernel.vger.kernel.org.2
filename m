Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E30D32A540
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446805AbhCBMNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 07:13:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:8741 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380804AbhCBLzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 06:55:52 -0500
IronPort-SDR: HkVqoYUFDbwCmUk3F6HOLjBcOCtB/0UsPWVnZLHRwg75lOvOsW6Qh4D1Zh5de2UyH3MLL9aQsZ
 3iwYPL6w+y6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186114316"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="186114316"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 03:55:04 -0800
IronPort-SDR: sLcrOMnFItxSfzrDMto9cVRjv9+hk9kPFhJ/849M0nvwHUUjLsr9Gv5q7tn7lj4mKJJH0QkWcO
 e2C5MqfJhGZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="398975519"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.165])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2021 03:55:01 -0800
Date:   Tue, 2 Mar 2021 19:55:00 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        dave.hansen@intel.com, andi.kleen@intel.com, len.brown@intel.com
Subject: Re: [PATCH] x86/tsc: mark tsc reliable for qualified platforms
Message-ID: <20210302115500.GA76460@shbuild999.sh.intel.com>
References: <1614653572-19941-1-git-send-email-feng.tang@intel.com>
 <YD4B2TG7JPqFChhR@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD4B2TG7JPqFChhR@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 10:14:01AM +0100, Peter Zijlstra wrote:
> On Tue, Mar 02, 2021 at 10:52:52AM +0800, Feng Tang wrote:
> > @@ -1193,6 +1193,17 @@ static void __init check_system_tsc_reliable(void)
> >  #endif
> >  	if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE))
> >  		tsc_clocksource_reliable = 1;
> > +
> > +	/*
> > +	 * Ideally the socket number should be checked, but this is called
> > +	 * by tsc_init() which is in early boot phase and the socket numbers
> > +	 * may not be available. Use 'nr_online_nodes' as a fallback solution
> > +	 */
> > +	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC)
> > +		&& boot_cpu_has(X86_FEATURE_NONSTOP_TSC)
> > +		&& boot_cpu_has(X86_FEATURE_TSC_ADJUST)
> > +		&& nr_online_nodes <= 2)
> > +		tsc_clocksource_reliable = 1;
> 
> Logical operators go at the end of a line and alignment is with the (,
> not the code block after it.

Thanks for pointing out and the suggestion! Will change it to

	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
	    nr_online_nodes <= 2)
		tsc_clocksource_reliable = 1;

- Feng
