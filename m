Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030E2395676
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhEaHuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:50:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:8290 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhEaHuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:50:11 -0400
IronPort-SDR: kKLx7C4Y/8TTDynIwbiERW6rMt9NbSt6qNQgU7ZaJZavzhpXe4SHuKEY7fHbxfHwDkKr3Hvt1Q
 VXPZYRmAfcOw==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="203349032"
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="203349032"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 00:48:32 -0700
IronPort-SDR: 2tjMRHZB29DMZyVN+JZqVrCt3L4DFNPtiluN+Oaybq/Ida3Dwfn1cTOi96sIKCZDhOyK3OgKda
 okwo2DFaoAOw==
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="473839350"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 00:48:23 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lncep-00G2XB-H0; Mon, 31 May 2021 10:48:19 +0300
Date:   Mon, 31 May 2021 10:48:19 +0300
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
Message-ID: <YLSUw2Kkq946LQam@smile.fi.intel.com>
References: <20210530025145.13527-1-liuhailongg6@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210530025145.13527-1-liuhailongg6@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 10:51:45AM +0800, Hailong Liu wrote:
> From: Hailong Liu <liu.hailong6@zte.com.cn>
> 
> Now /proc/sched_debug has been moved to debugfs, so make the comments
> consistent with it.

Have you checked if the very same Kconfig option is used for something
slightly different as well?

> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>

Missed SoB tag of the submitter.

...

> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1166,7 +1166,7 @@ config SCHED_DEBUG
>  	depends on DEBUG_KERNEL && PROC_FS

Are the dependencies correct?

>  	default y
>  	help
> -	  If you say Y here, the /proc/sched_debug file will be provided
> +	  If you say Y here, the debugfs/sched/debug file will be provided
>  	  that can help debug the scheduler. The runtime overhead of this
>  	  option is minimal.

-- 
With Best Regards,
Andy Shevchenko


