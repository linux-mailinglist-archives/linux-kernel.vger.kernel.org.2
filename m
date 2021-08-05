Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467F13E1C97
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhHETZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhHETZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:25:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59036C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 12:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=rrLmuxgXV+8M0AVHq3xn5uFJNy/UFq1cbVRewb2LU0E=; b=bui2tZ2wcMKdPyoIDcheJQZ/ib
        kUnzX2Qm9zW56+u0rVa978ELH0oYuA1AMDg5MYRwtGHDK+UWzrElu0Y/LHqFy5TPPNpOrPyv3toQ7
        SyPNk0aYtRHU+8yKd2i+jcmvOelVDYt/0YKnqxjlhCxfEeZJS3s8zMDHaAV9D6ecs9rKNXFoMM+4n
        gXSyGL5wNs/KwJMpJ9QcWSJpZapO/r9ka3C1QI47vjqIlcpbbOk2qaXg5t0+Tjf7LJBfOu+pnXfsU
        St7jr1JJzvZ7GxDAdyU9SBJ//gEX1FC/8vWXAb4BliRXwCWGNF3hUYv5d2pApi+PG04ldkWKnXR2C
        B10eOEoA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBizK-0069bi-ML; Thu, 05 Aug 2021 19:25:08 +0000
Subject: Re: [kbuild-all] Re: make[2]: *** [arch/powerpc/Makefile.postlink:31:
 vmlinux] Error 1
To:     "Chen, Rong A" <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        Feng Tang <feng.tang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202107301612.rQ29n76B-lkp@intel.com>
 <c3e9247d-95cd-718c-d8a5-f0cd5e5a3598@infradead.org>
 <176ab0a5-72dd-dc24-be64-6919cffba9ed@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f0aa87df-89e2-05b0-52a0-c12236a1d778@infradead.org>
Date:   Thu, 5 Aug 2021 12:25:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <176ab0a5-72dd-dc24-be64-6919cffba9ed@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/21 3:28 AM, Chen, Rong A wrote:
> 
> 
> On 8/4/2021 11:10 AM, Randy Dunlap wrote:
>> On 7/30/21 1:29 AM, kernel test robot wrote:
>>> tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   764a5bc89b12b82c18ce7ca5d7c1b10dd748a440
>>> commit: cf536e185869d4815d506e777bcca6edd9966a6e Makefile: extend 32B aligned debug option to 64B aligned
>>> date:   10 weeks ago
>>> config: powerpc64-randconfig-c023-20210730 (attached as .config)
>>> compiler: powerpc-linux-gcc (GCC) 10.3.0
>>> reproduce (this is a W=1 build):
>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cf536e185869d4815d506e777bcca6edd9966a6e
>>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>          git fetch --no-tags linus master
>>>          git checkout cf536e185869d4815d506e777bcca6edd9966a6e
>>>          # save the attached .config to linux build tree
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=powerpc64
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>>> make[2]: *** [arch/powerpc/Makefile.postlink:31: vmlinux] Error 1
>>>
>>> ---
>>
>> Hi ktr/lkp,
>>
>> This is not "All errors". I suggest that you improve your output by
>> (also) grepping for "ERROR:", so that the following lines would be
>> included here:
>>
>> ERROR: start_text address is c000000000000200, should be c000000000000100
>> ERROR: try to enable LD_HEAD_STUB_CATCH config option
>> ERROR: see comments in arch/powerpc/tools/head_check.sh
> 
> Hi Randy,
> 
> Thanks for the advice, the "ERROR:" lines weren't redirected to stderr, so the bot didn't notice them, it looks difficult to change the output.

Hi Rong,

So 0day bot only checks stderr for errors?
That is almost reasonable (IMO).

Michael, in the file arch/powerpc/tools/head_check.sh,
what do you think about redirecting all of the ERROR: lines
to stdout (echo "..." >&2)?


> Best Regards,
> Rong Chen
> 
>>
>>
>> and yes, enabling LD_HEAD_STUB_CATCH does fix this build error.



>> thanks.

-- 
~Randy

