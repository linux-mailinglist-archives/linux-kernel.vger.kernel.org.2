Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B94A39D50E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhFGGhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:37:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:7552 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhFGGhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:37:47 -0400
IronPort-SDR: fSfCp61OeeS7Aez2wKMG3erYGg8TOnsGB208/YwzrcFxrpogUeMllrl96lZsmOQTBwAYAfd+AK
 7NU5VFKiHO7w==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="184251042"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="184251042"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 23:35:56 -0700
IronPort-SDR: pmyJF+7EpzOpsx9iT1oeDExF58KDHI41I7OH5JdyjLwTAUK7HjTidt2EBFb8e/+KVEZBQCUKu0
 IA41DCya19AQ==
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="447379229"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 23:35:55 -0700
Subject: Re: [kbuild-all] Re: [irqchip: irq/irqchip-next] irqdomain: Kill
 irq_domain_add_legacy_isa
To:     Marc Zyngier <maz@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     irqchip-bot for Marc Zyngier <tip-bot2@linutronix.de>,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        tglx@linutronix.de
References: <162298343087.29796.2303741743539407585.tip-bot2@tip-bot2>
 <202106062321.3Z0IkIka-lkp@intel.com>
 <bebfd30fc7ba6ffb20ab0b4d4afec7ec@kernel.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <71261762-f3ea-1e78-6b34-ffea320d1d34@intel.com>
Date:   Mon, 7 Jun 2021 14:35:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bebfd30fc7ba6ffb20ab0b4d4afec7ec@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/21 11:15 PM, Marc Zyngier wrote:
> On 2021-06-06 16:06, kernel test robot wrote:
>> Hi irqchip-bot,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on tip/irq/core]
>> [also build test WARNING on linux/master linus/master v5.13-rc4 
>> next-20210604]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:
>> https://github.com/0day-ci/linux/commits/irqchip-bot-for-Marc-Zyngier/irqdomain-Kill-irq_domain_add_legacy_isa/20210606-204659 
>>
>> base: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>> 006ae1970a8cde1d3e92da69b324d12880133a13
>> config: powerpc-allyesconfig (attached as .config)
>> compiler: powerpc64-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>         wget
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>> -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         #
>> https://github.com/0day-ci/linux/commit/7d6d9b0177b4ae53ccae4fb2c5cd387460def6ac 
>>
>>         git remote add linux-review https://github.com/0day-ci/linux
>>         git fetch --no-tags linux-review
>> irqchip-bot-for-Marc-Zyngier/irqdomain-Kill-irq_domain_add_legacy_isa/20210606-204659 
>>
>>         git checkout 7d6d9b0177b4ae53ccae4fb2c5cd387460def6ac
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross
>> ARCH=powerpc
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>    arch/powerpc/sysdev/i8259.c: In function 'i8259_init':
>>    arch/powerpc/sysdev/i8259.c:263:15: error: implicit declaration of
>> function 'irq_domain_add_legacy_isa'; did you mean
>> 'irq_domain_add_legacy'? [-Werror=implicit-function-declaration]
>>      263 |  i8259_host = irq_domain_add_legacy_isa(node, 
>> &i8259_host_ops, NULL);
>>          |               ^~~~~~~~~~~~~~~~~~~~~~~~~
>>          |               irq_domain_add_legacy
>>>> arch/powerpc/sysdev/i8259.c:263:13: warning: assignment to 'struct 
>>>> irq_domain *' from 'int' makes pointer from integer without a cast 
>>>> [-Wint-conversion]
>>      263 |  i8259_host = irq_domain_add_legacy_isa(node, 
>> &i8259_host_ops, NULL);
>>          |             ^
>>    cc1: some warnings being treated as errors
>
> This makes zero sense. At the point where this patch is applied in
> the series, all instances of irq_domain_add_legacy_isa() have been
> removed, except for one in the Chinese translation of the documentation:
>
> <quote>
> maz@hot-poop:~/arm-platforms$ git checkout 
> bf541b2ef87c162c8129333c55d2357bab122d8e
> HEAD is now at bf541b2ef87c irqdomain: Kill irq_domain_add_legacy_isa
> maz@hot-poop:~/arm-platforms$ git grep irq_domain_add_legacy_isa
> Documentation/translations/zh_CN/core-api/irq/irq-domain.rst: 
> irq_domain_add_legacy_isa()
> </quote>
>
> Are you applying the patches out of order, by any chance?
>
> Thanks,
>
>         M.

Hi Marc,

Sorry for the inconvenience, we didn't identify the patch emails from 
tip-bot2,
we'll ignore these emails to avoid ineffective work.

Best Regards,
Rong Chen
