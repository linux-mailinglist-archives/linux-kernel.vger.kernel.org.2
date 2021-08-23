Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04FD3F4739
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbhHWJQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:16:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:47130 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235828AbhHWJQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:16:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="196640763"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="196640763"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 02:16:09 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="525863669"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.29.47]) ([10.255.29.47])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 02:16:07 -0700
Subject: Re: [kbuild-all] Re: [peterz-queue:sched/core 8/11]
 include/linux/sched.h:1722:57: warning: unused parameter 'dst'
To:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     Will Deacon <will@kernel.org>, clang-built-linux@googlegroups.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Valentin Schneider <Valentin.Schneider@arm.com>
References: <202108210940.aD3d42zA-lkp@intel.com>
 <YSNkCAyMU0tJoedT@hirez.programming.kicks-ass.net>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <428f3e9a-a8d3-51ca-5e2e-caa50b8da3eb@intel.com>
Date:   Mon, 23 Aug 2021 17:16:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YSNkCAyMU0tJoedT@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/2021 5:02 PM, Peter Zijlstra wrote:
> On Sat, Aug 21, 2021 at 09:20:50AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
>> head:   234b8ab6476c5edd5262e2ff563de9498d60044a
>> commit: b90ca8badbd11488e5f762346b028666808164e7 [8/11] sched: Introduce task_struct::user_cpus_ptr to track requested affinity
>> config: i386-randconfig-a016-20210820 (attached as .config)
>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d9c5613e856cf2addfbf892fc4c1ce9ef9feceaa)
>> reproduce (this is a W=1 build):
> 
> Dear 0day folks; could you please blacklist me for all W=1 build output?
> I'm 100% not interested in random compiler generated garbage.

Hi Peterz,

Got it, we'll do that for you asap.

Best Regards,
Rong Chen

