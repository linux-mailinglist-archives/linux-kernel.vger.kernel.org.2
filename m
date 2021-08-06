Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705453E2898
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245088AbhHFKa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:30:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:44299 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231794AbhHFKa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:30:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="194617524"
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="194617524"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 03:30:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="481427756"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.29.52]) ([10.255.29.52])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 03:30:39 -0700
Subject: Re: [kbuild-all] Re: make[2]: *** [arch/powerpc/Makefile.postlink:31:
 vmlinux] Error 1
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Feng Tang <feng.tang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202107301612.rQ29n76B-lkp@intel.com>
 <c3e9247d-95cd-718c-d8a5-f0cd5e5a3598@infradead.org>
 <176ab0a5-72dd-dc24-be64-6919cffba9ed@intel.com>
 <f0aa87df-89e2-05b0-52a0-c12236a1d778@infradead.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <4f38fd30-450e-b19e-f475-914fe0623d9d@intel.com>
Date:   Fri, 6 Aug 2021 18:30:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f0aa87df-89e2-05b0-52a0-c12236a1d778@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2021 3:25 AM, Randy Dunlap wrote:
> On 8/5/21 3:28 AM, Chen, Rong A wrote:
>>
>>
>> On 8/4/2021 11:10 AM, Randy Dunlap wrote:
>>> On 7/30/21 1:29 AM, kernel test robot wrote:
>>>> tree: 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
>>>> master
>>>> head:   764a5bc89b12b82c18ce7ca5d7c1b10dd748a440
>>>> commit: cf536e185869d4815d506e777bcca6edd9966a6e Makefile: extend 
>>>> 32B aligned debug option to 64B aligned
>>>> date:   10 weeks ago
>>>> config: powerpc64-randconfig-c023-20210730 (attached as .config)
>>>> compiler: powerpc-linux-gcc (GCC) 10.3.0
>>>> reproduce (this is a W=1 build):
>>>>          wget 
>>>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>>>> -O ~/bin/make.cross
>>>>          chmod +x ~/bin/make.cross
>>>>          # 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cf536e185869d4815d506e777bcca6edd9966a6e 
>>>>
>>>>          git remote add linus 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>          git fetch --no-tags linus master
>>>>          git checkout cf536e185869d4815d506e777bcca6edd9966a6e
>>>>          # save the attached .config to linux build tree
>>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 
>>>> make.cross ARCH=powerpc64
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>>> make[2]: *** [arch/powerpc/Makefile.postlink:31: vmlinux] Error 1
>>>>
>>>> ---
>>>
>>> Hi ktr/lkp,
>>>
>>> This is not "All errors". I suggest that you improve your output by
>>> (also) grepping for "ERROR:", so that the following lines would be
>>> included here:
>>>
>>> ERROR: start_text address is c000000000000200, should be 
>>> c000000000000100
>>> ERROR: try to enable LD_HEAD_STUB_CATCH config option
>>> ERROR: see comments in arch/powerpc/tools/head_check.sh
>>
>> Hi Randy,
>>
>> Thanks for the advice, the "ERROR:" lines weren't redirected to 
>> stderr, so the bot didn't notice them, it looks difficult to change 
>> the output.
> 
> Hi Rong,
> 
> So 0day bot only checks stderr for errors?

yes, as far as it goes.

Best Regards,
Rong Chen

> That is almost reasonable (IMO).
> 
> Michael, in the file arch/powerpc/tools/head_check.sh,
> what do you think about redirecting all of the ERROR: lines
> to stdout (echo "..." >&2)?
> 
> 
>> Best Regards,
>> Rong Chen
>>
>>>
>>>
>>> and yes, enabling LD_HEAD_STUB_CATCH does fix this build error.
> 
> 
> 
>>> thanks.
> 
