Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429CE3D87AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhG1GJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:09:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:36264 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231199AbhG1GJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:09:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="192866704"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="192866704"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 23:09:06 -0700
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="517290472"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.30.133]) ([10.255.30.133])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 23:09:04 -0700
Subject: Re: [kbuild-all] Re: gup_test.c:1:10: fatal error: fcntl.h: No such
 file or directory
To:     John Hubbard <jhubbard@nvidia.com>,
        kernel test robot <lkp@intel.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202107281223.L61SLDL2-lkp@intel.com>
 <6af32770-1825-ff9a-ccf2-46600ed6fc7e@nvidia.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <04756a7d-3c08-affa-2e14-13b801d543a7@intel.com>
Date:   Wed, 28 Jul 2021 14:09:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <6af32770-1825-ff9a-ccf2-46600ed6fc7e@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 7/28/2021 1:24 PM, John Hubbard wrote:
> On 7/27/21 9:59 PM, kernel test robot wrote:
>> tree:   
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   7d549995d4e0d99b68e8a7793a0d23da6fc40fe8
>> commit: 9c84f229268fa229e250b7225611d0eb7094fea0 mm/gup_benchmark: 
>> rename to mm/gup_test
>> date:   7 months ago
>> config: openrisc-randconfig-s031-20210726 (attached as .config)
>> compiler: or1k-linux-gcc (GCC) 10.3.0
>> reproduce:
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.3-341-g8af24329-dirty
>>          # 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9c84f229268fa229e250b7225611d0eb7094fea0 
>>
>>          git remote add linus 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 9c84f229268fa229e250b7225611d0eb7094fea0
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 
>> make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir 
>> ARCH=openrisc SHELL=/bin/bash -C tools/testing/selftests/vm install
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> gup_test.c:1:10: fatal error: fcntl.h: No such file or directory
>>         1 | #include <fcntl.h>
>>           |          ^~~~~~~~~
>>     compilation terminated.
>>
> 
> I reproduced this via the above steps, and noticed that there are missing
> header files for most (all?) of the vm tests, not just gup_test.c. And
> not just fcntl.h, either. The error list continue as follows (below).
> 
> This seems like a new toolchain issue, right?
> 

Yes, Sorry about this, it seems to be related to our changes recently, 
please ignore it.

Best Regards,
Rong Chen


