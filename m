Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD78F39D467
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 07:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFGFmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 01:42:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:39788 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhFGFl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 01:41:59 -0400
IronPort-SDR: dauNcn8pKuUYeR+uQGB4UodWnCZOlPVl9bNBgd5b/jL2S7jSjeL3AmdEZSz2QxN0gZ8uFt7F93
 UsDGfaEvVtqw==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="184935481"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="184935481"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 22:40:08 -0700
IronPort-SDR: jRd36pt5vFdy2P3pwEOW3+6OukIOoSfDZkH02krN8iAJQbu93/12VkSo5D/xavwHC/ExtjcPxq
 lcsMPjQFtF5g==
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="447365402"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 22:40:07 -0700
Subject: Re: [kbuild-all] Re: net/bpf/test_run.c:154:14: warning: no previous
 prototype for 'bpf_fentry_test7'
To:     Yonghong Song <yhs@fb.com>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
References: <202106041511.4rHRCtw2-lkp@intel.com>
 <b45f82d0-8bc1-7050-a939-4f5791c6981e@fb.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <dffb1503-b9f8-14de-5730-bc6f5b83f42e@intel.com>
Date:   Mon, 7 Jun 2021 13:39:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b45f82d0-8bc1-7050-a939-4f5791c6981e@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/4/21 11:52 PM, Yonghong Song wrote:
>
>
> On 6/4/21 12:50 AM, kernel test robot wrote:
>> Hi Yonghong,
>>
>> FYI, the error/warning still remains.
>>
>> tree: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
>> master
>> head:   f88cd3fb9df228e5ce4e13ec3dbad671ddb2146e
>> commit: d923021c2ce12acb50dc7086a1bf66eed82adf6a bpf: Add tests for 
>> PTR_TO_BTF_ID vs. null comparison
>> date:   11 months ago
>> config: x86_64-rhel (attached as .config)
>> compiler: gcc-6 (Ubuntu 6.4.0-17ubuntu1) 6.4.0 20180424
>> reproduce (this is a W=1 build):
>>          # 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d923021c2ce12acb50dc7086a1bf66eed82adf6a
>>          git remote add linus 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout d923021c2ce12acb50dc7086a1bf66eed82adf6a
>>          # save the attached .config to linux build tree
>>          make W=1 ARCH=x86_64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     net/bpf/test_run.c:120:14: warning: no previous prototype for 
>> 'bpf_fentry_test1' [-Wmissing-prototypes]
>>      int noinline bpf_fentry_test1(int a)
>>                   ^~~~~~~~~~~~~~~~
>>     net/bpf/test_run.c:125:14: warning: no previous prototype for 
>> 'bpf_fentry_test2' [-Wmissing-prototypes]
>>      int noinline bpf_fentry_test2(int a, u64 b)
>>                   ^~~~~~~~~~~~~~~~
>>     net/bpf/test_run.c:130:14: warning: no previous prototype for 
>> 'bpf_fentry_test3' [-Wmissing-prototypes]
>>      int noinline bpf_fentry_test3(char a, int b, u64 c)
>>                   ^~~~~~~~~~~~~~~~
>>     net/bpf/test_run.c:135:14: warning: no previous prototype for 
>> 'bpf_fentry_test4' [-Wmissing-prototypes]
>>      int noinline bpf_fentry_test4(void *a, char b, int c, u64 d)
>>                   ^~~~~~~~~~~~~~~~
>>     net/bpf/test_run.c:140:14: warning: no previous prototype for 
>> 'bpf_fentry_test5' [-Wmissing-prototypes]
>>      int noinline bpf_fentry_test5(u64 a, void *b, short c, int d, 
>> u64 e)
>>                   ^~~~~~~~~~~~~~~~
>>     net/bpf/test_run.c:145:14: warning: no previous prototype for 
>> 'bpf_fentry_test6' [-Wmissing-prototypes]
>>      int noinline bpf_fentry_test6(u64 a, void *b, short c, int d, 
>> void *e, u64 f)
>>                   ^~~~~~~~~~~~~~~~
>>>> net/bpf/test_run.c:154:14: warning: no previous prototype for 
>>>> 'bpf_fentry_test7' [-Wmissing-prototypes]
>>      int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
>>                   ^~~~~~~~~~~~~~~~
>>>> net/bpf/test_run.c:159:14: warning: no previous prototype for 
>>>> 'bpf_fentry_test8' [-Wmissing-prototypes]
>>      int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
>>                   ^~~~~~~~~~~~~~~~
>>     net/bpf/test_run.c:164:14: warning: no previous prototype for 
>> 'bpf_modify_return_test' [-Wmissing-prototypes]
>>      int noinline bpf_modify_return_test(int a, int *b)
>>                   ^~~~~~~~~~~~~~~~~~~~~~
>
> I think this has been discussed earlier.
>
> In net/bpf/test_run.c, we have,
>
> __diag_push();
> __diag_ignore(GCC, 8, "-Wmissing-prototypes",
>               "Global functions as their definitions will be in 
> vmlinux BTF");
> int noinline bpf_fentry_test1(int a)
> {
>         return a + 1;
> }
> ...
>
> Unfortunately, the __diag_ignore macro only effective for gcc8 and later.
>
> So for gcc6, the above warning will be emitted. Is it possible for the 
> tool to check and ignore this error if the gcc version is less than 8?
>

Hi Yonghong,

Thanks for the advice, we'll ignore this error later.

Best Regards,
Rong Chen
