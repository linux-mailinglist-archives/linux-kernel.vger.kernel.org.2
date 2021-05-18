Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B23A387801
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhERLtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:49:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:34813 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233617AbhERLto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:49:44 -0400
IronPort-SDR: THgekq6ZtxNJd7dC9IqNn4hB9XeCHmsxR8km6G/mG6uINGf+oDWh9+sD7cuHUkDCtOl0TCH43d
 obuElvq4fFWA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="187816156"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="187816156"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 04:48:22 -0700
IronPort-SDR: +9WTz8d5TUPpUNd+pB2kJe2b2eGHoMNLpYmwSs4Ju+5jwsUylg+24j993HmiqsMbgAfIivuw/o
 z5LQyeb0FGJQ==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="472913735"
Received: from pqiu-mobl1.ccr.corp.intel.com (HELO [10.255.30.136]) ([10.255.30.136])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 04:48:20 -0700
Subject: Re: [kbuild-all] Re: arch/csky/mm/tcm.c:14:2: error: #error "You
 should define DTCM_RAM_BASE"
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202105150718.cdDLUzFD-lkp@intel.com>
 <a386406d-40fd-d382-b272-e524f046ca71@infradead.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <66d3ff0d-ae3a-dbd7-1ac0-ddffd9c023d8@intel.com>
Date:   Tue, 18 May 2021 19:48:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a386406d-40fd-d382-b272-e524f046ca71@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 5/15/2021 7:22 AM, Randy Dunlap wrote:
> On 5/14/21 4:08 PM, kernel test robot wrote:
>> Hi Guo,
>>
>> First bad commit (maybe != root cause):
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   25a1298726e97b9d25379986f5d54d9e62ad6e93
>> commit: 18c07d23da5a48525b2955aa269b8bb108c19300 csky: Fixup calltrace panic
>> date:   1 year ago
>> config: csky-randconfig-r036-20210515 (attached as .config)
>> compiler: csky-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=18c07d23da5a48525b2955aa269b8bb108c19300
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 18c07d23da5a48525b2955aa269b8bb108c19300
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=csky
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> arch/csky/mm/tcm.c:14:2: error: #error "You should define DTCM_RAM_BASE"
>>        14 | #error "You should define DTCM_RAM_BASE"
>>           |  ^~~~~
>>     arch/csky/mm/tcm.c:109:7: warning: no previous prototype for 'tcm_alloc' [-Wmissing-prototypes]
>>       109 | void *tcm_alloc(size_t len)
>>           |       ^~~~~~~~~
>>     arch/csky/mm/tcm.c:124:6: warning: no previous prototype for 'tcm_free' [-Wmissing-prototypes]
>>       124 | void tcm_free(void *addr, size_t len)
>>           |      ^~~~~~~~
>>
>>
>> vim +14 arch/csky/mm/tcm.c
>>
>> f525bb2c9e7cf1 Guo Ren 2019-11-27  11
>> f525bb2c9e7cf1 Guo Ren 2019-11-27  12  #ifdef CONFIG_HAVE_DTCM
>> f525bb2c9e7cf1 Guo Ren 2019-11-27  13  #if (CONFIG_DTCM_RAM_BASE == 0xffffffff)
>> f525bb2c9e7cf1 Guo Ren 2019-11-27 @14  #error "You should define DTCM_RAM_BASE"
>> f525bb2c9e7cf1 Guo Ren 2019-11-27  15  #endif
>> f525bb2c9e7cf1 Guo Ren 2019-11-27  16
> 
> 
> I.e., the person or bot that is running the kernel configurator should
> set/define the Kconfig symbol CONFIG_DTCM_RAM_BASE.
> 
> Please do so in your scripts.

Thanks for the advice, we have added it in the script.

Best Regards,
Rong Chen


> Thanks.
> 
>> :::::: The code at line 14 was first introduced by commit
>> :::::: f525bb2c9e7cf1e3c43ab57704c9e1c836d30b34 csky: Tightly-Coupled Memory or Sram support
>>
>> :::::: TO: Guo Ren <guoren@linux.alibaba.com>
>> :::::: CC: Guo Ren <guoren@linux.alibaba.com>
> 
> 
> 
