Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F6C331BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhCIAma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:42:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:8561 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230327AbhCIAm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:42:29 -0500
IronPort-SDR: inreQXQxrfk51/FIaMAX854dBKu1Aj2BnkmxL90ahy2g7Pn+0BUEVSr2DUQGZbbib7t85sPc/D
 rnBBzQCpcmLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="273158804"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="273158804"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 16:42:29 -0800
IronPort-SDR: StTEf6YiRf8FOCI3WurmyAfyK6jvUGJrlrIAvcdaKRUoGTowH8OTH+tNAMjKKGGnwp/2zbmIm7
 6VyEyWuzTKsA==
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="409512751"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 16:42:26 -0800
Subject: Re: [kbuild-all] Re: [PATCH v2] mm: page_alloc: dump migrate-failed
 pages
To:     Minchan Kim <minchan@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kbuild-all@01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <202103090555.LtLPf1Ho-lkp@intel.com> <YEalYUiTH45XO2EV@google.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <d994f666-7883-25a3-9d46-ca431874dc18@intel.com>
Date:   Tue, 9 Mar 2021 08:41:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <YEalYUiTH45XO2EV@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/21 6:29 AM, Minchan Kim wrote:
> On Tue, Mar 09, 2021 at 05:29:30AM +0800, kernel test robot wrote:
>> Hi Minchan,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on hnaz-linux-mm/master]
>>
>> url:    https://github.com/0day-ci/linux/commits/Minchan-Kim/mm-page_alloc-dump-migrate-failed-pages/20210309-042205
>> base:   https://github.com/hnaz/linux-mm master
>> config: m68k-allmodconfig (attached as .config)
>> compiler: m68k-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/0day-ci/linux/commit/3c635af37b862e9c601ee8d5818f7da9cd3e2e57
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review Minchan-Kim/mm-page_alloc-dump-migrate-failed-pages/20210309-042205
>>          git checkout 3c635af37b862e9c601ee8d5818f7da9cd3e2e57
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     arch/m68k/include/asm/page_mm.h:169:49: warning: ordered comparison of pointer with null pointer [-Wextra]
>>       169 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
>>           |                                                 ^~
>>     include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
>>        78 | # define unlikely(x) __builtin_expect(!!(x), 0)
>>           |                                          ^
>>     include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
>>       143 |  BUG_ON(!virt_addr_valid(buf));
>>           |  ^~~~~~
>>     include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
>>       143 |  BUG_ON(!virt_addr_valid(buf));
>>           |          ^~~~~~~~~~~~~~~
>>     In file included from arch/m68k/include/asm/page.h:60,
>>                      from arch/m68k/include/asm/thread_info.h:6,
>>                      from include/linux/thread_info.h:38,
>>                      from include/asm-generic/preempt.h:5,
>>                      from ./arch/m68k/include/generated/asm/preempt.h:1,
>>                      from include/linux/preempt.h:78,
>>                      from include/linux/spinlock.h:51,
>>                      from include/linux/mmzone.h:8,
>>                      from include/linux/gfp.h:6,
>>                      from include/linux/mm.h:10,
>>                      from mm/page_alloc.c:19:
> I am not sure this is triggered by the patch since I could see the
> warn with reverting the patch.

Hi Minchan,

Only the lines prefixed by ">>" are related with the patch:

>> mm/page_alloc.c:8348:5: warning: no previous prototype for 'alloc_contig_ratelimit' [-Wmissing-prototypes]

     8348 | int alloc_contig_ratelimit(void)
          |     ^~~~~~~~~~~~~~~~~~~~~~

>> mm/page_alloc.c:8353:6: warning: no previous prototype for 'dump_migrate_failure_pages' [-Wmissing-prototypes]

     8353 | void dump_migrate_failure_pages(struct list_head *page_list)



Best Regards,
Rong Chen
