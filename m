Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35244408277
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 03:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbhIMBG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 21:06:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:25858 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233133AbhIMBG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 21:06:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10105"; a="285232247"
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="285232247"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2021 18:05:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="542830214"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2021 18:05:07 -0700
Subject: Re: [kbuild-all] Re: [peterz-queue:sched/core 8/11]
 include/linux/sched.h:1722:57: warning: unused parameter 'dst'
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, Will Deacon <will@kernel.org>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <Valentin.Schneider@arm.com>
References: <202108210940.aD3d42zA-lkp@intel.com>
 <YSNkCAyMU0tJoedT@hirez.programming.kicks-ass.net>
 <428f3e9a-a8d3-51ca-5e2e-caa50b8da3eb@intel.com>
 <20210911122419.GY4323@worktop.programming.kicks-ass.net>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <8293b6b6-60a3-a0cf-834e-906b24e578a9@intel.com>
Date:   Mon, 13 Sep 2021 09:05:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210911122419.GY4323@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/21 8:24 PM, Peter Zijlstra wrote:
> On Mon, Aug 23, 2021 at 05:16:05PM +0800, Chen, Rong A wrote:
>>
>> On 8/23/2021 5:02 PM, Peter Zijlstra wrote:
>>> On Sat, Aug 21, 2021 at 09:20:50AM +0800, kernel test robot wrote:
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
>>>> head:   234b8ab6476c5edd5262e2ff563de9498d60044a
>>>> commit: b90ca8badbd11488e5f762346b028666808164e7 [8/11] sched: Introduce task_struct::user_cpus_ptr to track requested affinity
>>>> config: i386-randconfig-a016-20210820 (attached as .config)
>>>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d9c5613e856cf2addfbf892fc4c1ce9ef9feceaa)
>>>> reproduce (this is a W=1 build):
>>> Dear 0day folks; could you please blacklist me for all W=1 build output?
>>> I'm 100% not interested in random compiler generated garbage.
>> Hi Peterz,
>>
>> Got it, we'll do that for you asap.
> Rong, I seem to still be getting W=1 build warnings spam. Could you
> pleaes have a look?

Hi Peterz,

Sorry about that, do you mean we shouldn't test with W=1 for your repo?

Best Regards,
Rong Chen
