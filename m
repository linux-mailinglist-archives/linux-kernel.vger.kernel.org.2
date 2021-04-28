Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903CE36D40B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbhD1Ihs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:37:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:63962 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237143AbhD1Iho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:37:44 -0400
IronPort-SDR: vonmne445gQaLVAMkL1W/V/nBJJ1lYmIz2a8ZT+nwpkxDBKmINwdvbd4Xb34BJ9xNVYK95x8OV
 sUQGnFYOyeJg==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="183832957"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="183832957"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 01:36:59 -0700
IronPort-SDR: 8z1ezEkN//rVFccU2elNeqxjLcFg/ynak4cABVRzE5nS/Si7nS4aFxCS6CQaCkEODxCn07QtWk
 XUYx/GiLPJWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="423426309"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga008.fm.intel.com with ESMTP; 28 Apr 2021 01:36:56 -0700
Date:   Wed, 28 Apr 2021 16:36:55 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, zhengjun.xing@intel.com,
        x86@kernel.org
Subject: Re: [genirq]  cbe16f35be:  will-it-scale.per_thread_ops -5.2%
 regression
Message-ID: <20210428083655.GC53821@shbuild999.sh.intel.com>
References: <87fszcnecr.ffs@nanos.tec.linutronix.de>
 <87czufo6xk.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czufo6xk.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 09:37:11PM +0200, Thomas Gleixner wrote:
> On Tue, Apr 27 2021 at 13:42, Thomas Gleixner wrote:
> > On Tue, Apr 27 2021 at 17:00, kernel test robot wrote:
> >> FYI, we noticed a -5.2% regression of will-it-scale.per_thread_ops due to commit:
> >>
> >> commit: cbe16f35bee6880becca6f20d2ebf6b457148552 ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > this is the second report in the last week which makes not a lot of sense.
> > And this oneis makes absolutely no sense at all.
> >
> > This commit affects request_irq() and the related variants and has
> > exactly ZERO influence on anything related to that test case simply
> > because.
> >
> > I seriously have to ask the question whether this test infrastructure is
> > actually measuring what it claims to measure.
> >
> > As this commit clearly _cannot_ have the 'measured' side effect, this
> > points to some serious issue in the tests or the test infrastructure
> > itself.
> 
> Just to illustrate the issue:
> 
> I ran the will-it-scale getppid1 test manually against plain v5.12 and
> against v5.12 + cherrypicked cbe16f35be, i.e. the "offending" commit.
> 
> The result for a full run is just in the noise:
> 
>     average:    < 0.1%
>     minimum:     -0.22%
>     maximum:      0.29%
> 
> IOW very far away from -5.2%.
> 
> That's an order of magnitude off.

The test in original report was done on a 2S/44C/88T Cascade Lake box.
I just run the same case on one Skylake server and one CoffeLake
desktop, and the commit cause no performance change, just like your
result.

And per our experience, this is common that some kernel performance
change can only be reproduced on one or several type of platforms.

Thanks,
Feng

> And no, I'm not going to run that lkp-test muck simply because it's
> unusable and the test result of will-it-scale itself is clear enough.
> 
> Thanks,
> 
>         tglx
