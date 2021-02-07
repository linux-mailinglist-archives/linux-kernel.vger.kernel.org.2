Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15C631226B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 09:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBGIQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 03:16:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:25046 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhBGIQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 03:16:27 -0500
IronPort-SDR: Z4qbDmP5hJcQ7BU0IzZ4xDvdLt99x7ObWZkjHOJvs0d3VWO+6vlBg/jUyE8AP9Gt/nS5JqyuAV
 8+NulsWoM0RQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9887"; a="243092473"
X-IronPort-AV: E=Sophos;i="5.81,159,1610438400"; 
   d="scan'208";a="243092473"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 00:15:45 -0800
IronPort-SDR: TpOQotO5iyFYzPANoQoElu1jDFPVllvHetjE2R+ettg940cQiB10qFE7h+iwkHf8ASAGH2Fiuw
 ZuUyFtSpBNZg==
X-IronPort-AV: E=Sophos;i="5.81,159,1610438400"; 
   d="scan'208";a="394636266"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2021 00:15:42 -0800
Subject: Re: [kbuild-all] Re: [patch 06/12] x86/entry: Convert system vectors
 to irq stack macro
To:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org,
        x86@kernel.org, Kees Cook <keescook@chromium.org>
References: <20210204211154.713523041@linutronix.de>
 <202102051148.WIj5O4Ry-lkp@intel.com>
 <YB1SdvRbHMY7IRrY@hirez.programming.kicks-ass.net>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <ad03c046-3249-8ac2-96af-03b2312454c0@intel.com>
Date:   Sun, 7 Feb 2021 16:15:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <YB1SdvRbHMY7IRrY@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/21 10:13 PM, Peter Zijlstra wrote:
> On Fri, Feb 05, 2021 at 11:52:40AM +0800, kernel test robot wrote:
>> Hi Thomas,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on tip/x86/asm]
>> [also build test WARNING on tip/master linus/master tip/x86/core v5.11-rc6 next-20210125]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Thomas-Gleixner/x86-irq-64-Inline-irq-stack-switching/20210205-091059
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 5c99720b28381bb400d4f546734c34ddaf608761
>> config: x86_64-randconfig-r026-20210204 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>> reproduce (this is a W=1 build):
>>          # https://github.com/0day-ci/linux/commit/d91ff58e804175dd59e483c7cf236e1fe66c2187
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review Thomas-Gleixner/x86-irq-64-Inline-irq-stack-switching/20210205-091059
>>          git checkout d91ff58e804175dd59e483c7cf236e1fe66c2187
>>          # save the attached .config to linux build tree
>>          make W=1 ARCH=x86_64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> arch/x86/hyperv/hv_init.o: warning: objtool: sysvec_hyperv_reenlightenment()+0x7f: undefined stack state
>> --
>>>> arch/x86/kernel/cpu/mshyperv.o: warning: objtool: sysvec_hyperv_callback()+0x7f: undefined stack state
>>>> arch/x86/kernel/cpu/mshyperv.o: warning: objtool: sysvec_hyperv_stimer0()+0x7f: undefined stack state
> It would help if you'd actually applied the patches to a tree that had
> the required objtool patches as described in 0/n. Or better yet, don't
> scrape emails if the 0/n includes a git link which you'll run on anyway.

Hi Peter,

Thanks for the advice, we'll add the check to our cluster,
and sorry for the inconvenience.

Best Regards,
Rong Chen

