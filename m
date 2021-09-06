Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3700F401A39
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 12:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbhIFK5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 06:57:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:32598 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231173AbhIFK53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 06:57:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10098"; a="216787933"
X-IronPort-AV: E=Sophos;i="5.85,272,1624345200"; 
   d="scan'208";a="216787933"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 03:56:24 -0700
X-IronPort-AV: E=Sophos;i="5.85,272,1624345200"; 
   d="scan'208";a="536833527"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.168.75]) ([10.249.168.75])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 03:56:23 -0700
Subject: Re: [kbuild-all] Re: ERROR: start_text address is c000000000000200,
 should be c000000000000100
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202109051525.iZrjm1vj-lkp@intel.com>
 <5de53d5c-f2c9-9aad-5981-76a6357b3e02@infradead.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <d8dc922d-ab3a-f4dc-c765-199e19d9f29f@intel.com>
Date:   Mon, 6 Sep 2021 18:56:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5de53d5c-f2c9-9aad-5981-76a6357b3e02@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/2021 2:13 AM, Randy Dunlap wrote:
> On 9/5/21 12:17 AM, kernel test robot wrote:
>> Hi Randy,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   49624efa65ac9889f4e7c7b2452b2e6ce42ba37d
>> commit: 47c258d71ebfc832a760a1dc6540cf3c33968023 powerpc/head_check: 
>> use stdout for error messages
>> date:   3 weeks ago
>> config: powerpc64-randconfig-s031-20210904 (attached as .config)
>> compiler: powerpc64-linux-gcc (GCC) 11.2.0
>> reproduce:
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.4-rc1-dirty
>>          # 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=47c258d71ebfc832a760a1dc6540cf3c33968023 
>>
>>          git remote add linus 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 47c258d71ebfc832a760a1dc6540cf3c33968023
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 
>> make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir 
>> ARCH=powerpc SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> ERROR: start_text address is c000000000000200, should be 
>>>> c000000000000100
>>>> ERROR: try to enable LD_HEAD_STUB_CATCH config option
>>>> ERROR: see comments in arch/powerpc/tools/head_check.sh
> 
> 
> Following those instructions fixes this build error for me.
> Can ktr/lkp do that?
> Otherwise just ignore this ERROR.
> 
> Set CONFIG_EXPERT=y
> and CONFIG_LD_HEAD_STUB_CATCH=y.
> 

Hi Randy,

Thanks for the explanation, We'll enable these configs.

Best Regards,
Rong Chen

> However, after doing that, I get these messages:
> 
> INFO: Uncompressed kernel (size 0x30ef664) overlaps the address of the 
> wrapper(0x400000)
> INFO: Fixing the link_address of wrapper to (0x3100000)
> 
