Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2BF36B658
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhDZQBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:01:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:45863 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234227AbhDZQBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:01:04 -0400
IronPort-SDR: Qep6Kyzn45+bJXbBx0q5wZy7M8eABlDWDb3l8/YO20kaZRboVQgI0NBpbV0q41o6BYY0tKx8G1
 ibLLJaVW6ndw==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="217055661"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="217055661"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 09:00:10 -0700
IronPort-SDR: u11/7ayCBj3uinM6PuJhdN3GlHB/uMB8esP7mSw4MOE3NUcvcWbCA1xSzSmNUuKGC8Ex2TvVg1
 T64SHLXEIi2w==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="457229687"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 09:00:10 -0700
Date:   Mon, 26 Apr 2021 09:00:08 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, feng.tang@intel.com,
        zhengjun.xing@intel.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v10 clocksource 1/7] clocksource: Provide module
 parameters to inject delays in watchdog
Message-ID: <20210426160008.GY1401198@tassilo.jf.intel.com>
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
 <20210425224709.1312655-1-paulmck@kernel.org>
 <20210426040736.GS1401198@tassilo.jf.intel.com>
 <20210426152801.GY975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426152801.GY975577@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Boot-time coverage is important, as we saw in kbuild test robot testing
> of v9 of this patchset, which triggered clocksource_tsc_early, but not
> clocksource_tsc.  Note that v10 avoids this triggering.

Not sure how that could happen, I didn't think the kbuild bot knows
how to set these options.

Overall I think you should follow the existing frame works instead
of inventing your own so that things can be later tested in an
uniform manner.

Perhaps the fault injection framework needs boot options, but
they should be generic.

-Andi
