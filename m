Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32704359832
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhDIIpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:45:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:18613 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbhDIIpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:45:32 -0400
IronPort-SDR: PytMN4Xfb3KgChlSpjjzwyV8Y9Y7TVTb++8OvTQ375E2XmYbqEEEAbyzYdv3bC/BjssUYurEF4
 AoEuJM2/HHMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="190520421"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="190520421"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 01:45:19 -0700
IronPort-SDR: 06iTqg+iOZC09Uez8Mh4BaFQY8i7mwJkA0OhhbY6gSLjTEeQ8tPaGiIaTfDQkbVK0SZonbaH0X
 Y7xzZA4KqXQg==
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="422643273"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 01:45:16 -0700
Subject: Re: [kbuild-all] Re: [PATCH] mm: gup: remove FOLL_SPLIT
To:     John Hubbard <jhubbard@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210329193828.179993-1-shy828301@gmail.com>
 <202103301403.u00aVRF6-lkp@intel.com>
 <ffa96851-ce93-12b4-70ca-594f00fa3c2b@nvidia.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <6236d7d0-7e81-c88a-e019-12707e574274@intel.com>
Date:   Fri, 9 Apr 2021 16:44:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ffa96851-ce93-12b4-70ca-594f00fa3c2b@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 3/30/21 3:08 PM, John Hubbard wrote:
> On 3/29/21 11:24 PM, kernel test robot wrote:
>> Hi Yang,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on hnaz-linux-mm/master]
>>
>> url: 
>> https://github.com/0day-ci/linux/commits/Yang-Shi/mm-gup-remove-FOLL_SPLIT/20210330-034042
>> base:   https://github.com/hnaz/linux-mm master
>> config: s390-randconfig-r032-20210330 (attached as .config)
>> compiler: s390-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # 
>> https://github.com/0day-ci/linux/commit/c8563a636718f98af86a3965d94e25b8f2cf2354
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review 
>> Yang-Shi/mm-gup-remove-FOLL_SPLIT/20210330-034042
>>          git checkout c8563a636718f98af86a3965d94e25b8f2cf2354
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 
>> make.cross ARCH=s390
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     arch/s390/mm/gmap.c: In function 'thp_split_mm':
>>>> arch/s390/mm/gmap.c:2498:27: error: 'FOLL_SPLIT' undeclared (first 
>>>> use in this function); did you mean 'FOLL_PIN'?
>>      2498 |    follow_page(vma, addr, FOLL_SPLIT);
>>           |                           ^~~~~~~~~~
>>           |                           FOLL_PIN
>>     arch/s390/mm/gmap.c:2498:27: note: each undeclared identifier is 
>> reported only once for each function it appears in
>>
>>
>> vim +2498 arch/s390/mm/gmap.c
>
> There appears to be an imperfection in this 0day testing system, 
> because (just as the patch
> says), commit ba925fa35057a062ac98c3e8138b013ce4ce351c ("s390/gmap: 
> improve THP splitting"),
> July 29, 2020, removes the above use of FOLL_SPLIT.
>
> And "git grep", just to be sure, shows it is not there in today's 
> linux.git. So I guess the
> https://github.com/0day-ci/linux repo needs a better way to stay in sync?

Sorry for the delay, indeed, it's a issue from 0day-CI, we'll update 
linux-mm in the system.

Best Regards,
Rong Chen
