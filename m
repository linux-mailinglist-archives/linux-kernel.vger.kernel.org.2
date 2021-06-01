Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593F53973B0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhFANAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:00:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:29926 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233162AbhFANAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:00:17 -0400
IronPort-SDR: LwKuHAlJXgIzpXwg8X/7CGcAQHfkc6FyvnMCrwy966Qa7Ci5k3Fnuvcurem5q9z5xRflkcrL3X
 SSpARUd+VxVw==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="201671708"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="201671708"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 05:58:36 -0700
IronPort-SDR: GCDZ5iWYsJ3w1wJvU1SsJKhdf3cRDx023GHFDruIL+1Txe9Kg4DAydLl3UJNfRWE16MYWIeu2x
 UCc3livv78Vg==
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="474239953"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 05:58:32 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lo3yX-00GQuE-D8; Tue, 01 Jun 2021 15:58:29 +0300
Date:   Tue, 1 Jun 2021 15:58:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Hailong Liu <liuhailongg6@163.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: Re: [PATCH] sched/debug:fix stale comments of sched_debug
Message-ID: <YLYu9YpBDre5BO3F@smile.fi.intel.com>
References: <20210530025145.13527-1-liuhailongg6@163.com>
 <YLSUw2Kkq946LQam@smile.fi.intel.com>
 <48a36f92-e8cf-d62b-e4d5-bf6911bcbbcf@163.com>
 <YLUJQp4fdEAW4GzY@smile.fi.intel.com>
 <YLXoQzcUwSO775Z6@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLXoQzcUwSO775Z6@hirez.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 09:56:51AM +0200, Peter Zijlstra wrote:
> On Mon, May 31, 2021 at 07:05:22PM +0300, Andy Shevchenko wrote:
> > > >> --- a/lib/Kconfig.debug
> > > >> +++ b/lib/Kconfig.debug
> > > >> @@ -1166,7 +1166,7 @@ config SCHED_DEBUG
> > > >>  	depends on DEBUG_KERNEL && PROC_FS
> > > > 
> > > > Are the dependencies correct?
> > > 
> > > Based on your suggestion, I checked and it turned out that PROC_FS is not
> > > the correct dependency, but DEBUG_FS. 
> > 
> > I guess you missed something.
> > 
> > > Shoud I change it to DEBUG_FS?
> > 
> > Please, double check.
> 
> Thing is that proc_sched_show_task() still wants PROC_FS, i've not yet
> found a suitable debugfs based location for that.
> 
> And DEBUG_FS doesn't need a dependency; it has complete DEBUG_FS=n
> wrappers and will build fine. Arguably selecting SCHED_DEBUG without
> DEBUG_FS is daft, but it should work.

Yep, my point here is that we have several files (in procfs and debugfs) which
are enabled by the same option. Changing help text as it's done in the patch
seems a half baked solution, i.e. it needs more, like describing what the files
are visible in different configurations.


-- 
With Best Regards,
Andy Shevchenko


