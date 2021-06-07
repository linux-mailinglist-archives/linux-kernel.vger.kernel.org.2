Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A39F39D477
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 07:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFGFvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 01:51:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:53857 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhFGFvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 01:51:48 -0400
IronPort-SDR: irHnXsaUUTEKTA3MnukcCLFw1CiuQmrmOq3YkdNg1VoCM8ArcwhokpBGOVb26NcAueQGX9c4Bl
 w6rALgEnhBLg==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="265721044"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="265721044"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 22:49:57 -0700
IronPort-SDR: lQ00SA89qr/8ioWr0e4vWpuL3dWyO9LlAFM76uMxweheumsRiJLqJmCJzZAmgnuSFBvNgztGTb
 Jn9evhL2u6Zg==
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="447367664"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 22:49:56 -0700
Subject: Re: [kbuild-all] Re: kernel/trace/trace.c:3634:2: warning: function
 might be possible candidate for 'gnu_printf' format attribute
To:     Steven Rostedt <rostedt@goodmis.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202106041958.XB0yCLBn-lkp@intel.com>
 <20210604164838.2da06df3@oasis.local.home>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <5a50cb60-f184-0d6e-723b-5bad4b5fd14a@intel.com>
Date:   Mon, 7 Jun 2021 13:49:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210604164838.2da06df3@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/21 4:48 AM, Steven Rostedt wrote:
> On Fri, 4 Jun 2021 19:12:03 +0800
> kernel test robot <lkp@intel.com> wrote:
>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   f88cd3fb9df228e5ce4e13ec3dbad671ddb2146e
>> commit: 9a6944fee68e25084130386c608c5ac8db487581 tracing: Add a verifier to check string pointers for trace events
>> date:   3 months ago
>> config: x86_64-rhel (attached as .config)
>> compiler: gcc-6 (Ubuntu 6.4.0-17ubuntu1) 6.4.0 20180424
>> reproduce (this is a W=1 build):
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a6944fee68e25084130386c608c5ac8db487581
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 9a6944fee68e25084130386c608c5ac8db487581
>>          # save the attached .config to linux build tree
>>          make W=1 ARCH=x86_64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     kernel/trace/trace.c: In function 'test_can_verify_check':
>>>> kernel/trace/trace.c:3634:2: warning: function might be possible candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>>       vsnprintf(buf, 16, "%d", ap);
>>       ^~~~~~~~~
> "test_can_verify_check" is not a generic function that needs a printf
> format check. This is a bogus warning. Please remove it as being an issue.
>
> -- Steve
>

Hi Steve,

Thanks for the feedback, we'll ignore the commit to avoid new reports 
for this warning.

Best Regards,
Rong Chen

>
>>     kernel/trace/trace.c: In function 'trace_check_vprintf':
>>     kernel/trace/trace.c:3717:3: warning: function might be possible candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>>        trace_seq_vprintf(&iter->seq, iter->fmt, ap);
>>        ^~~~~~~~~~~~~~~~~
>>     kernel/trace/trace.c:3756:3: warning: function might be possible candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>>        trace_seq_vprintf(&iter->seq, p, ap);
>>        ^~~~~~~~~~~~~~~~~
>>
>>
>> vim +/gnu_printf +3634 kernel/trace/trace.c
>>
>>    3617	
>>    3618	static int test_can_verify_check(const char *fmt, ...)
>>    3619	{
>>    3620		char buf[16];
>>    3621		va_list ap;
>>    3622		int ret;
>>    3623	
>>    3624		/*
>>    3625		 * The verifier is dependent on vsnprintf() modifies the va_list
>>    3626		 * passed to it, where it is sent as a reference. Some architectures
>>    3627		 * (like x86_32) passes it by value, which means that vsnprintf()
>>    3628		 * does not modify the va_list passed to it, and the verifier
>>    3629		 * would then need to be able to understand all the values that
>>    3630		 * vsnprintf can use. If it is passed by value, then the verifier
>>    3631		 * is disabled.
>>    3632		 */
>>    3633		va_start(ap, fmt);
>>> 3634		vsnprintf(buf, 16, "%d", ap);
>>    3635		ret = va_arg(ap, int);
>>    3636		va_end(ap);
>>    3637	
>>    3638		return ret;
>>    3639	}
>>    3640	
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

