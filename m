Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FFC39D878
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhFGJUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:20:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:38443 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhFGJUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:20:30 -0400
IronPort-SDR: R1ohEh9FHQiiIhqRVwWOc0DQTpJji7sWg7Q46+OZRk6mSWivdBk0xh87ooKfOAzdx5FhgiZata
 y4LHjNYhX6lw==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="290215873"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="290215873"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 02:18:39 -0700
IronPort-SDR: RAcDO5vQXfQ/TNZWTcCgXV2g/0YpbchXU6OonEikw158rL8bza6AfDIol0xJYHKSWahThplg3W
 bm7sIYunpmzg==
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="447421534"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 02:18:37 -0700
Subject: Re: [kbuild-all] Re: kernel/rcu/tree.c:2073:23: warning: stack frame
 size of 2704 bytes in function 'rcu_gp_kthread'
To:     paulmck@kernel.org, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <202106061253.0X2QKyyI-lkp@intel.com>
 <20210606044926.GJ4397@paulmck-ThinkPad-P17-Gen-1>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <4696fe3d-a7ad-acae-686e-6295ca327737@intel.com>
Date:   Mon, 7 Jun 2021 17:18:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210606044926.GJ4397@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/21 12:49 PM, Paul E. McKenney wrote:
> On Sun, Jun 06, 2021 at 12:19:57PM +0800, kernel test robot wrote:
>> Hi Paul,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   f5b6eb1e018203913dfefcf6fa988649ad11ad6e
>> commit: 7dffe01765d9309b8bd5505503933ec0ec53d192 rcu: Add lockdep_assert_irqs_disabled() to raw_spin_unlock_rcu_node() macros
>> date:   5 months ago
>> config: powerpc-randconfig-r023-20210606 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 551a697c5cf33275b66add4fc467fcf59084cffb)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install powerpc cross compiling tool for clang build
>>          # apt-get install binutils-powerpc-linux-gnu
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7dffe01765d9309b8bd5505503933ec0ec53d192
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 7dffe01765d9309b8bd5505503933ec0ec53d192
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     In file included from kernel/rcu/tree.c:21:
>>     In file included from include/linux/kernel.h:12:
>>     In file included from include/linux/bitops.h:29:
>>     In file included from arch/powerpc/include/asm/bitops.h:62:
>>     arch/powerpc/include/asm/barrier.h:49:9: warning: '__lwsync' macro redefined [-Wmacro-redefined]
>>     #define __lwsync()      __asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
>>             ^
>>     <built-in>:310:9: note: previous definition is here
>>     #define __lwsync __builtin_ppc_lwsync
>>             ^
>>>> kernel/rcu/tree.c:2073:23: warning: stack frame size of 2704 bytes in function 'rcu_gp_kthread' [-Wframe-larger-than=]
>>     static int __noreturn rcu_gp_kthread(void *unused)
> Does -rcu commit 2f20de99a63b ("rcu: Make rcu_gp_cleanup() be noinline
> for tracing") help?

Hi Paul,

The stack frame size decreased to 2256 bytes:

   kernel/rcu/tree.c:2129:23: warning: stack frame size of 2256 bytes in 
function 'rcu_gp_kthread' [-Wframe-larger-than=]

Best Regards,
Rong Chen
