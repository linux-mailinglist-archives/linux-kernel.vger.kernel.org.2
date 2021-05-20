Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D3D38A0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 11:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhETJ0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:26:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:25217 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231584AbhETJ0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:26:08 -0400
IronPort-SDR: BO7oiCpGKPd8EftbGf1nzw2d913hBUSrm5WredVIWezmcJOfx5QLIwU/OYsDpbfT71VMEA4BD1
 yI8AJMYGOeBA==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="265097263"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="265097263"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 02:24:47 -0700
IronPort-SDR: Etc2GQhGchnN4xp520cc+mOggfx1lrYzlgf8MeQUXDsE3UTJWlffOSk0/xhVgGmCOcy0XuK90R
 myMCRHwWbJOw==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="473923820"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 02:24:45 -0700
Subject: Re: [kbuild-all] Re: kernel/sched/fair.c:9551:12: warning: stack
 frame size of 1376 bytes in function 'load_balance'
To:     Arnd Bergmann <arnd@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <202105112356.JuDlybKz-lkp@intel.com>
 <CAKfTPtB9B9jv_uSk0fS7uOTtH5FCwLcAOrPjtXzRuURLUMFnoA@mail.gmail.com>
 <CAK8P3a0YVh=hoBthjH7N=mSXOi0fEdwvyuHUJ36qricqVUZ9jA@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <cae151a3-7d88-a1fd-4d34-d599238f6a4e@intel.com>
Date:   Thu, 20 May 2021 17:23:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0YVh=hoBthjH7N=mSXOi0fEdwvyuHUJ36qricqVUZ9jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/21 8:32 PM, Arnd Bergmann wrote:
> On Mon, May 17, 2021 at 3:45 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>> On Tue, 11 May 2021 at 18:01, kernel test robot <lkp@intel.com> wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   1140ab592e2ebf8153d2b322604031a8868ce7a5
>>> commit: 0826530de3cbdc89e60a89e86def94a5f0fc81ca sched/fair: Remove update of blocked load from newidle_balance
>>> date:   9 weeks ago
>>> config: mips-randconfig-r022-20210511 (attached as .config)
>>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project a0fed635fe1701470062495a6ffee1c608f3f1bc)
>>> reproduce (this is a W=1 build):
>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          # install mips cross compiling tool for clang build
>>>          # apt-get install binutils-mips-linux-gnu
>>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0826530de3cbdc89e60a89e86def94a5f0fc81ca
>>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>          git fetch --no-tags linus master
>>>          git checkout 0826530de3cbdc89e60a89e86def94a5f0fc81ca
>>>          # save the attached .config to linux build tree
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=mips
>> It was a bit difficult to find the warning among the thousand
> I opened an issue against clang about it:
>
> See https://github.com/ClangBuiltLinux/linux/issues/1379

Hi Arnd,

We have disabled CONFIG_UBSAN_ALIGNMENT for mips/clang in our kconfigs
according to the comments in the above link.

Best Regards,
Rong Chen

>
> but then found that this is already known. I think it would be best to
> make the kernel test robot
> set CONFIG_COMPILE_TEST to avoid issues like this. I have annotated a
> number of symbols
> that are known to cause unnecessary false positives in a similar way
> to get a clean build.
>
>          Arnd
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

