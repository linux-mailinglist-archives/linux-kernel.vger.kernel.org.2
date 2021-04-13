Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8220935E9C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 01:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbhDMXlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 19:41:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:12750 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232316AbhDMXlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 19:41:12 -0400
IronPort-SDR: gPwawuczlnhCIzHWwXlPgDzZo/SEtQseUxK1Vd0tfythP4Q5+dduMu+fcd9RfONY9y9bn3aLMM
 0iPAWv4P6OPg==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="181647499"
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="181647499"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 16:40:51 -0700
IronPort-SDR: B96sVtHzZJZGUCZLbxqmC7GzgoPcJm9L6timB4LNgl7jhrCYcUGY+Zp4cWuepMXQ/l05WX7Q/t
 llw2RR1ETV2w==
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="424467972"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 16:40:51 -0700
Date:   Tue, 13 Apr 2021 23:40:45 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v5 2/3] x86/bus_lock: Handle #DB for bus lock
Message-ID: <YHYr/cK+8BGXNILt@otcwcpicx3.sc.intel.com>
References: <20210313054910.2503968-1-fenghua.yu@intel.com>
 <20210313054910.2503968-3-fenghua.yu@intel.com>
 <871rca6dbp.fsf@nanos.tec.linutronix.de>
 <YFUjVwBg133LN+kS@otcwcpicx3.sc.intel.com>
 <878s6iatdf.fsf@nanos.tec.linutronix.de>
 <YGe/IwJSNHnuhU2d@otcwcpicx3.sc.intel.com>
 <8735vw2cub.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735vw2cub.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On Mon, Apr 12, 2021 at 09:15:08AM +0200, Thomas Gleixner wrote:
> On Sat, Apr 03 2021 at 01:04, Fenghua Yu wrote:
> > On Sat, Mar 20, 2021 at 01:42:52PM +0100, Thomas Gleixner wrote:
> >> On Fri, Mar 19 2021 at 22:19, Fenghua Yu wrote:
> >> And even with throttling the injection rate further down to 25k per
> >> second the impact on the workload is still significant in the 10% range.
> > So I can change the ratelimit to system wide and call usleep_range()
> > to sleep: 
> >                while (!__ratelimit(&global_bld_ratelimit))
> >                        usleep_range(1000000 / bld_ratelimit,
> >                                     1000000 / bld_ratelimit);
> >
> > The max bld_ratelimit is 1000,000/s because the max sleeping time is 1
> > usec.
> 
> Maximum sleep time is 1usec?
> 
> > The min bld_ratelimit is 1/s.
> 
> Again. This does not make sense at all. 1Mio bus lock events per second
> are way beyond the point where the machine does anything else than being
> stuck in buslocks.
> 
> Aside of that why are you trying to make this throttling in any way
> accurate? It does not matter at all, really. Limit reached, put it to
> sleep for some time and be done with it. No point in trying to be clever
> for no value.

Is it OK to set bld_ratelimit between 1 and 1,000 bus locks/sec for
bld_ratelimit?

Can I do the throttling like this?

               /* Enforce no more than bld_ratelimit bus locks/sec. */
               while (!__ratelimit(&global_bld_ratelimit))
                       msleep(10);

On one machine, if bld_ratelimit=1,000, that's about 5msec for a busy
bus lock loop, i.e. bus is locked for about 5msec and then the process
sleeps for 10msec and thus won't generate any bus lock.
"dd" command running on other cores doesn't have noticeable degradation
with bld_ratelimit=1,000.

Thanks.

-Fenghua
