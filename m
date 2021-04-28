Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7959236D3A7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhD1IJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:09:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:42309 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230456AbhD1IJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:09:09 -0400
IronPort-SDR: YXldW8SwvUQADZXWjtuqaglnEcB7AFp/yItSH6t8jJZculkza0FMSxfKc1ru0KFXcOx4PnraUN
 2istnFlBvb3A==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="282022014"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="282022014"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 01:08:24 -0700
IronPort-SDR: YNklEDKZwnYd3HocG82lxaF8Jsx+15ry+Ex9WF8LzzNmB/vwLKbKBOVZOOi/zKU28M4j3diCQa
 zxiUj+5PCQ4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="423418514"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga008.fm.intel.com with ESMTP; 28 Apr 2021 01:08:22 -0700
Date:   Wed, 28 Apr 2021 16:08:19 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [genirq]  cbe16f35be:  will-it-scale.per_thread_ops -5.2%
 regression
Message-ID: <20210428080819.GB53821@shbuild999.sh.intel.com>
References: <20210427090013.GG32408@xsang-OptiPlex-9020>
 <87fszcnecr.ffs@nanos.tec.linutronix.de>
 <20210428050758.GB52098@shbuild999.sh.intel.com>
 <d392cc91241641df865217d82368eba8@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d392cc91241641df865217d82368eba8@hisilicon.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barry,

On Wed, Apr 28, 2021 at 07:01:35AM +0000, Song Bao Hua (Barry Song) wrote:
> 
> 
> > -----Original Message-----
> > From: Feng Tang [mailto:feng.tang@intel.com]
> > Sent: Wednesday, April 28, 2021 5:08 PM
> > To: Thomas Gleixner <tglx@linutronix.de>
> > Cc: kernel test robot <oliver.sang@intel.com>; Song Bao Hua (Barry Song)
> > <song.bao.hua@hisilicon.com>; Ingo Molnar <mingo@kernel.org>; LKML
> > <linux-kernel@vger.kernel.org>; lkp@lists.01.org; lkp@intel.com;
> > ying.huang@intel.com; zhengjun.xing@intel.com; x86@kernel.org
> > Subject: Re: [genirq] cbe16f35be: will-it-scale.per_thread_ops -5.2%
> > regression
> > 
> > Hi Thomas,
> > 
> > On Tue, Apr 27, 2021 at 01:42:12PM +0200, Thomas Gleixner wrote:
> > > Folks,
> > >
> > > On Tue, Apr 27 2021 at 17:00, kernel test robot wrote:
> > >
> > > > Greeting,
> > > >
> > > > FYI, we noticed a -5.2% regression of will-it-scale.per_thread_ops due to
> > commit:
> > > >
> > > > commit: cbe16f35bee6880becca6f20d2ebf6b457148552 ("genirq: Add
> > > > IRQF_NO_AUTOEN for request_irq/nmi()")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
> > > > master
> > >
> > > this is the second report in the last week which makes not a lot of sense.
> > > And this oneis makes absolutely no sense at all.
> > >
> > > This commit affects request_irq() and the related variants and has
> > > exactly ZERO influence on anything related to that test case simply
> > > because.
> > >
> > > I seriously have to ask the question whether this test infrastructure
> > > is actually measuring what it claims to measure.
> > >
> > > As this commit clearly _cannot_ have the 'measured' side effect, this
> > > points to some serious issue in the tests or the test infrastructure
> > > itself.
> > 
> > 0day has reported about 20 similar cases that the bisected commit has nothing
> > to do with the benchmark case, and we were very confused too back then. And
> > our debug showed many of them changed the code alignment of kernel data or text
> > of other modules which is relevant with the benchmark, though some cases are
> > not well explained yet. Following are links of some explained cases.
> > 
> > https://lore.kernel.org/lkml/20200305062138.GI5972@shao2-debian/
> > https://lore.kernel.org/lkml/20200330011254.GA14393@feng-iot/
> > https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> > 
> > And to debug code alignment case, one debug patch to force all function address
> > aligned to 32 bytes was merged in v5.9
> > 
> > 09c60546f04f ./Makefile: add debug option to enable function aligned on 32 bytes
> > 
> > 
> > For this particular case, the commit changes the code size of
> > request_threaded_irq(), and many following functions' alignment are changed.
> > 
> 
> If so, the performance impact of code change would be random.

Right, I heard 0day team has enabled the force_func_align_32B for some
kernel build to filter the case.

> > So I extended the debug patch to force 64 bytes aligned, then this commit will
> > cause _no_ performance change for the same test case on same platform.
> > 
> > diff --git a/Makefile b/Makefile
> > 
> >  ifdef CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B
> > -KBUILD_CFLAGS += -falign-functions=32
> > +KBUILD_CFLAGS += -falign-functions=64
> >  endif
> > 
> > Though I don't know the detail of how exactly this code alignment affects the
> > case.
> 
> Guess it is related with icache.

Possibly, and sometime iTLB also.

> But it is still an irrelevant problem.
Yes, the commit itself has no problem. And my personal thought
is no further action is needed. 

Thanks,
Feng

> > 
> > Thanks,
> > Feng
> > 
> > > Thanks,
> > >
> > >         tglx
> 
> Thanks
> Barry
