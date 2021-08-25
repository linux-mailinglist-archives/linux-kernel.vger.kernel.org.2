Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620993F7147
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 10:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239407AbhHYItZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 04:49:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:15322 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239005AbhHYItN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 04:49:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="217486201"
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="scan'208";a="217486201"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 01:48:27 -0700
X-IronPort-AV: E=Sophos;i="5.84,350,1620716400"; 
   d="scan'208";a="527134143"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 01:48:25 -0700
Subject: Re: [kbuild-all] Re: arch/powerpc/kernel/signal_32.c:297:2: warning:
 Value stored to 'msr' is never read [clang-analyzer-deadcode.DeadStores]
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        kernel test robot <lkp@intel.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <202108231827.N9VUIKbD-lkp@intel.com>
 <3db8de6e-a971-be9f-19eb-e7d95faf2870@csgroup.eu>
 <7955eec5-c1d7-e0d7-280a-138d96b2daa9@intel.com>
 <79754a11-fa14-756a-fc30-5cb139a286b6@csgroup.eu>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <6e7edeb5-07fc-fedc-7f9c-0e2eb23e22bb@intel.com>
Date:   Wed, 25 Aug 2021 16:48:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <79754a11-fa14-756a-fc30-5cb139a286b6@csgroup.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/21 3:29 PM, Christophe Leroy wrote:
>
>
> Le 24/08/2021 à 08:59, Chen, Rong A a écrit :
>>
>>
>> On 8/23/2021 10:35 PM, Christophe Leroy wrote:
>>>
>>>
>>> Le 23/08/2021 à 12:59, kernel test robot a écrit :
>>>> tree: 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
>>>> master
>>>> head:   e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93
>>>> commit: ef75e73182949a94bde169a774de1b62ae21fbbc powerpc/signal32: 
>>>> Transform save_user_regs() and save_tm_user_regs() in 'unsafe' version
>>>> date:   9 months ago
>>>> config: powerpc-randconfig-c003-20210821 (attached as .config)
>>>> compiler: clang version 14.0.0 
>>>> (https://github.com/llvm/llvm-project 
>>>> d9c5613e856cf2addfbf892fc4c1ce9ef9feceaa)
>>>> reproduce (this is a W=1 build):
>>>>          wget 
>>>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>>>> -O ~/bin/make.cross
>>>>          chmod +x ~/bin/make.cross
>>>>          # install powerpc cross compiling tool for clang build
>>>>          # apt-get install binutils-powerpc-linux-gnu
>>>>          # 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef75e73182949a94bde169a774de1b62ae21fbbc 
>>>>
>>>>          git remote add linus 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>          git fetch --no-tags linus master
>>>>          git checkout ef75e73182949a94bde169a774de1b62ae21fbbc
>>>>          # save the attached .config to linux build tree
>>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 
>>>> ARCH=powerpc clang-analyzer
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>>
>>>> clang-analyzer warnings: (new ones prefixed by >>)
>>>>             ^
>>>>>> arch/powerpc/kernel/signal_32.c:297:2: warning: Value stored to 
>>>>>> 'msr' is never read [clang-analyzer-deadcode.DeadStores]
>>>>             msr &= ~MSR_VSX;
>>>>             ^      ~~~~~~~~
>>>>     arch/powerpc/kernel/signal_32.c:297:2: note: Value stored to 
>>>> 'msr' is never read
>>>>             msr &= ~MSR_VSX;
>>>>             ^      ~~~~~~~~
>>>
>>>
>>> This is wrong.
>>>
>>> msr is used at line 326:
>>>
>>> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 
>>> 2020-08-18  326 unsafe_put_user(msr, &frame->mc_gregs[PT_MSR], failed);
>>
>> Hi Christophe,
>>
>> The usage is under CONFIG_VSX, the test config 
>> (powerpc-randconfig-c003-20210821) didn't enable it which triggered 
>> this warning.
>
>
> No no, the 'unsafe_put_user(msr, &frame->mc_gregs[PT_MSR], failed) ' 
> at line 326 is not under CONFIG_VSX as far as I can see.
>
>
> Christophe

Hi Christophe,

It's my fault, I didn't see it correctly, and I have no idea why 
clang-analyzer reported it as a issue,
we'll double check such warning next time.

Best Regards,
Rong Chen
