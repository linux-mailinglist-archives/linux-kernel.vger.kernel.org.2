Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5F93E12A3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbhHEK2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:28:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:40531 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234785AbhHEK2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:28:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="212263377"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="212263377"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 03:28:30 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="512635500"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.31.111]) ([10.255.31.111])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 03:28:28 -0700
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
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <176ab0a5-72dd-dc24-be64-6919cffba9ed@intel.com>
Date:   Thu, 5 Aug 2021 18:28:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c3e9247d-95cd-718c-d8a5-f0cd5e5a3598@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/2021 11:10 AM, Randy Dunlap wrote:
> On 7/30/21 1:29 AM, kernel test robot wrote:
>> tree:   
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   764a5bc89b12b82c18ce7ca5d7c1b10dd748a440
>> commit: cf536e185869d4815d506e777bcca6edd9966a6e Makefile: extend 32B 
>> aligned debug option to 64B aligned
>> date:   10 weeks ago
>> config: powerpc64-randconfig-c023-20210730 (attached as .config)
>> compiler: powerpc-linux-gcc (GCC) 10.3.0
>> reproduce (this is a W=1 build):
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cf536e185869d4815d506e777bcca6edd9966a6e 
>>
>>          git remote add linus 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout cf536e185869d4815d506e777bcca6edd9966a6e
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 
>> make.cross ARCH=powerpc64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> make[2]: *** [arch/powerpc/Makefile.postlink:31: vmlinux] Error 1
>>
>> ---
> 
> Hi ktr/lkp,
> 
> This is not "All errors". I suggest that you improve your output by
> (also) grepping for "ERROR:", so that the following lines would be
> included here:
> 
> ERROR: start_text address is c000000000000200, should be c000000000000100
> ERROR: try to enable LD_HEAD_STUB_CATCH config option
> ERROR: see comments in arch/powerpc/tools/head_check.sh

Hi Randy,

Thanks for the advice, the "ERROR:" lines weren't redirected to stderr, 
so the bot didn't notice them, it looks difficult to change the output.

Best Regards,
Rong Chen

> 
> 
> and yes, enabling LD_HEAD_STUB_CATCH does fix this build error.
> 
> thanks.
