Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DCD36D184
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 07:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhD1FI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 01:08:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:21307 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhD1FI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 01:08:56 -0400
IronPort-SDR: RD5nf20CjS8mIYI+v/4ZaqIk2TwrvicXj7J+/X1yf+Ux5N8FLZR/F90G7KumH8NCwVAo5dYNaf
 DjI42hbQrDQg==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="260610995"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="260610995"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 22:08:11 -0700
IronPort-SDR: WeGAdNQhj6QOSTfnXbE+VkWxfrsZ1HHB/UKm3aAHCzVuSKcKmVvRtsddY1QApYhiXQSJ0MM0n/
 ikIlFm3mNHSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="465752535"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 27 Apr 2021 22:07:58 -0700
Date:   Wed, 28 Apr 2021 13:07:58 +0800
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
Message-ID: <20210428050758.GB52098@shbuild999.sh.intel.com>
References: <20210427090013.GG32408@xsang-OptiPlex-9020>
 <87fszcnecr.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fszcnecr.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Apr 27, 2021 at 01:42:12PM +0200, Thomas Gleixner wrote:
> Folks,
> 
> On Tue, Apr 27 2021 at 17:00, kernel test robot wrote:
> 
> > Greeting,
> >
> > FYI, we noticed a -5.2% regression of will-it-scale.per_thread_ops due to commit:
> >
> > commit: cbe16f35bee6880becca6f20d2ebf6b457148552 ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> this is the second report in the last week which makes not a lot of sense.
> And this oneis makes absolutely no sense at all.
> 
> This commit affects request_irq() and the related variants and has
> exactly ZERO influence on anything related to that test case simply
> because.
> 
> I seriously have to ask the question whether this test infrastructure is
> actually measuring what it claims to measure.
> 
> As this commit clearly _cannot_ have the 'measured' side effect, this
> points to some serious issue in the tests or the test infrastructure
> itself.

0day has reported about 20 similar cases that the bisected commit has
nothing to do with the benchmark case, and we were very confused too
back then. And our debug showed many of them changed the code alignment
of kernel data or text of other modules which is relevant with the
benchmark, though some cases are not well explained yet. Following are
links of some explained cases.

https://lore.kernel.org/lkml/20200305062138.GI5972@shao2-debian/ 
https://lore.kernel.org/lkml/20200330011254.GA14393@feng-iot/
https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/

And to debug code alignment case, one debug patch to force all
function address aligned to 32 bytes was merged in v5.9

09c60546f04f ./Makefile: add debug option to enable function aligned on 32 bytes


For this particular case, the commit changes the code size of
request_threaded_irq(), and many following functions' alignment
are changed.

So I extended the debug patch to force 64 bytes aligned, then
this commit will cause _no_ performance change for the same test
case on same platform.

diff --git a/Makefile b/Makefile
 
 ifdef CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B
-KBUILD_CFLAGS += -falign-functions=32
+KBUILD_CFLAGS += -falign-functions=64
 endif

Though I don't know the detail of how exactly this code alignment
affects the case. 

Thanks,
Feng

> Thanks,
> 
>         tglx
