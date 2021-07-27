Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41C63D71A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbhG0JB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:01:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:23631 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235923AbhG0JB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:01:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="199628090"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="199628090"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 02:01:24 -0700
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="516768644"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.29.203]) ([10.255.29.203])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 02:01:22 -0700
Subject: Re: [kbuild-all] Re: lib/test_scanf.c:531:1: warning: the frame size
 of 2080 bytes is larger than 2048 bytes
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        - <patches@opensource.cirrus.com>
References: <202107131602.8qHTzV8q-lkp@intel.com>
 <870e7908-113c-0eed-264e-8a9832202bfe@opensource.cirrus.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <48beec0a-a2ff-2905-fe5d-047fb744b2b4@intel.com>
Date:   Tue, 27 Jul 2021 17:01:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <870e7908-113c-0eed-264e-8a9832202bfe@opensource.cirrus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2021 12:15 AM, Richard Fitzgerald wrote:
> On 13/07/2021 09:21, kernel test robot wrote:
>> All warnings (new ones prefixed by >>):
>>
>>     lib/test_scanf.c: In function 'numbers_list_field_width_val_width':
>>>> lib/test_scanf.c:531:1: warning: the frame size of 2080 bytes is 
>>>> larger than 2048 bytes [-Wframe-larger-than=]
>>       531 | }
>>           | ^
>>     lib/test_scanf.c: In function 'numbers_list_field_width_typemax':
>>     lib/test_scanf.c:489:1: warning: the frame size of 2552 bytes is 
>> larger than 2048 bytes [-Wframe-larger-than=]
>>       489 | }
>>           | ^
>>     lib/test_scanf.c: In function 'numbers_list':
>>     lib/test_scanf.c:438:1: warning: the frame size of 2080 bytes is 
>> larger than 2048 bytes [-Wframe-larger-than=]
>>       438 | }
>>           | ^
>>
> 
> I haven't been able to reproduce this. I've tried these compilers:
> 
> Linaro AArch32 GCC 10.2.1 20201103(-O2 or -Os optimization): stack 
> frames < 200 bytes
> 
> Linaro ARM32 7.5-2019.12 -Os: maximum of 384 bytes
> 
> Debian 6.3.0-18+deb9u1, x86_64 -O2: frames < 200 bytes

Hi Richard,

I installed gcc-10-arm-linux-gnueabi on Debian and can't reproduce the 
warning too.

> 
> (The GCC fetched with the reproduction instructions from the krobot
> report doesn't work on my Debian system.)

I have confirmed that the gcc compiler used by the bot can reproduce the 
warning, which problem on your Debian system? we can improve the 
reproduce tool if there's more information.

Best Regards,
Rong Chen

> 
> The sizes reported by the krobot are the total of all stack variable in
> the function, but they all have limited scope. Obviously my GCC versions
> are optimizing by effectively making a union of stack variable that are
> used in different scope. So presumably the GCC version used by krobot is
> missing this optimization. That feels to me more like a compiler bug if
> it is allocating 12 times more stack than is actually necessary for the
> function.
> 
> Output from my 10.2.1 compiler (-O2):
> 
> lib/test_scanf.c: In function 'numbers_list_field_width_val_width':
> lib/test_scanf.c:530:1: warning: the frame size of 176 bytes is larger 
> than 128 bytes [-Wframe-larger-than=]
>    530 | }
>        | ^
> lib/test_scanf.c: In function 'numbers_list_field_width_typemax':
> lib/test_scanf.c:488:1: warning: the frame size of 184 bytes is larger 
> than 128 bytes [-Wframe-larger-than=]
>    488 | }
>        | ^
> lib/test_scanf.c: In function 'numbers_list':
> lib/test_scanf.c:437:1: warning: the frame size of 168 bytes is larger 
> than 128 bytes [-Wframe-larger-than=]
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
