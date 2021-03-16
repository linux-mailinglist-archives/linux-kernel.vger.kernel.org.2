Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9AC33D154
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbhCPKCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:02:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:54685 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236475AbhCPKC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:02:28 -0400
IronPort-SDR: 7HT+pGm9M8RZrXZxvjCqmXJ5XVBkFc39QGysb8IyZsIjJtmMACVEAk1tit0iyd+eFUeHGYCKkf
 mVUtVmNQxb2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="274275274"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="274275274"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 03:02:24 -0700
IronPort-SDR: hRJ72N6PQ6S8MCDELM3s6dxylw+oTpGiKH7tdX+AR61tfZfU5+pjUH1OTC+cDrheWp8qrGdXhr
 zRvUz4bPNdvQ==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="388414559"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 03:02:22 -0700
Subject: Re: [kbuild-all] Re: [tip:x86/cpu 2/3]
 arch/x86/kernel/alternative.c:96:10: warning: Undefined behaviour, pointer
 arithmetic 'x86nops+10' is out of bounds.
To:     Borislav Petkov <bp@alien8.de>, kernel test robot <lkp@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <202103160701.3uXlWiWM-lkp@intel.com>
 <20210316082703.GA18003@zn.tnic>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <a7522586-6496-1b09-6d98-0682f0a60dce@intel.com>
Date:   Tue, 16 Mar 2021 18:01:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210316082703.GA18003@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/21 4:27 PM, Borislav Petkov wrote:
> Yet another useless report!
>
> On Tue, Mar 16, 2021 at 07:50:10AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
>> head:   301cddc21a157a3072d789a3097857202e550a24
>> commit: a89dfde3dc3c2dbf56910af75e2d8b11ec5308f6 [2/3] x86: Remove dynamic NOP selection
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> cppcheck possible warnings: (new ones prefixed by >>, may not real problems)
> What's cppcheck?
>
> That?
>
> Description-en: tool for static C/C++ code analysis (CLI)
>   Cppcheck is a command-line tool that tries to detect bugs that your
>
>
>>>> arch/x86/kernel/alternative.c:96:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+10' is out of bounds. [pointerOutOfBounds]
>>      x86nops + 1 + 2 + 3 + 4,
>>              ^
>>     arch/x86/kernel/alternative.c:97:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+15' is out of bounds. [pointerOutOfBounds]
>>      x86nops + 1 + 2 + 3 + 4 + 5,
>>              ^
>>     arch/x86/kernel/alternative.c:98:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+21' is out of bounds. [pointerOutOfBounds]
>>      x86nops + 1 + 2 + 3 + 4 + 5 + 6,
>>              ^
>>     arch/x86/kernel/alternative.c:99:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+28' is out of bounds. [pointerOutOfBounds]
>>      x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
>>              ^
>>>> arch/x86/kernel/ftrace.c:304:7: warning: union member 'ftrace_op_code_union::code' is never used. [unusedStructMember]
>>      char code[OP_REF_SIZE];
>>           ^
> How do you trigger this?
>
> /me ignores it until there's some info on how those things can be
> reproduced.
>

Hi Borislav,

Sorry for the inconvenience, there's a bug in our system which sent 
internal reports to outside.
please ignore the warnings.

Best Regards,
Rong Chen
