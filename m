Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B501640F89E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 15:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344506AbhIQNBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 09:01:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:14574 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243653AbhIQNBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:01:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="209883032"
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="209883032"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 05:58:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="546363552"
Received: from mylly.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Sep 2021 05:58:54 -0700
Subject: Re: [iio:testing 40/43] ld.lld: error: undefined symbol: __udivdi3
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
References: <202109120656.fiJqCh8H-lkp@intel.com>
 <20210914134103.00006d23@Huawei.com> <YUCpDDkNSqhlaThq@shinobu>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <6fade104-0f00-3ebf-827c-8f6d830d4ac5@linux.intel.com>
Date:   Fri, 17 Sep 2021 15:58:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUCpDDkNSqhlaThq@shinobu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/21 4:52 PM, William Breathitt Gray wrote:
> On Tue, Sep 14, 2021 at 01:41:03PM +0100, Jonathan Cameron wrote:
>> On Sun, 12 Sep 2021 06:43:58 +0800
>> kernel test robot <lkp@intel.com> wrote:
>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
>>> head:   77a4a019161bcba51af1dbbeadc04795840fb3e0
>>> commit: f7da4339ca510e4476ea35cb9fd44f3f190706c5 [40/43] counter: Internalize sysfs interface code
>>> config: i386-randconfig-r022-20210911 (attached as .config)
>>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 261cbe98c38f8c1ee1a482fe76511110e790f58a)
>>> reproduce (this is a W=1 build):
>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=f7da4339ca510e4476ea35cb9fd44f3f190706c5
>>>          git remote add iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>>>          git fetch --no-tags iio testing
>>>          git checkout f7da4339ca510e4476ea35cb9fd44f3f190706c5
>>>          # save the attached .config to linux build tree
>>>          mkdir build_dir
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=i386 SHELL=/bin/bash
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>>> ld.lld: error: undefined symbol: __udivdi3
>>>     >>> referenced by intel-qep.c:290 (drivers/counter/intel-qep.c:290)
>>>     >>>               counter/intel-qep.o:(intel_qep_spike_filter_ns_write) in archive drivers/built-in.a
>> This is a result of a change to passing in a u64 instead of a string.   I've applied a fix
>> that uses do_div() and pushed out as testing again.
>>
>> William, please sanity check that fix looks right to you.
>>
>> Thanks,
>>
>> Jonathan
> 
> Your do_div() change seems sane to me; would div_u64_rem() work here as
> well, or is do_div preferred because we're not using the remainder?
> 
> I'm CCing Jarkko Nikula as well to keep them in the loop.
> 
Yeah I believe do_div() is the right fix for the "counter: Internalize 
sysfs interface code" since the calculation remains the same.

I realized now the filter length has been rounded down. E.g. values 
20-29 from user space set 20 ns long filter in HW. Perhaps better would 
be to round up or to nearest but that goes to some future patch if needed.

Jarkko
