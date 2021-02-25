Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7B0324BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 09:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbhBYIS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 03:18:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:26860 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235739AbhBYISr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 03:18:47 -0500
IronPort-SDR: feNucJ/1n4kY63abF+c6uyGSYvXQnQFuqWoCg9rvgqC+9bhDqdTV1yZE265jhgdS4uqrqyJ5ao
 /GQA+e4S/uTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="185569616"
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="185569616"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 00:18:02 -0800
IronPort-SDR: wYFR47Rc3qOJ0krqea5Xw9mhoQawZEH8UCoRB3wZb4KCWUIzlsh6zaIT7GS7HHagHN9ON98jdZ
 TRfUQ5unDvqQ==
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="404159242"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 00:17:59 -0800
Subject: Re: [kbuild-all] Re: WARNING: modpost: vmlinux.o(.text+0x1a8edb8):
 Section mismatch in reference from the function stop_machine() to the
 function .init.text:intel_rng_hw_init()
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <202102242224.Cpiog92Y-lkp@intel.com>
 <83ab58cb-581f-135f-21fd-05c15860cafa@suse.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <a7013b23-af0b-e1dd-324c-904a536d9f01@intel.com>
Date:   Thu, 25 Feb 2021 16:17:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <83ab58cb-581f-135f-21fd-05c15860cafa@suse.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/21 10:26 PM, Jürgen Groß wrote:
> On 24.02.21 15:20, kernel test robot wrote:
>> tree: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
>> master
>> head:   c03c21ba6f4e95e406a1a7b4c34ef334b977c194
>> commit: ab234a260b1f625b26cbefa93ca365b0ae66df33 x86/pv: Rework 
>> arch_local_irq_restore() to not use popf
>> date:   2 weeks ago
>> config: x86_64-randconfig-a005-20210223 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 
>> f14a14dd2564703db02f80c00db8ae492b594f77)
>> reproduce (this is a W=1 build):
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install x86_64 cross compiling tool for clang build
>>          # apt-get install binutils-x86-64-linux-gnu
>>          # 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ab234a260b1f625b26cbefa93ca365b0ae66df33
>>          git remote add linus 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout ab234a260b1f625b26cbefa93ca365b0ae66df33
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 
>> ARCH=x86_64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>>
>>>> WARNING: modpost: vmlinux.o(.text+0x1a8edb8): Section mismatch in 
>>>> reference from the function stop_machine() to the function 
>>>> .init.text:intel_rng_hw_init()
>> The function stop_machine() references
>> the function __init intel_rng_hw_init().
>> This is often because stop_machine lacks a __init
>> annotation or the annotation of intel_rng_hw_init is wrong.
>
> I'd be very interested to know how the identified patch would be able to
> have this effect.

Hi Clang Team,

The problem is found by the latest clang, and I can't reproduce it with 
clang-11,
could you take a look?

Best Regards,
Rong Chen
