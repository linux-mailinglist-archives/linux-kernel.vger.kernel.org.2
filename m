Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F10639666A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhEaRGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:06:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:65026 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233877AbhEaQOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 12:14:32 -0400
IronPort-SDR: izzFsUxYs2+q/UUwf0kOFxTS09qPHwBX8pI88h0KwmM0+PXlrvgSNRBF00eqvjYP724l0VnVX4
 fZ3LNnoH7xLA==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="183059584"
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="183059584"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 09:05:34 -0700
IronPort-SDR: QwwaRwpOQK6vzQv5pLkqYQ+evH0v8Ni0uIZe7dNilQRbmDp7DbqqxmyJ3MZLDjXZKSyJ7q02LG
 P7QUl6czWCSw==
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="473954357"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 09:05:27 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lnkPq-00G8vY-1r; Mon, 31 May 2021 19:05:22 +0300
Date:   Mon, 31 May 2021 19:05:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hailong Liu <liuhailongg6@163.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <YLUJQp4fdEAW4GzY@smile.fi.intel.com>
References: <20210530025145.13527-1-liuhailongg6@163.com>
 <YLSUw2Kkq946LQam@smile.fi.intel.com>
 <48a36f92-e8cf-d62b-e4d5-bf6911bcbbcf@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48a36f92-e8cf-d62b-e4d5-bf6911bcbbcf@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 10:09:36PM +0800, Hailong Liu wrote:
> On 5/31/21 3:48 PM, Andy Shevchenko wrote:
> > On Sun, May 30, 2021 at 10:51:45AM +0800, Hailong Liu wrote:
> >> From: Hailong Liu <liu.hailong6@zte.com.cn>
> >>
> >> Now /proc/sched_debug has been moved to debugfs, so make the comments
> >> consistent with it.
> > 
> > Have you checked if the very same Kconfig option is used for something
> > slightly different as well?
> 
> Do you mean that I need to check whether SCHED_DEBUG is also related to
> other features? 

Yes.

> >> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
> > 
> > Missed SoB tag of the submitter.
> 
> In fact the exiting SoB tag of this patch is the actual submitter. 
> 
> I'm sorry that the inconsistency between the submission email and the SoB
> email address caused you to feel confused. 
> 
> For some personal reasons, I had to use an email at home and mark another
> email address as the submitter. 

AFAIU the documentation you have to have two SoBs in this case.

> >> --- a/lib/Kconfig.debug
> >> +++ b/lib/Kconfig.debug
> >> @@ -1166,7 +1166,7 @@ config SCHED_DEBUG
> >>  	depends on DEBUG_KERNEL && PROC_FS
> > 
> > Are the dependencies correct?
> 
> Based on your suggestion, I checked and it turned out that PROC_FS is not
> the correct dependency, but DEBUG_FS. 

I guess you missed something.

> Shoud I change it to DEBUG_FS?

Please, double check.

-- 
With Best Regards,
Andy Shevchenko


