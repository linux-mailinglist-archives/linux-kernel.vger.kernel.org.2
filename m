Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C7F42A736
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 16:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbhJLOdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 10:33:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:19517 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237376AbhJLOdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:33:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="227118766"
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; 
   d="scan'208";a="227118766"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 07:31:06 -0700
X-IronPort-AV: E=Sophos;i="5.85,367,1624345200"; 
   d="scan'208";a="441253376"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.174.65]) ([10.249.174.65])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 07:31:03 -0700
Subject: Re: [kbuild-all] Re: [tip:sched/core 14/47]
 kernel/sched/fair.c:893:22: error: variable 'p' set but not used
To:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <202110121132.N2z9JrD0-lkp@intel.com>
 <YWVw/oVd5ztGZDAK@hirez.programming.kicks-ass.net>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <40d464a8-86b6-d4cf-6e3a-d0712ac351c3@intel.com>
Date:   Tue, 12 Oct 2021 22:31:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YWVw/oVd5ztGZDAK@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2021 7:26 PM, Peter Zijlstra wrote:
> On Tue, Oct 12, 2021 at 11:57:41AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
>> head:   b2d5b9cec60fecc72a13191c2c6c05acf60975a5
>> commit: 60f2415e19d3948641149ac6aca137a7be1d1952 [14/47] sched: Make schedstats helpers independent of fair sched class
>> config: hexagon-buildonly-randconfig-r002-20211012 (attached as .config)
>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c3dcf39554dbea780d6cb7e12239451ba47a2668)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=60f2415e19d3948641149ac6aca137a7be1d1952
>>          git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>>          git fetch --no-tags tip sched/core
>>          git checkout 60f2415e19d3948641149ac6aca137a7be1d1952
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=hexagon
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     kernel/sched/fair.c:860:28: error: variable 'stats' set but not used [-Werror,-Wunused-but-set-variable]
>>                     struct sched_statistics *stats;
>>                                              ^
>>     kernel/sched/fair.c:892:27: error: variable 'stats' set but not used [-Werror,-Wunused-but-set-variable]
>>             struct sched_statistics *stats;
>>                                      ^
>>>> kernel/sched/fair.c:893:22: error: variable 'p' set but not used [-Werror,-Wunused-but-set-variable]
>>             struct task_struct *p = NULL;
>>                                 ^
>>     kernel/sched/fair.c:910:22: error: variable 'p' set but not used [-Werror,-Wunused-but-set-variable]
>>             struct task_struct *p = NULL;
>>                                 ^
>>     kernel/sched/fair.c:909:27: error: variable 'stats' set but not used [-Werror,-Wunused-but-set-variable]
>>             struct sched_statistics *stats;
>>                                      ^
>>>> kernel/sched/fair.c:936:22: error: variable 'tsk' set but not used [-Werror,-Wunused-but-set-variable]
>>             struct task_struct *tsk = NULL;
>>                                 ^
>>     kernel/sched/fair.c:935:27: error: variable 'stats' set but not used [-Werror,-Wunused-but-set-variable]
>>             struct sched_statistics *stats;
>>                                      ^
>>     kernel/sched/fair.c:4451:28: error: variable 'stats' set but not used [-Werror,-Wunused-but-set-variable]
>>                     struct sched_statistics *stats;
>>                                              ^
>>     8 errors generated.
> 
> Again, I have absolutely no intention of fixing this. IMO this is the
> compiler being a total pain in the arse.
> 
> Please stop reporting this.

Hi Peterz,

Sorry for the noise, we'll ignore the unused-but-set-variable warning in
kernel/sched/ part. Is there any other issue should be ignored?

Best Regards,
Rong Chen
