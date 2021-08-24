Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150BF3F5904
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhHXHaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:30:18 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:39145 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233436AbhHXHaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:30:15 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Gv12c3qTnz9sVf;
        Tue, 24 Aug 2021 09:29:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3ozNqScM8a44; Tue, 24 Aug 2021 09:29:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Gv12c2q8Xz9sTx;
        Tue, 24 Aug 2021 09:29:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B4F38B7DA;
        Tue, 24 Aug 2021 09:29:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ezv-owZ2jHMc; Tue, 24 Aug 2021 09:29:28 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C88178B7D1;
        Tue, 24 Aug 2021 09:29:27 +0200 (CEST)
Subject: Re: [kbuild-all] Re: arch/powerpc/kernel/signal_32.c:297:2: warning:
 Value stored to 'msr' is never read [clang-analyzer-deadcode.DeadStores]
To:     "Chen, Rong A" <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <202108231827.N9VUIKbD-lkp@intel.com>
 <3db8de6e-a971-be9f-19eb-e7d95faf2870@csgroup.eu>
 <7955eec5-c1d7-e0d7-280a-138d96b2daa9@intel.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <79754a11-fa14-756a-fc30-5cb139a286b6@csgroup.eu>
Date:   Tue, 24 Aug 2021 09:29:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7955eec5-c1d7-e0d7-280a-138d96b2daa9@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/08/2021 à 08:59, Chen, Rong A a écrit :
> 
> 
> On 8/23/2021 10:35 PM, Christophe Leroy wrote:
>>
>>
>> Le 23/08/2021 à 12:59, kernel test robot a écrit :
>>> tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93
>>> commit: ef75e73182949a94bde169a774de1b62ae21fbbc powerpc/signal32: Transform save_user_regs() and 
>>> save_tm_user_regs() in 'unsafe' version
>>> date:   9 months ago
>>> config: powerpc-randconfig-c003-20210821 (attached as .config)
>>> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 
>>> d9c5613e856cf2addfbf892fc4c1ce9ef9feceaa)
>>> reproduce (this is a W=1 build):
>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O 
>>> ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          # install powerpc cross compiling tool for clang build
>>>          # apt-get install binutils-powerpc-linux-gnu
>>>          # 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef75e73182949a94bde169a774de1b62ae21fbbc 
>>>
>>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>          git fetch --no-tags linus master
>>>          git checkout ef75e73182949a94bde169a774de1b62ae21fbbc
>>>          # save the attached .config to linux build tree
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc clang-analyzer
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>>
>>> clang-analyzer warnings: (new ones prefixed by >>)
>>>             ^
>>>>> arch/powerpc/kernel/signal_32.c:297:2: warning: Value stored to 'msr' is never read 
>>>>> [clang-analyzer-deadcode.DeadStores]
>>>             msr &= ~MSR_VSX;
>>>             ^      ~~~~~~~~
>>>     arch/powerpc/kernel/signal_32.c:297:2: note: Value stored to 'msr' is never read
>>>             msr &= ~MSR_VSX;
>>>             ^      ~~~~~~~~
>>
>>
>> This is wrong.
>>
>> msr is used at line 326:
>>
>> ef75e73182949a arch/powerpc/kernel/signal_32.c Christophe Leroy 2020-08-18  326 
>> unsafe_put_user(msr, &frame->mc_gregs[PT_MSR], failed);
> 
> Hi Christophe,
> 
> The usage is under CONFIG_VSX, the test config (powerpc-randconfig-c003-20210821) didn't enable it 
> which triggered this warning.


No no, the 'unsafe_put_user(msr, &frame->mc_gregs[PT_MSR], failed) ' at line 326 is not under 
CONFIG_VSX as far as I can see.


Christophe
