Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE2B36AB61
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 06:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhDZENT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 00:13:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:29774 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhDZENS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 00:13:18 -0400
IronPort-SDR: U7R76eiWsR0VPsvaYF4T1iG7XOLBc8k24Bu3/CKsJKR6qsma+cZqu+MOXFLf17egUgaoXgKT15
 zvbqcfMsTF5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="193091258"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="193091258"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 21:12:37 -0700
IronPort-SDR: poc0boSHS8hNFEnmuaRhbOJsfcCUlbhbuMNMfaMbfNts51iNwtUpXZgbS0CNYbqqnARSLPidXx
 sG+lRRzDQzxA==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="422450585"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 21:12:36 -0700
Date:   Sun, 25 Apr 2021 21:12:35 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, feng.tang@intel.com,
        zhengjun.xing@intel.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v10 clocksource 3/7] clocksource: Check per-CPU clock
 synchronization when marked unstable
Message-ID: <20210426041235.GT1401198@tassilo.jf.intel.com>
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
 <20210425224709.1312655-3-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425224709.1312655-3-paulmck@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 03:47:04PM -0700, Paul E. McKenney wrote:
> Some sorts of per-CPU clock sources have a history of going out of
> synchronization with each other.  However, this problem has purportedy
> been solved in the past ten years.  Except that it is all too possible
> that the problem has instead simply been made less likely, which might
> mean that some of the occasional "Marking clocksource 'tsc' as unstable"
> messages might be due to desynchronization.  How would anyone know?
> 
> Therefore apply CPU-to-CPU synchronization checking to newly unstable
> clocksource that are marked with the new CLOCK_SOURCE_VERIFY_PERCPU flag.
> Lists of desynchronized CPUs are printed, with the caveat that if it
> is the reporting CPU that is itself desynchronized, it will appear that
> all the other clocks are wrong.  Just like in real life.

Well I could see this causing a gigantic flood of messages then.
Assume I have 300 cores, do I get all those messages 300 times repeated
then? If the console is slow this might end up taking a lot
of CPU time.

And in a larger cluster this might not be uncommon. 

There must be some way to throttle this.

-Andi
