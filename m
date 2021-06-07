Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A036339D500
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFGGg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:36:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:50082 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhFGGg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:36:56 -0400
IronPort-SDR: nd3cJzKuMEXoSTML6xqIrOnMMeqB51MSPeRBhv48nf7kJzEo9ZIVQh0CdgwlMnAqBob8QQKc0b
 txvDE1NWeH7g==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="225903268"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="225903268"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 23:35:05 -0700
IronPort-SDR: 5GiVmBqX1BL1tQNN+0dngUQblYqcnUnrxBx0LVwAaisP5TQvvwxb7uz5RD9lCY8c0Nn0fyXDRk
 JAgrwmRmeQqw==
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="447378949"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 23:35:03 -0700
Subject: Re: [kbuild-all] Re: [irqchip: irq/irqchip-next] powerpc: Drop
 dependency between asm/irq.h and linux/irqdomain.h
To:     Marc Zyngier <maz@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     irqchip-bot for Marc Zyngier <tip-bot2@linutronix.de>,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        tglx@linutronix.de
References: <162298343129.29796.10381692252026350764.tip-bot2@tip-bot2>
 <202106062241.NcVGcvw3-lkp@intel.com>
 <0daef13c3e27002d10bedb7f9719d633@kernel.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <1dbed936-a112-8493-aab2-bbf87aaf6cc2@intel.com>
Date:   Mon, 7 Jun 2021 14:34:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0daef13c3e27002d10bedb7f9719d633@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/21 11:24 PM, Marc Zyngier wrote:
> On 2021-06-06 16:00, kernel test robot wrote:
>> Hi irqchip-bot,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on powerpc/next]
>> [also build test ERROR on linux/master linus/master v5.13-rc4 
>> next-20210604]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:
>> https://github.com/0day-ci/linux/commits/irqchip-bot-for-Marc-Zyngier/powerpc-Drop-dependency-between-asm-irq-h-and-linux-irqdomain-h/20210606-205106 
>>
>> base: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
>> config: powerpc-sbc8548_defconfig (attached as .config)
>> compiler: powerpc-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>         wget
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>> -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         #
>> https://github.com/0day-ci/linux/commit/72415db4cc9ec9987380123553c3222a3568f37f 
>>
>>         git remote add linux-review https://github.com/0day-ci/linux
>>         git fetch --no-tags linux-review
>> irqchip-bot-for-Marc-Zyngier/powerpc-Drop-dependency-between-asm-irq-h-and-linux-irqdomain-h/20210606-205106 
>>
>>         git checkout 72415db4cc9ec9987380123553c3222a3568f37f
>
> I got curious, and fetched this tree. This patch is isolated,
> out of context in the series, and makes absolutely zero sense
> on its own. No wonder you detect all sort of compilation issues.
>
> If you are going to test things, please pick the whole branch,
> and not random patches. This is a waste of everybody's time.
>
>         M.

Hi Marc,

Sorry for the inconvenience, we didn't identify the patch emails from 
tip-bot2,
we'll ignore these emails to avoid ineffective work.

Best Regards,
Rong Chen
