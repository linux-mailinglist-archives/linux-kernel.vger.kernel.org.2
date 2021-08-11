Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC49C3E88D9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 05:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbhHKDh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 23:37:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:52103 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232994AbhHKDhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 23:37:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="300632755"
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="300632755"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 20:36:55 -0700
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="516288737"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.175.89]) ([10.249.175.89])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 20:36:53 -0700
Subject: Re: [kbuild-all] Re: [linux-stable-rc:linux-5.10.y 4948/4972]
 tools/testing/selftests/bpf/prog_tests/core_reloc.c:860: undefined reference
 to `ASSERT_FALSE'
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, kbuild-all@lists.01.org,
        open list <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
References: <202108101908.Xq5QKkNW-lkp@intel.com>
 <CAEf4BzaxSUF31qjjZx1+7OLomxyx3mAaqNY71GAV-TQMoGnOCQ@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <382a3ccc-4c98-2c8c-e750-1188ad9cb562@intel.com>
Date:   Wed, 11 Aug 2021 11:36:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaxSUF31qjjZx1+7OLomxyx3mAaqNY71GAV-TQMoGnOCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2021 11:11 PM, Andrii Nakryiko wrote:
> On Tue, Aug 10, 2021 at 4:25 AM kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
>> head:   e97bd1e03e6ef58ec47ee7f085f8c14ed6329cf7
>> commit: 183d9ebd449c20658a1aaf580f311140bbc7421d [4948/4972] selftests/bpf: Fix core_reloc test runner
>> config: x86_64-rhel-8.3-kselftests (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>> reproduce:
>>          # apt-get install sparse
>>          # sparse version: v0.6.3-348-gf0e6938b-dirty
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=183d9ebd449c20658a1aaf580f311140bbc7421d
>>          git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>>          git fetch --no-tags linux-stable-rc linux-5.10.y
>>          git checkout 183d9ebd449c20658a1aaf580f311140bbc7421d
>>          # save the attached .config to linux build tree
>>          make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash -C tools/testing/selftests/bpf install
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     /usr/bin/ld: tools/testing/selftests/bpf/core_reloc.test.o: in function `test_core_reloc':
>>>> tools/testing/selftests/bpf/prog_tests/core_reloc.c:860: undefined reference to `ASSERT_FALSE'
>>     collect2: error: ld returned 1 exit status
>> --
>>     /usr/bin/ld: tools/testing/selftests/bpf/no_alu32/core_reloc.test.o: in function `test_core_reloc':
>>>> tools/testing/selftests/bpf/prog_tests/core_reloc.c:860: undefined reference to `ASSERT_FALSE'
>>     collect2: error: ld returned 1 exit status
>>
> 
> ASSERT_FALSE() macro is defined in test_progs.h, which is included
> from core_reloc.c. There must be something wrong about how kernel test
> robot is building selftests/bpf.

Hi Andrii,

The issue was found in a stable branch, and commit 7a2fa70aaffc 
(selftests/bpf: Add remaining ASSERT_xxx() variants) seems not in the 
branch, There are some conflicts that I failed to cherry-pick it to the 
head to test.

Best Regards,
Rong Chen

> 
>>
>> vim +860 tools/testing/selftests/bpf/prog_tests/core_reloc.c
>>
>>     765
>>     766  void test_core_reloc(void)
>>     767  {
>>     768          const size_t mmap_sz = roundup_page(sizeof(struct data));
>>     769          struct bpf_object_load_attr load_attr = {};
>>     770          struct core_reloc_test_case *test_case;
>>     771          const char *tp_name, *probe_name;
>>     772          int err, i, equal;
>>     773          struct bpf_link *link = NULL;
>>     774          struct bpf_map *data_map;
>>     775          struct bpf_program *prog;
>>     776          struct bpf_object *obj;
>>     777          uint64_t my_pid_tgid;
>>     778          struct data *data;
>>     779          void *mmap_data = NULL;
>>     780
> 
> [...]
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
