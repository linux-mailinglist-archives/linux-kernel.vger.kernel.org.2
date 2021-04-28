Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0082836D2BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhD1HCY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Apr 2021 03:02:24 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3093 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1HCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:02:23 -0400
Received: from dggeml759-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FVTwL6RFxzWZJP;
        Wed, 28 Apr 2021 14:57:38 +0800 (CST)
Received: from dggemi709-chm.china.huawei.com (10.3.20.108) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 28 Apr 2021 15:01:35 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi709-chm.china.huawei.com (10.3.20.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 28 Apr 2021 15:01:35 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Wed, 28 Apr 2021 15:01:35 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     kernel test robot <oliver.sang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [genirq]  cbe16f35be:  will-it-scale.per_thread_ops -5.2%
 regression
Thread-Topic: [genirq]  cbe16f35be:  will-it-scale.per_thread_ops -5.2%
 regression
Thread-Index: AQHXO0FhMjEcPgOF502NS90b4qVMhqrHuBoAgAEkLwCAAKN1wA==
Date:   Wed, 28 Apr 2021 07:01:35 +0000
Message-ID: <d392cc91241641df865217d82368eba8@hisilicon.com>
References: <20210427090013.GG32408@xsang-OptiPlex-9020>
 <87fszcnecr.ffs@nanos.tec.linutronix.de>
 <20210428050758.GB52098@shbuild999.sh.intel.com>
In-Reply-To: <20210428050758.GB52098@shbuild999.sh.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.171]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Feng Tang [mailto:feng.tang@intel.com]
> Sent: Wednesday, April 28, 2021 5:08 PM
> To: Thomas Gleixner <tglx@linutronix.de>
> Cc: kernel test robot <oliver.sang@intel.com>; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; Ingo Molnar <mingo@kernel.org>; LKML
> <linux-kernel@vger.kernel.org>; lkp@lists.01.org; lkp@intel.com;
> ying.huang@intel.com; zhengjun.xing@intel.com; x86@kernel.org
> Subject: Re: [genirq] cbe16f35be: will-it-scale.per_thread_ops -5.2%
> regression
> 
> Hi Thomas,
> 
> On Tue, Apr 27, 2021 at 01:42:12PM +0200, Thomas Gleixner wrote:
> > Folks,
> >
> > On Tue, Apr 27 2021 at 17:00, kernel test robot wrote:
> >
> > > Greeting,
> > >
> > > FYI, we noticed a -5.2% regression of will-it-scale.per_thread_ops due to
> commit:
> > >
> > > commit: cbe16f35bee6880becca6f20d2ebf6b457148552 ("genirq: Add
> > > IRQF_NO_AUTOEN for request_irq/nmi()")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
> > > master
> >
> > this is the second report in the last week which makes not a lot of sense.
> > And this oneis makes absolutely no sense at all.
> >
> > This commit affects request_irq() and the related variants and has
> > exactly ZERO influence on anything related to that test case simply
> > because.
> >
> > I seriously have to ask the question whether this test infrastructure
> > is actually measuring what it claims to measure.
> >
> > As this commit clearly _cannot_ have the 'measured' side effect, this
> > points to some serious issue in the tests or the test infrastructure
> > itself.
> 
> 0day has reported about 20 similar cases that the bisected commit has nothing
> to do with the benchmark case, and we were very confused too back then. And
> our debug showed many of them changed the code alignment of kernel data or text
> of other modules which is relevant with the benchmark, though some cases are
> not well explained yet. Following are links of some explained cases.
> 
> https://lore.kernel.org/lkml/20200305062138.GI5972@shao2-debian/
> https://lore.kernel.org/lkml/20200330011254.GA14393@feng-iot/
> https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> 
> And to debug code alignment case, one debug patch to force all function address
> aligned to 32 bytes was merged in v5.9
> 
> 09c60546f04f ./Makefile: add debug option to enable function aligned on 32 bytes
> 
> 
> For this particular case, the commit changes the code size of
> request_threaded_irq(), and many following functions' alignment are changed.
> 

If so, the performance impact of code change would be random.

> So I extended the debug patch to force 64 bytes aligned, then this commit will
> cause _no_ performance change for the same test case on same platform.
> 
> diff --git a/Makefile b/Makefile
> 
>  ifdef CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B
> -KBUILD_CFLAGS += -falign-functions=32
> +KBUILD_CFLAGS += -falign-functions=64
>  endif
> 
> Though I don't know the detail of how exactly this code alignment affects the
> case.

Guess it is related with icache.
But it is still an irrelevant problem.

> 
> Thanks,
> Feng
> 
> > Thanks,
> >
> >         tglx

Thanks
Barry

