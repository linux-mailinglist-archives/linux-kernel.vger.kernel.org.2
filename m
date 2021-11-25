Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975F645E123
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 20:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356884AbhKYTtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 14:49:03 -0500
Received: from smtprelay0013.hostedemail.com ([216.40.44.13]:52600 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1356764AbhKYTrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 14:47:02 -0500
Received: from omf06.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 2A7958384368;
        Thu, 25 Nov 2021 19:43:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 8F5A6104628C;
        Thu, 25 Nov 2021 19:43:46 +0000 (UTC)
Message-ID: <81cbcf8c782cea2261af55965718a0d8ebb3b21f.camel@perches.com>
Subject: Re: [norov:bitmap-tmp 7/8] arch/powerpc/xmon/xmon.c:472:64: error:
 expected ')' before 'return'
From:   Joe Perches <joe@perches.com>
To:     kernel test robot <lkp@intel.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Date:   Thu, 25 Nov 2021 11:43:48 -0800
In-Reply-To: <202111260340.kCOW9xsR-lkp@intel.com>
References: <202111260340.kCOW9xsR-lkp@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.03
X-Stat-Signature: ydumw6qte9e1jfidj55nrm1ympsy3q34
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 8F5A6104628C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX194I0kw4rWGgM8wRxRwblhUIW+C2aJBwuc=
X-HE-Tag: 1637869426-704949
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-11-26 at 03:17 +0800, kernel test robot wrote:
> tree:   https://github.com/norov/linux bitmap-tmp
> head:   75ee333c81c999b29a49810611fb160cec32217d
> commit: 29f49f10b3fbef5a88db0a7e370984297616f0fa [7/8] lib/cpumask: replace cpumask_weight with cpumask_{empty,gt,le,eq}
> config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20211126/202111260340.kCOW9xsR-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/norov/linux/commit/29f49f10b3fbef5a88db0a7e370984297616f0fa
>         git remote add norov https://github.com/norov/linux
>         git fetch --no-tags norov bitmap-tmp
>         git checkout 29f49f10b3fbef5a88db0a7e370984297616f0fa
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/xmon/xmon.c: In function 'wait_for_other_cpus':
> > > arch/powerpc/xmon/xmon.c:472:64: error: expected ')' before 'return'
>      472 |                 if (cpumask_weight_gt(&cpus_in_xmon, ncpus - 1)
>          |                    ~                                           ^
>          |                                                                )
>      473 |                         return true;
>          |                         ~~~~~~                                  
> > > arch/powerpc/xmon/xmon.c:476:9: error: expected expression before '}' token
>      476 |         }
>          |         ^

It's always good to compile test patches before submitting them and:
 
> vim +472 arch/powerpc/xmon/xmon.c
> 
>    465	
>    466	static bool wait_for_other_cpus(int ncpus)
>    467	{
>    468		unsigned long timeout;
>    469	
>    470		/* We wait for 2s, which is a metric "little while" */
>    471		for (timeout = 20000; timeout != 0; --timeout) {
>  > 472			if (cpumask_weight_gt(&cpus_in_xmon, ncpus - 1)
>    473				return true;
>    474			udelay(100);

unrelated trivia:

It seeems this loop could consume a lot of cpu/power.

Could this use usleep_range() or maybe something else that doesn't allow
rescheduling on another cpu?

Maybe it should be something like

	unsigned long timeout = jiffies + msecs_to_jiffies(2000);

	while (time_before(jiffies, timeout)) {
		if (cpumask_weight_gt(&cpus_in_xmon, ncpus - 1)
				return true;
		usleep_range(100, 200);
	}


