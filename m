Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8A542BB0C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbhJMJEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:04:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13734 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbhJMJEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:04:46 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HTmjF0TGGzVfmC;
        Wed, 13 Oct 2021 17:01:05 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 17:02:42 +0800
Received: from [10.67.102.169] (10.67.102.169) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 13 Oct 2021 17:02:42 +0800
CC:     <yangyicong@hisilicon.com>, <llvm@lists.linux.dev>,
        <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Barry Song <baohua@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [tip:sched/core 45/47] kernel/sched/topology.c:23:20: error:
 unused function 'sched_debug'
To:     kernel test robot <lkp@intel.com>
References: <202110130209.1XL2cTpW-lkp@intel.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <0538ccac-19eb-a184-6aef-1d11eefbae17@hisilicon.com>
Date:   Wed, 13 Oct 2021 17:02:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <202110130209.1XL2cTpW-lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/10/13 2:30, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> head:   b2d5b9cec60fecc72a13191c2c6c05acf60975a5
> commit: f43df9225fcad9b07a4ef4d0fe4c3ad2fb4ce82d [45/47] sched/topology: Remove unused numa_distance in cpu_attach_domain()
> config: hexagon-buildonly-randconfig-r004-20211012 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c3dcf39554dbea780d6cb7e12239451ba47a2668)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=f43df9225fcad9b07a4ef4d0fe4c3ad2fb4ce82d
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip sched/core
>         git checkout f43df9225fcad9b07a4ef4d0fe4c3ad2fb4ce82d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=hexagon 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> kernel/sched/topology.c:23:20: error: unused function 'sched_debug' [-Werror,-Wunused-function]
>    static inline bool sched_debug(void)
>                       ^
>    1 error generated.
> 

sched_debug() is unused if CONFIG_ENERGY_MODEL=n || CONFIG_CPU_FREQ_GOV_SCHEDUTIL=n and CONFIG_NUMA=n,
which is the case in the report. This is not introduced by this patch.

A __maybe_unused qualify for sched_debug() may fix this. Not sure we intends to do so.

> 
> vim +/sched_debug +23 kernel/sched/topology.c
> 
> f2cb13609d5397 Ingo Molnar    2017-02-01  22  
> f2cb13609d5397 Ingo Molnar    2017-02-01 @23  static inline bool sched_debug(void)
> f2cb13609d5397 Ingo Molnar    2017-02-01  24  {
> 9406415f46f612 Peter Zijlstra 2021-04-15  25  	return sched_debug_verbose;
> f2cb13609d5397 Ingo Molnar    2017-02-01  26  }
> f2cb13609d5397 Ingo Molnar    2017-02-01  27  
> 
> :::::: The code at line 23 was first introduced by commit
> :::::: f2cb13609d5397cdd747f3ed6fb651233851717d sched/topology: Split out scheduler topology code from core.c into topology.c
> 
> :::::: TO: Ingo Molnar <mingo@kernel.org>
> :::::: CC: Ingo Molnar <mingo@kernel.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