> 
> gup_test.c:1:10: fatal error: fcntl.h: No such file or directory
> 1 | #include <fcntl.h>
> |          ^~~~~~~~~
> compilation terminated.
> compaction_test.c:10:10: fatal error: stdio.h: No such file or directory
> 10 | #include <stdio.h>
> |          ^~~~~~~~~
> In file included from hmm-tests.c:13:
> ../kselftest_harness.h:56:10: fatal error: asm/types.h: No such file or 
> directory
> 56 | #include <asm/types.h>
> |          ^~~~~~~~~~~~~
> hugepage-shm.c:31:10: fatal error: stdlib.h: No such file or directory
> 31 | #include <stdlib.h>
> |          ^~~~~~~~~~
> make: *** [../lib.mk:139: 
> /kernel_work/linux-github/tools/testing/selftests/vm/gup_test] Error 1
> compilation terminated.
> compilation terminated.
> compilation terminated.
> hugepage-mmap.c:20:10: fatal error: stdlib.h: No such file or directory
> 20 | #include <stdlib.h>
> |          ^~~~~~~~~~
> map_hugetlb.c:13:10: fatal error: stdlib.h: No such file or directory
> 13 | #include <stdlib.h>
> |          ^~~~~~~~~~
> compilation terminated.
> compilation terminated.
> on-fault-limit.c:2:10: fatal error: sys/mman.h: No such file or directory
> 2 | #include <sys/mman.h>
> |          ^~~~~~~~~~~~
> transhuge-stress.c:9:10: fatal error: stdlib.h: No such file or directory
> 9 | #include <stdlib.h>
> |          ^~~~~~~~~~
> map_fixed_noreplace.c:10:10: fatal error: sys/mman.h: No such file or 
> directory
> 10 | #include <sys/mman.h>
> |          ^~~~~~~~~~~~
> mlock2-tests.c:3:10: fatal error: sys/mman.h: No such file or directory
> 3 | #include <sys/mman.h>
> |          ^~~~~~~~~~~~
> compilation terminated.
> compilation terminated.
> compilation terminated.
> compilation terminated.
> mremap_dontunmap.c:9:10: fatal error: sys/mman.h: No such file or directory
> 9 | #include <sys/mman.h>
> |          ^~~~~~~~~~~~
> compilation terminated.
> va_128TBswitch.c:8:10: fatal error: stdio.h: No such file or directory
> 8 | #include <stdio.h>
> |          ^~~~~~~~~
> compilation terminated.
> make: *** [../lib.mk:139: 
> /kernel_work/linux-github/tools/testing/selftests/vm/hmm-tests] Error 1
> make: *** [../lib.mk:139: 
> /kernel_work/linux-github/tools/testing/selftests/vm/hugepage-shm] Error 1
> map_populate.c:9:10: fatal error: errno.h: No such file or directory
> 9 | #include <errno.h>
> |          ^~~~~~~~~
> compilation terminated.
> make: *** [../lib.mk:139: 
> /kernel_work/linux-github/tools/testing/selftests/vm/compaction_test] 
> Error 1
> make: *** [../lib.mk:139: 
> /kernel_work/linux-github/tools/testing/selftests/vm/hugepage-mmap] Error 1
> mlock-random-test.c:6:10: fatal error: unistd.h: No such file or directory
> 6 | #include <unistd.h>
> |          ^~~~~~~~~~
> compilation terminated.
> make: *** [../lib.mk:139: 
> /kernel_work/linux-github/tools/testing/selftests/vm/map_hugetlb] Error 1
> khugepaged.c:2:10: fatal error: fcntl.h: No such file or directory
> 2 | #include <fcntl.h>
> |          ^~~~~~~~~
> compilation terminated.
> make: *** [../lib.mk:139: 
> /kernel_work/linux-github/tools/testing/selftests/vm/on-fault-limit] 
> Error 1
> make: *** [../lib.mk:139: 
> /kernel_work/linux-github/tools/testing/selftests/vm/mlock2-tests] Error 1
> make: *** [../lib.mk:139: 
> /kernel_work/linux-github/tools/testing/selftests/vm/transhuge-stress] 
> Error 1
> make: *** [../lib.mk:139: 
> /kernel_work/linux-github/tools/testing/selftests/vm/map_fixed_noreplace] Error 
> 1
> make: *** [../lib.mk:139: 
> /kernel_work/linux-github/tools/testing/selftests/vm/mremap_dontunmap] 
> Error 1
> make: *** [../lib.mk:139: 
> /kernel_work/linux-github/tools/testing/selftests/vm/va_128TBswitch] 
> Error 1
> make: *** [../lib.mk:139: 
> /kernel_work/linux-github/tools/testing/selftests/vm/map_populate] Error 1
> thuge-gen.c:16:10: fatal error: sys/mman.h: No such file or directory
> 16 | #include <sys/mman.h>
> |          ^~~~~~~~~~~~
> compilation terminated.
> make: *** [../lib.mk:139: 
> /kernel_work/linux-github/tools/testing/selftests/vm/khugepaged] Error 1
> make: *** [../lib.mk:139: 
> /kernel_work/linux-github/tools/testing/selftests/vm/mlock-random-test] 
> Error 1
> userfaultfd.c:38:10: fatal error: stdio.h: No such file or directory
> 38 | #include <stdio.h>
> |          ^~~~~~~~~
> compilation terminated.
> write_to_hugetlbfs.c:7:10: fatal error: err.h: No such file or directory
> 7 | #include <err.h>
> |          ^~~~~~~
> compilation terminated.
> virtual_address_range.c:8:10: fatal error: stdio.h: No such file or 
> directory
> 8 | #include <stdio.h>
> |          ^~~~~~~~~
> compilation terminated.
> 
> 
> thanks,
