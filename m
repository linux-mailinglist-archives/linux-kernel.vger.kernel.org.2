Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0031345B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCWJk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:40:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:63227 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhCWJkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:40:23 -0400
IronPort-SDR: /JjHMBYucD1XrWhgzWxmAT5uTqRFLBtymehBuYg9UCqF946v19XPYV34+uSR6+NR+4trMClW9T
 oM9vy4gFSfuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="251797116"
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="251797116"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 02:40:23 -0700
IronPort-SDR: 7IYSh1KkvPQ38lizWBCrcSuM9u9zT+QMo90n/tY864He9kzN3KI1W4/HyTy7CvKw9Ny0wlGHOi
 NiA69FzBbE3g==
X-IronPort-AV: E=Sophos;i="5.81,271,1610438400"; 
   d="scan'208";a="414905499"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 02:40:22 -0700
Subject: Re: drivers/opp/of.c:959:12: warning: stack frame size of 1056 bytes
 in function '_of_add_table_indexed'
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <202103231522.N0bCxZ97-lkp@intel.com>
 <20210323072534.sif6hfei4zx5tzn3@vireshk-i7>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <38b9dd6b-c118-a46c-e5c2-ae2a5f871f57@intel.com>
Date:   Tue, 23 Mar 2021 17:39:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210323072534.sif6hfei4zx5tzn3@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/21 3:25 PM, Viresh Kumar wrote:
> On 23-03-21, 15:23, kernel test robot wrote:
>> Hi Viresh,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   84196390620ac0e5070ae36af84c137c6216a7dc
>> commit: 406e47652161d4f0d9bc4cd6237b36c51497ec75 opp: Create _of_add_table_indexed() to reduce code duplication
>> date:   7 weeks ago
>> config: powerpc64-randconfig-r023-20210323 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 14696baaf4c43fe53f738bc292bbe169eed93d5d)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install powerpc64 cross compiling tool for clang build
>>          # apt-get install binutils-powerpc64-linux-gnu
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=406e47652161d4f0d9bc4cd6237b36c51497ec75
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 406e47652161d4f0d9bc4cd6237b36c51497ec75
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/opp/of.c:959:12: warning: stack frame size of 1056 bytes in function '_of_add_table_indexed' [-Wframe-larger-than=]
>>     static int _of_add_table_indexed(struct device *dev, int index)
>>                ^
>>     1 warning generated.
> I have reported this on 1st march as well. Looks to be false positive.
>

Hi Viresh,

Thanks for the feedback, we'll stop the bot sending such report again.

Best Regards,
Rong Chen
