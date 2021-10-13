Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9744F42B324
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbhJMDLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:11:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:13359 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237109AbhJMDLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:11:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="226107806"
X-IronPort-AV: E=Sophos;i="5.85,369,1624345200"; 
   d="scan'208";a="226107806"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 20:09:49 -0700
X-IronPort-AV: E=Sophos;i="5.85,369,1624345200"; 
   d="scan'208";a="491255283"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.172.110]) ([10.249.172.110])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 20:09:46 -0700
Subject: Re: [kbuild-all] Re: undefined reference to `memcg_bulk_charge_hook'
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <202110130513.t6y4KgaP-lkp@intel.com>
 <2a5a496b-5b5e-0039-5bb2-d04268215e37@infradead.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <8586cfc1-1d57-f9d9-e95a-b0c53b884471@intel.com>
Date:   Wed, 13 Oct 2021 11:09:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2a5a496b-5b5e-0039-5bb2-d04268215e37@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2021 5:55 AM, Randy Dunlap wrote:
> On 10/12/21 2:34 PM, kernel test robot wrote:
>> tree:   
>> https://github.com/0day-ci/linux/commits/UPDATE-20211012-182031/Vasily-Averin/memcg-enable-memory-accounting-in-__alloc_pages_bulk/20211008-172703 
>>
>> head:   e10c5e64a0799c75d26d2a82c03f757335616711
>> commit: e10c5e64a0799c75d26d2a82c03f757335616711 memcg: enable memory 
>> accounting in __alloc_pages_bulk
>> date:   11 hours ago
>> config: powerpc64-randconfig-r001-20211012 (attached as .config)
>> compiler: powerpc-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # 
>> https://github.com/0day-ci/linux/commit/e10c5e64a0799c75d26d2a82c03f757335616711 
>>
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review 
>> UPDATE-20211012-182031/Vasily-Averin/memcg-enable-memory-accounting-in-__alloc_pages_bulk/20211008-172703 
>>
>>          git checkout e10c5e64a0799c75d26d2a82c03f757335616711
>>          # save the attached .config to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 
>> make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> Hi ktr/lkp,
> 
> Can you explain why the (previously) attached .config file says:
> CONFIG_32BIT=y
> 
> but in the email text above, it says:
> config: powerpc64-randconfig-r001-20211012
> 
> I would expect a powerpc64 randconfig to say
> CONFIG_64BIT=y
> 
> Am I just confused?

Hi Randy,

Sorry for the trouble, the name of randconfig here is wrong,
it didn't set CONFIG_64BIT=y, it should be powerpc-randconfig-r001-xxx


> 
> Also, using (Arnd's) crosstools, the compiler for powerpc64 shows up
> as powerpc64-linux-ld, not as powerpc-linux-ld.
> Is that different for the 0day toolchains?

we'll check CONFIG_64BIT to choose the proper toolchain in reproduce 
script 
"https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross"

Best Regards,
Rong Chen


> (not AFAICT)
> 
> 
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     powerpc-linux-ld: mm/page_alloc.o: in function `__alloc_pages_bulk':
>>>> (.text+0x857c): undefined reference to `memcg_bulk_charge_hook'
>>>> powerpc-linux-ld: (.text+0x86d0): undefined reference to 
>>>> `memcg_bulk_post_charge_hook'
>>     powerpc-linux-ld: (.text+0x870c): undefined reference to 
>> `memcg_bulk_post_charge_hook'
>>>> powerpc-linux-ld: (.text+0x87c8): undefined reference to 
>>>> `memcg_bulk_pre_charge_hook'
>>
>> ---
> 
> thanks.
