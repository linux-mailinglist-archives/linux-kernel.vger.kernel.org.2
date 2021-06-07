Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A985539D4FF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFGGgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:36:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:35925 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhFGGgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:36:31 -0400
IronPort-SDR: at/z/an9QQVSj2S3gydBuUxefCbDjydgoekdWCG7dgMyVY6F50IrLofeotZznRELkxD4wnDgry
 D4WZ9wng7cKg==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="290196767"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="290196767"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 23:34:40 -0700
IronPort-SDR: 2XLHzrAgSmoPJl6+sL77MGL422dWVNMMB3uYZeIKBXh/qx5JrwKfbKorLejMI6X40eEUrpJLsa
 nRnRNrC6hbGA==
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="447378827"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 23:34:36 -0700
Subject: Re: [kbuild-all] Re: [irqchip: irq/irqchip-next] genirq: Use
 irq_resolve_mapping() to implement __handle_domain_irq() and co
To:     Marc Zyngier <maz@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     irqchip-bot for Marc Zyngier <tip-bot2@linutronix.de>,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        tglx@linutronix.de
References: <162298342683.29796.7142738277768084602.tip-bot2@tip-bot2>
 <202106062255.MSPpLhpo-lkp@intel.com>
 <09413d2ec08ea7c41ce84f448cb577d0@kernel.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <54c72b10-0973-d945-4bd4-21bb2878b6d4@intel.com>
Date:   Mon, 7 Jun 2021 14:34:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <09413d2ec08ea7c41ce84f448cb577d0@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/21 11:28 PM, Marc Zyngier wrote:
> On 2021-06-06 15:19, kernel test robot wrote:
>> Hi irqchip-bot,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on linux/master]
>> [also build test WARNING on tip/irq/core linus/master v5.13-rc4 
>> next-20210604]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:
>> https://github.com/0day-ci/linux/commits/irqchip-bot-for-Marc-Zyngier/genirq-Use-irq_resolve_mapping-to-implement-__handle_domain_irq-and-co/20210606-204819 
>>
>> base:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> dd860052c99b1e088352bdd4fb7aef46f8d2ef47
>> config: riscv-nommu_k210_defconfig (attached as .config)
>> compiler: riscv64-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>         wget
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>> -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         #
>> https://github.com/0day-ci/linux/commit/e684b127b014b361df0088dca184273cdd73d79e 
>>
>>         git remote add linux-review https://github.com/0day-ci/linux
>>         git fetch --no-tags linux-review
>> irqchip-bot-for-Marc-Zyngier/genirq-Use-irq_resolve_mapping-to-implement-__handle_domain_irq-and-co/20210606-204819 
>>
>>         git checkout e684b127b014b361df0088dca184273cdd73d79e
>
> Same thing. Patch randomly picked without context, broken
> test system. From now on. these reports will be sent to /dev/null
> until the test infrastructure is fixed.
>
>         M.

Hi Marc,

Sorry for the inconvenience, we didn't identify the patch emails from 
tip-bot2,
we'll ignore these emails to avoid ineffective work.

Best Regards,
Rong Chen
